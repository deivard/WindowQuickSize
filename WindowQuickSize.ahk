#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Main window dimensions
Global main_x,main_y,main_w,main_h
; Support window dimensionn
Global sup_x,sup_y,sup_w,sup_h
; Adaptive window dimensions
Global cycle_x0,cycle_y0,cycle_w0,cycle_h0, cycle_x1,cycle_y1,cycle_w1,cycle_h1, cycle_x2,cycle_y2,cycle_w2,cycle_h2 ;, cycle_x3,cycle_y3,cycle_w3,cycle_h3
; Adaptive window dimension tracker
Global cycle_index = 0 
; Full screen dimensions
Global full_x,full_y,full_w,full_h
; User defined custom window dimensions
Global cust_x,cust_y,cust_w,cust_h
; Keep track of dimension of window before changing
Global last_x,last_y,last_h,last_w,last_title = "nothing"
Global padding = 7
SysGet, ScreenArea, MonitorWorkArea
global screen_h = % ScreenAreaBottom - ScreenAreaTop
global screen_w = % ScreenAreaRight - ScreenAreaLeft
global window_h = % screen_h - (2*padding)


Global section = "Settings"
init() {
  IniRead, padding, WindowQuickSize.ini, %section%, padding, 7
  ; Update window_h based on padding
  window_h = % screen_h - (2*padding)

  ; Read the main window dimensions
  IniRead, main_x, WindowQuickSize.ini, %section%, main_x, -1
  IniRead, main_y, WindowQuickSize.ini, %section%, main_y, -1
  IniRead, main_w, WindowQuickSize.ini, %section%, main_w, -1
  IniRead, main_h, WindowQuickSize.ini, %section%, main_h, -1

  ; Create the support window dimensions (they depend on the dimension of the main window)
  sup_x = % main_w + 2 * padding
  sup_y = % main_y
  sup_w = % screen_w - main_w - (3 * padding)
  sup_h = % window_h

  ; Full screen window dimensions
  full_x = % main_x
  full_y = % main_y
  full_w = % screen_w - 2 * padding
  full_h = % window_h

  ; NOTE: This configuration is not used anymore
  ; First configuration of cycleive window.
  ; Same dimension as full screen but only cover 6/8 of width
  ; cycle_x0 = % screen_w/8
  ; cycle_y0 = % main_y
  ; cycle_w0 = % (screen_w/8)*6
  ; cycle_h0 = % main_w

  ; This is the new first configuration
  cycle_x0 = % (screen_w/8)
  cycle_y0 = % (screen_h/48)
  cycle_w0 = % (screen_w/8)*6
  cycle_h0 = % (screen_h/48)*46.5
  ; Second configuration of cycleive window.
  ; Just a bit smaller than previous window.
  cycle_x1 = % (screen_w/25)*6
  cycle_y1 = % (screen_h/25)*3
  cycle_w1 = % (screen_w/25)*12
  cycle_h1 = % (screen_h/25)*17
  ; Third configuration of cycleive window.
  ; Just a bit smaller than previous window.
  cycle_x2 = % (screen_w/25)*7.5
  cycle_y2 = % (screen_h/25)*5
  cycle_w2 = % (screen_w/25)*10
  cycle_h2 = % (screen_h/25)*15

  ; Read the user defined custom window dimensions
  IniRead, cust_x, WindowQuickSize.ini, %section%, cust_x, -1
  IniRead, cust_y, WindowQuickSize.ini, %section%, cust_y, -1
  IniRead, cust_w, WindowQuickSize.ini, %section%, cust_w, -1
  IniRead, cust_h, WindowQuickSize.ini, %section%, cust_h, -1

  return
}

init() ; Initialize variables from ini file

; Configure the main window width and the padding. This is the bread and butter for this script
; since most of the windows are dependant on the dimensions provided by the main window.
^!+1::
  ; y and height value not used, since they will be calculated based on padding and screen height
  WinGetPos, padding, nan, main_w, nan, A  ; "A" to get the active window's pos.
  ; Recalculate window_h
  window_h = % screen_h - (2*padding)
  save()
  init()
  WinGetActiveTitle, title
  ; Move the window so it reflects the configuration
  WinMove, %title%,, main_x, main_y, main_w, main_h
