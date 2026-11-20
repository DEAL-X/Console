// Interactive entry point for tutorials, including numbered tutorial folders.
Use deal/core;
Use console;

const directory = "Sample/tutorials";
const samples = Array.from(application.Engine.Resource.GetFolderContents(directory, true))
    .filter(item => item.IsFile &&
        /\.djs$/i.test(item.Path) &&
        !/(^|[\\/])default\.djs$/i.test(item.Path))
    .sort((left, right) => left.Path.localeCompare(right.Path, undefined, { numeric: true, sensitivity: "base" }));

Print "DEAL.JS tutorials";
samples.forEach((item, index) => {
    Print (index + 1) + ". " + item.Path.replace(/^Sample[\\/]tutorials[\\/]/i, "");
});

const selectedNumber = Number(prompt("Tutorial number: "));
if (Number.isInteger(selectedNumber) && selectedNumber >= 1 && selectedNumber <= samples.length) {
    const selectedPath = samples[selectedNumber - 1].Path;
    if (confirm("Do you want to execute it?")) {
        Print application.Execute(selectedPath);
    } else {
        Print application.Compile(selectedPath);
    }
} else {
    Print "No valid tutorial was selected.";
}
