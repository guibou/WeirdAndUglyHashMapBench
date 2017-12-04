#!/usr/bin/env python
import sys

def key(v):
    return bytes(sorted(v))

d = {}
with open(sys.argv[1], 'rb') as f:
    for line in f:
        l = line.rstrip()
        d.setdefault(key(l), []).append(l)

# lookup
for test in sys.argv[2:]:
    print(test,":",d.get(key(test.encode('utf8')), None))
