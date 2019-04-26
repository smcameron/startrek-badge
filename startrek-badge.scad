$fn = 128;

module half_thing() {
	translate(v = [20, 0, 2.5]) {
		difference() {
			scale(v = [0.5, 1.0, 1.0])
				cylinder(r1 = 100, r2 = 100, h = 5, center = true);
			translate(v = [-20, -100, -50])
				cube(size = [100, 400, 100]);
		}
	}
}

module delta_thing() {
	union() {
	scale(v = [1.2, 1, 1])
		half_thing();
	translate(v = [-0.001, 0, 0])
		mirror(v = [1, 0, 0])
			scale(v = [0.8, 1, 1])
				half_thing();
	}
}

module basic_badge() {
	difference() {
	delta_thing();
		translate(v = [-6, -70, 0])
			rotate(a = [0, 0, 1], a = -10)
				scale(v = [1.4, 1, 10])
					delta_thing();
	}
}


module badge_with_edge()
{
	difference() {
		minkowski() {
			basic_badge();
			cylinder(r1 = 4, r2 = 4, h = 5);	
		}
		translate(v = [0, 0, 8])
			basic_badge();
	}
}

module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module triangle(thickness, w, h) {
	rotate(v = [0, 1, 0], a = -90)
		prism(thickness, h, w);
}

module isoceles_triangle(thickness, base, height)
{
	union() {
		triangle(thickness, base / 2.0, height);
		translate(v = [-0.001, 0, 0])
			mirror(v = [1, 0, 0])
				triangle(thickness, base / 2.0, height);
	}
}

module star_thing(thickness)
{
	translate(v = [0, 80, 0])
	union() {
		difference() {
			rotate(v = [0, 0, 1], 180)
				isoceles_triangle(thickness, 10, 50); 
			translate(v = [0, -45, -1])
				rotate(v = [0, 0, 1], 180)
					isoceles_triangle(thickness + 2, 10, 6); 
		}
		translate(v = [-10, -40, 0])
			rotate(v = [0, 0, 1], a = -100) 
				isoceles_triangle(thickness, 5, 7);
		translate(v = [10, -40, 0])
			rotate(v = [0, 0, 1], a = 100) 
				isoceles_triangle(thickness, 5, 7);
	}
}

module edged_badge_with_star()
{
	union() {
		badge_with_edge();
		star_thing(10);
	}
}

edged_badge_with_star();
