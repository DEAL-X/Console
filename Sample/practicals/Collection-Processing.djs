// Practical: filter, transform, aggregate, and select structured records.
// HOW TO USE:
// Use Sample/practicals/Collection-Processing;

Use deal/core;
Use deal/select;
Use console;

Consider orders be [
    { id: 1, customer: "Ada", amount: 12.5, paid: true },
    { id: 2, customer: "Grace", amount: 8, paid: false },
    { id: 3, customer: "Ada", amount: 5.5, paid: true },
    { id: 4, customer: "Edsger", amount: 20, paid: true }
];

Consider paidOrders be orders.filter(order => order.paid);
Consider customers be select "customer" from paidOrders;
Consider adaOrders be paidOrders.filter(order => order.customer === "Ada");
Consider total be paidOrders.reduce((sum, order) => sum + order.amount, 0);

Print {
    paid_count: paidOrders.length,
    customers: Array.from(new Set(customers)),
    ada_order_count: adaOrders.length,
    paid_total: Number(total.toFixed(2))
};
