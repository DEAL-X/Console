using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using MiMFa.Engine.Put;

namespace MiMFa.Engine.DEAL.Console
{
    public static class SampleRegressionTests
    {
        private static readonly HashSet<string> ExecutableSamples = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "practicals/Compare.djs",
            "practicals/File.djs",
            "practicals/Folder.djs",
            "practicals/Interop-File.djs",
            "practicals/Research-Catalog-Processing.djs",
            "practicals/Collection-Processing.djs",
            "practicals/Jsonl-File-Workflow.djs",
            "tutorials/1/01-Getting-Started.djs",
            "tutorials/3/03-Commands.djs",
            "tutorials/4/04-CLR-Object-Interop.djs",
            "tutorials/4/04-DotNet-Interop.djs",
            "tutorials/5/05-Functions-and-Commands.djs",
            "tutorials/6/06-Selection-and-Collections.djs"
        };

        public static int RunResourceInterop()
        {
            var failures = new List<string>();
            TextWriter originalOutput = System.Console.Out;
            System.Console.SetOut(TextWriter.Null);
            Program.DisplayMode = 0;
            try
            {
                RunResourceInteropSmokeTest(
                    Path.Combine(Directory.GetCurrentDirectory(), "Test", "runtimes", "Resource-Interop-Smoke-Test.js"),
                    failures
                );
                RunFileModuleInteropSmokeTest(
                    Path.Combine(Directory.GetCurrentDirectory(), "Test", "runtimes", "File-Module-Interop-Smoke-Test.djs"),
                    failures
                );
            }
            finally
            {
                System.Console.SetOut(originalOutput);
            }

            if (failures.Count == 0)
            {
                System.Console.WriteLine("Direct ClearScript resource interop passed.");
                return 0;
            }

            foreach (string failure in failures)
                System.Console.Error.WriteLine("FAIL " + failure);
            return 1;
        }

        public static int Run()
        {
            string root = Directory.GetCurrentDirectory();
            string sampleRoot = Path.Combine(root, "Sample");
            var failures = new List<string>();
            var samples = Directory.Exists(sampleRoot)
                ? Directory.GetFiles(sampleRoot, "*.djs", SearchOption.AllDirectories).OrderBy(path => path, StringComparer.OrdinalIgnoreCase).ToArray()
                : Array.Empty<string>();

            if (samples.Length == 0)
            {
                System.Console.Error.WriteLine("No sample .djs files were found under: " + sampleRoot);
                return 1;
            }

            TextReader originalInput = System.Console.In;
            TextWriter originalOutput = System.Console.Out;
            System.Console.SetOut(TextWriter.Null);
            Program.DisplayMode = 0;

            try
            {
                foreach (string path in samples)
                {
                    string relative = Path.GetRelativePath(sampleRoot, path).Replace('\\', '/');
                    bool execute = ExecutableSamples.Contains(relative);
                    bool needsEmptyPrompt = relative.Equals("practicals/File.djs", StringComparison.OrdinalIgnoreCase);
                    System.Console.SetIn(new StringReader(needsEmptyPrompt ? Environment.NewLine : string.Empty));

                    bool initialized = false;
                    try
                    {
                        Program.Initial();
                        initialized = true;

                        var startupErrors = Program.Engine.Errors.Select(error => error.ToString()).ToArray();
                        if (startupErrors.Length > 0)
                        {
                            failures.Add(relative + " [startup]: " + string.Join(" | ", startupErrors));
                            continue;
                        }

                        var input = new Input(File.ReadAllText(path), Path.GetFullPath(path));
                        int errorsBeforeCompilation = Program.Engine.Errors.Count();
                        var output = Program.Engine.Compile(input);
                        var compileLogErrors = Program.Engine.Errors.Skip(errorsBeforeCompilation)
                            .Select(error => error.ToString()).ToArray();
                        if (output.Errors.Count > 0 || compileLogErrors.Length > 0)
                        {
                            var details = compileLogErrors.Concat(output.Errors).ToArray();
                            failures.Add(relative + " [compile]: " + string.Join(" | ", details));
                            continue;
                        }

                        if (!execute)
                            continue;

                        int errorsBeforeExecution = Program.Engine.Errors.Count();
                        Program.Engine.Execute(output);
                        var runtimeErrors = Program.Engine.Errors.Skip(errorsBeforeExecution)
                            .Select(error => error.ToString()).ToArray();
                        if (runtimeErrors.Length > 0 || output.Errors.Count > 0)
                        {
                            var details = runtimeErrors.Concat(output.Errors).ToArray();
                            failures.Add(relative + " [execute]: " + string.Join(" | ", details));
                        }
                    }
                    catch (Exception exception)
                    {
                        failures.Add(relative + " [exception]: " + exception);
                    }
                    finally
                    {
                        if (initialized)
                        {
                            try { Program.Final(); }
                            catch (Exception exception) { failures.Add(relative + " [shutdown]: " + exception.Message); }
                        }
                    }
                }

                RunResourceInteropSmokeTest(
                    Path.Combine(root, "Test", "runtimes", "Resource-Interop-Smoke-Test.js"),
                    failures
                );
            }
            finally
            {
                System.Console.SetIn(originalInput);
                System.Console.SetOut(originalOutput);
            }

            System.Console.WriteLine("Sample compatibility: " + samples.Length + " samples checked; " + failures.Count + " total failures.");
            if (failures.Count == 0)
            {
                System.Console.WriteLine("All sample compilation and selected runtime checks passed.");
                return 0;
            }

            foreach (string failure in failures)
                System.Console.Error.WriteLine("FAIL " + failure);
            return 1;
        }

