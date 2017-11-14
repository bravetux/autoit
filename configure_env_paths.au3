Func read_env_config_and_set($cfg_section, $config_FilePath)
	; host file $config_FilePath placed on the location

	Local $var[50][50], $i, $sh
	If FileExists($config_FilePath) Then
		$var = IniReadSection($config_FilePath, $cfg_section)
		;msgbox(0,"Read Config ", $cfg_section);
		If @error Then
			MsgBox(4096, "Error", "Unable to read section." & $cfg_section)
		Else
			For $i = 1 To $var[0][0]
				;MsgBox(4096, $NULL, "Key: " & $var[$i][0] & @CRLF & "Value: " & $var[$i][1])
				ShellExecuteWait("setx", $var[$i][0] & '"' & $var[$i][1] & '"' & " -m", @SW_MINIMIZE)
			Next
			$sh = UBound($var) - 1 ; get zize of array just take some leg work out of the for next loops, i'm quit lazy
		EndIf
	Else
		MsgBox(4096, "Config File Read Error", "The INI file does not exist.")
	EndIf ; ===> FileExists $config_FilePath
EndFunc   ;==>read_env_config_and_set
