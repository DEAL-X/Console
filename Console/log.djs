use deal/data/log;

// Ensure the Log namespace exists before extending it in the Console host.
globalThis.Log = globalThis.Log || {};

command Log.display (title = null, message = null) => writeLine(Log.message(title, message));
command Log.subject (message = null) => Log.display(message, "");
command Log.error (message = null) => Log.display("Error", message);
command Log.success (message = null) => Log.display("Success", message);
command Log.warn (message = null) => Log.display("Warning", message);
command Log.info (message = null) => Log.display(null, message);