from random import uniform
from random import randint

def HMM(n):
    '''simulate loaded die with hidden markov model'''
    switcher='F'  # state of current die
    rolls=[]      # store values of die
    state=[]      # store state of die
    for i in range(n):
        if switcher=='F':   # die is fair
            X=uniform(0,1)
            # 95% chance of staying fair
            # 5% chance of switching to loaded
            if X<=0.95: # stay fair
                value=randint(1,6)
                switcher='F'
            else: # switch to loaded
                Y=randint(1,10)
                if Y>=6:
                    value=6
                else:
                    value=Y
                switcher='L'
        else: # die is loaded
            X=uniform(0,1)
            # 90% chance of staying loaded
            # 10% chance of switching to fair
            if X<=0.9: # stay loaded
                Y=randint(1,10)
                if Y>=6:
                    value=6
                else:
                    value=Y
                switcher='L'
            else: # switch to fair          
                value=randint(1,6)
                switcher='F'
        rolls.append(value)
        state.append(switcher)
    return rolls,state
