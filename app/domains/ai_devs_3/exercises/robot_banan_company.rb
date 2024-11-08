# S01E01 - Zadanie 1
# {{FLG:FIRMWARE}}
# https://xyz.ag3nts.org/files/0_13_4b.txt - Oprogramowanie robota patrolującego

module AiDevs3
  module Exercises
    class RobotBananCompany < Exercise

      def prompt1
"
### DATA SOURCE ###
maze = [['O', 'X', 'O', 'O', 'O', 'O'],
['O', 'O', 'O', 'X', 'O', 'O'],
['O', 'X', 'O', 'X', 'O', 'O'],
['O', 'X', 'O', 'O', 'O', 'O']]

starting_position = [3, 0]
destination_position = [3, 5]
### /DATA SOURCE ###

### HOW TO USE THE DATA SOURCE ###
maze[0,0] is equal to 'O'
maze[0,1] is equal to 'X'
maze[0,2] is equal to 'O'
maze[1,1] is equal to 'O'
maze[1,2] is equal to 'X'
maze[1,3] is equal to 'X'
maze[3,5] is equal to 'O'
### /HOW TO USE THE DATA SOURCE ###

maze is a two-dimensional array.
Each position can be accessed by maze[y][x] where y is the row number and x is the column number. For example, maze[0][0] is the first position in the maze and maze[3][5] is the last position in the maze.

Instruction 'LEFT' means to change dimension x by -1 (for example, maze[0][1] -> maze[0][0]).
Instruction 'RIGHT' means to change dimension x by +1 (for example, maze[0][1] -> maze[0][2]).
Instruction 'UP' means to change dimension y by -1 (for example, maze[1][0] -> maze[0][0]).
Instruction 'DOWN' means to change dimension y by +1 (for example, maze[1][0] -> maze[2][0]).

Provide a list of instructions that will allow to move from starting_position to destination_position in the maze.
Non of iterations can set the current_position to the 'X' value.

### STEP-BY-STEP ALGORITHM ###
- remember the current_position which is set to the starting_position = [3, 0]; current_position is [3,0]
- think what are possible instructions - 'LEFT' is not possible because dimension x-1 in the case of current_position [3,0] would be -1 which is not allowed; 'DOWN' is not possible because dimension y+1 in the case of current_position [3,0] would be 4 and max Y dimension of the maze is 3; 'RIGHT' is not possible because dimension x+1 in the case of current_position [3,0] would be 1 but maze[3][1] is 'X' which is not allowed; 'UP' is possible because dimension y-1 in the case of current_position [3,0] would be 2 and maze[2][0] is 'O'; so the first instruction is 'UP'; current_position is [2,0]
- remember the current_position which is set now to [2,0]; current_position is [2,0]
- think what are possible instructions - 'LEFT' is not possible because dimension x-1 in the case of current_position [2,0] would be -1 which is not allowed; 'DOWN' is possible because dimension y+1 in the case of current_position [2,0] would be 3 and maze[3][0] is 'O'; 'RIGHT' is not possible because dimension x+1 in the case of current_position [2,0] would be 1 but maze[2][1] is 'X' which is not allowed; 'UP' is possible because dimension y-1 in the case of current_position [2,0] would be 1 and maze[1][0] is 'O'; so two instructions are possible: 'DOWN' and 'UP'; the best option is 'UP' because it moves the current_position closer to the destination; so the second instruction is 'UP'; current_position is [1,0]
- remember the current_position which is set now to [1,0]; current_position is [1,0]
- repeat this process until the current_position is equal to the destination_position
### /STEP-BY-STEP ALGORITHM ###

take a deep breath and start the task calmly;
do not rush and think about the solution;
analyze the maze and think about the possible moves;
calmly go with the algorithm step-by-step

describe each step in a separate line and start with the '-' symbol, like this
- current_position [3,0]; available instructions: ['UP']; instruction: 'UP'; new current_position is [2,0]
- current_position [2,0]; available instructions: ['UP', 'DOWN']; instruction: 'UP'; new current_position is [1,0]
- current_position [1,0]; available instructions: ['RIGHT', UP', 'DOWN']; instruction: 'RIGHT'; new current_position is [1,1]
(and so on)

and then return instructions in a specific format, like this:
              <RESULT>
              {
               \"steps\": \"UP, ...\"
              }
              </RESULT>
return only steps with the '-' listed above and <RESULT> section - nothing else

        "
      end

      def prompt
"instructions are:
<RESULT>
{
 \"steps\": \"1, 1, 3, 3, 4, 2, 4, 2, A, B, 3\"
}
</RESULT>
return the same structure but change each number into the instruction as fallows:
1 -> 'UP'
2 -> 'RIGHT'
3 -> 'DOWN'
4 -> 'LEFT'
"
      end

      def do_it
        chat(prompt)
      end
    end
  end
end
