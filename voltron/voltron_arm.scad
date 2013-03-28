//	voltron_arm.scad
	//	arm_plate(); arm_assembled(); lion_hand(); lion_hand_uncolored(); wrist(); bicep(); 
	//	green_bicep(); green_wrist(); red_bicep(); red_wrist(); 
	//	elbow(); bicep1(); bicep2(); shoulder(); arm_pins(); 4arm_pins(); 

module arm_plate()
	{
	% cube([100,100,0.1], center=true);
	translate([7.5,0,0]) rotate([0,0,90]) lion_hand();
	translate([-12.5,0,0]) wrist(forearm_length);
	translate([-35,0,0]) bicep(bicep_length);
	translate([25,0,0]) elbow();
	translate([40,-2,0]) shoulder();
	}

module arm_assembled(mirrored=0)
	{
	//	Common Parts
	for (i=[0,1]) mirror([i,0,0]) translate([-30-i*9,0,70]) 
		{
		translate([-2,0,14+forearm_length-0.2]) rotate([90,0,90]) elbow();
	*	translate([-2.5+4-1,0,6+forearm_length+bicep_length]) rotate([0,0,0]) translate([0,0,3]) rotate([90,0,90]) 
			translate([0,0,-3]) shoulder();
		translate([-2.5+6,0,3+forearm_length+bicep_length]) rotate([0,0,0]) translate([0,0,3]) rotate([0,0,-90]) 
				translate([0,0,-3]) shoulder();
		}
	//	Green Arm
	translate([-30,0,70]) 
		{
		rotate([0,0,90]) lion_hand(green=1,red=0);
		translate([0,0,12.7]) wrist(forearm_length, green=1, red=0);
		translate([0.5,0,forearm_length+8]) rotate([0,0,0]) translate([0,0,5]) bicep(green=1,red=0, radius=bicep_radius);
		}
	//	Red Arm
	translate([30+9,0,70]) 
		{
		rotate([0,0,-90]) lion_hand(green=0,red=1);
		rotate([0,0,180]) translate([0,0,12.7]) wrist(forearm_length, red=1, green=0);
		translate([0.5,0,forearm_length+8]) rotate([0,0,180]) translate([0,0,5]) bicep(green=0,red=1, radius=bicep_radius);
		}
	}	

module lion_hand(green=1,red=0)
	{
	if (green==1 || red==0) { color("Green", 0.9) lion_hand_uncolored(); }
	if (green==0 || red==1) { color("Red", 0.9) lion_hand_uncolored(); }
	}
	
module lion_hand_uncolored()
	{
	difference()
		{
		union()
			{
			//	Pin
			translate([0,0,12.5]) pin(r=3);
			//	Fake hinge
			translate([0,-3,8]) fake_joint(radius=1.5, width=13, thickness=1);
			//	Jaw
			intersection()
				{
				translate([0,0,12.5/2]) cube([11.5,12,12.5], center=true);
				cylinder(r1=7.25, r2=8, h=13, $fn=facets, center=false); 
				}
			//	Head
			translate([0,0.5,0]) intersection()
				{
				rotate([90,0,0]) 
					linear_extrude(height=14, center=true) polygon(
						points=[ [ 16/2, 12.5], [ -16/2, 12.5], [ -14/2, 12.5/2], [0,5], [ 14/2, 12.5/2], ], 
						path=[1,2,3,4,5]);
				translate([0,0,0]) cylinder(r1=9, r2=9.5, h=13, $fn=facets, center=false);
				}
			//	Nose
			translate([0,5,0]) rotate([0,0,0]) cylinder(r=2,h=10, $fn=6);
			//	Ears
			intersection()
				{
				for (i=[0,1]) mirror([i,0,0]) translate([0,0,10.5]) linear_extrude(height=4, center=true) 
					polygon( points=[ [0,7.5], [0,0], [19/2,9/2 ], [ 20/2, 12.5/2], [ 19/2, 13/2], ], 
						path=[1,2,3,4,5,6,7,8,9,10,11]);
				translate([0,0,8]) cylinder(r1=8, r2=12, h=5, $fn=facets, center=false);
				}
			//	Whiskers
			for (i=[0,1]) mirror([i,0,0])
				{
				translate([5.5,0,8]) cube([4,0.5,4], center=true);
				translate([5.5,1,8]) cube([4,0.5,4], center=true);
				translate([5.5,2,8]) cube([4,0.5,4], center=true);
				}
			}
		union()
			{
			//	Mouth cutout
			translate([0,0,3-0.1]) rotate([0,90,0]) cylinder(r=3, h=16, $fn=facets, center=true);
			//	Teeth cutout
			difference()
				{
				cube([16,5,6], center=true);
				for (i=[-1,1]) translate([3.5*i,0,0]) cube([1,5,6.5], center=true);
				}
			}		
		}
	}

