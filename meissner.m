meissner0 0      # /raid2/jmckinne/grmhd999256r0
                #
                # nearbh.eps
                #
                #jre punsly.m
		#
		if(0){\
		       jrdp2d dump0000
		       da ./dumps/rdump-0
		       lines 2 10000000
		       read {B1 6 B2 7 B3 8}
		    }
		    if(0){\
		           jrdp2d dump0001
		        }
		    if(1){\
		           #jrdp2d dump0001
		        }
                # gammiegridnew3 gdump
                #
                faraday
                fieldcalc 0 aphi
                #
                set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
                #
                set horizon=r-$rhor
                #
                set ergo=r - (1+sqrt(1-(a*cos(h))**2))
                #
                # interpolate
		#
		define sizenx (256)
		define sizeny (256)
                #
		#define sizenx (8)
		#define sizeny (8)
                #
                interpsingle aphi $sizenx $sizeny -2.5 2.5 -2.5 2.5
                interpsingle lights $sizenx $sizeny -2.5 2.5 -2.5 2.5
                interpsingle horizon $sizenx $sizeny -2.5 2.5 -2.5 2.5
                interpsingle ergo $sizenx $sizeny -2.5 2.5 -2.5 2.5
                #
                # get data
                readinterp aphi
                readinterp lights
                readinterp horizon
                readinterp ergo
                #
                # get plot data
                #
                plc 0 iaphi
                set newaphi=newfun
                plc 0 ilights
                set newlights=newfun
                plc 0 ihorizon
                set newhorizon=newfun
                plc 0 iergo
                set newergo=newfun
                #
p1meissner0   0  #
		#
                # begin plotting
                #
		#set mynewaphi=(newaphi<0) ? 0 : newaphi
		#set mynewaphi=(newaphi>0) ? 0 : newaphi
		#set mynewaphi=(abs(mynewaphi))**.6
		#
		set mynewaphi=newaphi
                plc 0 mynewaphi
		#
		erase
		#
p2meissner0   0  #
		#
		#
		# device postencap fig3.eps
		#
                fdraft
		#
		#
		#
                define x1label "x"
                define x2label "z"
                #
                define POSCONTCOLOR "default"
                define NEGCONTCOLOR "default"
                ctype default lweight 3 ltype 0
		#
		#SET s=-1,1,1
		#SET b=-2,2,2
		#define newgy1 ($gy1-100)
		#AXIS -2.5 2.5 s b $gx1 $newgy1 $($gx2-$gx1) 1 0
		#
		ticksize 1 2 1 2
		box
		xlabel $x1label
		ylabel $x2label
		#define cres 40
		define cres 14
                plc 0 mynewaphi 010
		#
		#
                #
                #ctype default lweight 5 ltype 0
		#set image[ix,iy]=newlights
                #set lev=-1E-15,1E-15,2E-15 levels lev
                #lweight 5
                #contour
                #lweight 3
                #
		#ctype default lweight 5 ltype 0
                #set image[ix,iy]=newhorizon
                #set lev=-1E-15,1E-15,2E-15 levels lev
                #lweight 5
                #contour
                #lweight 3
                #
                ctype default lweight 5 ltype 0
                set image[ix,iy]=newergo
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3
		#
		if(1){\
		set Rinold=$rhor*1.00
		# circle
                set t=0,2*pi,.01
                set x=Rinold*sin(t)
                set y=Rinold*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                shade 0 x y
                connect x y
		}
		#
                #shade 1000 x12 (sqrt(Rinold**2+x22**2))
                #
		#set x=0,1,1
                #set x[0]=1/.0216
                #set x[1]=x[0]
                #set y=0,1,1
                #set y[0]=-100
                #set y[1]=100
                #connect x y
                #
		#
		if(0){\
		macro read "/usr/local/lib/sm/macro/utils"
		expand 0.75
		draw_arrowhead 2.4 0.2 90
		#draw_arrowhead 1.705 0.160 5
		#draw_arrowhead 1.57 0.39 5
		#draw_arrowhead 1.46 0.57 5
		#draw_arrowhead 1.32 0.74 5
		#draw_arrowhead 1.08 0.85 5
		#draw_arrowhead 1.056 0.96 5
		#draw_arrowhead 0.94 1.04 5
		#draw_arrowhead 0.82 1.10 5
		#draw_arrowhead 0.674 1.13 5
		#draw_arrowhead 0.550 1.159 5
		#draw_arrowhead 0.41 1.159 5
		#draw_arrowhead 0.354 1.376 5
		#draw_arrowhead 0.086 1.367 5
		#
		draw_arrowhead -2.4 0.2 90
		#
		}
		#
		if(1){\
		macro read "/usr/local/lib/sm/macro/utils"
		expand 0.75
		draw_arrowhead 2.47 0.2 90
		draw_arrowhead -2.47 0.2 90
		#
		draw_arrowhead 2.17 0.1 90
		draw_arrowhead -2.17 0.1 90
		#
		}
		#
		#
