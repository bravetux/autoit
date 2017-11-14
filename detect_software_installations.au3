Func ComputerGetSoftware(ByRef $aSoftwareInfo, $g_sw_detect_input)
	Local Const $UnInstKey = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
	Local $i = 1
	Local $AppKey, $Reg, $string
	Local $input
	Dim $aSoftwareInfo[1][4]

	$input = InputBox("Which Software", "You are running " & @OSVersion & " " & @OSArch & @CRLF & @CRLF & "Which Software would you like to view?", 'ALL')
	$input = $g_sw_detect_input
	If @error = 1 Then Exit
	If $input = 'ALL' Then
		For $j = 1 To 500
			$AppKey = RegEnumKey($UnInstKey, $j)
			If @error <> 0 Then ExitLoop
			If RegRead($UnInstKey & "\" & $AppKey, "DisplayName") = '' Then ContinueLoop
			ReDim $aSoftwareInfo[UBound($aSoftwareInfo) + 1][4]
			$aSoftwareInfo[$i][0] = StringStripWS(StringReplace(RegRead($UnInstKey & "\" & $AppKey, "DisplayName"), " (remove only)", $NULL), 3)
			$aSoftwareInfo[$i][1] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "DisplayVersion"), 3)
			$aSoftwareInfo[$i][2] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "Publisher"), 3)
			$aSoftwareInfo[$i][3] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "UninstallString"), 3)
			$i = $i + 1
		Next
		$aSoftwareInfo[0][0] = UBound($aSoftwareInfo, 1) - 1
		If $aSoftwareInfo[0][0] < 1 Then SetError(1, 1, 0)
		Return _ArraySort($aSoftwareInfo, 0, 1)
	Else
		For $j = 1 To 500
			$AppKey = RegEnumKey($UnInstKey, $j)
			If @error <> 0 Then ExitLoop
			$Reg = RegRead($UnInstKey & "\" & $AppKey, "DisplayName")
			$string = StringInStr($Reg, $input)
			If $string = 0 Then ContinueLoop
			ReDim $aSoftwareInfo[UBound($aSoftwareInfo) + 1][4]
			$aSoftwareInfo[$i][0] = StringStripWS(StringReplace(RegRead($UnInstKey & "\" & $AppKey, "DisplayName"), " (remove only)", $NULL), 3)
			$aSoftwareInfo[$i][1] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "DisplayVersion"), 3)
			$aSoftwareInfo[$i][2] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "Publisher"), 3)
			$aSoftwareInfo[$i][3] = StringStripWS(RegRead($UnInstKey & "\" & $AppKey, "UninstallString"), 3)
			$i = $i + 1
		Next
		$aSoftwareInfo[0][0] = UBound($aSoftwareInfo, 1) - 1
		If $aSoftwareInfo[0][0] < 1 Then SetError(1, 1, 0)
		Return _ArraySort($aSoftwareInfo, 0, 1)
	EndIf
EndFunc   ;==>ComputerGetSoftware
