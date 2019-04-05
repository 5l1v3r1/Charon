# CHARON
# Author: Zane Gittins
# Last Updated: 4/5/2019
#
# Description: Docker container for decoding TrendMicro quarantine 
# files and providing a safe environment to perform light analysis.
#
# Tools:
# (1). TrendMicro .qtn Decode via Wine
# (2). VxAPI
# (3). Radare2
# (4). PowerShell
# (5). Unzip
# (7). Python3
# (9). ExifTool

FROM ubuntu:latest
MAINTAINER Zane Gittins (@ZGittins, https://github.com/zaneGittins)

USER root
RUN dpkg --add-architecture i386 && \
    apt-get update --fix-missing --yes && \ 
    apt-get install --yes \ 
    wine-stable \ 
    python3 \ 
    python3-pip \ 
    libimage-exiftool-perl \ 
    git \ 
    wget \ 
    apt-utils \
    nano \
    unzip \ 
    wine32 && \
    pip3 install -q --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org argparse && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install --yes powershell

RUN wine cmd > /dev/null 2>&1 && \ 
    mkdir ~/.wine/drive_c/Program\ Files/VSEncode && \
    ln -s ~/.wine/drive_c/Program\ Files/VSEncode /opt && \
    git config --global http.sslverify false && \
    git clone https://github.com/PayloadSecurity/VxAPI /opt/VxAPI && \
    git clone https://github.com/radare/radare2 /opt/radare2 && \
    ./opt/radare2/sys/install.sh && \ 
    echo 'export PS1="\[\e[31m\]Charon\[\e[m\] \T \[\e[37;40m\]\W\[\e[m\] > "' >> /root/.bashrc

ADD ["trend/VSEncode.exe", "/root/.wine/drive_c/Program Files/VSEncode/VSEncode.exe"]
ADD ["trend/ofcpipc.dll", "/root/.wine/drive_c/Program Files/VSEncode/ofcpipc.dll"]
ADD ["trend/VSAPI32.DLL", "/root/.wine/drive_c/Program Files/VSEncode/VSAPI32.DLL"]
ADD ["trend/decrypt_location.txt", "/root/.wine/drive_c/Program Files/VSEncode/decrypt_location.txt"]

WORKDIR /opt