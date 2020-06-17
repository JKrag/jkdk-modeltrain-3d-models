stairs ();

module stairs ()
{
    width = 20;
    stepheight = 3;
    stepcount = 5;
    for (i=[0:stepcount]) 
        translate([0, i*10, 3*i]) cube([width,50-10*i,stepheight]);
    
}