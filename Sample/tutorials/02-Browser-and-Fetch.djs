// Tutorial 02: Browser control and the Fetch-compatible API.
// Browser methods/properties are synchronous; Fetch and response bodies are asynchronous.

Use deal/core;
Use deal/web;

// Open returns a BrowserTab immediately. The host's default driver is Chrome.
Consider tab be browser.open("https://example.com/");
Consider pageTitle be tab.Title;
Consider pageUrl be tab.Url;
Consider firstHeading be tab.Window.Document.QuerySelector("h1");

// Browser convenience methods are synchronous.
tab.Navigate("https://example.org/");
tab.Back();

// Fetch and response-body readers return promises; await both.
Consider response be await fetch("https://example.com/");
If response.ok,
    Consider html be await response.text();
    Print html;
Otherwise,
    Log.error "The request failed with status " + response.status;
