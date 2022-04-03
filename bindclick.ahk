#SingleInstance, force
#MaxThreadsPerHotkey 2
CoordMode, Mouse

Space::LButton

!x::
    Suspend, toggle
return

^!x::
    ExitApp
return
