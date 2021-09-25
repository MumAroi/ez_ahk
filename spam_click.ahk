#SingleInstance, force
#MaxThreadsPerHotkey 2
CoordMode, Mouse, Screen, Pixel

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
        Sleep 15  ;  milliseconds
    }
return

^e::
Toggle := !Toggle
WinGet, WindowActiveId, ID, A
WinActivate, ahk_id %WindowActiveId%
MouseGetPos, xpos, ypos
Loop {
    If (!Toggle){
        break
    }
    Click, %xpos%, %ypos%
    Sleep 15
}
return

Esc:: ExitApp

