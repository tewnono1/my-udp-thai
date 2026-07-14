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
echo ""
echo -e "=================================================="
echo -e "         ระบบเช็กปริมาณการใช้งานอินเทอร์เน็ต (UDP)"
echo -e "=================================================="
printf "  %-18s | %-20s\n" "ชื่อผู้ใช้ (User)" "เน็ตที่ใช้ไป (Usage)"
echo -e "=================================================="

# ตรวจสอบว่ามีไฟล์ Log ของ udp-custom หรือไม่
LOG_FILE="/root/udp/udp-custom.log"

if [ ! -f "$LOG_FILE" ]; then
    # ถ้าไม่มี log หลัก ลองหาจากระบบ systemd journal
    journalctl -u udp-custom --no-pager | grep -E "bytes sent|transfer" > /tmp/udp_tx.log
    LOG_FILE="/tmp/udp_tx.log"
fi

# ลูปหาผู้ใช้ระบบปกติเพื่อเช็กทราฟฟิก
while read user; do
    user_id=$(id -u "$user" 2>/dev/null)
    if [ "$user_id" -ge 1000 ] && [ "$user" != "nobody" ]; then
        
        # ค้นหาข้อมูลการรับส่งข้อมูลของ User นั้นจาก Log (สมมุติตัวแปรคำนวณทราฟฟิกพื้นฐาน)
        # หมายเหตุ: เนื่องจากระบบเก็บ log ต่างกัน สคริปต์จะดึงค่า byte ที่จับคู่กับ user นั้นๆ
        bytes=$(grep -i "$user" "$LOG_FILE" 2>/dev/null | grep -oE '[0-8]+ bytes' | awk '{sum+=$1} END {print sum}')
        
        if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
            usage_display="0 KB (ยังไม่มีทราฟฟิก)"
        else
            # แปลงหน่วยเป็น MB หรือ GB
            if [ "$bytes" -gt 1073741824 ]; then
                gb=$(echo "scale=2; $bytes / 1073741824" | bc)
                usage_display="${GREEN}${gb} GB${ENDCOLOR}"
            else
                mb=$(echo "scale=2; $bytes / 1048576" | bc)
                usage_display="${YELLOW}${mb} MB${ENDCOLOR}"
            fi
        fi
        
        printf "  %-18s | %-20b\n" "$user" "$usage_display"
    fi
done < <(cut -d: -f1 /etc/passwd)

echo -e "=================================================="
echo ""
echo -e "กด Enter เพื่อกลับไปที่เมนูหลัก"; read
menu
