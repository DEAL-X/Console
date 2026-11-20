// Direct JavaScript-to-.NET resource interop regression test.
// Run with V8ScriptEngineFlags.EnableArrayConversion enabled.
// Keep JavaScript arrays at the API boundary; the C# overloads adapt only where required.

(function () {
    const resource = application.Engine.Resource;
    const linesPath = resource.Combine(resource.TempDirectory, "deal-resource-array-smoke.txt");
    const bytesPath = resource.Combine(resource.TempDirectory, "deal-resource-bytes-smoke.bin");
    const textPath = resource.Combine(resource.TempDirectory, "deal-resource-text-smoke.bin");

    function assert(condition, message) {
        if (!condition) throw new Error("Resource interop smoke test failed: " + message);
    }

    try {
        const lines = ["first", "second", "third"];
        resource.SetFileLines(linesPath, lines);
        let actual = Array.from(resource.GetFileLines(linesPath));
        assert(actual.length === 3 && actual[0] === "first" && actual[2] === "third",
            "JavaScript string[] should bind to SetFileLines(string[]).");

        resource.PrependFileLines(linesPath, ["zero"]);
        resource.AppendFileLines(linesPath, ["fourth"]);
        actual = Array.from(resource.GetFileLines(linesPath));
        assert(actual.length === 5 && actual[0] === "zero" && actual[4] === "fourth",
            "PrependFileLines and AppendFileLines should accept JavaScript arrays.");

        resource.SetFileContents(textPath, "DEAL");
        const textBytes = resource.GetFileContents(textPath);
        assert(textBytes.length === 4 && Number(textBytes[0]) === 68 && Number(textBytes[3]) === 76,
            "String content should bind to the UTF-8 SetFileContents(string) overload.");

        resource.SetFileContents(bytesPath, [65, 66, 67]);
        const bytes = resource.GetFileContents(bytesPath);
        assert(bytes.length === 3 && Number(bytes[0]) === 65 && Number(bytes[2]) === 67,
            "JavaScript byte values should bind to SetFileContents(byte[]).");

        return true;
    } finally {
        resource.Delete(linesPath);
        resource.Delete(bytesPath);
        resource.Delete(textPath);
    }
})();
