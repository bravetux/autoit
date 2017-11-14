Func CheckAlive($host, $method = "ping", $port = False, $query = "HEAD / HTTP/1.0")
	Local $ping
	Switch $method
		Case "ping"
			$ping = Ping($host)
			;msgbox(0,"Ping", $host);
			If $ping Then
				SetExtended($ping)
				Return True
			Else
				Return False
			EndIf
	EndSwitch
EndFunc   ;==>CheckAliv
