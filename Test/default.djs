use deal/core;
use console;

command Test = function(name, fromExt = ".djs", toExt = ".js", openResultsApp = 'notepad'){
	if(openResultsApp) return Local write(path be (local path `./Tests/outputs/${name}${toExt}`), application.Compile `./Tests/inputs/${name}${fromExt}`) then start openResultsApp by path, otherwise print its;
	else return Local write(path be (local path `./Tests/outputs/${name}${toExt}`), compile `./Tests/inputs/${name}${fromExt}`);
};

command Test.compare = function(name, fromExt = ".djs", toExt = ".js", pattern = "\\w+|\\W+") {
	Test(name, fromExt, toExt, null);
	return application.Compare(`./Tests/outputs/${name}${toExt}`, `./Tests/expects/${name}${toExt}`, pattern);
}