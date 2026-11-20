// Practical: validate incoming records and separate accepted and rejected data.
Use deal/core;
Consider incoming be [
    { id: 101, email: "ada@example.test", amount: 25 },
    { id: 102, email: "invalid-email", amount: 14 },
    { id: 103, email: "grace@example.test", amount: -3 },
    { id: 104, email: "edsger@example.test", amount: 42 }
];

Consider checked be incoming.map(record => {
    const errors = [];
    if (!Number.isInteger(record.id) || record.id <= 0) errors.push("invalid id");
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(record.email)) errors.push("invalid email");
    if (!Number.isFinite(record.amount) || record.amount < 0) errors.push("invalid amount");
    return { record, errors };
});

Consider accepted be checked.filter(item => item.errors.length === 0).map(item => item.record);
Consider rejected be checked.filter(item => item.errors.length > 0)
    .map(item => ({ id: item.record.id, errors: item.errors }));

print { accepted: accepted, rejected: rejected };
