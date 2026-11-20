// Practical: flatten nested department data and calculate per-team totals.
Use deal/core;
Consider departments be [
    { name: "Engineering", teams: [{ name: "Compiler", people: 4 }, { name: "Runtime", people: 3 }] },
    { name: "Research", teams: [{ name: "Language", people: 2 }, { name: "Tools", people: 5 }] }
];

Consider teams be departments.flatMap(department =>
    department.teams.map(team => ({ department: department.name, ...team })));
Consider totalPeople be teams.reduce((total, team) => total + team.people, 0);
Consider largestTeam be teams.reduce((largest, team) =>
    team.people > largest.people ? team : largest);

print { teams: teams, total_people: totalPeople, largest_team: largestTeam };
