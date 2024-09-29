'Compile with nxtBasic: https://github.com/unartic/nxtBasic

CONST STARS_COUNT = 25 'Max 127
CONST STAR_COLOR=  1


Dim StarsVX(STARS_COUNT)
Dim StarsVY(STARS_COUNT)
Dim Sprites(STARS_COUNT)

color 1,0
ENTERISO

SETCHARSET 6
locate 5,0
PRINTC "You are about to watch a starfield."
locate 7,0
PRINTC "Pressing a key gives the stars a random new color."
locate 10,0
PRINTC "Now press a key to begin..."

Do
    if GET()<>"" then exit loop
Loop

SCREEN 128
FILLSCREEN 0

'Set a random vector for each sprite
for i = 1 to STARS_COUNT
    Gosub SetVectors
next

'Put black sprite, with one color pixel in VRAM at address $13000
VPOKEN 1,$3000,CHR$(STAR_COLOR) + RPT$(CHR$(0),63)

for i = 1 to STARS_COUNT
    ldy 1   'Set VRAM bank to #1
    Sprites(i) = ADDSPRITE($3000,8,8,8,0)   'Creat 8x8px sprite with 256 colors, based on the image at VRAM address #13000
    SHOWSPRITE Sprites(i),320/2,240/2,3     'Make sprite visible and display in center of the screen
next i

Do
    for i = 1 to STARS_COUNT
        MOVESPRITE Sprites(i),StarsVX(i),StarsVY(i)
    
    
        'If sprite is offscreen, reset it to the middle and generate a new random vector
        spriteX = SPRITEGETX(Sprites(i))
        spriteY = GetY()
        if spriteX<0 OR spriteX>320 OR spriteY<0 OR spriteY>240 then 
            SHOWSPRITE Sprites(i),320/2,240/2,3
            Gosub SetVectors
        end if
           
    next 
    if GET()<>"" then
        'Change the star color to a random value on a keypress
        VPOKE 1,$3000,INT(RND(TI())*254)+1
    end if
Loop

SetVectors:
    thisVX = INT(RND(TI())*9)+1
    thisVY = INT(RND(TI())*9)+1
    
    'Make vector negative in 50% of the cases
    if RNDINT(10)>5 then thisVX = NEG(thisVX)
    if RNDINT(10)>5 then thisVY = NEG(thisVY)
    
    StarsVX(i) = thisVX
    StarsVY(i) = thisVY
return


