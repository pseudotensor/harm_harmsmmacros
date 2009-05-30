		#
		define item Tud02
		define itemf Tud12
		jrdp dump0000
		stresscalc 1
		set olditem=$item
		dercalc 0 $itemf d$itemf
		set diffitem=-(dTud12x*.0089)
		set newitem=olditem-diffitem
		#
		jrdp dump0001
		stresscalc 1
		ctype default pl 0 r $item
		ctype red pl 0 r newitem 0010
		#
		#
		set diffcode=$item-olditem
		ctype default pl 0 r diffcode
		ctype red pl 0 r diffitem 0010
		#
		#
		#
		ctype default agpl 'dump' r Tud12
		#
		#
		define item Tud12
		#
		jrdp dump0000
		stresscalc 1
		ctype default pl 0 r $item
		set itema=$item
		#
		jrdp dump0001
		stresscalc 1
		ctype red plo 0 r $item
		set itemb=$item
		#
		jrdp dump0002
		stresscalc 1
		ctype blue plo 0 r $item
		set itemc=$item
		#
		set diff1=itemb-itema
		ctype default pl 0 r diff1
		#
		#
		#
		#
		jrdp dump0000
		stresscalc 1
		ctype default pl 0 r Tud11
		set Tud11a=Tud11
		#
		jrdp dump0001
		stresscalc 1
		ctype red plo 0 r Tud11
		set Tud11b=Tud11
		#
		jrdp dump0002
		stresscalc 1
		ctype blue plo 0 r Tud11
		set Tud11c=Tud11
		#
		set diff1=Tud11b-Tud11a
		ctype default pl 0 r diff1
		#
testfast 1    #
		set muf=+1
		#
		set B2anal=(r<-0.1+muf*$1) ? 1.0 : ((r>0.1+muf*$1) ? 0.7 : (1.0-3.0/2.0*(r+0.1-muf*$1)))
		#
plot4 0    #
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		#
		########################################
		# fast wave
		########################################
		ticksize 0 0 0 0
		limits -.5 1.5 0.65 1.1
		ctype default window 1 -6 1 6 box 0 2 0 0
		#
		jrdp ../../dumpfasti
		set B2i=B2
		#
		jrdp ../../dumpfastf
		set B2f=B2
		#
		define x1label "x^1"
		define x2label "B_2"
		#xla $x1label
		#angle 0.1
		yla $x2label
		#angle 0
		#
		#testfast 0
		#ctype default pl 0 r B2anal
		#set B2anal0=B2anal
		#testfast 1
		#ctype default pl 0 r B2anal 0010
		#set B2anal1=B2anal
		#
		set rnew=r+1.0*0
		ctype default pl 0 rnew B2i 0010
		#
		set rnew=r+1.0*1
		ctype default pl 0 rnew B2i 0010
		#
		#lweight 2 expand 1.1
		ctype default ptype 4 0 angle 45 points r B2f
		angle 0
		#
		expand 1.3
		#
		#print fast.dat {B2anal0 B2anal1 B2}
		########################################
		# deg Alfven wave
		########################################
		ticksize 0 0 0 0
		limits -.5 1.5 -.4 2.5
		ctype default window 1 -6 1 5 box 0 2 0 0
		#
		jrdp ../../dumpdegalfi
		set B2i=B2
		set B3i=B3
		#
		jrdp ../../dumpdegalff
		set B2f=B2
		set B3f=B3
		#
		define x1label "x^1"
		define x2label "B_2"
		#xla $x1label
		yla $x2label
		#
		set rnew=r+.5*0
		ctype default pl 0 rnew B2i 0010
		#
		set rnew=r+.5*2
		ctype default pl 0 rnew B2i 0010
		#
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r B2f
		angle 0
		expand 1.3
		###########################################
		ticksize 0 0 0 0
		limits -.5 1.5 -.4 2.5
		ctype default window 1 -6 1 4 box 0 2 0 0
		#
		define x1label "x^1"
		define x2label "B_3"
		#xla $x1label
		yla $x2label
		#
		set rnew=r+.5*0
		ctype default pl 0 rnew B3i 0010
		#
		set rnew=r+.5*2
		ctype default pl 0 rnew B3i 0010
		#
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r B3f
		angle 0
		expand 1.3
		###########################################
		# 3-wave
		########################################
		ticksize 0 0 0 0
		limits -.5 1.5 0.9 2.1
		ctype default window 1 -6 1 3 box 0 2 0 0
		#
		jrdp ../../dump3wavei
		faraday
		set B2i=B2
		set E1i=fdd10
		#
		jrdp ../../dump3wavef
		set B2f=B2
		faraday
		set E1f=fdd10
		#
		define x1label "x^1"
		define x2label "B_2"
		#xla $x1label
		yla $x2label
		#
		#set rnew=r+.5*0
		#ctype default pl 0 rnew B2i 0010
		#
		#set rnew=r+.5*2
		#ctype default pl 0 rnew B2i 0010
		#
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r B2f
		angle 0
		expand 1.3
		###########################################
		ticksize 0 0 0 0
		limits -.5 1.5 -1.7 -.9
		ctype default window 1 -6 1 2 box 0 2 0 0
		#
		define x1label "x^1"
		define x2label "E_1"
		#xla $x1label
		yla $x2label
		#
		#set rnew=r+.5*0
		#ctype default pl 0 rnew B3i 0010
		#
		#set rnew=r+.5*2
		#ctype default pl 0 rnew B3i 0010
		#
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r E1f
		angle 0
		expand 1.3
		###########################################
		# B^2-E^2<0 problem
		###########################################
		ticksize 0 0 0 0
		limits -.5 1.5 -.3 2.8
		ctype default window 1 -6 1 1 box 1 2 0 0
		#
		jrdp ../../dumpbsqmesqi
		set bsqi=bsq/(B1**2+B2**2+B3**2)
		#
		jrdp ../../dumpbsqmesqf
		set bsqf=bsq/(B1**2+B2**2+B3**2)
		#
		define x1label "x^1"
		define x2label "b^2/B^2"
		#xla \raise4000 $x1label
		expand 1.3 expand 1.2 lweight 2
		xla \raise999 $x1label   
		yla $x2label
		#
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r bsqi
		lweight 2 expand 1.1 ctype default ptype 4 0 angle 45 points r bsqf
		angle 0
		expand 1.3
		#
