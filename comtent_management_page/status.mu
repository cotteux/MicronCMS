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

# Alternative path
PATH = None

# Browser pages cache time in seconds.
CACHE_TIME = 0 #0=No cache, None=Default

# Date/time format for formatting on the screen.
DATE_TIME_FORMAT = "%Y-%m-%d %H:%M:%S"

# Screen template - Main
TEMPLATE_MAIN = """
>Reticulum Status

Latest Update: {date_time}
{entrys}

`c`[Home`:/page/index.mu]`
"""


##############################################################################################################
# Include

import os
import time
import subprocess
import platform
from datetime import datetime

def get_size(bytes, suffix="B"):
    """
    Scale bytes to its proper format
    e.g:
        1253656 => '1.20MB'
        1253656678 => '1.17GB'
    """
    factor = 1024
    for unit in ["", "K", "M", "G", "T", "P"]:
        if bytes < factor:
            return f"{bytes:.2f}{unit}{suffix}"
        bytes /= factor


##############################################################################################################
# Globals  - System (Not changeable)


FILE = os.path.splitext(os.path.basename(__file__))[0]

if PATH == None:
    PATH = os.path.expanduser("~")+"/."+FILE


##############################################################################################################
# Program


if CACHE_TIME != None:
    print("#!c="+str(CACHE_TIME))


if DEBUG:
    print(os.environ)

print(">System Information")
uname = platform.uname()
print(f"System: {uname.system}")
print(f"Node Name: {uname.node}")
print(f"Release: {uname.release}")
print(f"Version: {uname.version}")
print(f"Machine: {uname.machine}")

tpl = TEMPLATE_MAIN
tpl = tpl.replace("{self}", FILE)
tpl = tpl.replace("{date_time}", time.strftime(DATE_TIME_FORMAT, time.localtime(time.time())))
tpl = tpl.replace("{entrys}", subprocess.getoutput("rnstatus").strip())
print(tpl)
print('>')
print('`a')
