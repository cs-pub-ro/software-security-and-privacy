#!/usr/bin/python3

#########################################
# This file showcases the use of pexpect
# for writing shell-interactive programs.
#########################################

import pexpect
import re
import string

# We call the target program, as you would do in bash
proc = pexpect.spawn("./sidechannel.py")

articles_file = open("./dict/articles")
adjectives_file = open("./dict/adjectives")
nouns_file = open("./dict/nouns")

max_time = 0
solution = ''

for art in articles_file:
    for adj in adjectives_file:
        for noun in nouns_file:
            # Expect-like statements probe the program's output.
            ## Expect_exact looks for an exact occurence of a string.
            proc.expect_exact(">> Password: ")

            # We can send input via sendline.
            current_string = art.strip() + ' ' + adj.strip() + ' ' + noun.strip()
            proc.sendline("{}".format(current_string))

            # Get response.
            res = proc.readline()
            res = proc.readline()

            ## Get time.
            t = res.split('['.encode('utf-8'))[1].split(']'.encode('utf-8'))[0]
            time = int(t)

            # Let's see what we got.
            print("Password '{}' takes {}".format(current_string, time))

            if time > max_time:
                max_time = time
                solution = current_string

print('Solution is:')
print(solution)
