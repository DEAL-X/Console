// Practical: write structured records to JSON Lines and read them back.
// HOW TO USE:
// Use Sample/practicals/Jsonl-File-Workflow;

Use deal/core;
Use deal/data/file;
Use console;

Consider records be [
    { id: 1, name: "Ada", active: true },
    { id: 2, name: "Grace", active: false },
    { id: 3, name: "Edsger", active: true }
];

Consider file be File(Temporary.path("deal-jsonl-workflow.jsonl"));
file.fields = records;

Consider restored be Array.from(file.fields);
Consider activeRecords be restored.filter(record => record.active);

Print {
    written: records.length,
    restored: restored.length,
    active: activeRecords.map(record => record.name)
};
