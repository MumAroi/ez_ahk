#SingleInstance, force
#MaxThreadsPerHotkey 2
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
SetTitleMatchMode, RegEx
CoordMode, Mouse, Screen, Pixel

; GUI
Gui, Add, GroupBox, x12 y9 w460 h140 , Setup
Gui, Add, Button, x22 y29 w100 h40 gButtonSetPosition, SetPosition`n(Ctrl+R)
Gui, Add, Text, x172 y39 w260 h20 vTextStatusSetUpPosition,
Gui, Add, Button, x22 y89 w100 h40 gButtonStart, Start/Stop`n(Ctrl+E)
Gui, Add, Progress, x142 y99 w20 h20 cFF0000 vColorStart, 100
Gui, Add, Text, x172 y99 w260 h20 vTextStatusStart, Not Active
; Generated using SmartGUI Creator 4.0
Gui, Show, x536 y205 h162 w485, AreYouWanNo Gardening
Return

ButtonSetPosition:
^r::
WinGet, WindowActiveId, ID, A
WinGetActiveStats, WindowActiveName, W, H, X, Y
WinGetClass, WindowClass, A
MouseGetPos, xpos, ypos
GuiControl,, TextStatusSetUpPosition, MousePosition: x%xpos% y%ypos%
return

ButtonStart:
^e::
Toggle := !Toggle
GuiControl,, TextStatusStart, Avtive
GuiControl, +c00FF00, ColorStart
WinActivate, ahk_id %WindowActiveId%
Loop {
    If (!Toggle){
        break
    }
    SetControlDelay -1
    ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%,,,, NA
    ; Click, %xpos%, %ypos%
    Sleep 15
}
GuiControl,, TextStatusStart, Not Active
GuiControl, +cFF0000, ColorStart
return

Esc:: ExitApp

GuiClose:
ExitApp