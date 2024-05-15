
. ./gamemode2.sh
. ./gamemode1.sh
. ./database.sh

clear
echo "Добро пожаловать в Binariki"
while :
do  
    echo "Введите: "
    echo "1, чтобы играть с ботом"
    echo "2, чтобы играть с другом"
    echo "3, чтобы показать таблицу лидеров"
    echo "4, чтобы вывести путь к галерее фото"
    echo "5, чтобы выйти"
    read gamemode

    case $gamemode in
        1)
            bot_play
            new_result $?
            read -p "Чтобы продолжить введите любой символ"
            clear
            ;;

        2)
            friend_play
            read -p "Чтобы продолжить введите любой символ"
            clear
            ;;

        3)
            clear
            echo "Таблица лидеров:"
            top_players
            read -p "Чтобы продолжить введите любой символ" 
            clear
            ;;
        
        4)
            clear
            where_photo
            read -p "Чтобы продолжить введите любой символ"
            clear
            ;;
        
        5)
            exit 0
            ;;

        *)
            clear
            echo "Неопознанный аргумент"
            ;;
    esac
done

