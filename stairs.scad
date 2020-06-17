Main();

module
Main()
{
    stairwidth = 20;
    stepcount = 5;
    stepdepth = 5;
    totalStepLength = staircaselength(stepcount, stepdepth);

    Stairs(width = stairwidth,
           stepcount = stepcount,
           stepdepth = stepdepth,
           stepheight = 2);

    Staircase(stairwidth = stairwidth,
              thickness = 2,
              staircaselength = totalStepLength,
              tunnelSize = 30);
}

function staircaselength(stepcount, stepdepth) = (stepcount * stepdepth);

module Stairs(width, stepcount, stepdepth, stepheight)
{
    for (i = [0:stepcount])
        translate([ -width / 2, i * stepdepth, stepheight * i ])
            cube([ width, stepdepth * (stepcount - i), stepheight ]);
}

module Staircase(stairwidth, thickness, staircaselength, tunnelSize

)
{
    totalWallLength = staircaselength + tunnelSize + thickness;
    echo("Total Wall Length", totalWallLength);
    x_offset = stairwidth / 2;

    translate([ -(x_offset + thickness), staircaselength - totalWallLength, 0 ])
        rotate([ 90, 0, 90 ]) cube([ totalWallLength, 20, thickness ]);
    translate([ (x_offset), staircaselength - totalWallLength, 0 ])
        rotate([ 90, 0, 90 ]) cube([ totalWallLength, 20, thickness ]);
}




