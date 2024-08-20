'Demonstration of 3 sprites, where if they are colliding the animation speed is dropped
'and which sprites are colliding is displayed. 
'Developed by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

SCREEN 128

index1 = ADDSPRITE("BALL.BIN",16,16,8,0)
index2 = CLONESPRITE(index1)
index3 = CLONESPRITE(index1)

Dim vX(index3)
Dim vY(index3)


SHOWSPRITE index1,RNDINT(320),RNDINT(240),3
SHOWSPRITE index2,RNDINT(320),RNDINT(240),3
SHOWSPRITE index3,RNDINT(320),RNDINT(240),3

'Initial vectors for all three balls
vX(index1)=3
vY(index1)=3

vX(index2)=6
vY(index2)=-3

vX(index3)=-6
vY(index3)=3

Locate 0,3
PRINT "BALLS SLOW DOWN WHEN THEY OVERLAP"
PRINT " AND SHOW WHICH BALLS ARE OVERLAPPING"

Loop:
    FOR i = index1 to index3
        if SPRITEGETX(i)+vX(i)<0 THEN
            vX(i) = RNDINT(3)+1
        elseif SPRITEGETX(i)+vX(i)>304 THEN
            vX(i) = NEG(RNDINT(3))-1
        END IF

        if SPRITEGETY(i)+vY(i)<0 THEN
            vY(i) = RNDINT(3)+1
        elseif SPRITEGETY(i)+vY(i)>224 THEN
            vY(i) = NEG(RNDINT(3))-1
        END IF    
        
        MOVESPRITE i,vX(i),vy(i)
    
    next i
    
    CollidingBalls$=""
    'SPRITECOL returns a string with ascii values for all colliding sprites
    if len(SPRITECOL(index1))>0 then
        CollidingBalls$ = STR$(index1) + " AND"
        c$ = SPRITECOL(index1)
        FOR i = 1 to len(c$)
            CollidingBalls$ = CollidingBalls$ + STR$(ASC(MID$(c$,i,1)))
        NEXT i
        
        
        sleep 10
    elseif len(SPRITECOL(index2))>0 then
        CollidingBalls$ = STR$(index2) + " AND"
        c$ = SPRITECOL(index2)
        FOR i = 1 to len(c$)
            CollidingBalls$ = CollidingBalls$ + STR$(ASC(MID$(c$,i,1)))
        NEXT i
        sleep 10
    elseif len(SPRITECOL(index3))>0 then
        CollidingBalls$ = STR$(index3) + " AND"
        c$ = SPRITECOL(index3)
        FOR i = 1 to len(c$)
            CollidingBalls$ = CollidingBalls$ + STR$(ASC(MID$(c$,i,1)))
        NEXT i
        sleep 10
    end if
    locate 25,15
    print "                                                ";
    locate 25,15
    PRINT CollidingBalls$;
    
goto Loop
