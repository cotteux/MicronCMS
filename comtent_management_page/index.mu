#!/usr/bin/python3
#!c=0
# ^^^^ <--> Nomadnet specific to prevent page caching, may change if you like.

import os
from os import environ
import yaml
from datetime import datetime

###################################################
#        Path to config.yaml below:
config_path = '/home/cotteux/.nomadnetwork/storage/pages/config.yaml'
###################################################


config_file = open(config_path, 'r')
config = yaml.safe_load(config_file)


##for e in os.environ:
##    print(os.environ[e])
##    print(e)

time_now = datetime.now().strftime('%H:%M %B %d, %Y')

title = '```B' + str(config['site']['title_bar_rgb']) + '`=`!`c' + config['site']['title'] + '`! \n`=' + config['site']['title_sub_line'] + '\n`=``'

header = '''
-_
`c
''' + title + '''
`a
-¯'''

menu_items = ''

for p in config['pages']:
##    print(p)
    menu_items = menu_items + '`!`[<' + p + '>`:/page/index.mu`page=' + p + ']`! | '
    
menu = '''-_
`c` ''' + menu_items + ' `*Time: ' + time_now + '''`*
-¯
`a
'''

footer = '''
-_
`c`B''' + config['site']['footer_bar_rgb'] + config['site']['footer']


print(header)
print(menu)

try:
   if not os.environ['var_page'] or os.environ['var_page'] == 'Hom':

        with open(config['pages']['Home']['file']) as page_file: p = page_file.read()
        if   str(config['pages'][os.environ['var_page']]['type']) =='python' :

           with open(config['pages'][os.environ['var_page']]['file']) as page_file: p = page_file.read()
           exec(p)
        else :
           print(p)

   else:
        with open(config['pages'][os.environ['var_page']]['file']) as page_file: p = page_file.read()
        if   str(config['pages'][os.environ['var_page']]['type']) =='python' :

           with open(config['pages'][os.environ['var_page']]['file']) as page_file: p = page_file.read()
           exec(p)
        else :
           print(p)
except:
	if environ.get("var_page") is None :
           with open(config['pages']['Home']['file']) as page_file: p = page_file.read()
           print(p)

print(footer)

def subpage(player, opponent):
    # return true if player wins
    # r > s, s > p, p > r
    if (player == 'r' and opponent == 's') or (player == 's' and opponent == 'p') \
        or (player == 'p' and opponent == 'r'):
        return True
