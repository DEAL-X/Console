// Tutorial 07: create, append, and read a local text file.
Use deal/core;
Use deal/data/temporary;
Use deal/data/file;

Consider notes be File(Temporary.path("deal-tutorial-notes.txt"));
notes.write("DEAL.JS tutorial notes");
notes.append("First note");
notes.append("Second note");

application.Display({
    path: notes.path,
    lines: Array.from(notes.lines),
    count: notes.count,
    text: notes.read()
});
