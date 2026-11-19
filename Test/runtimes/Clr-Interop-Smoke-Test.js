// Runtime smoke test for DEAL JavaScript-to-.NET collection conversion.
// JavaScript arrays remain JavaScript arrays with EnableArrayConversion enabled.

(function () {
    function assert(condition, message) {
        if (!condition) throw new Error("CLR interop smoke test failed: " + message);
    }

    const stringArray = Make.arrayObject(["alpha", "beta"], "System.String");
    assert(Array.isArray(stringArray), "arrayObject must preserve JavaScript Array semantics");
    assert(stringArray.length === 2 && stringArray[1] === "beta", "string array contents");

    const integerList = Make.listObject([3, 5, 8], "System.Int32");
    assert(integerList.Count === 3 && Number(integerList[2]) === 8, "List<Int32> contents");

    const stringEnumerable = Make.iteratorObject(new Set(["read", "write"]), "System.String");
    assert(stringEnumerable.Count === 2, "IEnumerable<String> contents");

    const dictionary = Make.dictionaryObject({
        name: "DEAL.JS",
        metadata: { version: 1 },
        tags: ["declarative", "extensible"]
    });
    assert(dictionary.Count === 3, "dictionary entry count");

    const hashSet = Make.hashSetObject(["a", "b", "a"], "System.String");
    assert(hashSet.Count === 2, "HashSet<T> removes duplicates");

    const bytes = Make.bytesObject("DEAL");
    assert(Array.isArray(bytes) && bytes.length === 4, "bytesObject must return a JavaScript byte array");

    const resource = application.Engine.Resource;
    const path = resource.Combine(["Temporary", "deal-clr-interop-smoke.txt"]);
    resource.SetFileLines(path, stringArray, null);
    resource.AppendFileLines(path, ["write"], null);
    assert(resource.GetFileLine(path, 0, null) === "alpha" && resource.GetFileLine(path, 2, null) === "write", "object[] and IEnumerable<string> ResourceProvider overloads");
    resource.Delete(path);

    return "CLR interop smoke test passed.";
})();
