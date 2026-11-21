// Practical: summarize a small task board by status and priority.
Use deal/core;
Use console;

Consider tasks be [
    { title: "Review parser", status: "done", priority: 1 },
    { title: "Write examples", status: "todo", priority: 2 },
    { title: "Fix tokenizer", status: "doing", priority: 1 },
    { title: "Update guide", status: "todo", priority: 3 },
    { title: "Run regression tests", status: "doing", priority: 1 }
];

Consider summary be tasks.reduce((result, task) => {
    result[task.status] = (result[task.status] || 0) + 1;
    return result;
}, {});
Consider urgent be tasks.filter(task =>
    task.priority === 1 && task.status !== "done"
);

print {
    total: tasks.length,
    by_status: summary,
    urgent_open: urgent
};
