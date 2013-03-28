//	voltron_fake_parts.scad
	//	fake_lion_hind_leg(); fake_lion_front_leg(); fake_joint();

module fake_lion_hind_leg(radius=5, thickness=0.5, width=20, fn=facets/2)
	{
	rotate([-90,-90,0]) 
	translate([radius,0,0]) 
		{
		linear_extrude(height=width+thickness*6, center=true) 
			{
			//	Larger part of leg
			translate([radius*2.5,0,0]) circle(radius+1, $fn=fn);
			difference() 
				{
				hull()
					{
					union()
						{
						translate([radius*2.5,0,0]) circle(radius+1, $fn=fn);
						translate([radius+2,-radius/2,0]) circle(radius-2, $fn=fn);
						translate([radius-2,-radius/2,0]) circle(radius-2, $fn=fn);
						translate([-2,0,0]) circle(radius-2, $fn=fn);
						}
					}
				translate([radius*0.5,radius*4.5,0]) circle(radius*4, $fn=fn);
				}
			//	Smaller part of leg
			hull()
				{
				translate([radius*2,radius*1.7,0]) circle(r=radius-2, $fn=fn);
				translate([radius*1.7,radius*1.7,0]) rotate([0,0,15]) square(radius, center=true);
				}
			}
		linear_extrude(height=width+thickness*2, center=true) 
			{
			//	Hind leg to paw
			hull()
				{
				translate([-2,0,0]) circle(radius-2, $fn=fn);
				translate([radius*2,radius*1.7,0]) circle(radius-2, $fn=fn);
				}
			}
		linear_extrude(height=width+thickness*4, center=true) 
			{
			//	Claws
			translate([radius*0.8,0,0]) 
			difference()
				{
				translate([radius*0.3,radius*2.7,0]) circle(radius*1.3, $fn=fn);
				translate([radius*-.25,radius*3.25,0]) circle(radius*1.3, $fn=fn);
				translate([radius*1,radius*3,0]) square(radius*2, center=true);
				}
			}
		linear_extrude(height=width+thickness*8, center=true) 
			{
			translate([-2,0,0]) difference()
				{
				circle(r=radius-3, $fn=fn);
				circle(r=radius-4, $fn=fn);
				}
			translate([radius*2.5,0,0]) difference()
				{
				circle(r=radius, $fn=fn);
				circle(r=radius-1, $fn=fn);
				}
			translate([radius*2,radius*1.7,0]) difference()
				{
				circle(r=radius-3, $fn=fn);
				circle(r=radius-4, $fn=fn);
				}
			}
		}
	}

module fake_lion_front_leg(radius=5, thickness=0.5, width=20, fn=facets/2)
	{
	rotate([-90,-90,0]) 
	translate([radius,0,0]) 
		{
		linear_extrude(height=width+thickness*4, center=true) 
			{
			//	Larger part of leg
			hull()
				{
				circle(radius, $fn=fn);
				translate([radius*2.5,0,0]) circle(radius-2, $fn=fn);
				}
			//	Smaller part of leg
			hull()
				{
				translate([radius*1.8,radius*1.5,0]) circle(r=radius-2, $fn=fn);
				translate([radius*0.5,radius*1.5,0]) rotate([0,0,-5]) square(radius, center=true);
				}
			}
		linear_extrude(height=width+thickness*2, center=true) 
			{
			//	Hind leg to paw
			hull()
				{
				translate([radius*2.5,0,0]) circle(radius-2, $fn=fn);
				translate([radius*1.8,radius*1.5,0]) circle(radius-2.5, $fn=fn);
				}
			//	Claws
			difference()
				{
				translate([radius*.3,radius*2.7,0]) circle(radius*1.5, $fn=fn);
				translate([radius*-.25,radius*3.25,0]) circle(radius*1.5, $fn=fn);
				translate([radius*1,radius*3,0]) square(radius*2, center=true);
				}
			}
		linear_extrude(height=width+thickness*6, center=true) 
			{
			difference()
				{
				circle(r=radius-1, $fn=fn);
				circle(r=radius-2, $fn=fn);
				}
			translate([radius*2.5,0,0]) difference()
				{
				circle(r=radius-3, $fn=fn);
				circle(r=radius-4, $fn=fn);
				}
			translate([radius*1.8,radius*1.5,0]) difference()
				{
				circle(r=radius-3, $fn=fn);
				circle(r=radius-4, $fn=fn);
				}
			}
		}
	}

module fake_joint(width=16, radius=14/2, thickness=2, fn=facets)
	{
	difference()
		{
		rotate([0,90,0]) cylinder(r=radius, h=width+thickness*2, $fn=fn, center=true);
		for (i=[0,1]) rotate([0,0,180*i]) difference()
			{
			translate([width/2+thickness,0,0]) rotate([0,90,0]) cylinder(r=radius-1, h=2, $fn=fn, center=true);
			translate([width/2+thickness,0,0]) rotate([0,90,0]) cylinder(r=radius-2, h=3, $fn=fn, center=true);							}
		}
	}