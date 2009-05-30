conservedfluxes  0   # assumes read in a dump file
		# jrdp dump0040
		faraday
		ksp2bl # creates einf, einfEM, einfbl, einfEMbl
		# can do plcergo 0 einfEMbl
		# below 2 are not regular
		set eta1=gdet*rho*uu1/fdd23
		set eta2=gdet*rho*uu2/fdd31
		set myeta=eta1
		# below has sign error
		set omegaf0=myeta/(gdet*rho*uu0)*fdd12+uu3/uu0
		# below correct middle sign, overall sign error
		set myomegaf0=myeta/(gdet*rho*uu0)*fdd12-uu3/uu0
		set myh=(rho+p+u)/rho
		set e0=-myh*ud0+gdet/(4*pi*myeta)*myomegaf0*fuu12
		set l0=myh*ud3+gdet/(4*pi*myeta)*fuu12
		#
		#
		#
		# below 1 is regular
		set omegadiff1=omegaf0+omegaf2
		# below 3 are not regular
		set omegadiff2=omegaf0+omegaf1
		set omegadiff3=omegaf0-omegaf1
		set omegadiff4=omegaf0-omegaf2
		#
		# below 1 is correct(i.e. gives 0)
		set omega2diff1=myomegaf0+omegaf2
		# below 3 are not regular
		set omega2diff2=myomegaf0+omegaf1
		set omega2diff3=myomegaf0-omegaf1
		set omega2diff4=myomegaf0-omegaf2
		#
		#
		#
mycons 0        #
		set enthalpy=(rho+u+p)/rho
		# this form of bsq may be dependent on how written
		set X=enthalpy+bsq/rho
		set vu1=uu1/uu0
		set vu2=uu2/uu0
		set vu3=uu3/uu0
		set vd1=ud1/ud0
		set vd2=ud2/ud0
		set vd3=ud3/ud0
		#
		# omega's are conserved along flow lines
		set omegaf1=vu3-B3*(vu2/B2)
		set omegaf2=vu3-B3*(vu1/B1)
		# omegaf2 is more regular in time-dependent radial flows
		# eta's are conserved along flow lines
		set eta1=B1/(rho*uu1)
		set eta2=B2/(rho*uu2)
		set eta3=B3/(rho*(uu3-uu0*omegaf2))
		#
		# D=-E+omegaf*L (D isn't independent)
		set D1=enthalpy*(ud0+omegaf1*ud3)
		# D2 more regular
		set D2=enthalpy*(ud0+omegaf2*ud3)
		#
		# E and L conserved along flow lines
		set EN1=-ud0*X-eta1*D2/enthalpy*bd0
		set LN1=ud3*X+eta1*D2/enthalpy*bd3
		#
		# old version of EN1/LN1
		#set oldEN1=-X*ud0+B1*bd0*ud0*(omegaf2*vd3-1)/(rho*uu1)
		#set oldLN1=-X*ud3+B3*bd0*ud0*(omegaf2*vd3-1)/(rho*uu1)
		#
		set newE0=-Tud20/(rho*uu2)
		set newEN1=-Tud10/(rho*uu1)
		set newL0=-Tud13/(rho*uu1)
		set newLN1=-Tud23/(rho*uu2)
		#
		# very similar to newEN1/newLN1
		set okazEN1=-enthalpy*ud0+eta1*omegaf2*(ud0*bd3-ud3*bd0)
		set okazLN1=enthalpy*ud3+eta1*(ud0*bd3-ud3*bd0)
		#
		# 
		set levEN1=-enthalpy*ud0+eta1*gdet*omegaf2*fuu12
		set levLN1=enthalpy*ud3+eta1*gdet*fuu12
		#
		set lgE=LG(ABS(EN1))
		#
		#
