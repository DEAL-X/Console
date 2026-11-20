// Tutorial 04: Pass JavaScript values directly to .NET APIs.
// HOW TO USE:
// Use Sample/tutorials/4;

Use deal/core;
Use deal/make/object;

Consider names is ["Ada", "Grace", "Edsger"];
Consider path is application.Engine.Resource.Combine(
    application.Engine.Resource.TempDirectory,
    "deal-names.txt"
);

// ClearScript converts JavaScript arrays to CLR arrays when EnableArrayConversion is enabled.
// The ResourceProvider exposes a string[] adapter for this API because its main implementation
// accepts IEnumerable<string>.
application.Engine.Resource.SetFileLines(path, names);

// Byte arrays are also passed directly; no Make.byteArrayObject conversion is required.
Consider bytes is [68, 69, 65, 76];
Consider binaryPath is application.Engine.Resource.Combine(
    application.Engine.Resource.TempDirectory,
    "deal-bytes.bin"
);
application.Engine.Resource.SetFileContents(binaryPath, bytes);

// Explicit CLR dictionary conversion remains available for APIs that require Dictionary<TKey,TValue>.
Consider profile is Make.dictionaryObject({
    name: "DEAL.JS",
    version: 1,
    tags: ["declarative", "interoperable"]
});

Print application.Engine.Resource.GetFileLines(path);
Print profile;
