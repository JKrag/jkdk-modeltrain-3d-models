Main();

module
Main()
{
    width = 24;
    platformHeight = 16;
    aboveGroundWallHeight = 14;
    stepdepth = 2.8;
    stepheight = 2.3;
    wallThickness = 1.5;
    minimumFloorThickness = 1;
    tunnelSize = 18;

    stepcount = floor((platformHeight - minimumFloorThickness) / stepheight);
    totalStepLength = stepcount * stepdepth;

    totalStepHeight = stepcount * stepheight;
    actualFloorThickness = platformHeight - totalStepHeight;

    echo("Total step height", totalStepHeight);
    echo("Actual floor thickness", actualFloorThickness);

    difference()
    {
        union()
        {
            Stairs(width = width,
                   stepcount = stepcount,
                   stepdepth = stepdepth,
                   stepheight = stepheight);

            Staircase(width = width,
                      aboveGroundWallHeight = aboveGroundWallHeight,
                      totalStepHeight = totalStepHeight,
                      wallThickness = wallThickness,
                      floorThickness = actualFloorThickness,
                      staircaselength = totalStepLength,
                      tunnelSize = tunnelSize);
        }

        Tunnel(width, totalStepHeight, totalStepLength, tunnelSize);
    }
}

module Tunnel(width, totalStepHeight, totalStepLength, tunnelSize)
{
    tWidth = width + 20;
    translate(
        [ -tWidth / 2, -(totalStepLength + tunnelSize), -totalStepHeight ])
        // color("red")
        cube([ width + 20, tunnelSize, totalStepHeight ]);
}

module Stairs(width, stepcount, stepdepth, stepheight)
{
    for (i = [0:stepcount])
        translate([ -width / 2, -(i * stepdepth), -(stepheight * i) ])
            cube([ width, stepdepth * i, stepheight ]);
}

module Staircase(width,
                 aboveGroundWallHeight,
                 totalStepHeight,
                 wallThickness,
                 floorThickness,
                 staircaselength,
                 tunnelSize)
{
    totalWallHeight = aboveGroundWallHeight + totalStepHeight + floorThickness;

    totalWallLength = staircaselength + tunnelSize + wallThickness;
    echo("Total Wall Length", totalWallLength);
    x_offset = width / 2;

    // left wall
    translate(
        [ -x_offset, -totalWallLength, -(totalStepHeight + floorThickness) ])
        rotate([ 90, 0, 90 ])
            cube([ totalWallLength, totalWallHeight, wallThickness ]);
    // right wall
    translate([
        (x_offset - wallThickness),
        -totalWallLength,
        -(totalStepHeight + floorThickness)
    ]) rotate([ 90, 0, 90 ])
        cube([ totalWallLength, totalWallHeight, wallThickness ]);    // endwall    translate(        [ -x_offset, -totalWallLength, -(floorThickness + totalStepHeight) ])        rotate([ 90, 0, 0 ]) cube([ width, totalWallHeight, wallThickness ]);    // floor    translate(        [ x_offset, -totalWallLength, -(floorThickness + totalStepHeight) ])        rotate([ 0, 0, 90 ]) cube([ totalWallLength, width, floorThickness ]);}