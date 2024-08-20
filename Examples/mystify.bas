'A port of Tony's mystify program for CBM Basic. 
'Ported by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

10 SCREEN 1:COLOR 5,0:CLS:PRINT:PRINT
20 PRINT "  NUMBER OF BOX SHAPES TO DISPLAY  (1 TO 6):";
25 COLOR 1:INPUT NB:COLOR 5
26 IF NB < 1 OR NB > 6 THEN GOTO 20 
30 PRINT "  NUMBER OF CORNERS FOR THE SHAPE : (2 TO 10)";:COLOR 1
35 INPUT NC:COLOR 5
36 IF NC < 2 OR NC > 10 THEN GOTO 30
40 PRINT "  DEPTH... (LINES TO DRAW BEFORE ERASING) (2 TO 60) :";:COLOR 1
45 INPUT BD:COLOR 5
46 IF NC < 2 OR NC > 60 THEN GOTO 40
50 PRINT "  BLACK THE SCREEN BEFORE DRAWING ?   (Y/N) :";:COLOR 1 
60 INPUT CL$:COLOR 5
70 PRINT "  CHANGE COLOR ON X BOUNCE ";:COLOR 1
80 INPUT XC$
90 XC$ = LEFT$(XC$,1)
100 COLOR 5:PRINT "  CHANGE COLOR ON Y BOUNCE ";:COLOR 1
110 INPUT YC$
120 YC$=LEFT$(YC$,1)

160 XL = 319:YL = 239
170 SCREEN 128
180 IF LEFT$(CL$,1) = "Y" THEN RECT 0,0,XL,YL,16
190 P1 = 1            : REM CURRENT BOX
200 P2 = 1            : REM PREVIOUS BUFFER POSITION
210 P3 = 2            : REM CURRENT BUFFER POSITION
220 P4 = 0            : REM COLOR OF THE BOX AND POINTER
230 X1 = 0: X2 = 0: X3 = 0
240 Y1 = 0: Y2 = 0: Y3 = 0

250 DIM BX(NB,BD, NC)  : REM CORNER X COORDINATES
260 DIM BY(NB,BD, NC)  : REM CORNER Y COORDINATES
270 DIM XI(NB, NC)     : REM X INCREMENT
280 DIM YI(NB, NC)     : REM Y INCREMENT
290 DIM BC(NB)         : REM COLOR OF THE BOX
'51 / 52
GOSUB 6000
OLDTI=TI
400
FOR P1=1 TO NB
    X2=BX(P1,P3,NC)
    Y2=BY(P1,P3,NC)
    FOR C=1 TO NC
        X1=X2
        X2=BX(P1,P3,C)
        Y1=Y2
        Y2=BY(P1,P3,C)
        LINE X1,Y1,X2,Y2,16
        X3=BX(P1,P2,C)+XI(P1,C)
        Y3=BY(P1,P2,C)+YI(P1,C)
        IF X3>XL THEN 
            XI(P1,C)=(RNDINT(9)+1) *-1 
            X3=XL
        END IF
        465 
        IF X3=XL AND XC$="Y" THEN 
            BC(P1) = RNDINT(255)+1 ' INT(RND(1)*255)+1
        END IF
        IF BC(P1) = 0 OR BC(P1) = 16 THEN GOTO 465
        IF X3<0 THEN 
            XI(P1,C)=RNDINT(9)+1 ' INT(RND(1)*9)+1
            X3=0
        END IF
        IF Y3>YL THEN 
            YI(P1,C)=(RNDINT(4)+1) *-1 'INT((RND(1)+4)+1)*-1
            Y3=YL
        END IF
        IF Y3=YL AND YC$="Y" THEN 
            BC(P1) = RNDINT(255)+1 ' INT(RND(1)*255) + 1
        END IF
        IF BC(P1) = 16 THEN BC(P1)=17
        IF Y3<0 THEN 
            YI(P1,C)=RNDINT(4)+1 'INT(RND(1)*4)+1
            Y3=0
        END IF
        BX(P1,P3,C)=X3
        BY(P1,P3,C)=Y3
    NEXT
    X2=X3:Y2=Y3
    P4=BC(P1)
    FOR C=1 TO NC
        X1=X2:X2=BX(P1,P3,C)
        Y1=Y2:Y2=BY(P1,P3,C)
        LINE X1,Y1,X2,Y2,P4
    NEXT
NEXT
P2=P3:P3=P3+1
IF P3>BD THEN P3=1

580 GOTO 400

5999 REM SETUP VARIABLES
6000 X = INT(RND(TI*-1))
6005 FOR B = 1 TO NB
6010     BC(B) = INT(RND(1)*255)+1
6020     IF BC(B)=0 OR BC(B)=16 THEN GOTO 6010
6040     FOR C = 1 TO NC
6050         XI(B,C) = INT(RND(1)*5)+1
6060         IF (INT(RND(1)*20)+1) > 10 THEN XI(B,C)= XI(B,C)*-1
6070         YI(B,C) = INT(RND(1)*5)+1
6080         IF (INT(RND(1)*20)+1) > 10 THEN YI(B,C)= XI(B,C)*-1
6090         BX(B,1,C) = INT(RND(1)*319) + 1
6100         BY(B,1,C) = INT(RND(1)*239) + 1
6110     NEXT C
6120 NEXT B
6130 RETURN

