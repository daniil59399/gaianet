#!/bin/bash

# Цвета и форматирование
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD='\033[1m'

# ASCII логотип
print_logo() {
    clear
    # Киберпанк-стиль заголовок
    echo -e "\033[38;5;51m╔══════════════════════════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;5;51m║\033[0m \033[38;5;201m[\033[0m \033[38;5;82mINITIALIZING GUST CRYPTO\033[0m \033[38;5;201m]\033[0m \033[38;5;226m[\033[0m \033[38;5;82mSYSTEM STATUS: ONLINE\033[0m \033[38;5;226m]\033[0m \033[38;5;51m║\033[0m"
    echo -e "\033[38;5;51m╚══════════════════════════════════════════════════════════════════════════════╝\033[0m"

    # ASCII арт GaiaNet
    echo -e "\033[38;5;51m    ██████╗   ██╗   ██      ███████╗     ████████╗\033[0m"
    echo -e "\033[38;5;45m   ██╔════╝   ██║   ██╗╝   ██╔═════╝       ║██║    \033[0m"
    echo -e "\033[38;5;39m   ██║  ███╗  ██║   ██║     ███████╗       ║██║    \033[0m"
    echo -e "\033[38;5;33m   ██║   ██║  ██║   ██║║    ╚════██║       ║██║    \033[0m"
    echo -e "\033[38;5;27m   ╚██████╔╝  ██████╔║     ███████║        ║██║    \033[0m"
    echo -e "\033[38;5;21m    ╚═════╝   ╚═════╝╚     ╚══════╝        ╚═╝     \033[0m"
    echo
    echo -e "\033[38;5;51m   ██████╗ ██████╗    ██╗    ██╗██████╗ ████████╗    ██████╗      \033[0m"
    echo -e "\033[38;5;45m  ██╔════╝ ██╔══██╗    ██║  ██║ ██╔══██╗╚══██╔══╝  ██      ██╗    \033[0m"
    echo -e "\033[38;5;39m  ██║      ██████╔╝     ║██║    ██████╔╝  ║██║     ██      ██║     \033[0m"
    echo -e "\033[38;5;33m  ██║      ██═██╝       ║██║    ██═       ║██║     ██      ██║     \033[0m"
    echo -e "\033[38;5;27m  ╚██████╗ ██║ ██       ║██║   ║██║        ██       ╚██████╔╝      \033[0m"
    echo -e "\033[38;5;21m   ╚═════╝ ╚═╝ ╚═╝      ╚══╝   ╚══╝       ╚══╝       ╚═════╝             \033[0m"

    # Герметический символизм и киберпанк-подпись
    echo
    echo -e "\033[38;5;201m⌬ ⌬ ⌬\033[0m \033[38;5;82m[\033[0m \033[5mGUST CRYPTO\033[0m \033[38;5;82m]\033[0m \033[38;5;201m⌬ ⌬ ⌬\033[0m"
    echo -e "\033[38;5;201m⌬ ⌬ ⌬\033[0m \033[38;5;82m[\033[0m \033[5mPOWERED BY XNOD3,EDIT SCRIPT BY GUST CRYPTO \033[0m \033[38;5;82m]\033[0m \033[38;5;201m⌬ ⌬ ⌬\033[0m"
    echo


    # Дополнительные элементы
    echo -e "\033[38;5;51m▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄\033[0m"
    echo
}

# Обновляем цвета и добавляем новые
declare -A COLORS=(
    ["cyan"]="\033[38;5;51m"
    ["purple"]="\033[38;5;93m"
    ["green"]="\033[38;5;82m"
    ["red"]="\033[38;5;196m"
    ["yellow"]="\033[38;5;226m"
    ["pink"]="\033[38;5;201m"
    ["gray"]="\033[38;5;245m"
    ["reset"]="\033[0m"
)

# Обновляем символы для более киберпанк-стиля
declare -A SYMBOLS=(
    ["info"]="∴"
    ["success"]="◉"
    ["error"]="✕"
    ["warning"]="⚠"
    ["step"]="⟡"
    ["arrow"]="⟩"
    ["dot"]="∙"
    ["progress_fill"]="▰"
    ["progress_empty"]="▱"
)

# Функция для вывода логов
log() {
    local level=$1
    local message=$2
    local date=$(date '+%H:%M:%S')
    local color prefix

    case $level in
        "INFO")
            color=${COLORS[cyan]}
            prefix=${SYMBOLS[info]}
            ;;
        "SUCCESS")
            color=${COLORS[green]}
            prefix=${SYMBOLS[success]}
            ;;
        "ERROR")
            color=${COLORS[red]}
            prefix=${SYMBOLS[error]}
            ;;
        "WARNING")
            color=${COLORS[yellow]}
            prefix=${SYMBOLS[warning]}
            ;;
        "STEP")
            color=${COLORS[pink]}
            prefix=${SYMBOLS[step]}
            ;;
    esac

    echo -e "${color}${SYMBOLS[arrow]} ${COLORS[gray]}${date}${COLORS[reset]} ${color}${prefix}${COLORS[reset]} ${message}"
}

