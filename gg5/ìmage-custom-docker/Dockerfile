FROM ubuntu:latest
run apt update && apt install -y nano
workdir /personale
copy script.sh .
run chmod 775 script.sh
run ./script.sh
EXPOSE 80