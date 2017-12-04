# Simple benchmark for acronyms lookup

Benchmark acronyms lookup on a big database of words (~744K words).

```
nix-build && cd result; ./runBench.sh; cd ../
```

This bench has four implementations:

- A CPP one (using `std::vector`, `std::unordered_map` and `std::string`)
- An Haskell one (using `[t]`, `Data.HashMap.Strict.Map` and `ByteString`)
- Another Haskell one (using `[t]`, `Data.HashTabels.IO.HashTable` and `ByteString`)
- A python one (using `list`, `dict` and `bytes`)

The word dictionnary comes from http://wordlist.aspell.net/

# Implementation details

- The inner list of acronyms uses mutable memory efficient
  `std::vector` or `list` in python and C++, when it is linked list
  `[]` in Haskell, this is a bit unfair to Haskell, but persistant
  vector are slow, and I did not wanted to test with mutable ones.
- The container is an hashmap for all implementation. Haskell comes
  with two implementation, one with a persistant hashmap, the second
  with a mutable hashmap. Surprisingly, the mutable one is slower, I cannot explain it.
- I use byte strings in all implementation because the trick to
  recognise acronyms uses a `sort` on each word. In Haskell, there is no
  sort on `Data.Text` and using `String` is slow. So this design
  choice is here to help Haskell.

# Timing

This is a crappy benchmark, but well, that's interesting:

- CPP: 0.650s
- Haskell persistant: 2.300s
- Haskell mutable: 4.2s
- Python: 1.8s