plot3more 0     # really 4 plots now
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		###########################################
		# Stationary Alfven wave
		###########################################
		ticksize 0 0 0 0
		limits -1.0 2.0 0.95 1.35
		ctype default window 1 -4 1 4 box 0 2 0 0
		#
		jrdp ../../dumpalfstati
		set B3i=B3
		#
		jrdp ../../dumpalfstatf
		set B3f=B3
		#
		#define x1label "x^1"
		define x2label "B_z"
		#xla $x1label
		yla $x2label
		#
		ctype default pl 0 r B3i 0010
		#lweight 2 expand 1.1 
		ctype default ptype 4 0 angle 45 points r B3f
		angle 0
		#expand 1.3
		#
		###########################################
		# Curren Sheet problem B0=0.5
		###########################################
		ticksize 0 0 0 0
		limits -1 2 -.6 0.7
		ctype default window 1 -4 1 3 box 0 2 0 0
		#
		jrdp ../../dumpcs1f
		set By=B2
		faraday
		set Ez=fdd30
		#
		define x1label "x^1"
		define x2label "E_z B_y"
		#xla $x1label
		#yla \raise500 $x2label
		yla $x2label
		#
		#lweight 2 expand 1.1
		ctype default ptype 4 1 angle 45 points r By
		#lweight 2 expand 1.1
		ctype default ptype 4 0 angle 45 points r Ez
		angle 0
		#expand 1.3
		#
		###########################################
		# Curren Sheet problem B0=2.0
		###########################################
		ticksize 0 0 0 0
		limits -1 2 -2.2 2.6
		ctype default window 1 -4 1 2 box 0 2 0 0
		#
		jrdp ../../dumpcs2f
		set By=B2
		faraday
		set Ez=fdd30
		# and bsq
		#
		#define x1label "x^1"
		define x2label "E_z \frac{b^2}{B^2} B_y"
		#expand 1.3 expand 1.2 lweight 2
		#xla $x1label
		#angle 0.1
		#yla \raise500 $x2label
		yla $x2label
		#angle 90
		#
		set itbsq=bsq/(B1**2+B2**2+B3**2)
		ctype default pl 0 r itbsq 0010
		#lweight 2 expand 1.1
		ctype default ptype 4 1 angle 45 points r By
		#lweight 2 expand 1.1
		ctype default ptype 4 0 angle 45 points r Ez
		angle 0
		#expand 1.3
		#
		###########################################
		# Curren Sheet problem B0=2.0 (PARA+RK4)
		###########################################
		ticksize 0 0 0 0
		limits -1 2 -2.2 2.6
		ctype default window 1 -4 1 1 box 1 2 0 0
		#
		jrdp ../../dumpcs2fpara
		set By=B2
		faraday
		set Ez=fdd30
		# and bsq
		#
		define x1label "x^1"
		define x2label "E_z \frac{b^2}{B^2} B_y"
		#expand 1.3 expand 1.2 lweight 2
		xla $x1label
		#angle 0.1
		#yla \raise500 $x2label
		yla $x2label
		#angle 90
		#
		set itbsq=bsq/(B1**2+B2**2+B3**2)
		ctype default pl 0 r itbsq 0010
		#lweight 2 expand 1.1
		ctype default ptype 4 1 angle 45 points r By
		#lweight 2 expand 1.1
		ctype default ptype 4 0 angle 45 points r Ez
		angle 0
		#expand 1.3
		#
splitbz1 0      #
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		####################
		jrdp dump0000
		set Rinold=Rin
		#
		fieldcalc 0 aphii
		interpsingle aphii 128 128 6 6
		jrdp dump0005
		fieldcalc 0 aphif
		interpsingle aphif 128 128 6 6
		#
		readinterp aphii
		readinterp aphif
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		#
                set newiaphii=(radius>Rinold) ? iaphii : $missing_data
                set iaphii=newiaphii
                set newiaphif=(radius>Rinold) ? iaphif : $missing_data
                set iaphif=newiaphif
                #
		#
		# get ix,iy
		plc 0 iaphii 010
		set myi=newfun
		plc 0 iaphif 010
		set myf=newfun
		#
		plc0 0 myradiusdiff 010
		set myrdiff=newfun
		#
		#
		erase
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		#
		#######
		####### initial
		#######
		ticksize 0 0 0 0
		limits 0 4.5 -4.5 4.5
		ctype default window -2 20 1 1:19 box 1 2 0 0
		#
		define cres 32
		define minc (0.00)
		define maxc (3.15)
		#
		set image[ix,iy]=myi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphif 010
		xla $x1label
		yla $x2label
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#######
		####### final
		#######
		ticksize 0 0 0 0
		limits 0 4.5 -4.5 4.5
		ctype default window -2 20 2 1:19 box 1 0 0 0
		#
		define cres 32
		define minc (0.00)
		#define maxc (3.9)
		#define maxc (4.0)
		#define maxc (3.2026)
		define maxc (3.15)
		#
		set image[ix,iy]=myf
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphii 010
		xla $x1label
		#yla $x2label
		#
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
splitbza9 0      #
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		define cres 32
		define boxsize 4.5
		define plotsize 4.5
		define interpnx 256
		define interpny 256
		#
		####################
		jrdp dump0000
		set Rinold=Rin
		#
		fieldcalc 0 aphii
		interpsingle aphii $interpnx $interpny $boxsize $boxsize
		jrdp dump0200
		fieldcalc 0 aphif
		set aphiffull=aphif
		interpsingle aphif $interpnx $interpny $boxsize $boxsize
		#
		readinterp aphii
		readinterp aphif
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		#
                set newiaphii=(radius>Rinold) ? iaphii : $missing_data
                set iaphii=newiaphii
                set newiaphif=(radius>Rinold) ? iaphif : $missing_data
		set iaphif=newiaphif
                #
		#
		# get ix,iy
		plcnoplot 0 iaphii 010
		set myi=newfun
		plcnoplot 0 iaphif 010
		set myf=newfun
		plcnoplot 0 myradiusdiff 010
		set myrdiffone=newfun
		#
		#
		#
		#
		erase
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		#
		#######
		####### initial
		#######
		ticksize 0 0 0 0
		limits 0 $plotsize -$plotsize $plotsize
		ctype default window -7 20 1:2 1:13 box 1 2 0 0
		#
		define cres 32
		define minc (0.00)
		define maxc (1.32)
		#
		set image[ix,iy]=myi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphif 010
		xla $x1label
		yla $x2label
		#
		set image[ix,iy]=myrdiffone
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#######
		####### final
		#######
		ticksize 0 0 0 0
		limits 0 $plotsize -$plotsize $plotsize
		ctype default window -7 20 3:4 1:13 box 1 0 0 0
		#
		define cres 32
		define minc (0.00)
		define maxc (1.32)
		#
		set image[ix,iy]=myf
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphii 010
		xla $x1label
		#yla $x2label
		#
		#
		set image[ixone,iyone]=myrdiffone
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#######
		####### final large scale
		jrdp dump0200
		interpsingle aphiffull $interpnx $interpny 100 100
		readinterp aphiffull
		#
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		set myradiusdiff2=radius-Rout*.95
		plcnoplot 0 myradiusdiff 010
		set myrdifftwo=newfun
		plcnoplot 0 myradiusdiff2 010
		set myrdifftwo2=newfun
		#
                set newiaphiffull=((radius>Rinold)&&(radius<Rout*0.95)) ? iaphiffull : $missing_data
                set iaphiffull=newiaphiffull
		plcnoplot 0 iaphiffull 010
		set myfull=newfun
		#
		#######
		ticksize 0 0 0 0
		limits 0 99.9 -99.9 99.9
		ctype default window 7 20 5:7 1:13 box 1 2 0 0
		#
		define cres 32
		define minc (0.00)
		define maxc (1.32)
		#
		set image[ix,iy]=myfull
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphii 010
		xla $x1label
		#yla $x2label
		#
		#
		set image[ix,iy]=myrdifftwo
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set image[ix,iy]=myrdifftwo2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#
		#
		#
		#
		#
		#
