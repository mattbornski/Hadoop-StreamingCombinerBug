#!/usr/bin/env python

import sys

if __name__ == '__main__':
    # A no-op combiner.
    for line in sys.stdin:
        print line.rstrip('\n')