// Practical: collect search-result cards across a bounded number of pages.
// This sample intentionally uses the BrowserDocument HTML-string API rather
// than treating its serialized QuerySelectorAll result as live DOM elements.
// HOW TO USE:
// Use Sample/practicals/Web-Scraping-2;

Use deal/core;
Use deal/web;
Use deal/data/file;
const query = "DSL";
const tab = browser.open("about:blank");
const normalFile = File(Temporary.path("normal-serp.jsonl"));
const finalFile = File(Temporary.path("final-serp.jsonl"));
let address = "https://www.google.com/search?q=" + encodeURIComponent(query);
let pageCount = 0;

// Keep the example bounded; a live search page can change its markup at any time.
while (address && pageCount < 3) {
    tab.Navigate(address);
    pageCount++;

    const cards = JSON.parse(tab.Window.Document.QuerySelectorAll("div[data-rpos]") || "[]");
    For each markup in cards,
        Consider linkMatch be /<a\b[^>]*href=["']([^"']+)["'][^>]*>[\s\S]*?<h3\b[^>]*>([\s\S]*?)<\/h3>/i.exec(markup);
        If linkMatch,
            Consider descriptionMatch be /<div[^>]*data-sncf=["']1["'][^>]*>([\s\S]*?)<\/div>/i.exec(markup);
            Consider record be {
                query: query,
                title: linkMatch[2].replace(/<[^>]*>/g, " ").replace(/&amp;/g, "&").trim(),
                description: descriptionMatch ? descriptionMatch[1].replace(/<[^>]*>/g, " ").replace(/&amp;/g, "&").trim() : "",
                url: linkMatch[1]
            };
            normalFile.append(record);

    const nextMarkup = tab.Window.Document.QuerySelector("a#pnnext");
    const nextMatch = nextMarkup && /href=["']([^"']+)["']/i.exec(nextMarkup);
    if (nextMatch) {
        const nextUrl = nextMatch[1];
        address = /^https?:/i.test(nextUrl) ? nextUrl : "https://www.google.com" + nextUrl;
    } else address = null;
}

// Re-read the JSONL file, remove duplicate URLs, and persist the final records.
const finalRecords = [];
const seen = new Set();
For each record in normalFile.fields,
    If (record.url && !seen.has(record.url)),
        seen.add(record.url);
        Append finalRecords, record;

finalFile.fields = finalRecords;
print { pages: pageCount, records: finalRecords };
