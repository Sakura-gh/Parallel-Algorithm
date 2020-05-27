# coding: utf-8
#!/usr/bin/env python3

import sys

# no descending order
# cur_word = None
# cur_cnt = 0

# for line in sys.stdin:
#     word, cnt = line.strip().split()
#     cnt = int(cnt)
#     if cur_word == word:
#         cur_cnt += cnt
#     else:
#         if cur_word:
#             print("%s %d" % (cur_word, cur_cnt))
#         cur_word = word
#         cur_cnt = cnt

# if cur_word == word:
#     print("%s %d" % (cur_word, cur_cnt))

# descending order
# use a result map to store input (word,1)
result = {}
for line in sys.stdin:
    # remove spaces on both sides, and split line into items
    word, cnt = line.strip().split()
    # string cnt -> int cnt
    cnt = int(cnt)
    # if {word: cnt} exists, cnt++; else add {word, cnt}
    if word in result.keys():
        result[word] += cnt
    else:
        result[word] = cnt

# sort result in descending order
result = sorted(result.items(), key=lambda x: (-x[1], x[0]))
# print result
for item in result:
    print("%s %d" % (item[0], item[1]))
