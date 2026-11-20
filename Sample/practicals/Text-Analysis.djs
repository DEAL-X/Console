// Practical: normalize text and build a frequency table.
Use deal/core;
Consider source be "DEAL makes intent clear. Clear intent makes reliable programs.";
Consider words be source.toLowerCase().match(/[a-z]+/g) ?? [];
Consider frequencies be new Map();

For each word in words,
    frequencies.set(word, (frequencies.get(word) ?? 0) + 1);

Consider ranking be Array.from(frequencies.entries())
    .sort((left, right) => right[1] - left[1] || left[0].localeCompare(right[0]));

print {
    word_count: words.length,
    unique_words: frequencies.size,
    most_common: ranking.slice(0, 5)
};
