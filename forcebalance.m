problems1  0   #
		setlimits 0 50 6.0 6.1 0 1 plflim 0 x1 r h rho 0
		der newx newfun dnewx dnewfun
		#
		pl 0 dnewx dnewfun
		#

fail2   0       #
		set lgtot1=lg(fail1+failrho1+failu1+failrhou1+1)
		set lgtot2=lg(fail2+failrho2+failu2+failrhou2+1)
		set lgtot3=lg(fail3+failrho3+failu3+failrhou3+1)
		#
		plc 0 lgtot3 001 Rin Rout Rin Rout
		#
		plc 0 lgtot3 001 r[0] r[$nx-1] h[0] h[$nx*$ny-1]
		#
		set failtot0=fail0+failrho0+failu0+failrhou0
		set failtot1=fail1+failrho1+failu1+failrhou1
		set failtot2=fail2+failrho2+failu2+failrhou2
		set failtot3=fail3+failrho3+failu3+failrhou3
		#
doallforces 0   #
		#
		jrdp dump0000
		setuptcross
		forceb1
		forceb2
		forceb3
		#
plotforces 0    #
		#
		#
		#
		jre forcebalance.m
		doallforces
		#
		# Then look at the various "forces."
		#
		# error in rest-mass conservation
		plc 0 errorrm
		#
		# error in energy-conservation
		plc 0 errorstress0
		#
		# error in momentums (1=R,2=z,3=\phi)
		plc 0 errorstress1
		plc 0 errorstress2
		plc 0 errorstress3
		#
		# error in divB
		plc 0 errorb0
		#
		# error in induction equations (1=R,2=z,3=\phi)
		plc 0 errorb1
		plc 0 errorb2
		plc 0 errorb3
		#
		#		
		#
setuptcross 0   #
		# first setup normalization time
		set tcross=$dx1/(ABS(v1p)+ABS(v1m))+$dx2/(ABS(v2p)+ABS(v2m))
		set tcrossother=1/((ABS(v1p)+ABS(v1m))/$dx1+(ABS(v2p)+ABS(v2m))/$dx2)
		set tcrossavg=SUM(tcross)/dimen(tcross)
		set tcrossotheravg=SUM(tcrossother)/dimen(tcrossother)
		#
		# define type of derivative to use
		define DERTYPE 0
		#
forceb1     0           #
		#
		#
		#
		# first check mass conservation
		#
		set f1=gdet*rho*uu1
		set f2=gdet*rho*uu2
		dercalc $DERTYPE f1 f1d
		dercalc $DERTYPE f2 f2d
		set totalrm=f1dx+f2dy
		#
		set normrm=gdet*rho*uu0/tcross
		#
		set errorrm=totalrm/normrm
		#
		#set f1t=totalrm/f1dx
		#set f2t=totalrm/f2dy
		#
		#define coord 1
		#define interp 0
		#set lgf1t=LG(ABS(f1t))
		#set lgf2t=LG(ABS(f2t))
		#
