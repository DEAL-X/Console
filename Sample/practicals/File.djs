// HOW TO USE:
// Use Sample/practicals/File;

Use deal/core;
Use deal/data;
Use console;

Consider myCart variable be file temporary path "file-1-sample.txt";
myCart append {Name:"Snakes", Count:2, Price:2, Brand:"Guau"};
myCart append {Name:"Chocolate", Count:5, Price:2.5, Type:"V", Unit:"Kilo", Desc:"90% coca"};
myCart append {Name:"Beverage", Count:3, Price:1.2, Brand:"CocaCola", Desc:"1.5L"};
myCart append {Name:"Milk", Count:6, Price:0.2, Type:"V", Unit:"Liter"};
myCart append {Name:"Beverage", Count:1, Price:1.2, Brand:"PepsiCola", Desc:"1.5L"};
myCart append {Name:"Chocolate", Count:0.75, Price:2, Type:"V", Unit:"Kilo", Desc:"80% coca"};

print "The myCart variable is a file contain:";
print myCart read it;
Var query be null;
do {
	query be (prompt "Search a word in cart to compute the price (leave empty to jump): ")?.toLowerCase();
	Let results be select "Name", "Price", "Count" from (not query? 
		myCart search (item => 
			item?.Name?.toLowerCase()?.includes(query)
			or item?.Desc?.toLowerCase()?.includes(query)
			or item?.Brand?.toLowerCase()?.includes(query)
		) : myCart fields
	);
	print "Name\t Count\t Price\t Total";
	print results map (item => `${item.Name}\t ${item.Count}\t ${Math.decimals(item.Price, 2)}\t ${Math.decimals(item.Count * item.Price, 2)}`) join("\n");
	print `The total price of ${results.length} items is: ` + math decimals(math sum(results map (item=>item.Count * item.Price)), 2) + " $";
} while (query);