plot1 0      #
		# omegaf2 much smoother in funnel than omegaf1
		# this is due to B1/uu1 not varying in space-time much, but B2/uu2 varying considerably
		plc 0 omegaf2 001 Rin Rout 0 1.0
		#plc 0 omegaf1 001 Rin Rout 0 1.0
		define oldmax ($max)
		define oldmin ($min)
		erase
		mybox2d
		ticksize 0 0 0 0
		limits $txl $txh $tyl $tyh
		define newmin (0.1)
		define newmax (0.17)
		set lev=$newmin,$newmax,$(($newmax-$newmin)/30)
		levels lev
		ctype default contour
		#
		set lev=$newmax,$oldmax,$(($oldmax-$newmax)/30)
		levels lev
		ctype red contour
		#
		set lev=$oldmin,$newmin,$(($newmin-$oldmin)/30)
		levels lev
		ctype blue contour
		#
		#
		define cres 30
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		fieldcalc 0 aphi
		plc 0 aphi 010
		#
		#
plot2 0
		# funnel E(\Phi)
		define cres 30
		#plc 0 oldEN1 001 Rin Rout 0 1.0
		plc 0 EN1 001 Rin Rout 0 1.0
		#plc 0 newEN1 001 Rin Rout 0 1.0
		#plc 0 okazEN1 001 Rin Rout 0 1.0
		#plc 0 E2 001 Rin Rout 0 1.0
		#plc 0 E3 001 Rin Rout 0 1.0
		#set oldE0=einf/(rho*uu0)
		#plc 0 oldE0 001 Rin Rout 0 1.0
		#
		define oldmax ($max)
		define oldmin ($min)
		erase
		mybox2d
		ticksize 0 0 0 0
		limits $txl $txh $tyl $tyh
		define newmin (-100)
		define newmax (100)
		set lev=0,$newmax,$(($newmax)/30)
		levels lev
		ctype default contour
		#
		set lev=$newmin,0,$((-$newmin)/30)
		levels lev
		ctype green contour
		#
		set lev=$newmax,$oldmax,$(($oldmax-$newmax)/30)
		levels lev
		ctype red contour
		#
		set lev=$oldmin,$newmin,$(($newmin-$oldmin)/30)
		levels lev
		ctype blue contour
		#
		define cres 30
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		fieldcalc 0 aphi
		plc 0 aphi 010
		#
		define cres 30
		define POSCONTCOLOR black
		define NEGCONTCOLOR black
		plc 0 acctot 010
		define newmin (-.3)
		define newmax (.3)
		set lev=$newmin,0,$(($newmin-$min)/256)
		levels lev
		ctype magenta contour
 		#
		set lev=0,$newmax,$(($newmax)/256)
		levels lev
		ctype yellow contour
 		#
		#
plot3 0
		# funnel L(\Phi)
		define cres 30
		plc 0 LN1 001 Rin Rout 0 1.0
		define oldmax ($max)
		define oldmin ($min)
		erase
		mybox2d
		ticksize 0 0 0 0
		limits $txl $txh $tyl $tyh
		define newmin (-500)
		define newmax (500)
		set lev=$newmin,$newmax,$(($newmax-$newmin)/300)
		levels lev
		ctype default contour
		#
		set lev=$newmax,$oldmax,$(($oldmax-$newmax)/30)
		levels lev
		ctype red contour
		#
		set lev=$oldmin,$newmin,$(($newmin-$oldmin)/30)
		levels lev
		ctype blue contour
		#
		define cres 30
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		fieldcalc 0 aphi
		plc 0 aphi 010
		#
setjet1 0       #
		setjetpart1
		setjetpart2