# Функция для отображения прогресса
show_spinner() {
    local pid=$1
    local message=$2
    local spin='-\|/'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\r${BLUE}⏳ %s... %s${NC}" "$message" "${spin:$i:1}"
        sleep .1
    done
    printf "\r"
}

# Проверка зависимостей
check_dependencies() {
    log "INFO" "Проверка зависимостей..."
    
    # Сначала обновим кэш apt
    log "INFO" "Обновление списка пакетов..."
    if ! sudo apt-get update > /tmp/apt_update.log 2>&1; then
        log "ERROR" "Ошибка при обновлении списка пакетов"
        log "ERROR" "Детали ошибки:"
        cat /tmp/apt_update.log
        exit 1
    fi

    # Установка базовых зависимостей
    local deps=("curl" "wget" "git" "bc" "lsof")
    for dep in "${deps[@]}"; do
        if ! dpkg -l | grep -q "^ii  $dep"; then
            log "WARNING" "Отсутствует $dep. Установка..."
            if ! sudo apt-get install -y $dep > /tmp/dep_install.log 2>&1; then
                log "ERROR" "Ошибка при установке $dep"
                log "ERROR" "Детали ошибки:"
                cat /tmp/dep_install.log
                exit 1
            fi
        fi
    done

    # Отдельная установка Python и pip
    log "INFO" "Установка Python и pip..."
    if ! sudo apt-get install -y python3 python3-pip > /tmp/python_install.log 2>&1; then
        # Если не удалось установить, пробуем альтернативный метод
        log "WARNING" "Стандартная установка pip не удалась, пробуем альтернативный метод..."
        if ! sudo apt-get install -y python3-distutils python3-apt > /tmp/python_install.log 2>&1; then
            log "ERROR" "Ошибка при установке Python-зависимостей"
            log "ERROR" "Детали ошибки:"
            cat /tmp/python_install.log
            exit 1
        fi
        
        # Установка pip через get-pip.py
        log "INFO" "Установка pip через get-pip.py..."
        if ! curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3 > /tmp/pip_install.log 2>&1; then
            log "ERROR" "Ошибка при установке pip"
            log "ERROR" "Детали ошибки:"
            cat /tmp/pip_install.log
            exit 1
        fi
    fi

    # Проверяем установку pip
    if ! command -v pip3 &> /dev/null; then
        log "ERROR" "pip3 не установлен после всех попыток установки"
        exit 1
    fi

    # Установка Python-пакетов
    log "INFO" "Установка Python-зависимостей..."
    if ! pip3 install --quiet --no-cache-dir requests faker; then
        log "WARNING" "Стандартная установка пакетов не удалась, пробуем с --user..."
        if ! pip3 install --quiet --no-cache-dir --user requests faker; then
            log "ERROR" "Ошибка при установке Python-пакетов"
            exit 1
        fi
    fi

    log "SUCCESS" "Все зависимости установлены успешно"
}

# Анимированная линия загрузки
show_progress_bar() {
    local duration=$1
    local width=50
    local progress=0
    local bar_char="▓"
    local empty_char="░"
    local sleep_duration=0.02  # Фиксированная задержка вместо вычисления
    
    while [ $progress -le $width ]; do
        local bar=""
        for ((i=0; i<$progress; i++)); do
            bar="${bar}${bar_char}"
        done
        for ((i=$progress; i<$width; i++)); do
            bar="${bar}${empty_char}"
        done
        printf "\r\033[38;5;51m[%s] %d%%\033[0m" "$bar" $(($progress*100/$width))
        progress=$((progress+1))
        sleep $sleep_duration 2>/dev/null || sleep 1  # Fallback если sleep не поддерживает дробные числа
    done
    echo
}

