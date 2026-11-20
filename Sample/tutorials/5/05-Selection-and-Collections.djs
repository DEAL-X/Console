// Tutorial: select object properties and match values in collections.
// HOW TO USE:
// Use Sample/tutorials/5;

Use deal/core;
Use deal/select;
Consider people be [
    { name: "Ada", language: "Analytical Engine", active: true },
    { name: "Grace", language: "COBOL", active: true },
    { name: "Edsger", language: "ALGOL", active: false }
];

Consider names be select "name" from people;
Consider activePeople be people.filter(person => person.active);
Consider activeNames be select "name" from activePeople;
Consider namesStartingWithA be select any /^A/i from names;

print {
    names: names,
    active_names: activeNames,
    names_starting_with_a: namesStartingWithA
};
