@echo off
setlocal enabledelayedexpansion
if !errorlevel! equ 0 (
    echo docker start success
    :: 查询IP是否存在
    wsl -u root ip addr | findstr "199.9.6.7" > nul
    if !errorlevel! equ 0 (
        echo wsl ip has set
    ) else (
        ::设置IP两种方法
        ::方法一需已经添加虚拟网卡TAP
        wsl -u root  tunctl -b
        wsl -u root  tunctl -b
        wsl -u root  ip link set tap0 up
        wsl -u root  ip link set tap1 up
        wsl -u root  ip addr add 199.9.6.7/24  broadcast 199.9.6.255 dev tap0
        wsl -u root  ip addr add 199.9.6.8/24  broadcast 199.9.6.255 dev tap1
        ::方法二
        wsl -u root  ip addr add 199.9.6.6/24  broadcast 199.9.6.255 dev eth0 label eth0:1

        
        echo set wsl ip success: 199.9.6.7,199.9.6.8
    )


    ::windows作为wsl的宿主，在wsl的固定IP的同一网段也给安排另外一个IP
    ipconfig | findstr "199.9.6.70" > nul
    if !errorlevel! equ 0 (
        echo windows ip has set
    ) else (
        netsh interface ip add address "vEthernet (WSL)" 199.9.6.70 255.255.255.0
        echo set windows ip success: 199.9.6.70
    )
)