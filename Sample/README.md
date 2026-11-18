# DEAL.JS sample collection

The samples are organized by purpose:

- [tutorials/](tutorials/) — progressive examples covering language fundamentals, commands, collections, browser control, Fetch, and CLR interoperability.
- [practicals/](practicals/) — complete workflows for comparison, file and folder operations, structured-data processing, JSONL persistence, CLR interop, web scraping, and API collection.
- [fixtures/](fixtures/) — deterministic local files used by practicals and automated runtime checks.

## Tutorials

1. **Getting started** — variables, iteration, and declarative instructions.
2. **Browser and Fetch** — synchronous BrowserTab operations and asynchronous Fetch/body consumption.
3. **Commands** — command-oriented iteration and formatted output.
4. **CLR interoperability** — JavaScript-to-.NET arrays, collections, dictionaries, and objects.
5. **Functions and commands** — reusable JavaScript functions and DEAL command declarations.
6. **Selection and collections** — selecting object properties and matching collection values.
7. **Async Fetch** — awaiting HTTP responses and JSON bodies.

## Practical workflows

- **Compare** — compare text values using the Console host.
- **File** — append structured cart records, search them, and calculate totals interactively.
- **Folder** — inspect the included fixture directory and select matching paths.
- **Interop-File** — write and read JSONL records and UTF-8 text through CLR resource APIs.
- **Research-Catalog-Processing** — normalize, validate, deduplicate, and persist accepted/rejected records without live acquisition.
- **Collection-Processing** — filter, transform, select, and aggregate structured records.
- **Jsonl-File-Workflow** — round-trip JavaScript records through the File.fields property.
- **Web-Scraping-1** — reuse one browser tab to collect page titles and heading markup.
- **Web-Scraping-2** — collect a bounded number of search-result pages and persist unique records.
- **Website-Collecting** — fetch JSON from multiple endpoints.
- **Api-Catalog-Collection** — normalize a small public JSON API response and save a JSONL snapshot.

## Host requirements and execution notes

- Run the samples from the Console application's working directory so the deal/, Console/, Sample/, and fixture paths resolve.
- The Console host exposes ClearScript ExtendedHostFunctions as the global host object, which is required by deal/make/object.
- Use deal/web; loads the browser, Fetch, navigation, and shared Fetch compatibility modules. Browser practicals require an installed Chrome executable and a working browser session.
- Fetch-based samples require network access. They are compiled by the automated suite but are not run against live services.
- File.fields is a property: assign records with file.fields = records and enumerate them with for each record of file.fields.
- The sample compatibility workflow compiles every .djs sample and executes the deterministic local scenarios. Browser and external-network scenarios are compile-checked only.
