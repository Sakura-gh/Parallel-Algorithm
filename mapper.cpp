#include <iostream>
#include <string>
#include <regex>

using namespace std;

int main()
{
    // use regex to match english word
    regex re("([A-Za-z]*)");
    smatch result;
    string word;
    // read word separated by space
    while (cin >> word)
    {
        // match word with regex
        regex_search(word, result, re);
        if (result[0] != "")
            // output map (word, 1) for hadoop
            cout << result[0] << "\t"
                 << "1" << endl;
    }
    return 0;
}