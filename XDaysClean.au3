#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=shell32\.rsrc\ICON\874.ico
#AutoIt3Wrapper_Outfile=clean_x86.exe
#AutoIt3Wrapper_Outfile_x64=clean_x64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Cleanup Utility
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <date.au3>

If $CmdLine[0] = 0 Then help()
If $CmdLine[1] = "/?" Then help()
If $CmdLine[1] = "?" Then help()
If $CmdLine[0] = 1 And StringInStr($CmdLine[1], ":\") Then showit($CmdLine[1], 30, 0)
If $CmdLine[0] = 2 And StringInStr($CmdLine[1], ":\") And StringIsInt($CmdLine[2]) Then showit($CmdLine[1], $CmdLine[2], 0)
If $CmdLine[0] = 2 And StringInStr($CmdLine[1], ":\") And StringInStr($CmdLine[2], "/R") Then showit($CmdLine[1], 30, 1)
If $CmdLine[0] = 3 And StringInStr($CmdLine[1], ":\") And StringIsInt($CmdLine[2]) And StringInStr($CmdLine[3], "/R") Then showit($CmdLine[1], $CmdLine[2], 1)
If $CmdLine[0] = 2 And StringInStr($CmdLine[1], ":\") And StringInStr($CmdLine[2], "/D") Then workit($CmdLine[1], 30, 0)
If $CmdLine[0] = 3 And StringInStr($CmdLine[1], ":\") And StringIsInt($CmdLine[2]) And StringInStr($CmdLine[3], "/D") Then workit($CmdLine[1], $CmdLine[2], 0)
If $CmdLine[0] = 3 And StringInStr($CmdLine[1], ":\") And StringInStr($CmdLine[2], "/R") And StringInStr($CmdLine[2], "/D") Then workit($CmdLine[1], 30, 1)
If $CmdLine[0] = 4 And StringInStr($CmdLine[1], ":\") And StringIsInt($CmdLine[2]) And StringInStr($CmdLine[3], "/R") And StringInStr($CmdLine[4], "/D") Then workit($CmdLine[1], $CmdLine[2], 1)

help()

Func showit($path_and_mask, $target_age, $recursive)
	$a = _FileSearch($path_and_mask, $recursive)
	If $a[0] > 0 Then
		$list = ""
		For $i = 1 To $a[0]
			$file_age = days_since_modified($a[$i])
			If $file_age > $target_age Then
				$list = $list & $a[$i] & @CRLF
			EndIf
		Next
	EndIf
	MsgBox(0, "old files", $list)
	Local $fp = FileOpen("./oldFiles.txt", 2)
	FileWrite($fp, $list)
	FileClose($fp)
	Exit
EndFunc   ;==>showit

Func workit($path_and_mask, $target_age, $recursive)
	$a = _FileSearch($path_and_mask, $recursive)
	If $a[0] > 0 Then
		For $i = 1 To $a[0]
			$file_age = days_since_modified($a[$i])
			If $file_age > $target_age Then
				FileDelete($a[$i])
			EndIf
		Next
	EndIf
	Exit
EndFunc   ;==>workit

Func help()
	$msg = "Cleanup is a command line utility that deletes files older than a given age." & @CRLF & _
			@CRLF & "Syntax:" & @CRLF & _
			@CRLF & "CLEANUP   ""path_and_mask""   [days_old]   [/R]  [/D]" & @CRLF & _
			@CRLF & "  path_and_mask    I.E. C:\folder\sub-folder\*.* (use quotes if there are spaces)" & _
			@CRLF & "  days_old    age of files to delete (default is 30)" & _
			@CRLF & "  /R        recursive (default is non-recursive)" & _
			@CRLF & "  /D        delete the files, without /D it just shows a list matching the mask" & @CRLF & _
			@CRLF & "Examples:" & _
			@CRLF & "CLEANUP ""C:\test fol\*.txt"" 60 /R /D" & _
			@CRLF & "CLEANUP C:\test\*.log /R /D" & _
			@CRLF & "CLEANUP C:\test\*.* 25 /D" & @CRLF & _
			@CRLF & "Developed by Vignesh Kumar B <vigneshkumarb@hcl.com>" & @CRLF
	MsgBox(0, "Cleanup Help", $msg)
	Exit
EndFunc   ;==>help

Func days_since_modified($full_path_to_file)
	$FileInfo = FileGetTime($full_path_to_file, 0, 0)
	$formated_file_date = $FileInfo[0] & "/" & $FileInfo[1] & "/" & $FileInfo[2]
	$formated_current_date = @YEAR & "/" & @MON & "/" & @MDAY
	$date_diff = _DateDiff('D', $formated_file_date, $formated_current_date) ; needs <date.au3>
	Return $date_diff
EndFunc   ;==>days_since_modified

Func _FileSearch($szMask, $nOption)
	$szRoot = ""
	$hFile = 0
	$szBuffer = ""
	$szReturn = ""
	$szPathList = "*"
	Dim $aNULL[1]

	If Not StringInStr($szMask, "\") Then
		$szRoot = @ScriptDir & "\"
	Else
		While StringInStr($szMask, "\")
			$szRoot = $szRoot & StringLeft($szMask, StringInStr($szMask, "\"))
			$szMask = StringTrimLeft($szMask, StringInStr($szMask, "\"))
		WEnd
	EndIf
	If $nOption = 0 Then
		_FileSearchUtil($szRoot, $szMask, $szReturn)
	Else
		While 1
			$hFile = FileFindFirstFile($szRoot & "*.*")
			If $hFile >= 0 Then
				$szBuffer = FileFindNextFile($hFile)
				While Not @error
					If $szBuffer <> "." And $szBuffer <> ".." And _
							StringInStr(FileGetAttrib($szRoot & $szBuffer), "D") Then _
							$szPathList = $szPathList & $szRoot & $szBuffer & "*"
					$szBuffer = FileFindNextFile($hFile)
				WEnd
				FileClose($hFile)
			EndIf
			_FileSearchUtil($szRoot, $szMask, $szReturn)
			If $szPathList == "*" Then ExitLoop
			$szPathList = StringTrimLeft($szPathList, 1)
			$szRoot = StringLeft($szPathList, StringInStr($szPathList, "*") - 1) & "\"
			$szPathList = StringTrimLeft($szPathList, StringInStr($szPathList, "*") - 1)
		WEnd
	EndIf
	If $szReturn = "" Then
		$aNULL[0] = 0
		Return $aNULL
	Else
		Return StringSplit(StringTrimRight($szReturn, 1), "*")
	EndIf
EndFunc   ;==>_FileSearch

Func _FileSearchUtil(ByRef $ROOT, ByRef $MASK, ByRef $RETURN)
	$hFile = FileFindFirstFile($ROOT & $MASK)
	If $hFile >= 0 Then
		$szBuffer = FileFindNextFile($hFile)
		While Not @error
			If $szBuffer <> "." And $szBuffer <> ".." Then _
					$RETURN = $RETURN & $ROOT & $szBuffer & "*"
			$szBuffer = FileFindNextFile($hFile)
		WEnd
		FileClose($hFile)
	EndIf
EndFunc   ;==>_FileSearchUtil