# Анимированный переход
show_transition() {
    local message=$1
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    local delay=0.1
    local duration=${2:-2}
    local end=$((SECONDS + duration))
    
    while [ $SECONDS -lt $end ]; do
        for (( i=0; i<${#chars}; i++ )); do
            printf "\r${COLORS[pink]}${chars:$i:1}${COLORS[reset]} ${COLORS[cyan]}${message}${COLORS[reset]}"
            sleep $delay
        done
    done
    printf "\r%s\n" "$(printf ' %.0s' $(seq 1 $((${#message} + 2))))"
}

# Добавим функцию для печатающегося текста
type_text() {
    local text="$1"
    local delay=${2:-0.05}
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Функция для отображения статуса ноды
show_node_status() {
    local date=$(date '+%H:%M:%S')
    if pgrep -f "gaianet start" > /dev/null; then
        echo -e "${COLORS[green]}${SYMBOLS[arrow]} ${COLORS[gray]}${date}${COLORS[reset]} ${COLORS[green]}${SYMBOLS[success]} НОДА АКТИВНА${COLORS[reset]}"
        if [ -f "$HOME/gaianet_info.txt" ]; then
            echo -e "${COLORS[cyan]}${SYMBOLS[dot]} Информация о ноде:${COLORS[reset]}"
            while IFS= read -r line; do
                echo -e "${COLORS[cyan]}  ${SYMBOLS[arrow]} ${line}${COLORS[reset]}"
            done < "$HOME/gaianet_info.txt"
        fi
    else
        echo -e "${COLORS[red]}${SYMBOLS[arrow]} ${COLORS[gray]}${date}${COLORS[reset]} ${COLORS[red]}${SYMBOLS[error]} НОДА ОСТАНОВЛЕНА${COLORS[reset]}"
    fi
}

# Добавим функцию проверки и освобождения порта
check_and_free_port() {
    local port=$1
    local pid=$(lsof -ti:$port)
    if [ ! -z "$pid" ]; then
        log "WARNING" "Обнаружен процесс на порту $port (PID: $pid)"
        show_transition "Освобождение порта $port..." 2
        if ! kill -9 $pid > /dev/null 2>&1; then
            log "ERROR" "Не удалось освободить порт $port"
            exit 1
        fi
        log "SUCCESS" "Порт $port освобожден"
        show_progress_bar 1
    fi
}

# Функция создания сервиса
create_service() {
    log "INFO" "Создание systemd сервиса..."
    
    local service_file="/etc/systemd/system/gaianet.service"
    
    # Создаем сервисный файл
    cat > /tmp/gaianet.service << 'EOF'
[Unit]
Description=Gaianet Node Service
After=network.target

[Service]
Type=forking
RemainAfterExit=true
ExecStart=/root/gaianet/bin/gaianet start
ExecStop=/root/gaianet/bin/gaianet stop
ExecStopPost=/bin/sleep 20
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOF

    # Копируем файл в systemd директорию
    if ! sudo mv /tmp/gaianet.service "$service_file"; then
        log "ERROR" "Не удалось создать сервисный файл"
        exit 1
    fi
    
    # Обновляем конфигурацию systemd
    if ! sudo systemctl daemon-reload; then
        log "ERROR" "Не удалось обновить конфигурацию systemd"
        exit 1
    fi
    
    # Включаем сервис
    if ! sudo systemctl enable gaianet.service; then
        log "ERROR" "Не удалось включить сервис"
        exit 1
    fi
    
    # Запускаем сервис
    if ! sudo systemctl start gaianet.service; then
        log "ERROR" "Не удалось запустить сервис"
        log "ERROR" "Проверьте статус: systemctl status gaianet.service"
        exit 1
    fi
    
    # Проверяем статус
    sleep 2
    if ! systemctl is-active --quiet gaianet.service; then
        log "ERROR" "Сервис не запустился"
        log "ERROR" "Проверьте статус: systemctl status gaianet.service"
        exit 1
    fi
    
    log "SUCCESS" "Сервис успешно создан, включен и запущен"
}

# Функция удаления сервиса
remove_service() {
    log "INFO" "Удаление systemd сервиса..."
    
    # Останавливаем сервис если запущен
    if systemctl is-active --quiet gaianet.service; then
        sudo systemctl stop gaianet.service
    fi
    
    # Отключаем сервис
    if systemctl is-enabled --quiet gaianet.service; then
        sudo systemctl disable gaianet.service
    fi
    
    # Удаляем файл сервиса
    if [ -f "/etc/systemd/system/gaianet.service" ]; then
        sudo rm -f /etc/systemd/system/gaianet.service
        sudo systemctl daemon-reload
    fi
    
    log "SUCCESS" "Сервис успешно удален"
}

# Добавляем функцию для отображения прогресса этапов установки
show_stage_progress() {
    local current=$1
    local total=$2
    local stage_name=$3
    local width=30
    local filled=$((current * width / total))
    local empty=$((width - filled))
    local progress=$((current * 100 / total))
    
    echo -e "\n${COLORS[purple]}${SYMBOLS[step]} ${COLORS[cyan]}Этап ${current}/${total}:${COLORS[reset]} ${stage_name}"
    echo -ne "${COLORS[purple]}${SYMBOLS[arrow]}${COLORS[reset]} ["
    for ((i=0; i<filled; i++)); do echo -ne "${COLORS[green]}${SYMBOLS[progress_fill]}${COLORS[reset]}"; done
    for ((i=0; i<empty; i++)); do echo -ne "${COLORS[gray]}${SYMBOLS[progress_empty]}${COLORS[reset]}"; done
    echo -e "] ${COLORS[green]}${progress}%${COLORS[reset]}\n"
}

# Обновляем функцию запроса домена
request_domain() {
    echo -e "\n${COLORS[purple]}${SYMBOLS[step]} ${COLORS[cyan]}КОНФИГУРАЦИЯ ДОМЕНА${COLORS[reset]}"
    echo -e "${COLORS[gray]}┌─────────────────────────────────────────────┐${COLORS[reset]}"
    echo -e "${COLORS[gray]}│${COLORS[reset]} Выберите домен для чат-бота:                 ${COLORS[gray]}│${COLORS[reset]}"
    echo -e "${COLORS[gray]}│${COLORS[reset]} 1. plastq (по умолчанию)                     ${COLORS[gray]}│${COLORS[reset]}"
    echo -e "${COLORS[gray]}│${COLORS[reset]} 2. Указать свой домен                        ${COLORS[gray]}│${COLORS[reset]}"
    echo -e "${COLORS[gray]}└─────────────────────────────────────────────┘${COLORS[reset]}"
    
    echo -ne "\n${COLORS[purple]}${SYMBOLS[arrow]} Ваш выбор ${COLORS[gray]}(1/2)${COLORS[reset]}: "
    read choice
    echo

    case $choice in
        2)
            echo -e "${COLORS[cyan]}${SYMBOLS[info]} Введите домен:${COLORS[reset]}"
            echo -e "${COLORS[gray]}Пример: yourdomain.com${COLORS[reset]}"
            echo -ne "${COLORS[purple]}${SYMBOLS[arrow]} Домен: ${COLORS[reset]}"
            read custom_domain
            
            if [ -z "$custom_domain" ]; then
                log "ERROR" "Домен не указан"
                exit 1
            fi
            ;;
        *)
            custom_domain="plastq"
            ;;
    esac
    
    log "SUCCESS" "Будет использован домен: ${COLORS[cyan]}$custom_domain${COLORS[reset]}"
    echo "$custom_domain" > /tmp/gaianet_domain
    show_transition "Продолжаем установку..." 2
}

# Установка ноды
install_node() {
    print_logo
    
    # Увеличиваем лимит открытых файлов
    log "INFO" "Настройка системных лимитов..."
    if ! ulimit -n 65535 > /dev/null 2>&1; then
        log "WARNING" "Не удалось увеличить лимит файлов через ulimit"
        # Пробуем через systemd
        if [ -d "/etc/systemd/system.conf.d" ]; then
            mkdir -p /etc/systemd/system.conf.d
            echo -e "[Manager]\nDefaultLimitNOFILE=65535" > /etc/systemd/system.conf.d/limits.conf
            systemctl daemon-reload
        fi
    fi
    
    # Проверяем существующую установку
    if command -v gaianet &>/dev/null || [ -d "$HOME/gaianet" ] || [ -d "$HOME/.gaianet" ]; then
        echo -e "\n${COLORS[yellow]}${SYMBOLS[warning]} Обнаружена существующая установка GaiaNet!${COLORS[reset]}"
        echo -e "${COLORS[gray]}┌─────────────────────────────────────────────┐${COLORS[reset]}"
        echo -e "${COLORS[gray]}│${COLORS[reset]} Выберите действие:                           ${COLORS[gray]}│${COLORS[reset]}"
        echo -e "${COLORS[gray]}│${COLORS[reset]} 1. Удалить существующую и установить заново  ${COLORS[gray]}│${COLORS[reset]}"
        echo -e "${COLORS[gray]}│${COLORS[reset]} 2. Отменить установку                        ${COLORS[gray]}│${COLORS[reset]}"
        echo -e "${COLORS[gray]}└─────────────────────────────────────────────┘${COLORS[reset]}"
        
        echo -ne "\n${COLORS[purple]}${SYMBOLS[arrow]} Ваш выбор ${COLORS[gray]}(1/2)${COLORS[reset]}: "
        read choice
        echo
        
        case $choice in
            1)
                log "WARNING" "Удаление существующей установки..."
                remove_node
                sleep 2
                log "INFO" "Начинаем новую установку..."
                ;;
            *)
                log "INFO" "Установка отменена"
                exit 0
                ;;
        esac
    fi
    
    local total_stages=7
    local current_stage=0
    
    # Запрашиваем домен в начале установки
    request_domain
    
    ((current_stage++))
    show_stage_progress $current_stage $total_stages "Инициализация"
    show_transition "Инициализация установки GaiaNet ноды..." 2
    log "INFO" "Начинаем установку GaiaNet ноды..."
    sleep 1
    
    ((current_stage++))
    show_stage_progress $current_stage $total_stages "Проверка зависимостей"
    show_transition "Проверка системных зависимостей..." 2
    check_dependencies
    show_progress_bar 1
    
    # Проверка и освобождение порта 8080
    show_transition "Проверка системных портов..." 2
    check_and_free_port 8080
    
    # Обновление пакетов
    show_transition "Подготовка к обновлению системных пакетов..." 2
    log "INFO" "Обновление пакетов..."
    if ! (sudo bash -c 'ulimit -n 65535; apt-get update -y' 2>&1 | grep -v "NO_PUBKEY\|WARNING\|legacy\|DEPRECATION" > /tmp/gaianet_install.log); then
        # Проверяем, есть ли реальные ошибки (не связанные с ключами Docker)
        if grep -q "^E:" /tmp/gaianet_install.log; then
            log "ERROR" "Ошибка при обновлении пакетов"
            log "ERROR" "Детали ошибки:"
            cat /tmp/gaianet_install.log
            exit 1
        fi
    fi
    show_progress_bar 2
    
    # Установка ноды
    show_transition "Загрузка и установка GaiaNet..." 2
    log "INFO" "Установка GaiaNet ноды..."
    if ! curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash > /tmp/gaianet_install.log 2>&1; then
        log "ERROR" "Ошибка при установке ноды"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_install.log
        exit 1
    fi
    show_progress_bar 2
    
    # Обновление переменных окружения
    show_transition "Настройка переменных окружения..." 2
    log "INFO" "Обновление переменных окружения..."
    export PATH="$HOME/gaianet/bin:$PATH"
    export WASMEDGE_PLUGIN_PATH="/root/.wasmedge/plugin"
    source /root/.wasmedge/env
    show_progress_bar 1
    
    # Проверка установки с полным путем
    if ! $HOME/gaianet/bin/gaianet --version &>/dev/null; then
        log "ERROR" "Команда gaianet не найдена после установки"
        log "ERROR" "Проверьте содержимое лога установки:"
        cat /tmp/gaianet_install.log
        exit 1
    fi
    
    # Инициализация конфигурации
    show_transition "Инициализация конфигурации ноды..." 2
    log "INFO" "Инициализация конфигурации..."
    if ! gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json > /tmp/gaianet_init.log 2>&1; then
        log "ERROR" "Ошибка при инициализации конфигурации"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_init.log
        exit 1
    fi
    show_progress_bar 2
    
    # Настройка доменов
    show_transition "Настройка доменов..." 2
    log "INFO" "Настройка доменов..."
    if [ ! -f "/tmp/gaianet_domain" ]; then
        log "ERROR" "Файл с доменом не найден"
        exit 1
    fi

    custom_domain=$(cat /tmp/gaianet_domain)
    if ! (gaianet config --domain "gaia.domains" && gaianet init) > /tmp/gaianet_config.log 2>&1; then
        log "ERROR" "Ошибка при настройке домена"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_config.log
        exit 1
    fi
    log "SUCCESS" "Установлен домен: $custom_domain"
    show_progress_bar 1
    
    # Сохранение информации о ноде
    show_transition "Получение информации о ноде..." 2
    log "INFO" "Получение информации о ноде..."
    local node_info
    if ! node_info=$(gaianet info 2>/tmp/gaianet_info.log); then
        log "ERROR" "Ошибка при получении информации о ноде"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_info.log
        exit 1
    fi
    
    local node_id=$(echo "$node_info" | grep "Node ID" | awk '{print $NF}')
    local device_id=$(echo "$node_info" | grep "Device ID" | awk '{print $NF}')
    
    if [[ -z "$node_id" || -z "$device_id" ]]; then
        log "ERROR" "Не удалось получить Node ID или Device ID"
        log "ERROR" "Вывод команды gaianet info:"
        echo "$node_info"
        exit 1
    fi
    
    echo -e "Node ID: $node_id\nDevice ID: $device_id" > "$HOME/gaianet_info.txt"
    show_progress_bar 1
    
    # Создание и запуск сервисов
    show_transition "Настройка системных сервисов..." 2
    
    # Создаем сервис ноды
    log "INFO" "Настройка сервиса ноды..."
    create_service
    
    # Создаем и запускаем чат-бот
    log "INFO" "Настройка чат-бота..."
    create_chat_script
    
    show_progress_bar 2
    
    # Проверяем статус сервисов
    if systemctl is-active --quiet gaianet.service && systemctl is-active --quiet gaianet-chat.service; then
        log "SUCCESS" "Все сервисы успешно запущены"
    else
        log "WARNING" "Проверьте статус сервисов: systemctl status gaianet.service gaianet-chat.service"
    fi
    
    # Финальное сообщение
    echo
    echo -e "\033[38;5;82m╔════════════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;5;82m║                    УСТАНОВКА ЗАВЕРШЕНА!                        ║\033[0m"
    echo -e "\033[38;5;82m╚════════════════════════════════════════════════════════════════╝\033[0m"
    sleep 1
    
    log "SUCCESS" "Установка завершена успешно!"
    log "INFO" "Информация о ноде сохранена в: $HOME/gaianet_info.txt"
    log "INFO" "Логи чата доступны в: /var/log/gaianet/chat.log"
    log "INFO" "Статистика чата в: /var/log/gaianet/stats.json"
}

