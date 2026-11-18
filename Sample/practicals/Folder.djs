// Practical: inspect a local fixture directory and select matching files.
// HOW TO USE:
// Use Sample/practicals/Folder;

Use deal/core;
Use deal/data/local;
Use deal/select;
Use console;

Consider entries be Array.from(Local.folder("Sample/fixtures/results"));
Consider results be entries
    .filter(item => item.IsFile && item.Name.toLowerCase().includes("namespaces"))
    .map(item => item.Path);

Print results;
