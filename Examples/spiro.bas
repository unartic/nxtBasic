'Compile with nxtBasic: https://github.com/unartic/nxtBasic

Start:
SCREEN 1
ENTERISO
SETCHARSET 6
color 1,0
cls

Dim rFixed as INT
Dim rRoling as INT
Dim Distance as Float
Dim angle_step as Float
Dim rDifDivByRRoling as Float
Dim theta as float
DIM rDif as float

PRINT
PRINTC "- Spirograph demo compiled with nxtBasic -"
PRINT
PRINT
COLOR 5,0
'----------------------------
'Lets ask the user for parameter values:

    rFixed = GetInputValueInt("Radius of fixed circle (try: 74)",1,320)       
    PRINT
    rRoling= GetInputValueInt("Radius of roling circle (try: 41)",1,320)           
    PRINT
    Distance=GetInputValueInt("Distance from center of rolling circle to drawing point (try: 80)",1,320)          
    PRINT
    UseColor=GetInputValueInt("Color (try: 59)",1,255)      
    PRINT
'------------------------------
CLS
locate 5,5
PRINTC "- Spirograph demo compiled with nxtBasic -"
PRINT
PRINT
PRINTC "Press a key to start."
PRINT
PRINTC "Hit ESC during plotting to enter other values."

'Wait for a keypress
Do until GET()<>""
Loop

SCREEN 128
FILLSCREEN 0

rDif = rFixed-rRoling
rDifDivByRRoling = rDif/rRoling

xOld=0
yOld=0
theta=0
angle_step = 0.1   'the smaller, the more precision/slower

'Start plotting the Spirograph until Escape is pressed
Do until GET()=CHR$(27)     'Check for ESC key

    'x and y are calculated in real time
    x = INT(rDif * cos(theta) + Distance * cos(rDifDivByRRoling * theta))+160
    y = INT(rDif * sin(theta) - Distance * sin(rDifDivByRRoling * theta))+120
    
    if x<1 then x=1
    if y<1 then y=1
    if x>319 then x=319
    if y>239 then y=239
    
    if xOld>0 then LINE xOld,yOld,x,y,UseColor
    
    xOld=x
    yOld=y
 
    theta=theta+angle_step

 Loop
 GOTO Start
 
 Function GetInputValueInt(sCaption as string,iMin as int,iMax as int) as int
    TryInputAgain:
    SETCOL 5
    InputValue = INPUT(sCaption)
    if InputValue<iMin or InputValue>iMax then goto TryInputAgain
    GetInputValueInt = InputValue
 End Function