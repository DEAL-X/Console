// Interactive entry point for practical samples in this directory.
Use deal/core;
Use console;
{
    const directory = "Sample/practicals";
    const samples = Array.from(application.Engine.Resource.GetFolderContents(directory, false))
        .filter(item => item.IsFile &&
            /\.(djs|js|deal)$/i.test(item.Path) &&
            !/(^|[\\/])default\.djs$/i.test(item.Path))
        .sort((left, right) => left.Path.localeCompare(right.Path, undefined, { numeric: true, sensitivity: "base" }));

    Print "DEAL.JS Practical Course";
    Print "";
    samples.forEach((item, index) => {
        Print ((index + 1) + "\t" + application.Engine.Resource.FileName(item.Path));
    });
    
    let selectedNumber = null;
    do{
        selectedNumber = Number(prompt("Input the Sample Number: "));
        if (Number.isInteger(selectedNumber) && selectedNumber >= 1 && selectedNumber <= samples.length) {
            const selectedPath = samples[selectedNumber - 1].Path;
            if (confirm(`Do you want to execute "${samples[selectedNumber - 1].FullName}"?`))
                Execute(null, selectedPath);
            else if (confirm(`Do you want to compile "${samples[selectedNumber - 1].FullName}"?`))
                Print Compile(null, selectedPath);
            else {
                Print "";
                Print application.Engine.Resource.GetFileText(selectedPath);
                Print "";
            }
        }  else break;
    } while(true);
}
