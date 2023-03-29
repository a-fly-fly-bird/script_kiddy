wget -O clash.gz https://github.com/Dreamacro/clash/releases/download/v1.14.0/clash-linux-amd64-v3-v1.14.0.gz
gzip -f clash.gz -d 
chmod +x clash
./clash
# 手动下载配置文件（改名为~/.config/clash/config.yaml）和Country.yaml(~/.config/clash/Country.yaml)
nohup ./clash &
