// Practical: persist and restore a JSON configuration file.
Use deal/core;
Use deal/data/temporary;
Use deal/data/file;

Consider settings be {
    application: "DEAL.JS",
    version: 1,
    strict: true,
    compileOnSave: false
};

Consider configPath be Temporary.path("deal-settings.json");
Consider configFile be File(configPath, null, false);
configFile.write(JSON.stringify(settings));

Consider restored be JSON.parse(configFile.read());

application.Display({
    path: configFile.path,
    application: restored.application,
    version: restored.version,
    strict_mode: restored.strict,
    compile_on_save: restored.compileOnSave
});