angplotsplit1  0 #
		#
		jrdp dump0000
		gammiegridnew3 gdump
		# get B0 as defined by Kom04a
		set B0=B1*dxdxp11*gdetks/sin(h)
		#set B0=h*0+2.0
		#
		jrdp dump0200
		faraday
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		fdraft
		#
		erase
		lweight 3
		#
		#
		define x1label "\theta"
		#
		#######
		####### omegaf2/omegah
		#######
		define x2label "\Omega_F/\Omega_H"
		#
		ticksize 0 0 0 0
		limits 0 3.14159 0 0.8
		ctype default window 2 2 1 2 box 1 2 0 0
		#
		#
		set omegah=a/(2.0*$rhor)
		#
		xla $x1label
		yla $x2label
		set rat=omegaf2/omegah
		setlimits 1.43 1.44 0 pi 0 0.81 plflim 0 x2 r h rat 1 001
		#######
		####### omegaf2/omegah
		#######
		ticksize 0 0 0 0
		limits 0 3.14159 0 0.8
		ctype default window 2 2 1 1 box 1 2 0 0
		#
		#
		setlimits 20 21 0 pi 0 0.81 plflim 0 x2 r h rat 1 001
		xla $x1label
		yla $x2label
		#
		#######
		####### Bphi
		#######
		define x2label "B_\phi, B^r/3, B^\theta"
		#
		#set Bphiprime=-gdet*fuu12*B1
		# convert from KSP to KS for diagonal dxdxp
		set fuu12ks=-dxdxp11*fuu12*dxdxp22
		set gdetks=0.5*(a**2+2*r**2+a**2*cos(2*h))*sin(h)
		set Bphiprime=-gdetks*fuu12ks/B0
		#
		set myB1=-B1/3*dxdxp11/B0
		set myB2=B2*dxdxp22/B0
		#
		#
		#set Bphiprime=-gdet*fuu12*B1
		#set Bphiprime=-gdet*fuu12
		#set Bphiprime=-fuu12
		#
		ticksize 0 0 0 0
		limits 0 3.14159 -1.0 1.0
		ctype default window 2 2 2 2 box 1 2 0 0
		#
		#
		#
		ctype default ltype 0
		setlimits 1.43 1.44 0 pi 0 0.81 plflim 0 x2 r h Bphiprime 0 001
		ctype default ltype 2
		setlimits 1.43 1.44 0 pi 0 0.81 plflim 0 x2 r h myB1 0 001
		ctype default ltype 3
		setlimits 1.43 1.44 0 pi 0 0.81 plflim 0 x2 r h myB2 0 001
		xla $x1label
		yla $x2label
		#######
		####### Bphi
		#######
		ticksize 0 0 0 0
		limits 0 3.14159 -1.0 1.0
		ctype default window 2 2 2 1 box 1 2 0 0
		#
		#
		ctype default ltype 0
		setlimits 20 21 0 pi 0 0.81 plflim 0 x2 r h Bphiprime 0 001
		ctype default ltype 2
		setlimits 20 21 0 pi 0 0.81 plflim 0 x2 r h myB1 0 001
		ctype default ltype 3
		setlimits 20 21 0 pi 0 0.81 plflim 0 x2 r h myB2 0 001
		xla $x1label
		yla $x2label
		#
		#
		#
		#
		#
		#
		#
		#       
walda0 0      #
		#
		# ~/sm/iinterp 1 2 1 1 64 64 1  2.0 0 0  0  64 128 1  0 100 -100 100 0 0  1.3097 100 0 1 0 < ./dumps/aphii  > ./dumps/iaphii
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		####################
		jrdp dump0000
		set Rinold=Rin
		#
		define interpnx 256
		define interpny 256
		fieldcalc 0 aphii
		interpsingle aphii $interpnx $interpny 6 6
		#interpsingle aphii
		#jrdp dump0122
		jrdp dump0400
		fieldcalc 0 aphif
		interpsingle aphif $interpnx $interpny 6 6
		#interpsingle aphif
		#
		readinterp aphii
		readinterp aphif
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		#
                set newiaphii=(radius>Rinold) ? iaphii : $missing_data
                set iaphii=newiaphii
                set newiaphif=(radius>Rinold) ? iaphif : $missing_data
                set iaphif=newiaphif
                #
		#
		# get ix,iy
		plc 0 iaphii 010
		set myi=newfun
		plc 0 iaphif 010
		set myf=newfun
		#
		plc0 0 myradiusdiff 010
		set myrdiff=newfun
		#
		#
		erase
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		#
		#######
		####### initial
		#######
		ticksize 0 0 0 0
		limits 0 4.5 -4.5 4.5
		ctype default window -2 20 1 1:19 box 1 2 0 0
		#
		define cres 32
		#define minc (-20.287)
		define minc (-19.4533062)
		#define maxc (3.9)
		#define maxc (4.0)
		define maxc (0)
		#
		set image[ix,iy]=myi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphif 010
		xla $x1label
		yla $x2label
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#######
		####### final
		#######
		ticksize 0 0 0 0
		limits 0 4.5 -4.5 4.5
		ctype default window -2 20 2 1:19 box 1 0 0 0
		#
		define cres 32
		#define minc (-193.54)
		define minc (-29208.41602)
		#define minc (-29209)
		define maxc (0)
		#
		set image[ix,iy]=myf
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		#plc 0 iaphii 010
		xla $x1label
		#yla $x2label
		#
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set t=0,pi,.001
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
aphiequalize 0  #
		# not a quick calculation
		#
		do ii=0,$nx*$ny*$nz-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   set indexk=INT($ii/($nx*$ny))
		   define tempi (indexi)
		   define tempj (indexj)
		   define tempk (indexk)
		   #
		   set symii=($ny-1-indexj)*$nx+indexi
		   #
		   if(indexi==0) { echo $tempj }
		   if(indexj<=$ny/2) {\
		   
		   set aphi[$ii]=0.5*(aphi[$ii]+aphi[symii])
		   #
		}
		   if(indexj>$ny/2) {\
		   set aphi[$ii]=aphi[symii]
		   #
		}
		
		}
		#
debug1 0 #
		#
		da ./dumps/iaphii
		lines 1 1000000
		read {myi 1 pi 2 pj 3 xp1 4 xp2 5 yap 6 y1ap 7 y2ap 8 y12ap 9 yap2 10}
		set pickit=2
		set reali=myi if(myi==pickit)
		set realj=myj if(myi==pickit)
		set realxp1=xp1 if(myi==pickit)
		set realxp2=xp2 if(myi==pickit)
		set realyap=yap if(myi==pickit)
		set realy1ap=y1ap if(myi==pickit)
		set realy2ap=y2ap if(myi==pickit)
		set realy12ap=y12ap if(myi==pickit)
		set realyap2=yap2 if(myi==pickit)
		#
debug2 0 ##
		da ./dumps/iaphii
		lines 1 1000000
		read {ya 1 y1a 2 y2a 3 y12a 4}
		
