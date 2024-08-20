'Demonstration of a rotating 3d cube in nxtBasic. 
'The cube on the left is drawn, erased and drawn etc, causing a flicker, the cube
'on the bottom right is a bitmap copy of the drawn cube
'Developed by Unartic, july 2024
'Compile with nxtBasic: https://github.com/unartic/nxtBasic

SCREEN 128

Dim cos_theta,sin_theta,cos_phi,sin_phi as float

'We use seperate arrays per axis, because single dimension arrays are way faster
Dim PointsX(8)  'Original points
Dim PointsY(8)
Dim PointsZ(8)

Dim nPointsX(8) 'Rotated points
Dim nPointsY(8)
Dim nPointsZ(8)

' Define the vertices of the cube. We can construct any shape actualy
PointsX(1)=25:PointsY(1)=25:PointsZ(1)=25
PointsX(2)=75:PointsY(2)=25:PointsZ(2)=25
PointsX(3)=75:PointsY(3)=75:PointsZ(3)=25
PointsX(4)=25:PointsY(4)=75:PointsZ(4)=25
PointsX(5)=25:PointsY(5)=25:PointsZ(5)=75
PointsX(6)=75:PointsY(6)=25:PointsZ(6)=75
PointsX(7)=75:PointsY(7)=75:PointsZ(7)=75
PointsX(8)=25:PointsY(8)=75:PointsZ(8)=75

cntPoints=8

pivot_x=50
pivot_y=50
pivot_z=50

Dim rotation_speed as float
Dim angle as float

rotation_speed = 0.1
angle = 0

Loop:
    angle=angle + rotation_speed
  
    cos_theta = cos(angle)
    sin_theta = sin(angle)    
    cos_phi = cos(angle * 0.7) ' Different angle for y-axis rotation
    sin_phi = sin(angle * 0.7)
    
    for i = 1 to cntPoints
        tx = PointsX(i) - pivot_x
        ty = PointsY(i) - pivot_y
        tz = PointsZ(i) - pivot_z
    
        ' Rotation around x-axis
        tempY = int(ty * cos_theta - tz * sin_theta)
        tempZ = int(ty * sin_theta + tz * cos_theta)
        ty = tempY
        tz = tempZ
        
        ' Rotation around y-axis
        tempX = int(tx * cos_phi - tz * sin_phi)
        tempZ = int(tx * sin_phi + tz * cos_phi)
        tx = tempX
        tz = tempZ
    
        nPointsX(i) = (tx + pivot_x)
        nPointsY(i) = (ty + pivot_y)
        nPointsZ(i) = (tz + pivot_z)
    next i

    
    'Copy a white square from somewhere on the screen to where the cube
    'is located to 'erase' it. Seems to be faster then writing white lines
    'on top of the old ones
    VCOPY 0,100,100,100,0,0


    ' Draw new cube
    LINE nPointsX(1),nPointsY(1),nPointsX(2),nPointsY(2),5
    LINE nPointsX(2),nPointsY(2),nPointsX(3),nPointsY(3),5
    LINE nPointsX(3),nPointsY(3),nPointsX(4),nPointsY(4),5
    LINE nPointsX(4),nPointsY(4),nPointsX(1),nPointsY(1),5
    LINE nPointsX(5),nPointsY(5),nPointsX(6),nPointsY(6),5
    LINE nPointsX(6),nPointsY(6),nPointsX(7),nPointsY(7),5
    LINE nPointsX(7),nPointsY(7),nPointsX(8),nPointsY(8),5
    LINE nPointsX(8),nPointsY(8),nPointsX(5),nPointsY(5),5
    LINE nPointsX(1),nPointsY(1),nPointsX(5),nPointsY(5),5
    LINE nPointsX(2),nPointsY(2),nPointsX(6),nPointsY(6),5
    LINE nPointsX(3),nPointsY(3),nPointsX(7),nPointsY(7),5
    LINE nPointsX(4),nPointsY(4),nPointsX(8),nPointsY(8),5
    
    'Copy a 100x100 square with the cube to right corner of the screen
    VCOPY 0,0,100,100,150,100


     
Goto loop
