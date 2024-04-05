#!/bin/bash

function check_login {

    login=$1
    db_name=./users/$login/.acc
    separator="|"
    line=$(cat $db_name)

    if [[ $line == $login$separator* ]]
    then

        echo $line
        return 0

    fi
}






function register {
    separator="|"
    read -p "Введите ваше имя: " name
    result=$1

    for line in $(ls users)
    do
        if [[ $name == $line ]]
        then
            attempts=3

            while [[ $attempts -ne 0 ]]
            do  

                read -s -p "Введите пароль:" password
                password=$(echo $password | sha1sum | awk '{print $1}')
                check_log=$(check_login $name)

                if [[ $name$separator$password == $check_log ]]
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
        fi
    done

    new_password=1
    check_new_password=0
    echo "Ваш аккаунт не найдет"
    echo "Зарегистрируйтесь"

    while [[ $new_password != $check_new_password ]]
    do
        read -s -p "Введите пароль: " new_password
        echo " "
        read -s -p "Повторите пароль: " check_new_password
        echo " "
        continue

    done

    new_password=$(echo $new_passwrod | sha1sum | awk '{print $1}')
    mkdir ./users/$name
        
    echo $name$separator$new_password > ./users/$name/.acc
    echo $result > ./users/$name/ach.txt
    echo "Вы успешно зарегистрировались, ваш результат зафиксирован"
    return 0
    

}
register -1