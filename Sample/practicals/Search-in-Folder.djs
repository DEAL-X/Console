// Practical: inspect a local fixture directory and select matching files.
// HOW TO USE:
// Use Sample/practicals/Folder;

Use deal/core;
Use deal/data/local;
Use deal/select;
Use console;
{
	Let dir be prompt "Input the search directory path: ";
	Consider pat = ".*example.*";
	do {
		pat be prompt "Input the search word (RegEx pattern is supported): ";
		Print select any (RegExp(pat) from select "Path" from local folder dir, true);
	} while (pat);
}