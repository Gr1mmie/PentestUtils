#!/bin/zsh

if [ ! -x "$(command -v dotnet)" ];then
	echo "[*] dotnet not detected, beginning installation\n"
else
	echo "[*] dotnet detected, exiting..."
	sleep 1
	exit 1
fi

if [ ! -d '$HOME/dotnet-64' ];then mkdir $HOME/dotnet-64;fi
cwd=$(pwd)

echo "[+] Downloading dotnet5.0"
cd
wget https://download.visualstudio.microsoft.com/download/pr/820db713-c9a5-466e-b72a-16f2f5ed00e2/628aa2a75f6aa270e77f4a83b3742fb8/dotnet-sdk-5.0.100-linux-x64.tar.gz  2>/dev/null
echo "[+] Moving and extracting download to $HOME/dotnet-64"
tar zxf dotnet-sdk-5.0.100-linux-x64.tar.gz -C $HOME/dotnet-64
sleep 1
echo "[+] Checking shell..."
check_shell=$(echo $SHELL)
if [[ $check_shell == "/bin/zsh" ]];then
	echo "[+] zsh detected"
	echo "[+] exporting dotnet to PATH and adding to ~/.zshrc"
	echo 'export DOTNET_ROOT=$HOME/dotnet-64' >> ~/.zshrc
	echo 'export PATH=$HOME/dotnet-64:$PATH' >> ~/.zshrc
	source ~/.zshrc 2>/dev/null
elif [[ $check_shell == "/bin/bash" ]];then
	echo "[+] bash detected"
	echo "[+] exporting dotnet to PATH and adding to ~/.bashrc"
	echo 'export DOTNET_ROOT=$HOME/dotnet-64' >> ~/.bashrc
	echo 'export PATH=$HOME/dotnet-64:$PATH' >> ~/.bashrc
	source ~/.bashrc 2>/dev/null
fi
echo "[+] Cleaning up"
rm dotnet-sdk-5.0.100-linux-x64.tar.gz
echo "[+] Verifying installation"
cd $cwd
dotnet --version
