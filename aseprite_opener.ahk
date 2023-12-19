; Opens file in existing Aseprite instance, instead of opening a new one.
SetTitleMatchMode, 2

Process, Exist, aseprite.exe
NewPID := ErrorLevel
; Open new instance
if not NewPID
{
  run, C:\Program Files\Aseprite\Aseprite.exe %1%
}
; Open in existing instance
else
{ 
  list_files:={} ;define array name

  data=
  (
  %1%
  )

  loop,parse,data,`n,`r
    list_files[A_Index]:=A_LoopField

  DropFiles("Aseprite", list_files)

  DropFiles(window, files)
  {
    for k,v in files
      memRequired+=StrLen(v)+1
    hGlobal := DllCall("GlobalAlloc", "uint", 0x42, "ptr", memRequired+21)
    dropfiles := DllCall("GlobalLock", "ptr", hGlobal)
    NumPut(offset := 20, dropfiles+0, 0, "uint")
    for k,v in files
      StrPut(v, dropfiles+offset, "utf-8"), offset+=StrLen(v)+1
    DllCall("GlobalUnlock", "ptr", hGlobal)
    PostMessage, 0x233, hGlobal, 0,, %window%
    if ErrorLevel
      DllCall("GlobalFree", "ptr", hGlobal)
  }

  WinActivate, % ase := "ahk_exe aseprite.exe"
  WinMaximize, %ase%
}

