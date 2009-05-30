saveold 0       # jrdp3du dump0010
		set rideal=r
		set rhoideal=rho
		set uideal=u
		set pideal=(5/3-1)*uideal
		set v1ideal=uu1/uu0
		set v2ideal=uu2/uu0
		set v3ideal=uu3/uu0
		set B1ideal=B1
		set B2ideal=B2
		set B3ideal=B3
		#
savenew 0       # jrdp3du dump0010
		set rmig=r
		set rhomig=rho
		set umig=u
		set pmig=u*(2*rho+u)/(3*(rho+u))
		set v1mig=uu1/uu0
		set v2mig=uu2/uu0
		set v3mig=uu3/uu0
		set B1mig=B1
		set B2mig=B2
		set B3mig=B3
		#
savenewhr 0       # jrdp3du dump0010
		set rhr=r
		set rhohr=rho
		set uhr=u
		set phr=u*(2*rho+u)/(3*(rho+u))
		set v1hr=uu1/uu0
		set v2hr=uu2/uu0
		set v3hr=uu3/uu0
		set B1hr=B1
		set B2hr=B2
		set B3hr=B3
		#
plcmp 1   #
		ltype 0 ctype default pl 0 r $1mig
		ltype 2 ctype red plo 0 r $1ideal
		#
plcmpres 1   #
		ltype 0 ctype default pl 0 rmig $1mig
		ltype 2 ctype red plo 0 rideal $1ideal
		ltype 1 ctype blue plo 0 rhr $1hr
		#
fieldideal 0   #
		jrdp3du dump0025
		fieldcalc 0 aphi
		interpsingle aphi 512 512 0 40 -40 40
		readinterp aphi
		#
		fdraft
		define POSCONTCOLOR "default"
                define NEGCONTCOLOR "default"
                define BOXCOLOR "default"
                #
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
                define cres 15
                plc 0 iaphi 001 0 20 -10 10
                set aphi0=iaphi
		#
		# device postencap ideal43.eps
		# device postencap ideal53.eps
		# device postencap tm.eps
		#
		# what interpsingle used (before readinterp)
		#
		!echo 1 $interptype 1 1 $nx $ny $nz  2.0 0 0  $igrid  $inx $iny $inz  $ixmin $ixmax $iymin $iymax 0 0  $iRin $iRout $iR0 $ihslope $idefcoord
		#
		# for all from 4/3:
		# 1 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 40 -40 40 0 0 1.170236893 40 0 0.3 9
		#
		# for images:
		# 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 40 -40 40 0 0 1.170236893 40 0 0.3 9
		# ~/sm/iinterpnoextrap <above> < input > output
		#
		# < im0p0s0l0625.r8 > ideal43lrho.r8
		# before doing this, copy coordparms.dat to local dir.
		#
		# full thing for 4/3
		#
		# ~/sm/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > ideal43lrho.r8
		#
		# full thing for 5/3
		#
		# ~/sm/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > ideal53lrho.r8
		#
		# full thing for tm
		#
		# ~/sm/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > tmlrho.r8
		#
		#



		#
other 0         #
	 r8torasjon 0 ~/research/pnmhd/bin/i/john.pal ideal43lrho.r8 512 512
         r8torasjon 0 ~/research/pnmhd/bin/i/john.pal ideal53lrho.r8 512 512
         r8torasjon 0 ~/research/pnmhd/bin/i/john.pal tmlrho.r8 512 512
         convert ideal43lrho.ras ideal43lrho.png
         convert ideal53lrho.ras ideal53lrho.png
         convert tmlrho.ras tmlrho.png

