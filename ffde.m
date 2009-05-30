ffde1 0         # shows outer boundary problem
		plc 0 (LG(v1))
		lightitup
		#
		#
		#
lightitup 0             # coordinate light cylinder
		#
		jrdp dump0100
		gammiegridnew3 gdump
		faraday
		set lv1=(LG(ABS(v1)+1E-15))
		plc 0 lv1
		set image[ix,iy]=light
		set light=1.0-sqrt(gv333)*omegaf2
		set lev=-1E-9,1E-9,2E-9
		levels lev
		ctype blue contour
		#
lightitup2 0    #
		jrdp dump0100
		fieldcalc 0 aphi
		interpsingle lv1 200 200 100 100
		interpsingle light 200 200 100 100
		interpsingle aphi 200 200 100 100
		readinterp lv1
		readinterp light
		readinterp aphi
		plc 0 ilv1
		plc 0 iaphi 010
		#
		set image[ix,iy]=ilight
		set lev=-1E-9,1E-9,2E-9
		levels lev
		ctype blue contour
