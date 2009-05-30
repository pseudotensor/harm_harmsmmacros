ramsol 0        #
		#
		macro read "/usr/local/lib/sm/macro/irregular"
		da nu.75_m.5.txt
		lines 1 1
		read '%g %g %g %g' {nu5 m5 s5 ucrit5}
		print {nu5 m5 s5 ucrit5}
		lines 2 1000000
		read '%g %g %g' {u5 Tu5 Tpu5}
		#
		da nu.75_m.05.txt
		lines 1 1
		read '%g %g %g %g' {nu05 m05 s05 ucrit05}
		print {nu05 m05 s05 ucrit05}
		lines 2 1000000
		read '%g %g %g' {u05 Tu05 Tpu05}
		#
		da nu.75_m.005.txt
		lines 1 1
		read '%g %g %g %g' {nu005 m005 s005 ucrit005}
		print {nu005 m005 s005 ucrit005}
		lines 2 1000000
		read '%g %g %g' {u005 Tu005 Tpu005}
		#
		da nu.75_m.0005.txt
		lines 1 1
		read '%g %g %g %g' {nu0005 m0005 s0005 ucrit0005}
		print {nu0005 m0005 s0005 ucrit0005}
		lines 2 1000000
		read '%g %g %g' {u0005 Tu0005 Tpu0005}
		#
		#set myr=r if(tj==$ny/2)
		#set myh=h if(ti==0)
		#set R=r*sin(h) if(tj==$ny/2)
		#set Z=r*cos(h) if(ti==0)
		#set ZoR = Z/R
		#
		#
		#
		define x1label "[tan(\theta)]^{-1}=z/R"
		define x2label "T(u)"
		#
		#set aphiuse=((R>100)&&(abs(th-pi/2)<pi/2*0.99)) ? 1 : 0
		set aphiuse=R*0+1
		fieldcalc 0 aphi
		set myaphi=aphi/R**(nu5) if(aphiuse)
		set zoR=Z/R if(aphiuse)
		#
		ctype default
		pl 0 zoR myaphi 0101 -100 100 1E-15 10
		points zoR (LG(myaphi))
		#
		#
		set thbz=(th<pi/2) ? th : (pi-th)
		set rampara=rspc*(1-cos(thbz))
		set newrampara=rampara/R if(aphiuse)
		ctype red
		pl 0 zoR newrampara 0111 -100 100 1E-15 10
		#
		#
		#interp 
		#
		ltype 0 ctype blue
		pl 0 u5 Tu5 0111 -100 100 1E-15 10
		#
		ltype 1 ctype blue
		pl 0 u05 Tu05 0111 -100 100 1E-15 10
		#
		ltype 2 ctype blue
		pl 0 u005 Tu005 0111 -100 100 1E-15 10
		#
		ltype 3 ctype blue
		pl 0 u0005 Tu0005 0111 -100 100 1E-15 10
		#
setupinterp 0   #
		#
		# CYL
		define coord 1
		#
		# SPC
		#define coord 3
		#
		#
		if($coord==3){\
		       set Z=r*cos(h)
		       set R=r*sin(h)
		       set th=h
		       set rspc=r
		}
		#
		if($coord==1){\
		       set Z=h
		       set R=r
		       set th=atan(R/Z)
		       set rspc=R/sin(th)
		}
		#
		set theu=Z/R
		#
		set innerradius=Rin
		set myrin=innerradius
		#set innerradius=$rhor
		#set innerradius=3
		set outerradius=Rout
		set myrout=outerradius
		if($coord==3){\
		       set thin=0
		       set thout=pi
		    }
		if($coord==1){\
		       set thin=-Rout
		       set thout=Rout
		    }
		#
		#
		#set Tu=Tu5
		#set u=u5
		#
		#
rameshinterp0 0 # stupid slow way of interpolation, but doesn't assume increasing vs. decreasing or monotonic function
		#
		do ii=0,$nx-1,1 {\
		  do jj=0,$ny-1,1 {\
		     set interpuse=((ti==$ii)&&(tj==$jj)) ? 1 : 0
		     set myu=theu if(interpuse)
		     set myR=R if(interpuse)
		     set myZ=Z if(interpuse)
		     #
		     echo $ii of $nx and $jj of $ny
		     set didget=0
		     #
		     if(myu>=0){
		        set godu=u
		     }
		     if(myu<0){
		        set godu=-u
		     }
		     #
		     if(0){\
 		      do kk=0,dimen(Tu)-1,1 {\
		        if((didget==0)&&(godu[$kk]>myu)) {\
                          set myTu=Tu[$kk-1]+(Tu[$kk]-Tu[$kk-1])/(godu[$kk]-godu[$kk-1])*(myu-godu[$kk-1])
		          set rameshaphi[$ii+$jj*$nx]=myR**(nu5)*myTu
		          set didget=1
		        }
		      }
		     }
		     if(myu<0){
 		      do kk=0,dimen(Tu)-1,1 {\
		        if((didget==0)&&(godu[$kk]<myu)) {\
                          set myTu=Tu[$kk-1]+(Tu[$kk]-Tu[$kk-1])/(godu[$kk]- godu[$kk-1])*(myu-godu[$kk-1])
		          set rameshaphi[$ii+$jj*$nx]=myR**(nu5)*myTu
		          set didget=1
		        }
		      }
		     }
		     if(didget==0) { echo Didn't get at $ii $jj }
		    }
		   }
		  }
		  #
		  print ramesh5.dat '%21.15g %21.15g %21.15g %21.15g\n' {Z R theu rameshaphi}
		  #
rameshinterp1 1 # fast way of interpolation, data must be monotonic and increasing
		  #
		set rameshTu$1=Z*0
		set rameshTpu$1=Z*0
		set rameshaphi$1=Z*0
		set rameshBR$1=Z*0
		set rameshBZ$1=Z*0
		set rameshBP$1=Z*0
		#
		do jj=0,$ny-1,1 {\
		     set interpuse=(tj==$jj) ? 1 : 0
		     set myu=theu if(interpuse)
		     set myR=R if(interpuse)
		     set myZ=Z if(interpuse)
		     #
		     echo $jj of $ny
		     #
		     if(myZ[0]>0){
		        set mygodu=myu
		     }
		     if(myZ[0]<0){
		        set mygodu=-myu
		     }
		     #print {myu myR myZ godu Tu}
		     #
		     #interp2 u$1 Tu$1 mygodu myTu
		     #interp2 u$1 Tpu$1 mygodu myTpu
		     spline u$1 Tu$1 mygodu myTu
		     spline u$1 Tpu$1 mygodu myTpu
		     #
		     ctype default pl 0 u$1 Tu$1 0100
		     ctype red pl 0 mygodu myTu 0110
		     #!sleep 0.01s
		     #
		     do ii=0,$nx-1,1 {
		        set rameshTu$1[$ii+$jj*$nx]=myTu[$ii]
		        set rameshTpu$1[$ii+$jj*$nx]=myTpu[$ii]
		        set rameshaphi$1[$ii+$jj*$nx]=myR[$ii]**(nu$1)*myTu[$ii]
		        set rameshBR$1[$ii+$jj*$nx]=-myR[$ii]**(nu$1-2)*myTpu[$ii]
		        set rameshBZ$1[$ii+$jj*$nx]=myR[$ii]**(nu$1-2)*(nu$1*myTu[$ii]-mygodu[$ii]*myTpu[$ii])
		        set rameshBP$1[$ii+$jj*$nx]=-nu$1*s$1*myR[$ii]**(nu$1-2)*myTu[$ii]**(nu$1-1)/nu$1
		     }
		  }
		  #
		  #
		  #
