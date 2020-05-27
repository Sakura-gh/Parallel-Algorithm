#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

// compare by pair's value in descending order
int cmp(const pair<string, int>& x, const pair<string,int>& y)
{
    if (x.second > y.second)
        return 1;
    else if (x.second == y.second && x.first < y.first)
        return 1;
    else
        return 0;
}

int main()
{
    // use map to store the result sent by hadoop
    map<string, int> result;
    map<string, int>::iterator iter;
    // hadoop: (word, cnt) 
    string word,cnt;

    // read (word, cnt) sent by hadoop
    while(cin>>word>>cnt)
    {
        // if (word, ) in map, then cnt++
        auto iter=result.find(word);
        if(iter!=result.end())
            iter->second++;
        // else insert (word, 1) into map
        else
            result.insert(make_pair(word, 1));
    }

    // convert map to vector, and sort in descending order
    vector<pair<string, int>> final_result;
    for(auto _iter=result.begin(); _iter!=result.end(); _iter++)
    {
        final_result.push_back(make_pair(_iter->first, _iter->second));
    }
    sort(final_result.begin(), final_result.end(), cmp);
    
    // print result
    for(auto __iter=final_result.begin();__iter!=final_result.end();__iter++)
    {
        cout<< __iter->first<<" "<<__iter->second<<endl;
    }

    return 0;
}

