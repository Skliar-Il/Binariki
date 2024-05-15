function turn_go {
    local square=$1
    shift
    local field=($1 $2 $3 $4 $5 $6 $7 $8 $9)

    if [[ ! -n "$square" ]]
    then
        echo "Номер ячейки не должен быть пуст"
        return 2
    elif [[ ! -n $(echo $square | grep "^[1-9]$") ]]
    then
        echo "Номер ячейки должен являться цифрой от 1 до 9"
        return 3
    fi

    if [[ ${field[$(($square-1))]} == "X" || ${field[$(($square-1))]} == "O" ]]
    then
        echo "Ячейка уже использована, выберите другую"
        return 1
    fi

    return 0
}

function check_win {
    local field=($1 $2 $3 $4 $5 $6 $7 $8 $9)
    if [[ ${field[0]} == ${field[1]} && ${field[0]} == ${field[2]} ]]
    then
        return 1
    elif [[ ${field[3]} == ${field[4]} && ${field[3]} == ${field[5]} ]]
    then
        return 1
    elif [[ ${field[6]} == ${field[7]} && ${field[6]} == ${field[8]} ]]
    then
        return 1
    elif [[ ${field[0]} == ${field[3]} && ${field[0]} == ${field[6]} ]]
    then
        return 1
    elif [[ ${field[1]} == ${field[4]} && ${field[1]} == ${field[7]} ]]
    then
        return 1
    elif [[ ${field[2]} == ${field[5]} && ${field[2]} == ${field[8]} ]]
    then
        return 1
    elif [[ ${field[0]} == ${field[4]} && ${field[0]} == ${field[8]} ]]
    then
        return 1
    elif [[ ${field[2]} == ${field[4]} && ${field[2]} == ${field[6]} ]]
    then
        return 1
    fi

    return 0
}
