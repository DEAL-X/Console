use deal/core;
use console;

command Test = function(name, fromExt = ".djs", toExt = ".js", openResultsApp = 'notepad'){
	if(openResultsApp) return Local write(path be (local path `./Test/outputs/${name}${toExt}`), application.Compile `./Test/inputs/${name}${fromExt}`) then start openResultsApp by path, otherwise print its;
	else return Local write(path be (local path `./Test/outputs/${name}${toExt}`), compile `./Test/inputs/${name}${fromExt}`);
};

command Test.compare = function(name, fromExt = ".djs", toExt = ".js", pattern = "\\w+|\\W+") {
	Test(name, fromExt, toExt, null);
	return application.Compare(`./Test/outputs/${name}${toExt}`, `./Test/expects/${name}${toExt}`, pattern);
}