# Удаление ноды
remove_node() {
    print_logo
    
    show_transition "Подготовка к удалению ноды..." 2
    log "WARNING" "Удаление ноды GaiaNet..."
    
    # Останавливаем все сервисы
    if systemctl is-active --quiet gaianet.service || systemctl is-active --quiet gaianet-chat.service; then
        show_transition "Остановка сервисов..." 2
        systemctl stop gaianet.service 2>/dev/null
        systemctl stop gaianet-chat.service 2>/dev/null
        show_progress_bar 1
    fi
    
    # Удаление сервисов systemd
    show_transition "Удаление системных сервисов..." 2
    if [ -f "/etc/systemd/system/gaianet.service" ]; then
        systemctl disable gaianet.service 2>/dev/null
        rm -f /etc/systemd/system/gaianet.service
    fi
    if [ -f "/etc/systemd/system/gaianet-chat.service" ]; then
        systemctl disable gaianet-chat.service 2>/dev/null
        rm -f /etc/systemd/system/gaianet-chat.service
    fi
    systemctl daemon-reload
    show_progress_bar 1
    
    # Удаление Python-зависимостей
    show_transition "Удаление Python-зависимостей..." 2
    pip3 uninstall -y requests faker &>/dev/null
    show_progress_bar 1
    
    # Удаление файлов и директорий
    show_transition "Удаление файлов..." 2
    # Удаляем файлы ноды
    rm -rf $HOME/.gaianet
    rm -rf $HOME/gaianet
    rm -f $HOME/gaianet_info.txt
    # Удаляем файлы чат-бота
    rm -rf /var/log/gaianet
    rm -rf /root/gaianet/chat
    rm -f /tmp/gaianet_domain
    # Удаляем временные файлы
    rm -f /tmp/gaianet_*.log
    show_progress_bar 2
    
    echo
    echo -e "\033[38;5;196m╔════════════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;5;196m║                     УДАЛЕНИЕ ЗАВЕРШЕНО                         ║\033[0m"
    echo -e "\033[38;5;196m╚════════════════════════════════════════════════════════════════╝\033[0m"
    sleep 1
    
    log "SUCCESS" "Нода и все компоненты успешно удалены"
}

