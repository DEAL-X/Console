// HOW TO USE:
// Use Sample/practicals/Compare;

Use deal/core;
Use deal/data/file;
Use console;

function cmp() => print `The result of compare "${Array.from(arguments).join('" with "')}" is ` + (compare ...arguments);

cmp "test text", "test text";
cmp "test text", "test Text";
cmp "test text", "testtext";
cmp "test text", "text test";
cmp "test text", "tst txt";
cmp "test text", "tesxt";
cmp "test text", "tesx";
cmp "test text", "t";
cmp "test text", "e";
cmp "test text", "x";
cmp "test text", "";
cmp "test text", "m";
cmp "test text", "no";