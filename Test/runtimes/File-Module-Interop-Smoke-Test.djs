Use deal/data/file;

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

Local.write(textPath, "DEAL");
if (application.Engine.Resource.GetFileText(textPath) !== "DEAL")
    throw new Error("Local.write did not use the direct string resource API.");

application.Engine.Resource.Delete(path);
application.Engine.Resource.Delete(path + ".bin");
application.Engine.Resource.Delete(textPath);
