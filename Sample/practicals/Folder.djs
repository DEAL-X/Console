// Practical: inspect a local fixture directory and select matching files.
// HOW TO USE:
// Use Sample/practicals/Folder;

Use deal/core;
Use deal/data/local;
Use deal/select;
Use console;

Consider entries be Array.from(Local.folder("Sample/fixtures/results"));
Consider paths be entries.map(item => item.Path);
Consider results be select any /Namespaces/i from paths;

Print results;
