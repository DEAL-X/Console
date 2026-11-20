# Compiler and runtime tests

- inputs/ contains DEAL/JavaScript stress-test source files.
- expects/ contains the expected JavaScript output for compiler comparisons.
- outputs/ contains manually captured compiler output snapshots.
- runtimes/ contains focused smoke tests for browser drivers, the browser object model, native web integration, and direct JavaScript-to-.NET resource method binding.

## How to use

```deal
use console;
use test;

test "Test-File-Name-Without-Extension";
```

The test helper compiles an input from Test/inputs/, writes the result to Test/outputs/, and can open the generated file for inspection. Use Test.compare(name) to compare it with the matching file in Test/expects/.

## Runtime smoke tests

- Browser-Driver-Smoke-Test.js — run separately with ChromeDriver, EdgeDriver, and FirefoxDriver. It covers tab creation, navigation, activation, closing, and current-tab resolution without relying on an external website.
- Browser-Object-Model-Smoke-Test.js — exercises browser object proxies and Chromium-specific optional file-picker checks.
- Native-Web-Smoke-Test.js — exercises Fetch, local-file requests, browser navigation, abort handling, and request-body lifecycle.
- Resource-Interop-Smoke-Test.js and File-Module-Interop-Smoke-Test.djs — verify direct JavaScript array binding to the targeted resource APIs with ClearScript array conversion enabled, and verify sibling module loading from a directory import.

## Compiler stress tests

For each stress test, compare generated JavaScript from inputs/ with the corresponding file in expects/. The outputs/ directory contains captured outputs and is intentionally separate from the expected snapshots.
