#!/usr/bin/env sh

echo ""
echo "# CPP"
echo ""
time ./acronyms_cpp ./words.txt dog rat chair
echo ""
echo "Haskell (Data.HashMap)"
echo ""
time ./acronyms_hs ./words.txt dog rat chair
echo ""
echo "Haskell (Data.HashTables [Mutable])"
echo ""
time ./acronym_mutable_hs ./words.txt dog rat chair
echo ""
echo "Python"
echo ""
time ./acronyms_python ./words.txt dog rat chair