# Запуск ноды
run_node() {
    print_logo
    
    if ! command -v gaianet &>/dev/null; then
        log "ERROR" "Нода не установлена"
        type_text "Для установки используйте команду: ${USAGE_PREFIX} install" 0.03
        exit 1
    fi
    
    if pgrep -f "gaianet start" > /dev/null; then
        log "WARNING" "Нода уже запущена"
        show_node_status
        exit 0
    fi
    
    show_transition "Инициализация запуска ноды..." 2
    log "INFO" "Запуск ноды GaiaNet..."
    
    if ! gaianet start > /tmp/gaianet_start.log 2>&1 & then
        log "ERROR" "Ошибка при запуске ноды"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_start.log
        exit 1
    fi
    
    show_progress_bar 3
    
    # Проверяем, запустилась ли нода
    sleep 2
    if pgrep -f "gaianet start" > /dev/null; then
        echo
        echo -e "\033[38;5;82m╔════════════════════════════════════════╗\033[0m"
        echo -e "\033[38;5;82m║           НОДА ЗАПУЩЕНА                ║\033[0m"
        echo -e "\033[38;5;82m╚════════════════════════════════════════╝\033[0m"
        show_node_status
        log "SUCCESS" "Нода успешно запущена"
    else
        log "ERROR" "Не удалось запустить ноду"
        log "ERROR" "Проверьте логи: /tmp/gaianet_start.log"
        exit 1
    fi
}

