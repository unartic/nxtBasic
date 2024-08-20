'Demonstration of 25 sprites moving rapidly along the screen 
'Developed by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

SCREEN 128
noSprites = 25          'number of sprites to display
Dim Sprites(noSprites)  'Sprite indexes
Dim vX(noSprites)       'x-vectors
Dim vY(noSprites)       'y-vectors

'Set screen to green
RECT 0,0,319,239,5


'Add a sprite BALL.BIN, width=16, height=16, colordepths is 8bpp, and palette offset=0, and return its index
Sprites(1) = ADDSPRITE("BALL.BIN",16,16,8,0)

'Show the sprite on the screen at a random location between x(0-300) and y(0-200), in front of layer 1
ShowSprite Sprites(1),RNDINT(300),RNDINT(200),3

'Clone this sprite as much as needed
for i = 2 to noSprites
    Sprites(i) = CloneSprite(Sprites(1))
next

'Set a vector for x and y positive or negative 1 to 10 px per 'frame'
for q = 1 to noSprites
    vX(q) = RNDINT(10)+1
    if RNDINT(100)>50 THEN vX(q)=neg(vX(q))
    
    vY(q) = RNDINT(10)+1
    if RNDINT(100)>50 THEN vY(q)=neg(vY(q))
next

Loop:
    for i = 1 to noSprites
        'get current x and y of a sprite
        x = SpriteGetX(Sprites(i))
        y = SpriteGetY(Sprites(i))
        
        'check if we need to bounce left or top
        if x<16 then vX(i)=RNDINT(15)+1
        if y<16 then vY(i)=RNDINT(15)+1
        
        
        'check if we need to bounce right or bottom
        if x>304 then vX(i)=NEG(RNDINT(15)+1)
        if y>224 then vY(i)=NEG(RNDINT(15)+1)
        
        'move the sprite amount of pixels in vector array
        MoveSprite Sprites(i),vX(i),vY(i)
    next
Goto Loop



