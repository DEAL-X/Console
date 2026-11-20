// Practical: persist and restore a JSON configuration file.
Use deal/core;
Use deal/data/file;
Use console;

Consider settings be {
    application: "DEAL.JS",
    options: { strict: true, compileOnSave: false },
    recent: ["tutorials", "practicals"]
};

Consider configFile be File(Temporary.path("deal-settings.json"), null, false);
configFile.write(JSON.stringify(settings, null, 2));
Consider restored be JSON.parse(configFile.read());

Print {
    path: configFile.path,
    application: restored.application,
    strict_mode: restored.options.strict,
    recent_count: restored.recent.length
};
