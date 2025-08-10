function profit = profit(x)
    purchase_quantity = x(1);
    selling_price = x(2);
    demand = demand_function(selling_price);
    if purchase_quantity <= demand && purchase_quantity <= max_storage
        profit = (selling_price - purchase_cost) * purchase_quantity - storage_cost * purchase_quantity;
    elseif purchase_quantity <= demand && purchase_quantity > max_storage
        profit = (selling_price - purchase_cost) * max_storage - storage_cost * max_storage;
    else
        profit = (selling_price - purchase_cost) * demand - storage_cost * purchase_quantity;
    end
end