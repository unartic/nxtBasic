'Compile with nxtBasic: https://github.com/unartic/nxtBasic

ENTERISO

Dim KeyCodes(128) as string

'Row 1
KeyCodes($6E)="ESC"
KeyCodes($70)="F1"
KeyCodes($71)="F2"
KeyCodes($72)="F3"
KeyCodes($73)="F4"
KeyCodes($74)="F5"
KeyCodes($75)="F6"
KeyCodes($76)="F7"
KeyCodes($77)="F8"
KeyCodes($78)="F9"
KeyCodes($79)="F10"
KeyCodes($7A)="F11"
KeyCodes($7B)="F12"
KeyCodes($7C)="PRNTSCRN"
KeyCodes($7D)="SCROLLCK"
KeyCodes($7E)="PAUSE"


'Row 2
KeyCodes($01)="`"
KeyCodes($02)="1"
KeyCodes($03)="2"
KeyCodes($04)="3"
KeyCodes($05)="4"
KeyCodes($06)="5"
KeyCodes($07)="6"
KeyCodes($08)="7"
KeyCodes($09)="8"
KeyCodes($0A)="9"
KeyCodes($0B)="0"
KeyCodes($0C)="-"
KeyCodes($0D)="="
KeyCodes($0E)="BACKSPC"
KeyCodes($0F)="BACKSPC"

KeyCodes($4B)="INSERT"
KeyCodes($50)="HOME"
KeyCodes($55)="PGUP"

KeyCodes($5A)="NUMLCK"
KeyCodes($5F)="/"
KeyCodes($64)="*"
KeyCodes($69)="-"

'Row 3
KeyCodes($10)="TAB"
KeyCodes($11)="Q"
KeyCodes($12)="W"
KeyCodes($13)="E"
KeyCodes($14)="R"
KeyCodes($15)="T"
KeyCodes($16)="Y"
KeyCodes($17)="U"
KeyCodes($18)="I"
KeyCodes($19)="O"
KeyCodes($1A)="P"
KeyCodes($1B)="["
KeyCodes($1C)="]"
KeyCodes($1D)="\"

KeyCodes($4C)="DEL"
KeyCodes($51)="END"
KeyCodes($56)="PGDN"

KeyCodes($5B)="7"
KeyCodes($60)="8"
KeyCodes($65)="9"
KeyCodes($6A)="+"

'Row 4
KeyCodes($1E)="CAPS"
KeyCodes($1F)="A"
KeyCodes($20)="S"
KeyCodes($21)="D"
KeyCodes($22)="F"
KeyCodes($23)="G"
KeyCodes($24)="H"
KeyCodes($25)="J"
KeyCodes($26)="K"
KeyCodes($27)="L"
KeyCodes($28)=";"
KeyCodes($29)="'"
KeyCodes($2A)="ENTER"
KeyCodes($2B)="ENTER"

KeyCodes($5C)="4"
KeyCodes($61)="5"
KeyCodes($66)="6"
KeyCodes($6B)="+"

'Row 5
KeyCodes($2C)="SHFTL"
KeyCodes($2D)="SHFTL"
KeyCodes($2E)="Z"
KeyCodes($2F)="X"
KeyCodes($30)="C"
KeyCodes($31)="V"
KeyCodes($32)="B"
KeyCodes($33)="N"
KeyCodes($34)="M"
KeyCodes($35)="<"
KeyCodes($36)=">"
KeyCodes($37)="?"
KeyCodes($38)="SHFTR"
KeyCodes($39)="SHFTR"

KeyCodes($53)="UP"

KeyCodes($5D)="1"
KeyCodes($62)="2"
KeyCodes($67)="3"
KeyCodes($6C)="ENTER"

'Row 6
KeyCodes($3A)="CTRL"
KeyCodes($3B)="SPEC"
KeyCodes($3C)="ALT"
KeyCodes($3D)="SPACE"
KeyCodes($3E)="ALTGR"
KeyCodes($3F)="SPEC"
KeyCodes($40)="CTRL"
KeyCodes($4F)="LEFT"
KeyCodes($54)="DOWN"
KeyCodes($59)="RIGHT"
KeyCodes($5E)="0"
KeyCodes($63)="0"
KeyCodes($68)="."
KeyCodes($6D)="ENTER"



OldLine$=SPC(200)
Line$=SPC(200)

cls
Loop:
    locate 0,0
    for i = 0 to 4
        btn$=JoyButtons(i)
        if btn$="" then 
            aa$="(not found)"
        end if
        PRINT "JOY " + STR$(i) + ": " + btn$
    next
       
    Line$=""
    for i = 1 to 128
        if KEYDOWN(i) Then
            Line$ = Line$ + KeyCodes(i) + " "
        end if
    next
    if Line$<>OldLine$ then
        locate 5,0
        PRINT SPC(200)
        locate 5,0
        PRINT Line$
        OldLine$ = Line$
        
    end if
    
Goto Loop