#SingleInstance force

#Esc:: ExitApp ; win+escape to exit when bug exits
CapsLock::Delete ; turn caps lock into right shift

; Start WSL Terminal in the repo directory
^!t:: ; Ctrl+Alt+T
{
  Run("wsl --cd \\wsl.localhost\Ubuntu\home\leo\repo")
}

!q::Escape ; Alt+Q=Esc

!CapsLock::CapsLock ; use alt capslock to use normal capslock

; Rotate second display screen
^!r:: ; Ctrl+Alt+R
{
  Vertical := MsgBox("Yes:Vertical, No:Horizontal", , "YesNo")
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

#CapsLock:: ; win+capslock = alt+f4(close window)
{
  Send "!{f4}"
}

; ctrl+q = Escape
^q::
{
  Send "{Escape}"
}