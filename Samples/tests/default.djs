command test(name, fromExt = ".djs", toExt = ".js", openResultsApp = 'notepad'){
	if(openResultsApp) save(path be (local path `./Samples/tests/results/${name}${toExt}`), compile `./Samples/tests/inputs/${name}${fromExt}`) then start openResultsApp by path, otherwise print its;
	else return save(path be (local path `./Samples/tests/results/${name}${toExt}`), compile `./Samples/tests/inputs/${name}${fromExt}`);
}