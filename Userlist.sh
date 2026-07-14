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
echo -e "=================================================="
echo -e "         รายชื่อผู้ใช้งานและวันหมดอายุทั้งหมด"
echo -e "=================================================="
echo -e "  ชื่อผู้ใช้ (Username)     |     วันหมดอายุ (Expire)"
echo -e "=================================================="

while read user; do
    # คัดกรองเฉพาะผู้ใช้ระบบปกติ ไม่รวมระบบของ OS
    user_id=$(id -u "$user" 2>/dev/null)
    if [ "$user_id" -ge 1000 ] && [ "$user" != "nobody" ]; then
        expire_date=$(chage -l "$user" | grep "Account expires" | cut -d: -f2)
        if echo "$expire_date" | grep -q "never"; then
            expire_display="ไม่มีวันหมดอายุ"
        else
            expire_display=$(date -d "$expire_date" "+%Y-%m-%d" 2>/dev/null)
            [ -z "$expire_display" ] && expire_display="ไม่ระบุ"
        fi
        printf "  %-25s |     %s\n" "$user" "$expire_display"
    fi
done < <(cut -d: -f1 /etc/passwd)

echo -e "=================================================="
echo ""
echo -e "กด Enter เพื่อกลับไปที่เมนูหลัก"; read
menu
