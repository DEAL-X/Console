// CLR collection interoperability smoke test.
// Run after the host exposes ExtendedHostFunctions as "host" and loads deal/make.
// Checks EnableArrayConversion semantics and the script-friendly .NET overloads.

function clrObjectInteropSmokeTest(application) {
    const resource = application.Engine.Resource;
    const values = ["first", "second", "third"];
    const path = resource.Combine(["Temporary", "clr-object-interop-smoke.txt"]);
    const binaryPath = resource.Combine(["Temporary", "clr-object-interop-bytes-smoke.bin"]);
    const textPath = resource.Combine(["Temporary", "clr-object-interop-encoding-smoke.txt"]);
    const folderPath = resource.Combine(["Temporary", "clr-object-interop-folder"]);

    const clrArray = Make.arrayObject(values, "System.String");
    if (!Array.isArray(clrArray) || clrArray.length !== 3 || clrArray[1] !== "second")
        throw new Error("Make.arrayObject must return a JavaScript array with mapped values.");

    const clrStrings = Make.stringArrayObject(values);
    if (!Array.isArray(clrStrings) || clrStrings[0] !== "first")
        throw new Error("Make.stringArrayObject must return a JavaScript array.");

    const clrBytes = Make.byteArrayObject([65, 66, 67]);
    if (!Array.isArray(clrBytes) || clrBytes.length !== 3 || Number(clrBytes[2]) !== 67)
        throw new Error("Make.byteArrayObject must return a JavaScript byte array.");

    const clrList = Make.listObject(values, "System.String");
    if (clrList.Count !== 3 || clrList[1] !== "second")
        throw new Error("Make.listObject did not create a usable List<string>.");

    const clrEnumerable = Make.iteratorObject(values, "System.String");
    if (clrEnumerable.Count !== 3 || clrEnumerable[2] !== "third")
        throw new Error("Make.iteratorObject must return a usable List<string> implementing IEnumerable<string>.");

    const dictionary = Make.dictionaryObject(
        { one: 1, two: 2 },
        "System.String",
        "System.Int32"
    );
    if (!dictionary.ContainsKey("one") || !dictionary.ContainsKey("two") || dictionary.Count !== 2)
        throw new Error("Make.dictionaryObject did not preserve typed key/value pairs.");

    const intType = Make.typeObject("System.Int32");
    if (Number(Make.convertObject("42", intType)) !== 42)
        throw new Error("Make.convertObject did not convert through System.Convert.ChangeType.");

    const dynamicRecord = Make.objectObject({ name: "DEAL.JS", revision: 1 });
    if (dynamicRecord.name !== "DEAL.JS" || dynamicRecord.revision !== 1)
        throw new Error("Make.objectObject did not create a populated ExpandoObject.");

    const hashSet = Make.hashSetObject(values, "System.String");
    if (hashSet.Count !== 3)
        throw new Error("Make.hashSetObject returned an unexpected item count.");

    // Exercise generic type definitions resolved through the host type collection.
    const queue = Make.queueObject(values, "System.String");
    const stack = Make.stackObject(values, "System.String");
    const linkedList = Make.linkedListObject(values, "System.String");
    const sortedSet = Make.sortedSetObject(values, "System.String");
    const arrayList = Make.arrayListObject(values);
    const hashTable = Make.hashTableObject({ first: 1, second: 2 });
    if (queue.Count !== 3 || stack.Count !== 3 || linkedList.Count !== 3 || sortedSet.Count !== 3)
        throw new Error("A generic queue, stack, linked list, or sorted set converter failed.");
    if (arrayList.Count !== 3 || hashTable.Count !== 2)
        throw new Error("A non-generic collection converter failed.");

    try {
        // JavaScript arrays are marshalled as object[] and converted in the host.
        resource.SetFileLines(path, clrArray, "utf-8");
        resource.PrependFileLines(path, ["zero"], "utf-8");
        resource.AppendFileLines(path, ["last"], "utf-8");
        if (resource.GetFileLine(path, 0, null) !== "zero" || resource.GetFileLine(path, 4, null) !== "last")
            throw new Error("The object[] Set/Prepend/AppendFileLines overloads failed.");

        // The same object[] overload accepts the byte array without a CLR byte[] in script.
        resource.SetFileContents(binaryPath, clrBytes);
        const storedBytes = resource.GetFileContents(binaryPath);
        if (!Array.isArray(storedBytes) || Number(storedBytes[0]) !== 65 || Number(storedBytes[2]) !== 67)
            throw new Error("The object-based SetFileContents byte conversion failed.");

        // Encoding-name overloads accept script strings as well as Encoding host objects.
        resource.SetFileText(textPath, "payload", "utf-8");
        resource.PrependFileText(textPath, "before", "utf-8");
        resource.AppendFileText(textPath, "after", "utf-8");
        if (resource.GetFileText(textPath, "utf-8") !== "beforepayloadafter")
            throw new Error("The text encoding overloads failed.");
        if (resource.GetFileText(textPath, undefined) !== "beforepayloadafter")
            throw new Error("Undefined encoding values must use the default encoding.");
        const linesEnumerator = resource.GetFileLines(textPath, "utf-8").GetEnumerator();
        linesEnumerator.Dispose();
        const contentsEnumerator = resource.GetContents(textPath, false, "utf-8").GetEnumerator();
        contentsEnumerator.Dispose();
        const defaultLinesEnumerator = resource.GetFileLines(textPath, undefined).GetEnumerator();
        defaultLinesEnumerator.Dispose();
        resource.SetFileLine(textPath, 0, "changed", "utf-8");
        resource.PrependFileLine(textPath, "first", "utf-8");
        resource.AppendFileLine(textPath, "last", "utf-8");
        if (resource.GetFileLine(textPath, 0, "utf-8") !== "first")
            throw new Error("The encoding-aware single-line overloads failed.");

        // Actual CLR generic collections continue to bind through IEnumerable<string>.
        resource.SetFileLines(path, clrList, null);
        resource.SetFileLines(path, clrEnumerable, null);
        if (resource.GetFileLine(path, 0, null) !== "first" || resource.GetFileLine(path, 2, null) !== "third")
            throw new Error("The IEnumerable<string> ResourceProvider overload failed.");

        resource.CreateDirectory(folderPath);
        resource.SetFolderContents(folderPath, []);

        return {
            passed: true,
            arrayRepresentation: "JavaScript Array",
            byteRepresentation: "JavaScript Array",
            listType: "System.Collections.Generic.List<System.String>",
            dictionaryCount: dictionary.Count,
            dynamicObjectType: "System.Dynamic.ExpandoObject",
            hashSetCount: hashSet.Count,
            queueCount: queue.Count,
            stackCount: stack.Count,
            linkedListCount: linkedList.Count,
            sortedSetCount: sortedSet.Count,
            arrayListCount: arrayList.Count,
            hashTableCount: hashTable.Count,
            lineCount: 3
        };
    } finally {
        resource.Delete(path);
        resource.Delete(binaryPath);
        resource.Delete(textPath);
        resource.Delete(folderPath);
    }
}
