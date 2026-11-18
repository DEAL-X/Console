// Practical: collect page titles and heading markup from several websites.
// Requires an installed Chrome browser (the default Browser driver).
// HOW TO USE:
// Use Sample/practicals/Web-Scraping-1;

Use deal/core;
Use deal/web;
Use console;

Consider urls be [
    "https://example.com/",
    "https://example.org/"
];
Consider results be [];

// Open one tab and reuse the same BrowserTab for each address.
Consider tab be browser.open("about:blank");
For each url of urls,
    Try,
        tab.Navigate(url);
        Consider title be tab.Title;
        Consider headings be tab.Window.Document.QuerySelectorAll("h1, h2, h3");
        Append results, { url: tab.Url, title: title, headings: JSON.parse(headings || "[]") };
    Catch problem,
        Log.warning "Could not scrape " + url + ": " + problem;

Print results;