walda91 0 ##
		#
		# ~/sm/iinterp 1 2 1 1 64 64 1  2.0 0 0  0  64 128 1  0 100 -100 100 0 0  1.3097 100 0 1 0 < ./dumps/aphii  > ./dumps/iaphii
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		erase
		fdraft
		#
		set komcomp=1
		#
		####################
		if(komcomp==1){\
		       jrdp dump0126
		       #jrdp dump0000
		    }
		if(komcomp==0){\
		           jrdp dump0200
		        }
		if(komcomp==2){\
		           jrdp dump0200
		        }
		#jrdp dump0120
		#jrdp dump0130
		set Rinold=Rin
		gammiegridnew3 gdump
		#
		#
		if(komcomp==1){\
		       define boxsize 3
		       define plotsize 2.9
		    }
		if(komcomp==0){\
		       define boxsize 100
		       define plotsize 59.9
		    }
		if(komcomp==2){\
		       define boxsize 20
		       define plotsize 14.9
		    }
		#
		define interpnx 256
		define interpny 256
		faraday
		fieldcalc 0 aphi
		set ergor=r-(1+sqrt(1-(a*cos(h))**2))
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		#set lights=(r>rhor) ? 1 : lights
		#
		interpsingle omegaf2 $interpnx $interpny $boxsize $boxsize
		interpsingle aphi $interpnx $interpny $boxsize $boxsize
		interpsingle bsq $interpnx $interpny $boxsize $boxsize
		interpsingle ergor $interpnx $interpny $boxsize $boxsize
		interpsingle lights $interpnx $interpny $boxsize $boxsize
		#
		readinterp omegaf2
		readinterp aphi
		readinterp bsq
		readinterp ergor
		readinterp lights
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		#
                set newiomegaf2=(radius>Rinold) ? iomegaf2 : $missing_data
                set iomegaf2=newiomegaf2
                #
                set newiaphi=(radius>Rinold) ? iaphi : $missing_data
                set iaphi=newiaphi		
                #
                set newibsq=(radius>Rinold) ? ibsq : $missing_data
                set ibsq=newibsq		
		#
                set newiergor=(radius>Rinold) ? iergor : $missing_data
                set iergor=newiergor		
		#
                set newilights=(radius>Rinold) ? ilights : $missing_data
                set ilights=newilights		
		#
		# get ix,iy
		plc 0 iomegaf2 010
		set mywf2=newfun
		plc 0 iaphi 010
		set myaphi=newfun
		plc 0 ibsq 010
		set mybsq=newfun
		plc 0 iergor 010
		set myergor=newfun
		plc 0 ilights 010
		set mylights=newfun
		#
		plc0 0 myradiusdiff 010
		set myrdiff=newfun
		#
		plotwalda91
		#
plotwalda91 0   #
		#
		#
		#
		erase
		lweight 3
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		#
		#######
		####### omegaf2
		#######
		ticksize 0 0 0 0
		limits 0 $plotsize -$plotsize $plotsize
		ctype default window -3 4 1 1:3 box 1 2 0 0
		#
		define cres 15
		define maxc (0.67)
		#define maxc (0.167)
		define minc (0)
		#
		set omegah=a/(2.0*$rhor)
		#
		set image[ix,iy]=mywf2/omegah
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		yla $x2label
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#
		set image[ix,iy]=iergor
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#		
		set image[ix,iy]=ilights
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		relocate 6.3 -.25
		putlabel 5 "-"
		relocate 12.3 0
		putlabel 5 "+"
		#######
		####### aphi
		#######
		ticksize 0 0 0 0
		limits 0 $plotsize -$plotsize $plotsize
		ctype default window -3 4 2 1:3 box 1 0 0 0
		#
		define cres 15
		define maxc (0)
		if(komcomp==1){\
		       define minc (-10)
		    }
		if(komcomp==0){\
		       define minc (-6087)
		    }
		if(komcomp==2){\
		           define cres (50)
		       define minc (-230)
		    }
		#
		set image[ix,iy]=myaphi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		#yla $x2label
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#		
		set image[ix,iy]=iergor
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#
		set image[ix,iy]=ilights
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		#######
		####### bsq
		#######
		ticksize 0 0 0 0
		limits 0 $plotsize -$plotsize $plotsize
		ctype default window -3 4 3 1:3 box 1 0 0 0
		#
		define cres 15		
		define minc (0)
		#define maxc (14)
		if(komcomp==1){\
		       define maxc (37)
		       #define maxc (9.4)
		       #define maxc (3.14)
		    }
		if(komcomp==0){\
		       define maxc (4.16)
		    }
		#
		if(komcomp==2){\
		       define cres 50
		       define maxc (37)
		    }
		#
		set image[ix,iy]=mybsq
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		#yla $x2label
		#
		set image[ix,iy]=myrdiff
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype default contour
		#		
		set image[ix,iy]=iergor
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#
		set image[ix,iy]=ilights
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5 ctype default contour
		lweight 3
		#		
		set t=0,pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
angularplot1  0 #
		#
		jrdp dump0000
		gammiegridnew3 gdump
		# get B0 as defined by Kom04a
		# B0 for BZ
		#set B0=B1*dxdxp11*gdetks/sin(h)
		# B0 for wald
		set B0=h*0+2.0
		#
		jrdp dump0126
		faraday
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		fdraft
		#
		erase
		lweight 3
		#
		#
		define x1label "\theta"
		#
		#######
		####### omegaf2/omegah
		#######
		define x2label "\Omega_F/\Omega_H"
		#
		ticksize 0 0 0 0
		limits 0 3.14159 0 0.8
		ctype default window 2 2 1 2 box 1 2 0 0
		#
		#
		set omegah=a/(2.0*$rhor)
		#
		xla $x1label
		yla $x2label
		set rat=omegaf2/omegah
		setlimits 1.75 1.76 0 pi 0 0.81 plflim 0 x2 r h rat 1 001
		#######
		####### omegaf2/omegah
		#######
		ticksize 0 0 0 0
		limits 0 3.14159 0 0.8
		ctype default window 2 2 1 1 box 1 2 0 0
		#
		#
		setlimits 2.59 2.6 0 pi 0 0.81 plflim 0 x2 r h rat 1 001
		xla $x1label
		yla $x2label
		#
		#######
		####### Bphi
		#######
		define x2label "B_\phi, B^r/3, B^\theta"
		#
		#set Bphiprime=-gdet*fuu12*B1
		# convert from KSP to KS for diagonal dxdxp
		set fuu12ks=-dxdxp11*fuu12*dxdxp22
		set gdetks=0.5*(a**2+2*r**2+a**2*cos(2*h))*sin(h)
		set Bphiprime=-gdetks*fuu12ks/B0
		#
		set myB1=-B1/3*dxdxp11/B0
		set myB2=B2*dxdxp22/B0
		#
		#
		#set Bphiprime=-gdet*fuu12*B1
		#set Bphiprime=-gdet*fuu12
		#set Bphiprime=-fuu12
		#
		ticksize 0 0 0 0
		limits 0 3.14159 -1.0 1.0
		ctype default window 2 2 2 2 box 1 2 0 0
		#
		#
		#
		ctype default ltype 0
		setlimits 1.75 1.76 0 pi 0 0.81 plflim 0 x2 r h Bphiprime 0 001
		ctype default ltype 2
		setlimits 1.75 1.76 0 pi 0 0.81 plflim 0 x2 r h myB1 0 001
		ctype default ltype 3
		setlimits 1.75 1.76 0 pi 0 0.81 plflim 0 x2 r h myB2 0 001
		xla $x1label
		yla $x2label
		#######
		####### Bphi
		#######
		ticksize 0 0 0 0
		limits 0 3.14159 -1.0 1.0
		ctype default window 2 2 2 1 box 1 2 0 0
		#
		#
		ctype default ltype 0
		setlimits 2.59 2.6 0 pi 0 0.81 plflim 0 x2 r h Bphiprime 0 001
		ctype default ltype 2
		setlimits 2.59 2.6 0 pi 0 0.81 plflim 0 x2 r h myB1 0 001
		ctype default ltype 3
		setlimits 2.59 2.6 0 pi 0 0.81 plflim 0 x2 r h myB2 0 001
		xla $x1label
		yla $x2label

