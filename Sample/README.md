# DEAL.JS sample collection

The sample collection is organized by purpose:

- tutorials/ — a progressive, numbered path from language basics to browser, file, asynchronous, and collection operations.
- practicals/ — self-contained workflows built from realistic in-memory data and local files.
- fixtures/ — deterministic local resources used by examples and runtime checks.

## Interactive sample launchers

From the Console host, use one of these directories:

- Use Sample; — browse all tutorials and practicals.
- Use Sample/tutorials; — browse the numbered tutorial sequence.
- Use Sample/practicals; — browse practical workflows.

Each launcher lists the available source files with numbers. Enter a number, then choose whether to execute the selected sample. Choosing No compiles the source and prints the generated JavaScript without executing it.

## Tutorials

1. Getting started — variables, iteration, and declarative instructions.
2. Browser and Fetch — browser control and asynchronous Fetch/body consumption.
3. Commands — command-oriented iteration and formatted output.
4. Functions and commands — reusable JavaScript functions and DEAL command declarations.
5. Selection and collections — selecting object properties and matching collection values.
6. Async Fetch — awaiting HTTP responses and JSON bodies.
7. File and resources — create, append, and read local text files.
8. Strings and templates — interpolation, matching, and text transformation.
9. Objects and properties — object spread, property enumeration, and mapping.
10. Conditions and loops — branching and repeated operations.
11. Error handling — try/catch and validation failures.
12. Functions and callbacks — passing functions as values and composing transformations.
13. Async functions — promises, async functions, and Promise.all.
14. Array operations — map, filter, and reduce.

## Practical workflows

- Compare — compare text values using the Console host.
- File — append structured cart records, search them, and calculate totals interactively.
- Folder — inspect the included fixture directory and select matching paths.
- Research-Catalog-Processing — normalize, validate, deduplicate, and persist accepted/rejected records without live acquisition.
- Collection-Processing — filter, transform, select, and aggregate structured records.
- Jsonl-File-Workflow — round-trip JavaScript records through the File.fields property.
- Web-Scraping-1 — reuse one browser tab to collect page titles and heading markup.
- Web-Scraping-2 — collect a bounded number of search-result pages and persist unique records.
- Website-Collecting — fetch JSON from multiple endpoints.
- Api-Catalog-Collection — normalize a small public JSON API response and save a JSONL snapshot.
- Inventory-Report — calculate inventory value and identify items below reorder levels.
- Text-Analysis — normalize text and rank word frequencies.
- Validation-Pipeline — validate incoming records and separate accepted/rejected data.
- Task-Board — summarize work by status and priority.
- Nested-Data-Transformation — flatten nested data and calculate grouped totals.
- Json-Configuration — persist and restore a JSON configuration file.

## Host requirements

- Run samples from the Console application's working directory so deal/, Console/, and Sample/ paths resolve.
- Browser practicals require a working browser driver and an installed browser. Network examples require network access.
- File examples use the shared File and Local modules; their implementation calls application.Engine.Resource directly, and ordinary JavaScript values are passed to the targeted resource overloads without a separate conversion wrapper.
- The automated sample compatibility workflow compiles every .djs sample and runs focused runtime smoke tests for the resource and module interop boundaries. Browser and external-network scenarios are compile-checked only.
