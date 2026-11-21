use deal\make;
use deal/make/string;

command open(question = "Path to open: ", defValue = "") => prompt(question, defValue);

command save(question = "Path to save: ", defValue = "") => prompt(question, defValue);

command append(dest = null, value = null) {
	if(Array.isArray(dest)) {
		dest.push(value);
		return dest;
	}
	else return application.Engine.Resource.AppendFileText(dest ?? temp.file, Make.string(value));
}
command prepend(dest = null, value = null){
	if(Array.isArray(dest))
		return dest = [value, ...dest];
	else return application.Engine.Resource.PrependFileText(dest ?? temp.file, Make.string(value));
}
command first(source = null) {
	if("object" === typeof source)
		return source.first;
	else return application.Engine.Resource.GetFileLine(source ?? temp.file, 0);
}
command last(source = null) {
	if("object" === typeof source)
		return source.last;
	else return application.Engine.Resource.GetFileLine(source ?? temp.file, -1);
}