module bicep(green=1,red=0, length=bicep_length, radius=bicep_radius)
	{
	if (green==1 || red==0)
		{ color("Green",0.9) green_bicep(length, radius); }
	if (green==0 || red==1)
		{ color("Red",0.9) red_bicep(length, radius); }
	}

module wrist(green=1,red=0, length=forearm_length)
	{
	if (green==1 || red==0)
		{ color("Green",0.9) green_wrist(length); }
	if (green==0 || red==1)
		{ color("Red",0.9) red_wrist(length); }
	}

module green_bicep(length=20, radius=8)
	{
	difference()
		{
		translate([0,0,length/2]) union()
			{	//	Main bicep
			intersection()
				{
				//	Bicep
				cylinder(r=radius, h=length, center=true, $fn=facets);
				//	Taper bicep near elbow
				cylinder(r1=radius-1.5, r2=radius*3, h=length+2, center=true,$fn=facets);
				//	Taper bicep near shoulder
				cylinder(r2=radius-1.5, r1=radius*3, h=length+2, center=true,$fn=facets);
				}
			//	Base of tail, near butt
			translate([-radius+1,0,length-1-length/2]) rotate([90,0,0]) cylinder(r=2, h=3, $fn=facets/2, center=true);
			//	Length of tail
			translate([-radius,0,length/1.5+1-length/2]) cylinder(r1=0.8,r2=1.5,h=length/2, center=true);
			//	Tip of tail
			translate([-radius+1,0,length/2-2-length/2]) scale([1,1,1.8]) rotate([90,0,0]) cylinder(r=2, h=2, $fn=facets/2, center=true);
			//	Fake hind legs
			translate([0,0,length/3-length/2]) fake_lion_hind_leg(radius=4,width=radius*2-1);
			}
		//	Shoulder connector - full ROM
		translate([0,0,length-7]) rotate([0,0,90])
			joint_male_negative(male_joint_width=7, male_joint_thickness=6, 
			male_joint_height=8, forward_rom=120, backward_rom=10, clearance_edge=0, fn=facets);
		//	Elbow connector - zero ROM
		translate([0,0,length+2.5]) rotate([180,0,90]) translate([0,0,length-5]) 
			joint_male_negative(male_joint_width=5, male_joint_thickness=5, male_joint_height=8, forward_rom=0, 
			backward_rom=0, clearance_edge=0, fn=facets);
		}
	}