interp2example 0  #
		  #
		  set xold={0 1 2 3 4 5}
		  set yold=sin(xold)
		  set xin={0.5 1.5 2.5 3.5 4.5 5.5}
		  interp2 xold yold xin yout
		  ctype default pl 0 xold yold
		  ctype red plo 0 xin yout
		  #
doallrinterp 0    #
		jrdpcf2d dump0000
		gammiegridnew3 gdump
		faraday
		fieldcalc 0 aphi
		#ramfield
		#
		setupinterp
		ramsol
		rameshinterp1 5
		rameshinterp1 05
		rameshinterp1 005
		rameshinterp1 0005
		#
plotallr0    0  #
		#
		set myrin=50
		set myrout=500
		if($coord==3){\
		       set mythin=0
		       set mythout=pi
		    }
		if($coord==1){\
		       set mythin=-myrout
		       set mythout=myrout
		    }
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		#define POSCONTCOLOR "black"
		#define NEGCONTCOLOR "black"
		define BOXCOLOR "default"
		define x1label "r c^2/GM"
		define x2label "\theta"
		plc 0 aphi 001 myrin myrout mythin mythout
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "red"
		plc 0 rameshaphi5 011 myrin myrout mythin mythout
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "blue"
		plc 0 rameshaphi05 011 myrin myrout mythin mythout
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "yellow"
		plc 0 rameshaphi005 011 myrin myrout mythin mythout
		define POSCONTCOLOR "green"
		define NEGCONTCOLOR "green"
		plc 0 rameshaphi0005 011 myrin myrout mythin mythout
		#
plotallr1   0   #
		interpsingle aphi 256 256 500 500
		interpsingle rameshaphi5 256 256 500 500
		interpsingle rameshaphi05 256 256 500 500
		interpsingle rameshaphi005 256 256 500 500
		interpsingle rameshaphi0005 256 256 500 500
		#
		readinterp aphi
		readinterp rameshaphi5
		readinterp rameshaphi05
		readinterp rameshaphi005
		readinterp rameshaphi0005
		#
		replotallr1
		#
		#
replotallr1 0   #
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define x1label "R c^2/GM"
		define x2label "Z c^2/GM"
		define cres 20
		set godiaphi=iaphi
		plc 0 godiaphi
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "red"
		#plc 0 irameshaphi5 010
		define cres 18
		define mymin (10)
		define mymax (150)
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		set image[ix,iy]=irameshaphi5
		ctype $POSCONTCOLOR
		contour
		#
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "blue"
		#plc 0 irameshaphi05 010
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		set image[ix,iy]=irameshaphi05
		ctype $POSCONTCOLOR
		contour
		#
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "yellow"
		#plc 0 irameshaphi005 010
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		set image[ix,iy]=irameshaphi005
		ctype $POSCONTCOLOR
		contour
		#
		define POSCONTCOLOR "green"
		define NEGCONTCOLOR "green"
		#plc 0 irameshaphi0005 010
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		set image[ix,iy]=irameshaphi0005
		ctype $POSCONTCOLOR
		contour
		#
otherramesh1  0 #
		set god=rameshBZ0005*r**(5/4)
		plc 0 god
		#
		set god=rameshBZ5*r**(5/4)
		plc 0 god
		#
checkdata0  0   #
		set godii=0,dimen(u5)-1,1
		der godii u5 dgodii du5
		set godii=0,dimen(u05)-1,1
		der godii u05 dgodii du05
		set godii=0,dimen(u005)-1,1
		der godii u005 dgodii du005
		set godii=0,dimen(u0005)-1,1
		der godii u0005 dgodii du0005
		#
		print {u5 du5 u05 du05 u005 du005 u0005 du0005}
		#
fieldcheck99 0  #
		# gammiegridnew3 gdump
		#
		set myrin=Rin
		set myrout=Rout
		#set thin=(pi/2*0.999)
		#set thout=(pi/2*1.001)
		set thin=-0.01*Rin
		set thout=0.01*Rin
		#
		jrdpcf2d dump0000
		#
		ctype default
		set myB1=abs(B1*sqrt(gv311))
		setlimits myrin myrout thin thout 0 1 plflim 0 x1 r h myB1 0 110
		#
		set myfit=newfun[0]*(newx/newx[0])**(-5/4)
		ctype red pl 0 newx myfit 1110
		#
		jrdpcf2d dump0002
		#
		ctype blue
		set myB1=abs(B1*sqrt(gv311))
		setlimits myrin myrout thin thout 0 1 plflim 0 x1 r h myB1 0 111
		#
		jrdpcf2d dump0020
		#
		ctype cyan
		set myB1=abs(B1*sqrt(gv311))
		setlimits myrin myrout thin thout 0 1 plflim 0 x1 r h myB1 0 111
		#
checkrot0 0     #
		gammiegridnew3 gdump
		#
		set V3=uu3*sqrt(gv333)/uu0
		#
		set vf=omegaf2*sqrt(gv333)
		#
checku0  0      #
		#
		set myrin=Rin
		set myrout=Rout
		if($coord==3){\
		       set mythin=0
		       set mythout=pi
		    }
		if($coord==1){\
		       set mythin=-myrout
		       set mythout=myrout
		    }
		#
		#
		#
		# from jrdpcf2d dump9997
		# set omegaf2=u
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		plc 0 lights 001 myrin myrout mythin mythout
		set mylights=newfun
		#
		plc 0 V 001 myrin myrout mythin mythout
		set myV=newfun
		#
		fieldcalc 0 aphi
		plc 0 aphi 001 myrin myrout mythin mythout
		#
		plc 0 theu 011 myrin myrout mythin mythout
		#
		define min (ucrit5*0.999)
		define max (ucrit5*1.0001)
		set lev=$min,$max,($max-$min)/2
		levels lev ctype blue contour
		set lev=-$max,-$min,(-$min+$max)/2
		levels lev ctype blue contour
		#
		define min (ucrit05*0.999)
		define max (ucrit05*1.0001)
		set lev=$min,$max,($max-$min)/2
		levels lev ctype green contour
		set lev=-$max,-$min,(-$min+$max)/2
		levels lev ctype green contour
		#
		define min (ucrit005*0.999)
		define max (ucrit005*1.0001)
		set lev=$min,$max,($max-$min)/2
		levels lev ctype yellow contour
		set lev=-$max,-$min,(-$min+$max)/2
		levels lev ctype yellow contour
		#
		define min (ucrit0005*0.999)
		define max (ucrit0005*1.0001)
		set lev=$min,$max,($max-$min)/2
		levels lev ctype magenta contour
		set lev=-$max,-$min,(-$min+$max)/2
		levels lev ctype magenta contour
		#
		set image[ix,iy]=mylights
		set lev=-1E-15,1E-15,2E-15
		lweight 5 levels lev ctype cyan contour
		lweight 3
		#
		set image[ix,iy]=myV
		set lev=1-1E-15,1+1E-15,2E-15
		lweight 5 levels lev ctype red contour
		lweight 3
		#
