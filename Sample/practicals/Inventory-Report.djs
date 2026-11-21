// Practical: calculate stock value and identify products that need reordering.
Use deal/core;
Use console;

Consider products be [
    { name: "Notebook", stock: 18, price: 2.5, reorderAt: 10 },
    { name: "Pen", stock: 7, price: 1.2, reorderAt: 12 },
    { name: "Folder", stock: 0, price: 3.4, reorderAt: 5 },
    { name: "Marker", stock: 14, price: 1.8, reorderAt: 8 }
];

Consider inventoryValue be products.reduce(
    (total, product) => total + product.stock * product.price,
    0
);
Consider reorderList be products
    .filter(product => product.stock <= product.reorderAt)
    .map(product => ({
        name: product.name,
        stock: product.stock,
        reorder_at: product.reorderAt
    }));

Print {
    product_count: products.length,
    units_in_stock: products.reduce((total, product) => total + product.stock, 0),
    inventory_value: Number(inventoryValue.toFixed(2)),
    reorder: reorderList
};
