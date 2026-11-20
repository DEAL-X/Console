// HOW TO USE:
// Use Sample/practicals/Compare;

Use deal/core;
Use deal/data;
Use console;

function cmp() => print `The result of compare "${Array.from(arguments).join('" with "')}" is ` + (Math.decimals 100 * (compare ...arguments), 2) + "%";

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

let cmpv1, cmpv2;
do {
	cmpv1 be prompt "Input the test first value to compare: ";
	cmpv2 be prompt "Input the test second value to compare: ";
	cmp cmpv1, cmpv2;
} while (cmpv1 || cmpv2);