checkwf2 0      #
		#
		#set R=r
		# test
		#set trueomegaf2=0.5*( R**0.75 * 1E-8)**(-1/.75)
		#
		#set crapwf=omegaf2*R
		#plc 0 crapwf
		#
		#
		set myBR=B1*sqrt(gv311)
		set myBZ=B2*sqrt(gv322)
		set myBP=B3*sqrt(gv333)
		#
		set testaphi5=R**nu5*rameshTu5
		set rameshomegaf=m5*(rameshaphi5/Tu5[0])**(-1/nu5)
		# orthonormal basis
		set rameshBR=-R**(nu5-2) * rameshTpu5
		set rameshBR=(Z>0) ? rameshBR : -rameshBR
		set rameshBZ=R**(nu5-2)*(nu5*rameshTu5-abs(Z/R)*rameshTpu5)
		set rameshBP=-nu5*s5*R**(nu5-2)*rameshTu5**( (nu5-1)/nu5 )
		set rameshBP=(Z>0) ? rameshBP : -rameshBP
		#
		set diffBR=((myBR-rameshBR)/(myBR+rameshBR))
		set diffBZ=((myBZ-rameshBZ)/(myBZ+rameshBZ))
		set diffBP=((myBP-rameshBP)/(myBP+rameshBP))
		#
		if(1){\
		# jon version
		#jrdpcf2d dump9997
		# from code, correct
		#set omegaf2t=u
		# normal omegaf2
		set omegaf2t=omegaf2
		#
		}
		if(0){\
		       #
		# ramesh version
		set omegaf2t=rameshomegaf
		set B1=rameshBR/sqrt(gv311)
		set B2=rameshBZ/sqrt(gv322)
		set B3=rameshBP/sqrt(gv333)
		}
		# super ramesh version
		if(0){\
		       set R=Tu5*0+10
		       set Z=u5*R
		       set gv300=-1
		       set gv311=1
		       set gv322=1
		       set gv333=R*R
		       #
		       set gv301=0
		       set gv302=0
		       set gv303=0
		       set gv310=0
		       set gv312=0
		       set gv313=0
		       set gv320=0
		       set gv321=0
		       set gv323=0
		       set gv330=0
		       set gv331=0
		       set gv332=0
		       #
		set testaphi5=R**nu5*Tu5
		set Rdisk=(testaphi5/Tu5[0])**(1/nu5)
		set Omegadisk=m5/Rdisk
		set omegaf2t=m5*(R**nu5*Tu5/Tu5[0])**(-1/nu5)
		# orthonormal basis
		set BR=-R**(nu5-2) * Tpu5
		set BR=(Z>0) ? BR : -BR
		set BR=(Z==0) ? 0 : BR
		set BZ=R**(nu5-2)*(nu5*Tu5-abs(Z/R)*Tpu5)
		set BP=-nu5*(s5)*R**(nu5-2)*Tu5**( (nu5-1)/nu5 )
		set BP=(Z>0) ? BP : -BP
		set BP=(Z==0) ? 0 : BP
		#
		set B1=BR/sqrt(gv311)
		set B2=BZ/sqrt(gv322)
		set B3=BP/sqrt(gv333)
		}
		#
		# compute v^i
		#
		set B0=B1*0
		set Bd0=gv300*0+gv301*B1+gv302*B2+gv303*B3
		set Bd1=gv310*0+gv311*B1+gv312*B2+gv313*B3
		set Bd2=gv320*0+gv321*B1+gv322*B2+gv323*B3
		set Bd3=gv330*0+gv331*B1+gv332*B2+gv333*B3
		#
		set Bsq=Bd0*B0+Bd1*B1+Bd2*B2+Bd3*B3
		#
		set V1=-B1*(Bd0+omegaf2t*Bd3)/Bsq
		set V2=-B2*(Bd0+omegaf2t*Bd3)/Bsq
		#set V3=omegaf2t-B3*(Bd0+omegaf2t*Bd3)/Bsq
		set V3=omegaf2t*(1.0-B3*Bd3/Bsq) - B3*Bd0/Bsq
		#
		#set Vd0=gv300*0+gv301*V1+gv302*V2+gv303*V3
		set Vd1=gv311*V1+gv312*V2+gv313*V3
		set Vd2=gv321*V1+gv322*V2+gv323*V3
		set Vd3=gv331*V1+gv332*V2+gv333*V3
		#
		set Vsq=Vd1*V1+Vd2*V2+Vd3*V3
		set V=sqrt(Vsq)
		set V1hat=V1*sqrt(gv311)
		set V2hat=V2*sqrt(gv322)
		set V3hat=V3*sqrt(gv333)
		set utsq=1/(-gv300-Vsq-2*(gv301*V1+gv302*V2+gv303*V3))
		echo "computed utsq"
		#
		#
		# for super ramesh version, do:
		#  print {u5 R Z utsq Rdisk omegaf2t Omegadisk}
		#  print {u5 R Z utsq Rdisk omegaf2t Omegadisk V1hat V2hat V3hat V}
checkres0  0    #
		set god=R*0
		plc 0 god
		#
		do ii=0,$nx-1,1 {
		   set myth=atan(1/u5)
		   set myR=R[$ii]+myth*0
		   set myr=myR/sin(myth)
		   set myZ=myr*cos(myth)
		   points myR myZ
		}
		#
ramfield 2      #
		#
		define cres 16
		#
		jrdpcf2d dump$1
		fieldcalc 0 aphi
		#set toplot0=aphi
		set toplot0=B1
		jrdpcf2d dump$2
		fieldcalc 0 aphi
		#set toplot1=aphi
		set toplot1=B1
		#
		faraday
		set vf=R*omegaf2
		#
		set hbz=(th<pi/2) ? th : (pi-th)
		set rampara=rspc*(1-cos(hbz))
		#
		define cres 30
		#
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		#plc 0 rampara 001 myrin myrout thin thout
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "yellow"
		plc 0 toplot0 001 myrin myrout thin thout
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "blue"
		plc 0 toplot1 011 myrin myrout thin thout
		#
		#
		#plc 0 vf myrin myrout thin thout
		#
		#plc 0 uu0 myrin myrout thin thout
		#
		#
