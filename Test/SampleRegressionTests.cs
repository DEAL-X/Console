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
                        var output = Program.Engine.Compile(input);
                        if (output.Errors.Count > 0)
                        {
                            failures.Add(relative + " [compile]: " + string.Join(" | ", output.Errors));
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
            }
            finally
            {
                System.Console.SetIn(originalInput);
                System.Console.SetOut(originalOutput);
            }

            System.Console.WriteLine("Sample compatibility: " + (samples.Length - failures.Count) + "/" + samples.Length + " passed.");
            if (failures.Count == 0)
            {
                System.Console.WriteLine("All sample compilation and selected runtime checks passed.");
                return 0;
            }

            foreach (string failure in failures)
                System.Console.Error.WriteLine("FAIL " + failure);
            return 1;
        }
    }
}
