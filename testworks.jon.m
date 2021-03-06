computeffstress 0   #
                    jre trans1.m
                    mkstofluid b fluidb
		    #
		    set blgv311 = (blgv311<0) ? 0.0 : blgv311
                    #
                    #
                    # define T^mu_nu components
                    #
                    #
                    # calculate stress-energy tensor in BL coordinates
                    #
    		    DO it = 0,3, 1 { 
                        DO jt = 0,3,1 { 
		         set tud"$!it""$!jt" = (rho+u+p+bsq)*boostuu"$!it" * boostud"$!jt" -blbu"$!it" * blbd"$!jt"

			   # set tud"$!it""$!jt" =  -bu"$!it" * bd"$!jt"
			  
			 # set tud"$!it""$!jt" =  (rho+u+p)*uu"$!it" * ud"$!jt"
			}
                    }
		    #
		    #
                    # calculate area elements and mdot
                    #
                    set use=0, $nx*$ny*$nz-1,1
                    set use=use*0
                    set area=0, $nx-1, 1
                    set area=area*0
		    #
                    # 
                    # calculate area element in BL
                    #
		    set dr=dxdxp11*$dx1
                    set dph=dxdxp33*$dx3
		    #
                    set blgdet=r**2*sin(h)
                    set bla=dh*dph
		    #
		    # new validpoint
		    set validpoint = (abs(h-pi/2)<0.2 && (rho+u+p+bsq)/rho*ud0>-1)
		    #
		    # old validpoint
		    # set validpoint = (abs(h-pi/2)<0.2)
		    #
		    # LDOT/MDOT AT HORIZON (should be constant for all time):
		    set LDOTOMDOT=3.37
		    # MDOT @ HORIZON
		    # REALLY SHOULD CHOOSE NUMBER CONSTANT FOR ALL TIME:
		    #
		    # temp choices:
		    #define it (54)
		    define it (0)
		    #
		    set use=(ti==$it && validpoint==1)?1:0
		    #
		    set mdothor=SUM(rho*boostuu1*blgdet*bla*use)
		    set ldothor=SUM(tud13*blgdet*bla*use)
		    set lspechor = ldothor/mdothor
		    print {mdothor ldothor lspechor}
		    #
		    set LDOTOMDOT=lspechor
		    #
                    set mymdot=area*0
                    set myldot=mymdot*0
                    set nomdotmymdot=area*0
                    set mypress=mymdot*0
                    #
		    #
		    DO it=0, $nx-1,1 {		
		      set use=(ti==$it && validpoint==1)?1:0
		      set area[$it]=SUM(blgdet*bla*use)
                        #set mymdot[$it]=SUM(rho*boostuu1*blgdet*bla*use*sqrt(blgv311))
                        set mymdot[$it]=SUM(rho*boostuu1*blgdet*bla*use)
                        set myldot[$it]=SUM(tud13*blgdet*bla*use)
		        # below has \rho u^r term removed
                        set nomdotmymdot[$it]=SUM(1.0*blgdet*bla*use)
                      set mypress[$it]=SUM(ptot*blgdet*bla*use)
		    }
		    #
                    set mymdotavg=mymdot/area
                    set myldotavg=myldot/area
		    #
		    # normal Mdot @ horizon but divided by each shell's radius
		    set mymdotavghor=mdothor/area
		    #
		    # If mdothor removed, then remaining term is 1/area for the "mymdot" like term
		    set nomdotmymdotavg=nomdotmymdot/area
		    #
                    set mypressavg=mypress/area
		    #
                    set mytudfinal=rho*0
                    set mytudfinalchop=rho*0
                    set mytudfinalresid=rho*0
                    #
                    # boosting
                    #
                    DO it=0,3 {
		       DO jt=0,3{
		          set subfinal=tud"$!it""$!jt" * lamud1"$!it"*lamdu3"$!jt"
		          set mytudfinal=mytudfinal+subfinal
		          if(!($it==1 && $jt==3)){ set mytudfinalchop=mytudfinalchop+subfinal }
		          #
		          # below is without T^r_\phi term, just raw boost term
		          set subfinalresid= lamud1"$!it"*lamdu3"$!jt"
		          if($it==1 && $jt==3){ set mytudfinalresid=mytudfinalresid+subfinalresid }
                       }
                    }
		    #
		    set myffstress=0,$nx-1,1
                    set myffstress=myffstress*0                  
		    set myffalpha=0,$nx-1,1
                    set myffalpha=myffalpha*0                  
                    #
		    set myffstresschop=0,$nx-1,1
                    set myffstresschop=myffstresschop*0                  
		    set myffstressresid=0,$nx-1,1
                    set myffstressresid=myffstressresid*0                  
		    set myffalphachop=0,$nx-1,1
                    set myffalphachop=myffalphachop*0
		    set myffalpharesid=0,$nx-1,1
                    set myffalpharesid=myffalpharesid*0
		    #
		    DO  i=0,$nx-1 {		
			set use= (ti == $i && validpoint) ? 1:0
		        #
		        set dVortho=blgdet*use*bla*sqrt(blgv311)/sqrt(blgv333)
		        #
                        set substress=mytudfinal*dVortho
                        set myffstress[$i]= SUM(substress)
                        set myffalpha[$i]= SUM(substress/ptot)
		        #
                        set substresschop=mytudfinalchop*dVortho
                        set myffstresschop[$i]= SUM(substresschop)
                        set myffalphachop[$i]= SUM(substresschop/ptot)
		        #
                        set substressresid=mytudfinalresid*dVortho
                        set myffstressresid[$i]= SUM(substressresid)
                        set myffalpharesid[$i]= SUM(substressresid/ptot)
                    }
                    #
		    set myffstressorig=myffstress
		    set myffalphaorig=myffalpha
		    set myffstresschoporig=myffstresschop
		    set myffalphachoporig=myffalphachop
		    set myffstressresidorig=myffstressresid
		    set myffalpharesidorig=myffalpharesid
		    #
		    #
                    set myffstress= myffstressorig/area/mymdotavg
                    set myffstresshor= myffstressorig/area/mymdotavghor
                    set myffalpha= myffalphaorig/area
		    #
                    #
                    set myffstresschop= myffstresschoporig/area/mymdotavg
                    set myffstresschophor= myffstresschoporig/area/mymdotavghor
                    set myffalphachop= myffalphachoporig/area
		    #
		    # resid has no mdot term in bottom, so now lost Ldot/Mdot compared to normal or chop terms
                    set myffstressresid= myffstressresidorig/area/nomdotmymdotavg
                    set myffalpharesid= myffalpharesidorig/area/nomdotmymdotavg
		    #
		    #
		    #set mydxdxp11=dxdxp11 if (tj==15 && tk==0)
		    #set mydxdxp33=dxdxp33 if (tj==15 && tk==0)
		    #
                    set myblgv311=blgv311 if (tj==15 && tk==0)
                    set myblgv333=blgv311 if (tj==15 && tk==0)
		    #
		    set myr=r if (tj==0 && tk==0)
		    #
		    computentstress
		    #
		    # compute normal stress
		    set fmyffstress=myffstress/(2*pi*myr)
		    set fmyffstresshor=myffstresshor/(2*pi*myr)
		    #
		    # compute chop + residual term for Ramesh-like stress calculation
		    set fmyffstressramesh=(myffstresschop + myffstressresid*LDOTOMDOT)/(2*pi*myr)
		    set fmyffstressrameshhor=(myffstresschophor + myffstressresid*LDOTOMDOT)/(2*pi*myr)
		    #
		    # Ramesh-like for \alpha
		    # Turn <Trp/P> into <Trp/P not from T^r_\phi/P> + residual
		    # where residual lost T^r_\phi, so replaced by (Ldot/Mdot)*<Mdot> \sim T^r_\phi
		    # Ldot/Mdot * Mdot = Ldot that replaces
		    set residalpha=(myffalpharesid*LDOTOMDOT*mymdotavghor)
		    set fmyffalpharamesh=(myffalphachop + residalpha)
		    #
		    #