rdram 1         # rdram nu1.0_m.25_hres.txt
		#
		da $1
		lines 1 1
		read '%g %g %g %g' {nu mm ss ucrit}
		lines 2 1000000
		read '%g %g %g' {uu Theta dThetadu}
		#
		# uu = z/R
		#
		set theta1 = atan(1.0/uu)
		#
rdram2 1        # rdram2 nu1.0_m.25_gamma.txt
		#
		da $1
		lines 1 1
		read '%g %g %g %g' {nu mm ss ucrit}
		lines 2 1000000
		read '%g %g %g %g %g %g' {R z Bp Bphi beta_minsq gamma_min}
		#
		# tan(theta) = R/z
		#
		set theta=atan2(R,z)
		#
ramplot1 0      #
		# some plots to see
		#
		ctype default pl 0 uu Theta 1101 1E-15 1E15 1E-16 10
		points (lg(uu)) (lg(Theta))
		#
		ctype red pl 0 uu dThetadu 1111 1E-15 1E15 1E-16 10
		points (lg(uu)) (lg(ABS(dThetadu)))
		#
ramplot12 0     #
		# some plots to see
		#
		define x1label "\theta"
		define x2label "\Theta(\theta)"
		#
		if(1){\
		define thin (1E-15)
		define thout (pi)
		define Thetain (1E-16)
		define Thetaout (10)
		}
		#
		if(0){\
		define thin (1E-1)
		define thout (pi)
		define Thetain (1E-1)
		define Thetaout (10)
		}
		#
		#
		ctype default pl 0 theta1 Theta 1101 $thin $thout $Thetain $Thetaout
		points (lg(theta1)) (lg(Theta))
		#
		# only true for nu=1
		#set myfit = Theta[0]*(theta1/(pi/2))**nu
		# for nu=.75 s=.5
		#set myfit = Theta[0]*(theta1/(pi/2))**(4*nu)
		# for nu=1.25 s/M=2.5
		set myfit = Theta[0]*(theta1/(pi/2))**(0)
		# for nu=1.25 s/M=1.6
		set myfit = Theta[0]*(theta1/(pi/2))**(2-nu)
		ctype blue pl 0 theta1 myfit 1111  $thin $thout $Thetain $Thetaout
		#
		#
		ctype red pl 0 theta1 dThetadu 1111 $thin $thout $Thetain $Thetaout
		points (lg(theta1)) (lg(ABS(dThetadu)))
		#
ramplot2 0      #
		ctype default pl 0 theta gamma_min 1101 1E-5 10 0.5 3000
		#
ramplot3 0      #
		plc 0 uu0
		set jtheta=atan2(r,h)
		plc 0 jtheta 010
		#
ramplot4 0      #
		# to compare with ramplot2
		set jtheta=atan2(r,h)
		#
		ramplot2
		define x1label "\theta"
		define x2label "u^t"
		ctype red pl 0 jtheta uu0 1110
		#set myuse=(uu0<1000 && r>5 && jtheta<pi/2) ? 1 : 0
		set myuse=(jtheta<pi/2) ? 1 : 0
		set uu0good = uu0 if(myuse)
		set jthetagood = jtheta if(myuse)
		#ctype blue pl 0 jthetagood uu0good 1110
		ctype blue points (LG(jthetagood)) (LG(uu0good))
		#
ramstress0 1    #
		# look at stresses
		#
		gogrmhd
		jrdpcf2d dump$1
		gammiegridnew3 gdump
		# get time back
		jrdpcf2d dump$1
		fullstress
		#
		# setup bzplot100doloop macro
		jre stress.m
		define picki (10)
		define pickj (12)
		define mydelay (0)
		define doplot (0)
		define mygdettype (0)
		#
		# get point and averaged stresses
		bzplot100doloop 1 3
		bzplot100doloop 2 3
		#
checklc 0        #
		 plc 0 uu0
		 fieldcalc 0 aphi
		 plc 0 (aphi**.25) 010
		 jre mode2.m
		 alfvenvp
		 plc0 0 alfvenv1m 010
		 faraday
		 set R=r*sin(h)
		 plc 0 R 010
		 set lev=4,4.1,.1 levels lev ctype cyan contour
		 plc 0 h 010
		 set lev=.185,.186,.01 levels lev ctype yellow contour
ramlines1 0      #
		#
		jre mode2.m
		alfvenvp
		plc0 0 alfvenv1m
		plc 0 h 010
		plc 0 uu0 010
		plc 0 (r*sin(h)) 010
		set lev=4,4.1,.1 levels lev ctype cyan contour
		fieldcalc 0 aphi
		plc 0 (aphi**.25) 010
		#
ramspar1 0      #
		#
		# gammiegridnew3 gdump
		#
		#
		# for nu=1 only
		#set B3norm=B3*sqrt(gv333)
		#set B3spar=B3norm*r*sin(h)
		#
		# general \nu
		#
		# true for no space-time mixing
		#
		set Br = dxdxp11*B1+dxdxp12*B2
		set Bh = dxdxp21*B1+dxdxp22*B2
		set Bp = B3
		#
		set Brnorm=Br
		set Bhnorm=Bh*abs(r)
		set Bpnorm=Bp*abs(r*sin(h))
		#
		set Bznorm0=Brnorm*cos(h)-Bhnorm*sin(h)
		set BRnorm0=Brnorm*sin(h)+Bhnorm*cos(h)
		#
		set spar0=Bpnorm/Bznorm0
		#
		# plc 0 spar0 001 Rin Rout (pi/2-.1) (pi/2+.1)
		#
		ctype default
		setlimits Rin 1E2 (pi/2) (pi/2+.01) -.1 5.0 plflim 0 x1 r h spar0 1 100
		#
		ctype red pl 0 r (0.5+r*0) 1010
		#
		#
ramspardumb0 0  #
		# stupid way?
		set thetaB = atan2(Bhnorm,Brnorm)
		set Bznorm1 = Brnorm/cos(thetaB)
		# or
		set Bznorm2 = Bhnorm/sin(thetaB)
		#
		set spar1=Bpnorm/Bznorm1
		set spar2=Bpnorm/Bznorm2
		#
		#
		#
slowfastcompare0 0 #
		# /home/jondata/ramt26/run
		# slow
		jrdpcf2d dump9995
		set aphislow=rho
		set omegaf2slow=u
		#
		jrdpcf2d dump0000
		set B1slow=B1
		set B2slow=B2
		set uu0slow=uu0
		set uu1slow=uu1
		set uu2slow=uu2
		set uu3slow=uu3
		#
		# fast
		jrdpcf2d ../../run_comparefast/dumps/dump9995
		set aphifast=rho
		set omegaf2fast=u
		#
		jrdpcf2d ../../run_comparefast/dumps/dump0000
		set B1fast=B1
		set B2fast=B2
		set uu0fast=uu0
		set uu1fast=uu1
		set uu2fast=uu2
		set uu3fast=uu3
		#
		#
		set aphidiff=aphislow-aphifast
		set omegaf2diff=omegaf2slow-omegaf2fast
		set B1diff=B1slow-B1fast
		set B2diff=B2slow-B2fast
		set uu0diff=uu0slow-uu0fast
		set uu1diff=uu1slow-uu1fast
		set uu2diff=uu2slow-uu2fast
		set uu3diff=uu3slow-uu3fast
		#
