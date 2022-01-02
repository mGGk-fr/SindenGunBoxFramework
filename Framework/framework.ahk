#Include ..\framework\config.ahk

; AHK Bootstrap
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Utility functions
DetectSinddenGuns() {
    RIDI_DEVICENAME := 0x20000007
    SINDEN_TYPE := 0

    SizeofRawInputDeviceList := A_PtrSize * 2
    SizeofRawInputDevice := 8 + A_PtrSize
    DetectedSindenCount := 0

    Res := DllCall("GetRawInputDeviceList", "Ptr", 0, "UInt*", Count, UInt, SizeofRawInputDeviceList)

    VarSetCapacity(RawInputList, SizeofRawInputDeviceList * Count)

    Res := DllCall("GetRawInputDeviceList", "Ptr", &RawInputList, "UInt*", Count, "UInt", SizeofRawInputDeviceList)

    Loop %Count% {
        Handle := NumGet(RawInputList, (A_Index - 1) * SizeofRawInputDeviceList, "UInt")
        Type := NumGet(RawInputList, ((A_Index - 1) * SizeofRawInputDeviceList) + A_PtrSize, "UInt")
        if (Type != SINDEN_TYPE) {
            Continue
        }

        Res := DllCall("GetRawInputDeviceInfo", "Ptr", Handle, "UInt", RIDI_DEVICENAME, "Ptr", 0, "UInt *", nLength)
        If (Res = -1) {
            Continue
        }
        VarSetCapacity(Name, (nLength + 1) * 2)
        Res := DllCall("GetRawInputDeviceInfo", "Ptr", Handle, "UInt", RIDI_DEVICENAME, "Str", Name, "UInt*", nLength)
        If (Res = -1) {
            Continue
        }
        if (InStr(Name, "HID#VID_16C0&")) {
            DetectedSindenCount++
        }
    }

    return DetectedSindenCount
}


DetectAndBootSindenInstances()
{
    global FirstGunFolder, SecondGunFolder
    GunCount := DetectSinddenGuns()
    if(GunCount = 0) {
        MsgBox, 16, GunBox Framework, No Sinden guns detected
        ExitApp
    }
    if(GunCount > 0) {
        Run, %FirstGunFolder%\Lightgun.exe
    }
    if(GunCount > 1) {
        Run, %SecondGunFolder%\Lightgun.exe
    }
}

BootFramework()
{
    DetectAndBootSindenInstances()
}

EndFramework()
{
    Run,taskkill /im "Lightgun.exe" /F
    ExitApp
}