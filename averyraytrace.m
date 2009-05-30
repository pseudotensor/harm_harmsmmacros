doallsol0 0     #
		jre averyraytrace.m
		setupsol0
		createsol0
		interpsol0
		printsol0
		#
setupsol0  0    #
		# /raid1/jmckinne/jetresfl1
		# jetresfl1
		jrdpcf2d dump0057
		#gammiegridnew3 gdump
		#
		define myinx (300)
		define myiny (300)
		define myRout (5E3)
		#
		#
setupsol1 0     #/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#
		gogrmhd
		jrdp2d dump0040
		# gammiegrid gdump
		#
		define myinx (300)
		define myiny (300)
		define myRout (40)
		set _defcoord=0
		jre punsly.m
		setdxdxpold
		#
		#
createsol0  0   #
		# use this as starting point
		#
		#
		# erg K^{-1} g^{-1}
		set kb=1.3807*10**(-16)
		set mp=1.67262E-24
		set me=9.11E-28
		set C=2.99792458E10
		set mion=mp
		#
		set thetaion=p/(rho)
		set Tion=thetaion*(mion*C**2/kb)
		set Tele=me/mp*Tion
		#
		#
		#
		set R=r*sin(h)
		set z=r*cos(h)
		#
		set delta=r**2-2*r+a**2
		set sigma=r**2+a**2*cos(h)**2
		#
		set uu0bl=uu0 - 2*r/delta*(dxdxp11*uu1 + dxdxp12*uu2)
		set uu1bl=dxdxp11*uu1+dxdxp12*uu2
		set uu2bl=dxdxp21*uu1+dxdxp22*uu2
		set uu3bl=-a/delta*(dxdxp11*uu1 + dxdxp12*uu2) + uu3
		#
		set bu0bl=bu0 - 2*r/delta*(dxdxp11*bu1 + dxdxp12*bu2)
		set bu1bl=dxdxp11*bu1+dxdxp12*bu2
		set bu2bl=dxdxp21*bu1+dxdxp22*bu2
		set bu3bl=-a/delta*(dxdxp11*bu1 + dxdxp12*bu2) + bu3
		#
		#
		set lptot=lg(ptot)
		dercalc 0 lptot dlptot
		set mydptot=0.5*(dlptotx*$dx1+dlptoty*$dx2)
		#dercalc 0 p dp
		#
		set guu1=gdet*uu1
		set guu2=gdet*uu2
		dercalc 0 guu1 dguu1
		dercalc 0 guu2 dguu2
		set divv=dguu1x+dguu2y
		set shockind1=(divv<0) ? 1 : 0
		#
		set gammamin=1
		set coefmax=1.0
		#set coefjon=0.5*abs(mydbsq/bsq + (dpx+dpy)/p)
		#set coefjon=0.5*abs(mydptot/ptot)
		set coefjon=abs(mydptot)
		set coefjon2=coefjon*thetaion*mion/me/gammamin*(3*p-2)/(2*p-1)
		set coef=(shockind1<0.5) ? 0 : coefjon2
		#set coef=coefjon2
		#set coef=(coef>coefmax) ? coefmax : coef
		#
		#
		# rho thermal electron is order unity, so don't multiply by anything
		set lgrhonte=LG(rho*coef)
		#
		#*sqrt(4.0*pi)
		# Obtain field strength in Gaussian units
		set bu0bl=bu0bl*sqrt(4.0*pi)
		set bu1bl=bu1bl*sqrt(4.0*pi)
		set bu2bl=bu2bl*sqrt(4.0*pi)
		set bu3bl=bu3bl*sqrt(4.0*pi)
		#
interpsol0 0    #
		#
		#
		interpsingle R $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle z $myinx $myiny 0 $myRout -$myRout $myRout 1
		#
		#
		#
		interpsingle rho $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle Tele $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle uu0bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle uu1bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle uu2bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle uu3bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle bu0bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle bu1bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle bu2bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		interpsingle bu3bl $myinx $myiny 0 $myRout -$myRout $myRout 1
		#
		interpsingle lgrhonte $myinx $myiny 0 $myRout -$myRout $myRout 1
		#
		#
		readinterp R
		readinterp z
		#
		#
		readinterp rho
		readinterp Tele
		readinterp uu0bl
		readinterp uu1bl
		readinterp uu2bl
		readinterp uu3bl
		readinterp bu0bl
		readinterp bu1bl
		readinterp bu2bl
		readinterp bu3bl
		#
		readinterp lgrhonte
		set irhonte=10**ilgrhonte
		# don't allow density of non-thermal e's to be greater than a fixed fraction of thermal guys.
		set irhonte=(irhonte>0.1*irho) ? 0.1*irho : irhonte
		#
		#
printsol0   0   #
		#plc 0 irho
		#
		# get from interpsingle stderr
		#0.55 0.0131954 0.0263907
		#set fakeRin=0.55
		#set dxc=0.0131954
		#set dyc=0.0263907
		# 0.055 0.0165287 0.0330574
		set fakeRin=0.055
		set dxc=0.0165287
		set dyc=0.0330574
		#
		#1.06289 0.0122416 0.0244832
		#set fakeRin=1.06289
		#set dxc=0.0122416
		#set dyc=0.0244832
		#
		# sgra4
		#set fakeRin=0.055
		#set dxc=0.0165287
		#set dyc=0.0330574
		#
		# MG04 fidicual
		# 1.321 0.00493719 0.00987438
		set fakeRin=1.321
		set dxc=0.00493719
		set dyc=0.00987438
		#
		#
		set newX1=LG(fakeRin)+(ti+0.5)*dxc
		set Rup=10**newX1
		set myR=Rup
		#
		set newX2u=LG(fakeRin)+( (tj+0.5) -($ny/2))*dyc
		set zup=10**newX2u
		set newX2d=LG(fakeRin)+(($ny/2) - (tj+0.5) )*dyc
		set zdown=- (10**newX2d)
		set myz=(tj>=$ny/2) ? zup : zdown
		#
		#
		define print_noheader (0)
		print jondisk.dat {_n1 _n2 _t _a Rin Rout}
		#print + jondisk.dat '%15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' {iR iz irho iTele iuu0bl iuu1bl iuu2bl iuu3bl ibu0bl ibu1bl ibu2bl ibu3bl irhonte}
		print + jondisk.dat '%15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' {myR myz irho iTele iuu0bl iuu1bl iuu2bl iuu3bl ibu0bl ibu1bl ibu2bl ibu3bl irhonte}
		#
		# !scp jondisk.dat  jon@relativity:/home/jondata/
		# OR
		# !cp jondisk.dat /home/jondata/
		#
		# on relativity in /home/jondata do: ./reorder
		# then reset _n1 to add 1 (e.g. 300 -> 301)
		# scp jondiskreordered.dat jmckinne@cfa0.cfa.harvard.edu:/data/wdocs/jmckinney/www-docs/
		#
		#
powerlaws0 0    #
		gcalc2 3 2 0.3 rhonte rhontevsr
		#
		pl 0 newr rhontevsr 1100
		#
		gcalc2 3 2 0.3 thetaion thetaionvsr
		# -1.016
		# -.88
		#
		gcalc2 3 2 0.3 rho rhovsr
		ctype default pl 0 newr rhovsr 1100
		#
		gcalc2 3 2 0.3 coefjon coefjonvsr
		ctype default pl 0 newr coefjonvsr 1100
		#