checkc323 0     # old: ramt32 new: ramt34
		#
		# jrdpcf2d dump0000
		# gammiegridnew3 gdump
		#
		set c323gdet=gdet*c323
		ctype default setlimits 1E2 1.01E2 -1 4 0 1 plflim 0 x2 r h c323gdet 0
		#
		#
		#
		#
		#
		# PLOTS for Ramesh self-similar paper
		####################################
		#
jetstructss0 0  #
		#
		# Contour extraction of quantities along field line
		#
		# /raid7/jmckinne/ramt25
		# /mnt/data2/jon/ramt25
		#
		# device postencap jetstructss.eps
		gogrmhd
		jre ramesh_disk.m
		jrdpcf2d dump0050
		gammiegridnew3 gdump
		pitchangle0
		#
		# ramt37c: dump0052
		#
		# get field connected to disk that extends to large radius
		# getcontour0 gets from lower side (\theta<pi/2) and that's good here
		#  since other side messed up
		#
		# uses macro from ramesh_disk.m
		#
		# for field line from star
		# getcontour0 1.2
		# for field line from disk
		getcontour0 2.021
		# for field line from disk (from furthest out possible to reach \Gamma=10)
		#getcontour0 5.542
		#
		! cp caphidata.head caphidata.txt /home/jondata/contourdata/
		#       
		# !scp caphidata.head caphidata.txt jon@relativity:/home/jondata/contourdata/
		#
		# then goto Matlab and run joncontournew()
		#
		#!cp /home/jondata/contourdata/contoursks.txt contours_fromdisk_outer.txt
		#
		# !scp jon@relativity:/home/jondata/contourdata/contoursks.txt contours_fromdisk.txt
		#
		# uses macro from ramesh_disk.m
		#
		#
		#
		#
readanalytic0 0 #
		#
		# first read in analytic version
		# /home/jondata/ramt38/ramt38/run_rtype1
		#
		# created from /home/jondata/ramt38/ramt38/run
		jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype1/dumps/dump0000
		gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype1/dumps/gdump
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		# contours_nu1_s.25.txt
		readcontour0 /home/jondata/contourdata/contours_nu1_s.25.txt
		#
		# now set analytic to backup values
		set acz=cr*cos(ch)
		set acxaxis = 1+acz/2.021
		set lgacxaxis=lg(acxaxis)
		#
		set myach=ch*180/pi
		set lgmyach=lg(myach)
		#
		set lgaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaB3=lg(abs(toplotcB3hat))
		#
		set myapitch=cpitchangle
		set lgapitch=lg(myapitch)
		#
readanalytic1 0 #
		# read in analytic version
		# /home/jondata/ramt38/ramt38/run_rtype3
		#
		# created from /home/jondata/ramt38/ramt38/run
		jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype3/dumps/dump0000
		gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype3/dumps/gdump
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		# contours_nu1_s1.txt
		readcontour0 /home/jondata/contourdata/contours_nu1_s1.txt
		#
		# now set analytic to backup values
		set aacz=cr*cos(ch)
		set aacxaxis = 1+aacz/2.021
		set lgaacxaxis=lg(aacxaxis)
		#
		set myaach=ch*180/pi
		set lgmyaach=lg(myaach)
		#
		set lgaaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaaB3=lg(abs(toplotcB3hat))
		#
		set myaapitch=cpitchangle
		set lgaapitch=lg(myaapitch)
		#
		#
readnumerical0 0 #
		#
		jrdpcf2d dump0050
		gammiegridnew3 gdump
		#
		readcontour0 contours_fromdisk.txt
		#readcontour0 contours_fromdisk_outer.txt
		#
		#set Bhor=sqrt(bsq[0+$ny/2*$nx])
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		set cR=cr*sin(ch)
		set cz=cr*cos(ch)		
		set cxaxis = 1+cz/2.021
		set lgcxaxis=lg(cxaxis)
		#
		set mych=ch*180/pi
		set lgmych=lg(mych)
		#
		set lgclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgB3=lg(abs(toplotcB3hat))
		#
		set mykink=atan((1.0/(cwf2*cgrR)))
		set mypitch=cpitchangle
		set lgpitch=lg(mypitch)
		#
		#
