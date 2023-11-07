#!/usr/bin/env python3
#^^^^ <--> Nomadnet specific to prevent page caching, may change if you like.
import random 
import os
from os import environ

#env_string = ""
#for e in os.environ:
#  env_string += "{}={}\n".format(e, os.environ[e])
print('`B77Funder Construction `b')
print('')
#print(env_string)
choice=''
card=''
cards_list = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King'] 
player_card = []

def card_value(card): 
	if card in ['Jack', 'Queen', 'King']: 
		return 10
	elif card == 'Ace': 
		return 11
	else: 
		return int(card) 

if environ.get("var_choix") is None or environ.get('var_choix')=='' : 
	player_card = [random.choice(cards_list),random.choice(cards_list)] 
else :
	choice = os.environ['var_choix']
	card = os.environ['var_card']
	player_card = card.split('-',-1)
	if choice == "play": 
		player_card.append(random.choice(cards_list)) 

player_score = sum(card_value(card) for card in player_card) 
result = '-'.join(player_card) 
print("Cards Player Has:", player_card) 
print("Score Of The Player:", player_score) 
print("\n") 
print('What do you want? ["play" to request another card, "stop" to stop]:')
print('`!`[<Play>`:/page/Games/BlackJack.mu`choix=play|card='+result+']`! | `!`[<Stop>`:/page/Games/BlackJack.mu`choix=stop|card='+result+']`! ')
print('')

if choice == 'stop' :
	dealer_card = [random.choice(cards_list),random.choice(cards_list)] 
	dealer_score = sum(card_value(card) for card in dealer_card) 
	print("Cards Player Has:", player_card) 
	print("Score Of The Player:", player_score) 
	print('')
	print("Cards Dealer Has:", dealer_card) 
	print("Score Of The Dealer:", dealer_score) 
	print('')
	if player_score > 21: 
		print("Dealer wins (Player Loss Because Player Score is exceeding 21)") 

	if dealer_score < 17: 
		new_card = random.choice(cards_list)
		dealer_card.append(new_card) 
		dealer_score += card_value(new_card) 
		print("The dealer request another card")
		print('')
		print("Cards Dealer Has:", dealer_card)
		print("Score Of The Dealer:", dealer_score) 
		print("\n") 

	if dealer_score > 21 and player_score <=21:
		print("Player wins (Dealer Loss Because Dealer Score is exceeding 21)") 
	elif player_score > dealer_score and player_score <=21: 
		print("Player wins (Player Has High Score than Dealer)") 
	elif dealer_score > player_score: 
		print("Dealer wins (Dealer Has High Score than Player)") 
	elif dealer_score == player_score and player_score <=21:
		print("It's a tie.")
	print('')
	print('`!`[<Replay>`:/page/Games/BlackJack.mu`choix=]`! | `!`[<Home>`:/page/index.mu`page=Games]`!')

