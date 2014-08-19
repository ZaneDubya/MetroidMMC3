using System.Collections.Generic;
using System.IO;

namespace GetLabels
{
    class FileParser
    {
        private int m_LineIndex = 0;
        private List<string> m_Lines;
        public List<string> Lines { get { return m_Lines; } }

        public int Index
        {
            get
            {
                return m_LineIndex;
            }
            set
            {
                m_LineIndex = value;
            }
        }

        public string this[int index]
        {
            get
            {
                return m_Lines[index].ToString();
            }
        }

        public bool EOF
        {
            get
            {
                return m_LineIndex >= m_Lines.Count;
            }
        }

        public string ReadLine()
        {
            return m_Lines[m_LineIndex++].ToString();
        }

        public FileParser(string path)
        {
            m_Lines = new List<string>();
            readFile(path);
        }

        private void readFile(string path)
        {
            string line;
            StreamReader file = new StreamReader(path);
            while ((line = file.ReadLine()) != null)
            {
                m_Lines.Add(line);
            }
            file.Close();
        }
    }
}
