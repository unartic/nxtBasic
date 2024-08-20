'TETRIS
'Compile with nxtBasic: https://github.com/unartic/nxtBasic


CONST keyLeft = 157
CONST keyRight = 29     
CONST keyUp = 145

CONST KeyCodeLeft = $4f
CONST KeyCodeRight = $59
CONST KeyCodeDown = $54
CONST KeyCodeUp = $53

CONST BlockPerLevel = 15
CONST BlockSize = 4

SCREEN 1
SETCHARSET 4    'set thin charset, looks nice

StartGame:
color 1,0
cls

Width=20
Height=20
OffsetX = (GETCOLS()/2) - ((Width+2)/2)
OffsetY = (GETROWS()/2) - ((Height)/2)

Dim Field(Height,Width)
Dim Block(BlockSize,BlockSize)
Dim BlockBackup(BlockSize,BlockSize)
Level = 1
Points=0
cntBlocks=0

Gosub DrawScreen
Gosub GetNewBlock
Gosub DrawBlock
Gosub PrintScore

speed=50

lastTI=TI
keyPressDelay=TI

Loop:
    key=0
    if TI-keyPressDelay>0 then
        key=1
        keyPressDelay=TI
    end if

    
    if TI-lastTI>speed or (key=1 and KEYDOWN(KeyCodeDown)) then
        BlockY=BlockY+1
        Gosub CanMove
        BlockY=BlockY-1
        if Result=True then
            BlockY=BlockY+1
            if KEYDOWN(KeyCodeDown)=False then
                Gosub PlayBlockDown
            end if
            Gosub DrawBlock
            Gosub CleanUpY  'Prevent a bit of flickering of block
        else
            Gosub CopyBlockToField
            Gosub RemoveFullRows
            Gosub PrintField
            Gosub GetNewBlock
            Gosub DrawBlock         

            BlockY=BlockY+1
            Gosub CanMove
            BlockY=BlockY-1
            if Result=False then Goto GameOver
        end if
        lastTI=TI
    end if

    
    key=GET
    if key=KeyLeft then
        BlockX=BlockX-2
        Gosub CanMove
        BlockX=BlockX+2
        if Result=True then
            gosub HideBlock
            BlockX=BlockX-2
            gosub DrawBlock
        end if
    elseif key=keyRight then
        BlockX=BlockX+2
        Gosub CanMove
        BlockX=BlockX-2
        if Result=True then
            gosub HideBlock
            BlockX=BlockX+2
            gosub DrawBlock
        end if
    elseif key=keyUp then   'rotate
        Gosub BackupBlock
        Gosub RotateBlock
        Gosub CanMove
        Gosub RestoreBlock
        if Result=True then
            gosub HideBlock
            gosub RotateBlock
            gosub DrawBlock                
        end if
    end if

goto Loop

PlayBlockDown:
    PSGINIT 
    PSGFREQ 1,100
    for p = 1 to 20
    next p
    PSGFREQ 1,0
return

GameOver:
    gosub ClearKeyboardBuffer
    gosub PrintWindow
    color 0,1

    locate 6,20
    PRINT "              GAME OVER"
    PRINT
    Gosub ShowHighScore
    SETCOL 20
    PRINT "            TRY AGAIN? (Y/N)"
    
    WaitLoop:
        key$ = GET
        if key$="Y" then goto StartGame
        if key$="N" then goto ToBasic
    Goto WaitLoop    

ToBasic:
    screen 0
    color 1,6
    cls
    end

