using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace GetLabels
{
    class Program
    {
        static void Main(string[] args)
        {
            string path_in, path_out;

            if (ReadArgs(args, out path_in, out path_out))
            {
                if (Option_CopyAll)
                {
                    foreach (string dirPath in Directory.GetDirectories(path_in, "*", SearchOption.AllDirectories))
                        if (!dirPath.Contains(path_out))
                            Directory.CreateDirectory(dirPath.Replace(path_in, path_out));
                    foreach (string file_in in Directory.GetFiles(path_in, "*.asm", SearchOption.AllDirectories))
                    {
                        string file_out = file_in.Replace(path_in, path_out);
                        DoFile(file_in, file_out);
                    }
                }
                else
                {
                    DoFile(path_in, path_out);
                }
            }
            else
            {

            }
        }

        static bool DoFile(string path_in, string path_out)
        {
            FileParser reader = new FileParser(path_in);
            List<string> outlines = new List<string>();

            foreach (string line in reader.Lines)
            {
                string[] tokens = line.Split('|');
                for (int i = 0; i < tokens.Length; i++)
                    tokens[i] = tokens[i].Trim();

                if (tokens[0][0] == '$')
                {
                    if (tokens[1] == "*")
                        continue;

                    if (tokens[1][0] == 'l' && tokens[1].Length == 5 && OnlyHexInString(tokens[1].Substring(1)))
                        continue;

                    string hex_number = tokens[0].Substring(1);
                    int decimal_number = int.Parse(hex_number, System.Globalization.NumberStyles.HexNumber);
                    if (decimal_number < 0xC000)
                        continue;
                    outlines.Add(string.Format(".alias  {0}   ${1}", tokens[1], hex_number));
                }
            }

            bool success = true;

            if (success)
            {
                WriteFile(outlines, path_out);
                return true;
            }
            else
                return false;
        }

        static bool OnlyHexInString(string test)
        {
            // For C-style hex notation (0xFF) you can use @"\A\b(0[xX])?[0-9a-fA-F]+\b\Z"
            return System.Text.RegularExpressions.Regex.IsMatch(test, @"\A\b[0-9a-fA-F]+\b\Z");
        }



        static bool ReadArgs(string[] args, out string path_in, out string path_out)
        {
            if (args.Length == 0)
            {
                Console.WriteLine(msg_usage);
                Console.WriteLine(string.Format(msg_error_file, "input or output"));
            }
            else if (args.Length == 1)
            {
                Console.WriteLine(msg_usage);
                Console.WriteLine(string.Format(msg_error_file, "output"));
            }
            else // args length >= 2
            {
                path_in = args[0];
                path_out = args[1];

                if (Option_CopyAll)
                {
                    if (path_in == string.Empty)
                    {
                        path_in = Path.GetDirectoryName(System.Environment.CurrentDirectory);
                    }
                    if (!Directory.Exists(path_in))
                    {
                        Console.WriteLine(string.Format(msg_error_doesnotexist, string.Format("input directory '{0}'", path_in)));
                        return false;
                    }
                    else
                    {
                        path_in = Path.GetFullPath(path_in);
                    }

                    if (Directory.Exists(path_out))
                    {
                        Console.WriteLine("Error: output directory cannot exist if option -all is used.");
                        return false;
                    }
                    else
                    {
                        Directory.CreateDirectory(path_out);
                        path_out = Path.GetFullPath(path_out);
                    }
                }
                else
                {
                    if (!File.Exists(path_in))
                    {
                        Console.WriteLine(string.Format(msg_error_doesnotexist, "input file"));
                        return false;
                    }
                    path_out = Path.GetFullPath(path_out);
                    if (!Directory.Exists(Path.GetDirectoryName(path_out)))
                    {
                        Console.WriteLine(string.Format(msg_error_doesnotexist, "output directory"));
                        return false;
                    }
                    if (Path.GetFileName(path_out) == string.Empty)
                    {
                        Console.WriteLine(msg_error_no_outputfilename);
                        return false;
                    }
                }

                return true;
            }

            path_in = null;
            path_out = null;
            return false;
        }

        public static bool Option_Ophis = false;
        public static bool Option_CopyAll = false;

        static string msg_usage = "Usage: if6502 srcfile outfile [options]";
        static string msg_error_file = "Error: no {0} file specified.";
        static string msg_error_doesnotexist = "Error: {0} does not exist.";
        static string msg_error_no_outputfilename = "Error: output has no filename.";

        static void WriteFile(List<string> lines, string path)
        {
            using (StreamWriter file = new StreamWriter(path))
            {
                foreach (string line in lines)
                    file.WriteLine(line);
            }
        }

        static int tabCount(string line)
        {
            int whitespace = 0;
            foreach (char ch in line)
            {
                if (ch != '\t')
                    break;
                whitespace++;
            }
            return whitespace;
        }
    }
}
