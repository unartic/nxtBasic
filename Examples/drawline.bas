'Demonstration of the line draw function in nxtBasic, using the VERA FX Line draw helper. 
'Developed by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

CLS
locate 25,28
Print "PRESS A KEY DO BEGIN..."
Wait:
A$=GET
if A$="" then 
    goto Wait
end if

SCREEN 128

color 6,1
locate 15,5
UseColor=0
PRINT "DEMO OF VERA FX LINE DRAW HELPER"
Loop:
    FOR x = 0 to 319
        LINE 160,120,x,0,UseColor
    NEXT x

    FOR y = 0 to 239
        LINE 160,120,319,y,UseColor
    NEXT y

    FOR x = 319 to 0 step -1
        LINE 160,120,x,239,UseColor
    NEXT x

    FOR y = 239 to 0 step -1
        LINE 160,120,0,y,UseColor
    NEXT y
    UseColor=UseColor+1

    if UseColor=255 then 
        UseColor=0
    end if

goto loop
