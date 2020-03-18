# WindowQuickSize
Bask in the glory of my ~~shitty~~ **divine** AutoHotkey script that positions and resizes windows to some frequently used (at least in my workflow) sizes and positions. This script is helpful if you have an ultrawide monitor and a similar workflow as me. 

## Definitions
These are the different types of windows I have created. Note that I designed this script to give the windows some padding, simply because I think it looks and feels good. The padding is the same for all dimensions (x and y). It is only defined by the distance from the left edge of your screen to the active window the momemt you configure the main window by pressing `Shift+ctrl+alt+1`. This means that the vertical position of the window you configure to be the main window does not matter. The height will automatically be resized to `screen_height - 2 * padding` once you pressed the configure keybinding. The only things you need to keep in mind when configuring the main window is the width of the active window and its distance from the left edge of your screen.
#### Main window
The main window is supposed to act as the window that you primarly focus on, which will likely take up major part of your screen, this could for example be a code editor.

#### Support window
This window acts as a support window to the main window, this could for example be a web browser or file explorer that you browse while you code in the main window. Note that the main window is always on the left side, if you try to place it on the right side, this script will misinterpret that as a lot of padding and everything will be bonk.

#### Cycle window
This window have three (cyclable) preset size: large, medium and small. Try them out and you'll see what I mean. I use the large window size when I casually browse the web. The medium window is a good size for spotify and discord (in my opinion) and the small window is the typical file explorer size for me.

#### Full screen window
Pretty self explanatory, except that it is full screen with padding.

#### Custom window
This window is customisable, just resize and place a window in a position and size you want and this window will be defined by that size and position.

## Keybindings
`Shift+ctrl+alt+1`
Initialize the dimensions, including padding, for the main window, which in turn define the dimensions for the support window (width and padding) and the full screen window (padding).  

`Shift+alt+1`
Place and resize the active window so it has the positon and size of the main window.

`Shift+alt+2`
Place and resize the active window so it has the positon and size of the support window.
 
`Shift+alt+3`
Cycle through the cycle window sizes for the active window.

`Shift+alt+4`
Make the active window a full screen window.

`Shift+alt+q`
Place and resize the active window so it has the positon and size of the custom window.

`Shift+alt+r`
Undo the size and position change of the active window. **Note: almost as buggy as it can be, no plan for fixing it at the moment.**

`Shift+ctrl+alt+s`
Save current configuration to the .ini file. You won't ever need to press this since the other commands already save to the .ini file. I just thought I would include it just in case. 

# How do I run this magnificent gift to mankind
1. Clone the repository
2. Click (twice) on the executable 

To automatically run the script on startup see: https://www.autohotkey.com/docs/FAQ.htm#Startup

Note: you don't need AutoHotkey installed to run the executable.
