//	voltron_leg.scad
	//	leg_connectors(); legs_connectors(); leg_plate(); leg_assembled(); lion_foot(); ankle(); calf(); thigh(); 

module leg_connectors(plate=1)
	{
	if (plate==1) { % cube([100,100,0.1], center=true); }
	translate([25,0,0]) rotate([0,0,90]) ankle();
	translate([-10,0,0]) rotate([0,0,90]) thigh();
	}

module legs_connectors(plate=1)
	{
	if (plate==1) { % cube([100,100,0.1], center=true); }
	translate([0,9,0]) leg_connectors(0);
	translate([0,-9,0]) leg_connectors(0);
	}

module leg_plate(plate=1)
	{
	if (plate==1) { % cube([100,100,0.1], center=true); }
	//	Yellow Leg
		translate([0,20,0])
			{
			translate([30,0,0]) lion_foot(yellow=1, blue=0);
			translate([0,5,0]) rotate([0,0,90]) ankle();
			translate([-30,5,0]) calf(yellow=1, blue=0);
			translate([-15,-12.5,0]) rotate([0,0,90]) thigh();
			}
	//	Blue Leg
		translate([0,-20,0])
			{
			translate([30,0,0]) lion_foot(yellow=0, blue=1);
			translate([0,5,0]) rotate([0,0,90]) ankle();
			translate([-30,5,0]) calf(yellow=0, blue=1);
			translate([-15,-12.5,0]) rotate([0,0,90]) thigh();
			}
	}

module leg_assembled(mirrored=0)
	{
	//	Leg
	for (i=[0,mirrored])
		{
		mirror([i,0,0]) translate([feetSeparation,feetForward ,0]) 
			{
			lion_foot();
			translate([0,-3,4]) translate([0,0,10]) rotate([90,0,0]) 
				ankle();
			translate([0,-3.5-14/4,14+tolerance]) calf(); 	
			translate([0,-3.3,41.8+40/2]) rotate([90,0,0]) thigh(35);
			translate([10/2,-7,79.8+12/2]) 
			difference()
				{
				rotate([0,90,180]) hip();
		*		cube(100);
				}
			}
		}
	}