ShowHighScore:
    Dim HighScore(10,2) as string

    cntHighScores=0
    if FileExists("SCORES.BIN") then
        handle = OPENFILE("SCORES.BIN",FOR_READ)
        for i = 1 to 10
            
            HighScore(i,1)=INPUT#(handle)
            HighScore(i,2)=INPUT#(handle)

            if EOF then break
            cntHighScores=cntHighScores+1
        next i
        CLOSE handle
    end if

    
    
    if cntHighScores>0 then
        SETCOL 20
        PRINT "HIGHSCORES: " 
        
        for c = 1 to cntHighScores
            SETCOL 20
            PRINT LTRIM$(STR$(c)) + ": " + HighScore(c,1);
            PRINT " " + HighScore(c,2)
        next
        PRINT
    end if
    
    Gosub IsHighScore
    if Result=True then
        Gosub ClearKeyboardBuffer
        SETCOL 20
        PRINT "YOU HAVE A HIGHSCORE!"
        PRINT
        SETCOL 20
        Name$ = INPUT("WHAT IS YOUR NAME:")
        Gosub AddHighScore
    end if
return

PrintWindow:
    color 0,1
    locate 5,18
    for i = 1 to 20
        SETCOL 18
        PRINT SPC(44)
    next i     
    locate 6,20
return



ClearKeyboardBuffer:
    key$=GET
    if key$<>"" then goto ClearKeyboardBuffer
return

SaveHighScores:
    handle = OPENFILE("@:SCORES.BIN",FOR_WRITE)
    for i = 1 to 10
        if HighScore(i,1)="" then break
        PRINT# handle,HighScore(i,1)
        PRINT# handle,HighScore(i,2)
    next i
    CLOSE handle
return

AddHighScore:
    if HighScoreIndex=cntHighScores+1 then  'add at the back
        HighScore(HighScoreIndex,1)=Name$
        HighScore(HighScoreIndex,2)=STR$(POINTS)
        Gosub SaveHighScores
    else
        'Move highscores to make room
        for i = 10 to HighScoreIndex step -1
            HighScore(i,1)=HighScore(i-1,1)
            HighScore(i,2)=HighScore(i-1,2)
        next
        HighScore(HighScoreIndex,1)=Name$
        HighScore(HighScoreIndex,2)=STR$(POINTS)
        Gosub SaveHighScores
    end if
return

IsHighScore:
    HighScoreIndex=cntHighScores+1
    if cntHighScores=0 then
        Result=True 'no highscores yet, so always add
    else
        for i = 1 to cntHighScores
            if POINTS > VAL(HighScore(i,2)) then
                HighScoreIndex = i
                Result=true
                break
            end if
        next 
        if Result=False then
            if cntHighScores<10 then
                Result=True
            else
                Result=False
            end if
        end if
    end if
return

BackupBlock:
    for i = 1 to BlockSize
        for j = 1 to BlockSize
            BlockBackup(i,j)=Block(i,j)
        next
    next
return

RestoreBlock:
    for i = 1 to BlockSize
        for j = 1 to BlockSize
            Block(i,j)=BlockBackup(i,j)
        next
    next
return

RemoveFullRows:
    Points=Points+1
    cntRemoved=0
    for r = Height to 0 step -1
        bIsFull=true
        for c = 1 to Width/2
            if Field(r,c)=0 then
                bIsFull=False
                break
            end if
        next
        if bIsFull=True then
            cntRemoved=cntRemoved+1
            Points=Points+10
            for q = r to 2 step -1
                for w = 1 to Width/2
                    
                    Field(q,w)=Field(q-1,w)
                next    
            next
            r=r+1
            
        end if
    next

    'Little sound to celebrate line removal(s)
    if cntRemoved>0 then
        for i = 300 to 500+(cntRemoved*100) step 50
            PSGFREQ 1,i
            sleep 0
            PSGFREQ 1,0
        next
    
    end if
    
    Gosub PrintScore
return

PrintScore:
    Locate 1,1
    color 1,0
    PRINT "LEVEL: " + STR$(Level)
    SETCOL 1
    PRINT "SCORE: " + STR$(POINTS)
return

RotateBlock:
    FOR i = 1 TO curBlockSize
        FOR j = 1 TO curBlockSize
            Block(i,j) = BlockBackup(curBlockSize+1-j,i)
        NEXT j
    NEXT i
return