setjetpart1 0   #
		# assumes ran:
		# stresscalc 1
		#faraday
		#jsq
		#
		#
		set Bd3a=bd3*ud0
		set Bd3b=-bd0*ud3
		#
		set Bd1=bd1*ud0-bd0*ud1
		set Bd2=bd2*ud0-bd0*ud2
		set Bd3=bd3*ud0-bd0*ud3
		#
		set B1ks=B1*dxdxp11+B2*dxdxp12
		set B2ks=B1*dxdxp21+B2*dxdxp22
		set B3ks=B3
		#
		set uu0ks=uu0
		set uu1ks=uu1*dxdxp11+uu2*dxdxp12
		set uu2ks=uu1*dxdxp21+uu2*dxdxp22
		set uu3ks=uu3
		#
		# inverse of dx^{ks}/dx^{mks}
		set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		#
		set ud0ks=ud0
		set ud1ks=ud1*idxdxp11+ud2*idxdxp21
		set ud2ks=ud1*idxdxp12+ud2*idxdxp22
		set ud3ks=ud3
		#
		set Bd1ks=Bd1*idxdxp11+Bd2*idxdxp21
		set Bd2ks=Bd1*idxdxp12+Bd2*idxdxp22
		set Bd3ks=Bd3
		#
		set Sigma=r**2+(a*cos(h))**2
		set Delta=r**2-2*r+a**2
		set gdetbl=Sigma*sin(h)
		set B1bl=B1ks
		set B2bl=B2ks
		set B3bl=B3ks-B1ks*(a-2*r*omegaf2)/Delta
		#
		set Bd1bl=Bd1ks+a*Bd3ks/Delta
		set Bd2bl=Bd2ks
		set Bd3bl=Bd3ks
		#
		set geofactbl=Delta*sin(h)**2
		# 
		#
		# Bd3bl should equal Bd3 in KS' (it does!)
		#set Bd3bl=-B3bl*geofactbl
		#
		set uu0bl=uu0ks-2*r/Delta*uu1ks
		set uu1bl=uu1ks
		set uu2bl=uu2ks
		set uu3bl=-a/Delta*uu1ks+uu3ks
		#
		set ud0bl=ud0ks
		set ud1bl=(2*r*ud0ks+Delta*ud1ks+a*ud3ks)/Delta
		set ud2bl=ud2ks
		set ud3bl=ud3ks
		#
		#
