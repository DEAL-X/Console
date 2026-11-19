// Tutorial 04: JavaScript values and script-friendly .NET API overloads.
// The host exposes Microsoft.ClearScript.ExtendedHostFunctions as "host".
// HOW TO USE:
// Use Sample/tutorials/4;

Use deal/core;
Use deal/make;

Consider names is ["Ada", "Grace", "Edsger"];

// 1. A JavaScript array remains a JavaScript array under EnableArrayConversion.
// The resource provider's object[] overload converts it to the required string values.
Consider clrNames is Make.arrayObject(names, "System.String");
application.Engine.Resource.SetFileLines(
    application.Engine.Resource.Combine([
        application.Engine.Resource.TempDirectory,
        "deal-names.txt"
    ]),
    clrNames,
    null
);

// 2. Use real generic CLR collections when an API requires IEnumerable<T>.
Consider clrList is Make.listObject([10, 20, 30], "System.Int32");
Consider clrEnumerable is Make.iteratorObject(new Set(["read", "write"]), "System.String");
Consider clrUniqueNames is Make.hashSetObject(names, "System.String");

// clrList is List<Int32>; clrEnumerable is List<String>, implementing IEnumerable<String>.
// clrUniqueNames is HashSet<String>.

// 3. Convert JavaScript objects and nested values to Dictionary<String, Object>.
Consider profile is Make.dictionaryObject({
    name: "DEAL.JS",
    version: 1,
    tags: ["declarative", "interoperable"],
    metadata: { language: "JavaScript", target: ".NET" }
});

// 4. Convert plain objects into a requested .NET class when it has a
// parameterless constructor and writable properties with matching names.
// Consider point is Make.objectObject({ X: 12, Y: 34 }, "MyApplication.Point");

// 5. Byte arrays also remain script-facing arrays; resource overloads convert them in .NET.
Consider textBytes is Make.bytesObject("Hello from DEAL.JS");
Consider numericBytes is Make.bytesObject([68, 69, 65, 76]);
application.Engine.Resource.SetFileContents(
    application.Engine.Resource.Combine(["Temporary", "deal-bytes.bin"]),
    numericBytes
);

Print clrNames;
Print clrList;
Print clrEnumerable;
Print profile;
Print textBytes.length;
Print numericBytes.length;
