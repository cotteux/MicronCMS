#!/usr/bin/env python3
#^^^^ <--> Nomadnet specific to prevent page caching, may change if you like.
import random
import os
from os import environ

def is_win(player, opponent):
    # return true if player wins
    # r > s, s > p, p > r
    if (player == 'r' and opponent == 's') or (player == 's' and opponent == 'p') \
        or (player == 'p' and opponent == 'r'):
        return True

try:   #  Action is done and Result
    if os.environ['var_choix'] :
     user = os.environ['var_choix']
     computer = random.choice(['r','p','s'])
     if computer == 'r' : print ('I Choose Rock')
     if computer == 'p' : print ('I Choose Paper')
     if computer == 's' : print ('I Choose Scissor')
    if user == computer:
        print('It\'s a tie')
    else :
       if is_win(user, computer):
          print('You won!')
       else :
          print('You lost!')
    print('')
    print('`!`[<Replay>`:/page/Games/Rock-Paper-Scissor.mu`choix=]`! | `!`[<Home>`:/page/index.mu`page=Games]`!')
    print('`a')

except:    # the main page and the choice of actions
       print("Choose your option")
       print("")
       print('`!`[<Rock>`:/page/Games/Rock-Paper-Scissor.mu`choix=r]`! | `!`[<Paper>`:/page/Games/Rock-Paper-Scissor.mu`choix=p]`! | `!`[<Scissor>`:/page/Games/Rock-Paper-Scissor.mu`choix=s]`! ')