setjetpart2  0  #
		#
		##########################################################
		#
		# all accelerations/collimations measured in KS frame
		#
		# acceleration
		#
		# set norm in KS since that's coords when used
		#
		set gv311ks=1+2*r/Sigma
		set gv322ks=Sigma
		set gv312ks=0*Sigma
		set N=1.0/sqrt(B1ks*B1ks*gv311ks+B2ks*B2ks*gv322ks+2*B1ks*B2ks*gv312ks)
		#
		#
		# not done yet
		#velocity form of acceleration in KS
		#
		#dercalc 0 ud0 ud0d
		#dercalc 0 ud3 ud3d
		#
		#
		#####################################
		# hydro acceleration
		#
		# pure KS accx,accy
		dercalc 0 p pd
		set accx=-ud1*(uu1*pdx+uu2*pdy)+pdx
		set accy=-ud2*(uu1*pdx+uu2*pdy)+pdy
		#
		# KSP -> KS
		set accmaksr=accx*idxdxp11+accy*idxdxp21
		set accmaksh=accx*idxdxp12+accy*idxdxp22
		#
		set accma=N*(B1ks*accmaksr+B2ks*accmaksh)/(rho*enthalpy)
		#
		######################################
		# magnetic acceleration
		# derivative is w.r.t. KS' uniform coordinates
		dercalc 0 Bd3 Bd3d
		set accemx=-B3*Bd3dx
		set accemy=-B3*Bd3dy
		#
		# idxdxp converts lower like so...
		# transformation from KS' to KS of acceleration
		set accemksr=accemx*idxdxp11+accemy*idxdxp21
		set accemksh=accemx*idxdxp12+accemy*idxdxp22
		#
		set denratio=N/(rho*enthalpy)
		set accem=denratio*(B1ks*accemksr+B2ks*accemksh)
		#
		#
		set acctot=accem+accma
 		#
		#
		##################
		# matter and EM energy flux along field
		#
		# assumed ran:
		#stresscalc 1
		#
		# see grmhd-transforms.nb
		#
		# flux density (conserved quantity per unit area per unit time)
		set Tud10EMks=Tud10EM*dxdxp11+Tud20EM*dxdxp21
		set Tud20EMks=Tud10EM*dxdxp12+Tud20EM*dxdxp22
		set Tud10MAks=Tud10MA*dxdxp11+Tud20MA*dxdxp21
		set Tud20MAks=Tud10MA*dxdxp12+Tud20MA*dxdxp22
		#
		set Tud13EMks=Tud13EM*dxdxp11+Tud23EM*dxdxp21
		set Tud23EMks=Tud13EM*dxdxp12+Tud23EM*dxdxp22
		set Tud13MAks=Tud13MA*dxdxp11+Tud23MA*dxdxp21
		set Tud23MAks=Tud13MA*dxdxp12+Tud23MA*dxdxp22
		#
		set emefluxalongB=-(B1ks*Tud10EMks+B2ks*Tud20EMks)/(B1ks*uu1ks+B2ks*uu2ks)
		set maefluxalongB=-(B1ks*Tud10MAks+B2ks*Tud20MAks)/(B1ks*uu1ks+B2ks*uu2ks)
		# angular momentum along field
		set emlfluxalongB=(B1ks*Tud13EMks+B2ks*Tud23EMks)/(B1ks*uu1ks+B2ks*uu2ks)
		set malfluxalongB=(B1ks*Tud13MAks+B2ks*Tud23MAks)/(B1ks*uu1ks+B2ks*uu2ks)
		#
		#
		###################################################
		# collimation
		# set norm in KS since that's coords when used
		set NC=1.0/sqrt(B1ks*B1ks*gv322ks+B2ks*B2ks*gv311ks+2*B1ks*B2ks*gv312ks)/N
		#
		#########################################
		# hydro collimation
		# same accr/acch as for acceleration
		set collma=NC*denratio*(-B1ks*accmaksh+B2ks*accmaksr)
		#
		###########################################
		# magnetic collimation
		#
		set tau1=fuu20/fuu23
		set tau2=fuu10/fuu13
		set tau3=-fuu30/fuu12
		#
		set newBd1=tau1*Bd1
		set newBd2=tau2*Bd2
		dercalc 0 Bd1 Bd1d
		dercalc 0 Bd2 Bd2d
		dercalc 0 newBd1 newBd1d
		dercalc 0 newBd2 newBd2d
		#
		#
		set collem1a=B2*((-newBd2dx+newBd1dy)*(-omegaf2)+(-Bd2dx+Bd1dy))
		set collem2a=B1*((-newBd2dx+newBd1dy)*(omegaf2)-(-Bd2dx+Bd1dy))
		set collem1b=accemx
		set collem2b=accemy
		#
		# convert from KSP->KS
		#
		set collemksra=collem1a*idxdxp11+collem2a*idxdxp21
		set collemksha=collem1a*idxdxp12+collem2a*idxdxp22
		set collemksrb=collem1b*idxdxp11+collem2b*idxdxp21
		set collemkshb=collem1b*idxdxp12+collem2b*idxdxp22
		# 
		set collema=NC*denratio*(B2ks*collemksra-B1ks*collemksha)
		set collemb=NC*denratio*(B2ks*collemksrb-B1ks*collemkshb)
		#
		set collem=collema+collemb
		#
		set colltot=collma+collem
		#
		#
		##############
		# ma and em E and L fluxes across field lines
		#
		set emefluxacrossB=-(-B1ks*Tud20EMks+B2ks*Tud10EMks)/(-B1ks*uu2ks+B2ks*uu1ks)
		set maefluxacrossB=-(-B1ks*Tud20MAks+B2ks*Tud10MAks)/(-B1ks*uu2ks+B2ks*uu1ks)
		# angular momentum across field
		set emlfluxacrossB=(-B1ks*Tud23EMks+B2ks*Tud13EMks)/(-B1ks*uu2ks+B2ks*uu1ks)
		set malfluxacrossB=(-B1ks*Tud23MAks+B2ks*Tud13MAks)/(-B1ks*uu2ks+B2ks*uu1ks)
		#
		#
		#
		# effective $\Gamma_\infty$
		set gammainf=Delta*sin(h)**2*B3ks**2/(rho*uu0)
		set lggammainf=LG(ABS(gammainf))
		#
		#
		# now compute total true acceleration and collimation
		set acctrue0=jdotfd0
		set acctrue1=jdotfd1
		set acctrue2=jdotfd2
		set acctrue3=jdotfd3
		set acctrue1ks=acctrue1*idxdxp11+acctrue2*idxdxp21
		set acctrue2ks=acctrue1*idxdxp12+acctrue2*idxdxp22
		#
		set acctrueem=denratio*(B1ks*acctrue1ks+B2ks*acctrue2ks)
		set acctem=acctrueem-accem
		set colltrueem=NC*denratio*(B2ks*acctrue1ks-B1ks*acctrue2ks)
		set colltem=colltrueem-collem
		#
		#
		#
		#
		#
