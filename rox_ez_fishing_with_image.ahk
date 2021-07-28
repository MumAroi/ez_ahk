#SingleInstance, force
#MaxThreadsPerHotkey 2
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
SetTitleMatchMode, RegEx
CoordMode, Mouse, Screen, Pixel

IfNotExist, %A_ScriptDir%/RoxSettings.ini 
{
    iniwrite,'',RoxSettings.ini,Main,WindowActiveName
    iniwrite,'',RoxSettings.ini,Main,WindowClass
    iniwrite,0,RoxSettings.ini,Main,XPosition
    iniwrite,0,RoxSettings.ini,Main,YPosition
    iniwrite,'',RoxSettings.ini,Main,ImagePath1
    iniwrite,'',RoxSettings.ini,Main,ImagePath2
    iniwrite,0,RoxSettings.ini,Main,BaitNumber
}
; -----------------------CONFIGURE--------------------------------------------------------------------
; IniRead,xpos,RoxSettings.ini,Main,XPosition
; IniRead,ypos,RoxSettings.ini,Main,YPosition


Gui, +AlwaysOnTop
Gui, Color, FFFFFF
Gui, Add, GroupBox, x2 y9 w480 h170 , SetUp
Gui, Add, GroupBox, x2 y189 w480 h130 , Automation
Gui, Add, Text, x27 y29 w280 h15 vTextMousePositon, MousePosition x0, Y0
Gui, Add, Button, x22 y45 w120 h50 gButtonSetPositionClick, SetPositionClick`n(Ctrl+R)
Gui, Add, Text, x172 y50 w280 h20 vTextImagePath1, 
Gui, Add, Button, x172 y70 w80 h20 gButtonUploadImage1, Image1
Gui, Add, Button, x22 y110 w120 h50 gButtonTest, Test`n(Ctrl+E)
Gui, Add, Text, x172 y110 w280 h20 vTextImagePath2, 
Gui, Add, Button, x172 y130 w80 h20 gButtonUploadImage2, Image2
Gui, Add, Button, x32 y249 w120 h50 gButtonStartFishing, Start/Stop Fishing`n(Ctrl+D)
Gui, Add, Text, x32 y219 w80 h20 , Number Bait
Gui, Add, Progress, x232 y219 w20 h20 +cFF0000 vFishingStatusColor, 100
Gui, Add, Text, x262 y219 w60 h20 vFishingStatus, InActive
Gui, Add, Edit, x122 y219 w70 h20 Number -VScroll vBaitNumber, 0
Gui, Add, Button, x190 y249 w120 h50 gButtonSaveConfig, SaveConfig
Gui, Add, Button, x345 y249 w120 h50 gButtonLoadConfig, LoadConfig
; Generated using SmartGUI Creator 4.0
Gui, Show, x476 y151 h340 w494, AreYouWanNo Fishing
Return

ButtonUploadImage1:
FileSelectFile, ImagePath1, 1,, Open a file, Images (*.png; *.jpeg; *.jpg)
SplitPath, ImagePath1, ImageName1
GuiControl,, TextImagePath1, %ImageName1%
return

ButtonUploadImage2:
FileSelectFile, ImagePath2, 1,, Open a file, Images (*.png; *.jpeg; *.jpg)
SplitPath, ImagePath2, ImageName2
GuiControl,, TextImagePath2, %ImageName2%
return 

ButtonSetPositionClick:
^r::
WinGet, WindowActiveId, ID, A
; WinMaximize ahk_id %WindowActiveId%
WinGetActiveStats, WindowActiveName, W, H, X, Y
WinGetClass, WindowClass, A
MouseGetPos, xpos, ypos

GuiControl,, TextMousePositon, MousePosition X%xpos%, Y%ypos%
return

ButtonTest:
Sleep, 100
SetControlDelay -1
WinActivate, ahk_id %WindowActiveId%
; PixelGetColor, RColor, %xpos% , %ypos%
ImageSearch, FoundX1, FoundY1, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %ImagePath1%
if (FoundX1 > 0) {
    ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%,,,, NA
    Loop {
        ; PixelGetColor, HColor, %xpos% , %ypos%
        ImageSearch, FoundX2, FoundY2, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %ImagePath2%
        if (FoundX2 > 0) {
            ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%,,,, NA
            Sleep, 500
            Break
        }
    }
}
return

ButtonStartFishing:
^d::
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
        ; PixelGetColor, RColor, %xpos% , %ypos%
        ImageSearch, FoundX1, FoundY1, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %ImagePath1%
        If (FoundX1 > 0){
            ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%,,,, NA
            Loop {
                ; PixelGetColor, HColor, %xpos% , %ypos%
                ImageSearch, FoundX2, FoundY2, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %ImagePath2%
                If (FoundX2 > 0){
                    ControlClick, x%xpos% y%ypos%, ahk_id %WindowActiveId%
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

ButtonSaveConfig:
GuiControlGet, BaitNumber 
iniwrite,%WindowActiveName%,RoxSettings.ini,Main,WindowActiveName
iniwrite,%WindowClass%,RoxSettings.ini,Main,WindowClass
iniwrite,%xpos%,RoxSettings.ini,Main,XPosition
iniwrite,%ypos%,RoxSettings.ini,Main,YPosition
iniwrite,%ImagePath1%,RoxSettings.ini,Main,ImagePath1
iniwrite,%ImagePath2%,RoxSettings.ini,Main,ImagePath2
iniwrite,%BaitNumber%,RoxSettings.ini,Main,BaitNumber
return

ButtonLoadConfig:
IfNotExist, %A_ScriptDir%/RoxSettings.ini 
{
    MsgBox, The target file does not exist.
    Exit
}

IniRead,WindowActiveName,RoxSettings.ini,Main,WindowActiveName
IniRead,WindowClass,RoxSettings.ini,Main,WindowClass
IniRead,xpos,RoxSettings.ini,Main,XPosition
IniRead,ypos,RoxSettings.ini,Main,YPosition
IniRead,ImagePath1,RoxSettings.ini,Main,ImagePath1
IniRead,ImagePath2,RoxSettings.ini,Main,ImagePath2
IniRead,BNumber,RoxSettings.ini,Main,BaitNumber

WinActivate, %WindowActiveName% ahk_class %WindowClass%
WinGet, WindowActiveId, ID, A
WinMaximize ahk_id %WindowActiveId%
SplitPath, ImagePath1, ImageName1
SplitPath, ImagePath2, ImageName2

GuiControl,, TextImagePath1, %ImageName1%
GuiControl,, TextImagePath2, %ImageName2%
GuiControl,, TextMousePositon, MousePosition X%xpos%, Y%ypos%
GuiControl,, BaitNumber, %BNumber%
return

Esc:: ExitApp

GuiClose:
ExitApp