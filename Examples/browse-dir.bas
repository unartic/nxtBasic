'Program to showcase the directory listing features of nxtBasic.
'Browse through your directory structure
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

CONST COL_WIDTH=25  'width of columns with directory items
CONST rowCount=20   'rows to display on screen
CONST DEF_INDENT = 2    

SCREEN 8
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
        end if
    end if

goto loop

ResetDirList:
    color 1,6
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
    color 6,1
    goto ShowRow

LowLightRow:
    color 1,6

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
        next
    end if
    CLOSEDIRLIST()
    
    'Then read files
    cnt = DIRLIST("*","*",LIST_FILES)    
    if cnt>0 then
        for i = 1 to cnt
            List(curListCount+1)=DIRITEM()
            curListCount=curListCount+1
        next
    end if
    CLOSEDIRLIST()

return
