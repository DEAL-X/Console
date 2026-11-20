// Tutorial 12: pass functions as values and compose reusable operations.
Use deal/core;
function transform(values, operation) {
    return values.map(operation);
}

function clamp(value, low, high) {
    return Math.min(high, Math.max(low, value));
}

Consider values be [-4, 2, 7, 15];
Consider normalized be transform(values, value => clamp(value, 0, 10));
Consider labels be transform(normalized, value => value + " points");

print { original: values, normalized: normalized, labels: labels };
