$stillLooking = True
While $stillLooking
    $activeWindowTitle = WinGetTitle(WinActive(""))
    If $activeWindowTitle == "Title1" Then
        MsgBox(0, "", "Do something")
        $stillLooking = False
    ElseIf $activeWindowTitle == "Title2" Then
        MsgBox(0, "", "Do something else")
        $stillLooking = False
    EndIf
    sleep(5)
WEnd
