# Releases

## Version 1.0

**What's new:**

- Bug fixes
    - LCASE/UCASE now also change the case of extended chars in an ISO charset
    - Automatic run command wasn't working correctly without the -startin x16emu param. 

- New:
    - OVAL-function to draw circles and ovals.

- Improved:
    - All sprite function have a performance improvement of up to 10%
    - 9% performance increase in handling integer arrays with one dimension
    - 23% performance increase with FOR-NEXT loops
    - 20% performance increase in retrieving an integer variable
    - Example charsets.bas is now showing ISO charsets correctly and Katakana charset is added
    
- New example programs:
    - starfield.bas -> moving starfield: sprite movement demonstration
    - spiro.bas -> create a spirograph based on user input

- [Download nxtBasic 1.0 for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v1.0-win.zip)
- [Download nxtBasic 1.0 for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v1.0-linux.zip)
- [Download nxtBasic 1.0 for MacOS](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v1.0-mac.zip)


## Version 0.6b

**What's new:**



- Bug fixes
    - Fixed bug in ASC function
    - Fixed bug in left$
    - Fixed bug with loading basic constants
    - Fixed bug with incorrect compile time errors when two return types are possible
    - Fixed bug when returning a value in a function with using EXIT FUNCTION

- New:
    - Added [HLT](07.%20Control%20flow%20statements.md#hlt) to stop execution of code. Handy for debugging
    - Added [REPLACE](10.%20String%20handling.md#replace) to replace a portion of a string
    - Added [SPLITITEM](10.%20String%20handling.md#splititem): a 'split in place' function
    - Added [Tally()](10.%20String%20handling.md#tally): counts occurences of a char in a string
    - Added [INSTRREV()](10.%20String%20handling.md#instrrev): same as INSTR but then check from right to left


- Improved:
    - Performance improvement of about 50% on PSET
    - Compile time error checking on using the '+' operator on a mix between string and number
    - Implemented new way to load string and float literals, reducing prg size


- [Download nxtBasic 0.6b for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.6b-win.zip)
- [Download nxtBasic 0.6b for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.6b-linux.zip)
- [Download nxtBasic 0.6b for MacOS](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.6b-mac.zip)

  

## Version 0.5b

**What's new:**

- Bug fixes
    - Fixed bug while checking length of string concatanation
    - Fixed bug when multiple lines seperated by a semicolon where places behind the THEN statement
    - Fixed bug in BLOAD function
    - Fixed bug in function/sub definition where there was as space in front of an argument.
    - Fixed bug in BANK and COLOR statement when not supplying the optional argument

- New:
    - Added [CHAIN](15.%20Miscellaneous%20.md#chain) -> resume executing into another PRG-file.
    - Added "EXIT SUB" and "EXIT FUNCTION"
    - Added [documentation](16.%20Extending%20nxtBasic.md) on how to extend nxtBasic with your own assembly routines
    - Added DO/LOOP/EXIT LOOP
    - Added "OPTION EXPLICIT" to force declaration of variables
    - Added DIRITEMDATE(), DIRITEMTIME() and DIRITEMSIZE() to retrieve all file information
    - Added [internal constants](17.%20Internal%20constants.md) for 16 bit registers (r0,r1 etc) and vera-registers

- Improved:
    - Moved WorkBuffer and stacktable to end of low mem space
    - VERA FX multiplication output moved to non-visible piece of vram
    - ADDSPRITE can now also be called with an address instead of a filename to configure a sprite which is already in vram
    - ADDSPRITE returns the vram address a sprite is loaded into GETA(), GETX() and GETY()
    - Added ",FORCE" at the #INCLUDE directive to force an include, even if the file has been included before.
    - If BINPUT# is used to load less then 256 bytes, MACPTR is used to speed up the reading
    - Syntax checking for CONST definitions on compile time.
    - nxtBasic resets several internal memorylocation on run so running a prg several times should not cause an issue
    - Several performance improvements regarding sprite functions
    - 25% performance improvement on FOR-NEXT loops when there is no STEP defined.


- [Download nxtBasic 0.5b for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.5b-win.zip)
- [Download nxtBasic 0.5b for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.5b-linux.zip)
- [Download nxtBasic 0.5b for MacOS](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.5b-mac.zip)


## Version 0.4b

**What's new:**

- Bug fixes
    - Fixed bug while playing multiple zcm-files in sequense
    - Fixed bug with GETBMXHEIGHT and GETBMXWIDTH
    - Fixed bug in custom keyboard handler
    - Fixed bug in the internals of string storage in ram, causing string space to be filled rappidly
    - Fixed bug reading from DATA blocks with negative integers
    - Fixed bug: READ() was disabled due to build in constant READ (for OPENFILE). READ and WRITE are renamed to FOR_READ and FOR_WRITE
    - Fixed bug in line draw routine, not restore vera to prev state correctly

- New:
    - CURROW() -> returns the current row the cursor is on
    - CURCOL() -> returns the current column the cursor is on
    - PushVar() -> push the contents of a variable to the variable stack
    - PullVar() -> pulls a value from the stack and assigns it to a variable
    - User defined functions: FUNCTION MyFunc() as String
    - User defined sub routines: SUB MySub()
    
- New example programs:
    - player.bas: file browser which plays zcm and zsm files and shows bmx images
    - keyjoy.bas: demonstration of joystick and keyboard routines with multiple key presses simultaneously
  
- [Download nxtBasic 0.4b for Windows](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.4b-win.zip)
- [Download nxtBasic 0.4b for Linux](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.4b-linux.zip)
- [Download nxtBasic 0.4b for MacOS](https://github.com/unartic/nxtBasic/raw/main/Download/nxtBasic-v0.4b-mac.zip)

  
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