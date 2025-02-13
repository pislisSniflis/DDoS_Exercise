FROM kalilinux/kali-rolling:latest
RUN apt update && apt install -y hping3 slowloris kali-linux-headless net-tools
CMD ["/bin/bash"]