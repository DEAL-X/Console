// Practical: inspect a local fixture directory and select matching files.
// HOW TO USE:
// Use Sample/practicals/Folder;

Use deal/core;
Use deal/data/local;
Use deal/select;
Consider paths variable be select "Path" from local folder "Temporary";
print select any /.*snippet.*/i from paths;