module green_wrist(length=forearm_length, radius=forearm_radius)
	{
	difference()
		{
		translate([0,0,length/2]) union()
			{
			intersection()
				{
				//	Forearm
				cylinder(r=radius, h=length, center=true,$fn=facets);
				//	Taper forearm near wrist	
				cylinder(r1=radius-1.5, r2=radius*3, h=length+2, center=true,$fn=facets);
				//	Taper forearm near elbow
				cylinder(r2=radius-1.5, r1=radius*3, h=length+2, center=true,$fn=facets);
				}
			//	Adding some minor circular details around forearm
				cylinder(r=radius+1/10, h=length-2, center=true,$fn=facets);
			for (i=[1:5]) cylinder(r=radius+0.1+i/5, h=length/(1+i/5), center=true,$fn=facets);
			//	Fake joint
			translate([0,0,length/2-5]) rotate([0,0,90]) fake_joint(radius=4, width=radius*2, thickness=1.5);
			//	Fake lion legs
			translate([0,0,-length/2]) fake_lion_front_leg(radius=4,width=radius*2+1);
			}
		//	Wrist joint
		pinhole(r=3, tight=false);
		//	Elbow joint
		rotate([0,0,90]) translate([0,0,length-5]) joint_male_negative(male_joint_width=5, male_joint_thickness=5, 
			male_joint_height=8, forward_rom=90+45, backward_rom=0, clearance_edge=6, fn=facets);
		}
	}

module red_bicep(length=20, radius=8)
	{
	difference()
		{
		translate([0,0,length/2]) union()
			{	//	Main bicep
			intersection()
				{
				//	Bicep
				cube([radius*2-1, radius*2+1,length], center=true);
				//	Taper forearm near wrist	
				rotate([0,0,45]) cylinder(r1=radius-1.5, r2=radius*10, h=length+2, center=true,$fn=4);
				//	Taper forearm near elbow
				rotate([0,0,45]) cylinder(r2=radius-1.5, r1=radius*10, h=length+2, center=true,$fn=4);
				//	Flattening the corners
				rotate([0,0,45]) cube([radius*2+5, radius*2+5, length+2], center=true);
				}
			//	Base of tail, near butt
			translate([-radius+1,0,length-1-length/2]) rotate([90,0,0]) cylinder(r=2, h=3, $fn=facets/2, center=true);
			//	Length of tail
			translate([-radius,0,length/1.5+1-length/2]) cylinder(r1=0.8,r2=1.5,h=length/2, center=true);
			//	Tip of tail
			translate([-radius+1,0,length/2-2-length/2]) scale([1,1,1.8]) rotate([90,0,0]) 
				cylinder(r=2, h=2, $fn=facets/2, center=true);
			//	Fake hind legs
			translate([0,0,length/3-length/2]) fake_lion_hind_leg(radius=4,width=radius*2);
			}
		//	Shoulder connector - full ROM
		translate([0,0,length-7]) rotate([0,0,90])
			joint_male_negative(male_joint_width=7, male_joint_thickness=6, 
			male_joint_height=8, forward_rom=120, backward_rom=10, clearance_edge=0, fn=facets);
		//	Elbow connector - zero ROM
		translate([0,0,length+2.5]) rotate([180,0,90]) translate([0,0,length-5]) 
			joint_male_negative(male_joint_width=5, male_joint_thickness=5, male_joint_height=8, forward_rom=0, 
			backward_rom=0, clearance_edge=0, fn=facets);
		}
	}

module red_wrist(length=forearm_length, radius=forearm_radius)
	{
	difference()
		{
		translate([0,0,length/2]) union()
			{
			intersection()
				{
				//	Forearm
				cube([radius*2, radius*2+2,length], center=true);
				//	Taper forearm near wrist	
				rotate([0,0,45]) cylinder(r1=radius-1.5, r2=radius*10, h=length+2, center=true,$fn=4);
				//	Taper forearm near elbow
				rotate([0,0,45]) cylinder(r2=radius-1.5, r1=radius*10, h=length+2, center=true,$fn=4);
				//	Flattening the corners
				rotate([0,0,45]) cube([radius*2+5, radius*2+5, length+2], center=true);
				}
			//	Fake joint
			translate([0,0,length/2-5]) rotate([0,0,90]) fake_joint(radius=4, width=radius*2, thickness=1.5);
			//	Fake lion legs
			translate([0,0,-length/2]) fake_lion_front_leg(radius=4,width=radius*2+1.5);
			}
		//	Wrist joint
		pinhole(r=3, tight=false);
		//	Elbow joint
		rotate([0,0,90]) translate([0,0,length-5]) joint_male_negative(male_joint_width=5, male_joint_thickness=5, 
			male_joint_height=8, forward_rom=90+45, backward_rom=0, clearance_edge=6, fn=facets);
		}
	}

