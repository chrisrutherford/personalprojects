from random import randrange

def rockPaperScissors():
    userWins, compWins, draws=0, 0, 0
    playAgain='Y'
    print("Welcome to rock, paper, scissors!")
    
    while playAgain!='N':
        userChoice=int(input("Rock, paper, or scissors? (type 1, 2, or 3): "))
        compChoice=randrange(1,4)
        
        if userChoice==1:   #user chooses rock
            if compChoice==1:
                print("Draw!")
                draws+=1
            if compChoice==2:
                print("Computer wins!")
                compWins+=1
            if compChoice==3:
                print("You win!")
                userWins+=1

        if userChoice==2:   #user chooses paper
            if compChoice==1:
                print("You win!")
                userWins+=1
            if compChoice==2:
                print("Draw!")
                draws+=1
            if compChoice==3:
                print("Computer wins!")
                compWins+=1

        if userChoice==3:   #user chooses scissors
            if compChoice==1:
                print("Computer wins!")
                compWins+=1
            if compChoice==2:
                print("You win!")
                userWins+=1
            if compChoice==3:
                print("Draw!")
                draws+=1

        playAgain=input("Play again? Y/N: ")
        playAgain=playAgain.upper()
        
    print("Final stats")
    print("Player wins:",userWins)
    print("Computer wins:",compWins)
    print("Draws:",draws)
    
    return "Goodbye"
