// Interactive entry point for the complete sample collection.
Use deal/core;
Use console;
{
    print "1\tPracticals";
    print "2\tTutorials";
    const samples = [
        "Sample/practicals/default.djs",
        "Sample/tutorials/default.djs"
    ];
    const selectedNumber = Number(prompt("Input the Course Number: "));
    if (Number.isInteger(selectedNumber) && selectedNumber >= 1 && selectedNumber <= samples.length) {
        const selectedPath = application.Engine.Resource.Normalize(samples[selectedNumber - 1]);
        application.Clear();
        application.Engine.Execute(selectedPath);
    } else {
        Print "No valid sample was selected.";
    }
}