meissner1 0      #
		jrdp2d dump0001
		fieldcalc 0 aphi
		interpsingle aphi 256 256 -2.5 2.5 -2.5 2.5
		readinterp aphi
		#
		define x1label "x"
		define x2label "z"
		plc 0 iaphi
mplot1 0        #
		jre meissner.m
		device postencap ffde_a999.eps
		p2meissner0
		device X11
		#
meissner3 0     #
		#
		gogrmhd
		jrdp2d dump0080
		# gammiegridnew3 gdump
		fieldcalc 0 aphi
                set ergo=r - (1+sqrt(1-(a*cos(h))**2))
		#
                # interpolate
		#
		define sizenx (512)
		define sizeny (512)
		interpsingle aphi $sizenx $sizeny -5 5 -5 5
                interpsingle ergo $sizenx $sizeny -5 5 -5 5
		#
		# get data
		readinterp aphi
                readinterp ergo
		#
                # get plot data
                #
                plc 0 iaphi
                set newaphi=newfun
                plc 0 iergo
                set newergo=newfun
		#
		fdraft
		define POSCONTCOLOR "default"
		define x1label "x"
		define x2label "z"
		plc 0 iaphi 001 -5 5 -5 5
		#
p3meissner0   0  #
		#
                # begin plotting
                #
                plc 0 newaphi
		#
		erase
		#
p4meissner0   0  #
		#
		#
		# device postencap fig4.eps
		#
                fdraft
		#
		#
		#
                define x1label "x"
                define x2label "z"
                #
                define POSCONTCOLOR "default"
                define NEGCONTCOLOR "default"
                ctype default lweight 3 ltype 0
		#
		ticksize 1 2 1 2
		box
		xlabel $x1label
		ylabel $x2label
		define cres 15
                plc 0 newaphi 010
		#
		#
                #
                ctype default lweight 5 ltype 0
                set image[ix,iy]=newergo
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3
		#
		if(1){\
		set Rinold=$rhor*1.00
		# circle
                set t=0,2*pi,.01
                set x=Rinold*sin(t)
                set y=Rinold*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                shade 0 x y
                connect x y
		}
		#
		#
pmeissner4 0    #
		device postencap fig4.eps
		p4meissner0
		device X11
		!scp fig4.eps jon@relativity:
		#
		#
mplot2 0        # what interpsingle used (before readinterp)
                #
                !echo 1 $interptype 1 1 $nx $ny $nz  2.0 0 0  $igrid  $inx $iny $inz  $ixmin $ixmax $iymin $iymax 0 0  $iRin $iRout $iR0 $ihslope $idefcoord
                #
                # 
                # 1 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -20 20 0 0 0.99802 40 0.8 0.3 0
		#
                #
                # for images:
                # 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 -5 5 -5 5 0 0 0.99802 40 0.8 0.3 0
                # ~/bin/iinterpnoextrap <above> < input > output
                #
                # < im0p0s0l0625.r8 > ideal43lrho.r8
                # before doing this, copy coordparms.dat to local dir.
                #
                # full thing for 4/3
                #
                # ~/bin/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > ideal43lrho.r8
                #
                # full thing for 5/3
                #
                # ~/bin/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > ideal53lrho.r8
                #
                # full thing for tm
                #
                # ~/bin/iinterpnoextrap 0 3 1 1 256 256 1 2.0 0 0 0 512 512 1 0 20 -10 10 0 0 1.170236893 40 0 0.3 9 < im0p0s0l0625.r8 > tmlrho.r8
                #
                #
jetplot 0       #
		jrdp2d dump0001
		faraday
                set ergo=r - (1+sqrt(1-(a*cos(h))**2))
		#
		plc 0 omegaf2
		#
		define sizenx (512)
		define sizeny (512)
		define extent (10)
		interpsingle omegaf2 $sizenx $sizeny -$extent $extent -$extent $extent
                interpsingle ergo $sizenx $sizeny -$extent $extent -$extent $extent
		#
		readinterp omegaf2
		readinterp ergo
		#
		plc 0 iomegaf2
		set newomegaf2=newfun
		#
                plc 0 iergo
                set newergo=newfun
		#
jetplot2 0      #
		plc 0 newomegaf2 010
		erase
		#