plotjetss0      # very similar to plotjet0 in ramesh_disk.m
		# like jetstructplot0 in punsly.m
		#
		#	device postencap jetstructss.eps
		#
		# determine normalization
		#
		defaults
		fdraft
		#
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#
		##########################
		#
		# \theta_j
		#
		##########################
		#
		ticksize 0 0 0 0
		set thin=0.01*180/pi
		set thout=2.0*180/pi
		#
		define lgRin (0)
		# 3.5 for star and inner disk
		#define lgRout (3.5)
		# 3.5 for star and inner disk
		define lgRout (3.0)
		#
		define god1 (LG(thin))
		define god2 (LG(thout))
		limits $lgRin $lgRout $god1 $god2
		ctype default window 10 -2 1:5 2 box 0 2 0 0
		#
		define x2label "log(\theta_j [^\circ])"
		#define x1label "1+z/R_{fp}"
		set mych=ch*180/pi
		# below for whichaphi=1.6
		#set myfit=57*(cr/2.8)**(-0.34)
		# below for whichaphi=1.0
		#set myfit=44.5*(cr/2.8)**(-0.34)
		# for model at t=0
		#set myfit=52*(cr/2.8)**(-0.375)
		# for paraboloidal model
		#set myfit=54*(cr/2.8)**(-0.48)
		# for \nu=1 ramt25 model (from star)
		#set myfit=54*(cr/2.8)**(-0.515)
		# for \nu=1 ramt25 model (from disk)
		#set myfit=90*(cr/1.8)**(-0.515)
		#
		ltype 0 ctype default pl 0 lgcxaxis lgmych 0011 Rin Rout thin thout
		ltype 1 ctype default pl 0 lgacxaxis lgmyach 0011 Rin Rout thin thout
		ltype 2 ctype default pl 0 lgaacxaxis lgmyaach 0011 Rin Rout thin thout
		ltype 0
		#xla $x1label
		yla $x2label
		#
		#
		##########################
		#
		# \Gamma
		#
		##########################
		#
		ticksize 0 0 0 0
		limits $lgRin $lgRout 0 1.5
		ctype default window 10 -2 6:10 2 box 0 2 0 0
		define x2label "log(\gamma_{\rm min})"
		#define x1label "r"
		#set myfit=2*(cr/42.5)**(0.6)
		# for para
		#set myfit=1.5*(cr/42.5)**(0.55)
		# for \nu=1 ramt25 model (from star)
		#set myfit=2*(cr/42.5)**(0.47)
		# for \nu=1 ramt25 model (from disk)
		#set myfit=2.5*(cr/100)**(0.47)
		ltype 0 ctype default pl 0 lgcxaxis lgclorentzgam 0011 Rin Rout thin thout
		ltype 1 ctype default pl 0 lgacxaxis lgaclorentzgam 0011 Rin Rout thin thout
		ltype 2 ctype default pl 0 lgaacxaxis lgaaclorentzgam 0011 Rin Rout thin thout
		#xla $x1label
		yla $x2label
		#
		#
		#
		#
		#
		##########################
		#
		# B^\phi orthonormal
		#
		##########################
		ticksize 0 0 0 0
		limits $lgRin $lgRout -3 0.1
		ctype default window 10 -2 1:5 1 box 1 2 0 0
		#
		#define x2label "B^{\hat{\phi}}"
		define x2label "log(-B_\phi)"
		# in Gauss
		#
		define x1label "log(1+z/R_{fp})"
		#set myfit=0.29*cr**(-0.7)
		#set myfit=20*cr**(-1.5)
		# para
		#set myfit=0.26*cr**(-0.6)
		# para
		#set myfit=0.18*(cr/1.8)**(-0.5)
		#
		ltype 0 ctype default pl 0 lgcxaxis lgB3 0011 Rin Rout thin thout
		ltype 1 ctype default pl 0 lgacxaxis lgaB3 0011 Rin Rout thin thout
		ltype 2 ctype default pl 0 lgaacxaxis lgaaB3 0011 Rin Rout thin thout
		ltype 0
		xla $x1label
		yla $x2label
		#
		##########################
		#
		# Pitch angle
		#
		##########################
		ticksize 0 0 0 0
		limits $lgRin $lgRout -1.5 0.4
		ctype default window 10 -2 6:10 1 box 1 2 0 0
		#
		#define x2label "\alpha_{\rm pitch} = tan^{-1}(B^{\hat{r}}/B^{\hat{\phi}}) [degrees]"
		define x2label "log(\alpha_{\rm pitch})"
		#define x2label "(B^{\hat{r}})^2/\rho_{0,disk}"
		#define x2label "tan^{-1}(|B^{\hat{r}}|/|B^{\hat{\phi}}|)"
		#
		#
		define x1label "log(1+z/R_{fp})"
		#
		ltype 0 ctype default pl 0 lgcxaxis lgpitch 0011 Rin Rout thin thout
		ltype 1 ctype default pl 0 lgacxaxis lgapitch 0011 Rin Rout thin thout
		ltype 2 ctype default pl 0 lgaacxaxis lgaapitch 0011 Rin Rout thin thout
		#
		#ltype 1 ctype default pl 0 cr mykink 1110
		ctype default ltype 0
		xla $x1label
		yla $x2label
		#
		# device X11
		# !scp  jetstructgrffe.eps jon@relativity:/home/jondata/
		#
doallrp0   0    #
		# RUN FROM DIRECTORY : /mnt/data2/jon/ramt25
		#
		jre ramesh_disk.m
		jre ramesh_selfsim.m
		#
		readanalytic0
		readanalytic1
		readnumerical0
		#
		plotjetss0
		#
replotrp0 0     #
		#
		device postencap jetstructnu1.eps
		plotjetss0
		device X11
		!cp jetstructnu1.eps ~/
		#
		#
		#
		#
		#
		# next plot
		#
		#
readanalytic2 0 #
		#
		if(0){\
		 # first read in analytic version
		 # contours_nu.75_s.28146_analytical.txt
		 # /home/jondata/ramt38/ramt38/run_rtype5
		 #
		 # created from /home/jondata/ramt38/ramt38/run
		 jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype5/dumps/dump0000
		 gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype5/dumps/gdump
		}
		#
		if(1){\
		 # first read in analytic version
		 # contours_nu.75_s.27_analytical.txt
		 # /home/jondata/ramt38/ramt38/run_rtype8
		 #
		 # created from /home/jondata/ramt38/ramt38/run
		 jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype8/dumps/dump0000
		 gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype8/dumps/gdump
		}
		#
		if(0){\
		 # first read in analytic version
		 # contours_nu.75_s.22_analytical.txt
		 # /home/jondata/ramt38/ramt38/run_rtype9
		 #
		 # created from /home/jondata/ramt38/ramt38/run
		 jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype9/dumps/dump0000
		 gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype9/dumps/gdump
		}
		#
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		if(0){\
		       #contours_nu.75_s.28146_analytical.txt
		       readcontour0 /home/jondata/contourdata/contours_nu.75_s.28146_analytical.txt
		    }
		if(1){\
		           #contours_nu.75_s.27_analytical.txt
		 readcontour0 /home/jondata/contourdata/contours_nu.75_s.27_analytical.txt
		}
		if(0){\
		       #contours_nu.75_s.22_analytical.txt
		       readcontour0 /home/jondata/contourdata/contours_nu.75_s.22_analytical.txt
		    }
		#
		# now set analytic to backup values
		set acz=cr*cos(ch)
		set acxaxis = 1+acz/2.021
		set lgacxaxis=lg(acxaxis)
		#
		set myach=ch*180/pi
		set lgmyach=lg(myach)
		#
		set lgaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaB3=lg(abs(toplotcB3hat))
		#
		set myapitch=cpitchangle
		set lgapitch=lg(myapitch)
		#
readanalytic3 0 #
		# read in analytic version
		# /home/jondata/ramt38/ramt38/run_rtype4
		#
		# created from /home/jondata/ramt38/ramt38/run
		jrdpcf2d ../../../../../home/jondata/ramt38/ramt38/run_rtype4/dumps/dump0000
		gammiegridnew3 ../../../../../home/jondata/ramt38/ramt38/run_rtype4/dumps/gdump
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		# contours_nu.75_s.5_analytical.txt
		readcontour0 /home/jondata/contourdata/contours_nu.75_s.5_analytical.txt
		#
		# now set analytic to backup values
		set aacz=cr*cos(ch)
		set aacxaxis = 1+aacz/2.021
		set lgaacxaxis=lg(aacxaxis)
		#
		set myaach=ch*180/pi
		set lgmyaach=lg(myaach)
		#
		set lgaaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaaB3=lg(abs(toplotcB3hat))
		#
		set myaapitch=cpitchangle
		set lgaapitch=lg(myaapitch)
		#
		#
