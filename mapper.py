# coding: utf-8
#!/usr/bin/env python3

import sys
import re

for line in sys.stdin:
    '''
    get input from stdin, read line each time
    if the word appears, output map: (word, 1)
    '''
    if line == None:
        continue
    # use Re to remove special symbols
    r = '''[0-9'!"#$%&\'()*+,-./:;<=>?@，。?★、…【】《》？“”‘'！[\\]^_`{|}~]+'''
    line = re.sub(r, '', line)
    # remove spaces on both sides, and split line into items
    words = line.strip().split()
    # for every item: print (word, 1) for hadoop
    for word in words:
        if word:
            print("%s %d" % (word, 1))
