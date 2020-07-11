Main();

module Main() {
  width = 20;
  platformHeight = 16.7;
  aboveGroundWallHeight = m_to_h0(1.0);
  stepdepth_rl_cm = 30;
  stepheight_rl_cm = 16;
  wallThickness = 1.5;
  minimumFloorThickness = 1;
  tunnelSize = 20;
  tunnelOpenLeft = true;
  tunnelOpenRight = true;
  lipWidth = cm_to_h0(10);
  lipThickness = cm_to_h0(7);
  topWidth = cm_to_h0(20);
  topThickness = cm_to_h0(7);

  stepdepth = cm_to_h0(stepdepth_rl_cm);
  stepheight = cm_to_h0(stepheight_rl_cm);
  stepcount = floor((platformHeight - minimumFloorThickness) / stepheight);
  totalStepLength = stepcount * stepdepth;
  totalStepHeight = stepcount * stepheight;
  actualFloorThickness = platformHeight - totalStepHeight;

  totalWallLength = totalStepLength + tunnelSize;

  echo("Total step height: ", totalStepHeight);
  echo("Actual floor thickness: ", actualFloorThickness);
  echo("Above ground Wall Height: ", aboveGroundWallHeight);
  echo("Step height: ", stepheight);
  echo("Step depth: ", stepdepth);
  echo("Lipwidth: ", lipWidth);
  echo("Stepsanity (should be close to 62cm): ", 2 * stepheight_rl_cm + stepdepth_rl_cm);
  echo("Total Wall Length", totalWallLength);

  union() {

    difference() {
      union() {
        Staircase(platformHeight, aboveGroundWallHeight, width, wallThickness, actualFloorThickness, totalWallLength, lipWidth,
                  lipThickness);
        Top(width, aboveGroundWallHeight, topWidth, topThickness, wallThickness, totalWallLength);
      }
      Tunnel(width, totalStepHeight, totalStepLength, tunnelSize, wallThickness, tunnelOpenLeft, tunnelOpenRight);
    }
    translate([ totalWallLength, width / 2, 0 ]) Stairs(width, stepcount, stepdepth, stepheight);
  }
}

module Staircase(platformHeight, aboveGroundWallHeight, width, wallThickness, floorThickness, totalWallLength, lipWidth, lipThickness) {
  difference() {
    union() {
      StaircaseUnderground(platformHeight, width, wallThickness, floorThickness, totalWallLength);
      StaircaseAboveGround(aboveGroundWallHeight, width, wallThickness, totalWallLength);
      Lip(width, lipWidth, lipThickness, wallThickness, totalWallLength);
    }
    Stairwell(platformHeight, width, wallThickness, floorThickness, totalWallLength);
  }
}

module Tunnel(width, totalStepHeight, totalStepLength, tunnelSize, wallThickness, tunnelOpenLeft, tunnelOpenRight) {
  oversize = 10;
  tWidth = width / 2 + oversize;
  if (tunnelOpenLeft) {
    translate([ wallThickness, -width / 2, -totalStepHeight ]) cube([ tunnelSize, tWidth, totalStepHeight ]);
  }

  if (tunnelOpenRight) {
    translate([ wallThickness, width / 2, -totalStepHeight ]) cube([ tunnelSize, tWidth, totalStepHeight ]);
  }
}

module Stairs(width, stepcount, stepdepth, stepheight) {
  union() {
    for (i = [0:stepcount])
      translate([ -(i * stepdepth), -width / 2, -(stepheight * i) ]) cube([ stepdepth * i, width, stepheight ]);
  }
}

module Stairwell(platformHeight, width, wallThickness, floorThickness, totalWallLength) {
  oversize = 50;
  translate([ wallThickness, wallThickness, -platformHeight + floorThickness ])
    cube([ totalWallLength + oversize, width - 2 * wallThickness, platformHeight + oversize ], false);
}

module StaircaseUnderground(platformHeight, width, wallThickness, floorThickness, totalWallLength) {
  translate([ 0, 0, -platformHeight ]) cube([ totalWallLength, width, platformHeight ], false);
}

module StaircaseAboveGround(aboveGroundWallHeight, width, wallThickness, totalWallLength) {
  translate([ 0, 0, 0 ]) cube([ totalWallLength, width, aboveGroundWallHeight ], false);
}

module Lip(width, lipWidth, lipThickness, wallThickness, totalWallLength) {
  translate([ -lipWidth, -lipWidth, 0 ]) cube([ totalWallLength + lipWidth, width + lipWidth * 2, lipThickness ], false);
}

module Top(width, aboveGroundWallHeight, topWidth, topThickness, wallThickness, totalWallLength) {
  oversize = 10;
  overhang = (topWidth - wallThickness) / 2;
  topBoxWidth = width + 2 * overhang;
  topBoxSubtractWidth = topBoxWidth - 2 * topWidth;
  topBoxLength = totalWallLength + 2 * overhang;

  difference() {
    translate([ -overhang, -overhang, aboveGroundWallHeight ]) cube([ topBoxLength, topBoxWidth, topThickness ], false);
    translate([ -overhang + topWidth, -topBoxSubtractWidth / 2 + width / 2, aboveGroundWallHeight - 1 ])
      cube([ topBoxLength, topBoxSubtractWidth, topThickness + 2 ], false);
  }
}

function m_to_h0(m) = m / 87 * 1000;
function cm_to_h0(cm) = cm / 87 * 10;
