// Tutorial 11: handle expected failures with try/catch.
Use deal/core;
Use console;

function parsePositiveNumber(value) {
    const number = Number(value);
    if (!Number.isFinite(number) || number <= 0)
        throw new RangeError("A positive number is required.");
    return number;
}

Consider inputs be ["12", "0", "not-a-number", "4.5"];
Consider results be inputs.map(value => {
    try {
        return { input: value, value: parsePositiveNumber(value), error: null };
    } catch (error) {
        return { input: value, value: null, error: error.message };
    }
});

Print results;