readnumerical1 0 #
		#
		if(0){\
		# /mnt/disk/ramruns/ramt31
		jrdpcf2d dump0034
		gammiegridnew3 gdump
		readcontour0 /home/jondata/contourdata/contours_nu.75_s.28146_numerical.txt
		}
		#
		if(1){\
		# /mnt/disk/ramruns/ramt32
		jrdpcf2d dump0042
		gammiegridnew3 gdump
		readcontour0 /home/jondata/contourdata/contours_nu.75_s.28146_numerical_ramt32.txt
		}
		#
		#
		#
		#set Bhor=sqrt(bsq[0+$ny/2*$nx])
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		set cR=cr*sin(ch)
		set cz=cr*cos(ch)		
		set cxaxis = 1+cz/2.021
		set lgcxaxis=lg(cxaxis)
		#
		set mych=ch*180/pi
		set lgmych=lg(mych)
		#
		set lgclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		#set toplotcB3hat=cB3hat
		set lgB3=lg(abs(toplotcB3hat))
		#
		set mykink=atan((1.0/(cwf2*cgrR)))
		set mypitch=cpitchangle
		set lgpitch=lg(mypitch)
		#
		#
		# !scp  jetstructgrffe.eps jon@relativity:/home/jondata/
		#
doallrp1   0  #
		# RUN FROM DIRECTORY : /mnt/disk/ramruns/ramt32
		gogrmhd
		#
		jre ramesh_disk.m
		jre ramesh_selfsim.m
		#
		readanalytic2
		readanalytic3
		readnumerical1
		#
		plotjetss0
		#
replotrp1 0     #
		#
		device postencap jetstructnu.75.eps
		plotjetss0
		device X11
		!cp jetstructnu.75.eps ~/
		#
readanalytic4 0 #
		# first read in analytic version (RAMESHTYPE==7) nu=1.25 
		#
		#
		#
		# /home/jondata/ramt38/ramt38/run_rtype7
		#
		# created from /home/jondata/ramt38/ramt38/run
		jrdpcf2d ../../../../../../home/jondata/ramt38/ramt38/run_rtype7/dumps/dump0000
		gammiegridnew3 ../../../../../../home/jondata/ramt38/ramt38/run_rtype7/dumps/gdump
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		# contours_nu1.25_soM1.6_analytical.txt
		readcontour0 /home/jondata/contourdata/contours_nu1.25_soM1.6_analytical.txt
		#
		# now set analytic to backup values
		set acz=cr*cos(ch)
		set acxaxis = 1+acz/2.021
		set lgacxaxis=lg(acxaxis)
		#
		set myach=ch*180/pi
		set lgmyach=lg(myach)
		#
		set lgaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaB3=lg(abs(toplotcB3hat))
		#
		set myapitch=cpitchangle
		set lgapitch=lg(myapitch)
		#
readanalytic5 0 #
		# read in analytic version
		# /home/jondata/ramt38/ramt38/run_rtype6
		#
		# created from /home/jondata/ramt38/ramt38/run
		jrdpcf2d ../../../../../../home/jondata/ramt38/ramt38/run_rtype6/dumps/dump0000
		gammiegridnew3 ../../../../../../home/jondata/ramt38/ramt38/run_rtype6/dumps/gdump
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		# 
		readcontour0 /home/jondata/contourdata/contours_nu1.25_soM2.5_analytical.txt
		#
		# now set analytic to backup values
		set aacz=cr*cos(ch)
		set aacxaxis = 1+aacz/2.021
		set lgaacxaxis=lg(aacxaxis)
		#
		set myaach=ch*180/pi
		set lgmyaach=lg(myaach)
		#
		set lgaaclorentzgam=lg(clorentzgam)
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgaaB3=lg(abs(toplotcB3hat))
		#
		set myaapitch=cpitchangle
		set lgaapitch=lg(myaapitch)
		#
		#
readnumerical2 0 #
		# nu=1.25
		# # ramt36 too disrupted
		# # ramt37b too disrupted even if at higher resolution!
		# # ramt37c ok at dump0052 along a field line that reaches gam=10
		#
		# start from numerical directory (if on sauron, copy over skeleton of files needed)
		#
		#
		if(0){\
		       # /mnt/disk/ramruns/ramt37
		       jrdpcf2d dump0022
		       gammiegridnew3 gdump
		       readcontour0 /home/jondata/contourdata/contours_nu1.25_soM1.6_numerical.txt
		    }
		    #
		if(1){\
		       # /raid2/jmckinne/ramt37c/
		       jrdpcf2d dump0052
		       gammiegridnew3 gdump
		       readcontour0 /home/jondata/contourdata/contours_nu1.25_soM1.6_numerical_ramt37c.txt
		    }   
		#
		#
		#
		#set Bhor=sqrt(bsq[0+$ny/2*$nx])
		set Bhnorm=B2*sqrt(gv322)
		set Bhor=sqrt(abs(Bhnorm[0+($ny/2)*$nx]))
		#
		print {Bhor}
		#
		set cR=cr*sin(ch)
		set cz=cr*cos(ch)		
		set cxaxis = 1+cz/2.021
		set lgcxaxis=lg(cxaxis)
		#
		set mych=ch*180/pi
		set lgmych=lg(mych)
		#
		set lgclorentzgam=lg(clorentzgam)
		# fudge
		# see if scaling would have worked
		set fudgefun=(lgclorentzgam[500]-lgclorentzgam[480])/(lgcxaxis[500]-lgcxaxis[480])*(lgcxaxis-lgcxaxis[480])+lgclorentzgam[480]
		set lgclorentzgam=(lgcxaxis>2.8) ?  fudgefun : lgclorentzgam
		#
		set toplotcB3hat=cB3hat/Bhor
		set lgB3=lg(abs(toplotcB3hat))
		#
		set mykink=atan((1.0/(cwf2*cgrR)))
		set mypitch=cpitchangle
		set lgpitch=lg(mypitch)
		#
		#
		# !scp  jetstructgrffe.eps jon@relativity:/home/jondata/
		#
doallrp2   0  #  RUN FROM: /home/jondata/ramt38/ramt38/ramt37c
		#
		gogrmhd
		#
		jre ramesh_disk.m
		jre ramesh_selfsim.m
		#
		readanalytic4
		readanalytic5
		readnumerical2
		#
		plotjetss0
		#
replotrp2 0     #
		#
		device postencap jetstructnu1.25.eps
		plotjetss0
		device X11
		!cp jetstructnu1.25.eps ~/
		#
