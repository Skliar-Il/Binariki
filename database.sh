#!/bin/bash
. ./auth.sh

function top_players() {
    local count=0

    for list in $(ls ./users)
    do
        
        list_users[$count]=$list
        list_ach[$count]=$(cat ./users/$list/ach.txt)
        count=$(($count + 1))


    done
    count=$(($count - 1))

    
    for ((repeat=0; $repeat<$(($count)); repeat++))
    do
        for ((check_max=0; $check_max<$(($count - $repeat)); check_max++))
        do

            if [[ ${list_ach[$check_max]} -lt ${list_ach[$(($check_max + 1))]} ]]
            then 

                repeter=${list_ach[$check_max]}
                list_ach[$check_max]=${list_ach[$(($check_max + 1))]}
                list_ach[$(($check_max + 1))]=$repeter

                repeter=${list_users[$check_max]}
                list_users[$check_max]=${list_users[$(($check_max + 1))]}
                list_users[$(($check_max + 1))]=$repeter


            fi
        done
    done
    
    for ((permutation=0; permutation<=$count; permutation++))
    do
        echo "${list_users[$permutation]}: ${list_ach[$permutation]}"

    done
    return 0
}




function where_photo {
    echo
    echo "Все фото вы можете найти по этому пути, пожалуйста не залезайте в другие папки,
а то разработчики обидятся"
    echo
    echo "Путь: $(pwd)/Binariki_users_photo"
    echo
}




function photo {
    local name=$1
    local approval=0
    local today=$(date)

    while [[ $approval != "n" && $approval != "y" && $approval != "Y" && $approval != "N" ]]
    do
        read -p "Хотите сделать фото в альбом?[y/n]: " approval
    done


    if [[ $approval = "y" || $approval = "Y" ]]
    then

    for i in 3 2 1
    do
        echo $i
        sleep 1

    done


    ffmpeg -i /dev/video0 -t 1 "./Binariki_users_photo/$name.png" 1> /dev/null 2> /dev/null
    echo 
    echo "Фото сделанно"

    else
        return 0
    fi
}






function new_result {
    local name
    read -p "Введите ваше имя: " name


    local result=$1

    for line in $(ls users)
    do
        if [[ $name == $line ]]
        then
            log_in $result $name
            return 0
        fi
    done

    register $result $name
    return 0

}



#Сделать так чтобы программу во время выполнения некоторых функций нельзя было прервать 
