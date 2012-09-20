#!/usr/bin/env python

import sys

if __name__ == '__main__':
    # A summing reducer.
    last_k = None
    summed_v = None
    for line in sys.stdin:
        (k, v) = line.rstrip('\n').rsplit('\t', 1)
        if k != last_k:
            if last_k is not None:
                print last_k + '\t' + str(summed_v)
            last_k = k
            summed_v = int(v)
        else:
            summed_v += int(v)
    if last_k is not None:
        print last_k + '\t' + str(summed_v)