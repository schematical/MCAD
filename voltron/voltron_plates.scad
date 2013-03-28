//	voltron_plates.scad
	//	

module white_plate()
	{
	% cube([100,100,0.1], center=true);
	color("White", 0.9)
		{
		//	Ankle and thigh
		translate([0,-37.5,0]) leg_connectors(0);
		translate([0,-17.5,0]) leg_connectors(0);
		//	Spine
		translate([20,0,0]) rotate([0,0,90]) cervical_spine(); 
		translate([-20,0,0]) rotate([0,0,90]) lumbosacral_spine(); 
		//	Elbow and shoulder
		translate([20,17.5,0]) rotate([0,0,90]) elbow(); translate([-20,17.5,0]) rotate([0,0,90]) shoulder();
		translate([20,35,0]) rotate([0,0,90]) elbow(); translate([-20,35,0]) rotate([0,0,90]) shoulder();
		}
	}

module head_plate()
	{
	color("Dim Gray", 0.9) rotate([0,0,180]) lion_head();
	}
	
module black_plate()
	{
	% cube([100,100,0.1], center=true);
	color("Dim Gray", 0.9)
		{
		translate([0,-5,0]) chest();
		translate([0,-15,0]) rotate([0,0,180]) groin();
		translate([25,-15,0]) hip();
		translate([-25,-15,0]) rotate([0,0,180]) hip();
		}
	}

module red_plate()
	{
	% cube([100,100,0.1], center=true);
	translate([25,0,0]) rotate([0,0,-90]) lion_hand(green=0,red=1);
	translate([-25,0,0]) wrist(green=0,red=1,forearm_length);
	translate([0,0,0]) bicep(green=0,red=1,bicep_length);
	translate([0,20,0]) rotate([0,0,-90]) wing();
	translate([0,-20,0]) rotate([0,0,-90]) wing();
	}

module green_plate()
	{
	% cube([100,100,0.1], center=true);
	translate([25,0,0]) rotate([0,0,-90]) lion_hand(green=1,red=0);
	translate([-25,0,0]) wrist(green=1,red=0,forearm_length);
	translate([0,0,0]) bicep(green=1,red=0,bicep_length);
	}

module blue_plate(plate=1)
	{
	if (plate==1) { % cube([100,100,0.1], center=true); }
	color("Blue", 0.9)
		{
		translate([17.5,0,0]) rotate([0,0,-90]) lion_foot(yellow=0, blue=1);
		translate([-17.5,0,0]) rotate([0,0,90]) calf(yellow=0, blue=1);
		}
	}

module yellow_plate(plate=1)
	{
	if (plate==1) { % cube([100,100,0.1], center=true); }
	color("Yellow", 0.9) render()
		{
		translate([17.5,0,0]) rotate([0,0,-90]) lion_foot(yellow=1, blue=0);
		translate([-17.5,0,0]) rotate([0,0,90]) calf(yellow=1, blue=0);
		}
	}