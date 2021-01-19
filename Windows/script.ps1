do {
Write-Host "
Type 'exit' to leave script.
0   Set Default Rules
14  Add User
1   Delete user
2   Add user(s) to administrator group
3   Remove user(s) from administrator group
4   Change user's password
5   Password policies
6   Get all filesharing names
7   Stop filesharing name
8   Enabled CTRL-ALT-DEL on login
9   Set basic firewall rules
10  Flush DNS
11  Disable Guest account
12  Enabled/Disable remote desktop
13  Delete uneeded files
15  List all services
16  Disable FTP service
"

$input = Read-host

if($input -eq "0") {
	#Windows automatic updates
	reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AutoInstallMinorUpdates /t REG_DWORD /d 1 /f
	reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate /t REG_DWORD /d 0 /f
	reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 4 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f
	reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 4 /f
	reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v ElevateNonAdmins /t REG_DWORD /d 0 /f
	reg add HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoWindowsUpdate /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\Internet Communication Management\Internet Communication" /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
	reg add HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
	
	#Restrict CD ROM drive
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AllocateCDRoms /t REG_DWORD /d 1 /f
	
	#Disallow remote access to floppy disks
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AllocateFloppies /t REG_DWORD /d 1 /f
	#Disable auto Admin logon
	reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_DWORD /d 0 /f
	#Clear page file (Will take longer to shutdown)
	reg ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f
	#Prevent users from installing printer drivers 
	reg ADD "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers" /v AddPrinterDrivers /t REG_DWORD /d 1 /f
	#Add auditing to Lsass.exe
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe" /v AuditLevel /t REG_DWORD /d 00000008 /f
	#Enable LSA protection
	reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v RunAsPPL /t REG_DWORD /d 00000001 /f
	#Limit use of blank passwords
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f
	#Auditing access of Global System Objects
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v auditbaseobjects /t REG_DWORD /d 1 /f
	#Auditing Backup and Restore
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v fullprivilegeauditing /t REG_DWORD /d 1 /f
	#Restrict Anonymous Enumeration #1
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymous /t REG_DWORD /d 1 /f
	#Restrict Anonymous Enumeration #2
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymoussam /t REG_DWORD /d 1 /f
	#Disable storage of domain passwords
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v disabledomaincreds /t REG_DWORD /d 1 /f
	#Take away Anonymous user Everyone permissions
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v everyoneincludesanonymous /t REG_DWORD /d 0 /f
	#Allow Machine ID for NTLM
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v UseMachineId /t REG_DWORD /d 0 /f
	#Do not display last user on logon
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v dontdisplaylastusername /t REG_DWORD /d 1 /f
	#Enable UAC
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
	#UAC setting (Prompt on Secure Desktop)
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f
	#Enable Installer Detection
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableInstallerDetection /t REG_DWORD /d 1 /f
	#Disable undocking without logon
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v undockwithoutlogon /t REG_DWORD /d 0 /f
	#Enable CTRL+ALT+DEL
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DisableCAD /t REG_DWORD /d 0 /f
	#Max password age
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v MaximumPasswordAge /t REG_DWORD /d 15 /f
	#Disable machine account password changes
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v DisablePasswordChange /t REG_DWORD /d 1 /f
	#Require strong session key
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v RequireStrongKey /t REG_DWORD /d 1 /f
	#Require Sign/Seal
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v RequireSignOrSeal /t REG_DWORD /d 1 /f
	#Sign Channel
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v SignSecureChannel /t REG_DWORD /d 1 /f
	#Seal Channel
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\Netlogon\Parameters /v SealSecureChannel /t REG_DWORD /d 1 /f
	#Set idle time to 45 minutes
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters /v autodisconnect /t REG_DWORD /d 45 /f
	#Require Security Signature - Disabled pursuant to checklist:::
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters /v enablesecuritysignature /t REG_DWORD /d 0 /f
	#Enable Security Signature - Disabled pursuant to checklist:::
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters /v requiresecuritysignature /t REG_DWORD /d 0 /f
	#Clear null session pipes
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters /v NullSessionPipes /t REG_MULTI_SZ /d "" /f
	#Restict Anonymous user access to named pipes and shares
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters /v NullSessionShares /t REG_MULTI_SZ /d "" /f
	#Encrypt SMB Passwords
	reg ADD HKLM\SYSTEM\CurrentControlSet\services\LanmanWorkstation\Parameters /v EnablePlainTextPassword /t REG_DWORD /d 0 /f
	#Clear remote registry paths
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg\AllowedExactPaths /v Machine /t REG_MULTI_SZ /d "" /f
	#Clear remote registry paths and sub-paths
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg\AllowedPaths /v Machine /t REG_MULTI_SZ /d "" /f
	#Enable smart screen for IE8
	reg ADD "HKCU\Software\Microsoft\Internet Explorer\PhishingFilter" /v EnabledV8 /t REG_DWORD /d 1 /f
	#Enable smart screen for IE9 and up
	reg ADD "HKCU\Software\Microsoft\Internet Explorer\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 1 /f
	#Disable IE password caching
	reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DisablePasswordCaching /t REG_DWORD /d 1 /f
	#Warn users if website has a bad certificate
	reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v WarnonBadCertRecving /t REG_DWORD /d 1 /f
	#Warn users if website redirects
	reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v WarnOnPostRedirect /t REG_DWORD /d 1 /f
	#Enable Do Not Track
	reg ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v DoNotTrack /t REG_DWORD /d 1 /f
	reg ADD "HKCU\Software\Microsoft\Internet Explorer\Download" /v RunInvalidSignatures /t REG_DWORD /d 1 /f
	reg ADD "HKCU\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN\Settings" /v LOCALMACHINE_CD_UNLOCK /t REG_DWORD /d 1 /f
	reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v WarnonZoneCrossing /t REG_DWORD /d 1 /f
	#Show hidden files
	reg ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f
	#Disable sticky keys
	reg ADD "HKU\.DEFAULT\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f
	#Show super hidden files
	reg ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSuperHidden /t REG_DWORD /d 1 /f
	#Disable dump file creation
	reg ADD HKLM\SYSTEM\CurrentControlSet\Control\CrashControl /v CrashDumpEnabled /t REG_DWORD /d 0 /f
	#Disable autoruns
	reg ADD HKCU\SYSTEM\CurrentControlSet\Services\CDROM /v AutoRun /t REG_DWORD /d 1 /f
	
Write-Host "Managed registry keys"

} elseif($input -eq "1") {
	Write-Host "Type the name of the user you want to remove:"
	$username = Read-host
	Remove-LocalUser -Name $username
} elseif ($input -eq "2") {
	Write-Host "Type the username(s) you want to add to the admin group. Type 'exit' to go back."
	do {
		$username = Read-host
		if($username -ne "exit") {
			Add-LocalGroupMember -Group "Administrators" -Member $username
		}
	} until ($username -eq "exit")
} elseif ($input -eq "3") {
	Write-Host "Type the username(s) you want to add to the admin group. Type 'exit' to go back."
	do {
		$username = Read-host
		if($username -ne "exit") {
			Remove-LocalGroupMember -Group "Administrators" -Member $username
		}
	} until ($username -eq "exit")
} elseif ($input -eq "4") {
	Write-Host "Changing password(s). Type 'exit' at any time to leave."
	do {
		Write-Host "Username:"
		$username = Read-host
		if($username -eq "exit") { break }
		$useraccount = Get-LocalUser -Name $username
		Write-Host "Password:"
		$password = Read-host -AsSecureString
		if($password -eq "exit") { break }
		$useraccount | Set-LocalUser -Password $password
	} until ($username -eq "exit")
} elseif ($input -eq "5") {
	Write-Host "UNIQUEPW:"
	[int]$in = Read-host
	net accounts /UNIQUEPW:$in
	Write-Host "MINPWLEN:"
	[int]$in = Read-host
	net accounts /MINPWLEN:$in
	Write-Host "MAXPWAGE:"
	[int]$in = Read-host
	net accounts /MAXPWAGE:$in
	Write-Host "MINPWAGE:"
	[int]$in = Read-host
	net accounts /MINPWAGE:$in
	Write-Host "lockoutthreshold:"
	[int]$in = Read-host
	net accounts /lockoutthreshold:$in
	Write-Host "FORCELOGOFF:"
	[int]$in = Read-host
	net accounts /FORCELOGOFF:$in
} elseif ($input -eq "6") {
	#Get-WmiObject -Class Win32_UserAccount
	Get-FileShare
} elseif ($input -eq "7") {
	Write-Host "Enter the name of fileshare to remove:"
	$name = Read-host
	Remove-FileShare -Name $name
} elseif ($input -eq "8") {
	reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DisableCAD /t REG_DWORD /d 0 /f
} elseif ($input -eq "9") {
	netsh advfirewall set allprofiles state on
	Write-Host "Firewall enabled"
	Write-Host "Setting basic firewall rules.."
	netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no 
	netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no 
	netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no 
	netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no 
	netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no 
	netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no 
	netsh advfirewall firewall set rule name="Telnet Server" new enable=no 
	netsh advfirewall firewall set rule name="netcat" new enable=no
	Write-Host "Set basic firewall rules."
} elseif ($input -eq "10") {
	Write-Host "Flushing DNS..."
	ipconfig /flushdns >nul
	Write-Host "Flushed DNS."
	Write-Host "Clearing contents of: C:\Windows\System32\drivers\etc\hosts ..."
	attrib -r -s C:\WINDOWS\system32\drivers\etc\hosts
	attrib +r +s C:\WINDOWS\system32\drivers\etc\hosts
	Write-Host "Cleared hosts file."
} elseif ($input -eq "11") {
	Write-Host "Disabling Guest account"
	net user Guest /active:no
	Write-Host "Guest account disabled"
} elseif ($input -eq "12") {
	Write-Host "Enable remote desktop? (y/n)"
	$rmd = Read-host
	if($rmd -eq "y") {
		Write-Host "Enabling remote desktop..."
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v AllowTSConnections /t REG_DWORD /d 1 /f
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
		REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
		netsh advfirewall firewall set rule group="remote desktop" new enable=yes
		Write-Host "Please select 'Allow connections only from computers running Remote Desktop with Network Level Authentication (more secure)'"
		start SystemPropertiesRemote.exe /wait
		Write-Host "Enabled remote desktop"
	} else {
		Write-Host "Disabling remote desktop..."
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v AllowTSConnections /t REG_DWORD /d 0 /f
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
		netsh advfirewall firewall set rule group="remote desktop" new enable=no
		Write-Host "Disabled remote desktop"
	}
} elseif ($input -eq "13") {
	$path2=Split-Path -parent $MyInvocation.MyCommand.Definition
	$path=Get-Content $path2\path.txt

	Write-host "Searching for unauthorized files..."
	$extensions =@("aac","ac3","avi","aiff","bat","bmp","exe","flac","gif","jpeg","jpg","mov","m3u","m4p",
	"mp2","mp3","mp4","mpeg4","midi","msi","ogg","png","txt","sh","wav","wma","vqf")
	$tools =@("Cain","nmap","keylogger","Armitage","Wireshark","Metasploit","netcat")
	Write-host "Checking $extensions"
	foreach($ext in $extensions){
		Write-host "Checking for .$ext files"
		if(Test-path "$path\checkFilesOutput\$ext.txt"){Clear-content "$path\checkFilesOutput\$ext.txt"}
		C:\Windows\System32\cmd.exe /C dir C:\*.$ext /s /b | Out-File "$path\checkFilesOutput\$ext.txt"
	}
	Write-host "Finished searching by extension"
	Write-host "Checking for $tools"
	foreach($tool in $tools){
		Write-host "Checking for $tool"
		if(Test-path $path\checkFilesOutput\$tool.txt){Clear-content "$path\checkFilesOutput\$tool.txt"}
		C:\Windows\System32\cmd.exe /C dir C:\*$tool* /s /b | Out-File "$path\checkFilesOutput\$tool.txt"
	}
	Write-host "Finished searching for tools"
} elseif ($input -eq "14") {
	Write-host "Type the name of the new user:"
	$username = Read-host
	Write-host "Type the password for the user:"
	$password = Read-host -AsSecureString
	Write-host "Is the new account an Administrator? (y/n)"
	$admin = Read-host
	Write-host "Creating new account..."
	New-LocalUser $username -Password $password -FullName $username -Description "Description of this account."
	if($admin -eq "y") {
		Add-LocalGroupMember -Group "Administrators" -Member $username
	}
	Write-host "New account created."
} elseif ($input -eq "15") {
    Write-host "All services:"
    Get-Service

} elseif ($input -eq "16") {
    Write-host "Disabling FTP service..."
    Stop-Service "ftpsvc"
    Write-host "FTP service disabled."
    Write-host "Dont forget to delete the FTP Server folder under control panel."
}

} until ($input -eq "exit")