CanMove:
    Result=True
    for r = 1 to curBlockSize
        if Result=False then break
        for c = 1 to curBlockSize
            if Block(r,c)<>0 then
                
                if BlockX+(c*2)<1 or BlockX+(c*2)>Width  then
                    Result=False
                    break
                elseif Field(BlockY+r,(BlockX/2)+c)<>0 then
                    Result=False
                    break
                elseif BlockY+r>Height then
                    Result=False
                    break                    
                end if
            end if
        next 
    next 

return

CopyBlockToField:
    for r = 1 to BlockSize
        for c = 1 to BlockSize
            if Block(r,c)<>0 then
                Field(BlockY+r,(BlockX/2)+c)=Block(r,c)
            end if
        next 
    next
return

PrintField:
    for r = 1 to Height
        for c = 1 to Width/2
            color 0,Field(r,c)
            locate OffsetY+(r-1),OffsetX+((c)*2)
            print "  "
        next
    next

return


HideBlock:
    for r = 1 to BlockSize
        for c = 1 to BlockSize
            
            if Block(r,c)<>0 then
               ' color Block(r,c),0
                PLOTSTRING "  ",BlockY+OffsetY+r-1,BlockX+OffsetX+(c*2),$00
            end if
        next
    next
return

DrawBlock:
    for r = 1 to BlockSize
        
        for c = 1 to BlockSize
            
            if Block(r,c)<>0 then
                PLOTSTRING "  ",BlockY+OffsetY+r-1,BlockX+OffsetX+(c*2),Block(r,c)*16
            end if
        next
    next
return

CleanUpY:
    'Prevent flickering of block on way down
    for c = 1 to BlockSize
        for r = 1 to BlockSize-1
            if Block(r,c)<>0  then
                'PLOTSTRING is faster then PRINT, but it does require to use screen codes in stead of petscii characters
                PLOTSTRING "  ",BlockY+OffsetY+r-2,BlockX+OffsetX+(c*2),$00
                break
            end if
        next r
    next c
return

GetNewBlock:
    cntBlocks=cntBlocks+1
    if cntBlocks=BlockPerLevel then
        'Next level, so increase speed
        cntBlocks=0
        Level=Level+1
        Speed=Speed - 4
        if Speed<1 then Speed=0
    end if
    
    'Clear block
    for i = 1 to BlockSize
        for j = 1 to BlockSize
            Block(i,j)=0
        next 
    next 
    
    'Get new block. Not sure if randomness is good enough....
    BlockNr = RNDINT(6)+1 
    curBlockSize=3
   
    if BlockNr=1 then       'L
        Block(1,2)=8
        Block(2,2)=8
        Block(3,2)=8
        Block(3,3)=8
    elseif BlockNr=2 then   'Lr
        Block(1,2)=2
        Block(2,2)=2
        Block(3,2)=2
        Block(3,1)=2    
    elseif BlockNr=3 then   'Block
        Block(1,2)=3
        Block(2,2)=3
        Block(1,3)=3
        Block(2,3)=3   
    elseif BlockNr=4 then   'Balk
        Block(1,2)=4
        Block(2,2)=4
        Block(3,2)=4
        Block(4,2)=4
        curBlockSize=4
    elseif BlockNr=5 then   'Z
        Block(1,2)=5
        Block(2,2)=5
        Block(2,3)=5
        Block(3,3)=5
    elseif BlockNr=6 then   'Zr
        Block(1,3)=6
        Block(2,3)=6
        Block(2,2)=6
        Block(3,2)=6
    else 
        Block(1,2)=7       'T
        Block(2,2)=7       
        Block(3,2)=7
        Block(2,3)=7
    end if
    
    'Reset start pos of block
    BlockX=6
    BlockY=0
return


DrawScreen:
    color 0,1
    row = OffsetY
    for r = 1 to Height
        locate row,OffsetX
        PRINT "  ";
        SETCOL 51
        PRINT "  "
        row=row+1
    next
    locate row,OffsetX
    x = True
    PRINT "  " + RPT$(" ",Width) + "  "
    color 1,0
    locate 1,23
    PRINT "TETRIS CLONE COMPILED WITH NXTBASIC"
return


