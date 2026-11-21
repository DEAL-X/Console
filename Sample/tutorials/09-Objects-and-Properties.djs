// Tutorial 09: create, inspect, and transform JavaScript objects.
Use deal/core;
Use console;

Consider defaults be { language: "DEAL.JS", version: 1, stable: false };
Consider release be { ...defaults, version: 2, stable: true };
Consider properties be Object.keys(release).map(key => ({
    property: key,
    value: release[key]
}));

print {
    release: release,
    property_count: properties.length,
    properties: properties
};