module lion_foot(joint_offset=-7, yellow=1, blue=0)
	{
	difference()
		{
		union()
			{
			if (yellow==1 || blue==0)
				{
				for (i=[0,1]) mirror([i,0,0]) 
					{
					//	Ears
					translate([10,0,0]) rotate([0,-90,0]) linear_extrude(height=1.5, center=false) 
						polygon(points=[	[16,-4], [16,0], [12,4], [11,7.5], [0,7.5], [0,-4],	], 
							path=[1,2,3,4,5,6,7,8,9,10]);
					//	Whiskers
					translate([4.3,12.7,4]) cube([4,4,0.5], center=true);
					translate([4.3,12.7,5]) cube([4,4,0.5], center=true);
					translate([4.3,12.7,6]) cube([4,4,0.5], center=true);
					}
				}
			if (yellow==0 || blue==1)
				{
				for (i=[0,1]) mirror([i,0,0]) 
					{
					//	Ear
					translate([10.25,0,0]) 
					rotate([0,-90,0]) 
					linear_extrude(height=2.5, center=false)
						{
						polygon(points=[	[14,-5], [17,-4], [17,-1], [15,-1], [11,2], [5,2], [5,-5],	], 
							path=[1,2,3,4,5,6,7,8,9,10]);
						}
					//	Detail inside ear
					translate([10.5,-1.5,8.5]) cube([1,5,5], center=true);
					//	Also, a cylinder near the jaw
					translate([10,0,1]) rotate([90,0,0]) cylinder(r=1, h=7, $fn=facets/2, center=true);
					//	Whiskers
					translate([8.2,5.7,4]) cube([4,4,0.5], center=true);
					translate([8.2,5.7,5]) cube([4,4,0.5], center=true);
					translate([8.2,5.7,6]) cube([4,4,0.5], center=true);
					}
				//	Curved top to head
				translate([0,-4,12]) difference()
					{
					cylinder(r1=10, r2=8, h=2, center=true, $fn=facets);
					cylinder(r=6, h=4, center=true, $fn=facets);
					translate([0,0,2]) cube([2,22,5], center=true);
					}
				}
			//	Top of the head and eyes
			difference()
				{
				union()
					{
					//	Main polyhedron for foot
					for (i=[0,1]) mirror([i,0,0]) linear_extrude(height=13, center=false) 
						polygon(points=[	[10,-4], [6,-4], [0,-4], [0,7.5], [10,7.5]	], 
							path=[1,2,3,4,5,6,7,8,9,10]);
					translate([0,-12,4]) rotate([0,90,0]) cylinder(r=3, h=17, center=true);
					translate([0,-5,4]) rotate([0,90,0]) cylinder(r=3, h=17, center=true);
					}
				difference()
					{
					//	Flattening the top of the head
					translate([0,0,23.5]) rotate([10,0,0]) cube([30,60,20],center=true);
					cube([20,15,28], center=true);
					}
				if (yellow==1 || blue==1)
					{
					//	This cylinder is pushed forward
					translate([0,7.5+1,20-0.5]) rotate([10,0,0]) rotate([0,90,0]) 
						cylinder(r=10, h=20.01, $fn=8,center=true);
					}
				if (yellow==0 || blue==1)
					{
					//	This cylinder is pushed back towards the ankle more
					translate([0,7.3,19.5]) rotate([10,0,0]) rotate([0,90,0]) 
						cylinder(r=10, h=20.01, $fn=8,center=true);
					}
				}
			//	Rounded area behind head
				translate([0,joint_offset+0.5,8]) rotate([0,90,0]) cylinder(r=7-1, h=20-1, $fn=facets, center=true);
			if (yellow==1 || blue==0)
				{
				//	Large fake ankle joint
			*	translate([0,joint_offset,7]) fake_joint(radius=5, width=18, thickness=1.5);
				translate([0,joint_offset+4,8.2]) rotate([90,90,0]) fake_lion_front_leg(radius=4, width=20, thickness=0.5); 
				}	
			if (yellow==0 || blue==1)
				{
				//	Large fake ankle joint
			*	translate([0,joint_offset,7]) fake_joint(radius=3, width=19, thickness=1.5);
				translate([0,joint_offset+4,8.2]) rotate([90,90,0]) fake_lion_front_leg(radius=4, width=20, thickness=0.5); 
				}	
			//	Small fake jaw joint
			translate([0,6,2]) fake_joint(radius=1.5, width=19, thickness=1);
			//	Face
			intersection()
				{
				//	Snout
				for (i=[0,1]) mirror([i,0,0]) linear_extrude(height=8, center=false) 
					polygon(points=[	[6,14.5], [8,0], [0,0], [0,14.5]	], 
						path=[1,2,3,4,5,6,7,8,9,10]);
				//	Rounding the snout
				translate([0,7,5-0.5]) rotate([-90,0,0]) cylinder(r1=9, r2=5, h=10, $fn=16, center=false);
				}
			//	Nose
			translate([0,0,7]) scale([0.8,1,0.6]) rotate([-90,0,0]) rotate([0,0,90]) 
				cylinder(r1=6, r2=3, h=15, $fn=5, center=false);
			if (yellow==1 || blue==0)
				{
				//	Nose tip
				translate([0,7.0,7+2.2 ]) rotate([-25,0,0]) scale([0.8,1,0.6]) rotate([-90,0,0]) rotate([0,0,90]) 
					cylinder(r=3, h=6, $fn=5, center=false);
				//	Nose middle
				translate([0,4.4,7+2.7 ]) rotate([-12,0,0]) scale([0.8,1,0.6]) rotate([-90,0,0]) rotate([0,0,90]) 
					cylinder(r=3, h=6, $fn=5, center=true);
				//	Nose towards ankle
				translate([0,2.2,7+2.9 ]) rotate([-57,0,0]) scale([0.8,1,0.6]) rotate([-90,0,0]) rotate([0,0,90]) 
					cylinder(r=3, h=6, $fn=5, center=true);
				//	Nose nearest ankle
				translate([0,-1.3,7+4.7 ]) rotate([0,0,0]) scale([0.8,1,0.6]) rotate([-90,0,0]) rotate([0,0,90]) 
					cylinder(r=3, h=6, $fn=5, center=true);
				}
			}
			//	Carving out upper lip
			translate([0,24.25,-7.5]) cube(20, center=true);
		translate([0,joint_offset,7]) 
			{
			//	Joint negative
			joint_male_negative(male_joint_width=10, male_joint_thickness=8, male_joint_height=20, 
				forward_rom=45, 	backward_rom=0, clearance_edge=3, fn=facets);
			}
		}
	}
	
module ankle()
	{
	for(i=[0,1])
		{
		rotate([0,0,i*180]) translate([0,-11/2,0]) 
			joint_male_horizontal(male_joint_width=10, male_joint_thickness=8, male_joint_height=11);
		}
	}

