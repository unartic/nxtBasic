'Program to showcase the directory listing features, zsm and zcm playing functions and bmx drawing function of nxtBasic.
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

CONST COL_WIDTH=25  'width of columns with directory items
CONST rowCount=20   'rows to display on screen
CONST DEF_INDENT = 2    
SCREEN 128
FILLSCREEN 0

ENTERISO    'Goto iso-mode, so we see all filesnames as they are

SETINDENT DEF_INDENT


Dim List(500) as string 'array to store the current directory listing. (max 500 in this case)

Gosub ResetDirList  'Read listing from current dir and display it
Gosub HighLightRow  'Highlight the first row

Loop:
    key = GET       'get a key from the keyboard buffer
    if key=17 then  'arrow down
        Gosub LowLightRow
        if rowIndx+rowOffset+1<curListCount then    'at end of list??
            if rowIndx+1=rowCount then   
                rowOffset=rowOffset+1    'Does not fit on screen, so scroll one line
                Gosub PrintListing
            else
                rowIndx=rowIndx+1
            end if
        end if
        Gosub HighLightRow
     
    elseif key=145 then  'arrow up
        Gosub LowLightRow
        if rowIndx-1<0 then
            if rowOffset>0 then
                rowOffset=rowOffset-1
                Gosub PrintListing
            end if
            
        else
            rowIndx=rowIndx-1
        end if
        Gosub HighLightRow
    elseif key=13 then  'enter
        if LEFT$(List(rowOffset+rowIndx+1),1)="/" then
            Gosub ToSubDirectory
        elseif UCASE$(right$(List(rowOffset+rowIndx+1),3))="ZCM" then
            PlayZCM(List(rowOffset+rowIndx+1),10)
        elseif UCASE$(right$(List(rowOffset+rowIndx+1),3))="ZSM" then
            PlayZSM(List(rowOffset+rowIndx+1),100,25)
        elseif UCASE$(right$(List(rowOffset+rowIndx+1),3))="BMX" then
            x = 160 - (GETBMXWIDTH(List(rowOffset+rowIndx+1))/2)
            y = 120 - (GETBMXHEIGHT(List(rowOffset+rowIndx+1))/2)
            color 0,0
            cls
            DRAWBMX List(rowOffset+rowIndx+1),x,y

            WaitForKey:
                ZCMTICK
                ZSMTICK            
                key = GET
                if key=0 then goto WaitForKey
                
            FILLSCREEN 0
            Gosub ResetPalette
            color 1,0
            cls
            PRINT CurDir$
            PRINT RPT$("-",COL_WIDTH)
            Gosub PrintListing
            PRINT RPT$("-",COL_WIDTH)
            PRINT "(" + ltrim$(str$(curListCount)) + " items)"
            
            Gosub HighLightRow
        end if
    end if
    ZCMTICK
    ZSMTICK
goto loop

ResetPalette:
    'Only reset palette indexes 0 and 1 (black and white)
     VPOKE 1,$FA00,0
     VPOKE 1,$FA01,0
     VPOKE 1,$FA02,$FF
     VPOKE 1,$FA03,$0F
     
return

ResetDirList:
    color 1,0
    cls
    rowOffset=0
    rowIndx=0

    PRINT CurDir$
    PRINT RPT$("-",COL_WIDTH)
    
    Gosub GetList
    Gosub PrintListing
    PRINT RPT$("-",COL_WIDTH)
    PRINT "(" + ltrim$(str$(curListCount)) + " items)"
return

HighLightRow:
    color 0,1
    goto ShowRow

LowLightRow:
    color 1,0

ShowRow:
    locate rowIndx+2,DEF_INDENT

    cntSpaces = COL_WIDTH-len(List(rowOffset+rowIndx+1))
    if cntSpaces<1 then cntSpaces=0
    PRINT List(rowOffset+rowIndx+1) + SPC(cntSpaces)  
return

ToSubDirectory:
    'Use the command channel to execute a change-directory command
    SubDir$ = List(rowOffset+rowIndx+1)    

    'OPENFILE returns a handle, which immediatly gets closed. If we want to check
    'the result of de CD-command, we should not close it, and read the result before closing
    CLOSE OPENFILE("CD:" + RIGHT$(SubDir$,LEN(SubDir$)-1),COMMAND)
    
    Gosub ResetDirList
    Gosub HighLightRow
return

PrintListing:
    locate 2,DEF_INDENT
    cnt=0
    
    for i = rowOffset+1 to curListCount
        cnt=cnt+1
        if cnt>rowCount then break
        PRINT List(i) + "                   " 
    next
return

GetList:
    curListCount=0
    if len(CurDir$())>1 then
        List(curListCount+1)="/.."
        curListCount=curListCount+1
    end if
    NewItem$ = SPC(100)
    'First read directories
    cnt = DIRLIST("*","*",LIST_DIRS)  
    if cnt>0 then
        for i = 1 to cnt
            NewItem$=DIRITEM()
            if NewItem$<>"." AND NewItem$<>".." then    'HostFS does not return the . and .. items. hardware/sd card does
                List(curListCount+1)="/" + NewItem$
                curListCount=curListCount+1
            end if
            ZCMTICK
            ZSMTICK
        next
    end if
    CLOSEDIRLIST()
   
    'Then read ZCM files
    cnt = DIRLIST("*","ZSM",LIST_FILES)    
    if cnt>0 then
        for i = 1 to cnt
            List(curListCount+1)=DIRITEM()
            curListCount=curListCount+1
            ZCMTICK
            ZSMTICK
        next
    end if
    CLOSEDIRLIST()

    
    'Then read ZCM files
    cnt = DIRLIST("*","ZCM",LIST_FILES)    
    if cnt>0 then
        for i = 1 to cnt
            List(curListCount+1)=DIRITEM()
            curListCount=curListCount+1
            ZCMTICK
            ZSMTICK
        next
    end if
    CLOSEDIRLIST()


    
    'Then read ZCM files
    cnt = DIRLIST("*","BMX",LIST_FILES)    
    if cnt>0 then
        for i = 1 to cnt
            List(curListCount+1)=DIRITEM()
            curListCount=curListCount+1
        next
    end if
    CLOSEDIRLIST()

return
