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
echo -ne "${YELLOW}ใส่ชื่อผู้ใช้งาน (Username) ที่ต้องการลบ: "; read username
echo ""
echo -e "${RED}กำลังทำการลบผู้ใช้ $username กรุณารอครู่หนึ่ง..."
sleep 2

if userdel -f "$username" &>/dev/null; then
    clear
    echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
    echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
    echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat
    echo ""
    echo ""
    echo -e "${GREEN}=======================================${ENDCOLOR}"
    echo -e "${GREEN}     [สำเร็จ] ลบผู้ใช้งาน $username เรียบร้อยแล้ว!${ENDCOLOR}"
    echo -e "${GREEN}=======================================${ENDCOLOR}"
else
    echo -e "${RED}\n[ข้อผิดพลาด] ไม่สามารถลบผู้ใช้ $username ได้ (อาจไม่มีชื่อนี้ในระบบ) กรุณาลองใหม่อีกครั้ง${ENDCOLOR}"
fi

echo -e "\nกด Enter เพื่อกลับไปที่เมนูหลัก"; read
menu
