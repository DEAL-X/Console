using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using MiMFa.Engine.Put;
using MiMFa.Core.Resources;
using MiMFa.Net.Browsers.Drivers;
using MiMFa.Net.Browsers.Services;
using System.Text;

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


        public static int RunClrInteropOnly()
        {
            string root = Directory.GetCurrentDirectory();
            var failures = new List<string>();
            TextReader originalInput = System.Console.In;
            TextWriter originalOutput = System.Console.Out;
            System.Console.SetOut(TextWriter.Null);
            Program.DisplayMode = 0;

            try
            {
                RunClrSmokeTest(
                    Path.Combine(root, "Test", "runtimes", "CLR-Object-Interop-Smoke-Test.js"),
                    true,
                    failures
                );
                RunClrSmokeTest(
                    Path.Combine(root, "Test", "runtimes", "Clr-Interop-Smoke-Test.js"),
                    false,
                    failures
                );
                RunInteropOverloadShapeTests(failures);
            }
            finally
            {
                System.Console.SetIn(originalInput);
                System.Console.SetOut(originalOutput);
            }

            System.Console.WriteLine("CLR interop regression: " + (failures.Count == 0 ? "passed" : failures.Count + " failure(s)."));
            foreach (string failure in failures)
                System.Console.Error.WriteLine("FAIL " + failure);
            return failures.Count == 0 ? 0 : 1;
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

                RunClrSmokeTest(
                    Path.Combine(root, "Test", "runtimes", "CLR-Object-Interop-Smoke-Test.js"),
                    true,
                    failures
                );
                RunClrSmokeTest(
                    Path.Combine(root, "Test", "runtimes", "Clr-Interop-Smoke-Test.js"),
                    false,
                    failures
                );
                RunInteropOverloadShapeTests(failures);
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

        private static void RunInteropOverloadShapeTests(List<string> failures)
        {
            RequireOverload(typeof(ResourceBase), "Combine", new[] { typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "SetFolderContents", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "SetFileContents", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "SetFileLines", new[] { typeof(string), typeof(object), typeof(Encoding) }, failures);
            RequireOverload(typeof(ResourceBase), "GetFileLines", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "GetFileText", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "SetFileText", new[] { typeof(string), typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "GetFileLine", new[] { typeof(string), typeof(int), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "SetFileLines", new[] { typeof(string), typeof(object), typeof(object) }, failures);
            RequireOverload(typeof(ResourceBase), "PrependFileLines", new[] { typeof(string), typeof(object), typeof(Encoding) }, failures);
            RequireOverload(typeof(ResourceBase), "AppendFileLines", new[] { typeof(string), typeof(object), typeof(Encoding) }, failures);
            RequireOverload(typeof(BrowserPermissions), "Grant", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(BrowserPermissions), "GrantAsync", new[] { typeof(string), typeof(object) }, failures);
            RequireOverload(typeof(FirefoxDriver), "SetArguments", new[] { typeof(object) }, failures);

            try
            {
                using (var driver = new FirefoxDriver())
                {
                    driver.SetArguments(new object[] { "--headless", "--private" });
                    if (!driver.Arguments.SequenceEqual(new[] { "--headless", "--private" }))
                        failures.Add("CLR interop overload shape [FirefoxDriver.SetArguments]: object[] values were not converted to strings.");
                }
            }
            catch (Exception exception)
            {
                failures.Add("CLR interop overload shape [FirefoxDriver.SetArguments]: " + exception.Message);
            }
        }

        private static void RequireOverload(Type declaringType, string methodName, Type[] parameterTypes, List<string> failures)
        {
            if (declaringType.GetMethod(methodName, parameterTypes) == null)
                failures.Add("CLR interop overload shape: missing " + declaringType.FullName + "." + methodName + "(" +
                    string.Join(", ", parameterTypes.Select(type => type.Name)) + ").");
        }

        private static void RunClrSmokeTest(string path, bool invokeFunction, List<string> failures)
        {
            string name = Path.GetFileName(path);
            bool initialized = false;
            try
            {
                Program.Initial();
                initialized = true;

                var startupErrors = Program.Engine.Errors.Select(error => error.ToString()).ToArray();
                if (startupErrors.Length > 0)
                {
                    failures.Add(name + " [startup]: " + string.Join(" | ", startupErrors));
                    return;
                }

                int setupErrorsBefore = Program.Engine.Errors.Count();
                // Load the package entry so the Make namespace is declared before its submodules.
                Program.Engine.Execute("Use deal/make;");
                var setupErrors = Program.Engine.Errors.Skip(setupErrorsBefore)
                    .Select(error => error.ToString()).ToArray();
                if (setupErrors.Length > 0)
                {
                    failures.Add(name + " [module setup]: " + string.Join(" | ", setupErrors));
                    return;
                }

                string script = File.ReadAllText(path);
                if (invokeFunction)
                    script += Environment.NewLine + "clrObjectInteropSmokeTest(application);";
                Program.Interpreter.Evaluate(script);
            }
            catch (Exception exception)
            {
                failures.Add(name + " [execute]: " + exception);
            }
            finally
            {
                if (initialized)
                {
                    try { Program.Final(); }
                    catch (Exception exception) { failures.Add(name + " [shutdown]: " + exception.Message); }
                }
            }
        }
    }
}