rcompfield 2    #
		#
		#
		jrdpcf2d dump$1
		fieldcalc 0 aphi0
		jrdpcf2d dump$2
		fieldcalc 0 aphi1
		faraday
		gammiegridnew3 gdump
		#
		# get light cylinder from second dump
		#
		set lightstotal=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		set omegaf2=0.25+r*0
		set lightsstar=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		#
		set lightsdisk=h-0.489957
		set lightsdisk2=h-(pi-0.489957)
		#                                                                  
		#
		#
		# regular plot
		if(0){\
		       define x1in (0)
		       #define x1out (5.1*1E2)
		       define x1out (100.0)
		       define x2in (-1.1*1E3)
		       define x2out (1.1*1E3)
		    }
		#
		# zoom plot
		if(1){\
		       define x1in (0)
		       define x1out (50.0)
		       define x2in (-50)
		       define x2out (50)
		    }
		#
		define mynx (256)
		define myny (128)
		#
 		#
		interpsingle aphi0 $mynx $myny $x1in $x1out $x2in $x2out
		interpsingle aphi1 $mynx $myny $x1in $x1out $x2in $x2out
		interpsingle lightstotal $mynx $myny $x1in $x1out $x2in $x2out
		interpsingle lightsstar $mynx $myny $x1in $x1out $x2in $x2out
		interpsingle lightsdisk $mynx $myny $x1in $x1out $x2in $x2out
		interpsingle lightsdisk2 $mynx $myny $x1in $x1out $x2in $x2out
		#
		readinterp aphi0
		readinterp aphi1
		readinterp lightstotal
		readinterp lightsstar
		readinterp lightsdisk
		readinterp lightsdisk2
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define POSCONTLTYPE 1
		define NEGCONTLTYPE 1
		plc 0 iaphi0 001 $x1in $x1out $x2in $x2out
		set mynewfun0=newfun
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		#define POSCONTCOLOR "red"
		#define NEGCONTCOLOR "red"
		define BOXCOLOR "default"
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		plc 0 iaphi1 011 $x1in $x1out $x2in $x2out
		set mynewfun1=newfun
		#
		plc 0 ilightstotal 011 $x1in $x1out $x2in $x2out
		set mynewfunlightstotal=newfun
		#
		plc 0 ilightsstar 011 $x1in $x1out $x2in $x2out
		set mynewfunlightsstar=newfun
		#
		plc 0 ilightsdisk 011 $x1in $x1out $x2in $x2out
		set mynewfunlightsdisk=newfun
		#
		plc 0 ilightsdisk2 011 $x1in $x1out $x2in $x2out
		set mynewfunlightsdisk2=newfun
		#
		#
		#
ramcompfield0 0 #
		# /mnt/data2/jon/ramt25
		#
		# just easy way to get started
		gogrmhd
		jre ramesh_disk.m
		rcompfield 0000 0050
		#
		#
		# start real plot
		#
		fdraft
		erase
		ramcompfieldpl0
		#
ramcompfieldpl0 0 #
		#
		box
		xla "R"
		yla "z"
		#
		# ZOOM/NORMAL
		if(1){\
		       define aphipow (0.15)
		       define mymin (.05**$aphipow)
		       define mymax (100.0**$aphipow)
		       define cres 20
		    }
		#
		# OTHER
		if(0){\
		       define aphipow (0.15)
		       define mymin (2.012**$aphipow)
		       define mymax (470)
		       define cres 20
		    }
		#
		# NUMERICAL
		set image[ix,iy] = abs(mynewfun1)**$aphipow
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		lweight 3 ltype 0 ctype default contour
		#
		# analytic
		if(1){\
		       define aphipow (0.15)
		       define mymin (.05**$aphipow)
		       define mymax (100.0**$aphipow)
		       define cres 20
		    }
		#
		# ANALYTICAL
		set image[ix,iy] = abs(mynewfun0)**$aphipow
		set lev=$mymin,$mymax,($mymax-$mymin)/$cres
		levels lev
		lweight 3 ltype 1 ctype default contour
		#
		# light cylinders
		set image[ix,iy] = mynewfunlightstotal
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 7 ltype 0 ctype default contour
		#
		set image[ix,iy] = mynewfunlightsstar
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 7 ltype 1 ctype default contour
		#
		set image[ix,iy] = mynewfunlightsdisk
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 7 ltype 1 ctype default contour
		#
		set image[ix,iy] = mynewfunlightsdisk2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 7 ltype 1 ctype default contour
		#
		lweight 3
		#
ramcfieldpl1 0  #
		device postencap fieldcompnu1.eps
		ramcompfieldpl0
		device X11
		!cp fieldcompnu1.eps ~/
		#
ramcfieldpl2 0  #
		device postencap fieldcompnu1zoom.eps
		ramcompfieldpl0
		device X11
		!cp fieldcompnu1zoom.eps ~/
		#
animspar 0	# 
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1='dump'
		#
		set startanim=0
		set endanim=69
		#
		define x1label "R"
		define x2label "s M"
		fdraft
		#
		define x1label "R"
		define x2label "s M"
		#
		# !mkdir frames
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  #
		  define myii ($ii)
		  #
		  jrdpcf2d $filename
		  #
		  lweight 3
		  #
 		  define x1label "R"
		  define x2label "s M"
		  #
		  set h1f='frame'
		  set h2f=sprintf('%04d',$myii)
		  set h3f='.eps'
		  set _fname=h1f+h2f+h3f
                  define filenamef (_fname)
		  #
		  # device postencap ./frames/$filenamef
		  #
		  ramspar1
		  set tempt=sprintf('%5.2g',_t)
                  define temptime (tempt)
		  #
		  set crap=_t*.25
		  set tempt2=sprintf('%5.2g',crap)
                  define temptime2 (tempt2)
		  #
                  #label t=$time
		  ctype default
		  relocate (10383 31500)
                  label t=$temptime
		  relocate (20383 31500)
                  label Mt=$temptime2
		  #
		  # device X11
		  #!sleep .5s
		}
		#
sMplot 0        #
		set mytz={1,2,3,4}
		set myR={3,7,9,12}
		#
		#
currentclose0 0 #
		#
		set juhatx=ju1*sqrt(gv311)
		set juhaty=ju2*sqrt(gv322)
		#
		#vpl 0 juhat 10 12 000
		#
		defaults
		define SKIPFACTOR 4
		define UNITVECTOR 1
		vpl 0 juhat 1 12 100
		#
		set R=r*sin(h)
		define NEGCONTLTYPE 10
		define POSCONTLTYPE 10
		ticksize -1 0 0 0
		define godin (Rin-371)
		define godout (Rout+355)
		define bombin (0-.12)
		define bombout (pi+.12)
		limits $godin $godout $bombin $bombout
		plc 0 R 010
		#set lev=4,4.01,.01
		set lev=1.5,1.51,.01
		levels lev
		ctype blue contour
		#
groupvel 0      #
		#
		jrdpcf2d dump0069
		stresscalc 1
		#
		set momp=sqrt(Tud10*Tud10*gv311+Tud20*Tud20*gv322)
		set energy=-Tud00
		#
		set ve = momp/energy
		#
returncurr0 0   #
		#
		jrdpcf2d dump0069
		faraday
		fdraft
		set Bd3=-gdet*fuu12
		fieldcalc 0 aphi
		#set myuse=((r>2)&&(r<2.01)) ? 1 : 0
		set myuse=((r>100)&&(r<105)) ? 1 : 0
		set myBd3=Bd3 if(myuse)
		set myaphi=aphi if(myuse)
		define x1label "P"
                define x2label "RB_\phi"
		ltype 0 ctype default pl 0 myaphi myBd3
		ptype 4 1 points myaphi myBd3
		#