bzpureplot1  0 #
		#
		jrdp dump0000
		gammiegridnew3 gdump
		# get B0 as defined by Kom04a
		set B0=B1*dxdxp11*gdetks/sin(h)
		#
		jrdp dump0050
		faraday
		jsq
		#
		fdraft
		angle 0
		ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		expand 1.3
		lweight 2
		fdraft
		#
		erase
		lweight 3
		#
		#
		define x1label "\theta"
		#
		#######
		####### omegaf2/omegah
		#######
		define x2label "\Omega_F/\Omega_H"
		#
		ticksize 0 0 0 0
		#limits 0 3.14159 0.49 0.51
		limits 0 3.14159 0.41 0.6
		ctype default window 2 -3 2 3 box 0 2 0 0
		#
		#
		#
		#
		set omegah=a/(2.0*$rhor)
		set ratbz=0.5+0*r
		#
		#xla $x1label
		yla $x2label
		set rat=omegaf2/omegah
		lweight 0 ltype 10 setlimits 3.0 3.05 0 pi 0 0.6 plflim 0 x2 r h rat 1 001
		expand 0.5 lweight 3 ltype 0 ptype 4 0 angle 45 points newx newfun
		expand 1.5 lweight 3 ltype 0 angle 0
		angle 0
		#ltype 2 setlimits 3.0 3.1 0 pi 0 0.6 plflim 0 x2 r h ratbz 1 001
		#ltype 0
		#######
		####### Bphi
		#######
		define x2label "B_\phi, -B^r/10, B^\theta"
		notation -3 3 -3 3
		#
		#set Bphiprime=-gdet*fuu12*B1
		# convert from KSP to KS for diagonal dxdxp
		set fuu12ks=-dxdxp11*fuu12*dxdxp22
		set gdetks=0.5*(a**2+2*r**2+a**2*cos(2*h))*sin(h)
		set Bphiprime=-gdetks*fuu12ks/B0
		#
		ticksize 0 0 0 0
		limits 0 3.14159 -.015 .005
		ctype default window 2 -3 2 2 box 1 2 0 0
		#
		set myB1=-B1*0.1*dxdxp11/B0
		set myB2=B2*dxdxp22/B0
		#
		#
		ctype default ltype 0
		lweight 0 ltype 10 setlimits 3.0 3.05 0 pi 0 0.81 plflim 0 x2 r h Bphiprime 0 001
		expand 0.5 lweight 3 ltype 0 ptype 4 0 angle 45 points newx newfun
		expand 1.5 lweight 3 ltype 0 angle 0
		set bzsolution=-1/8*a*sin(newx)**2
		connect newx bzsolution
		#
		ctype default ltype 2
		setlimits 3.0 3.05 0 pi 0 0.81 plflim 0 x2 r h myB1 0 001
		ctype default ltype 3
		setlimits 3.0 3.05 0 pi 0 0.81 plflim 0 x2 r h B2 0 001
		xla $x1label
		yla $x2label
		#######
		####### EdotB
		#######
		define x2label "E.B"
		define x1label "r c^2/GM"
		#
		#
		ticksize 0 0 -1 0
		define downvalue (-22)
		define upvalue (-20)
		limits 1.396 5.0 $downvalue $upvalue
		ctype default window 2 6 2 1:2 box 1 2 0 0
		#
		set myedotb=LG(ABS(edotb/B0**2)+1E-21)
		#
		define onepole (pi-0.1)
		define twopole (0.1)
		#
		ctype default ltype 0
		setlimits Rin 5.0 $twopole ($twopole*1.001) 0 1 plflim 0 x1 r h myedotb 0 001
		setlimits Rin 5.0 $onepole ($onepole*1.001) 0 1 plflim 0 x1 r h myedotb 0 001
		xla $x1label
		yla $x2label
		#
neutronstar1  0 # /home/jondata/pulsarffde/kommycompare/
		#
		gammiegridnew3 gdump
		#jrdp dump0038
		jrdp dump0012
		faraday
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		fieldcalc 0 aphi
		interpsingle aphi 512 512 75 75
		interpsingle lights 512 512 75 75
		readinterp aphi
		readinterp lights
		#
		plc 0 iaphi 001 0 75 -35 35
		set myaphi=newfun
		plc 0 ilights 001 0 75 -35 35
		set mylights=newfun
		#
		nsplot1
		#
nsplot1   0     #
		fdraft
		erase
		#
		limits 0 75 -35 35
		box
		define x2label "z c^2/GM"
		define x1label "R c^2/GM"
		xla $x1label
		yla $x2label
		define cres 44
		#define minc (-.43)
		define minc (0)
		#define maxc (2.4)
		define maxc (13)
		#
		set image[ix,iy]=myaphi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		contour
		#
		define minc (2.285)
		define maxc (2.2851)
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype blue contour
		#
		set lev=-1E-15,1E-15,2E-15 levels lev
		set image[ix,iy]=mylights
		levels lev
		ctype default lweight 5 ltype 0 contour
		lweight 3
		#
		#
averytest 0    #
		jrdpcf dump0008
		faraday
		gammiegridnew3 gdump
		jsq
		fieldcalc 0 aphi
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 aphi
		#
		#set ju1o=ju1*sqrt(gv311)
		#set ju2o=ju2*sqrt(gv322)
		#set ju3o=ju3*sqrt(gv333)
		#set B1o=B1*sqrt(gv311)
		#set B2o=B2*sqrt(gv322)
		#set B3o=B3*sqrt(gv333)
		#set jcrossB=(ju1o*B2o-ju2o*B1o)
		#set jsq=ju1o*ju1o+ju2o*ju2o
		#set Bsq=B1o*B1o+B2o*B2o
		#set final=jcrossB/sqrt(jsq*Bsq)
		#
		#define POSCONTCOLOR red
		#define NEGCONTCOLOR red
		#plc 0 final 010

		set ephi=fdd03/gdet
		set final=ephi/sqrt(bsq)
		plc 0 final 

tests3 0        #
		jrdpbz dump0008
		faraday
		define UNITVECTOR 1
		#define UNITVECTOR 0
		#set jx=ju1o
		#set jy=ju2o
		#set jx=ju1
		#set jy=ju2
		#set x22=x2*pi
		set jx=ju1*gdet*$dx2
		set jy=ju2*gdet*$dx1
		fieldcalc 0 aphi
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		plc 0 aphi
		set image[ix,iy]=lights
		set lev=-1E-15,1E-15,2E-15 levels lev
		ctype blue contour
		ctype default vpl 0 j 1 12 110
		set vx=(dxdxp11*uu1+dxdxp12*uu2)/uu0
		set vy=(dxdxp21*uu1+dxdxp22*uu2)/uu0
		#ctype default vpl 0 v 1 12 110
		#
		#vpl 0 j 1000 12 110

		#
		
		#
		
tests1 0       #
		jrdp dump0037
		faraday
		#
		set avg1=SUM(abs(uu1/B1))/dimen(uu1)
		set avg2=SUM((abs(uu1/B1)+abs((uu3-uu0*omegaf2)/B3)))/dimen(uu1)
		set avg3=SUM((abs(uu2/B2)+abs((uu3-uu0*omegaf2)/B3)))/dimen(uu1)
		#
		# hmm, like machine precision
		set freeze1=uu1/B1-(uu3-uu0*omegaf2)/B3
		set freeze1n=(uu1/B1-(uu3-uu0*omegaf2)/B3)/(abs(uu1/B1)+abs((uu3-uu0*omegaf2)/B3))
		set freeze1n2=(uu1/B1-(uu3-uu0*omegaf2)/B3)/avg1
		set freeze1n3=(abs(freeze1n2)>1) ? 1 : freeze1n2
		set freeze2=(uu1/B1-uu2/B2)
		set freeze2n=(uu1/B1-uu2/B2)/(abs(uu1/B1)+abs(uu2/B2))
		set freeze2n2=(uu1/B1-uu2/B2)/avg2
		set freeze2n3=(abs(freeze2n2)>1) ? 1 : freeze2n2
		set freeze3=uu2/B2-(uu3-uu0*omegaf2)/B3
		set freeze3n=(uu2/B2-(uu3-uu0*omegaf2)/B3)/(abs(uu2/B2)+abs((uu3-uu0*omegaf2)/B3))
		set freeze3n2=(uu2/B2-(uu3-uu0*omegaf2)/B3)/avg3
		set freeze3n3=(abs(freeze3n2)>1) ? 1 : freeze3n2
		#
		plc0 0 freeze2
		
