// Tutorial: await Fetch and consume a JSON response body.
// Requires network access to the public JSONPlaceholder test API.
// HOW TO USE:
// Use Sample/tutorials/6;

Use deal/core;
Use deal/web;
Consider response be await fetch("https://jsonplaceholder.typicode.com/posts?_limit=3");
If !response.ok,
    throw new Error("The request failed with HTTP " + response.status);

Consider posts be await response.json();
Consider titles be posts.map(post => post.title);

print {
    status: response.status,
    count: posts.length,
    titles: titles
};
