tera1 0         #
		device postencap velvst.eps
		#
		#da mdotvstime066.txt
		da bull.txt
		lines 1 100000
		read '%g %g' {t mdot}
		#
		set bull=(-1.0/mdot)/1000.0
		#
		pl 0 t mdot
		#
		#
		define x1label "t GM/c^3"
		define x2label "dt GM/c^3"
		ltype 0
		pl 0 t bull 0001 0 3700 0 1
		#
		ltype 1
		pl 0 t (0.15+t*0) 0011 0 3700 0 1
		ltype 2
		pl 0 t (0.15*1.8+t*0) 0011 0 3700 0 1
		ltype 3
		pl 0 t (0.15*2.0+t*0) 0011 0 3700 0 1
		#
		device X11
		#
		#
tera2 0         #
		#
		fdraft
		#
		device postencap dtvst.eps
		#
		#
		#da mdotvstime066.txt
		da bull.txt
		lines 1 100000
		read '%g %g' {t mdot}
		#
		set bull=0.6-(-1.0/mdot)/1000.0
		#
		#
		define x1label "t GM/c^3"
		define x2label "dt GM/c^3"
		ltype 0
		pl 0 t bull 0001 0 3700 0 1
		#
		ltype 1
		set god=0.44
		pl 0 t (god+t*0) 0011 0 3700 0 1
		ltype 2
		pl 0 t (god/1.8+t*0) 0011 0 3700 0 1
		ltype 3
		pl 0 t (god/2.0+t*0) 0011 0 3700 0 1
		#
		#
		device X11
		#
