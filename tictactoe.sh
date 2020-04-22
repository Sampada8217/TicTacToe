#!/bin/bash  
function CheckFirstPlayer()
{
	toss=$((RANDOM%2))
	if [ $toss -eq 1 ]
	then
		echo "First turn is MY_TURN"
        else
		echo "First Turn is COMP_TURN"
        fi
}
function resetBoard()
{
	echo "Welcome to Tic Tac Toe Game"
	MY_TURN=O
	COMP_TURN=X
	BOARD_SIZE=3
	BOARD_POS=10
	won=0
	emptySym='.'
        turn=0
	for (( i=0; i<=$BOARD_POS; i++ ))
	do
     		BOARD[$i]="."
	done
}
function printBoard()
{
	echo " | ${BOARD[1]} | ${BOARD[2]} | ${BOARD[3]} | "
	echo "------------"
	echo " | ${BOARD[4]} | ${BOARD[5]} | ${BOARD[6]} | "
	echo "------------"
	echo " | ${BOARD[7]} | ${BOARD[8]} | ${BOARD[9]} | "
	echo "------------"
}

function checkHorizontal()
{
	if [ $won == 0 ]
        then
             local rows=3
             local pos=1
             local symCount=1
             while [ $symCount -ne $rows ]
             do
                  if [[ ${BOARD[$pos]} == ${BOARD[$pos+1]} ]] && [[ ${BOARD[$pos+1]} == ${BOARD[$pos+2]} ]] && [[ ${BOARD[$pos]} == ${BOARD[$pos+2]} ]] && [[ ${BOARD[$pos]} == $1 ]] 
		  then
		  	      printBoard
                  	      echo "Won Horizonatally"
                              won=1
			      break
		  else
                              pos=$(( $pos + $rows ))
		   fi

 	     symCount=$(( $symCount + 1 ))
	     done
          fi
}

function checkVertical()
{
	if [ $won == 0 ]
        then
		local col=3
		local pos=1
		local symCount=1
		while [ $symCount -ne $col ]
		do
                	if [[ ${BOARD[$pos]} == ${BOARD[$pos+3]} ]] && [[ ${BOARD[$pos]} == ${BOARD[$pos+6]} ]] && [[ ${BOARD[$pos+3]} == ${BOARD[$pos+6]} ]] && [[ ${BOARD[$pos]} == $1 ]] 
          		then
                        	printBoard
                                echo "Won Vertically"
                                won=1
                                break
                        else
                               pos=$(( $pos + $col ))
                        fi
                symCount=$(( $symCount + 1 ))
		done
         fi
}

function checkDiagonal()
{
	if [ $won == 0 ]
	then
		local pos=1
		if [[ ${BOARD[$pos]} == ${BOARD[$pos+4]} ]] && [[ ${BOARD[$pos+4]} == ${BOARD[$pos+8]} ]] && [[ ${BOARD[$pos]} == ${BOARD[$pos+8]} ]] && [[ ${BOARD[$pos]} == $1 ]]
		then
			printBoard
			echo "Won Diagonally"
			won=1
			break
                elif [[ ${BOARD[$pos+2]} == ${BOARD[$pos+4]} ]] && [[ ${BOARD[$pos+2]} == ${BOARD[$pos+6]} ]] && [[ ${BOARD[$pos+4]} == ${BOARD[$pos+6]} ]] && [[ ${BOARD[$pos+2]} == $1 ]] 
		then
			printBoard
			echo "Won Diagonally"
			won=1
			break
		fi
	fi
}
function CheckTie()
{
	if [ $won == 0 ]
	then
		isSymfilled=1
		while [ ${BOARD[$isSymFilled]} != $emptySym ]
		do
			if [ $isSymFilled -eq $BOARD_POS ]
			then
				echo "Tie"
				break
			else
				isSymFilled=$(($isSymFilled+1))
			fi
		done
	fi
}

function  Player1()
{
        echo "MY TURN displaying Board to fill valid cell"
	printBoard
	echo "Enter Position where you want to place Symbol"
	read pos
        if [ ${BOARD[$pos]} == $emptySym ]
        then
		BOARD[$pos]=$MY_TURN
		player=$(( (player%2) +1 ))
	else
		echo "You Can't Place There"
		Player1
        fi
        turn=0
}


function player2()
{
        row=1
	col=3
	turn=0
	echo "Computer playing"
        checkWin $row $col
	checkWin $col $row
	checkOppWin $row $col
	checkOppWin $col $row

	if [ $turn = 0 ]
	then
		checkCorner
        fi
	if [ $turn = 0 ]
	then
		checkCenter
	fi
	if [ $turn = 0 ]
	then
		checkSides
	fi
}
        