jetplotplot  0  #
		#omegaf2=E_\theta/B^r
		#
		# device postencap fig5.eps
		#
                fdraft
		#
		#
		#
                define x1label "x"
                define x2label "z"
                #
                define POSCONTCOLOR "default"
                define NEGCONTCOLOR "default"
                ctype default lweight 3 ltype 0
		#
		#ticksize 1 2 1 2
		ticksize 0 0 0 0
		box
		xlabel $x1label
		ylabel $x2label
                #
		ctype default lweight 3 ltype 0
		set image[ix,iy]=newomegaf2
		define maxit (0.4781/2)
		define stepit ($maxit/10)
                set lev=$stepit,$maxit,$stepit levels lev
                lweight 5
                contour
                lweight 3
                #
                ctype default lweight 5 ltype 0
                set image[ix,iy]=newergo
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3
		#
		if(1){\
		set Rinold=$rhor*1.00
		# circle
                set t=0,2*pi,.01
                set x=Rinold*sin(t)
                set y=Rinold*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                shade 0 x y
                connect x y
		}
		#
plotsimple1 0   #
		jrdp2d dump0000
		fieldcalc 0 aphi
		#
		interpsingle aphi 256 256 -2.5 2.5 -2.5 2.5
		readinterp aphi
		#
		plc 0 iaphi
		#
		set Rinold=1.0
		# circle
                set t=0,2*pi,.01
                set x=Rinold*sin(t)
                set y=Rinold*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                shade 0 x y
                connect x y
		#
		#
		#
charge0 1       #
		#/raid2/jmckinne/grmhd999256r0
		# set Bnorm=0.5
		#
		#/home/jondata/gammamax2000_a1/run
		set Bnorm=sqrt(4.022990227)*sqrt(4.0*pi)
		#set Bnorm=sqrt(4.022990227)
		#
		# (above now on /mnt/disk/)
		#
		# /home/jondata/bhc_test/run/
		# (tests Wald charge)
		# must set Bnorm in Gaussian units
		# set Bnorm=sqrt(4.0)*sqrt(4.0*pi)
		#
		jrdp2d dump$1
		faraday
		# Q = 1/(4\pi) \int F^{tr}\detg d\theta d\phi
		# F^{tr} = fuu01
		#
		#set myftr=sqrt(4*pi)*fuu01*gdet*$dx2*2*pi if(ti==0)
		#
		#set myQ=SUM(myftr)/(4*pi)
		#
		# 4*pi accounts for definition of Q
		# sqrt(4\pi) accounts for Gaussian->HL for Gaussian Q
		set dQ=sqrt(4*pi)*fuu01/(4*pi)
		# u here is fuu01 pre-filtered
		#set dQ=sqrt(4*pi)*u/(4*pi)
		#set dQ=u/sqrt(4*pi)
		#
		# commented out below to test Wald charge
		#gcalc2 3 0 pi/2 dQ Qvsr
		gcalc2 6 0 0.955 dQ Qvsr
		#
		#ctype default pl 0 newr Qvsr 1000
		#
		# strength at infinity (sqrt(bsq) at large radius)
		#set Bnorm=2.0
		set Qnorm=Qvsr/(a*2.0*Bnorm)
		set komQnorm=Qvsr/(a*Bnorm)
		#
		location 6000 31000 6000 31000
		#
		define x1label "r c^2/GM"
		define x2label "Q/(2B_0 J)"
		#
		#ctype default pl 0 newr Qnorm 1100
		ctype default pl 0 newr Qnorm 1001 Rin 10 -5 5
		#
		define myrhor (lg($rhor))
		ctype red vertline $myrhor
		#
		set myr=r if(tj==0)
		define iii (0)
		while {$iii<$nx} {
		   if(myr[$iii]>$rhor) {\
		       define myiii ($iii)
		       BREAK
		    }
		    define iii ($iii+1)
		}
		#
		set myQrat=Qnorm[$myiii]
		print {myQrat}
		#
iaphi 1         #
		jrdpcf2d dump$1
		fieldcalc 0 aphi
		interpsingle aphi 256 256 -2.5 2.5 -2.5 2.5
		readinterp aphi
		plc 0 iaphi
		#
		if(1){\
		set Rinold=$rhor*1.00
		# circle
                set t=0,2*pi,.01
                set x=Rinold*sin(t)
                set y=Rinold*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                #shade 0 x y
		connect x y
		}
		#
checkomegaf 0   #
		# /home/jondata/gammamax2000_a1/run_nofilter
		#
		jrdpcf2d dump0005
		faraday
		fieldcalc 0 aphi
		#
		define cres 100
		plc 0 (abs(aphi)**.02) 001 Rin 10 0 pi
		#
		define cres 2
		set omegah=a/(2*$rhor)
		plc 0 (omegaf2/omegah) 011 Rin 10 0 pi
		set lev=0,2,(2-0)/15 levels lev ctype blue contour
		define cres 2
		plc 0 (omegaf2/omegah) 011 Rin 10 0 pi
		#
