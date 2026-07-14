#!/bin/bash

#font colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

clear
echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat
echo ""
#echo -e "                                   ʙʏ ᴘʀᴏᴊᴇᴄᴛ ꜱꜱʟᴀʙ ʟᴋ"
echo ""
echo ""
echo -e "${RED}คุณกำลังจะลบสคริปต์ติดตั้งและระบบทั้งหมดออกจาก VPS เครื่องนี้${ENDCOLOR}"
read -p "คุณต้องการดำเนินการต่อหรือไม่? (Y/N): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    clear
    echo -e "${YELLOW}กำลังหยุดการทำงานและปิดบริการต่างๆ...${ENDCOLOR}"
    sleep 1
    systemctl stop udp-custom &>/dev/null
    systemctl disable udp-custom &>/dev/null
    rm -f /etc/systemd/system/udp-custom.service
    systemctl daemon-reload

    echo -e "${YELLOW}กำลังล้างโฟลเดอร์ระบบทั้งหมด...${ENDCOLOR}"
    sleep 1
    rm -rf /root/udp
    rm -rf /etc/Sslablk

    echo -e "${YELLOW}กำลังถอนการติดตั้งตัวเรียกเมนูหลัก...${ENDCOLOR}"
    sleep 1
    rm -f /usr/local/bin/menu
    rm -f /usr/bin/menu
    rm -f install.sh

    clear
    echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
    echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
    echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat
    echo ""
    echo -e "=================================================="
    echo -e "${GREEN}     [สำเร็จ] ลบสคริปต์และระบบทั้งหมดเรียบร้อยแล้ว!${ENDCOLOR}"
    echo -e "=================================================="
else
    echo -e "${GREEN}\nยกเลิกการลบระบบ กลับสู่เมนูหลัก...${ENDCOLOR}"
    sleep 2
    menu
fi
