use deal/data/log;

// Ensure the Log namespace exists before extending it in the Console host.
globalThis.Log = globalThis.Log || {};

command Log.display = function (title = null, message = null) => writeLine(Log.message(title, message));
command Log.subject = function (message = null) => Log.display(message, "");
command Log.error = function (message = null) => Log.display("Error", message);
command Log.success = function (message = null) => Log.display("Success", message);
command Log.warn = function (message = null) => Log.display("Warning", message);
command Log.info = function (message = null) => Log.display(null, message);