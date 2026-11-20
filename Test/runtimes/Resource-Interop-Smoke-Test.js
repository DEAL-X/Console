// Direct JavaScript-to-.NET resource interop regression test.
// Run with V8ScriptEngineFlags.EnableArrayConversion enabled.

(function () {
    const resource = application.Engine.Resource;
    const linesPath = resource.Combine(resource.TempDirectory, "deal-resource-array-smoke.txt");
    const bytesPath = resource.Combine(resource.TempDirectory, "deal-resource-bytes-smoke.bin");
    const textPath = resource.Combine(resource.TempDirectory, "deal-resource-text-smoke.txt");

    function assert(condition, message) {
        if (!condition) throw new Error("Resource interop smoke test failed: " + message);
    }

    try {
        const lines = ["first", "second", "third"];
        resource.SetFileLines(linesPath, lines, null);
        assert(resource.GetFileLine(linesPath, 0, null) === "first" &&
            resource.GetFileLine(linesPath, 2, null) === "third",
            "JavaScript arrays should bind to SetFileLines(string[]).");

        resource.PrependFileLines(linesPath, ["zero"], null);
        resource.AppendFileLines(linesPath, ["fourth"], null);
        assert(resource.GetFileLine(linesPath, 0, null) === "zero" &&
            resource.GetFileLine(linesPath, 4, null) === "fourth",
            "PrependFileLines and AppendFileLines should accept JavaScript arrays.");

        resource.SetFileContents(bytesPath, [65, 66, 67]);
        const bytes = resource.GetFileContents(bytesPath);
        assert(bytes.length === 3 && Number(bytes[0]) === 65 && Number(bytes[2]) === 67,
            "JavaScript byte arrays should bind to SetFileContents(byte[]).");

        resource.SetFileText(textPath, "DEAL");
        assert(resource.GetFileText(textPath) === "DEAL",
            "String values should use the existing SetFileText(string) API.");

        return true;
    } finally {
        resource.Delete(linesPath);
        resource.Delete(bytesPath);
        resource.Delete(textPath);
    }
})();
