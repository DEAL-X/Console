// Tutorial 11: handle expected failures with try/catch.
Use deal/core;

function parsePositiveNumber(value) {
    const number = Number(value);
    if (!Number.isFinite(number) || number <= 0)
        throw new RangeError("A positive number is required.");
    return number;
}

Consider inputs be ["12", "0", "not-a-number", "4.5"];
Consider results be [];

For each value of inputs,
    Try,
        Append results, { input: value, value: parsePositiveNumber(value), error: null };
    Catch problem,
        Append results, { input: value, value: null, error: problem.message };

application.Display(results);