tests2 0        #		
		
		#
		jrdpcf dump0008
		faraday
		jsq
		fieldcalc 0 aphi
		define cres 128
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 aphi 001 0 60 0 pi
		define cres 1024
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR blue
		set it1=ju1*gdet*$dx2
		plc 0 it1 011 0 60 0 pi
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		set it2=ju2*gdet*$dx1
		plc 0 it2 011 0 60 0 pi
		#

tests4 0        #
		#
		jrdp dump0038
		faraday
		set diffomegaf=(omegaf1-omegaf2)/(abs(omegaf1)+abs(omegaf2))
		plc 0 diffomegaf
		#
tests5 0        #
		define cres 50
		fieldcalc 0 aphi
		fieldtcalc 0 At
		#plc 0 At
		set god=(At/aphi)
		set ratio=(abs(god)>1) ? 1 : god
		#plc 0 ratio 001 Rin Rout 0.3 2.84
		pls 0 ratio 101 Rin Rout 0.3 2.84
		#
		#
tests6  0       #
		jrdp dump0040
		faraday
		fieldcalc 0 aphi
		set myBd3=-gdet*fuu12
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 aphi 001 4.5 10 0 pi
		define POSCONTCOLOR red
		define NEGCONTCOLOR white
		plc 0 myBd3 011 4.5 10 0 pi
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR blue
		plc 0 omegaf2 011 4.5 10 0 pi
		#
tests7   0      #
		jrdp dump0040
		fieldcalc 0 aphi
		stresscalc 1
		set EN1=-Tud10/B1
		set myB1o=(B1*dxdxp11+B2*dxdxp12)
		set EN1=(ABS(gdet*B1)<5) ? 0 : EN1
		set EN2=-Tud20/B2
		set EN2=(ABS(gdet*B1)<5) ? 0 : EN2
		#
		define myRin 4.5
		define myRout 80
		define cres 16
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 aphi 001 $myRin $myRout 0 pi
		define POSCONTCOLOR red
		define NEGCONTCOLOR white
		plc 0 EN1 011 $myRin $myRout 0 pi
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR blue
		plc 0 EN2 011 $myRin $myRout 0 pi
		#
currenttest1 0  #
		jrdp dump0001
		faraday
		set one=gdet*fuu01
		set two=gdet*fuu02
		# centered difference
		dercalc 0 one done
		dercalc 0 two dtwo
		set myjcon0=1/gdet*(donex+dtwoy)
		#
anothertest1 0  #
		# don't plot first point
		define firstr (r[0]*1.001)
		pls 0 B1    101 $firstr 15 -3 6
		pls 0 omegaf1    101 $firstr 15 -3 6
		pls 0 fdd01    101 $firstr 15 -3 6
		set Ed1=fdd10/gdet
		set Ed2=fdd20/gdet
		set Ed3=fdd30/gdet
		set myomega1=gdet*Ed1/(gdet*B2)
		set myomega2=gdet*Ed2/(-gdet*B1)
		#
		set vu1=uu1/uu0
		set vu2=uu2/uu0
		set vu3=uu3/uu0
		set myBd3=-gdet*fuu12
		set E1perB1=omegaf2*myBd3
		#
		# very small part
		set part1=-vu1*B3/B1
		#
		set newomega=part1+vu3
		pls 0 newomega    101 $firstr 15 -3 6
		#
		# Ed2:
		#
		set part1=vu3*B1
		set part2=-vu1*B3
		# big jump
		pls 0 part1    101 $firstr 15 -3 6
		#
		# very small
		pls 0 part2    101 $firstr 15 -3 6     		
sashatest1  0   #
		jrdp dump0040
		fieldcalc 0 aphi
		faraday
		#
		define cres 16
		define startr (r[0]*1.01)
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 aphi 001 $startr 15 0 pi
		define POSCONTCOLOR blue
		define NEGCONTCOLOR cyan
		plc 0 omegaf2 011 $startr 15 0 pi
		#
		define cres 0
		plc 0 h  011 $startr 15 0 pi
		set lev=0.3,0.31,0.01
		levels lev
		ctype green contour
		#
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h B2 0
		points newx newfun
		#
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h B1 0
		points newx newfun
		#
		dercalc 0 B2 dB2
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h dB2x 0
		points newx newfun
		#
		dercalc 0 B1 dB1
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h dB1x 0
		points newx newfun
		#
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h h 0
		points newx newfun
		#
		dercalc 0 omegaf2 domegaf2
		setlimits $startr 15 0.3 0.31 0 1 plflim 0 x1 r h domegaf2x 0
		points newx newfun
		#
		set Ed1=fdd10/gdet
		set Ed2=fdd20/gdet
		set Ed3=fdd30/gdet
		set myomega1=gdet*Ed1/(gdet*B2)
		set myomega2=gdet*Ed2/(-gdet*B1)
		#
		set vu1=uu1/uu0
		set vu2=uu2/uu0
		set vu3=uu3/uu0
		set myBd3=-gdet*fuu12
		set E1perB1=omegaf2*myBd3
		#
		define cres 16
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		set it1=gdet*Ed1*$dx1
		set it2=gdet*Ed2*$dx2
		plc 0 it1  001 $startr 15 0 pi
		#
		set codei=0
		set codej=12
		set it1l=it1[(codej+3)*$nx+(codei+3)]
		set codei=0
		set codej=13
		set it1r=it1[(codej+3)*$nx+(codei+3)]
		#
		set codei=0
		set codej=12
		set it1l=it1[(codej+3)*$nx+(codei+3)]
		set codei=0
		set codej=13
		set it1r=it1[(codej+3)*$nx+(codei+3)]
		# it1~.00285
		# it2~-.0164
		
		#
		set myB1=gdet*B1
		set myB2=gdet*B2
		dercalc 0 myB1 dmyB1
		dercalc 0 myB2 dmyB2
		set mydivb=dmyB1x+dmyB2y
		set startr (0.5*(r[2]+r[1]))
		plc 0 mydivb 001 $startr 20 -3 6
		#
		pls 0 mydivb 101 $startr 20 -3 6
plotk1 0        #
		#jrdp dump0026
		#jrdp dump0012
		#jrdp dump0042
		faraday
		#set wf2rat=omegaf2/0.0206309
		set wf2rat=omegaf2/0.0216
		#
		ctype default
		setlimits 4.5 4.5 0 pi 0.5 1.2
		plflim 0 x2 r h wf2rat 1
		set newfun=newfun if(newx<=pi)
		set ratr=reverse(newfun)
		set ratavg4=0.5*(ratr+newfun)
		set mynewx4=newx if(newx<=pi)
		#
		ctype red 
		setlimits 9 9.1 0 pi 0.5 1.2
		plflim 0 x2 r h wf2rat 1 001
		set newfun=newfun if(newx<=pi)
		set ratr=reverse(newfun)
		set ratavg1=0.5*(ratr+newfun)
		set mynewx1=newx if(newx<=pi)
		#
		ctype blue
		setlimits 32 32.1 0 pi 0.5 1.2
		plflim 0 x2 r h wf2rat 1 001
		set newfun=newfun if(newx<=pi)
		set ratr=reverse(newfun)
		set ratavg2=0.5*(ratr+newfun)
		set mynewx2=newx if(newx<=pi)
		#
		ctype cyan
		setlimits 5 5.01 0 pi 0.5 1.2
		plflim 0 x2 r h wf2rat 1 001
		#points newx newfun
		set newfun=newfun if(newx<=pi)
		set ratr=reverse(newfun)
		set ratavg3=0.5*(ratr+newfun)
		set mynewx3=newx if(newx<=pi)
		#
		#
