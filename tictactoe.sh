#!/bin/bash 

function resetBoard()
{
echo "Welcome to Tic Tac Toe Game"
MY_TURN=O
COMP_TURN=X
BOARD_SIZE=3
BOARD_POS=9

for (( i=0; i<=$BOARD_POS; i++ ))
do
     BOARD[$i]="."
done


}
 
function printBoard()
{
	echo " | ${Matrix[0]} | ${Matrix[1]} | ${Matrix[2]} | "
	echo "------------"
	echo " | ${Matrix[3]} | ${Matrix[4]} | ${Matrix[5]} | "
	echo "------------"
	echo " | ${Matrix[6]} | ${Matrix[7]} | ${Matrix[8]} | "
	echo "------------"
}
printBoard


