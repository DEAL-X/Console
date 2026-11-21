// Tutorial 14: map, filter, and reduce a collection.
Use deal/core;
Use console;

Consider prices be [12.5, 8, 19.99, 4.5, 25];
Consider discounted be prices.map(price => Number((price * 0.9).toFixed(2)));
Consider affordable be discounted.filter(price => price < 15);
Consider total be affordable.reduce((sum, price) => sum + price, 0);

Print {
    prices: prices,
    discounted: discounted,
    affordable: affordable,
    total: Number(total.toFixed(2))
};