setjetbl1 0        #  fudgeed up BL attempt.  Need too many time derivatives of KSP quantities to do this correctly
		set Bd3a=bd3*ud0
		set Bd3b=-bd0*ud3
		#
		set Bd1=bd1*ud0-bd0*ud1
		set Bd2=bd2*ud0-bd0*ud2
		set Bd3=bd3*ud0-bd0*ud3
		#
		set B1ks=B1*dxdxp11+B2*dxdxp12
		set B2ks=B1*dxdxp21+B2*dxdxp22
		set B3ks=B3
		#
		set uu0ks=uu0
		set uu1ks=uu1*dxdxp11+uu2*dxdxp12
		set uu2ks=uu1*dxdxp21+uu2*dxdxp22
		set uu3ks=uu3
		#
		# inverse of dx^{ks}/dx^{mks}
		set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		#
		set ud0ks=ud0
		set ud1ks=ud1*idxdxp11+ud2*idxdxp21
		set ud2ks=ud1*idxdxp12+ud2*idxdxp22
		set ud3ks=ud3
		#
		set Bd1ks=Bd1*idxdxp11+Bd2*idxdxp21
		set Bd2ks=Bd1*idxdxp12+Bd2*idxdxp22
		set Bd3ks=Bd3
		#
		set Sigma=r**2+(a*cos(h))**2
		set Delta=r**2-2*r+a**2
		set gdetbl=Sigma*sin(h)
		set B1bl=B1ks
		set B2bl=B2ks
		set B3bl=B3ks-B1ks*(a-2*r*omegaf2)/Delta
		#
		set Bd1bl=Bd1ks+a*Bd3ks/Delta
		set Bd2bl=Bd2ks
		set Bd3bl=Bd3ks
		#
		set geofactbl=Delta*sin(h)**2
		# 
		#
		# Bd3bl should equal Bd3 in KS' (it does!)
		#set Bd3bl=-B3bl*geofactbl
		#
		set uu0bl=uu0ks-2*r/Delta*uu1ks
		set uu1bl=uu1ks
		set uu2bl=uu2ks
		set uu3bl=-a/Delta*uu1ks+uu3ks
		#
		set ud0bl=ud0ks
		set ud1bl=(2*r*ud0ks+Delta*ud1ks+a*ud3ks)/Delta
		set ud2bl=ud2ks
		set ud3bl=ud3ks
		#
		# acceleration
		#
		# normalization
		set gv311bl=Sigma/Delta
		set gv322bl=Sigma
		set gv312bl=0*Sigma
		set N=1.0/sqrt(B1bl*B1bl*gv311bl+B2bl*B2bl*gv322bl+2*B1bl*B2bl*gv312bl)
		#
		#
		# not done yet
		#velocity form of acceleration in KS
		#
		#dercalc 0 ud0 ud0d
		#dercalc 0 ud3 ud3d
		#
		#
		#
		# hydro acceleration
		dercalc 0 p pd
		set pdr=pdx*idxdxp11+pdy*idxdxp21
		set pdh=pdx*idxdxp12+pdy*idxdxp22
		#
		set accr=-ud1bl*(uu1bl*pdr+uu2bl*pdh)+pdr
		set acch=-ud2bl*(uu1bl*pdr+uu2bl*pdh)+pdh
		set accma=N*(B1bl*accr+B2bl*acch)/(rho*enthalpy)
		#
		#
		# magnetic acceleration
		# derivative is w.r.t. KS' uniform coordinates transformed to KS and then BL
		dercalc 0 Bd3bl Bd3bld
		#
		# idxdxp converts lower derivatives like so...
		# transformation from KS' to KS
		set Bd3bldr=Bd3bldx*idxdxp11+Bd3bldy*idxdxp21
		set Bd3bldh=Bd3bldx*idxdxp12+Bd3bldy*idxdxp22
		#
		set accr=-B3bl*Bd3bldr
		set acch=-B3bl*Bd3bldh
		set accem=N*(B1bl*accr+B2bl*acch)/(rho*enthalpy)
		#
		#
		set acctot=accem+accma
 		#
		#
		#
		# collimation
		set NC=1.0/sqrt(B1bl*B1bl*gv322bl+B2bl*B2bl*gv311bl+2*B1bl*B2bl*gv312bl)/N
		#
		# hydro collimation
		# same accr/acch as for acceleration
		set accr=-ud1bl*(uu1bl*pdr+uu2bl*pdh)+pdr
		set acch=-ud2bl*(uu1bl*pdr+uu2bl*pdh)+pdh
		set collma=N*NC*(-B1bl*acch+B2bl*accr)/(rho*enthalpy)
		#
		# magnetic collimation
		#
		set bp2=B1bl**2+B2bl**2
		set AA=(r**2+a**2)**2-a**2*Delta*sin(h)**2
		set omegazamo=2*a*r/AA
		set omega0=(a**2-Delta/sin(h)**2)/(2*a*r)
		set tau = (omegaf2/omegazamo-1)/(omega0-omegazamo+1E-15)
		# tau->omegaf2*(r**3*sin(h)**2/(2-r) for a=0
		#
		set newBd1bl=tau*Bd1bl
		set newBd2bl=tau*Bd2bl
		dercalc 0 Bd1bl Bd1bld
		dercalc 0 Bd2bl Bd2bld
		dercalc 0 newBd1bl newBd1bld
		dercalc 0 newBd2bl newBd2bld
		#
		set Bd1bldr=Bd1bldx*idxdxp11+Bd1bldy*idxdxp21
		set Bd1bldh=Bd1bldx*idxdxp12+Bd1bldy*idxdxp22
		set Bd2bldr=Bd2bldx*idxdxp11+Bd2bldy*idxdxp21
		set Bd2bldh=Bd2bldx*idxdxp12+Bd2bldy*idxdxp22
		#
		set newBd1bldr=newBd1bldx*idxdxp11+newBd1bldy*idxdxp21
		set newBd1bldh=newBd1bldx*idxdxp12+newBd1bldy*idxdxp22
		set newBd2bldr=newBd2bldx*idxdxp11+newBd2bldy*idxdxp21
		set newBd2bldh=newBd2bldx*idxdxp12+newBd2bldy*idxdxp22
		#
		# electric field gradients dominate EM collimation
		set collem11a=bp2*(Bd1bldr-omegaf2*newBd1bldr)
		set collem12a=bp2*(Bd1bldh-omegaf2*newBd1bldh)
		set collem21a=bp2*(Bd2bldr-omegaf2*newBd2bldr)
		set collem22a=bp2*(Bd2bldh-omegaf2*newBd2bldh)
		#
		set collem11b=B1bl*B3bl*Bd3bldr
		set collem12b=B1bl*B3bl*Bd3bldh
		set collem21b=B2bl*B3bl*Bd3bldr
		set collem22b=B2bl*B3bl*Bd3bldh
		#
		set collema=N*NC*(collem12a-collem21a)/(rho*enthalpy)
		set collemb=N*NC*(collem12b-collem21b)/(rho*enthalpy)
		#
		set collemtot=collema+collemb
		#
		set colltot=collma+collemtot
		#
		# effective $\Gamma_\infty$
		set gammainf=Delta*sin(h)**2*B3bl**2/(rho*uu0)
		set lggammainf=LG(ABS(gammainf))
		#
		#
		faraday
		jsq
		# now compute total true acceleration and collimation
		set ratio=N/(rho*enthalpy)
		set acctrue0=jdotfd0*ratio
		set acctrue1=jdotfd1*ratio
		set acctrue2=jdotfd2*ratio
		set acctrue3=jdotfd3*ratio
		set acctrue0ks=acctrue0
		set acctrue1ks=acctrue1*idxdxp11+acctrue2*idxdxp21
		set acctrue2ks=acctrue1*idxdxp12+acctrue2*idxdxp22
		set acctrue3ks=acctrue3
		set acctrue0bl=acctrue0ks
		set acctrue1bl=(2*r*acctrue0ks+Delta*acctrue1ks+a*acctrue3ks)/Delta
		set acctrue2bl=acctrue2ks
		set acctrue3bl=acctrue3ks
		set acctrueem=(B1bl*acctrue1bl+B2bl*acctrue2bl)
		set acctem=acctrueem-accem
		set colltrueem=NC/N*(-B1bl*acctrue2bl+B2bl*acctrue1bl)
		set colltem=colltrueem-collemtot
		#
		#
