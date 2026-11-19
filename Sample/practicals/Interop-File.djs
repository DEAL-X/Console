// Practical: export structured DEAL data through .NET resource APIs.
// Requires ExtendedHostFunctions exposed as "host" by the Console host.
// HOW TO USE:
// Use Sample/practicals/Interop-File;

Use deal/core;
Use deal/make/object;
Use deal/data/file;
Use deal/data/local;

Consider records be [
    { id: 1, title: "Declarative", tags: ["language", "intent"] },
    { id: 2, title: "Deterministic", tags: ["compiler", "reliability"] },
    { id: 3, title: "Interoperable", tags: ["JavaScript", ".NET"] }
];

Consider root be Temporary directory;
Consider jsonLinesPath be application.Engine.Resource.Combine(root, "deal-records.jsonl");
Consider binaryPath be application.Engine.Resource.Combine(root, "deal-summary.txt");

Consider results be File(jsonLinesPath);
results fields be records;

Consider restored be [];
For each record of results fields: Append restored, record;

Local write binaryPath, "Exported " + restored.length + " records from DEAL.JS.";

Print restored;
Print Local read binaryPath;