@echo off
title Admin and Guest
REM Disable users to log in as Admin and Guest
net user administrator /active:no
net user guest /active:no
title Firewall
REM Turns on Firewall
netsh advfirewall set allprofiles state on
title Telnet
REM Disables user input and feedback from telnet (Telnet)
DISM /online /disable-feature /featurename:TelnetServer
DISM /online /disable-feature /featurename:TelnetClient
REM stops the service (Telnet)
sc stop "TlnctSvr"
sc config "TlntSvr" start=disabled
title Remote Desktop
REM Disables all of the remote desktop related services
sc stop "TermService"
sc config "TermService" start = disabled
sc stop "SessionEnv"
sc config "SessionEnv" start = disabled
sc stop "UmRdpService"
sc config "UmRdpService" start = disabled
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start = disabled
REM Disables the actual remote desktop program
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d l /f
title Lock-Out Policy
REM changes the account lockout policy + Password Requirements
net accounts /lockoutthreshold:5 /MINPWLEN:8 /MAXPWAGE:30 /MINPWAGE:1 /UNIQUEPW:5
title Enable Updates
REM This registry key enables updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f
REM Pause so the cmd line doesnt automatically clear the screen, so we can analyze what happened while running the script
pause
