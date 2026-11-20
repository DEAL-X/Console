// Interactive entry point for practical samples in this directory.
Use deal/core;
const directory = "Sample/practicals";
const samples = Array.from(application.Engine.Resource.GetFolderContents(directory, false))
    .filter(item => item.IsFile &&
        /\.djs$/i.test(item.Path) &&
        !/(^|[\\/])default\.djs$/i.test(item.Path))
    .sort((left, right) => left.Path.localeCompare(right.Path, undefined, { numeric: true, sensitivity: "base" }));

print "DEAL.JS practicals";
samples.forEach((item, index) => {
    print (index + 1) + ". " + application.Engine.Resource.FileName(item.Path);
});

const selectedNumber = Number(prompt("Practical number: "));
if (Number.isInteger(selectedNumber) && selectedNumber >= 1 && selectedNumber <= samples.length) {
    const selectedPath = samples[selectedNumber - 1].Path;
    if (confirm("Do you want to execute it?")) {
        print application.Execute(selectedPath);
    } else {
        print application.Compile(selectedPath);
    }
} else {
    print "No valid practical was selected.";
}
