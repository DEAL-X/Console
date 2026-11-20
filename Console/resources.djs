use deal\make;
use deal/make/string;

command open() => will application.Engine.Resource.GetFileText(...arguments);

command save(dest = null, value = null) => will application.Engine.Resource.SetFileText(dest ?? temp.file, Make.string(value));

command append(dest = null, value = null) {
	if(Array.isArray(dest)) {
		dest.push(value);
		return dest;
	}
	else return application.Engine.Resource.AppendFileText(dest ?? temp.file, Make.string(value));
}
command prepend(object = null, value = null){
	if(Array.isArray(dest))
		return dest = [value, ...dest];
	else return application.Engine.Resource.PrependFileText(dest ?? temp.file, Make.string(value));
}