//	voltron_body.scad
	//	body_plate(); lion_head(); lion_head_without_hole();
	//	chest(); cervical_spine(); lumbosacral_spine(); groin(); hip(); wing();
	
module body_plate()
	{
	% cube([100,100,0.1], center=true);
	translate([-6,11,8.3]) rotate([90,0,0]) lion_head();
	translate([20,0,0]) chest();
	translate([-15,36,0]) hip(); 
	translate([-34,36,0]) hip(); 
	translate([-15,19,0]) rotate([0,0,90]) lumbosacral_spine(); 
	translate([-22,3,0]) rotate([0,0,90]) groin(); 
	}
	
module lion_head()
	{
	difference()
		{
		lion_head_without_hole();
		pinhole(r=3, h=7, tight=true);
		}
	}

module lion_head_without_hole()
	{
	difference()
		{
		//	Top of head
		union()
			{
			translate([0,0,13]) linear_extrude(height=7, center=false)
				for (i=[0,1]) 
					{ mirror([i,0,0]) 
						polygon(points=[ [8,-5], [6,-7.5], [5,-8.3], [0,-8.3], [0,11], [6.5,9.5], [8,3], [8.5,-1] ], 
						path=[1,2,3,4,5,6,7,8]); 
					}
			scale([0.8,1.4,1])
				{
				//	Design on top of head
				translate([0,-2,19.5]) rotate([0,0,90]) 
					cylinder(r=4, h=1, $fn=5);
				//	Design on top of head design on top of head
				translate([0,-2,20]) rotate([0,0,90]) 
					cylinder(r=3, h=1, $fn=5);
				}
			}
		//	Carving out the snout
		difference()
			{
			//	Angling the top front of the snout downward
			translate([0,0,19.5+30/2]) for (i=[0,1]) { mirror([i,0,0]) rotate([-10,10,0]) cube(30, center=true); }	
			//	Excepting the eyes and back of head
			translate([0,0,14.5]) linear_extrude(height=8, center=false)
				for (i=[0,1]) { mirror([i,0,0]) polygon(points=[ [8,-9], [0,-9], [0,4], [10,-1],  ], path=[1,2,3,4,5,6,7,8]); }
			}
		//	Carving out the ear-groves
				for (i=[0,1]) 
					{ 
					mirror([i,0,0]) 
						{
						translate([6.5,-4,20.5]) cube([6,4,2], center=true);
						translate([9,-4,20]) cube([2,4,6], center=true);
						}
					}
		}
	//	Whiskers
	for (i=[1,0]) mirror([i,0,0]) union()
		{
		translate([3,9.1,15.5]) rotate([-10,0,0]) cube([0.5,3,3], center=true);
		translate([4.5,8.7,15.3]) rotate([-10,0,0]) cube([0.5,3,3], center=true);
		translate([6,8.4,15.1]) rotate([-10,0,0]) cube([0.5,3,3], center=true);
		}
	//	Lion Ears!
	for (i=[1,0]) mirror([i,0,0]) translate([9,-4,18.5]) difference()
		{
		union()
			{
			cube([6,4,7], center=true);
			translate([2.5,0,0.5]) cube([2,3,3], center=true);
			}
		translate([-2,0,2]) cube([6,5,7], center=true);
		translate([4.5,0,-4.5]) rotate([0,45,0]) cube(5, center=true);
		}
	//	Lion Nose
	translate([0,3.5,16.9]) scale([1,1,0.75]) rotate([90,90,0]) cylinder(r1=2, r2=5, h=15, $fn=5, center=true);
	//	Jaw hinge
	translate([0,-3,13]) fake_joint(width=16, radius=3.5, thickness=1, fn=facets);
	//	Lower Jaw
	difference()
		{
		intersection()
			{
			//	Setting the boundary for the lower jaw
			linear_extrude(height=14.5, center=false)
				for (i=[0,1]) 
					{ mirror([i,0,0]) polygon(
						points=[ [8,-5], [6,-7.5], [5,-8.3], [0,-8.3], [0,10], [5.5,8.5], [7,3], [8,-1] ], 
						path=[1,2,3,4,5,6,7,8]); 
					}
			union()
				{
				//	Bottom of lower jaw
				translate([0,0,6.2]) rotate([-50,0,0]) translate([0,2,0.2]) difference()
					{
					cube([16.7,20,3], center=true);
					//	Small cutout so that you can see the outline of the inner mouth
					translate([0,0,1.5]) cube([16.7-5,20,1], center=true);
					}
				//	Front of lower jaw
				difference()
					{
					translate([0,8,2/2]) cube([16.7,9.3,2], center=true);
					//	Again, just a small subtle cutout so that you can see the outline of the inner mouth
					translate([0,5,1.5]) scale([1.5,1,1]) cylinder(r=4, h=1, center=false);
					}
				//	Top of face
				difference()
					{
					translate([0,0,10]) sphere(r=6, $fn=facets);
					for(i=[0,1]) mirror([i,0,0])
						{
						//	Eyes
						translate([3.1,6,11]) rotate([0,90,-35]) cylinder(r=1.5, h=5, center=true, $fn=16);
						}
					}
				//	Lips
					translate([0,2.6,5.7]) scale([0.8,1,0.4]) sphere(r=3, $fn=facets);
					translate([0,2.5,5.2]) scale([0.8,1,0.4]) sphere(r=3, $fn=facets);
				//	Bottom of face
				difference()
					{
					translate([0,0,2]) cylinder(r1=5, r2=6, h=8, $fn=facets);
					for(i=[0,1]) mirror([i,0,0])
						{
						//	Cheekbones
						translate([6.5,7.7,5.5]) rotate([-10,10,-35]) cylinder(r=5, h=9, center=true, $fn=16);
						}
					}
				//	Neck
				cylinder(r=5, h=2);
				//	Back of the head
				translate([0,-5.8,13/2]) cube([10,5,13], center=true);
				//	Nose
				translate([0,4.5,9.5]) intersection()
					{
					scale([0.9,1,1.1]) rotate([0,0,90]) cylinder(r1=3, r2=0, h=5, $fn=3, center=true);
					//	This is to flatten out the front of the nose
					translate([0,-0.9,-1]) rotate([20,0,0]) cube(5, center=true);
					}
				//	Underside of Jaw
				translate([0,-1,9]) rotate([40,0,0]) difference()
					{
					cylinder(r=7, h=28, center=true);
					//	This is so that only the rounded part of the back of the neck is showing
					translate([0,28/2,0]) cube(28, center=true);
					}
				//	Teeth
				for (i=[0,1]) mirror([i,0,0]) translate([3.5,10,12.5]) difference()
					{
					//	A triangular cylinder
					scale([1,1,0.6]) rotate([0,90,0]) cylinder(r=4, h=1.5, center=true, $fn=3);
					//	But only half a triangle
					translate([0,10/2,0]) cube(10, center=true);
					}
				}
			}
		}
	}
	
