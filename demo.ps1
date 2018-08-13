#region Demo .NET FrameWork / Get-Process

Get-Process

[System.Diagnostics.Process]::GetProcesses()

https://msdn.microsoft.com/en-us/library/system.diagnostics.process(v=vs.110).aspx

Get-Process | Get-Member

notepad

Get-Process -Name notepad

[system.diagnostics.process]::GetProcessesByName("notepad")

#endregion

#region Install pscore

https://github.com/PowerShell/PowerShell

"terminal.integrated.shell.windows": "C:\\Program Files\\PowerShell\\6.0.3\\pwsh.exe"

#When you install the 'Shell launcher' extension, you can manage multiple shells within VSCode
https://4sysops.com/archives/vscode-as-a-console-for-powershell-core-6-part-1-multiple-shells/

#endregion

#region PSRemoting

https://github.com/PowerShell/Win32-OpenSSH/releases

#You can tell if it has the SSH remoting support by looking at the parameter sets for New-PSSession
#Get-Command New-PSSession -syntax --> Output:
#New-PSSession [-HostName] <string[]> [-Name <string[]>] [-UserName <string>] [-KeyFilePath <string>] [-SSHTransport] [<CommonParameters>]

Get-Process -Name "SSH*"

https://github.com/PowerShell/Win32-OpenSSH/releases

#C:\Program Files\OpenSSH

powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\OpenSSH\install-sshd.ps1"

$env:Path="$env:Path;C:\Program Files\OpenSSH\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $env:Path

Start-Service sshd
Set-Service sshd -StartupType Automatic

#Notepad as admin, edit C:\ProgramData\SSH\sshd_config
#Comment out this line in sshd_config "Subsystem sftp   sftp-server.exe"
#mklink /D c:\pwsh "C:\Program Files\PowerShell\6.0.3"
#Add Subsystem    powershell c:\pwsh\pwsh.exe -sshs -NoLogo -NoProfile
#Unremark PasswordAuthentication yes

New-NetFirewallRule -DisplayName 'SSH Inbound' -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22
#Look at error in pwsh!

Restart-Computer

#endregion PSRemoting