return

^!+q::
  WinGetPos, cust_x, cust_y, cust_h, cust_w, A  ; "A" to get the active window's pos.

  ; Automatically save custom window configurations, so user don't have to press ctrl+shift+s
  IniWrite, % cust_x, WindowQuickSize.ini, %section%, cust_x
	IniWrite, % cust_y, WindowQuickSize.ini, %section%, cust_y
	IniWrite, % cust_w, WindowQuickSize.ini, %section%, cust_w
	IniWrite, % cust_h, WindowQuickSize.ini, %section%, cust_h
return

save(){
  ; Look at the x-axis for padding
  IniWrite, % padding, WindowQuickSize.ini, %section%, padding

  ; Save main window configurations
  IniWrite, % padding, WindowQuickSize.ini, %section%, main_x
	IniWrite, % padding, WindowQuickSize.ini, %section%, main_y
	IniWrite, % main_w, WindowQuickSize.ini, %section%, main_w
	IniWrite, % window_h, WindowQuickSize.ini, %section%, main_h

  ; Note: This is reduntand at the moment since the custom window configuration command already saves to the init file every time.
  ; Save custom window configurations
  ; IniWrite, % cust_x, WindowQuickSize.ini, %section%, cust_x
	; IniWrite, % cust_y, WindowQuickSize.ini, %section%, cust_y
	; IniWrite, % cust_w, WindowQuickSize.ini, %section%, cust_w
	; IniWrite, % cust_h, WindowQuickSize.ini, %section%, cust_h
}

; Save current configurations 
^!+s::
  save()
  init()
return

; Shift+alt+r: Undo last window change
+!r::
  WinMove, %last_title%,, %last_x%, %last_y%, %last_w%, %last_h% 
return

; Shift+alt+1: Move active window to main position
+!1::
  WinGetActiveTitle, title
  if (title != last_title){
    ; Store the window's last configuration for undos only if this isnt the last window interacted with
    WinGetPos, last_x, last_y, last_w, last_h, A  ; "A" to get the active window's pos.
    lastTitle = %title%
  }
  WinMove, %title%,, main_x, main_y, main_w, main_h
return

; Shift+alt+2: Move active window to support position
+!2::
  WinGetActiveTitle, title
  if (title != last_title){
    ; Store the window's last configuration for undos only if this isnt the last window interacted with
    WinGetPos, last_x, last_y, last_w, last_h, A  ; "A" to get the active window's pos.
    lastTitle = %title%
  }
  WinMove, %title%,, sup_x, sup_y, sup_w, sup_h
return

; Shift+alt+3: Move active window to cycleive position 
+!3::
  WinGetActiveTitle, title
  if (title != last_title){
    ; Store the window's last configuration for undos only if this isnt the last window interacted with
    WinGetPos, last_x, last_y, last_w, last_h, A  ; "A" to get the active window's pos.
    lastTitle = %title%
  }
  ; Check if the last active is the one that is active now
  if (cycleive_last_title = title) {
    ; Increment the cycleive counter
    cycle_index = % mod(cycle_index + 1, 3) 
  }
  else {
    ; Else we should use the first configuration
    cycle_index := 0
    ; MsgBox, %cycle_index% 
  }
  last_title = %title%
  cycleive_last_title = %title%
  WinMove, %title%,, cycle_x%cycle_index%, cycle_y%cycle_index%, cycle_w%cycle_index%, cycle_h%cycle_index%
return

; Shift+alt+4: Move active window to full screen position
+!4::
  WinGetActiveTitle, title
  if (title != last_title){
    ; Store the window's last configuration for undos only if this isnt the last window interacted with
    WinGetPos, last_x, last_y, last_w, last_h, A  ; "A" to get the active window's pos.
    lastTitle = %title%
  }
  WinMove, %title%,, full_x, full_y, full_w, full_h
return

; Shift+alt+q: Move active window to custom position
+!q::
  WinGetActiveTitle, title
  if (title != last_title){
    ; Store the window's last configuration for undos only if this isnt the last window interacted with
    WinGetPos, last_x, last_y, last_w, last_h, A  ; "A" to get the active window's pos.
    lastTitle = %title%
  }
  WinMove, %title%,, cust_x, cust_y, cust_h, cust_w
return