// Tutorial 06: select object properties and match values in collections.
// HOW TO USE:
// Use Sample/tutorials/6;

Use deal/core;
Use deal/select;
Use console;

Consider people be [
    { name: "Ada", language: "Analytical Engine", active: true },
    { name: "Grace", language: "COBOL", active: true },
    { name: "Edsger", language: "ALGOL", active: false }
];

Consider names be select "name" from people;
Consider activePeople be people.filter(person => person.active);
Consider namesStartingWithA be select any /^A/i from names;

Print {
    names: names,
    active_names: select "name" from activePeople,
    names_starting_with_a: namesStartingWithA
};