computentstress 0   #
                    #
		    input nt.txt
		    #
		    set bb=1
		    set cc=1-3/x
		    set dd=1-2/x
		    set myntstress=stress/(x*bb*cc**(-0.5)*dd)
		    #
		    #
plotstress 0    #
		#
		#
		#
		ctype default
		pl 0 myr (-fmyffstresshor) 1001 2 20 1E-5 1E-2
		#
		#ctype yellow
		#pl 0 myr (-fmyffstress) 1011 2 20 1E-5 1E-3
		#
		#ctype red
		#pl 0 myr (-fmyffstressramesh) 1011 2 20 1E-5 1E-3
		#
		#ctype cyan
		#pl 0 myr (-fmyffstressrameshhor) 1011 2 20 1E-5 1E-3
		#
		#
		ctype blue
		pl 0 x myntstress 1011 2 20 1E-5 1E-3  
		#pl 0 myr myffstress 1111 2 20 1E-5 1
		#
		# print {myr fmyffstress fmyffstresshor fmyffstressramesh fmyffstressrameshhor}
		#
plotalpha 0     #
		#
		#
		ctype default
		pl 0 myr myffalpha 1001 2 40 0 1
		#
		#ctype red
		#pl 0 myr fmyffalpharamesh 1011 2 40 0 1
		#
		#ctype blue
		#pl 0 myr myffalphachop 1011 2 40 0 1
		#
		#ctype cyan
		#pl 0 myr residalpha  1011 2 40 0 1
		#
		#
