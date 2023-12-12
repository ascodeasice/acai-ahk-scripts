

; caps lock: escape
; caps+key: ctrl+key
; alt+caps: caps
; win+caps: alt+f4
*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey=="CapsLock"){
	if (A_TimeSincePriorHotkey < 1000)
		Suspend "1"
		Send "{Esc}"
		Suspend "0"
	}
}

!CapsLock::CapsLock ; use alt capslock to use normal capslock

#CapsLock:: ; win+capslock = alt+f4(close window)
{
  Send "!{f4}"
}

#Esc:: ExitApp ; win+escape to exit when bug exits

; Start WSL Terminal in the repo directory
^!t:: ; Ctrl+Alt+T
{
  Run("wsl --cd \\wsl.localhost\Ubuntu\home\leo\repo")
}

!q::Escape ; Alt+Q=Esc

!CapsLock::CapsLock ; use alt capslock to use normal capslock

^CapsLock::Delete ; Ctrl+CapsLock = Delete

; Rotate second display screen
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

; ctrl+q = Escape
^q::
{
  Send "{Escape}"
}