module calf(yellow=1, blue=0, calf_height=40)
	{
	difference()
		{
		union()
			{
			//	Tail - the long part
				translate([0,8,20]) rotate([0,0,45]) cylinder(r1=1, r2=2, h=18, $fn=4, center=false);
			//	Tail - the tip of the tail
				translate([0,5,21]) scale([1,1,1.5]) rotate([0,90,0]) cylinder(r=3, h=2, $fn=facets/2, center=true);
			if (yellow==1 || blue==0)
				{
				//	The tube along the front edge of the yellow lion
				translate([0,8.5,2]) difference() 
					{
					cylinder(r=2, h=15, $fn=facets/2, center=false);
					translate([0,0,-1]) cylinder(r=1.5, h=17, $fn=facets/2, center=false);
					translate([0,5,0]) rotate([50,0,0]) cube(10, center=true);
					}
				//	The fins on the yellow lion, toward the hindquarters
				for (i=[0,1]) mirror([i,0,0])
					translate([4.5,7,32])
					rotate([0,-90,0]) 
					linear_extrude(height=1.5, center=true)
					polygon(points=[
					[0,0] , [5,5], [7,5], [7,0]
					], path=[1,2,3,4,5,6,7,8,9]);
				//	Ramp sort of thing under tail
					translate([0,7,31.5])rotate([0,-90,0]) linear_extrude(height=8, center=true)
						polygon(points=[
						[-2,0] ,[-4,0], [-2,1.5], [7,1.5], [7,0]
						], path=[1,2,3,4,5,6,7,8,9]);
				}
			if (yellow==0 || blue==1)
				{
				//	The fins on the blue lion, toward the hindquarters, nearer to the tail on either side
				for (i=[0,1]) mirror([i,0,0])
					translate([2,7,26.5])
					rotate([0,-90,0]) 
					linear_extrude(height=0.7, center=true)
					polygon(points=[
					[0,0] , [3,3], [12,3], [12,0]
					], path=[1,2,3,4,5,6,7,8,9]);
				}
		//	Main calf component
			intersection()
				{
				translate([0,0,calf_height/2]) cube([16,14,calf_height],center=true);
				translate([0,0,-1]) cylinder(r=8.5, h=calf_height, $fn=facets, center=false);
				}
		//	Just an edge around the calf to give it detail
			translate([0,0,10/2+5]) intersection()
				{
				cube([16+0.5,14+0.5,10],center=true);
				translate([0,0,-1]) cylinder(r=8.5+0.5, h=12, $fn=facets, center=true);
				}
		//	Just an edge around the calf to give it detail
			translate([0,0,10/2+25]) intersection()
				{
				cube([16+0.5,14+0.5,10],center=true);
				translate([0,0,-1]) cylinder(r=8.5+0.5, h=12, $fn=facets, center=true);
				}
		if (yellow==0 || blue==1)
			{
			//	A slight extra edge around blue calf
			translate([0,0,10/2+5]) intersection()
				{
				cube([16+1,14+1,10-2],center=true);
				translate([0,0,-1]) cylinder(r=8.5+1, h=12-2, $fn=facets, center=true);
				}
			//	Also, a little square patch on the extra edge
			translate([0,7.5,10/2+5]) cube([6,1,6], center=true);
			}
			rotate([0,0,-90]) 
				{ rotate([0,5,0]) translate([-3,0,32-17.5+3.2]) fake_lion_hind_leg(radius=4, width=15.5, thickness=0.5); }
			}
		translate([0,0,6+tolerance+0.2]) rotate([0,180,0]) 
			joint_male_negative(male_joint_width=10, male_joint_thickness=8, male_joint_height=20, 
			forward_rom=0, backward_rom=0, fn=facets);
		translate([0,0,32]) 
			joint_male_negative(male_joint_width=10, male_joint_thickness=8, male_joint_height=20, 
			forward_rom=90+45, backward_rom=2, clearance_edge=1, fn=facets);
		}
	}

module thigh(thigh_length=25)
	{
	//	Leg connector to hip
	translate([0,thigh_length/2+11/2,0]) rotate([0,0,180]) 
		joint_male_horizontal(male_joint_width=5, male_joint_thickness=8, male_joint_height=11);
	//	Leg connector to leg
	joint_male_horizontal(male_joint_width=10, male_joint_thickness=8, male_joint_height=thigh_length);
	//	Edge on front of thigh
	translate([0,5.8,8]) cube([3, thigh_length-21/2, 1], center=true);
	}