module chest()
	{
	//	Emblem
	translate([0,37.5,21.5]) intersection()
		{
		scale([1.2,2.3,1]) rotate([0,0,90]) cylinder(r=8, h=3, $fn=6, center=true);
		translate([0,-6.8,0]) cube(19, center=true);
		}
	//	The chest plate the emblem sits upon
	translate([0,29,16]) difference()
		{
		scale([1,1,0.25]) rotate([90,45/2,0]) cylinder(r=25, h=27, $fn=8, center=true);
		for (i=[0,1]) mirror([i,0,0])
			translate([23,-12,0]) rotate([0,0,45/2]) cylinder(r=15, h=28, $fn=8, center=true);
		}
	difference()
		{
		for (i=[0,1]) mirror([i,0,0]) 
			{
			difference()
				{
				//	Main groin area
				linear_extrude(height=30, center=false) polygon( points=[
					[0,0], [13.5,0], [14,8], [25,30.5], [25,43.5], [15.5, 43.5], [7, 45], [0,45]
					], path=[1,2,3,4,5,6,7,8,9,10]);
				//	Holes for shoulder pin connectors
				translate([7.5+18,38,7.5]) rotate([0,-90,0]) pinhole(r=4, h=7, tight=true);
				//	Holes for wing connectors
				translate([8,35,0]) pinhole(r=3, h=7, tight=true);
				//	Shaping sides of chest
				translate([-2,5,20]) rotate([10,20,0]) cube(50, center=false);
				}
			}
		//	Shaping chest
			translate([0,-17,10]) 
				{
				//	Stomach cutout
				translate([-25,-25,5]) cube(50, center=false);
				//	Ribcage cutout
				translate([-25,25,5]) rotate([30,0,0]) cube(50, center=false);
				//	Colarbone cutout
				translate([-25,25,25]) rotate([-20,0,0]) cube(60, center=false);
				//	Front chest cutout
				translate([-25,25,9]) rotate([0,0,0]) cube(60, center=false);
				}
		//	Tail cutout
		linear_extrude(height=1, center=true)
			difference()
				{
				union()
					{
					hull()
						{
						translate([0,5,0]) square(4, center=true);
						translate([0,30,0]) square(2, center=true);
						}
					hull()
						{
						translate([0,30,0]) rotate([0,0,90]) circle(r=3, $fn=3);
						translate([0,27,0]) circle(r=3);
						}
					}
				hull()
					{
					translate([0,5,0]) square(3, center=true);
					translate([0,30,0]) square(1, center=true);
					}
				hull()
					{
					translate([0,30,0]) rotate([0,0,90]) circle(r=2, $fn=3);
					translate([0,27,0]) circle(r=2.5);
					}
				}
		//	Pinhole for neck
		translate([0,45,7.5+1]) rotate([90,0,0]) pinhole(r=3, h=7, tight=true);
		//	Pinhole for lumbosacral
		translate([0,0,7.5]) rotate([-90,0,0]) pinhole(r=4, h=7, tight=true);
		}
	}