# Остановка ноды
stop_node() {
    print_logo
    
    if ! pgrep -f "gaianet start" > /dev/null; then
        log "ERROR" "Нода не запущена"
        show_node_status
        exit 1
    fi
    
    show_transition "Подготовка к остановке ноды..." 2
    log "INFO" "Остановка ноды GaiaNet..."
    
    if ! gaianet stop > /tmp/gaianet_stop.log 2>&1; then
        log "ERROR" "Ошибка при остановке ноды"
        log "ERROR" "Детали ошибки:"
        cat /tmp/gaianet_stop.log
        exit 1
    fi
    
    show_progress_bar 2
    
    # Проверяем, остановилась ли нода
    sleep 2
    if ! pgrep -f "gaianet start" > /dev/null; then
        echo
        echo -e "\033[38;5;196m╔════════════════════════════════════════╗\033[0m"
        echo -e "\033[38;5;196m║           НОДА ОСТАНОВЛЕНА             ║\033[0m"
        echo -e "\033[38;5;196m╚════════════════════════════════════════╝\033[0m"
        log "SUCCESS" "Нода успешно остановлена"
    else
        log "ERROR" "Не удалось остановить ноду"
        exit 1
    fi
}

# Добавляем функцию проверки статуса
status_node() {
    print_logo
    show_transition "Проверка статуса ноды..." 2
    show_node_status
}