forceb2     0   #
		# check energy-momentum conservation
		#
		stresscalc 1
		gammiegridnew3 gdump
		#
		# normal gravity term
		set prefact0=gdet
		#set prefact0=1
		#
		set gravity0=prefact0*(\
		    (Tud00*c000+Tud01*c100+Tud02*c200+Tud03*c300)+\
		    (Tud10*c001+Tud11*c101+Tud12*c201+Tud13*c301)+\
		    (Tud20*c002+Tud21*c102+Tud22*c202+Tud23*c302)+\
		    (Tud30*c003+Tud31*c103+Tud32*c203+Tud33*c303)\
		    )
		#
		set gravity1=prefact0*(\
		    (Tud00*c010+Tud01*c110+Tud02*c210+Tud03*c310)+\
		    (Tud10*c011+Tud11*c111+Tud12*c211+Tud13*c311)+\
		    (Tud20*c012+Tud21*c112+Tud22*c212+Tud23*c312)+\
		    (Tud30*c013+Tud31*c113+Tud32*c213+Tud33*c313)\
		    )
		#
		set gravity2=prefact0*(\
		    (Tud00*c020+Tud01*c120+Tud02*c220+Tud03*c320)+\
		    (Tud10*c021+Tud11*c121+Tud12*c221+Tud13*c321)+\
		    (Tud20*c022+Tud21*c122+Tud22*c222+Tud23*c322)+\
		    (Tud30*c023+Tud31*c123+Tud32*c223+Tud33*c323)\
		    )
		#
		set gravity3=prefact0*(\
		    (Tud00*c030+Tud01*c130+Tud02*c230+Tud03*c330)+\
		    (Tud10*c031+Tud11*c131+Tud12*c231+Tud13*c331)+\
		    (Tud20*c032+Tud21*c132+Tud22*c232+Tud23*c332)+\
		    (Tud30*c033+Tud31*c133+Tud32*c233+Tud33*c333)\
		    )
		#
		set gravity0b=(ck0*Tud00+ck1*Tud10+ck2*Tud20+ck3*Tud30)
		set gravity1b=(ck0*Tud01+ck1*Tud11+ck2*Tud21+ck3*Tud31)
		set gravity2b=(ck0*Tud02+ck1*Tud12+ck2*Tud22+ck3*Tud32)
		set gravity3b=(ck0*Tud03+ck1*Tud13+ck2*Tud23+ck3*Tud33)
		#
		#
		set flux10=gdet*Tud10
		set flux20=gdet*Tud20
		set flux30=gdet*Tud30
		set flux11=gdet*Tud11
		set flux21=gdet*Tud21
		set flux31=gdet*Tud31
		set flux12=gdet*Tud12
		set flux22=gdet*Tud22
		set flux32=gdet*Tud32
		set flux13=gdet*Tud13
		set flux23=gdet*Tud23
		set flux33=gdet*Tud33
		#
		#
		dercalc $DERTYPE flux10 dflux10
		dercalc $DERTYPE flux20 dflux20
		dercalc $DERTYPE flux30 dflux30
		dercalc $DERTYPE flux11 dflux11
		dercalc $DERTYPE flux21 dflux21
		dercalc $DERTYPE flux31 dflux31
		dercalc $DERTYPE flux12 dflux12
		dercalc $DERTYPE flux22 dflux22
		dercalc $DERTYPE flux32 dflux32
		dercalc $DERTYPE flux13 dflux13
		dercalc $DERTYPE flux23 dflux23
		dercalc $DERTYPE flux33 dflux33
		#
		set momentum0=-(dflux10x+dflux20y)
		set momentum1=-(dflux11x+dflux21y)
		set momentum2=-(dflux12x+dflux22y)
		set momentum3=-(dflux13x+dflux23y)
		#
		set force0=momentum0+gravity0
		set force1=momentum1+gravity1
		set force2=momentum2+gravity2
		set force3=momentum3+gravity3
		#
		set normstress0=gdet*Tud00/tcross
		set normstress1=gdet*Tud01/tcross
		set normstress2=gdet*Tud02/tcross
		set normstress3=gdet*Tud03/tcross
		#
		set errorstress0=force0/normstress0
		set errorstress1=force1/normstress1
		set errorstress2=force2/normstress2
		set errorstress3=force3/normstress3
		#
		#
		#set ratio0=LG(ABS(force0/(force0+force1+force2+force3)))
		#set ratio1=LG(ABS(force1/(force0+force1+force2+force3)))
		#set ratio2=LG(ABS(force2/(force0+force1+force2+force3)))
		#set ratio3=LG(ABS(force3/(force0+force1+force2+force3)))
		#
		#
forceb3 0       #
		# 
		# *F^{\mu\nu} = b^\mu u^\nu - b^\nu u^\mu
		# fluxb\mu\nu = gdet *F^{\mu\nu}
		# 0=d_j (gdet *F^{j\nu})
		#
		dualb fluxb00 0 0
		dualb fluxb10 1 0
		dualb fluxb20 2 0
		dualb fluxb30 3 0
		dualb fluxb01 0 1
		dualb fluxb11 1 1
		dualb fluxb21 2 1
		dualb fluxb31 3 1
		dualb fluxb02 0 2
		dualb fluxb12 1 2
		dualb fluxb22 2 2
		dualb fluxb32 3 2
		dualb fluxb03 0 3
		dualb fluxb13 1 3
		dualb fluxb23 2 3
		dualb fluxb33 3 3
		#
		#
		#
		dercalc $DERTYPE fluxb10 dfluxb10
		dercalc $DERTYPE fluxb20 dfluxb20
		dercalc $DERTYPE fluxb11 dfluxb11
		dercalc $DERTYPE fluxb21 dfluxb21
		dercalc $DERTYPE fluxb12 dfluxb12
		dercalc $DERTYPE fluxb22 dfluxb22
		dercalc $DERTYPE fluxb13 dfluxb13
		dercalc $DERTYPE fluxb23 dfluxb23
		#
		# divb
		set forceb0=dfluxb10x+dfluxb20y
		set forceb1=dfluxb11x+dfluxb21y
		set forceb2=dfluxb12x+dfluxb22y
		set forceb3=dfluxb13x+dfluxb23y
		#
		# normb0=0 (divb=0 not an evolutionary equation but a differential constraint)
		# set normb0=fluxb00/tcross # 0
		set normb0=0.5*(ABS(fluxb10)/$dx1+ABS(fluxb20)/$dx2)
		set normb1=fluxb01/tcross
		set normb2=fluxb02/tcross
		set normb3=fluxb03/tcross
		#
		set errorb0=forceb0/normb0
		set errorb1=forceb1/normb1
		set errorb2=forceb2/normb2
		set errorb3=forceb3/normb3
		#
		#
		# errorb0 is off probably because of grid-scale error in this calculation since divb=0 in the dump
		# This problem could also be related to the method used in HARM.
		# HARM defines divb on a stencil larger than the smallest possible by \sqrt{2}
		#   it also uses 4 values per direction for 8 total values in 2D.
		# If divb=0 was enforced on a small stencil (2 zones per direction) then the above will be better
		# this could be a *real* problem that needs to be fixed
		# Charles recently wrote one fix to this and we can try it sometime.
		# BUT... this is unlikely a problem -- even less likely than nonrelativistic velocity problem
		#
		
