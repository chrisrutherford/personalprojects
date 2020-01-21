import numpy as np

faces = (2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "King", "Queen", "Ace")


def blackjack():
    print("Let's play!")
    ace_value = int(input("Should an Ace be worth 1 or 11 points? "))
    points = 0
    cards = []
    card1face = np.random.choice(faces)
    cards.append(card1face)
    card2face = np.random.choice(faces)
    cards.append(card2face)
    print("Your first card is {}, and your second is {}.".format(card1face, card2face))
    card1 = card_value(card1face, ace_value)
    card2 = card_value(card2face, ace_value)
    points = points + card1 + card2
    print("You have {} points.".format(points))

    ## TODO: fix this looping issue
    next_move = input("(H)it or (S)tand?: ")
    while next_move.upper() != 'S' or next_move.upper() != 'H':
        next_move = str(input("I said (H)it or (S)tand?: "))
        print(next_move.upper() != 'S' or next_move.upper() != 'H')
    if next_move.upper() == "S":
        pass
    while 'H' == next_move.upper() and points < 21:
        new_card_face = np.random.choice(faces)
        cards.append(new_card_face)
        if "Ace" in cards and points>21:
            points -= 10
        new_card = card_value(new_card_face, ace_value)
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


def card_value(face, ace_value):
    if face == "Ace":
        return int(ace_value)
    if face == "Jack" or face == "King" or face == "Queen":
        return 10
    else:
        return int(face)


x = input("Welcome to Blackjack. Do you feel lucky, pal? Y/N: ")
if x.upper() == 'Y':
    blackjack()
else:
    print("Oh. Alright then. Goodbye.")


replay = input("\nPlay again? Y/N: ")
while replay.upper() != 'N':
    blackjack()
    replay = input("\nPlay again? Y/N: ")
