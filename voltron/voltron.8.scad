	use <pin_joints.scad>
	use <joints.scad>
	include <voltron_arm.scad>
	include <voltron_leg.scad>
	include <voltron_body.scad>
	include <voltron_fake_parts.scad>
	include <voltron_plates.scad>

//	General
	facets = 32;
	tolerance = 0.3;
//	Settings
	bicep_length=30;
		bicep_radius=9;
	forearm_length=35;
		forearm_radius=7.5;

*	rotate([0,0,180]) translate([0,-70+70,0]) assembled();

*	yellow_plate();
*	blue_plate();
*	green_plate();
*	red_plate();
*	black_plate();
*	white_plate();
	translate([0,0,8.3]) rotate([-90,0,0]) head_plate();

*	wing();

	% cube([100,100,0.1], center=true);

module assembled(feetSeparation = 12.5, feetForward = 4, calf_height=40, thigh_height=25)
	{
	//	Wings
	color("Red", 0.9) for(i=[0,1]) mirror([i,0,0])
		translate([23,-13,142]) rotate([-90,45,0]) render() 
			wing();
	//	Yellow Leg
	translate([-feetSeparation,feetForward,0]) 
		{
		difference()
			{
			union()
				{
				color("Yellow", 0.9) render() 
					lion_foot();
				color("White", 0.9) translate([0,-3,4]) translate([0,0,10]) rotate([90,0,0]) render() 
					ankle();
				color("Yellow", 0.9) translate([0,-3.5-14/4,14+tolerance]) render() 
					calf(calf_height);
				color("White", 0.9) translate([0,-3.3-8,2.3+calf_height+thigh_height/2]) rotate([90,0,180]) render() 
					thigh(thigh_height);
				color("DimGray", 0.9) translate([-10/2,-7,29.5+calf_height/2+thigh_height]) rotate([0,90,0]) render() 
					hip();
				}
		*	translate([0,-7,0]) cube(300);
			}
		}
	//	Blue Leg
	translate([feetSeparation,feetForward,0]) 
		{
		difference()
			{
			union()
				{
				color("Blue", 0.9) render() 
					lion_foot(yellow=0, blue=1);
				color("White", 0.9) translate([0,-3,4]) translate([0,0,10]) rotate([90,0,0]) render() 
					ankle();
				color("Blue", 0.9) translate([0,-3.5-14/4,14+tolerance]) render() 
					calf(calf_height, yellow=0, blue=1);
				color("White", 0.9) translate([0,-3.3-8,2.3+calf_height+thigh_height/2]) rotate([90,0,180]) render() 
					thigh(thigh_height);
				color("DimGray", 0.9) translate([10/2,-7,29.5+calf_height/2+thigh_height]) rotate([0,90,180]) render() 
					hip();
				}
		*	translate([0,-7,0]) cube(300);
			}
		}
	translate([0,-4.5-6,4+calf_height+thigh_height]) difference()
		{
		color("DimGray", 0.9) rotate([90,0,180]) render() groin();
	*	translate([0,0,-50]) cube(100);
		}
	translate([0,-4.5-6,4+calf_height+thigh_height+23.3]) difference()
		{
		color("DimGray", 0.9) rotate([90,0,180]) render() 
			chest();
	*	translate([0,0,-50]) cube(100);
		}
	translate([0,-2,137.7]) difference()
		{
		color("DimGray", 0.9) render() 
			lion_head();
	*	translate([0,0,-50]) cube(100);
		}
	translate([0,-4.5+1,calf_height+thigh_height+27]) rotate([90,0,0]) translate([0,0,-4]) 
		color("White", 0.9) lumbosacral_spine();
	translate([0,-3.5,calf_height+thigh_height+27+45.3]) rotate([90,0,0]) translate([0,0,-4]) 
		color("White", 0.9) cervical_spine();
	translate([-5,0,-10]) 
		arm_assembled(0);
	}