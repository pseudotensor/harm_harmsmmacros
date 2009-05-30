
averyplot0    0 #
		greaddump dumptavg2040v2
		#
		jre punsly.m
		jre levinson.m
		#
		setdxdxpold
		setjetpart1
		define x1label "u^\phi[BL]/u^t[BL]"
		define x2label "u_\phi[BL]/u_t[BL]"
		#
averyplot1    0 #
		averyplot0
		#
		set usehor=((r>$rhor)&&(r<20)&&(abs(h-pi/2)<0.2))
		#set usehor=((r>$rhor)&&(r<risco)&&(abs(h-pi/2)<0.2))
		set vphibl=uu3bl/uu0bl if(usehor)
		set lphibl=ud3bl/ud0bl if(usehor)
		set rhonew=rho if(usehor)
		set unew=u if(usehor)
		#
		#device postencap disk.eps
		#
		erase
		limits vphibl lphibl
		ctype default box
		ctype default points vphibl lphibl
		xla $x1label
		yla $x2label
		#
		#device X11
		#!scp disk.eps jon@rainman.astro.uiuc.edu:public_html/
		#
		ctype default pl 0 vphibl lphibl
		set myfit=-2.7*(vphibl/0.1)**(-.21)
		ctype red pl 0 vphibl myfit 0010
	#       #
averyplot2 0    #
		averyplot0
		#
		set vphibl=uu3bl/uu0bl
		set lphibl=ud3bl/ud0bl
		#
		gcalc2 3 2 0.2 vphibl vphiblvsr
		gcalc2 3 2 0.2 lphibl lphiblvsr
		#
		device postencap diska.35.eps
		#
		fdraft
		ctype default pl 0 vphiblvsr lphiblvsr
		# a=0.9375
		#set myfit=-2.7*(vphiblvsr/0.1)**(-.21)
		# a=0.35
		set myfit=-3.24*(vphiblvsr/0.1)**(-.17)
		ctype red pl 0 vphiblvsr myfit 0010
		#
		device X11
		!scp diska.35.eps jon@rainman.astro.uiuc.edu:public_html/
avery3 0        #
		set it1=rho+$gam*u+bsq
		set it2=($gam-1)*u+bsq*0.5
		set rhonew=it1 if(usehor)
		set unew=it2 if(usehor)
		#
		#
		erase
		limits rhonew unew
		ctype default box
		points rhonew unew
		#pl 0 rhonew unew 1100
		#
		#
		set it1=rho+$gam*u+bsq
		set it2=($gam-1)*u+bsq*0.5
		set it3=($gam-1)*u
		gcalc2 3 2 0.2 it1 it1vsr
		gcalc2 3 2 0.2 it3 it3vsr
		gcalc2 3 2 0.2 it2 it2vsr
		ctype default pl 0 it1vsr it2vsr 
		pl 0 it1vsr it3vsr
