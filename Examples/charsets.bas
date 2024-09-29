'A quick program for nxtBasic in whicn you can iterate through all x16 character sets
'Developed by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

cntCharSets=12
Dim CharSets(cntCharSets) as string
CharSets(1)="iso"
CharSets(2)="PET UPPER/GRAPH"
CharSets(3)="pet upper/lower"
CharSets(4)="PET UPPER/GRAPH (THIN)"
CharSets(5)="pet upper/lower (thin)"
CharSets(6)="iso (thin)"
CharSets(7)="cp437"
CharSets(8)="cyrillic iso"
CharSets(9)="cyrillic iso (thin) "
CharSets(10)="eastern latin iso"
CharSets(11)="eastern iso (thin) "
CharSets(12)="katakana (thin) "

SCREEN 1
COLOR 5,0
CLS
locate 10,15
PRINT "USE LEFT AND RIGHT ARROW TO ITERATE THROUGH CHARSETS"
SLEEP 180
CLS

curCharSet=1
GOSUB ChangeCharSet


Loop:
    key$ = GET
    if Key$ = CHR$(29) THEN     'Right arrow
        curCharSet=curCharSet+1
        if curCharSet>cntCharSets then curCharSet=1
        GOSUB ChangeCharSet
    END IF
    if Key$ = CHR$(157) THEN    'Left arrow
        curCharSet=curCharSet-1
        if curCharSet=0 then
            curCharSet=cntCharSets
        end if
        GOSUB ChangeCharSet
    END IF
 

GOTO Loop

ChangeCharSet:
    if curCharSet>=2 and curCharSet<=5 then
        EXITISO 
    else
        ENTERISO
    end if
    SETCHARSET curCharSet
    locate 0,5
    PRINT STR$(curCharSet) + ": " + CharSets(curCharSet) + "                   "
    Gosub PrintCharSet
return

PrintCharSet:
    row=1
    col=5

    For i = 32 to 255
        if i<$80 or i>$9F then
            locate row,col
            
            print str$(i) + ": " + chr$(i)
            row=row+1
            if row>28 then
                row=1
                col=col+10
            end if
        end if
    next
    col=5
return