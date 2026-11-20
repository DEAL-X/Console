// Interactive entry point for the complete sample collection.
Use deal/core;
Use console;

const directory = "Sample";
const samples = Array.from(application.Engine.Resource.GetFolderContents(directory, true))
    .filter(item => item.IsFile &&
        /\.djs$/i.test(item.Path) &&
        !/(^|[\\/])default\.djs$/i.test(item.Path))
    .sort((left, right) => left.Path.localeCompare(right.Path, undefined, { numeric: true, sensitivity: "base" }));

Print "DEAL.JS samples";
Print "Select a sample by its number:";
samples.forEach((item, index) => {
    Print (index + 1) + ". " + item.Path.replace(/^Sample[\\/]/i, "");
});

const selectedNumber = Number(prompt("Sample number: "));
if (Number.isInteger(selectedNumber) && selectedNumber >= 1 && selectedNumber <= samples.length) {
    const selectedPath = samples[selectedNumber - 1].Path;
    if (confirm("Do you want to execute it?")) {
        Print application.Execute(selectedPath);
    } else {
        Print application.Compile(selectedPath);
    }
} else {
    Print "No valid sample was selected.";
}
