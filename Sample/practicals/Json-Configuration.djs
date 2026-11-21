// Practical: persist and restore a JSON configuration file.
Use deal/core;
Use deal/data/temporary;
Use deal/data/file;

Consider settings be {
    application: "DEAL.JS",
    options: { strict: true, compileOnSave: false },
    recent: ["tutorials", "practicals"]
};

Consider configPath be Temporary.path("deal-settings.json");
Consider configFile be File(configPath, null, false);
configFile.write(JSON.stringify(settings, null, 2));

Consider restored be JSON.parse(configFile.read());

application.Display({
    path: configFile.path,
    application: restored.application,
    strict_mode: restored.options.strict,
    recent_count: restored.recent.length
});
