; Map X drive to \\myserver2\stuff2 using the user "username" from "domainx" with password "userpassword"
Local $drive = "P:"
Local $path = "\\10.100.126.91\Users\Share_SyncServer"
Local $sys_FilePath = @ScriptDir & "\Config.ini"
DriveMapAdd($drive, $path, 0, IniRead($sys_FilePath, "Credentials", "Username", "Default Value"), _
												IniRead($sys_FilePath, "AxcelisCredentials", "Password", "Default Value"))
; Get details of the mapping
MsgBox($MB_SYSTEMMODAL, "Mount", "Drive " & $drive & " is mapped to: " & DriveMapGet($drive))

=======================================================================================================
;Umount Drive
DriveMapDel ($drive)


----------------------------
Config.Ini

[Credentials]
Username=vigneshkumarb
Password=hungary123		

