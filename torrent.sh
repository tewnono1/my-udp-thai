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
echo -e "       ระบบจัดการบล็อก/ปลดบล็อก บิททอร์เรนต์ (BitTorrent)"
echo -e "=================================================="
echo -e "  [1] สั่งบล็อก บิททอร์เรนต์ (Block Torrent)"
echo -e "  [2] ปลดบล็อก บิททอร์เรนต์ (Unblock Torrent)"
echo -e "=================================================="
echo ""
echo -ne "${YELLOW}เลือกเมนูที่ต้องการใช้งาน [1-2]: ${ENDCOLOR}"; read x

if [ "$x" = "1" ]; then
    clear
    echo -e "${RED}กำลังทำการตั้งค่าบล็อกพอร์ตและแพ็กเกจ BitTorrent...${ENDCOLOR}"
    sleep 1
    # สั่งบล็อกพอร์ต Torrent มาตรฐานและคำสั่ง P2P
    iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
    iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
    iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
    iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
    iptables -A FORWARD -m string --algo bm --string "get_peers" -j DROP
    iptables -A FORWARD -m string --algo bm --string "find_node" -j DROP
    
    echo -e "${GREEN}\n======================================="
    echo -e "   [สำเร็จ] บล็อกบิททอร์เรนต์เรียบร้อยแล้ว!"
    echo -e "=======================================${ENDCOLOR}"
    
elif [ "$x" = "2" ]; then
    clear
    echo -e "${YELLOW}กำลังทำการล้างกฎเพื่อปลดบล็อก BitTorrent...${ENDCOLOR}"
    sleep 1
    # ล้างกฎ iptables ที่บล็อกออก
    iptables -F FORWARD
    
    echo -e "${GREEN}\n======================================="
    echo -e "   [สำเร็จ] ปลดบล็อกบิททอร์เรนต์เรียบร้อยแล้ว!"
    echo -e "=======================================${ENDCOLOR}"
else
    echo -e "${RED}\nเลือกเมนูไม่ถูกต้อง กำลังกลับสู่เมนูหลัก...${ENDCOLOR}"
    sleep 2
    menu
fi

echo -e "\nกด Enter เพื่อกลับไปที่เมนูหลัก"; read
menu
