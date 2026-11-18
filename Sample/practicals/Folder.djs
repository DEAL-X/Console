// HOW TO USE:
// Use Sample/practicals/Folder;

Use deal/core;
Use deal/data/local;
Use deal/select;
Use console;

Consider list constant be local folder "samples/tests/results";
Let results be: select any "Namespaces" from select "Path" from list;
Print results;