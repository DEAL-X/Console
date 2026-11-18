// Tutorial 05: define reusable JavaScript functions and DEAL commands.
// HOW TO USE:
// Use Sample/tutorials/5;

Use deal/core;
Use console;

function calculateTotal(items) {
    return items.reduce((total, item) => total + item.price * item.count, 0);
}

command describeCart(items) {
    return {
        item_count: items.length,
        total: Number(calculateTotal(items).toFixed(2))
    };
}

Consider cart be [
    { name: "Notebook", count: 2, price: 3.5 },
    { name: "Pen", count: 4, price: 1.25 },
    { name: "Folder", count: 1, price: 2 }
];

Print describeCart(cart);
