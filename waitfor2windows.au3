; #FUNCTION# ====================================================================================================================
; Name...........: _2WinWait
; Description ...: Wait For Tow Windows .
; Syntax.........: _2WinWait ($FirstTitle,$SecondTitle,[$FirstText = "" ,[$SecondText = ""]] )
; Parameters ....: $FirstTitle  - Title Of First  Wondow 
;                  $SecondTitle - Title Of Second Wondow 
;                  $FirstText   - Text  Of First  Wondow 
;                  $SecondText  - Text  Of Second Wondow 
; Return values .: Success - None
;                  Failure - Returns a 0 => If Your Titles Is Wrong
; Author ........: Ashalshaikh : Ahmad Alshaikh
; Remarks .......: 
; Related .......:
; Link ..........;
; Example .......; No
; ===============================================================================================================================
Func _2WinWait ($FirstTitle,$SecondTitle,$FirstText = "" ,$SecondText = "" )
    If $FirstTitle = "" Or $SecondTitle = "" Then
        Return 0 
    Else
        Do 
        Until WinExists ($FirstTitle,$FirstText) Or WinExists ($SecondTitle,$SecondText)
    EndIf
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _2WinWait_Any 
; Description ...: Wait For Tow Windows And Return Any Window Id Exists .
; Syntax.........: _2WinWait_Any ($FirstTitle,$SecondTitle,[$FirstText = "" ,[$SecondText = ""]] )
; Parameters ....: $FirstTitle  - Title Of First  Wondow 
;                  $SecondTitle - Title Of Second Wondow 
;                  $FirstText   - Text  Of First  Wondow 
;                  $SecondText  - Text  Of Second Wondow 
; Return values .: Success - Number Of Window ==> 1= First Window , 2= Second Window
;                  Failure - Returns a 0 => If Your Titles Is Wrong
; Author ........: Ashalshaikh : Ahmad Alshaikh
; Remarks .......: 
; Related .......:
; Link ..........;
; Example .......; No
; ===============================================================================================================================
Func _2WinWait_Any ($FirstTitle,$SecondTitle,$FirstText = "" ,$SecondText = "" )
    If $FirstTitle = "" Or $SecondTitle = "" Then
        Return 0 
    Else
        Do 
        Until WinExists ($FirstTitle,$FirstText) Or WinExists ($SecondTitle,$SecondText)
        If WinExists ($FirstTitle,$FirstTexit) Then 
            Return 1 
        Else
            Return 2 
        EndIf
    EndIf
EndFunc
