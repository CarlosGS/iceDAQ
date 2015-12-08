
// Ball array of microphones


// Increase the resolution of default shapes
$fa = 5; // Minimum angle for fragments [degrees]
$fs = 0.5; // Minimum fragment size [mm]

// Parameters
diameter = 100; // ball size (mm)
radius = diameter/2;


%color([0.8,0.8,0.8,0.8]) sphere(r=radius);

module mic(rot) {
    rotate(rot)
        translate([0,0,radius-6])
            color([0.4,0.4,0.4]) cylinder(r=10/2, h=6);
}

mic();

mic([60,0,0]);
mic([-60,0,0]);
mic([0,60,0]);
mic([0,-60,0]);

mic([90,0,45]);
mic([90,0,-45]);
mic([90,0,135]);
mic([90,0,-135]);

mic([120,0,0]);
mic([-120,0,0]);
mic([0,120,0]);
mic([0,-120,0]);

mic([180,0,0]);


