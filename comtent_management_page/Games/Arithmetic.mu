#!/usr/bin/env python3
# ^^^^ <--> Nomadnet specific to prevent page caching, may change if you like.

import random
import os
from os import environ

if   environ.get("field_user_input") is None :
	number1 = random.randint(1,30)
	number2 = random.randint(1,30)
	resultat= str(number1+number2)
	print('Answer this '+str(number1)+'+'+str(number2)+'=`B444`<3|user_input`>`b')
	print('`!`B444`[Submit`:/page/Games/Arithmetic.mu`user_input|resultat='+resultat+']`b`!')
else :
	print("Result")
	if os.environ['field_user_input']== os.environ['var_resultat']: 
   	    print('Yeahhhh, good answer')
	else :
   	    print("Loser , the result is "+os.environ['var_resultat'])
	print  ('`!`[<Replay>`:/page/Games/Arithmetic.mu`user_input=|resultat=]`! | `!`[<Home>`:/page/index.mu`page=Games|user_input=|resultat=]`!')
