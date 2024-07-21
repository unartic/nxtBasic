# Releases

## Version 0.3b

**What's new:**
- Bug fixes: 
    - Fixed several double used labels on the assembly side of nxtBasic
    - Fixed incorrect compile time error when using array as function param
    - Fixed bug with INPUT# returning a null-byte when eof was reached
    - Fixed bug with 4bpp color depth in ADDSPRITE method
    - Fixed bug in LEN-function
    - Fixed bug where there are comments on the same line on a CONST definition
    
- Added: 
    - CURSCREENMODE: returns the current screen-mode
    - GETROWS: returns number of text mode rows
    - GETCOLS: returns number of text mode columns
    - OPENFILE: an easier way to open files for reading and writing: handle=OPENFILE("Filename",READ)
    - SETDEVICE {devicenr}: sets the device all file i/o related function should use (only needed if device is not 8)
    - SETCOL: locate for column only
    - SETINDENT: sets a default indentation for the PRINT command
    - CURDIR$   - returns the current directory
    - DIRLIST/DIRITEM: to retrieve directoy listing
    - New example programs:
        - tetris.bas     - a text mode tetris clone
        - browse-dir.bas - browse through your directory structure using DIRLIST/DIRITEm functions
    
- Improved:
    - Changed the internal True and False statements to True=-1 and False=0, altered the AND OR and NOT operators. They now (also) function as bitwise operators
    - Changed all (but OPEN)-statements to use the SETDEVICE or device 8.
    - PLAYZCM and PLAYZSM do not longer require a filehandle, that'll be automaticly arranged by nxtBasic
    - Changed the Modulus operator from % to MOD, because it was interfering with binary assignment: a=%00110110

- [Download nxtBasic 0.3b for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.3b-win.zip)
- [Download nxtBasic 0.3b for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.3b-linux.zip)
- [Download nxtBasic 0.3b for MacOS](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.3b-mac.zip)

 
## Version 0.2b

**What's new:**
- Bug fixes: 
    - Compiler: comparison operants mixing floats and integers didn't work correctly
    - Assembler: Indirect label replacement for values >255, missing leading zero
    - Fixed double declaration in drawbmx.bas example program 
    
- Added: 
    - support to play ZCM files from disk
    - support to play ZSM files from disk
    - INSTR-function
    - LINPUT#-function
    
- Improved:
    - RESTORE {label}: can now be used with label
    - #INCLUDE keeps track of which files are included and will not include a file with the same name more then once.
    - If nxtbasic is called when not in the nxtbasic direcory, dependencys are read from the nxtbasic directory

- [Download nxtBasic 0.2b for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-0.2b-win.zip)
- [Download nxtBasic 0.2b for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-0.2b-linux.zip)


## Version 0.1b
Initial version, only for Windows.

[Download](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-0.1b.zip)