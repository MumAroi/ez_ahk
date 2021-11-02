#SingleInstance, force
#MaxThreadsPerHotkey 2
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
SetTitleMatchMode, RegEx
CoordMode, Mouse, Screen, Pixel

; IfNotExist, %A_ScriptDir%/RoxSettings.ini 
; {
;     iniwrite,'',RoxSettings.ini,Main,WindowActiveName
;     iniwrite,'',RoxSettings.ini,Main,WindowClass
;     iniwrite,0,RoxSettings.ini,Main,XPosition
;     iniwrite,0,RoxSettings.ini,Main,YPosition
;     iniwrite,0,RoxSettings.ini,Main,RedyColor
;     iniwrite,0,RoxSettings.ini,Main,RedyColorCode
;     iniwrite,0,RoxSettings.ini,Main,HookColor
;     iniwrite,0,RoxSettings.ini,Main,HookColorCode
; }
; -----------------------CONFIGURE--------------------------------------------------------------------
; IniRead,xpos,RoxSettings.ini,Main,XPosition
; IniRead,ypos,RoxSettings.ini,Main,YPosition
; IniRead,RedyPosionColor,RoxSettings.ini,Main,RedyColor
; IniRead,RedyColorCode,RoxSettings.ini,Main,RedyColorCode
; IniRead,HookPosionColor,RoxSettings.ini,Main,HookColor
; IniRead,HookColorCode,RoxSettings.ini,Main,HookColorCode

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
Gui, Add, Button, x22 y309 w120 h50 gButtonStartFishing, Start/Stop Fishing`n(Ctrl+F)
Gui, Add, Text, x22 y279 w60 h20 , Number Bait
Gui, Add, Progress, x220 y279 w20 h20 +cFF0000 vFishingStatusColor, 100
Gui, Add, Text, x250 y279 w60 h20 vFishingStatus, InActive
Gui, Add, Edit, x92 y279 w70 h20 Number -VScroll vBaitNumber, 0
; Gui, Add, Button, x180 y279 w120 h50 gButtonSaveConfig, SaveConfig
; Gui, Add, Button, x335 y279 w120 h50 gButtonLoadConfig, LoadConfig
; Generated using SmartGUI Creator 4.0
Gui, Show, x449 y145 h391 w490, AreYouWanNo Fishing
Return

ButtonSetRedyPosition:
^R::
WinGet, WindowActiveId, ID, A
; WinMaximize ahk_id %WindowActiveId%
WinGetActiveStats, WindowActiveName, W, H, X, Y
WinGetClass, WindowClass, A
MouseGetPos, xpos, ypos

PixelGetColor, RedyPosionColor, %xpos% , %ypos%
RedyPosionColorString := RedyPosionColor

StringRight, RedyColorCode, RedyPosionColorString, 6
GuiControl,, TextStatusSetUpRedyPosition, %WindowActiveName% / %WindowClass%
GuiControl, +c%RedyColorCode%, ColorSetUpPosition
GuiControl,, TextColorSetUpPosition, MousePosition: x%xpos% y%ypos% / colorCode:  c%RedyColorCode%

click
return

ButtonSetHookPosition:
^e::
SetControlDelay -1
WinActivate, ahk_id %WindowActiveId%

PixelGetColor, HookPosionColor, %xpos% , %ypos%
HookPosionColorString := HookPosionColor
StringRight, HookColorCode, HookPosionColorString, 6

GuiControl,, TextStatusSetHookPosition,   %WindowActiveName% / %WindowClass%
GuiControl, +c%HookColorCode%, ColorSetHookPosition
GuiControl,, TextColorSetHookPosition, MousePosition: x%xpos% y%ypos% / colorCode:  c%HookColorCode%

ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%,,,, NA
return 

ButtonSetUpTest:
^q::
Sleep, 100
SetControlDelay -1
WinActivate, ahk_id %WindowActiveId%
startTime := A_TickCount 
PixelGetColor, RColor, %xpos% , %ypos%
if (RColor = RedyPosionColor) {
    Random, rxpos, xpos , xpos+2
    Random, rypos, ypos , ypos+2
    ControlClick, x%rxpos% y%rypos%, ahk_id %WindowActiveId%,,,, NA
    Loop {
        nowTime := A_TickCount-start
        PixelGetColor, HColor, %xpos% , %ypos%
        if (HColor = HookPosionColor) {
            ControlClick, x%rxpos% y%rypos%, ahk_id %WindowActiveId%,,,, NA
            Sleep, 500
            Break
        }else if (nowTime > 2000) {
            break
        }
    }
}
return

ButtonStartFishing:
^f::
GuiControlGet, BaitNumber 
if(BaitNumber > 0){
    Toggle := !Toggle
    FishingCount = 0
    GuiControl,, FishingStatus, Avtive
    GuiControl, +c00FF00, FishingStatusColor
    While (Toggle)
    {
        Sleep, 100
        SetControlDelay -1
        WinActivate, ahk_id %WindowActiveId%
        PixelGetColor, RColor, %xpos% , %ypos%
        If (RColor = RedyPosionColor){
            Random, rxpos, xpos , xpos+2
            Random, rypos, ypos , ypos+2
            ControlClick, x%rxpos% y%rypos%, ahk_id %WindowActiveId%,,,, NA
            Loop {
                PixelGetColor, HColor, %xpos% , %ypos%
                If (HColor = HookPosionColor){
                    ControlClick, x%rxpos% y%rypos%, ahk_id %WindowActiveId%
                    FishingCount++
                    If(FishingCount = BaitNumber) {
                        Toggle := !Toggle 
                        GuiControl,, FishingStatus, InAvtive
                        GuiControl, +cFF0000, FishingStatusColor
                    }
                    Sleep, 500
                    Break
                }
            }
        }
    }
}
return

; ButtonSaveConfig:
; iniwrite,%WindowActiveName%,RoxSettings.ini,Main,WindowActiveName
; iniwrite,%WindowClass%,RoxSettings.ini,Main,WindowClass
; iniwrite,%xpos%,RoxSettings.ini,Main,XPosition
; iniwrite,%ypos%,RoxSettings.ini,Main,YPosition
; iniwrite,%RedyPosionColor%,RoxSettings.ini,Main,RedyColor
; iniwrite,%RedyColorCode%,RoxSettings.ini,Main,RedyColorCode
; iniwrite,%HookPosionColor%,RoxSettings.ini,Main,HookColor
; iniwrite,%HookColorCode%,RoxSettings.ini,Main,HookColorCode
; return

; ButtonLoadConfig:
; IfNotExist, %A_ScriptDir%/RoxSettings.ini 
; {
;     MsgBox, The target file does not exist.
;     Exit
; }

; IniRead,WindowActiveName,RoxSettings.ini,Main,WindowActiveName
; IniRead,WindowClass,RoxSettings.ini,Main,WindowClass
; IniRead,xpos,RoxSettings.ini,Main,XPosition
; IniRead,ypos,RoxSettings.ini,Main,YPosition
; IniRead,RedyPosionColor,RoxSettings.ini,Main,RedyColor
; IniRead,RedyColorCode,RoxSettings.ini,Main,RedyColorCode
; IniRead,HookPosionColor,RoxSettings.ini,Main,HookColor
; IniRead,HookColorCode,RoxSettings.ini,Main,HookColorCode

; WinActivate, %WindowActiveName% ahk_class %WindowClass%
; WinGet, WindowActiveId, ID, A
; WinMaximize ahk_id %WindowActiveId%

; GuiControl,, TextStatusSetUpRedyPosition, %WindowActiveName% / %WindowClass%
; GuiControl, +c%RedyColorCode%, ColorSetUpPosition
; GuiControl,, TextColorSetUpPosition, MousePosition: x%xpos% y%ypos% / colorCode:  c%RedyColorCode%

; GuiControl,, TextStatusSetHookPosition,   %WindowActiveName% / %WindowClass%
; GuiControl, +c%HookColorCode%, ColorSetHookPosition
; GuiControl,, TextColorSetHookPosition, MousePosition: x%xpos% y%ypos% / colorCode:  c%HookColorCode%
; return

Esc:: ExitApp

GuiClose:
ExitApp