flag := false
F2:: flag := !flag

#If (flag)
    ~$LButton::
        While GetKeyState("LButton", "P"){
            Click
            Sleep 50  ;  milliseconds
        }
    return
#If

Esc:: ExitApp