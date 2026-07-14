#!/bin/bash
clear
echo "==================================================" | lolcat
echo "                  ★ SSLAB SSH ★                    " | lolcat
echo "==================================================" | lolcat
echo ""

# ดึงไอพีของเครื่อง VPS อัตโนมัติ (ไม่ว่าจะรันบนเครื่องไหน)
MYIP=$(wget -qO- ipinfo.io/ip || curl -s api.ipify.org || echo "IP_NOT_FOUND")

read -p " • ระบุชื่อผู้ใช้งาน : " username

# ตรวจสอบว่ามีผู้ใช้งานนี้อยู่แล้วหรือไม่
if id "$username" &>/dev/null; then
    echo ""
    echo "ชื่อผู้ใช้งานนี้มีอยู่ในระบบแล้ว!" | lolcat
    sleep 2
    menu
    exit 1
fi

read -p " • ต้องการสุ่มรหัสผ่านหรือไม่? (y/n) : " random_password
if [[ "$random_password" = "y" || "$random_password" = "Y" ]]; then
    password=$(openssl rand -base64 6 | cut -c1-8)
    echo " • รหัสผ่านที่สุ่มได้ : $password"
else
    read -p " • ระบุรหัสผ่าน (กรุณาใช้รหัสผ่านที่เดายาก) : " password
fi

read -p " • ระบุจำนวนวันที่ใช้งานได้ (วันหมดอายุ) : " days
read -p " • จำกัดจำนวนการเข้าใช้งานพร้อมกัน : " maxlog

if [ -z "$username" ] || [ -z "$password" ] || [ -z "$days" ] || [ -z "$maxlog" ]; then
    echo ""
    echo "กรุณากรอกข้อมูลให้ครบถ้วน!" | lolcat
    sleep 2
    exit 1
fi

# สร้างยูสเซอร์ในระบบ
useradd -e $(date -d "$days days" +"%Y-%m-%d") -s /bin/false -M $username
echo "$username:$password" | chpasswd

exp=$(chage -l $username | grep "Account expires" | cut -d: -f2)
exp_date=$(date -d "$exp" +"%Y-%m-%d")

clear
echo "==================================================" | lolcat
echo " • ชื่อผู้ใช้งาน : $username"
echo " • รหัสผ่าน : $password"
echo " • วันหมดอายุ : $exp_date"
echo " • ล็อกอินพร้อมกันสูงสุด : $maxlog"
echo "==================== Port ========================" | lolcat
echo ""
echo " • Badvpn    : 1-65535"
echo ""
echo "========= Http Custom UDP =========" | lolcat
echo ""
echo " ${MYIP}:1-65535@$username:$password"
echo ""
echo "==================================================" | lolcat
echo " >> ติดต่อบน Telegram : @shaystudiolab"
echo " >> ติดต่อบน Github : @noobconner21"
echo "==================================================" | lolcat
echo ""
read -p " กดปุ่ม Enter เพื่อกลับสู่เมนูหลัก "
menu