module elbow()
	{
	color("White",1) for(i=[0,1])
		{
		rotate([0,0,i*180]) translate([0,-8.5/2,0]) 
			joint_male_horizontal(male_joint_width=5.5, male_joint_thickness=5, male_joint_height=8.5);
		}
	}

module bicep2(bicep_length=20)
	{
	difference()
		{
		//	Rotating the bicep so that there is a flat edge on top/bottom/sides
		intersection()
			{
			translate([0,0,(bicep_length+14)/2]) cube([18, 18, bicep_length+14], center=true);
			cylinder(r=11, h=bicep_length+14+1, center=false);
			
			translate([0,0,(bicep_length+14)/2]) rotate([0,90,0]) cylinder(r=(bicep_length+14+3)/2, h=19, center=true);
			translate([0,0,(bicep_length+14)/2]) rotate([0,90,90]) cylinder(r=(bicep_length+14+3)/2, h=19, center=true);
			
			}
		//	Shoulder connector - full ROM
		translate([0,0,bicep_length+5]) rotate([0,0,90])
			joint_male_negative(male_joint_width=7, male_joint_thickness=6, 
			male_joint_height=8, forward_rom=120, backward_rom=10, clearance_edge=0, fn=facets);
		//	Elbow connector - zero ROM
		translate([0,0,bicep_length+2.5]) rotate([180,0,90]) translate([0,0,bicep_length-5]) 
			joint_male_negative(male_joint_width=5, male_joint_thickness=5, male_joint_height=8, forward_rom=0, 
			backward_rom=0, clearance_edge=0, fn=facets);
		}
	}

module bicep1(bicep_length=20)
	{
	difference()
		{
		//	Rotating the bicep so that there is a flat edge on top/bottom/sides
		rotate([0,0,360/8/2]) translate([0,0,bicep_length/2]) union()
			{
			cylinder(r=9, h=bicep_length/4, center=true,$fn=8);
			cylinder(r2=7, r1=9, h=bicep_length/2, center=false,$fn=8);
			rotate([0,180,0]) cylinder(r2=7, r1=9, h=bicep_length/2, center=false,$fn=8);
			translate([0,0,bicep_length/2+5]) sphere(r=9,$fn=facets);
			}
		//	Shoulder connector - full ROM
		translate([0,0,bicep_length+5]) rotate([0,0,90])
			joint_male_negative(male_joint_width=7, male_joint_thickness=6, 
			male_joint_height=8, forward_rom=120, backward_rom=10, clearance_edge=0, fn=facets);
		//	Elbow connector - zero ROM
		translate([0,0,bicep_length+2.5]) rotate([180,0,90]) translate([0,0,bicep_length-5]) 
			joint_male_negative(male_joint_width=5, male_joint_thickness=5, male_joint_height=8, forward_rom=0, 
			backward_rom=0, clearance_edge=0, fn=facets);
		}
	}
	
module shoulder()
	{
	color("White",1) union()
		{
		joint_male_horizontal(male_joint_width=7.5, male_joint_thickness=6, male_joint_height=12);
		translate([0,6.5,0]) rotate([0,0,180]) pin(r=3.5, side=true);
		}
	}

module arm_pins()
	{
	for (i=[-1,1])
		{
		translate([0,12.5*i,0])
		union()
			{
			4arm_pins();
			rotate([0,0,180]) 4arm_pins();
			}
		}
	}

module 4arm_pins()
	{
	translate([45,-2,0]) shoulder();
	translate([32.5,0,0]) elbow();
	translate([20,-2,0]) shoulder();
	translate([7.5,0,0]) elbow();
	}
