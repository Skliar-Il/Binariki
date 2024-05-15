#!/bin/bash



function check_login {

    local login=$1

    db_name=./users/$login/.acc
    line=$(cat $db_name)

    if [[ $line == $login* ]]
    then

        echo $line
        return 0

    fi
}





function log_in {
    local attempts=3
    local result=$1
    local name=$2


    while [[ $attempts -ne 0 ]]
    do  

        read -s -p "Введите пароль:" password


        local password=$(echo $password | sha256sum | awk '{print $1}')
        local check_log=$(check_login $name)


        if [[ $name$password == $check_log ]]
        then

            echo " " 
            echo "Вы успешно вошли"

            ach=$(cat ./users/$name/ach.txt)
            ach=$(($ach+$result))

            echo $ach > ./users/$name/ach.txt
            echo "Ваш результат успешно внесен"

            return 0

        else
            attempts=$(($attempts-1))
            echo " "

        fi
    done

        echo "Вы не смогли авторизоваться, ваш результат будет утерян)"
        return 0
}






function register {

    local new_password=1
    local check_new_password=0
    local result=$1
    local name=$2
    
    echo "Ваш аккаунт не найдет"
    echo "Зарегистрируйтесь"

    while [[ $new_password != $check_new_password ]]
    do
        read -s -p "Введите пароль: " new_password
        echo " "
        read -s -p "Повторите пароль: " check_new_password
        echo " "
        
        if [[ $new_password != $check_new_password ]]
        then
            echo " "
            echo "Пароли не совпадают, введите их заново"
            echo " "
        fi
        continue

    done


    new_password=$(echo $new_password | sha256sum | awk '{print $1}')
    mkdir ./users/$name

        
    echo $name$new_password > ./users/$name/.acc
    echo $result > ./users/$name/ach.txt
    
    echo "Вы успешно зарегистрировались, ваш результат зафиксирован"
    photo $name
    
}