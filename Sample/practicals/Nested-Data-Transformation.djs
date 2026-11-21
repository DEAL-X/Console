// Practical: flatten nested department data and calculate team totals.
Use deal/core;
Use console;

Consider departments be [
    { name: "Engineering", teams: [{ name: "Compiler", people: 4 }, { name: "Runtime", people: 3 }] },
    { name: "Research", teams: [{ name: "Language", people: 2 }, { name: "Tools", people: 5 }] }
];

Consider teams be departments.flatMap(department =>
    department.teams.map(team => ({
        department: department.name,
        name: team.name,
        people: team.people
    }))
);
Consider totalPeople be teams.reduce((total, team) => total + team.people, 0);
Consider largestTeam be teams.reduce((largest, team) =>
    team.people > largest.people ? team : largest
);

Print {
    teams: teams,
    total_people: totalPeople,
    largest_team: largestTeam
};