ldotmdotcheck 0 #
		#
		ctype default
		pl 0 myr mymdot 1000
		#
		ctype red
		pl 0 myr myldot 1000
		#
		ctype blue
		pl 0 myr (myldot/mymdot) 1001 Rin Rout -1 4
		#
residcheck 0    #
		#
		ctype default
		setlimits Rin Rout (pi/2-0.1) (pi/2+0.1) 0 1 plflim 0 x1 r h tud13 0 100
		set resid=myffalpharesid*LDOTOMDOT*mymdotavghor
		ctype red pl 0 myr resid 1010
		#
		#
fortran2smplot 0 #
		#
		# gogrmhd
		#
		#da test7.137_197.dat
		#da test7.161_197.dat
		# da test7.137_160.dat
		#
		# with quant5 as well:
		#da test7.137_197_new.dat
                #
                # da test7.137_197_new.kepforced.dat
                #
                # final one:
		#da jontest7.dat
		#
                da jontestuu17.dat
                #
                #
		read   r 1
		read quant1 2
		read quant2 3
		read quant3 4
		read quant4 5
		read quant5 6
		read alpha 7
                read omega3 8
                read mdot 9
                read ldot 10
                read ptot 11
                read quantfinal 12
                read ellinmatt 13
                read emdot 14
                read linmatt 15
                read linmattrat 16
                read ralabstress 17
                read raffstress 18
                read avuu1fl 19
		#
		pl 0 r alpha 1101 2 20 1E-2 10
                #
                ctype red pl 0 r omega3 1101 2 20 1E-2 1
                ctype blue pl 0 r (r**(-3/2)) 1111 2 20 1E-2 1
		#
                # Mdot
                pl 0 r mdot 1101 2 20 1E-2 1
                #
                # Ldot
                pl 0 r ldot 1101 2 20 1E-2 1
                #
                #
                # Ldot/Mdot
                pl 0 r (ldot/mdot) 1001 2 20 1E-1 10 
                #
		input nt.txt
		#
		set bb=1
		set cc=1-3/x
		set dd=1-2/x
		#
		set xl=lg(x)
		set myntstress=stress/(x*bb*cc**(-0.5)*dd)
		#
		set myr=r
		set rl=lg(r)
		#
                # seems to be now like linmatt in Ramesh calculation
                ctype default
                pl 0 r (ellinmatt/emdot) 1001 2 20 0 10 
                ctype red
                pl 0 r (linmatt/emdot) 1011 2 20 0 10 
                #
		set stress1=quant1/(2*pi*myr)
		set stress2=quant2/(2*pi*myr)
		set stress3=quant3/(2*pi*myr)
		set stress4=quant4/(2*pi*myr)
		set stress5=quant5/(2*pi*myr)
                set finalstress=quantfinal/(2*pi*myr)
                #
                #
                set bb=1
                set cc= 1- 3/r
                set dd= 1-2/r
                set mylabstress1= (3.37-linmatt/emdot)/(2*3.14159*r)
                set mylabstress2= (3.37-ellinmatt/emdot)/(2*3.14159*r)
                set myffstress1=-mylabstress1*cc**0.5/(r*bb*dd)
                set myffstress2=-mylabstress2*cc**0.5/(r*bb*dd)
                #
                ctype default pl 0 myr myffstress1 1001 2 20 1E-4 1E-3
                ctype red pl 0 myr myffstress2 1011 2 20 1E-4 1E-3
                ctype blue pl 0 myr (raffstress/2/pi/r) 1011 2 20 1E-4 1E-3
                #
                set superstress=(r<11) ? (-stress4) : ((raffstress/2/pi/r))
		#
		ctype default
		pl 0 myr (-stress1) 1001 2 20 1E-04 1E-3
		ctype red
		pl 0 myr (-stress2) 1011 2 20 1E-04 1E-3
		ctype blue
		pl 0 myr (-stress3) 1011 2 20 1E-04 1E-3
		ctype magenta
		pl 0 myr (-stress4) 1011 2 20 1E-04 1E-3
                lweight 6
		ctype cyan
		pl 0 myr (superstress) 1011 2 20 1E-04 1E-3
                lweight 3
		ctype green
		pl 0 x myntstress 1011 2 20 1E-4 1E-3
		#
