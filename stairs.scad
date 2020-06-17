Main();

module
Main()
{
    stairwidth = 20;
    stepcount = 5;
    stepdepth = 5;
    stepheight = 2;
    aboveGroundWallHeight = 12;
    totalStepLength = stepcount * stepdepth;
    totalStepHeight = stepcount * stepheight;

    Stairs(width = stairwidth,
           stepcount = stepcount,
           stepdepth = stepdepth,
           stepheight = stepheight);

    Staircase(stairwidth = stairwidth,
                totalWallHeight = aboveGroundWallHeight + totalStepHeight,
              thickness = 2,
              staircaselength = totalStepLength,
              tunnelSize = 30);
}

module Stairs(width, stepcount, stepdepth, stepheight)
{
    for (i = [0:stepcount])
        translate([ -width / 2, i * stepdepth, stepheight * i ])
            cube([ width, stepdepth * (stepcount - i), stepheight ]);
}

module Staircase(stairwidth, totalWallHeight, thickness, staircaselength, tunnelSize)
{
    totalWallLength = staircaselength + tunnelSize + thickness;
    echo("Total Wall Length", totalWallLength);
    x_offset = stairwidth / 2;

    //left wall
    translate([ -(x_offset + thickness), staircaselength - totalWallLength, 0 ])
        rotate([ 90, 0, 90 ]) cube([ totalWallLength, totalWallHeight, thickness ]);
    // right wall
    translate([ (x_offset), staircaselength - totalWallLength, 0 ])
        rotate([ 90, 0, 90 ]) cube([ totalWallLength, totalWallHeight, thickness ]);
    // floor
    translate([ x_offset+thickness, staircaselength - totalWallLength, -thickness ])
        rotate([ 0, 0, 90 ]) 
        cube([ totalWallLength, stairwidth+2*thickness, thickness ]);
    // endwall
    translate([ -(x_offset+thickness), staircaselength - totalWallLength, -thickness ])
        rotate([ 90, 0, 0 ]) 
        cube([ stairwidth+2*thickness, totalWallHeight+thickness, thickness ]);
}



