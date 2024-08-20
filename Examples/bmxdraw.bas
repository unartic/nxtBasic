'Paint-like program witten in nxtBasic which handles BMX files.
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

'Use:
'- right mouse button to change color
'- S to save
'- O to open
'1 and 2 to switch between two pencils


CurrentPen=1

Width = 0
Height = 0
DIM Pal(16) as string

SCREEN 128
FILLSCREEN 0    'Fill bitmap screen with black

COLOR 5,0
CLS
PRINT
PRINT
PRINT RPT$($60,40);
PRINT
PRINT
PRINT "             BMX PAINT V1.0"
PRINT
PRINT
PRINT RPT$($60,40);
PRINT
PRINT
PRINT
PRINT
PRINT "         COMPILED USING NXTBASIC"

LOCATE 20,19
PRINT ".";
GOSUB InitPalletteData
FOR i = 1 to 3
    PRINT ".";
    SLEEP 33    
next i


    
ShowMenu:
    cls
    locate 10,12
    ? "N -> NEW FILE"
    locate 11,12
    ? "O -> OPEN FILE"
    
    WaitKeyLoop:
        key$ = GET
        If key$="N" then GOTO NewFile
        If key$="O" then GOTO OpenFile
    GOTO  WaitKeyLoop


CalcStartCor:
    xStart = 160-(Width/2)
    yStart = 120-(Height/2)
    xEnd = xStart + Width
    yEnd = yStart + Height
return

NewFile:
    GOSUB AskWidthAndHeight
    Gosub CalcStartCor
    FILLSCREEN 0
    'Draw screen
    RECT xStart,yStart,xEnd,yEnd,1

GOTO StartEdit



StartEdit:
    CLS 'clear textmode layer
    MOUSE 1
    PRINT "  USE RIGHT MOUSE BTN TO CHANGE COLOR"
    PRINT "          S TO SAVE TO BMX"
    CurrentColor=5
    Gosub SetMousePointerToColor
    LastDrawX=0
    LastDrawY=0
    LastRightMouse=0
    Loop:
        if MB()=2 THEN LastRightMouse=1
        IF MB()=0 AND LastRightMouse=1 then 'Release of right mouse button
            LastRightMouse=0
            GoSub PickColor
        end if

        Key$=GET
        if Key$="S" then GOSUB SaveImage
        If Key$="N" then GOTO NewFile
        If Key$="O" then GOTO OpenFile
        If Key$="1" then CurrentPen=1
        If Key$="2" then CurrentPen=2

                    
        IF MB()=1 then  'while left mouse button is being pressed
            NewX = MX()
            NewY = MY()            
            IF NewX>=xStart AND NewX<=xEnd AND NewY>=yStart AND NewY<=yEnd THEN
                If LastDrawX=0 THEN LastDrawX=NewX
                If LastDrawY=0 THEN LastDrawY=NewY

                'LINE 
                if CurrentPen=1  then
                    LINE LastDrawX,LastDrawY,NewX,NewY,CurrentColor
                END IF
                if CurrentPen=2 then    'Thicker pen
                    LINE LastDrawX,LastDrawY,NewX,NewY,CurrentColor
                    LINE LastDrawX+1,LastDrawY-1,NewX+1,NewY-1,CurrentColor
                    LINE LastDrawX-1,LastDrawY+1,NewX-1,NewY+1,CurrentColor
                    
                    LINE LastDrawX+1,LastDrawY,NewX+1,NewY,CurrentColor
                    LINE LastDrawX,LastDrawY+1,NewX,NewY+1,CurrentColor
                end if
               
                
                LastDrawX = NewX
                LastDrawY = NewY
            else
                LastDrawX=0
                LastDrawY=0               
            end if
        else
            LastDrawX=0
            LastDrawY=0           
        end if
    
    Goto loop
end


PickColor:
    GOSUB SaveScreen
    PaletteX=80
    PaletteY=40
    PaletteBoxSize=10
    PaletteColorsPerRow=16
    GOSUB ShowPalette
    LastLeftMouse=0
  
    WaitLoop:
        
        if MB()=1 THEN LastLeftMouse=1
        
        IF MB()=0 AND LastLeftMouse=1 then  'wait for mouse button to be released
            CurrentColor = ((MY()-BackupPaletteY)/PaletteBoxSize*16)   + ((MX()-BackupPaletteX)/PaletteBoxSize)
            Gosub SetMousePointerToColor
            Goto PickColorDone
            LastLeftMouse=0
        end IF
    goto WaitLoop

    PickColorDone:
    Gosub RestoreScreen
    
