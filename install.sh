#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# ==========================================
#  ระบบล็อก IP (ระบุ IP ที่อนุญาตให้รันสคริปต์ได้)
# ==========================================
# อนุญาตให้เฉพาะ IP เครื่องของคุณรันสคริปต์นี้ได้เท่านั้น
ALLOWED_IPS="185.84.161.17"

# ดึง IP ปัจจุบันของ VPS เครื่องที่กำลังรันสคริปต์
MY_IP=$(curl -sS https://ipinfo.io/ip || curl -sS https://api.ipify.org || wget -qO- https://ipv4.icanhazip.com)

# ตรวจสอบสิทธิ์การใช้งาน
ACCESS_GRANTED=false
for ip in $ALLOWED_IPS; do
    if [ "$MY_IP" == "$ip" ]; then
        ACCESS_GRANTED=true
        break
    fi
done

if [ "$ACCESS_GRANTED" = false ]; then
    clear
    echo "=================================================="
    echo -e " \e[31m⛔ ขออภัย! เซิร์ฟเวอร์นี้ไม่มีสิทธิ์ใช้งานสคริปต์นี้\e[0m"
    echo "=================================================="
    echo -e " IP ของเครื่องคุณคือ: \e[33m$MY_IP\e[0m"
    echo -e " กรุณาติดต่อแอดมินผู้ดูแลเพื่อลงทะเบียน IP นี้"
    echo "=================================================="
    exit 1
fi

# ==========================================
#  เริ่มขั้นตอนการติดตั้งตามปกติ
# ==========================================
apt update -y
apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt install lolcat -y
apt install figlet -y
apt install neofetch -y
apt install screenfetch -y
apt install unzip -y
cd
rm -rf /root/udp
mkdir -p /root/udp

# change to time GMT+7 Thailand
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# install udp-custom
wget "https://github.com/tewnono1/my-udp-thai/raw/main/udp-custom-linux-amd64" -O /root/udp/udp-custom
chmod +x /root/udp/udp-custom

wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/config.json" -O /root/udp/config.json
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team and modify by sslablk

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team and modify by sslablk

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

# โหลดไฟล์สคริปต์ย่อย
mkdir -p /etc/Sslablk/system
cd /etc/Sslablk/system

wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/ChangeUser.sh" -O ChangeUser.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/DelUser.sh" -O DelUser.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/Userlist.sh" -O Userlist.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/RemoveScript.sh" -O RemoveScript.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/torrent.sh" -O torrent.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/Adduser.sh" -O Adduser.sh
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/infousers" -O infousers
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/UserUsage.sh" -O UserUsage.sh

# เปิดสิทธิ์ให้ไฟล์ทุกตัวในโฟลเดอร์ทำงานได้
chmod +x *

# โหลดเมนูภาษาไทยไปใช้งานตรง ๆ ในระบบ
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/menu" -O /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# ลิ้งก์คำสั่ง lolcat เผื่อเรียกหาไม่เจอ
ln -s /usr/games/lolcat /usr/usr/bin/lolcat 2>/dev/null; ln -s /usr/games/lolcat /usr/bin/lolcat 2>/dev/null; ln -s /usr/games/lolcat /usr/local/bin/lolcat 2>/dev/null

echo start service udp-custom
systemctl start udp-custom &>/dev/null
systemctl enable udp-custom &>/dev/null

echo reboot
reboot
