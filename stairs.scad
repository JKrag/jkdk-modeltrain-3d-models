Main();

module Main()
{
    Stairs();
    Staircase();
}

module Stairs(
    width = 20,
    stepheight = 2,
    stepcount = 5,
    stepdepth = 5
)
{
    for (i = [0:stepcount])
        translate([ 0, i * stepdepth, stepheight * i ])
        cube([ width, stepdepth*(stepcount - i), stepheight ]);
}

module Staircase() {
    thickness = 2;
    length = 40;
    //cube([ width, stepdepth*(stepcount - i), stepheight ]);

}