finalplots 0    #
		erase
		location 6000 30000 6000 30000
		ltype 0
		lweight 3
		expand 1.5
		ctype default
		#
		device postencap alphajon.eps
		#
		define lin (LG(2))
		define lout (LG(20))
		limits $lin $lout 0 1
		ticksize -1 -5 0.1 0.5
		erase
		ctype default
		box
		define x1label "r/M"
		define x2label "\alpha"
		xlabel $x1label
		ylabel $x2label
		relocate 0.77815 3
		ltype 1
		draw 0.77815 5
		ltype 0
		lweight 5
		connect rl alpha
                #connect rl (r*alpha)
		#
		lweight 3
		ltype 1
		set myx=0,1,1
		set myx=LG(6)+myx*1E-5
		set myy=0,1,1
		set myy[0]=-1000
		set myy[1]=1000
		connect myx myy
		#
		device X11
		#
		#
		device postencap stressjon.eps
		#
		define lin (LG(2))
		define lout (LG(20))
		limits $lin $lout 0 1
		#limits $lin $lout 0 0.0008
		#ticksize -1 -5 0.00005 0.0004
		ticksize -1 -5 0.1 0.5
		erase
		ltype 0
		lweight 3
		ctype default
		box
                #
                ltype 0
                relocate 0.436738 0.66475
                putlabel 5 "\alpha"
                #
		define x1label "r/M"
		#define x2label "10^3 W/\dot{M}_{\rm horizon}\ \ \ \ \ \ \alpha"
                define x2label "10^3 W/\dot{M}_{\rm horizon}"
		xlabel $x1label
		ylabel $x2label
		#pl 0 myr (-stress4) 1001 2 15 1E-04 1E-3
		ltype 0
		lweight 5
		#connect rl (-stress4*1E3)
                connect rl (superstress*1E3)
                #
                ltype 4
                connect rl alpha
                #
                #
                #
		#
		ltype 2
		lweight 5
		#pl 0 x myntstress 1011 2 15 1E-4 1E-3
		connect xl (myntstress*1E3)
		#
		lweight 3
		ltype 1
		set myx=0,1,1
		set myx=LG(6)+myx*1E-5
		set myy=0,1,1
		set myy[0]=-1000
		set myy[1]=1000
		connect myx myy
		#
		device X11
		#
		#
		#
finalplots2 0   # 2-panel plot
                #
		#
		erase
                #
		device postencap stressalphajon.eps
                #
		location 6000 30000 6000 30000
		ltype 0
		lweight 3
		expand 1.5
		ctype default
                window 1 1 1 1
		#
		#
                #
                #
		define lin (LG(2))
		define lout (LG(20))
		limits $lin $lout 0 0.7
		#limits $lin $lout 0 1.0
		ticksize -1 -5 0.1 0.5
                #
                define x_gutter 0.0
                define y_gutter 0.0
                window 1 3 1 3 box 0 2 0 0
                #
		ctype default
		#define x1label "r/M"
		define x2label "\alpha"
		#xlabel $x1label
		ylabel $x2label
		relocate 0.77815 3
		ltype 1
		draw 0.77815 5
		ltype 0
		lweight 5
		connect rl alpha
                #connect rl (r*alpha)
		#
		lweight 3
		ltype 1
		set myx=0,1,1
		set myx=LG(6)+myx*1E-5
		set myy=0,1,1
		set myy[0]=-1000
		set myy[1]=1000
		connect myx myy
		#
		#
		define lin (LG(2))
		define lout (LG(20))
		#limits $lin $lout 0 0.7
		limits $lin $lout 0 0.9
		#limits $lin $lout 0 0.0008
		#ticksize -1 -5 0.00005 0.0004
		ticksize -1 -5 0.1 0.5
                define x_gutter 0.3
                window 1 3 1 1:2 box 1 2 0 0
		ltype 0
		lweight 3
		ctype default
		box
                #
		define x1label "r/M"
		#define x2label "10^3 W/\dot{M}_{\rm horizon}\ \ \ \ \ \ \alpha"
		#define x2label "10^3 W/\dot{M}_{\rm horizon}"
		define x2label "Shear Stress"
		xlabel $x1label
		ylabel $x2label
		#pl 0 myr (-stress4) 1001 2 15 1E-04 1E-3
		ltype 0
		lweight 5
		#connect rl (-stress4*1E3)
                connect rl (superstress*1E3)
                #
                #
		#
		ltype 2
		lweight 5
		#pl 0 x myntstress 1011 2 15 1E-4 1E-3
		connect xl (myntstress*1E3)
		#
		lweight 3
		ltype 1
		set myx=0,1,1
		set myx=LG(6)+myx*1E-5
		set myy=0,1,1
		set myy[0]=-1000
		set myy[1]=1000
		connect myx myy
		#
                #
                #
		device X11
		#
		#
		#
