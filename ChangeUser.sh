#!/bin/bash

#font colors
IP=$(cat /etc/IP)
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
#add users
echo ""
echo ""
echo -ne "${YELLOW}ใส่ชื่อผู้ใช้งาน (Username) ที่ต้องการแก้ไข: "; read username
while true; do
    read -p "คุณต้องการให้ระบบสุ่มรหัสผ่านใหม่ให้หรือไม่? (Y/N): " yn
    case $yn in
        [Yy]* ) password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-9};echo;); break;;
        [Nn]* ) echo -ne "กรอกรหัสผ่านใหม่ที่คุณต้องการ (แนะนำรหัสที่คาดเดายาก): "; read password; break;;
        * ) echo "กรุณาตอบ Y (ใช่) หรือ N (ไม่ใช่)";;
    esac
done
echo -ne "จำนวนวันที่ต้องการต่ออายุ (เช่น 30 วัน): ";read nod
exd=$(date +%F  -d "$nod days")
chage -E $exd $username && echo "$username:$password" | chpasswd &&
clear &&
echo -e  "${YELLOW} กำลังบันทึกข้อมูลการแก้ไข กรุณารอครู่หนึ่ง..."
sleep 3
clear
echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat

echo ""
echo ""
echo -e "========== รายละเอียดบัญชี SSH & OVPN =========="
echo -e ""
echo -e ""
echo -e "${GREEN}\n• หมายเลข IP เซิร์ฟเวอร์ : ${YELLOW}$s_ip"
echo -e "${GREEN}\n• ชื่อผู้ใช้งาน (Username) :${YELLOW} $username"
echo -e "${GREEN}\n• รหัสผ่านใหม่ (Password) :${YELLOW} $password"
echo -e "${GREEN}\n• วันที่หมดอายุ (Expire Date) :${YELLOW} $exd"
echo -e "${GREEN}\n• ล็อกอินพร้อมกันสูงสุด (Max Login) :${YELLOW} $maxlogins${ENDCOLOR}"
#echo -e "======================================="
echo -e ""
#echo -e ""
echo -e "================= พอร์ต (Port) ================="
echo -e ""
echo -e "${GREEN}\n• Badvpn    : ${YELLOW}1-65535${ENDCOLOR}"
echo -e ""
echo -e "========== รูปแบบ Http Custom UDP ==========="
echo -e " "
echo -e "$s_ip:1-65535@$username:$password"
echo -e ""
echo -e "======================================="
echo""
echo -e " >> ช่องทางติดต่อ Telegram : @shaystudiolab"
echo -e " >> เครดิตผู้พัฒนา Github : @noobconner21"
echo""
echo -e "======================================="
#echo -e "${RED}\nFailed to add user $username please try again."
echo ""
echo ""
#echo -e "${RED}\nFailed to modify user $username please try again.${ENDCOLOR}"

#return to panel

echo -e "\nกด Enter เพื่อกลับไปที่เมนูหลัก"; read
menu
