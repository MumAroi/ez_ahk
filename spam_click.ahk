#SingleInstance, force
; #MaxThreadsPerHotkey 2
; CoordMode, Mouse, Screen, Pixel

flag := false
F2:: flag := !flag

; #If (flag)
;     ~$LButton::
;         While GetKeyState("LButton", "P"){
;             Click
;             Sleep 50  ;  milliseconds
;         }
;     return
; #If

~$LButton::
    While (flag and GetKeyState("LButton", "P")){
        Click
        Sleep 50  ;  milliseconds
    }
return

Esc:: ExitApp