charact1 0      # requires above
		#
		# poloidal velocity along field line
		set up=N*(B1bl*ud1bl+B2bl*ud2bl)
		# part of full average
		# tslow[v1p,v1m]tavg, tfast[v1p,v1m]tavg, alfven[v1p,v1m]tavg
		set 
		#
		#
		#
plotacc1 0      #
		#
		set myRin=5
		set myRout=Rout
		set hin=0.0
		set hout=1.0
		define NEGCONTCOLOR blue
		define POSCONTCOLOR blue
		plc 0 uu0bl 001 myRin myRout hin hout
		define NEGCONTCOLOR default
		define POSCONTCOLOR red
		plc 0 accma 011 myRin myRout hin hout
		define NEGCONTCOLOR green
		define POSCONTCOLOR yellow
		plc 0 accem 011 myRin myRout hin hout
		define NEGCONTCOLOR cyan
		define POSCONTCOLOR magenta		
		plc 0 acctem 011 myRin myRout hin hout
		#
plotcoll1 0      #
		#
		set myRin=5
		set myRout=Rout
		set hin=0.0
		set hout=1.0
		define NEGCONTCOLOR blue
		define POSCONTCOLOR blue
		plc 0 uu0bl 001 myRin myRout hin hout
		define NEGCONTCOLOR default
		define POSCONTCOLOR default
		plc 0 collma 011 myRin myRout hin hout
		define NEGCONTCOLOR green
		define POSCONTCOLOR yellow
		plc 0 collema 011 myRin myRout hin hout
		define NEGCONTCOLOR cyan
		define POSCONTCOLOR magenta
		plc 0 collemb 011 myRin myRout hin hout
		define NEGCONTCOLOR (red)
		define POSCONTCOLOR (red)
		plc 0 colltem 011 myRin myRout hin hout
		#
		#
