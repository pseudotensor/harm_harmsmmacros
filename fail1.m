failplot 0      #
		device postencap fail0006.eps
		#
		jrdp dump0006
		jrdpdebug debug0006
		plc 0 lrho
		plc 0 lg1fail 010
		set it=SUM(fail0) print {it}
		#
		set it=fail0 if((h>0.2)&&(h<(pi-0.2)))
		set god=SUM(it) print {god}
		#
		#
		device X11
		!scp fail0006.eps metric:fail0006.3.eps
		


failplot 0              #
		device postencap fail0031.eps
		#
		jrdp dump0031
		jrdpdebug debug0031
		plc 0 lrho
		plc 0 lg1fail 010
		set it=SUM(fail0) print {it}
		#
		device X11
		!scp fail0031.eps metric:fail0031.3.eps
		
		#
		#
		# for pole check
		pls 0 lg1fail 101 Rin Rout 2.5 pi
		#
		# for inner radial check
		pls 0 fail0 101 Rin $rhor 0 pi
		#
		# for inner radial check witout polar axis itself
		pls 0 fail0 101 Rin $rhor 0.2 (pi-0.2)

		# for inner radial check witout polar axis itself
		pls 0 lg1fail 101 Rin $rhor 0.2 (pi-0.2)
