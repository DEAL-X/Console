// Tutorial 09: create, inspect, and transform JavaScript objects.

Use deal/core;
Use console;

Consider defaults be { language: "DEAL.JS", version: 1, stable: false };
Consider release be { ...defaults, version: 2, stable: true };
Consider properties be Object.entries(release).map(([key, value]) => ({
    property: key,
    value: value
}));

Print { release: release, property_count: properties.length, properties: properties };
