#!/bin/bash

# font colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

# ตรวจสอบสิทธิ์ Root
if [ "$EUID" -ne 0 ]; then
    exec sudo bash "$0" "$@"
    exit
fi

clear
echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat
echo ""
echo ""
echo -e "=================================================="
echo -e "         ระบบเช็กปริมาณการใช้งานอินเทอร์เน็ต (UDP)"
echo -e "=================================================="
printf "  %-18s | %-20s\n" "ชื่อผู้ใช้ (User)" "เน็ตที่ใช้ไป (Usage)"
echo -e "=================================================="

# ตรวจสอบประวัติการใช้งานจาก Log ของ udp-custom โดยจับคู่ IP/User ทราฟฟิก
LOG_FILE="/root/udp/udp-custom.log"

while read -r user; do
    user_id=$(id -u "$user" 2>/dev/null)
    if [ "$user_id" -ge 1000 ] && [ "$user" != "nobody" ]; then
        
        bytes=0
        # วิธีที่ 1: ดึงจากสถิติของระบบภายใน Log ถ้ามีบันทึกไว้
        if [ -f "$LOG_FILE" ]; then
            bytes=$(grep -i "transfer" "$LOG_FILE" 2>/dev/null | grep -i "$user" | awk '{sum+=$5} END {print sum}')
        fi
        
        # วิธีที่ 2: ดึงจากข้อมูล Accounting ของระบบ (กรณีวิธีแรกเป็น 0)
        if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
            # ดึงข้อมูลจาก journalctl ที่มีการคุยกันของคู่สถานะ
            bytes=$(journalctl -u udp-custom --since "1 days ago" --no-pager 2>/dev/null | grep -i "$user" | grep -oE '[0-9]+ bytes' | awk '{sum+=$1} END {print sum}')
        fi

        # หากผู้ใช้พึ่งเชื่อมต่อหรือยังไม่มีประวัติในรอบวัน
        if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
            usage_display="0 KB (ยังไม่มีทราฟฟิก)"
        else
            # คำนวณและแปลงหน่วยทราฟฟิก
            if [ "$bytes" -gt 1073741824 ]; then
                gb=$(echo "scale=2; $bytes / 1073741824" | bc)
                usage_display="${GREEN}${gb} GB${ENDCOLOR}"
            elif [ "$bytes" -gt 1048576 ]; then
                mb=$(echo "scale=2; $bytes / 1048576" | bc)
                usage_display="${YELLOW}${mb} MB${ENDCOLOR}"
            else
                kb=$(echo "scale=2; $bytes / 1024" | bc)
                usage_display="${kb} KB"
            fi
        fi
        
        printf "  %-18s | %-20b\n" "$user" "$usage_display"
    fi
done < <(cut -d: -f1 /etc/passwd)

echo -e "=================================================="
echo ""
echo -e "กด Enter เพื่อกลับไปที่เมนูหลัก"; read -r
menu
