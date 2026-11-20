// Tutorial 10: combine conditions and iteration.
Use deal/core;
Consider scores be [92, 67, 81, 49, 75, 100];
Consider results be [];

For each score in scores,
    If score >= 90,
        Append results, { score: score, grade: "A" };
    Else if score >= 75,
        Append results, { score: score, grade: "B" };
    Else if score >= 60,
        Append results, { score: score, grade: "C" };
    Otherwise,
        Append results, { score: score, grade: "D" };

print results;