# Функция создания скрипта общения
create_chat_script() {
    local script_dir="/root/gaianet/chat"
    local script_file="${script_dir}/chat_bot.py"
    local service_file="/etc/systemd/system/gaianet-chat.service"
    
    # Создаем директорию
    mkdir -p "${script_dir}"
    
    # Получаем домен
    local domain=$(cat /tmp/gaianet_domain)
    
    # Создаем скрипт Python с правильным URL
    cat > "${script_file}" << EOF
#!/usr/bin/env python3
import requests
import random
import logging
import time
import json
from datetime import datetime
from pathlib import Path

# Настройка логирования
log_dir = Path('/var/log/gaianet')
log_dir.mkdir(parents=True, exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(message)s',
    handlers=[
        logging.FileHandler(log_dir / 'chat.log'),
        logging.StreamHandler()
    ]
)

# Читаем домен из файла
try:
    with open('/tmp/gaianet_domain', 'r') as f:
        domain = f.read().strip()
    node_url = f"https://{domain}.gaia.domains/v1/chat/completions"
    logging.info(f"Using URL: {node_url}")
except Exception as e:
    logging.error(f"Failed to read domain: {e}")
    exit(1)

headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
}

# Статистика запросов
stats = {
    "total_requests": 0,
    "successful_requests": 0,
    "failed_requests": 0,
    "start_time": datetime.now().isoformat()
}

def save_stats():
    try:
        with open(log_dir / 'stats.json', 'w') as f:
            json.dump(stats, f, indent=2)
    except Exception as e:
        logging.error(f"Failed to save stats: {e}")

def send_message(message):
    try:
        response = requests.post(node_url, json=message, headers=headers, timeout=30)
        response.raise_for_status()
        stats["successful_requests"] += 1
        return response.json()
    except Exception as e:
        logging.error(f"Request failed: {e}")
        stats["failed_requests"] += 1
        return None
    finally:
        stats["total_requests"] += 1
        save_stats()

def generate_question():
    templates = [
        "What are your thoughts on {}?",
        "Can you explain how {} works?",
        "What's the relationship between {} and {}?",
        "Why is {} important for {}?"
    ]
    topics = [
        "artificial intelligence", "blockchain", "quantum computing",
        "machine learning", "neural networks", "cryptocurrency",
        "web3", "decentralized systems", "privacy", "security"
    ]
    template = random.choice(templates)
    if template.count('{}') == 1:
        return template.format(random.choice(topics))
    return template.format(random.choice(topics), random.choice(topics))

def main():
    consecutive_errors = 0
    
    while True:
        try:
            question = generate_question()
            message = {
                "messages": [
                    {"role": "system", "content": "You are a helpful assistant."},
                    {"role": "user", "content": question}
                ]
            }

            logging.info(f"Q: {question}")
            
            response = send_message(message)
            if response and 'choices' in response:
                reply = response['choices'][0]['message']['content']
                logging.info(f"A: {reply}")
                consecutive_errors = 0
                delay = random.randint(180, 300)  # 3-5 минут
            else:
                consecutive_errors += 1
                if consecutive_errors >= 3:
                    logging.error("Too many consecutive errors, sleeping for 10 minutes")
                    time.sleep(600)
                    consecutive_errors = 0
                delay = random.randint(300, 600)  # 5-10 минут при ошибке

            logging.info(f"Waiting {delay} seconds")
            time.sleep(delay)

        except Exception as e:
            logging.error(f"Unexpected error: {e}")
            time.sleep(300)

if __name__ == "__main__":
    main()
EOF

    # Делаем скрипт исполняемым
    chmod +x "${script_file}"
    
    # Создаем сервисный файл - теперь не нужно передавать никаких параметров
    cat > "${service_file}" << EOF
[Unit]
Description=GaiaNet Chat Bot Service
After=network.target gaianet.service

[Service]
Type=simple
User=root
ExecStart=/usr/bin/python3 ${script_file}
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    # Обновляем systemd
    systemctl daemon-reload
    systemctl enable gaianet-chat.service
    systemctl start gaianet-chat.service
    
    log "SUCCESS" "Скрипт чата установлен и запущен"
    log "INFO" "Логи доступны в: /var/log/gaianet/chat.log"
    log "INFO" "Статистика в: /var/log/gaianet/stats.json"
}

