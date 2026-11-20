# Compiler and runtime tests

- `inputs/` contains DEAL/JavaScript stress-test source files.
- `outputs/` contains captured compiler result snapshots.
- `expects/` contains the expected JavaScript output for each stress test.
- `runtimes/` contains executable smoke tests for browser drivers, the browser object model, native web integration, and direct JavaScript-to-.NET resource interop.

## How to use

```deal
use console;
use test;

test "Test-File-Name-Without-Extension";
// or
// save(path be (local path `./Tests/outputs/${name}.js`), compile `./Tests/inputs/${name}.djs`) then start openResultsApp by path;
```

## Runtime smoke tests

- `Browser-Driver-Smoke-Test.js` — run separately with ChromeDriver, EdgeDriver, and FirefoxDriver. It covers tab creation, navigation, activation, closing, and current-tab resolution without relying on an external website.
- `Browser-Object-Model-Smoke-Test.js` — exercises browser object proxies and Chromium-specific optional file-picker checks.
- `Native-Web-Smoke-Test.js` — exercises Fetch, local-file requests, browser navigation, abort handling, and request-body lifecycle.
- `Resource-Interop-Smoke-Test.js` — verifies that ordinary JavaScript arrays (marshaled by ClearScript as `object[]`) bind through the targeted generic array adapters to the resource methods' `IEnumerable<string>` implementations and to the existing `byte[]` API with ClearScript array conversion enabled.
## Compiler stress tests

For each stress test, compare the generated JavaScript from `inputs/` with the corresponding file in `expects/`. The `outputs/` copy records output captured from the implementation when it was saved. These files are kept separate so differences are easy to inspect.

- `Hierarchical-Keyword-Spelling.djs` — regression fixture for the three equivalent spellings `make StRing`, `make .StRing`, and `make.StRing`. Each expression must compile to exactly `Make.string`; the three corresponding lines in `expected/Hierarchical-Keyword-Spelling.expected.js` are the individual expected-output assertions.
