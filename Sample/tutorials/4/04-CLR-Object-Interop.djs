// Tutorial 04: JavaScript and .NET interoperability.
// HOW TO USE:
// Use Sample/tutorials/4;

Use deal/core;
Use deal/make;

Consider values be ["alpha", "beta", "gamma"];
Consider outputPath be application.Engine.Resource.Combine(
    application.Engine.Resource.TempDirectory,
    "clr-interop-array.txt"
);

// Pass the JavaScript array directly. ClearScript performs the array conversion.
application.Engine.Resource.SetFileLines(outputPath, values, null);

// Keep explicit object conversion only for APIs that require CLR object types.
Consider counts be Make.dictionaryObject(
    { first: 1, second: 2, third: 3 },
    "System.String",
    "System.Int32"
);
Consider dynamicRecord be Make.objectObject({ name: "DEAL.JS", revision: 1 });

Print {
    values: application.Engine.Resource.GetFileLines(outputPath),
    dictionaryType: counts.GetType().FullName,
    dictionaryCount: counts.Count,
    dynamicObjectType: dynamicRecord.GetType().FullName,
    dynamicObjectName: dynamicRecord["name"]
};
