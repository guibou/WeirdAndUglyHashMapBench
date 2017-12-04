#include <unordered_map>
#include <iostream>
#include <iostream>
#include <fstream>
#include <cassert>
#include <vector>
#include <algorithm>

std::string key(std::string v)
{
	std::sort(std::begin(v), std::end(v));
	return v;
}

int main(int argc, char**argv)
{
	assert(argc >= 2);
	std::ifstream f(argv[1]);
	assert(f.good());

	std::string word;

	std::unordered_map<std::string, std::vector<std::string>> acronyms;

	while(std::getline(f, word))
	{
		acronyms[key(word)].push_back(word);
	}

	// lookup
	for(auto i = 2; i < argc; ++i)
	{
		const std::string test(argv[i]);
		std::cout << test << ": ";

		// C++ is fun, it will create an empty vector on missed
		// query. Yes, the data structures grows linearly with the
		// number of queries ;)
		for(auto &&v : acronyms[key(test)])
		{
			std::cout << v << ", ";
		}
		std::cout << "\n";
	}

	return 0;
}
