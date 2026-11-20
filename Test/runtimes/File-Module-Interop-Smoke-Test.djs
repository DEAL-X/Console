Use deal/data;

Consider path is application.Engine.Resource.Combine(
    application.Engine.Resource.TempDirectory,
    "deal-file-module-interop-smoke.txt"
);
Consider textPath is application.Engine.Resource.Combine(
    application.Engine.Resource.TempDirectory,
    "deal-local-write-interop-smoke.txt"
);

Consider file is File(path);
file.lines = ["first", "second"];
if (file.count !== 2) throw new Error("File.lines did not pass a JavaScript array to SetFileLines.");

Consider binaryFile is File(path + ".bin");
binaryFile.contents = [65, 66, 67];
if (binaryFile.contents.length !== 3) throw new Error("File.contents did not pass a JavaScript array to SetFileContents.");

if (typeof Local === "undefined")
    throw new Error("The data directory import did not load its Local sibling module.");

application.Engine.Resource.SetFileText(textPath, "DEAL");
if (application.Engine.Resource.GetFileText(textPath) !== "DEAL")
    throw new Error("The resource API did not preserve a direct string argument.");

application.Engine.Resource.Delete(path);
application.Engine.Resource.Delete(path + ".bin");
application.Engine.Resource.Delete(textPath);