module cervical_spine()
	{
	for (i=[0,1]) mirror([0,i,0]) translate([0,-7/2,0]) 
		pin(r=3, h=7, side=true);
	}

module lumbosacral_spine()
	{
	for (i=[0,1]) mirror([0,i,0]) translate([0,-7/2,0]) 
		pin(r=4, h=7, side=true);
	}

module groin()
	{
	//	Belt buckle
	translate([0,23-2.5,14.5]) difference()
		{
		cube([5, 3.5,2], center=true);
		cube([5-1, 3.5-1,2+1], center=true);
		}
	difference()
		{
		for (i=[0,1]) mirror([i,0,0]) 
			{
			difference()
				{
				//	Main groin area
				linear_extrude(height=15, center=false) polygon( points=[
					[0,0], [7.5,0], [7.5,13], [31/2,13], [31/2, 23], [0, 23]
					], path=[1,2,3,4,5,6,7,8,9,10]);
				//	Holes for hip pin connectors
				translate([7.5,6,7.5]) rotate([0,-90,0]) pinhole(r=4, h=7, tight=true);
				}
			}
		translate([0,23,7.5]) rotate([90,0,0]) pinhole(r=4, h=7, tight=true);
		}
	}

module hip()
	{
	translate([0,0,10]) pin(r=4, side=false, h=7);
	difference()
		{
		translate([0,0,10/2]) intersection()
			{
			//	Hip
			difference()
				{
				cube([14,14,10], center=true);
				translate([0,0,-10/2]) 
					{
					difference()
						{
						cylinder(r=5, h=1, center=true, $fn=facets);
						cylinder(r=4, h=2, center=true, $fn=facets);
						}
					cylinder(r=2, h=1, center=true, $fn=facets);
					}
				}
			//	Diagonal to cut off corners
			rotate([0,0,45]) cube([15,15, 11], center=true);
			//	Sphere???
			sphere(9);
			}
		//	Thigh connector cutout
		translate([0,0,10/2]) rotate([0,90,0]) 
			joint_male_negative(male_joint_width=5, male_joint_thickness=8, male_joint_height=12, 
			forward_rom=0, backward_rom=0, fn=facets);
		}
	}

module wing(length=25)
	{
	color("Red", 0.9)
		{
		translate([0,21,1.5]) pin(r=3,h=7);
		for (i=[0,1]) mirror([i,0,0]) linear_extrude(height=1.5, center=false) 
			polygon(points=[	[0,25], [7,25], [4,-25], [0,-25]], 
			path=[1,2,3,4,5,6,7,8,9,10]);
		}
	}