plotk2
		#
		ctype default pl 0 mynewx4 ratavg4 0001 0 pi 0.5 1.2
		#points mynewx4 ratavg4
		ctype red pl 0 mynewx1 ratavg1 0011 0 pi 0.5 1.2
		points mynewx1 ratavg1
		ctype blue pl 0 mynewx2 ratavg2 0011 0 pi 0.5 1.2
		points mynewx2 ratavg2
		ctype cyan pl 0 mynewx3 ratavg3 0011 0 pi 0.5 1.2
		points mynewx3 ratavg3
		#
B2change 0 #
		jrdp dump0000
		define NEGCONTCOLOR red	
		define POSCONTCOLOR red
		plc 0 B3 001 0 10 -3 6
		jrdp dump0069
		define NEGCONTCOLOR blue
		define POSCONTCOLOR blue
		plc 0 B3 011 0 10 -3 6
		#
		#
agplk1  0	# agplk1
		#
		set h1='dump'
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename

		  plotk1
		   
		}
		#
		########################################
		# plots
		#
rplotk1 0       # as in Kom05b figure 6LL
		#jrdp dump0069
		plotk1
		plotk2
		#
		erase
		fdraft
		#
		define x1label "\theta"
		define x2label "\Omega_F/\Omega_{*}"
		#ctype default pl 0 mynewx4 ratavg4 0001 0 pi 0.5 1.2
		ltype 0 ctype default pl 0 mynewx1 ratavg1 0001 0 pi 0.5 1.2
		#points mynewx1 ratavg1
		ltype 2 ctype default pl 0 mynewx2 ratavg2 0011 0 pi 0.5 1.2
		#points mynewx2 ratavg2
		#ctype cyan pl 0 mynewx3 ratavg3 0011 0 pi 0.5 1.2
		#points mynewx3 ratavg3
		#
		da highres.dat
		lines 1 100000
		read {hmynewx1 1 hratavg1 2}
		read {hmynewx2 3 hratavg2 4}
		#
		set hratavg1=hratavg1*0.8
		set hratavg2=hratavg2*0.8
		#
		ltype 0 ctype default pl 0 hmynewx1 hratavg1 0011 0 pi 0.5 1.2
		ltype 2 ctype default pl 0 hmynewx2 hratavg2 0011 0 pi 0.5 1.2
		#
		#print highres.dat {mynewx1 ratavg1 mynewx2 ratavg2}
		#
rplotk2 1       # rplotk2 <whether need to exclude boundary zones>
		# medium-scale A_\phi
		#
		define cres 80
		#
		# jrdpcf dump0021
		#
		#jrdp dump0533
		#gammiegridnew3 gdump
		#
		faraday
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		set Rinold=4.84
		fdraft
		fieldcalc 0 aphi
		plc 0 aphi
		define minc $min
		define maxc $max
		#
		if($1==1){\
		set _n1=$nx-6
		set _n2=$ny-6
		define nx (_n1)
		define ny (_n2)
		set use=((ti>=0)&&(ti<_n1)&&(tj>=0)&&(tj<_n2)) ? 1 : 0
		}
		if($1==0){\
		       set use=1+ti*0
		}
		#
		set myaphi=aphi if(use)
		set mylights=lights if(use)
		set myjd0=jd0 if(use)
		#
		interpsingle myaphi 512 512 138.489 69.2444
		interpsingle mylights 512 512 138.489 69.2444
		interpsingle myjd0 512 512 138.489 69.2444
		#
		#
		readinterp myaphi
		readinterp mylights
		readinterp myjd0
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
                set newaphi=(radius>Rinold) ? imyaphi : $missing_data
                set iaphi=newaphi
                set newlights=(radius>Rinold) ? imylights : $missing_data
                set ilights=newlights
                set newjd0=(radius>Rinold) ? imyjd0 : $missing_data
                set ijd0=newjd0
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^z/GM"
		#
		plc 0 iaphi 001 0 138.489 -69.2444 69.2444
		set myiaphi=newfun
		plc 0 ilights 001 0 138.489 -69.2444 69.2444
		set myilights=newfun
		plc 0 ijd0 001 0 138.489 -69.2444 69.2444
		set myijd0=newfun
		#
plotrk2 0       #
		#
		erase
		lweight 3
		ltype 0
		box
		#
		ltype 0
		set image[ix,iy]=myiaphi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		yla $x2label
		#
		#set lev=1.5739,1.5739+1E-15,1E-15 levels lev ltype 2 ctype default contour
		lweight 10 set lev=1.55,1.55+1E-15,1E-15 levels lev ltype 2 ctype default contour
		ltype 0
		lweight 3
		#
		if(0){\
		set image[ix,iy]=myilights
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ltype 5
		ctype default contour
		#
		}
		ltype 0
		ctype default
		#
		if(1){\
		set image[ix,iy]=myijd0
		set lev=-1E-15,1E-15,2E-15
		levels lev
		lweight 5
		ltype 0
		ctype blue contour
		#
		}
		lweight 3
		ltype 0
		ctype default
		#
		#
		#
		# circle
		set t=0,pi,.01
		set x=Rinold*sin(t)
		set y=Rinold*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#shade 1000 x12 (sqrt(Rinold**2+x22**2))
		#
		set x=0,1,1
		set x[0]=1/.0216
		set x[1]=x[0]
		set y=0,1,1
		set y[0]=-100
		set y[1]=100
		connect x y
		#
rplotk3 1       #
		# small-scale A_\phi
		#
		define cres 80
		#
		#jrdp dump0533
		#gammiegridnew3 gdump
		#
		faraday
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		set Rinold=4.84
		fdraft
		fieldcalc 0 aphi
		plc 0 aphi
		define minc $min
		define maxc $max
		#
		if($1==1){\
		set _n1=$nx-6
		set _n2=$ny-6
		define nx (_n1)
		define ny (_n2)
		set use=((ti>=0)&&(ti<_n1)&&(tj>=0)&&(tj<_n2)) ? 1 : 0
		}
		if($1==0){\
		       set use=1+ti*0
		}
		#
		set myaphi=aphi if(use)
		set mylights=lights if(use)
		#
		interpsingle myaphi 512 512 60 10
		interpsingle mylights 512 512 60 10
		#
		#
		readinterp myaphi
		readinterp mylights
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
                set newaphi=(radius>Rinold) ? imyaphi : $missing_data
                set iaphi=newaphi
                set newlights=(radius>Rinold) ? imylights : $missing_data
                set ilights=newlights
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^z/GM"
		#
		#
		plc 0 iaphi 001 40 60 -10 10
		set myiaphi=newfun
		plc 0 ilights 001 40 60 -10 10
		set myilights=newfun
		#
		erase
		box
		#
		define minc 1.33
		define maxc 2.2
		#
		set image[ix,iy]=myiaphi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		yla $x2label
		#
		#set lev=1.5739,1.5739+1E-15,1E-15 levels lev ctype blue contour
		#
		#
		#set image[ix,iy]=myilights
		#set lev=-1E-15,1E-15,2E-15
		#levels lev
		#ctype red contour
		#
		ctype default
		#
		#
		#
		set x=0,1,1
		set x[0]=1/.0216
		set x[1]=x[0]
		set y=0,1,1
		set y[0]=-100
		set y[1]=100
		connect x y
		#
		set x=0,1,1
		set x[0]=43.08
		set x[1]=x[0]
		set y=0,1,1
		set y[0]=-100
		set y[1]=-.5
		connect x y
		#
