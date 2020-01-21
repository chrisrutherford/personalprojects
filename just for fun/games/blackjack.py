import numpy as np
from numpy.core.defchararray import upper

faces = (2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "King", "Queen", "Ace")

def blackjack():
    print("Let's play!")
    ace_value = input("Should an Ace be worth 1 or 11 points? ")
    points = 0
    card1face = np.random.choice(faces)
    card2face = np.random.choice(faces)
    print("Your first card is {}, and your second is {}.".format(card1face, card2face))
    card1 = card(card1face, ace_value)
    card2 = card(card2face, ace_value)
    points = points + card1 + card2

    print("You have {} points.".format(points))
    next_move = input("(H)it or (S)tand?: ")
    while upper(next_move)!='S' or upper(next_move)!='H':
        next_move = input("(H)it or (S)tand?: ")
    if upper(next_move) == 'S':
        print("You finished with {} points.".format(points))
    while upper(next_move) == 'H' and points < 21:
        new_card_face = np.random.choice(faces)
        new_card = card(new_card_face, ace_value)
        print("Your new card is {}.".format(new_card_face))
        points += new_card
        print("You now have {} points.\n".format(points))
        if points > 21:
            print("You busted! Sucks to be you.\n")
            return
        if points == 21:
            print("Blackjack!")
        if points < 21:
            next_move = input("(H)it or (S)urrender?: ")


def card(face, ace_value):
    if face == "Ace":
        return ace_value
    if face == "Jack" or face == "King" or face == "Queen":
        return 10
    else:
        return int(face)


x = input("Welcome to Blackjack. Do you feel lucky, pal? Y/N: ")
if upper(x) == 'N':
    print("Oh. Alright then. Goodbye.")
else:
    blackjack()

replay = input("\nPlay again? Y/N: ")
while upper(replay) != 'N':
    blackjack()
    replay = input("\nPlay again? Y/N: ")
