// Tutorial 04: JavaScript/.NET collection interoperability with EnableArrayConversion.
// The Console host exposes ClearScript ExtendedHostFunctions as global "host".
// JavaScript arrays stay JavaScript arrays; project-owned .NET APIs adapt object[].
// HOW TO USE:
// Use Sample/tutorials/4;

Use deal/core;
Use deal/make;

Consider values be ["alpha", "beta", "gamma"];
Consider clrArray be Make.arrayObject(values, "System.String");
Consider clrList be Make.listObject(values, "System.String");
Consider clrEnumerable be Make.iteratorObject(values, "System.String");
Consider counts be Make.dictionaryObject(
    { first: 1, second: 2, third: 3 },
    "System.String",
    "System.Int32"
);
Consider clrStrings be Make.stringArrayObject(values);
Consider clrBytes be Make.byteArrayObject("DEAL.JS");
Consider integerType be Make.typeObject("System.Int32");
Consider convertedNumber be Make.convertObject("42", integerType);
Consider dynamicRecord be Make.objectObject({ name: "DEAL.JS", revision: 1 });
Consider uniqueValues be Make.hashSetObject(values, "System.String");
Consider pendingValues be Make.queueObject(values, "System.String");
Consider recentValues be Make.stackObject(values, "System.String");
Consider legacyValues be Make.arrayListObject(values);

Consider outputPath be application.Engine.Resource.Combine(["Temporary", "clr-interop-array.txt"]);
application.Engine.Resource.SetFileLines(outputPath, clrArray, null);
Consider listPath be application.Engine.Resource.Combine(["Temporary", "clr-interop-list.txt"]);
application.Engine.Resource.SetFileLines(listPath, clrList, null);
Consider enumerablePath be application.Engine.Resource.Combine(["Temporary", "clr-interop-enumerable.txt"]);
application.Engine.Resource.SetFileLines(enumerablePath, clrEnumerable, null);
Consider binaryPath be application.Engine.Resource.Combine(["Temporary", "clr-interop-bytes.bin"]);
application.Engine.Resource.SetFileContents(binaryPath, clrBytes);

Print {
    arrayLength: clrArray.length,
    stringArrayLength: clrStrings.length,
    byteArrayLength: clrBytes.length,
    listType: "System.Collections.Generic.List<System.String>",
    dictionaryType: "System.Collections.Generic.Dictionary<System.String,System.Int32>",
    convertedNumber: convertedNumber,
    dynamicObjectType: "System.Dynamic.ExpandoObject",
    dynamicObjectName: dynamicRecord.name,
    dictionaryCount: counts.Count,
    hashSetCount: uniqueValues.Count,
    queueCount: pendingValues.Count,
    stackCount: recentValues.Count,
    arrayListCount: legacyValues.Count
};