function checkWin()
{
	count=1
	for (( i=1;i<=3;i++))
	do
		if [[ ${BOARD[$count]} == ${BOARD[$count+$1+$1]} ]] && [[ ${BOARD[$count+$1]} == $emptySym ]] && [[ ${BOARD[$count]} == $COMP_TURN ]] 
		then
			winMove=$(( $count+$1 ))
			BOARD[$winMove]=$COMP_TURN
			printBoard
			turn=1
			break
               elif [[ ${BOARD[$count]} == ${BOARD[$count+$1]} ]] && [[ ${BOARD[$count+$1+$1]} == $emptySym ]] && [[ ${BOARD[$count]} == $COMP_TURN ]]
		then
			winMove=$(( $count+$1+$1 ))
			BOARD[$winMove]=$COMP_TURN
			printBoard
			turn=1
			break
		elif [[ ${BOARD[$count+$1]} == ${BOARD[$count+$1+$1]} ]] && [[ ${BOARD[$count]} == $emptySym ]] && [[ ${board[$count+$1]} == $COMP_TURN ]]
		then
			winMove=$count
			BOARD[$winMove]=$COMP_TURN
			printBoard
			turn=1
			break
		fi
	count=$(( $count+$2 ))
	done
}


function checkOppWin()
{
	countOpp=1
 	if [ $turn -eq  0 ]
	then
	for (( i=1;i<=3;i++))
	do
		if [[ ${BAORD[$countOpp]} == ${BAORD[$countOpp+$1+$1]} ]] && [[ ${BOARD[$countOpp+$1]} == $emptySym ]] && [[ ${BOARD[$counterOpp]} == $MY_TURN ]] 
		then
			blockMove=$(( $countOpp+$1 ))
			BOARD[$blockMove]=$COMP_TURN
			turn=1
			break
		elif [[ ${BOARD[$countOpp]} == ${BOARD[$countOpp+$1]} ]] && [[ ${BOARD[$countOpp+$1+$1]} == $tail ]] && [[ ${BOARD[$countOpp]} == $MY_TURN ]]
		then
			blockMove=$(( $counteOpp+$1+$1 ))
			BOARD[$blockMove]=$COMP_TURN
			turn=1
			break
		elif [[ ${BOARD[$countOpp+$1]} == ${BOARD[$countOpp+$1+$1]} ]] && [[ ${BOARD[$countOpp]} == $emptySym ]] && [[ ${BOARD[$countOpp+$1]} == $MY_TURN ]]
		then
			blockMove=$countOpp
			BOARD[$blockMove]=$COMP_TURN
			turn=1
			break
		fi
	countOpp=$(( $countOpp+$2 ))
        done
 	fi

}

function  checkCorner()
{
	for((i=1;i<$BOARD_POS;i=$(($i+2)) ))
	do
		if [ ${BOARD[$i]} == $emptySym ]
		then
			echo "Move to Corner"
			BOARD[$i]=$COMP_TURN
			printBoard
			turn=1
			break
		fi
                if [ $i -eq 3 ]
                then
			i=$(($i+2))
		fi
	done
}
function checkCenter()
{
	cent=5
	if [[ ${BOARD[$cent]} == $emptySym ]]
        then
		echo "Move to Center"
		BOARD[$cent]=$COMP_TURN
		printBoard
		turn=1
	 fi
}
 
function checkSides()
{
	for ((i=2;i<$BOARD_POS;i=$(($i+2)) ))
	do
		if [ ${BOARD[$i]} == '.' ]
		then
			echo "Move to sides"
			BOARD[$i]=$COMP_TURN
			printBoard
			turn=1
			break
		fi
		if [ $i == 3 ] || [ $i == 6 ]
		then
			i=$(($i+1))
		fi
	done
}
function PlayGame()
{
resetBoard
CheckFirstPlayer
turn=$toss
while [ $won != 1 ]
do
	if [ $turn  ==  1 ]
        then
		Player1
		checkHorizontal $MY_TURN
		checkVertical $MY_TURN
		checkDiagonal $MY_TURN
		CheckTie $MY_TURN
		turn=0		
	else
		player2
		checkHorizontal $COMP_TURN
		checkVertical $COMP_TURN
		checkDiagonal $COMP_TU
		CheckTie $COMP_TURN
		turn=1
		
	fi
done
if [ $won == 1 ]
then
	echo "Game Over"
fi	
}
PlayGame