fields 0        #
		# T^j_k = dxdxp[j][k].  dxdxp11 = drdx1  dxdxp21=dhdx1
		#
		setb3d
		#
		ctype default setlimits Rin Rout 0.2 0.5 1E-4 1E-1 plflim 0 x1 r h B3bl 0 110
		ctype red setlimits Rin Rout 0.2 0.5 1E-4 1E-1 plflim 0 x1 r h Bd3bl 0 111
		ctype green setlimits Rin Rout 0.2 0.5 1E-4 1E-1 plflim 0 x1 r h Bd3 0 111
		#
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 Bd3 001 Rin Rout 0 0.5
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		plc 0 aphi 010
		#
		#
		#
		#
		#
		ctype default setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bd3 0 110
		ctype default setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bd0 0 110
		#
		set B3a=bu3*uu0
		set B3b=-bu0*uu3
		ctype default setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h B3 0 110
		ctype yellow setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h B3a 0 111
		ctype red setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h B3b 0 111
		#
		ctype default setlimits Rin Rout 0.2 0.5 1E-4 1E-1 plflim 0 x1 r h Bd3 1 110
		ctype yellow setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h Bd3a 0 111
		ctype red setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h Bd3b 0 111
		#
		#
		#
		ctype default setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq 0 110
		ctype yellow setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq0 0 111
		ctype red setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq1 0 111
		ctype blue setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq2 0 111
		ctype green setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq3 0 111
		#
		ctype default setlimits Rin Rout 0.2 0.5 -.03 .03 plflim 0 x1 r h bsq 1 100
		ctype yellow setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq0 0 101
		ctype red setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq1 0 101
		ctype blue setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq2 0 101
		ctype green setlimits Rin Rout 0.2 0.5 0 1 plflim 0 x1 r h bsq3 0 101
		
