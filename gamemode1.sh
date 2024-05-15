#!/bin/bash

. ./graph.sh
. ./functions.sh

function bot_play {
    local player="X"
    local turns=1
    local field=(1 2 3 4 5 6 7 8 9)

    local square=""

    draw ${field[@]}

    while [[ $turns -le 9 ]]
    do

        if [[ $player == "X" ]]
        then
            read -p "Введите номер ячейки: " square
        else
            square=$(($RANDOM%9+1))
    
            #здесь бы по-хорошему do while
            while [[ $square != ${field[$(($square-1))]} ]]
            do
                square=$(($RANDOM % 9))
            done
        fi

        turn_go $square ${field[@]}

        if [[ $? -eq 0 ]]
        then
            field[$((square-1))]=$player

            draw ${field[@]}
            turns=$(($turns+1))

            check_win ${field[@]}

            if [[ $? -eq 1 ]]
            then
                echo "Победил игрок $player"
                if [[ $player -eq "X" ]]
                then
                    return 2
                else
                    return 0
                fi
            fi

            if [[ $player == "X" ]]
            then
                player="O"
            else
                player="X"
            fi
        fi

    done
    echo "Ничья!"
    return 1


}
