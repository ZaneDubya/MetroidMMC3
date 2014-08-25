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
            int address_start, address_end;

            if (ReadArgs(args, out path_in, out path_out, out address_start, out address_end))
            {
                DoFile(path_in, path_out, address_start, address_end);
            }
        }

        static bool DoFile(string path_in, string path_out, int address_start, int address_end)
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

                    int address_decimal;
                    string address_hex_string = tokens[0].Substring(1);

                    if (!(HexParse(address_hex_string, out address_decimal)))
                        continue;
                    if (address_decimal <= address_start)
                        continue;
                    if (address_decimal >= address_end)
                        continue;

                    outlines.Add(string.Format(".alias {0} ${1}", tokens[1], address_hex_string));
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

        static bool HexParse(string input, out int hex)
        {
            try
            {
                hex = int.Parse(input, System.Globalization.NumberStyles.HexNumber);
                return true;
            }
            catch
            {
                hex = 0x0000;
                return false;
            }
        }

        static bool ReadArgs(string[] args, out string path_in, out string path_out, out int address_start, out int address_end)
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
                address_start = 0x8000;
                address_end = 0xFFFF;

                if (args.Length == 3)
                {
                    if (!HexParse(args[2], out address_start))
                        Console.WriteLine(string.Format(msg_error_address, "starting"));
                    address_end = 0xFFFF;
                }
                else if (args.Length == 4)
                {
                    if (!HexParse(args[2], out address_start))
                        Console.WriteLine(string.Format(msg_error_address, "starting"));
                    if (!HexParse(args[3], out address_end))
                        Console.WriteLine(string.Format(msg_error_address, "ending"));
                }

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

                return true;
            }

            path_in = null;
            path_out = null;
            address_start = 0x0000;
            address_end = 0x0000;
            return false;
        }

        public static bool Option_Ophis = false;

        static string msg_usage = "Usage: getlabels srcfile outfile [options]";
        static string msg_error_file = "Error: no {0} file specified.";
        static string msg_error_doesnotexist = "Error: {0} does not exist.";
        static string msg_error_no_outputfilename = "Error: output has no filename.";
        static string msg_error_address = "Error: input {0} address is not a valid format.";

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
