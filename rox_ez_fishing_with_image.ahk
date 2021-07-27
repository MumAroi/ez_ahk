#NoEnv
#SingleInstance, force
#MaxThreadsPerHotkey 2
#Include screen_capture_lib.ahk

SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
SetBatchLines, -1
SetTitleMatchMode, RegEx
CoordMode, Mouse, Screen, Pixel
; GUI 
; Gui, +AlwaysOnTop
Gui, Color, FFFFFF
Gui, Add, GroupBox, x2 y9 w480 h220 , SetUp
Gui, Add, GroupBox, x2 y249 w480 h130 , Automation
Gui, Add, Button, x22 y29 w120 h50 gButtonSetRedyPosition, SetRedyPosition`n(Ctrl+R)
Gui, Add, Text, x172 y29 w290 h30 vTextStatusSetUpRedyPosition, 
Gui, Add, Progress, x172 y59 w20 h20 vColorSetUpPosition, 100
Gui, Add, Text, x202 y59 w260 h20 vTextColorSetUpPosition, 
Gui, Add, Button, x22 y99 w120 h50 gButtonSetHookPosition, SetHookPosition`n(Ctrl+E)
Gui, Add, Text, x172 y99 w290 h30 vTextStatusSetHookPosition,
Gui, Add, Progress, x172 y129 w20 h20 vColorSetHookPosition, 100
Gui, Add, Text, x202 y129 w260 h20 vTextColorSetHookPosition, 
Gui, Add, Button, x142 y169 w120 h50 gButtonSetUpTest, SetUpTest`n(Ctrl+Q)
Gui, Add, Button, x25 y279 w120 h50 gButtonStartFishing, Start/Stop Fishing`n(Ctrl+F)
; Generated using SmartGUI Creator 4.0
Gui, Show, x449 y145 h391 w490, AreYouWanNo Fishing
Return

ButtonSetRedyPosition:
^R::
Hotkey, LButton, Select, On
ReplaceSystemCursors("IDC_CROSS")
return

ButtonSetHookPosition:
^e::

return 

ButtonSetUpTest:
^q::

return

ButtonStartFishing:
^f::
return


GuiClose:
ExitApp