return

ShowPalette:
    FRAME PaletteX-1,PaletteY-1,PaletteX+(PaletteBoxSize*PaletteColorsPerRow),PaletteY+(PaletteBoxSize*PaletteColorsPerRow),1
    BackupPaletteX = PaletteX
    BackupPaletteY = PaletteY+1
        
    
    adr = (PaletteY) * 320 + BackupPaletteX
    bnk = 0
    for i = 0 to 15
        for ln = 1 to 10
            VPOKEN bnk,adr,pal(i)
            adr=adr+320
            if adr<320 and adr>0 then bnk=bnk+1
        next ln
        
    next i
return

SetMousePointerToColor:
    VPOKE 1,$3011,CurrentColor
    VPOKE 1,$3011+16,CurrentColor
    VPOKE 1,$3012+16,CurrentColor
    VPOKE 1,$3021+16,CurrentColor
    VPOKE 1,$3022+16,CurrentColor
    VPOKE 1,$3023+16,CurrentColor
    VPOKE 1,$3031+16,CurrentColor
return

SaveScreen:
    'Write bitmap layer (320x240) to vram in two steps
    COPYVRAMTOHIGHRAM 0,0,$10,$A000         'Will write 5 rambanks of 8b each
    COPYVRAMTOHIGHRAM 0,$A000,$10+5,$8C00  
return

RestoreScreen:
    'Restore bitmap layer (320x240) from vram in two steps
    COPYHIGHRAMTOVRAM $10,0,0,$A000         'Will read 5 rambanks of 8b each
    COPYHIGHRAMTOVRAM $10+5,0,$A000,$8C00   
return


AskWidthAndHeight:
    cls
    PRINT
    PRINT "             NEW BMX FILE:"
    locate 3,10
    Width =  INPUT("WIDTH (PX): ")
    locate 5,10
    Height = INPUT("HEIGHT (PX):")
    if Width<1 or Width>320 then
        PRINT "WIDTH MUST BE BETWEEN 1 AND 320"
        Goto AskWidthAndHeight
    end if
    if Height<1 or Height>240 then
        PRINT "HEIGHT MUST BE BETWEEN 1 AND 240"
        Goto AskWidthAndHeight
    end if
return

EnterFileName:
    CLS
    PRINT
    PRINT "          ENTER BMX FILENAME:"    
    Gosub SaveScreen
    FILLSCREEN 0    'clear bitmap layer to black
    locate 5,10
    Filename$ = INPUT("FILENAME:")
    cls             'clear text mode layer
    Gosub RestoreScreen    
return

OpenFile:
    Gosub EnterFileName
    if Filename$<>"" then
        If FileExists(FileName$) then
            Width = GetBMXWidth(Filename$)
            Height = GetBMXHeight(Filename$)

            Gosub CalcStartCor
            FILLSCREEN 0
            DrawBMX FileName$,xStart,yStart
        else
            print "FILE DOES NOT EXISTS, TRY AGAIN"
            goto OpenFile
        end if
    else    
        end
    end if
Goto StartEdit

SaveImage:
    gosub EnterFileName
    if Filename$<>"" then
        If FileExists(FileName$) then
            Gosub SaveScreen
            FILLSCREEN 0
            locate 10,5
            PRINT "FILE ALREADY EXISTS"
            locate 12,5
            PRINT "USE '@:FILENAME' TO OVERWRITE"
            SLEEP 200
            cls
            Gosub RestoreScreen
            Goto SaveImage  'ask again
        else
            locate 0,13
            PRINT "SAVING FILE..."
            SAVEBMX Filename$,xStart,yStart,Width,Height
            CLS
            locate 0,10
            PRINT "FILE HAS BEEN SAVED"
            SLEEP 60
            CLS
        end if
    end if
return


InitPalletteData:
    'Drawing the palette is quite slow, so we create 16 strings of 160 bytes contins 16 colors with 10 pixesl each to print later
    for i = 0 to 16
        pal(i) = SPC(160)   'Reserve ram, so concatanating does not result in fragmentation of memory
    next

    for i = 0 to 255 step 16
        pal(i/16)=""
        for c = 0 to 15
            pal(i/16) = pal(i/16) + RPT$(CHR$(i+c),10)
        next c
    next i
return


