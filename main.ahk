#SingleInstance force

; SECTION: capslock

; caps lock: escape
; caps+key: ctrl+key
*CapsLock::
{
  Send "{LControl down}"
}

*CapsLock up::
{
  Send "{LControl Up}"

  if (A_PriorKey == "CapsLock") {
    if (A_TimeSincePriorHotkey < 1000)
      Suspend "1"
    Send "{Esc}"
    Suspend "0"
  }
}

; alt+caps: delete
!CapsLock::Delete

; win+caps: alt+f4
#CapsLock::
{
  Send "!{f4}"
}

; SECTION: win+escape to exit when bug exits
#Esc:: ExitApp

; SECTION: Start WSL Terminal in the repo directory
^!t:: ; Ctrl+Alt+T
{
  Run("wsl --cd \\wsl.localhost\Ubuntu\home\leo\repo")
}

; SECTION: Rotate second display screen
^!r:: ; Ctrl+Alt+R
{
  Vertical := MsgBox("Yes:Vertical, No:Horizontal", , "YesNoCancel")

  if (Vertical = 'Cancel')
    return

  Run("ms-settings:screenrotation")
  sleep 3000 ; wait until setting tab is opened
  Send "{TAB 4}"
  Send "{Enter}" ; select the second display screen

  ; find the orientation option
  Send "{TAB 18}"
  Send "{Enter}"

  if (Vertical = "Yes") {
    Send "{down}" ; move to vertical
  } else {
    Send "{up}" ; move to horizontal
  }

  Send "{Enter}"

  ; confirm saving the change
  sleep 2500
  Send "{TAB}"
  Send "{Enter}"

  ; close the window
  sleep 1000
  winClose "A"
}

; SECTION: alt hjkl to directions
!h:: Send "{Left}"
!j:: Send "{Down}"
!k:: Send "{Up}"
!l:: Send "{Right}"

; Shift modifier
+!h:: Send("+{Left}")
+!j:: Send("+{Down}")
+!k:: Send("+{Up}")
+!l:: Send("+{Right}")

; Ctrl modifier
^!h:: Send("^{Left}")
^!j:: Send("^{Down}")
^!k:: Send("^{Up}")
^!l:: Send("^{Right}")

; Ctrl+Shift
^+!h:: Send("^+{Left}")
^+!j:: Send("^+{Down}")
^+!k:: Send("^+{Up}")
^+!l:: Send("^+{Right}")

#+h:: {
  Send "{LWin down}{Shift down}{Left}{LWin Up}{Shift up}"
  return
}

#+l:: {
  Send "{LWin down}{Shift down}{Right}{LWin Up}{Shift up}"
  return
}

; SECTION: remap right alt
RAlt:: Send("{BackSpace}")
^RAlt:: Send("^{BackSpace}")
LAlt & RAlt:: Send("{Enter}")