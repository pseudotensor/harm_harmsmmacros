2dnoh0 0         #
		#gogrmhd
		#jrdp dump0010
		define coord 1
		#
		define cres 15
		plc 0 rho 001 0 1 0 1
		#
		# device postencap sashaplot.eps
		# box
		set lev=14,17,0.2 levels lev ctype blue contour
		set lev=2.5,4,0.25 levels lev ctype blue contour
		# device X11
		#
2dnoh1 0        #
		set radius=sqrt(r**2+h**2)
		ctype default
		pl 0 radius rho
		#
		erase box points radius rho
		set myfit=16+radius*0
		ctype red plo 0 radius myfit
		#
gresh 0         #
		define coord 1
		set vx=(v1-1E-10)
		set vy=v2
		set sinphi=r/sqrt(r**2+h**2)
		set cosphi=h/sqrt(r**2+h**2)
		set vr=vx*sinphi+vy*cosphi
		set vphi=-vx*cosphi+vy*sinphi
		plc 0 vphi
		#
		#
		define POSCONTCOLOR black
		define NEGCONTCOLOR black
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		plc 0 rho 001 0 1 0 1
		#plc 0 rho
		set lev=0.99,1.01,.002
		levels lev
		ctype cyan contour
		#
mgresh 0        #
		grid3d gdump
		# final
		jrdp dump0010
		#
		plc 0 rho 001 2.5 3.5 -.5 .5
		erase
		#
		#
		device postencap mgresh.eps
		#
		box
		mgreshden
		mgreshvort1 1
		#
		device X11
		#
		#
mgreshden 0     #
		# final moving gresho density
		define coord 1

		#define POSCONTCOLOR black
		#define NEGCONTCOLOR black
		#define BOXCOLOR default
		#define POSCONTLTYPE 0
		#define NEGCONTLTYPE 0
		set lev=0.97,1.03,.006
		levels lev
		ctype cyan contour
		#
mgreshu 0       #
		defaults
		plc 0 u 001 2.5 3.5 -.5 .5
		#
mgreshvort1 1    # final vort
		#
		#
		set vx=v1*sqrt(gv311)
		set vy=v2*sqrt(gv322)
		#
		set tiold=ti
		set tjold=tj
		set ti=ti+6
		set tj=tj+6
		dercalc 0 vx dvx
		dercalc 0 vy dvy
		# vort=curl u = d_j 
		set vort= -dvxy/dxdxp22 + dvyx/dxdxp11
		defaults
		# 001 2.5 3.5 -.5 .5
		# final
		if($1==0){\
		       plc 0 vort 001 2.5 3.5 -.5 .5
		    }
		#
		if($1==1){\
		       plc 0 vort 011 2.5 3.5 -.5 .5
		    }
		#
		set ti=tiold
		set tj=tjold
		#
mgreshvort0 0    # initial vort
		#
		grid3d gdump
		# final
		jrdp dump0000
		#
		set vx=v1*sqrt(gv311)
		set vy=v2*sqrt(gv322)
		#
		set tiold=ti
		set tjold=tj
		set ti=ti+6
		set tj=tj+6
		dercalc 0 vx dvx
		dercalc 0 vy dvy
		# vort=curl u = d_j 
		set vort= -dvxy/dxdxp22 + dvyx/dxdxp11
		defaults
		# initial
		plc 0 vort 001 -0.5 0.5 -.5 .5
		#
		set ti=tiold
		set tj=tjold
		#
explosion 0    #
		define coord 1
		define POSCONTCOLOR black
		define NEGCONTCOLOR black
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		plc 0 rho 001 0 1.5 0 1.5
		#plc 0 rho
		set lev=0.08,0.21,.005
		levels lev
		ctype cyan contour
		#
		#
checkweights0 0 #
		#
		define nx 100
		define ny 1
		#
		da 0_fail.out
		lines 1 1000000
		read '%d %d %d %d %g %g %g %g\n' {pl myi myn sp w2 w1 w0 rho}
		#
		set then=2
		set thepl=0
		#
		set iw=myi if((myn==then)&&(pl==thepl))
		set nn=myn if((myn==then)&&(pl==thepl))
		set ww2=w2 if((myn==then)&&(pl==thepl))
		set ww1=w1 if((myn==then)&&(pl==thepl))
		set ww0=w0 if((myn==then)&&(pl==thepl))
		set wrho=rho if((myn==then)&&(pl==thepl))
		#
		set r=iw
		#
		#jrdp dump0001
		set myrho=(wrho-1.0)
		ctype default pl 0 iw myrho 0001 30 70 -.1 1.1 points iw myrho
		ctype red pl 0 iw ww2 0010
		points iw ww2
		ctype yellow pl 0 iw ww1 0010
		points iw ww1
		ctype green pl 0 iw ww0 0010
		points iw ww0
		#
		#
		#
checkwlr 0      #
		#
		set rholeft=wrho-1.4
		set rhoright=wrho-1.0
		print '%d %21.15g %21.15g\n' {iw rholeft rhoright}
		#
		#
		jrdp dump0002
		pl 0 r rho
		set symit=rho-1.2
		asym1d symit
		#
amgreshgplc 17	# animplc 'dump' r 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		#set constlevelshit=0
		#
                define coord 1
                grid3d gdump
                #
                #
                do iiii=startanim,endanim,$ANIMSKIP {
		  set h2=sprintf('%04d',$iiii) set _fname=h1+h2
                  define filename (_fname)
		  #jrdp2d $filename
		  #define coord 1
                  jrdp3du $filename
                  #fieldcalc 0 aphi
		  #jre mode2.m
		  #alfvenvp
		  #interpsingle aphi 128 128 -2.5 2.5 -2.5 2.5
		  #readinterp aphi
		  #define CONSTLEVELS 1
		  #faraday
		  #device postencap $filename.$ii
                    #
                    #mgreshvort1 0
                    mgreshvorttrack $iiii
                    #
                    #
                    #
		  #device X11
		  # show zero contours
		  #if(1){\
		  #       set lev=-1E-15,1E-15,2E-15
		  #       levels lev
		  #       ctype blue contour
		  #    }
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
		#
		# animate pls in HARM
mgreshvorttrack 1 # track vort
		#
		#
		set vx=v1*sqrt(gv311)
		set vy=v2*sqrt(gv322)
		#
		set tiold=ti
		set tjold=tj
		set ti=ti+6
		set tj=tj+6
		dercalc 0 vx dvx
		dercalc 0 vy dvy
		# vort=curl u = d_j 
		set vort= -dvxy/dxdxp22 + dvyx/dxdxp11
		#defaults
		# 
                define start1 ((2.5+0.5)/10*$1 - 0.5)
                define start2 ((3.5-0.5)/10*$1 + 0.5)
                define start3 (-0.5)
                define start4 (0.5)
		# 
		#plc 0 vort 001 -0.5 0.5 -.5 .5
                plc 0 vort 001 $start1 $start2 $start3 $start4
		set ti=tiold
		set tj=tjold
		#
