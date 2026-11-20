// Tutorial 13: define and await asynchronous JavaScript functions.

Use deal/core;
Use console;

async function loadRecord(id) {
    const record = await Promise.resolve({ id: id, name: "Record " + id, active: id % 2 === 0 });
    return record;
}

Consider records be await Promise.all([1, 2, 3].map(id => loadRecord(id)));
Consider activeRecords be records.filter(record => record.active);

Print { loaded: records.length, active: activeRecords };