        private static void RunFileModuleInteropSmokeTest(string path, List<string> failures)
        {
            bool initialized = false;
            try
            {
                Program.Initial();
                initialized = true;

                string engineRoot = Path.Combine(Directory.GetCurrentDirectory(), "MiMFa DEAL.JS - Engine");
                if (Directory.Exists(engineRoot))
                    Program.Engine.Resource.CurrentDirectory = engineRoot;

                var startupErrors = Program.Engine.Errors.Select(error => error.ToString()).ToArray();
                if (startupErrors.Length > 0)
                {
                    failures.Add(Path.GetFileName(path) + " [startup]: " + string.Join(" | ", startupErrors));
                    return;
                }

                var input = new Input(File.ReadAllText(path), Path.GetFullPath(path));
                int errorsBeforeCompilation = Program.Engine.Errors.Count();
                var output = Program.Engine.Compile(input);
                var compileLogErrors = Program.Engine.Errors.Skip(errorsBeforeCompilation)
                    .Select(error => error.ToString()).ToArray();
                if (output.Errors.Count > 0 || compileLogErrors.Length > 0)
                {
                    var details = compileLogErrors.Concat(output.Errors).ToArray();
                    failures.Add(Path.GetFileName(path) + " [compile]: " + string.Join(" | ", details));
                    return;
                }

                int errorsBeforeExecution = Program.Engine.Errors.Count();
                Program.Engine.Execute(output);
                var runtimeErrors = Program.Engine.Errors.Skip(errorsBeforeExecution)
                    .Select(error => error.ToString()).ToArray();
                if (runtimeErrors.Length > 0)
                    failures.Add(Path.GetFileName(path) + " [execute]: " + string.Join(" | ", runtimeErrors));
            }
            catch (Exception exception)
            {
                failures.Add(Path.GetFileName(path) + " [exception]: " + exception);
            }
            finally
            {
                if (initialized)
                {
                    try { Program.Final(); }
                    catch (Exception exception) { failures.Add(Path.GetFileName(path) + " [shutdown]: " + exception.Message); }
                }
            }
        }

        private static void RunResourceInteropSmokeTest(string path, List<string> failures)
        {
            bool initialized = false;
            try
            {
                Program.Initial();
                initialized = true;

                var startupErrors = Program.Engine.Errors.Select(error => error.ToString()).ToArray();
                if (startupErrors.Length > 0)
                {
                    failures.Add(Path.GetFileName(path) + " [startup]: " + string.Join(" | ", startupErrors));
                    return;
                }

                Program.Interpreter.Evaluate(File.ReadAllText(path));
            }
            catch (Exception exception)
            {
                failures.Add(Path.GetFileName(path) + " [execute]: " + exception);
            }
            finally
            {
                if (initialized)
                {
                    try { Program.Final(); }
                    catch (Exception exception) { failures.Add(Path.GetFileName(path) + " [shutdown]: " + exception.Message); }
                }
            }
        }
    }
}
