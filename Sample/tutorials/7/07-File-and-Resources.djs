// Tutorial 07: create, append, and read a local text file.
Use deal/core;
Use deal/data;
Use console;

Consider notes be File(Temporary.path("deal-tutorial-notes.txt"), null, false);
notes.write("DEAL.JS tutorial notes");
notes.append("First note");
notes.append("Second note");

Print {
    path: notes.path,
    lines: Array.from(notes.lines),
    count: notes.count
};
