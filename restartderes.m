setupcheck 3   #
		#set _n1=512
		#set _n2=128
		#set _n3=32
		#
		set _n1=$1
		set _n2=$2
		set _n3=$3
		#
		set R0=0.3
		set Rin=1.8
		set Rout=50
		set hslope=0.15
		set defcoord=550
		# LOGRSINTH
		#
		set thin=0
		set thout=3.14159265358979
		set phiin=0
		set phiout=1.5707963267949
		#
		set _t=0
		set _startx1=0
		set _startx2=0
		set _startx3=0
		set _dx1=1
		set _dx2=1
		set _dx3=1
		set _realnstep=0
		set _gam=4/3
		set _a=0
		set _R0=R0
		set _Rin=Rin
		set _Rout=Rout
		set _hslope=hslope
		set _dt=0
		set _defcoord=defcoord
		set _MBH=1
		set _QBH=0
		#
		define nx (_n1)
		define ny (_n2)
		define nz (_n3)
		#
		define n1 (_n1)
		define n2 (_n2)
		define n3 (_n3)
		#
		set kk=0,$nx*$ny*$nz-1,1
		set indexi=INT(kk%$nx)
		set indexj=INT((kk%($nx*$ny))/$nx)
		set indexk=INT(kk/($nx*$ny))
		#
		set ti=indexi
		set tj=indexj
		set tk=indexk
		#
		set x1=ti
		set x2=tj
		set x3=tk
		#
		set r=x1
		set h=x2
		set ph=x3
		#
		set dr=1+r*0
		set dh=1+h*0
		set dp=1+ph*0
		#
		set tx1=x1
		set tx2=x2
		set tx3=x3
		#
		#
		gsetup
		gammienew
		define coord 1
		define x1label "ti"
		define x2label "tj"
		#
		#
get1col 2       #
		# 
		# jre restartderes.m 
		#
		#da col0.txt
		da $1
		#
		lines 1 100000000
		read '%g' {vartemp}
		set $2=vartemp
		#
		# plc 0 vartemp
		#
		#
makecomp 0      #
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		define BOXCOLOR default
		#
		setupcheck 512 128 32
		get1col col0.txt rhohigh
		set lrhohigh=(lg(rhohigh))
		plc 0 lrhohigh
		#
		animzplc 0 lrhohigh
		#
		#
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		#
		#
		setupcheck 512 128 16
		get1col icol0.txt rholow
		set lrholow=(lg(rholow))
		plc 0 lrholow
		#
		animzplc 0 lrholow
		#
		#
		#
checknewrdump 0 #
		#
		setupcheck 512 128 16
		#
		jrdprestart irdump.3dfull
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		define BOXCOLOR default
		#
		animzplc 0 lrhohigh
		#
		#
