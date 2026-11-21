// Tutorial 08: work with strings, templates, and regular expressions.
Use deal/core;
Use console;

Consider firstName be "Ada";
Consider lastName be "Lovelace";
Consider fullName be firstName + " " + lastName;
Consider message be \`Welcome, \${fullName}. DEAL.JS turns intent into executable code.\`;
Consider words be message.match(/[A-Za-z.]+/g) || [];

Print {
    message: message,
    uppercase: fullName.toUpperCase(),
    contains_deal: /DEAL\.JS/.test(message),
    word_count: words.length
};
