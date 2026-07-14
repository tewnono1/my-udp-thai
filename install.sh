#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
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
cd /etc/Sslablk
wget https://github.com/tewnono1/my-udp-thai/raw/main/system.zip
unzip -o system
cd /etc/Sslablk/system
chmod +x ChangeUser.sh Adduser.sh DelUser.sh Userlist.sh RemoveScript.sh torrent.sh
rm -f /etc/Sslablk/system/menu
rm -f /etc/Sslablk/system.zip

# โหลดเมนูภาษาไทยที่เราสร้างขึ้นมาใหม่ไปใช้งานตรง ๆ
wget "https://raw.githubusercontent.com/tewnono1/my-udp-thai/main/menu" -O /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# ลิ้งก์คำสั่ง lolcat เผื่อเรียกหาไม่เจอ
ln -s /usr/games/lolcat /usr/usr/bin/lolcat 2>/dev/null; ln -s /usr/games/lolcat /usr/bin/lolcat 2>/dev/null; ln -s /usr/games/lolcat /usr/local/bin/lolcat 2>/dev/null

echo start service udp-custom
systemctl start udp-custom &>/dev/null
systemctl enable udp-custom &>/dev/null

echo reboot
reboot
