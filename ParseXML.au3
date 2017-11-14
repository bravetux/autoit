Func ReadXML($Path, $Element)
	Local $aRet = StringRegExp(FileRead($Path), '<' & $Element & '>([^:]*?)</' & $Element & '>', 3)
	If IsArray($aRet) Then
		Return $aRet
	Else
		Return SetError(-1)
	EndIf
EndFunc   ;==>ReadXML
