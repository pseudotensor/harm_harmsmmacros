plotfluxes    0 #
		#
		device postencap mfluxtavg.eps
		ltype 0 ctype default pl 0 newx1 m1 0001 .6 3.05 -.07 .01
		ltype 2 ctype red pl 0 newx1 m2 0010
		device X11
		#
		device postencap efluxtavg.eps
		ltype 0 ctype default pl 0 newx1 e1 0001 .6 3.05 -.005 .06
		ltype 2 ctype red pl 0 newx1 e2 0010
		device X11
		#
		device postencap lfluxtavg.eps
		ltype 0 ctype default pl 0 newx1 l1 0001 .6 3.05 -.2 .05
		ltype 2 ctype red pl 0 newx1 l2 0010
		device X11
		#
		device postencap emfluxtavg.eps
		ltype 0 ctype default pl 0 newx1 em1 0001 .6 3.05 -1 -.90
		ltype 2 ctype red pl 0 newx1 em2 0010
		device X11
		#
		device postencap lmfluxtavg.eps
		ltype 0 ctype default pl 0 newx1 lm1 0001 .6 3.05 0 3.5
		ltype 2 ctype red pl 0 newx1 lm2 0010
		device X11
		#
debugplot1  0   #
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 lrho
		#
		set it=lg(fail0+1)
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		plc 0 it 010
		#
		set it=lg(floor0+1)
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		plc 0 it 010
		#
		set it=lg(limitgamma0+1)
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR yellow
		plc 0 it 010
		#
		set it=lg(failu0+1)
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 it 010
		#
		#
		#