rplotk4 0       # \Psi vs. r in equatorial plane
		# \dot{E} integrated
		jrdp dump0021
		fieldcalc 0 aphi
		#
		set omegacode=0.0216
		set Rl=1/omegacode
		set myrin=1*Rl
		set myrout=10*Rl
		set rstar=4.83752
		set Bp=1
		set mu=rstar**3*Bp/2
		set myaphi=aphi/(mu*omegacode)
		setlimits myrin myrout  1.570 1.572 0 1 plflim 0 x1 r h myaphi 0
		#
		set lowest=187.596/Rl
		set lowestaphi=1.22602
		#
		#
		#
		#stresscalc 1
		gcalc2 3 0 pi/2 eflem eflemvsr
		pl 0 newr eflemvsr
		set myeflemvsr=-eflemvsr/(mu**2*omegacode**4)/(4*pi)
		pl 0 newr myeflemvsr
		#
		#
		# correct for fact that set B=1 in heaviside
		set edotfull=2*pi*gdet*$dx2*eflem/(4*pi)
		#set myedotfull=edotfull if(ti==50)
		set myedotfull=edotfull if(ti==254)
		set myedot=-SUM(myedotfull)/(mu**2*omegacode**4)
		print {myedot}
rplotk5 1       #
		# large-scale A_\phi
		#
		define cres 40
		#
		#jrdp dump0533
		#gammiegridnew3 gdump
		#
		faraday
		#set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		set Rinold=4.84
		fdraft
		fieldcalc 0 aphi
		plc 0 aphi
		define minc $min
		define maxc $max
		# 
		if($1==1){\
		set _n1=$nx-6
		set _n2=$ny-6
		define nx (_n1)
		define ny (_n2)
		set use=((ti>=0)&&(ti<_n1)&&(tj>=0)&&(tj<_n2)) ? 1 : 0
		}
		if($1==0){\
		       set use=1+ti*0
		}
		#
		set myaphi=aphi if(use)
		#
		set myRout=30/.0216
		set myzout=myRout/2
		interpsingle myaphi 512 512 myRout myzout
		#
		#
		readinterp myaphi
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
		set myradiusdiff=radius-Rinold
		#
		set newaphi=(radius>Rinold) ? imyaphi : $missing_data
                set iaphi=newaphi
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^z/GM"
		#
		#
		plc 0 iaphi 001 0 myRout -myzout myzout
		set myiaphi=newfun
		#
		erase
		box
		#
		define minc 0.005
		define maxc 1.72
		#
		set image[ix,iy]=myiaphi
		set lev=$minc,$maxc,($maxc-$minc)/$cres
		levels lev
		ctype default contour
		xla $x1label
		yla $x2label
		#
		#set lev=1.5739,1.5739+1E-15,1E-15 levels lev ctype blue contour
		#
		#
		#set image[ix,iy]=myilights
		#set lev=-1E-15,1E-15,2E-15
		#levels lev
		#ctype red contour
		#
		ctype default
		#
		#
		#
		set x=0,1,1
		set x[0]=1/.0216
		set x[1]=x[0]
		set y=0,1,1
		set y[0]=-100
		set y[1]=100
		connect x y
		#
rplotk6 0       # current system
		#
		jrdpcf dump0053
		#gammiegridnew3 gdump
		#
		set ju0o=ju0*sqrt(-gv300)
		set ju1o=ju0*sqrt(gv311)
		set ju2o=ju0*sqrt(gv322)
		set ju3o=ju0*sqrt(gv333)
		#
		rdraft
		define cres 40
		plc0 0 ju0o
		#
		#
		interpsingle ju0o 512 512 200 100
		readinterp ju0o
		plc0 0 iju0o
rplotk62 0      # current system
		#
		jrdpcf dump0053
		#gammiegridnew3 gdump
		#
		set ju0o=ju0*sqrt(-gv300)
		set ju1o=ju0*sqrt(gv311)
		set ju2o=ju0*sqrt(gv322)
		set ju3o=ju0*sqrt(gv333)
		#
		#
		define UNITVECTOR 1
		define SKIPFACTOR 10
		set vvx=ju1o
		set vvy=ju2o
		vpl 0 vv 1 12 100
		#
		#interpsingle ju0o 512 512 200 100
		#readinterp ju0o
		#plc0 0 iju0o
		#
rplotk7 0       #
		define SKIPFACTOR 1
		define UNITVECTOR 0
		jrdpcf dump0053
		faraday
		set myBd3=-gdet*fuu12
		plc 0 myBd3 001 Rin 200 0 pi
		define minc ($min)
		#define maxc ($max)
		define maxc (-$min)
		define cres 40
		#
		#
		#interpsingle myBd3 512 512 200 200
		interpsingle myBd3 512 512 100 50
		readinterp myBd3
		plc 0 imyBd3 001 Rin 100 -50 50
		set godBd3=newfun
		#
		fdraft
		#
		erase
		#
		box
		#
		set image[ix,iy]=godBd3
		#
		set lev=1E-3,$maxc,($maxc-1E-3)/($cres/2)
		levels lev
		ltype 0 ctype default contour
		#
		set lev=$minc,-2E-3,(-2E-3-$minc)/($cres/2)
		levels lev
		ltype 2 ctype default contour
		ltype 0
		#
		xla $x1label
		yla $x2label
		#
		#
		set x=0,1,1
		set x[0]=1/.0216
		set x[1]=x[0]
		set y=0,1,1
		set y[0]=-1000
		set y[1]=1000
		connect x y
		#
rplotk8 0       #
		fdraft
		define SKIPFACTOR 1
		define UNITVECTOR 0
		#jrdp dump0053
		jrdp dump0021
		faraday
		fieldcalc 0 aphi
		set myBd3=-gdet*fuu12/(mu*omegacode**2)
		plc 0 myBd3 001 Rin 200 0 pi
		define minc ($min)
		#define maxc ($max)
		define maxc (-$min)
		define cres 40
		#
		set omegacode=0.0216
		set Rl=1/omegacode
		set myrin=1*Rl
		set myrout=10*Rl
		set rstar=4.83752
		set Bp=1
		set mu=rstar**3*Bp/2
		set myaphi=aphi/(mu*omegacode)
		#
		set myrin=1.1*1/.0216
		set myrout=1.01*myrin
		#set use=((r>50)&&(r<52)) ? 1 : 0
		set use=((r>51)&&(r<52)) ? 1 : 0
		#set use=((r>22)&&(r<22.2)) ? 1 : 0
		# H_\phi max = 1.07 at aphi=1.05335
		#set use=((r>myrin)&&(r<myrout)) ? 1 : 0
		smooth myBd3 smyBd3 10
		set godBd3=smyBd3 if(use)
		set godaphi=myaphi if(use)
		#smooth godBd3 sgodBd3 10
		define x1label "A_\phi/(\mu\Omega/c)"
		define x2label "B_\phi/(\mu\Omega^2/c^2)"
		ltype 0 ctype default pl 0 godaphi godBd3
		ptype 4 1 points godaphi godBd3
		#setlimits myrin myrout 0 (pi/2) 0 1 plflim 0 x2 r h sgodBd3 0
		#setlimits myrin myrout 0 (pi/2) 0 1 plflim 0 x2 r h godBd3 0 001
		#
		
