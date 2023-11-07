#!/usr/bin/env python3


##############################################################################################################
# Manual


# - Copy file to any subfolder or root folder of nomadnet pages.
# - Make the file executable with the command chmod +x <filename>
# - Rename the file as you want.
# - Modify the configuration section in this file according to your own needs. This can, but does not have to be changed.
# - Create a link to this file on the start page or another nomadnet page.
# - Open the page in nomandet client.


##############################################################################################################
# Configuration


# Debug mode (display of debug information).
DEBUG = False #True/False

# Browser pages cache time in seconds.
CACHE_TIME = 0 #0=No cache, None=Default

# Date/time format for formatting on the screen.
DATE_TIME_FORMAT = "%Y-%m-%d %H:%M:%S"

PAGES_EXT_ALLOW = []
PAGES_EXT_DENY = ["allowed"]

FILES_EXT_ALLOW = []
FILES_EXT_DENY = ["allowed"]

INDEX = "pages" #none=none/empty, pages=Index pages, files=Index files, both=Index pages/files

PAGES_INDEX_DEPTH = 0 #0=root, 255=all
FILES_INDEX_DEPTH = 0 #0=root, 255=all

# Screen template - Main
TEMPLATE_MAIN = """
{entrys}
"""

# Screen template - Pages
TEMPLATE_PAGES_HEADER = """>>Games Pages

"""

TEMPLATE_PAGES_ENTRY = """`[{name}`:{url}]`

"""

#TEMPLATE_PAGES_ENTRY = """`;0l;;{name};;;:{url};`"""

# Screen template - Files
TEMPLATE_FILES_HEADER = """
>>Date-Index
"""

TEMPLATE_FILES_ENTRY = """`[{name}`:{url}]`
"""

#TEMPLATE_FILES_ENTRY = """`;0l;;{name};;;:{url};`"""


##############################################################################################################
# Include


#### System ####
import os
import time


##############################################################################################################
# Globals  - System (Not changeable)


FILE = os.path.splitext(os.path.basename(__file__))[0]

PAGES_PATH = os.path.dirname(__file__)+"/Games"
FILES_PATH = PAGES_PATH[:PAGES_PATH.rfind('/')]+"/Games"

##############################################################################################################
# Functions


def pages_scan(base_path):
    files = [file for file in os.listdir(base_path) if os.path.isfile(os.path.join(base_path, file)) and file[:1] != "."]
    directories = [file for file in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, file)) and file[:1] != "."]

    for file in files:
        ext = os.path.splitext(file)[1][1:]
        if ext in PAGES_EXT_ALLOW or ext not in PAGES_EXT_DENY:
            file = base_path+"/"+file
            PAGES.append("/page/Games"+file.replace(PAGES_PATH, ""))

    for directory in directories:
        pages_scan(base_path+"/"+directory)


def pages_root_scan(base_path):
    files = [file for file in os.listdir(base_path) if os.path.isfile(os.path.join(base_path, file)) and file[:1] != "."]

    for file in files:
        ext = os.path.splitext(file)[1][1:]
        if ext in PAGES_EXT_ALLOW or ext not in PAGES_EXT_DENY:
            file = base_path+"/"+file
            PAGES.append("/page/Games"+file.replace(PAGES_PATH, ""))


def files_scan(base_path):
    files = [file for file in os.listdir(base_path) if os.path.isfile(os.path.join(base_path, file)) and file[:1] != "."]
    directories = [file for file in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, file)) and file[:1] != "."]

    for file in files:
        ext = os.path.splitext(file)[1][1:]
        if ext in FILES_EXT_ALLOW or ext not in FILES_EXT_DENY:
            file = base_path+"/"+file
            FILES.append("/file"+file.replace(FILES_PATH, ""))

    for directory in directories:
        files_scan(base_path+"/"+directory)


def files_root_scan(base_path):
    files = [file for file in os.listdir(base_path) if os.path.isfile(os.path.join(base_path, file)) and file[:1] != "."]

    for file in files:
        ext = os.path.splitext(file)[1][1:]
        if ext in FILES_EXT_ALLOW or ext not in FILES_EXT_DENY:
            file = base_path+"/"+file
            FILES.append("/file"+file.replace(FILES_PATH, ""))


##############################################################################################################
# Program


#print (PAGES_PATH)
if CACHE_TIME != None:
    print("#!c="+str(CACHE_TIME))


if DEBUG:
    print(os.environ)


entrys = ""


if INDEX == "pages":
    PAGES = []
    if PAGES_INDEX_DEPTH > 1:
        pages_scan(PAGES_PATH)
    else:
        pages_root_scan(PAGES_PATH)
    PAGES.sort()
    entrys += TEMPLATE_PAGES_HEADER
    for page in PAGES:
        entrys_add = TEMPLATE_PAGES_ENTRY
        removemu = page.replace(".mu","",1) 
        entrys_add = entrys_add.replace("{name}", removemu.replace("/page/Games/", "", 1))
        entrys_add = entrys_add.replace("{url}", page)
        entrys += entrys_add


elif INDEX == "files":
    FILES = []
    if FILES_INDEX_DEPTH > 1:
        files_scan(FILES_PATH)
    else:
        files_root_scan(FILES_PATH)
    FILES.sort()
    entrys += TEMPLATE_FILES_HEADER
    for file in FILES:
        entrys_add = TEMPLATE_FILES_ENTRY
        entrys_add = entrys_add.replace("{name}", file.replace("/file/", "", 1))
        entrys_add = entrys_add.replace("{url}", file)
        entrys += entrys_add


elif INDEX == "both":
    PAGES = []
    if PAGES_INDEX_DEPTH > 1:
        pages_scan(PAGES_PATH)
    else:
        pages_root_scan(PAGES_PATH)
    PAGES.sort()
    entrys += TEMPLATE_PAGES_HEADER
    for page in PAGES:
        entrys_add = TEMPLATE_PAGES_ENTRY
        entrys_add = entrys_add.replace("{name}", page.replace("/page/", "", 1))
        entrys_add = entrys_add.replace("{url}", page)
        entrys += entrys_add+"\n"

    FILES = []
    if FILES_INDEX_DEPTH > 1:
        files_scan(FILES_PATH)
    else:
        files_root_scan(FILES_PATH)
    FILES.sort()
    entrys += TEMPLATE_FILES_HEADER
    for file in FILES:
        entrys_add = TEMPLATE_FILES_ENTRY
        entrys_add = entrys_add.replace("{name}", file.replace("/file/", "", 1))
        entrys_add = entrys_add.replace("{url}", file)
        entrys += entrys_add+"\n"


tpl = TEMPLATE_MAIN
tpl = tpl.replace("{self}", FILE)
tpl = tpl.replace("{date_time}", time.strftime(DATE_TIME_FORMAT, time.localtime(time.time())))
tpl = tpl.replace("{entrys}", entrys)
print(tpl)
