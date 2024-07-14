# Releases

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