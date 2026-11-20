use deal/core;

Snippet = {};
Snippet.path = null;
command Snippet = function () {
	let path = null;
	let mode = 0;
	if(arguments.length > 1){
		if("string" === typeof arguments[0]){
			path = arguments[0];
			mode = arguments[1];
		}
		else {
			mode = arguments[0];
			path = arguments[1];
		}
	} else if(arguments.length > 0){
		if("string" === typeof arguments[0])
			path = arguments[0];
		else mode = arguments[0];
	}
	if(path == null) {
		path = Snippet.path;
		application.Engine.Resource.SetFileText(path, "// Write your snippet code here...");
	}
	if(isEmpty(path)) path = prompt("Please indicate an address for the snippet file:", Snippet.path);
	if (!application.Engine.Resource.Exists(path) && application.Engine.Resource.SetFileText(path)) {
		writeLine("The file " + path + " is created successfully!");
	}
	start("notepad", path);

	if(mode > 1 || (mode < 1 && confirm(`Are you sure to evaluate your snippet on \"${application.Engine.Resource.FileName(path)}\"?`))) return evaluate(path);
	else if(mode > 0 || (mode < 1 && confirm(`Do you want to compile that snippet instead?`))) return compile(path);
}
command Snippet.path = application.Engine.Resource.TempDirectory + 'snippet.djs';
command Snippet.handler(content = null, source = null){
	if(content && source) return [content, source];
	return [content ?? source ?? Snippet.path];
};

command compile() => application.Engine.Compile(...Snippet.handler(...arguments)).Content;
command evaluate() => application.Engine.Execute(...Snippet.handler(...arguments));
command execute() => application.Display(application.Engine.Execute(...Snippet.handler(...arguments)));
command compare() => application.Engine.Compare(...arguments);