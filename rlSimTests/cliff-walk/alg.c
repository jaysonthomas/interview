chkConvg() {
  start with the first entry of the Q-table
  print(state)
  do {
    Choose the action with the highest Q value
    if(none found) {
      choose any action that leads to a state not same as the previous one.
    }
    
    store current state
    Take the action
    Record the new state
    print(state) & update no. of moves
    Move to the particular table entry
  } while(this agent is not currently in the goal state)
}



int main() {
  initialize Q to 0s
  
  while(not exceeded max no. of episodes) {
    initialize s - (0,0)
    while(current state is not goal state) {
      choose a, that will take you to s'
      observe r (reward in s')
      choose action with the highest Q value in s' - record its Q value
      Q(s,a) = Q(s,a)+step_size*[r+discount_rate*maxQ(s',a') - Q(s,a)]
      s = s'      
    }
  }
}

Do you select the action from the Q table?
