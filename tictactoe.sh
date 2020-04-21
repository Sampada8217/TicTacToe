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
	player=$(( (player%2) +1 ))
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
	turn=0
	echo "Computer playing"
	checkWin  
        checkOppWin 
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
	winMove=$(checkHorizontal $1)
	if [ "$winMove" == -1 ]
	then
		winMove=$(checkVertical $1)
		if [ "$winMove" == -1 ]
		then
			winMove=$(checkDiagonal $1 1)
			if [ "$winMove" == -1 ]
			then
				winmove=$(checkDiagonal $1 -1)
			fi
		fi
	fi
	echo $winMove
}


function checkOppWin()
{
	blockMove=$(checkHorizontal $1)
	if [ "$blockMove" == -1 ]
	then
		blockMove=$(checkVertical $1)
		if [ "$blockMove" == -1 ]
		then
			blockMove=$(checkDiagonal $1 1)
			if [ "SblockMove" == -1 ]
			then
				blockMove=$(checkDiagonal $1 -1)
                	fi
 		fi
	fi
        echo $blockMove
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
resetBoard
CheckFirstPlayer
while [ $won != 1 ]
do
	if [ $turn -eq 1 ]
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
