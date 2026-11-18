// Used 7 resources from "deal/core"
// Used 7 resources from "console"
var Test = async function (name, fromExt = ".djs", toExt = ".js", openResultsApp = "notepad") {
    if (openResultsApp) return save(path = (Local.path(`./Tests/outputs/${name}${toExt}`)), compile(`./Tests/inputs/${name}${fromExt}`)).then((argument) => {
        handle(argument, true);
        start("openResultsApp", path);
    }).catch((argument) => {
        handle(argument, false);
        print(typeof argument == "undefined" ? data ?? this : argument ?? data ?? this ?? globalThis);
    }); else return save(path = (Local.path(`./Tests/outputs/${name}${toExt}`)), compile(`./Tests/inputs/${name}${fromExt}`));
};
Test.compare = function (name, fromExt = ".djs", toExt = ".js", pattern = "\\w+|\\W+") {
    await Test(name, fromExt, toExt, null);
    return compare(`./Tests/outputs/${name}${toExt}`, `./Tests/expects/${name}${toExt}`, pattern);
}