# Обновляем основную логику
VERSION="1.0.0"

# Получаем реальное имя скрипта
SCRIPT_NAME=$(basename "$0")

# Определяем способ запуска
if [[ "$0" == *"fd"* ]]; then
    USAGE_PREFIX="bash <(curl -s https://scripts.xnod3.com/nodes/gaianet.sh)"
else
    USAGE_PREFIX="./${SCRIPT_NAME}"
fi

case "$1" in
    "install")
        install_node
        ;;
    "remove")
        remove_node
        ;;
    "start")
        run_node
        ;;
    "stop")
        stop_node
        ;;
    "test")
        if [ -z "$2" ]; then
            # Пытаемся получить node_id из существующего файла
            if [ -f "$HOME/gaianet_info.txt" ]; then
                node_id=$(grep "Node ID" "$HOME/gaianet_info.txt" | awk '{print $NF}')
            fi
            
            if [ -z "$node_id" ]; then
                log "ERROR" "Укажите node_id: ${USAGE_PREFIX} test <node_id>"
                exit 1
            fi
        else
            node_id="$2"
        fi
        
        # Создаем временный тестовый скрипт
        test_script="/tmp/chat_test.py"
        log "INFO" "Создание тестового скрипта..."
        
        # Копируем только необходимый код для теста
        cat > "$test_script" << 'EOF'
#!/usr/bin/env python3
import requests
import json
import sys
import subprocess
import logging
import re

def clean_node_id(node_id: str) -> str:
    # Регулярное выражение для удаления ANSI escape последовательностей
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    return ansi_escape.sub('', node_id)

logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger(__name__)

def test_chat(node_id: str):
    node_id = clean_node_id(node_id)
    url = f"https://{node_id}.gaia.domains/v1/chat/completions"
    test_message = "Hello, this is a test message. Please respond with 'Test successful' if you receive this."
    
    logger.info(f"Testing chat API for node: {node_id}")
    logger.info(f"URL: {url}")
    
    payload = {
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful assistant."
            },
            {
                "role": "user",
                "content": test_message
            }
        ]
    }
    
    curl_cmd = [
        'curl',
        '-X', 'POST',
        url,
        '-H', 'accept: application/json',
        '-H', 'Content-Type: application/json',
        '-d', json.dumps(payload)
    ]
    
    logger.info("Sending test request...")
    logger.info(f"Command: {' '.join(curl_cmd)}")
    
    result = subprocess.run(curl_cmd, capture_output=True, text=True)
    
    logger.info(f"Return code: {result.returncode}")
    if result.stdout:
        logger.info(f"Response: {result.stdout}")
    if result.stderr:
        logger.info(f"Errors: {result.stderr}")
    
    return result.returncode == 0 and result.stdout

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python chat_test.py <node_id>")
        sys.exit(1)
    
    if test_chat(sys.argv[1]):
        print("Test completed successfully!")
        sys.exit(0)
    else:
        print("Test failed!")
        sys.exit(1)
EOF

        chmod +x "$test_script"
        log "INFO" "Запуск тестового скрипта..."
        python3 "$test_script" "$node_id"
        rm -f "$test_script"
        ;;
    "reinstall-chat")
        print_logo
        log "INFO" "Переустановка чат-бота..."
        
        # Получаем node_id из файла
        if [ ! -f "$HOME/gaianet_info.txt" ]; then
            log "ERROR" "Файл с информацией о ноде не найден"
            exit 1
        fi
        node_id=$(grep "Node ID" "$HOME/gaianet_info.txt" | awk '{print $NF}')
        
        # Останавливаем сервис чата
        log "INFO" "Остановка сервиса чата..."
        systemctl stop gaianet-chat.service
        
        # Удаляем старые файлы чата
        log "INFO" "Удаление старых файлов..."
        rm -rf /root/gaianet/chat
        rm -f /etc/systemd/system/gaianet-chat.service
        
        # Создаем новый скрипт чата
        log "INFO" "Установка нового скрипта чата..."
        create_chat_script
        
        log "SUCCESS" "Чат-бот успешно переустановлен"
        ;;
    *)
        print_logo
        type_text "GaiaNet Node Installer v${VERSION}" 0.03
        type_text "Powered by XNOD3" 0.03
        echo
        echo -e "${BOLD}Использование:${NC}"
        echo "  ${USAGE_PREFIX} install      - Установить ноду"
        echo "  ${USAGE_PREFIX} remove       - Удалить ноду"
        echo "  ${USAGE_PREFIX} start        - Запустить ноду"
        echo "  ${USAGE_PREFIX} stop         - Остановить ноду"
        echo "  ${USAGE_PREFIX} test [node_id] - Протестировать API чата"
        echo "  ${USAGE_PREFIX} reinstall-chat - Переустановить чат-бот"
        exit 1
        ;;
esac

exit 0 
