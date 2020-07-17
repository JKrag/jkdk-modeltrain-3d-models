Main();

function m_to_h0(m) = m / 87 * 1000;
function cm_to_h0(cm) = cm / 87 * 10;

module Main() {
  frameWidth = m_to_h0(4);
  frameHight = m_to_h0(1.7);
  frameThickness = cm_to_h0(30);
  frameBorderThickness = cm_to_h0(10);
  frameBorderDepth = cm_to_h0(10);
  posterFrameNr = 3;
  legsNr = 3;
  legsHight = m_to_h0(0.5);

  union() {
    Frame(frameWidth, frameHight, frameThickness, frameBorderThickness, frameBorderDepth, posterFrameNr);

    Legs(legsNr, legsHight, frameWidth, frameHight, frameThickness);
  }
}

module Frame(frameWidth, frameHight, frameThickness, frameBorderThickness, frameBorderDepth, posterFrameNr) {
 
  dfbt = 2 * frameBorderThickness;
  bos = frameThickness - frameBorderDepth;
  pw = (frameWidth - frameBorderThickness * (posterFrameNr + 1)) / posterFrameNr;

  difference() {
    difference() {
      cube([ frameWidth, frameThickness, frameHight ], false);
      for (i = [0:posterFrameNr - 1]) {
        translate([ i * pw + (frameBorderThickness * i) + frameBorderThickness, bos, frameBorderThickness ])
          cube([ pw, frameThickness, frameHight - dfbt ], false);
      }
    }
    for (i = [0:posterFrameNr - 1]) {
      translate([ i * pw + (frameBorderThickness * i) + frameBorderThickness, bos * -1, frameBorderThickness ])
        cube([ pw, frameThickness, frameHight - dfbt ], false);
    }
  }
}

module Legs(legsNr, legsHight, frameWidth, frameHight, frameThickness) {

  lw = (frameWidth - frameThickness * (legsNr + 1)) / legsNr;

  for (i = [0:legsNr]) {
    translate([ i * lw + i * frameThickness, 0, frameHight ]) cube([ frameThickness, frameThickness, legsHight ], false);
  }
}
