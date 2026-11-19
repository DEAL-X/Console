// Practical: fetch a small JSON catalog and persist a normalized JSONL snapshot.
// Requires network access to the public JSONPlaceholder test API.
// HOW TO USE:
// Use Sample/practicals/Api-Catalog-Collection;

Use deal/core;
Use deal/web;
Use deal/data/file;
Use console;

const response = await fetch("https://jsonplaceholder.typicode.com/posts?_limit=5");
if (!response.ok)
    throw new Error("Catalog request failed with HTTP " + response.status);

const posts = await response.json();
const catalog = posts.map(post => ({
    id: post.id,
    title: String(post.title || "").trim(),
    summary: String(post.body || "").replace(/\s+/g, " ").trim()
}));

const output = File(Temporary.path("deal-api-catalog.jsonl"));
output.fields = catalog;

Print {
    received: posts.length,
    saved: output.count,
    first: catalog[0] || null
};
