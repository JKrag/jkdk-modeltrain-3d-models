Main();

module Main() {
  width = 24;
  platformHeight = 16;
  aboveGroundWallHeight = m_to_h0(1.0);
  stepdepth_rl_cm = 30;
  stepheight_rl_cm = 16;
  wallThickness = 1.5;
  minimumFloorThickness = 1;
  topWidth = cm_to_h0(20);
  topThickness = cm_to_h0(7);

  stepdepth = cm_to_h0(stepdepth_rl_cm);
  stepheight = cm_to_h0(stepheight_rl_cm);
  stepcount = floor((platformHeight - minimumFloorThickness) / stepheight);
  totalStepLength = stepcount * stepdepth;
  totalStepHeight = stepcount * stepheight;
  actualFloorThickness = platformHeight - totalStepHeight;

  echo("Total step height: ", totalStepHeight);
  echo("Actual floor thickness: ", actualFloorThickness);
  echo("Above ground Wall Height: ", aboveGroundWallHeight);
  echo("Step height: ", stepheight);
  echo("Step depth: ", stepdepth);
  echo("Lipwidth: ", lipWidth);
  echo("Stepsanity (should be close to 62cm): ", 2 * stepheight_rl_cm + stepdepth_rl_cm);

  difference() {
    union() {
      Stairs(width = width, stepcount = stepcount, stepdepth = stepdepth, stepheight = stepheight);

      Staircase(width = width, aboveGroundWallHeight = aboveGroundWallHeight, totalStepHeight = totalStepHeight,
                wallThickness = wallThickness, floorThickness = actualFloorThickness, staircaselength = totalStepLength,
                tunnelSize = tunnelSize);
      Lip(width, lipWidth, lipThickness, wallThickness, totalStepLength, tunnelSize);
      Top(width, aboveGroundWallHeight, topWidth, topThickness, wallThickness, totalStepLength, tunnelSize);
    }

    Tunnel(width, totalStepHeight, totalStepLength, tunnelSize);
  }
}

module Tunnel(width, totalStepHeight, totalStepLength, tunnelSize) {
  tWidth = width + 20;
  translate([ -tWidth / 2, -(totalStepLength + tunnelSize), -totalStepHeight ]) cube([ tWidth, tunnelSize, totalStepHeight ]);
}

module Stairs(width, stepcount, stepdepth, stepheight) {
  union() {
    for (i = [0:stepcount])
      translate([ -width / 2, -(i * stepdepth), -(stepheight * i) ]) cube([ width, stepdepth * i, stepheight ]);
  }
}

module Staircase(width, aboveGroundWallHeight, totalStepHeight, wallThickness, floorThickness, staircaselength, tunnelSize) {
  totalWallHeight = aboveGroundWallHeight + totalStepHeight + floorThickness;

  totalWallLength = staircaselength + tunnelSize;
  echo("Total Wall Length", totalWallLength);
  x_offset = width / 2;
  union() {
    // left wall
    translate([ -x_offset, -totalWallLength, -(totalStepHeight + floorThickness) ]) rotate([ 90, 0, 90 ])
      cube([ totalWallLength, totalWallHeight, wallThickness ]);
    // right wall
    translate([ (x_offset - wallThickness), -totalWallLength, -(totalStepHeight + floorThickness) ]) rotate([ 90, 0, 90 ])
      cube([ totalWallLength, totalWallHeight, wallThickness ]);
    // endwall
    translate([ -x_offset, -totalWallLength, -(floorThickness + totalStepHeight) ]) rotate([ 90, 0, 0 ])
      cube([ width, totalWallHeight, wallThickness ]);
    // floor
    translate([ x_offset, -totalWallLength, -(floorThickness + totalStepHeight) ]) rotate([ 0, 0, 90 ])
      cube([ totalWallLength, width, floorThickness ]);
  }
}

module Lip(width, lipWidth, lipThickness, wallThickness, staircaselength, tunnelSize) {
  totalWallLength = staircaselength + tunnelSize + wallThickness;
  echo("Total Wall Length", totalWallLength);
  x_offset = width / 2;
  union() {
    // left lip
    translate([ -x_offset - lipWidth, -totalWallLength, 0 ]) cube([ lipWidth, totalWallLength, lipThickness ]);
    // right lip
    translate([ x_offset, -totalWallLength, 0 ]) cube([ lipWidth, totalWallLength, lipThickness ]);
    // end lip
    translate([ -x_offset - lipWidth, -totalWallLength - lipWidth, 0 ]) cube([ width + 2 * lipWidth, lipWidth, lipThickness ]);
  }
}

module Top(width, aboveGroundWallHeight, topWidth, topThickness, wallThickness, staircaselength, tunnelSize) {
  totalWallLength = staircaselength + tunnelSize + wallThickness;
  echo("Total Wall Length", totalWallLength);
  x_offset = width / 2;
  union() {
    // left lip
    translate([ -x_offset - (topWidth/2) + (wallThickness/2), -totalWallLength, aboveGroundWallHeight ]) cube([ topWidth, totalWallLength, topThickness ]);
    // right lip
    translate([ x_offset - (topWidth/2) - (wallThickness/2), -totalWallLength, aboveGroundWallHeight ]) cube([ topWidth, totalWallLength, topThickness ]);
    // end lip
    translate([ -x_offset - (topWidth-wallThickness)/2, -totalWallLength - (topWidth/2) + (wallThickness/2), aboveGroundWallHeight ]) 
      cube([ width + (topWidth-wallThickness), topWidth, topThickness ]);
  }
}

function m_to_h0(m) = m / 87 * 1000;
function cm_to_h0(cm) = cm / 87 * 10;
