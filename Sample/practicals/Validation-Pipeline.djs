// Practical: validate incoming records and separate accepted and rejected data.
Use deal/core;
Use console;

Consider incoming be [
    { id: 101, email: "ada@example.test", amount: 25 },
    { id: 102, email: "invalid-email", amount: 14 },
    { id: 103, email: "grace@example.test", amount: -3 },
    { id: 104, email: "edsger@example.test", amount: 42 }
];

Consider accepted be [];
Consider rejected be [];

For each record of incoming,
    Consider errors be [];
    If !Number.isInteger(record.id) || record.id <= 0,
        Append errors, "invalid id";
    If !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(record.email),
        Append errors, "invalid email";
    If !Number.isFinite(record.amount) || record.amount < 0,
        Append errors, "invalid amount";

    If errors.length === 0,
        Append accepted, record;
    Else,
        Append rejected, { id: record.id, errors: errors };

Print {
    accepted: accepted,
    rejected: rejected
};
