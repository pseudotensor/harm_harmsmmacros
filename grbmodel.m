loadmacrosgrb 0 #
		#
		#
		gogrmhd
		jre grbmodel.m
		jre kaz.m
		#
		#
		#
doallmodels 0   # at least 3 iterations so H calculation is good
		#
		#
		#
		dostandard 0
		dostandard 0
		dostandard 0
		#
		dostandard 1
		dostandard 1
		dostandard 1
		#
		dostandard 2
		dostandard 2
		dostandard 2
		#
		dostandard 3
		dostandard 3
		dostandard 3
		#
		#
dostandard   1  #
		#
		# remember to set lambdatot=1 if doing first time
		#
		#
		#cd ~/research/grbmodel/
		#
		#jre grbmodel.m
		echo "rdstar"
		#
		define WHICHSTARTYPE $1
		#
                # Note that default WHICHPROBLEM is 1, corresponding to self-gravity and evolving the metric
		#
		if($WHICHSTARTYPE==0){
		   # WW95 type star:
		   rdstarww95 s251s7b@14233 1 2 1112 1115 2225 2228 3339
		}
		#
		if($WHICHSTARTYPE==1){
		   # .jon means modified as described in m254e4.desc
		   rdstarheger m25e4.presn.jon 1
		}
		#
		if($WHICHSTARTYPE==2){
		   # .jon means modified as described in m254e4.desc
		   rdstarheger m15e4.presn.jon 1
		}
		#
		if($WHICHSTARTYPE==3){
		   # WW95 type star:
		   rdstarww95 s15s7b2@21363 1 2 682 685 1365 1368 2048
		}
		#
		#
		#
		#
		echo "outputting model"
		outputmodel
		#
		#
		#
doall 0         #
		cd ~/research/grbmodel/
		#
		echo "Doing Model 0"
		rdstarww95 s251s7b@14233 0
		outputmodel
		echo "Doing Model 1"
		rdstarww95 s251s7b@14233 1
		outputmodel
		echo "Doing Model 2"
		rdstarww95 s251s7b@14233 2
		outputmodel
		#
		#
		#
		#
		# less s251s7b\@14233
		#    mass        radius     temperature  density        velocity        Ye
		# 1  0.00000E+00  6.41605E+06  8.11999E+09  3.61550E+09 -4.69008E+06  4.28493E-01
		#
		#
rdstarww95 8    #
		#
		da $1
		#lines 2 1112
		lines $3 $4
		read '%d %g %g %g %g %g %g' {lnum mass r temp rho vr ye}
		#
		#      nucleons      helium       carbon       oxygen        neon       magnesium       si          iron
		#   1  4.77912E-03  7.45118E-03  0.00000E+00  0.00000E+00  0.00000E+00  2.44005E-07  5.69632E-05  9.87712E-01
		#lines 1115 2225
		lines $5 $6
		read '%d %g %g %g %g %g %g %g %g\n' {lnum2 nucleons helium carbon oxygen neon magnesium si iron}
		#
		#
		#lines 2228 3339
		lines $7 $8
		read '%d %g %g %g' {lnum3 j omega inertia}
		#
		# -1 indicates let HELM code compute abar
		set abarin=-1 + r*0
		set abarboundin = abarin
		#
		# now do general things
		rdstar $1 $2
		#
		#
		#
rdstarhegertest 0
		da m25e4.presn.jon
		lines 3 3
		read '%d %g %g %g %g %g %g %g %g %g %g %g %s %s' {gridnum mass r vr rho temp ptotin specetotin specstotin omega abarin ye stability network}

		#
		#
rdstarheger 2   #
		#
		# 13 + 21 = 34
		da $1
		lines 3 669
		read '%d %g %g %g %g %g %g %g %g %g %g %g %s %s %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {gridnum mass r vr rho temp ptotin specetotin specstotin omega abarin ye stability \
		       network neutrons protons he3 he4 C12 N14 O16 Ne20 Mg24 Si28 S32 Ar36 Ca40 Ti44 Cr48 Fe52 Fe54 Ni56 Fe56 Fetotal }
		#
		# below aren't actually used by HELM code if abarin is >=0
		set nucleons = neutrons+protons
		set helium = he3+he4 # only approximation
		set carbon = C12 + N14 #approx
		set oxygen = O16
		set neon = Ne20
		set magnesium = Mg24
		set si=Si28+S32+Ar36+Ca40+Ti44+Cr48
		set iron = Fe52+Fe54+Ni56+Fe56+Fetotal
		set j=omega*0
		set inertia = omega*0
		#
		# approximation assuming small fraction of free nucleons (which is reasonable)
		# in HELM code this isn't even used if nuclear EOS is used, which is normal
		set abarboundin = abarin
		#
		#DEBUG GODMARK
		if(0){\
		set iiii=1,dimen(r),1
		#set rhotest=0.55908101825122222900E+00010
		set rhotest=0.12618568830660203821E+00006
		set temptest=0.86851137375135288239E+00010
		set utottest=0.88601890289717108602E+00029
		set yetest=0.403161266014422
		#
		#set rho[10]=rhotest
		set rho=rhotest + 0*rho
		#set utot[10]=utottest
		#
		set iii=dimen(helium)-1
		set iii=0
		while {iii<=10} {
		   define myii (iii)
		   set temp[$myii]=temptest
	   	   set iii=iii+1
		}
		#
		set ye = yetest + 0*ye
		#
		}
		#
		#
		#
		# now do general things
		rdstar $1 $2
		#
		#
		#
		#
		#
rdstar 2        #
		# so-far this grbmodel.m file is only setup for one input model, but small varying details can be generalized or specified per model
		#
		# 0 = #if(DOSELFGRAVVSR==0 && DOEVOLVEMETRIC==1)
		# 1 = #elif(DOSELFGRAVVSR==1 && DOEVOLVEMETRIC==1)
		# 2 = #elif(DOSELFGRAVVSR==0 && DOEVOLVEMETRIC==0)
		define WHICHPROBLEM $2
		#
		# whether to remove star beyond He core and replace with stellar wind
		define REMOVEBEYONDHE 1
		#
		#
		setgrbconsts
		#
		#
		########## EXTEND SOLUTION
		#
		extendr
		set vrold=vr
		extendstarconst vr
		set yeold=ye
		extendstar ye
		set abarinold=abarin
		extendstar abarin
		set abarboundinold=abarboundin
		extendstar abarboundin
		set massold=mass
		extendstar mass
		set tempold=temp
		set rhoold=rho
		#
		# iterate to get good force-balanced solution inside added region
		#
		#
		# first extend density
		set rho=rhoold
		extendstar rho
		#extendstarlog rho
		#
		# Get Mvsr and gravity and pressurevsr for balanced pressure
		recomputeMvsr 0
		setgravity
		#
		# extend to new density using pressvsr assuming all due to degeneracy
		set rho=rhoold
		extendstarspecialdensity rho
		#
		# get new Mvsr, gravity, and pressurevsr
		recomputeMvsr 0
		setgravity
		#
		# set temperature for force balance assuming all due to temperature
		set temp=tempold
		extendstarspecialtemp temp
		#
		#
		#
		#
		#
		#
		#
		extendstar nucleons
		extendstar helium
		extendstar carbon
		extendstar oxygen
		extendstar neon
		extendstar magnesium
		extendstar si
		extendstar iron
		#
		#
		set totalfrac = nucleons+helium+carbon+oxygen+neon+magnesium+si+iron
		#
		#
		extendstar j
		extendstar omega
		extendstar inertia
		#
		#
		# This determines whether the density is truncated so one can use a BH already at large mass
		# We no longer need this with evolving metric in HARM
		if($WHICHPROBLEM==2){\
		       truncaterho
		       #
		       # recompute Mvsr since loss mass and set myM0
		       set myM0=M/msun
		       recomputeMvsr myM0
		       #
		       #
		       #
		    }\
		           else{\
		              set myM0=0.0
		           }
		#
		# set initial mass enclosed within GM/c^2 (M=1.7M0)
		set MBH0=Mvsr[0]*msun
		#set MBHprime=7.554e-05*msun
		#if(MBH0<MBHprime){ set MBH0=MBHprime }
		#
		# below may not be needed if doing self-gravity
		if($WHICHPROBLEM==0){ setfreefall vr }
		#
		#
		if($REMOVEBEYONDHE==1){\
		       # below creates iedge
		       findheedge iedge
		       # below uses iedge
		       stellarwind iedge
		       # recompute again since removed outer layers
		       recomputeMvsr myM0
		       #
		    }
		    #
		    #
		    #
		#
		#echo "here1"
		# convert species to nucleons+alpha particles+photons
		# set pressure and internal energies for use in HARM
		setpressures
		setgravity
		setH
		#
		# smooth? (temperature jumps result in \eta_p or \eta_n jumps)
		# This is ok, was just debugging origin of jumps
		if(0){
		   #smooth ye sye 5
		   #set ye=sye
		   smooth temp stemp 20
		   set temp=stemp
		   #smooth rho srho 5
		   #set rho=srho
		}
		#
		#
		#
		#####################################
		# use final data to get true EOS data
		#####################################
		processeos
		#
		#
		##########################################
		echo "now choose the EOS result to assume: WHY NEW AND TEST NOT SAME?"
		##########################################
		#
		set utotmine=utot
		set utot=utotnew
		#
		set ptotmine=ptot
		set ptot=ptotnew
		#
		set stot=stotnew
		#
		set Qm=Qmnew
		#
		######################################
		# Set final things based upon output
		######################################
		#
		#
		set taunse=rho**(0.2)*exp(179.7*1E9/temp-39)
                # non-degen regime, high temp
                set taunse2=(temp/1E10)**(-5)
		#
                #
		#
stellarwind 1   #
		# Add stellar wind outside Helium WR component
		# Done as in Zhang, Woosley, Heger (2004)
		# but see:
		# http://adsabs.harvard.edu/abs/2006A%26A...460..105V
		#
		set myiedge=$1
		#
                # Mdot = 4*Pi*r^2*rho*vr
		# Mdot and vratedge in cgs units
		set secPyr=60.0*60.0*24.0*365.25
                set Mdot=1E-5*msun/secPyr
                set vratedge=1E3*1E5
                set rhoatedge=Mdot/(4.0*pi*r[myiedge]**2*vratedge)
		#
		set iii=myiedge
		while {iii<dimen(helium)} {
		   set rho[iii] = rhoatedge *(r[myiedge]/r[iii])**2
		   set vr[iii] = 1E3*1E5
		   #
		   set helium[iii] = 1.0 + 0*r[iii]
		   set nucleons[iii] = 0.0 + 0*r[iii]
		   set ye[iii] = 0.5 + 0*r[iii]
		   # assume temperature of slightly ionized material
		   # http://www.aas.org/publications/baas/v26n2/aas184/abs/S6705.html
		   set temp[iii] = 6E3 + 0*r[iii]
		   # treat wind as pure hydrogen
		   set  nucleons[iii]= 1.0 + 0*r[iii]
		   set  helium[iii]= 0.0 + 0*r[iii]
		   set  carbon[iii]= 0.0 + 0*r[iii]
		   set  oxygen[iii]= 0.0 + 0*r[iii]
		   set  neon[iii]= 0.0 + 0*r[iii]
		   set  magnesium[iii]= 0.0 + 0*r[iii]
		   set  si[iii]= 0.0 + 0*r[iii]
		   set  iron[iii]= 0.0 + 0*r[iii]
		   set omega[iii] = 0.0 + 0*r[iii]
		   #
		   set iii=iii+1
		}
		#
		# should be still close to 1.0
		set totalfracnew = nucleons+helium+carbon+oxygen+neon+magnesium+si+iron
		#
		#
findheedge 1   #
		# MW99 definition of He core extraction
		define HFRAC (0.01)
		#
		set iii=dimen(helium)-1
		while {iii>=0} {
		   if(helium[iii]>nucleons[iii] && nucleons[iii]<$HFRAC){ set $1=iii break }
		   set hefrac=helium[iii]
		   set hfrac=nucleons[iii]
		   #print {iii hfrac hefrac}
		   set iii=iii-1
		}
		#
setfreefall 1	#
		#
		#set vrfreefall=-sqrt(2.0*G*M/r)
		set vrfreefall=-sqrt(2.0*G*Mvsr*msun/r)
		set $1=(r<Rhe) ? vrfreefall : $1
		set vcoef=0.5*C
		set $1=(abs($1)>vcoef) ? vcoef*($1/abs($1)) : $1
		set $1[0]=$1[1]
		#
		#
extendstar 1    #
		# choose which way to extend
		#extendstarlog $1
		#extendstarlinear $1
		extendstarconst $1
		#
extendr 0       #
		#
		set numin=20
		set myi=0,numin-1,1
		#
		# myRin is inner edge of new grid.  HARM will extend if necessary
		set myRin=1E5
		set slope=(r[0]-myRin)/numin
		set rinner=myRin+slope*(myi-0)
		set rnew= rinner CONCAT r
		set rold=r
		set r=rnew
		#
truncaterho 0   #
		# this is only used if inserting BH or NS by hand and want mass to be consistent
		# presently depends upon particular stellar model!
		#
		set myi=0,dimen(rho),1
		# below depends on stellar model
		set itrans=dimen(rho)*2/10
		# inner Helium radius
		#set rhon=-2
		set rhon=0
		set myRtrans=r[itrans]
		# RHO=1.16e7 vr=-8.81E7 @ 2.115E8cm
		set rho0=rho[itrans]*(r/myRtrans)**(rhon)
		set vr0=vr[itrans]*(r/myRtrans)**(-rhon-2)
		set Mdot0=4*pi*r**2*rho0*vr0
		#
		set rhoold2=rho
		set rho=(r>myRtrans) ? rho : rho0
		#set rho=(r>myRtrans) ? rho : 0
		set vr=(r>myRtrans) ? vr : vr0
		#
recomputeMvsr 1 #
		set myi=0,dimen(r)-1,1
		der myi r dmyi dr
		set DMvsr=4*pi*r**2*rho*dr/msun
		set Mvsr=DMvsr*0
		#
		set Mvsr[0]=$1
		#
		do iii=1,dimen(r)-1,1 {\
		       #
		       set Mvsr[$iii]=Mvsr[$iii-1]+(DMvsr[$iii-1]+DMvsr[$iii])*0.5
		       #set Mvsr[$iii]=Mvsr[$iii-1]+DMvsr[$iii]
		    }
		    #set Mvsr[dimen(r)-1]=Mvsr[dimen(r)-2]
		    #
		#
extendstarlog 1    #
		#
		set slope=(LG(abs($1[1]+1E-30))-LG(abs($1[0]+1E-30)))/(LG(rold[1])-LG(rold[0]))
		set $1new=$1[0]*(rinner/rold[0])**(slope)
		set $1old=$1
		set $1=$1new CONCAT  $1old
		#
extendstarlinear 1    #
		#
		set slope=((($1[1]+1E-30))-(($1[0]+1E-30)))/((rold[1])-(rold[0]))
		set $1new=$1[0]+slope*(rinner-rold[0])
		set $1old=$1
		set $1=$1new CONCAT  $1old
		#
extendstarconst 1    #
		#
		set slope=rold[0]*0.0
		set $1new=$1[0]+slope*(rinner-rold[0])
		set $1old=$1
		set $1=$1new CONCAT  $1old
		#
		#
extendstarspecialtemp 1 #
		# assumes setgravity was called so have phi
		#
		# dP/dr = -\rho d\phi/dr -> P = \int (-\rho d\phi/dr) + offset
		#
		# P\propto T^4
		#
		set $1newtemp=rinner*0
		set temp0=$1[0]
		set pressvsr0=pressvsr[numin]
		#
		do ii=0,dimen(rinner)-1,1 {\
		       set $1newtemp[$ii]=temp0*(pressvsr[$ii]/pressvsr0)**(1/4)
		}
		set $1old=$1
		set $1=$1newtemp CONCAT  $1old
		#
		#
extendstarspecialdensity 1 #
		# assumes setgravity was called so have phi
		#
		# dP/dr = -\rho d\phi/dr -> P = \int (-\rho d\phi/dr) + offset
		#
		# P\propto \rho^{4/3}
		#
		set $1newrho=rinner*0
		set phi0=phi[numin]
		set rho0=$1[0]
		set pressvsr0=pressvsr[numin]
		#
		do ii=0,dimen(rinner)-1,1 {\
		       set $1newrho[$ii]=rho0*(pressvsr[$ii]/pressvsr0)**(3/4)
		}
		set $1old=$1
		set $1=$1newrho CONCAT  $1old
		#
		#
		#
		#
extendstar0 1    #
		#
		set slope=rold[0]*0.0
		set $1new=0.0+slope*(rinner-rold[0])
		set $1old=$1
		set $1=$1new CONCAT  $1old
		#
		#
		#
plotmvsrs 0     #
		ctype default
		pl 0 r mass 1101 1E5 1E14 1E-5 20
		ctype red
		pl 0 r Mvsr 1111 1E5 1E14 1E-5 20
		#
		ctype cyan vertline (LG(Rhe))
		ctype magenta vertline (LG(2000.0*rl))
		# used to get M(r=rl) for code's initial mass
		#print {r Mvsr rho}
		#
mvsrplot 0      #
		ctype default pl 0 r Mvsr 1101 rl 1E14 1E-1 20
		ctype red pl 0 r mass 1111 rl 1E14 1E-1 20
		ctype green vertline (LG(Rhe))
		ctype green vertline (LG(myRtrans))
		#
masscut 0       #
		#ctype default
		#pl 0 r mass 1101 rl 1E14 1E-10 1E2
		ctype green vertline (LG(Rhe))
		# Menclosed =1.78Msun @ r=2.11e+08cm
plot1 0   #
		define x2label "Density[g/cc] and fits"
		define x1label "r [cm]"
		#
		ctype default
		pl 0 r rho 1100
		#
		ctype red
		set myrho=10**(9.48)*(r/(10**7.4))**(-3.2)
		pl 0 r myrho 1110
		#
		ctype green
		set myrho=10**(9.48)*(r/(10**7.4))**(-2.8)
		pl 0 r myrho 1110
		#
		ctype blue
		set myrho=10**(-2)*(r/(10**(10.973)))**(-2)
		pl 0 r myrho 1110
		#
		ctype green vertline (LG(2.11E8))
		#
plot2 0     #
		define x2label "Temperature[K] and fits"
		define x1label "r [cm]"
		#
		ctype default
		pl 0 r temp 1100
		ctype red
		set mytemp=10**(7.93)*(r/(10**10.35))**(-.8419)
		pl 0 r mytemp 1110
		#
		ctype blue
		set mytemp=10**(7.09)*(r/(10**(10.828)))**(-0.7715)
		pl 0 r mytemp 1110
		#
plot3 0      #
		define x2label "Special Fraction by mass [X_i]"
		define x1label "r [cm]"
		#
		#      nucleons      helium       carbon       oxygen        neon       magnesium       si          iron
		#
		#
                set myrin=1E5
		ltype 0
		ctype default pl 0 r nucleons 1101 myrin 1E14 1E-3 2
		ctype red pl 0 r helium 1111 myrin 1E14 1E-3 2
		ctype blue pl 0 r carbon 1111 myrin 1E14 1E-3 2
		ctype green pl 0 r oxygen 1111 myrin 1E14 1E-3 2
		ctype yellow pl 0 r neon 1111 myrin 1E14 1E-3 2
		ltype 2 ctype cyan pl 0 r magnesium 1111 myrin 1E14 1E-3 2
		ltype 0
		ctype magenta pl 0 r si 1111 myrin 1E14 1E-3 2
		ctype cyan pl 0 r iron 1111 myrin 1E14 1E-3 2
		#
		ltype 2 ctype red pl 0 r totalfrac  1111 myrin 1E14 1E-3 2
		ltype 0
		#
		#
		ctype green vertline (LG(2.11E8))
		#
		#
plot3b 0      #
		define x2label "Special Fraction by mass [X_i]"
		define x1label "T [K]"
		#
		#      nucleons      helium       carbon       oxygen        neon       magnesium       si          iron
		#
		#
		ctype default pl 0 temp nucleons 1101 1E3 1E11 1E-3 2
		ctype red pl 0 temp helium 1111 1E3 1E11 1E-3 2
		ctype blue pl 0 temp carbon 1111 1E3 1E11 1E-3 2
		ctype green pl 0 temp oxygen 1111 1E3 1E11 1E-3 2
		ctype yellow pl 0 temp neon 1111 1E3 1E11 1E-3 2
		ctype cyan pl 0 temp magnesium 1111 1E3 1E11 1E-3 2
		ctype magenta pl 0 temp si 1111 1E3 1E11 1E-3 2
		ctype cyan pl 0 temp iron 1111 1E3 1E11 1E-3 2
		#
plot3c 0      #
		# dostandard
		define x2label "Ye"
		define x1label "T [K]"
		#
		#      nucleons      helium       carbon       oxygen        neon       magnesium       si          iron
		#
		#
		setyefit
		ctype default pl 0 temp ye 1000
		#
		ctype red pl 0 temp yefit 1010
		#
setyefit 0      #
		# fit
		set yeiron=0.4285
		set yefit = (temp<10**9.532) ? 0.5 : (temp>8.12e+09) ? yeiron : (yeiron-0.5)/(8.12e+09-10**9.532)*(temp-10**9.532)+0.5
		#
		#
plot3d 0      #
		# dostandard
		define x2label "Ye"
		define x1label "\rho_b"
		#
		#      nucleons      helium       carbon       oxygen        neon       magnesium       si          iron
		#
		#
		setyefitrhob
		ctype default pl 0 rhob ye 1000
		#
		ctype red pl 0 rhob yefitrhob 1010
		#
plot3e 0        #
		pl 0 r iron 1101 1E5 1E14 1E-10 2
		#
		#
setyefitrhob 0      #
		# fit
		set yenucleons=0.5
		set yene=0.497957
		set yemg=0.480252
		set yesi=0.462273
		set yeiron=0.428493
		#
		set rhobnucleons2ne=10**6.71
		set rhobne2mg=10**7.103
		set rhobmg2si=10**8.24
		set rhobsi2iron=3.616e+09
		#
		set yefitrhob = (rhob<rhobnucleons2ne) ? yenucleons : \
		    (rhob<rhobne2mg) ? yene : \
		    (rhob<rhobmg2si) ? yemg + (rhob-rhobne2mg)*(yesi-yemg)/(rhobmg2si-rhobne2mg) : \
		    (rhob<rhobsi2iron) ? yesi + (rhob-rhobmg2si)*(yeiron-yesi)/(rhobsi2iron-rhobmg2si) : \
		    yeiron
		    #
		#
		#(rhob>10**9.57) ? yeiron : (yeiron-0.5)/(10**9.57-10**6.71)*(rhob-10**6.71)+0.5
		#
		#
setpressures 0  #
		#
		#
		# NOT H2, rather H+N separate ~ H1 separate
		#set mu1=2
		set mu1=1
		set pnucleons=rho*R/mu1*temp
		#
		set mu2=4
		set phelium=rho*R/mu2*temp
		#
		set mu3=12
		set pcarbon=rho*R/mu3*temp
		#
		set mu4=16
		set poxygen=rho*R/mu4*temp
		#
		set mu5=20.18
		set pneon=rho*R/mu5*temp
		#
		set mu6=24.3050
		set pmagnesium=rho*R/mu6*temp
		#
		set mu7=28.09
		set psi=rho*R/mu7*temp
		#
		set mu8=55.845
		set piron=rho*R/mu8*temp
		#
		set pgaswrong=pnucleons+phelium+pcarbon+poxygen+pneon+pmagnesium+psi+piron
		#
		# mutot is mean mass per mass of proton (mean molecular weight)
		# used to compute correct pressure/internal energy of nucleonic component
		set mutot = 1.0/(nucleons/mu1+helium/mu2+carbon/mu3+oxygen/mu4+neon/mu5+magnesium/mu6+si/mu7+iron/mu8)
		#
		#
		#
		# below statement is wrong
		# mue is mass per electron, and by charge neutrality is same a mass per (bound or unbound) proton for cold (no e+) matter
		# below statement is correct
		# mue is the number of baryons per electron, not the same as mutot
		set mue = 1.0/ye
		# roughly 2 unless neutronization occurs.  Initial model provides Ye = n_e/n_b ~ 1/\mu_e
		#
		#
		#
		#
		# get pwf99 pressure
		computeppwf
		#
		# jet magnetic pressure
		getjetp
		#
		#
		#
		#
		#
		# below assumes all elements are bound as actual elements
		set pgastest = rho*R/mutot*temp
		set gam=5/3
		set ugastest=pgastest/(gam-1)
		#
		#
		# now consider gas pressure and internal energy when dissasociating them as alpha particles
		# since this is what code assumes at the temperatures here
		#
		# IRON:
		# 8.8MeV/nucleon for iron-56mu -> 492.8MeV total
		# 7.075MeV/nucleon for alpha particle-4mu -> 28.3MeV total
		# energy absorbed per nucleon is 1.725MeV/nucleon in going from iron to alphas
		#
		# Helium = alpha particle, no change
		#
		# Carbon-12: 7.45MeV/nucleon -> 89MeV total
		# energy absorbed per nucleon is 0.375MeV/nucleon in going from C12 to alphas
		#
		# "nucleons-hydrogen"-1 proton :
		# energy *RELEASED* per nucleon is 7.45MeV - huge
		#
		#
		set nnucleons = rho/(mutot*mp)
		#
		#
		set pradtest1=11/12*arad*temp**4
		set pradtest2=1.0/3.0*arad*temp**4
		set rattemp=(temp*kb/(me*c**2))
		set pradtest=(rattemp>1.0 ? pradtest1 : pradtest2)
		#
		set gam=4/3
		set uradtest=pradtest/(gam-1)
		#
		#
		set pdegentest=K*(rho/mue)**(4/3)
		set udegentest=3.0*K*(rho/mue)**(1/3)*rho
		#
		# test values
		set ptottest=pgastest+pradtest+pdegentest
		set utottest=ugastest+uradtest+udegentest
		#
		# ~1E-3 at Si region
		set porho=ptottest/(rho*C*C)
		#
		set vrcollapse=-sqrt(2.0*G*Mvsr*msun/r)
		set vrbh = C*(r/rl)**(-0.8)
		set myvr=(r>2.11E8) ? vrcollapse : vrbh
		set myvr=vrcollapse
		set rampressure=rho*myvr*myvr
		#
		#
plot4 0         #
		define x2label "Pressure [ergs/cm^3]"
		define x1label "r [cm]"
		#
		#
		#
		ctype default pl 0 r pgastest 1101 rl 1E14 1E3 1E32
		#ctype default pl 0 r pgastest 1101 rl (1E4*rl) 1E20 1E28
		ctype red pl 0 r pradtest 1110
		ctype blue pl 0 r pdegentest 1110
		ctype cyan pl 0 r ptottest 1110
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype green pl 0 r ptot 1110
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		set myfit=10**(16.99)*(r/(10**10.42))**(-3.6) if(r<10**10.42 && r>=4.2E7)
		set myr=r if(r<10**10.42 && r>=4.2E7)
		ltype 2 ctype green pl 0 myr myfit 1110
		ltype 0
		#
		#set myfit=10**(13.18)*(r/(10**10.9))**(-2.84) if(r>10**10.9)
		#set myr=r if(r>10**10.9)
		set myfit=10**(16.18)*(r/(10**10.9))**(-3.0)
		set myr=r
		ctype magenta pl 0 myr myfit 1110
		#
		#
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype cyan pl 0 r jetp 1110
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		ctype yellow pl 0 r rampressure 1110
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ltype 2 ctype blue pl 0 r ppwfsimple 1110
		ltype 0
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		ctype green vertline (LG(Rhe))
		ctype green vertline (LG(myRtrans))
		#
getjetp 0   #
		#
		set rhodisk=1E11
		set bsq0=0.013*rhodisk*C*C
		set jetp=0.5*bsq0*(r/rl)**(-2.68)
		#
setgrbconsts 0  #http://www.astro.wisc.edu/~dolan/constants.html
		#
		#
                # erg K^{-1} g^{-1}
		set kb=1.3807E-16
		# defs:
		set C=2.99792458E10
                set c=C
		set amu=1.660538782E-24
		set qe=4.8032068d-10
		#
		#set Na=6.02214179E23
		set Na=1/amu
		#
		#
		#set ergPmev = 1.60217646E-6
		#set ergPmev = 1.6021772E-6 # bad
		# http://physics.nist.gov/cgi-bin/cuu/Convert?exp=0&num=1&From=ev&To=kg&Action=Convert+value+and+show+factor
		set ergPmev = 1.782661758E-30*1E3*c**2
		#
		set mev2K=1.16041d10
		#
		#
		#set mp=1.67262158E-24
		# http://en.wikipedia.org/wiki/Proton
		# http://physics.nist.gov/cgi-bin/cuu/Value?mp
		set mp=1.672621637E-24
		# NIST:
		#set me=9.10938188E-28
		set me=9.10938215E-28
		# http://physics.nist.gov/cgi-bin/cuu/Value?mn|search_for=atomnuc!
		set mn=1.674927211E-24
		#
		set malpha=6.64465598E-24
		# some constants
		#set hpl=6.6262E-27
		#
		set hpl=4.13566733E-15*1E-6*ergPmev
		#
		#
		#
		set Ebincgs = (-malpha+2.0*mp+2.0*mn)*c**2
		set EbinMeV = Ebincgs/ergPmev
		#
		set arad=7.56641E-15
		###set mb = (mp+mn)*0.5
		set mb = amu
		# Kaz definition of mass of baryon
		set mN = mb
		set R=kb/mb
		#set mue=2.0
		set K=(2*pi*hpl*C/3)*(3/(8*pi*mn))**(4/3)
		#
		set Q=(mn-mp)*c**2
		set Rp=kb/mp
                set Re=kb/me
                set hbar=hpl/(2*pi)
                set a=5.6704E-5 * 4 / c
		#set K=1.24E15
                set K2=9.9E12
		#
		#
		set msun=1.989E33
		set G=6.672E-8
		#set M=1.719*msun
		# below is as in code
		set M=1.7*msun
		set rl=G*M/(C*C)
		#
		set Rhe=2.247e+08
		#set Rhe=2.11E8
		#
		set myRtrans=Rhe
		#
		set LUNIT = rl
		set TUNIT = rl/C
		set VUNIT = C
		set RHOUNIT = 1
		set MUNIT = RHOUNIT*LUNIT**3
		set EDENUNIT = RHOUNIT*VUNIT*VUNIT
		#
		#
setgravity 0    #
		set Mvsrcgs = Mvsr*msun
		set specforce = -G*Mvsrcgs/(r*r)
		integrate r specforce intr phifromint
		set phiouter = -G*Mvsrcgs[dimen(Mvsrcgs)-1]/r[dimen(r)-1]
		set phi=-(phifromint-phifromint[dimen(phifromint)-1])+phiouter
		#
		set dpdr = specforce*rho
		integrate r dpdr intr pressvsrfromint
		set pressvsrouter = 0.0
		set pressvsr=-(pressvsrfromint-pressvsrfromint[dimen(pressvsrfromint)-1])+pressvsrouter
		#
		#
setH 0          #
		# \approx P/(\rho+u+P)
		set cs2fake = abs(utot)/abs(rho*c*c + utot)
		# below /c/c is so dphidror has units of 1/r^2 as in HARM
		set dphidr = -specforce/c/c
		set dphidrOr = dphidr/r
		set SMALL=1E-30
		#
		#  as in HARM, if unbinding, then assume very thin (NOT THICK!)
		set Hdisk = (dphidrOr>SMALL) ? (sqrt(cs2fake/(dphidrOr+SMALL))) : SMALL
		#
		set Hstar = (dphidr>0.0) ? (cs2fake/(dphidr+SMALL)) : SMALL
                #
                der r rho dr drhodr
                set Hest3 = rho/(abs(drhodr)+1E-30)
		#
		#
		####################################
		# Compute initial guess for Hcm
		####################################
                # forward integral
		# get dr since dr is not constant
		der r rho dr drhodr
		#
                set i=0,dimen(rho)-1,1
                set Hofr=i*0
                do ii=0,dimen(rho)-1,1 {
                    set use = (i>=$ii) ? 1 : 0
		    set dV = 4.0*pi*r**2*dr
                    set Hofr[$ii]=SUM(abs(r-r[$ii])*rho*use*dV)/SUM(use*rho*dV)
                }
                #
                # use more accurate H
                #
                #  print {r god Hdisk Hstar Hest3 Hofr}
                #
                # disk is not relevant for stellar model
                #set Htest = (Hdisk>Hstar) ? Hstar : Hdisk
                set Htest = Hofr
		set Htest = (Htest<1E-20) ? 1E-20 : Htest
		#
		set Hcm = Htest
		set Ynu = Htest*0.0
		#
		if(1){
		if(dimen(lambdatot)==dimen(rho)){
		   #recomputeH
		   #set Hcm = Hofrtau
		   recomputeH2 lambdatot Hofrtau2
		   set Hcm = Hofrtau2
                   #
                   set lambdaphoton=1.0/tauphotonohcm
		   recomputeH2 lambdaphoton Hofrtau2photon
		   set Hcmphoton = Hofrtau2photon
		   #set Hcm = 1E-15 + Hcm*0
		   # GODMARK DEBUG
                   #set Hcm = 1E6 + Hcm*0
		   #
		   # assume neutrinos perfectly thermalized at t=0
		   #set Ynu=Ynuthermal
		   # assume neutrinos totally unthermalized at t=0
		   set Ynu=Hcm*0.0
		   #
		   #
		}
		}
		#
		if(0){
		   recomputeH3
		   set Hcm = Hofrlocal
		}
		#
		#
recomputeH 0    # assuming have lambdatot from one pass of H, now compute opacity depth
		#
		# get dr
		der r lambdatot dr dlambdatotdr
		#
                # forward integral
                set i=0,dimen(lambdatot)-1,1
                set Hofrtau=i*0
                do ii=0,dimen(lambdatot)-1,1 {
                    set use = (i>=$ii) ? 1 : 0
                    set Hofrtau[$ii]=SUM(abs(r-r[$ii])*use*dr/lambdatot)/SUM(use*dr/lambdatot)
                }
                #
                # use more accurate H
		#
recomputeH2 2    # assuming have lambdatot from one pass of H, now compute opacity depth
                # Most correct
                #
                set locallambda=$1
		#
		# get dr
		der r locallambda dr dlocallambdadr
		set igod=0,dimen(r)-1,1
		der igod r di dr
		#
                # forward integral
                set i=0,dimen(locallambda)-1,1
                set $2=i*0
                do ii=0,dimen(locallambda)-1,1 {
                    set use = (i>=$ii) ? 1 : 0
                    set $2[$ii]=SUM(use*dr/locallambda)/(1.0/locallambda[$ii])
                }
                #
		#
recomputeH3 0    # assuming have lambdatot from one pass of H, now compute opacity depth
		#
		# get dr
		der r rho dr drhodr
		set Hofrlocal = abs(rho/drhodr)
		#
recomputetau 0  #
		#
		# get dr
		der r lambdatot rnew dlambdatotdr
		set igod=0,dimen(r)-1,1
		der igod r di dr
		#
                # forward integral
                set i=0,dimen(lambdatot)-1,1
                set tauafter=i*0
                do ii=0,dimen(lambdatot)-1,1 {
                    set use = (i>=$ii) ? 1 : 0
                    set tauafter[$ii]=SUM(use*dr/lambdatot)
                }
                #
                # use more accurate H
		#
plotHs 0        #
		#
		define x2label "H [cm]"
		define x1label "r [cm]"
		#
		recomputeH
		recomputeH2 lambdatot Hofrtau2
                #
                set lambdaphoton=1.0/tauphotonohcm
                recomputeH2 lambdaphoton Hofrtau2photon
                set Hcmphoton = Hofrtau2photon
                #
		recomputeH2 lambdatot Hofrtau2
		recomputeH3
		#
		#
		ltype 0 
		define PLOTLWEIGHT (5)
		ctype default pl 0 r lambdatot 1101 1E4 1E15 1 1E20
		define PLOTLWEIGHT (3)
		ltype 2 ctype default pl 0 r hcm 1111 1E4 1E15 1 1E20
		ltype 0
		ctype red pl 0 r Hcm 1111 1E4 1E15 1 1E20
		#ctype blue pl 0 r Hstar 1111 1E4 1E15 1 1E20
                ctype blue pl 0 r Hcmphoton 1111 1E4 1E15 1 1E20
		ctype cyan pl 0 r Hofrtau 1111 1E4 1E15 1 1E20
                # below is correct version after iterating
		ctype green pl 0 r Hofrtau2 1111 1E4 1E15 1 1E20
		ctype yellow pl 0 r Hofr 1111 1E4 1E15 1 1E20
		ctype magenta pl 0 r Hofrlocal 1111 1E4 1E15 1 1E20
		#
		#
checkforcebal 0 #
		#
		setgravity
		setH
		#
		#ctype default pl 0 r phi 1100
		#ctype red pl 0 r (specforce*r) 1110
		#
		#
		# now check force balance
		#
		set ptotrad = (4/3-1)*utot
		#
		# pressure from my simple EOS (nearly PWF like)
		der r ptot dr dptot
		set pressureaccx = -dptot/rho
		#
		# pressure from HELM EOS
		# seems to give better force balance, so probably more right
		# only issue is HELM doesn't account for Ye!=0.5
		der r ptotnew dr dptotnew
		set pressurenewaccx = -dptotnew/rho
		#
		der r ptotrad dr dptotrad
		set pressureradaccx = -dptotrad/rho
		#
		#
		#
		der intr pressvsr dintr dpressvsr
		set pressurevsraccx=-dpressvsr/rho
		#
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT)
		ctype default pl 0 r specforce 1101 1E5 1E14 1E-5 1E15
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT)
		ctype red pl 0 r (-pressureaccx) 1111 1E5 1E14 1E-5 1E15
		ctype cyan pl 0 r (-pressurenewaccx) 1111 1E5 1E14 1E-5 1E15
		ctype blue pl 0 r (-pressureradaccx) 1111 1E5 1E14 1E-5 1E15
		ctype green pl 0 r (-pressurevsraccx) 1111 1E5 1E14 1E-5 1E15
		#
		ctype red vertline (LG(rold[0]))
		#
		#
forcecode 0     #
		set roughpacc= (ptot/(r*rho)/LUNIT*TUNIT**2)
		#
		set specforcecode = specforce/LUNIT*TUNIT**2
		set pressureaccxcode = pressureaccx/LUNIT*TUNIT**2
		set pressureradaccxcode = pressureradaccx/LUNIT*TUNIT**2
		#
		ctype default pl 0 r specforcecode 1101 rl (1E4*rl) 1E-10 10
		ctype red pl 0 r (-pressureaccxcode) 1111 rl (1E4*rl) 1E-10 10
		ctype blue pl 0 r (-pressureradaccxcode) 1111 rl (1E4*rl) 1E-10 10
		#
checktemp  0    #
		ctype default pl 0 r temp 1101 rl (1E4*rl) 1E3 1E12
		#
checkvel 0      #
		# up to almost 0.1, so pretty non-relativistic (same as in code)
		set vocfromphi=sqrt(-phi)/C
		#
		ctype default pl 0 r vocfromphi 0001 rl (1E4*rl) -.01 0.1
		#
		#
checkpress 0    #
		# compare pressures
		ctype default pl 0 r ptot 1100
		ctype red pl 0 r ((4/3-1)*utot) 1110
		ctype blue pl 0 r ((5/3-1)*utot) 1110
		#
checktscale 0   #
		#
		#
		set tau = sqrt(0.2945/(G*rho))
		#
processeos1 0    #
		# output header for EOS program
		#
		define print_noheader (1)
		#
		set numlines=dimen(r)
		#
		print stellarmodel.head '%d\n' {numlines}
		#
		#
		# now print out data
		#
		# 15 things
                # Hcm computed in sm (presently from current lambdatot)
		print stellarmodel.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
                {rho temp ye abarin abarboundin nucleons helium carbon oxygen neon magnesium si iron Hcm Ynu}
		#
		#
		#
processeos2 0   # 
		#
		# save old quantities one might overwrite
		#
		set rhoold=rho
		set tkold=temp
		set yeold=ye
		set utotold=utot
		set ptotold=ptot
		#set stotold=stot
		#
		#
		#da eos.dat
		#lines 1 100000000
		#read '%g %g %g %g %g %g %g %g' {rhonew tempnew hcmnew tdynnew ptotnew utotnew stotnew Qmnew}
		#
		# assume whichdatatype==3 used with full 5D EOS used
		#jre kaz.m
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		set rhonew=rhob
		set tempnew=temp
		set yenew=tdynorye
		set utotnew=utot
		set ptotnew=ptot
		set stotnew=stot
		set Qmnew=Qm
                set Nmnew=Nm
		#
		echo "now store back old saved versions"
		#
		set rho=rhoold
		set temp=tkold
		set utot=utotold
		set ptot=ptotold
		#set stot=stotold
		#
		#
		#
processeos 0    #
		# DEBUG:
		#
		set iiii=0,dimen(rho)-1,1
		#
		if(0){
		   #set rho=10**(2 + (14-2)/(dimen(rho)-1)*iiii)
		   #set rho=10**(9 + (15-9)/(dimen(rho)-1)*iiii)
		   set temp=10**(9.3 + (9.8-9.3)/(dimen(rho)-1)*iiii)
		}
		if(0){
		   set rho=10**11.00344827 + 0*iiii
		set ye=0.502 + iiii*0
		set nucleons=1.0 + iiii*0
		set helium=0.0 + iiii*0
		set carbon=0.0 + iiii*0
		set oxygen=0.0 + iiii*0
		set neon=0.0 + iiii*0
		set magnesium=0.0 + iiii*0
		set si=0.0 + iiii*0
		set iron=0.0 + iiii*0
		set Hcm=0.0 + iiii*0
		}
		#DEBUG:
		#set Hcm=Hcm*1E2
		#
		#
		# output
		processeos1
		#
		# process data
		echo "HELM begin"
		!./helmstareos.exe > processeos.output
		echo "HELM end"
		#
		# input
		processeos2
		#
		#
                echo "done properly"
		#
outputmodel 0   #
		#
		set QBH0=0.0
		# below not right since need rotation profile
		set aBH0=0.0
		#
		if($WHICHPROBLEM==0){ define filename "stellar0.txt" }
		if($WHICHPROBLEM==1){ define filename "stellar1.txt" }
		if($WHICHPROBLEM==2){ define filename "stellar2.txt" }
		#
		set numlines=dimen(r)
		#
		define print_noheader (1)
		#
		print $filename '%d %21.15g %21.15g %21.15g\n' {numlines MBH0 aBH0 QBH0}
		#
		#
		#
		print + $filename '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
                {r rho utot vr temp ye Ynu Hcm nucleons helium carbon oxygen neon magnesium si iron j omega inertia}
		#
		#
		#
		#
		#
computeppwf 0   #
		#
		# Note that the PWF EOS assumes free n,p or alphas, while stellar model has various heavy nuclei
		#
                #
		#
		set rhob=rho
		set T=temp
		#
		set xnuc1=22.16*(rhob/1E10)**(-3/4)*(T/1E10)**(1.125)*exp(-8.209*1E10/T)
		#
		# use Kohri
                set xnucpwf=(xnuc1>1) ? 1 : xnuc1
		#
		#pl 0 r xnucpwf 1101 rl (1E4*rl) 1E-20 10
		#
                #
		#
		# baryons
                set num=(1+3.0*xnucpwf)/4
                set ppwfbaryon=rhob*R*T*num
                #
		set ppwfrad=11/12*a*T**4
		set ppwfdegen=1.24E15*(rhob/mue)**(4/3)
		#
		set upwfdegen=3.0*K*(rhob/mue)**(1/3)*rhob
		set upwfrad=ppwfrad/(4.0/3.0-1.0)
		set upwfbaryon=ppwfbaryon/(5.0/3.0-1.0)
		#
		set ppwfsimple=ppwfbaryon + ppwfrad  + ppwfdegen
		set upwfsimple=upwfbaryon + upwfrad  + upwfdegen
                #
comparepwf 0    #
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype default pl 0 r prad 1100
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		ctype red pl 0 r ppwfrad 1110
		ctype blue pl 0 r p_photon 1110
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype default pl 0 r pgas 1100
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		ctype red pl 0 r ppwfbaryon 1110
		ctype blue pl 0 r p_N 1110
		ctype green pl 0 r pcoul 1110
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype default pl 0 r pdegen 1100
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		ctype red pl 0 r ppwfdegen 1110
		ctype blue pl 0 r p_eleposi 1110
		#
		#
		#
checkpressure0  0 #
		 print {rhob temp ptot utot}
		 #
comparepress0    # Check individual contributions to EOS pressures
		define x2label "Pressure [ergs/cm^3]"
		define x1label "r [cm]"
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT)
		ctype default pl 0 r ptottest 1101 1E5 1E14 0.1 1E30
		ctype red pl 0 r ptotnew 1111 1E5 1E14 0.1 1E30
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT)
		#ctype green pl 0 r pcou 1111 1E5 1E14 0.1 1E30
		ctype blue pl 0 r p_photon 1111 1E5 1E14 0.1 1E30
		ctype magenta pl 0 r p_eleposi 1111 1E5 1E14 0.1 1E30
		ctype cyan pl 0 r p_N 1111 1E5 1E14 0.1 1E30
		ctype yellow pl 0 r p_nu 1111 1E5 1E14 0.1 1E30
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		# simple does well for t=0
		#ctype yellow pl 0 r ppwfsimple 1111 1E5 1E14 0.1 1E30
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		#
		set mydidconverge=(didconverge==1 ? 1E2 : 0)
		set mydidconverge2=(didconverge==-500 ? 1E1 : 0)
		ctype default pl 0 r (mydidconverge) 1111 1E5 1E14 0.1 1E35
		ctype blue pl 0 r (mydidconverge2) 1111 1E5 1E14 0.1 1E35
		#
		set lrhobminin=5.09999986398488
		set rhomin = 1.05*10**(lrhobminin)
		set ltkminout=-1.0
		set tmin = 1.05*10**(ltkminout)*mev2K
		print {rhomin tmin}
		## 1.322e+05   1.218e+09
		#print {r rho temp}
		# where model=0 not within Shen table anymore
		ctype red vertline (LG(1.338e+09))
 		ctype green vertline (LG(1.482e+09))
		#
		#
compareu0       # Check individual contributions to EOS internal energy densities
		define x2label "Internal E-Density [ergs/cm^3]"
		define x1label "r [cm]"
		#
		set u_N=(rho_N-rhob*c**2)
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype default pl 0 r utottest 1101 1E5 1E14 0.1 1E35
		ctype red pl 0 r utotnew 1111 1E5 1E14 0.1 1E35
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#ctype green pl 0 r ucou 1111 1E5 1E14 0.1 1E35
		ctype blue pl 0 r rho_photon 1111 1E5 1E14 0.1 1E35
		ctype magenta pl 0 r rho_eleposi 1111 1E5 1E14 0.1 1E35
		ctype cyan pl 0 r (u_N) 1111 1E5 1E14 0.1 1E35
		ctype yellow pl 0 r rho_nu 1111 1E5 1E14 0.1 1E35
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype yellow pl 0 r upwfsimple 1111 1E5 1E14 0.1 1E35
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		set mydidconverge=(didconverge==1 ? 1E2 : 0)
		set mydidconverge2=(didconverge==-500 ? 1E1 : 0)
		ctype default pl 0 r (mydidconverge) 1111 1E5 1E14 0.1 1E35
		ctype blue pl 0 r (mydidconverge2) 1111 1E5 1E14 0.1 1E35
		#
		set lrhobminin=5.09999986398488
		set rhomin = 1.05*10**(lrhobminin)
		set ltkminout=-1.0
		set tmin = 1.05*10**(ltkminout)*mev2K
		print {rhomin tmin}
		## 1.322e+05   1.218e+09
		#print {r rho temp}
		# where model=0 not within Shen table anymore
		ctype red vertline (LG(1.338e+09))
 		ctype green vertline (LG(1.482e+09))
		#
		#
		#
setAs 0         #http://www.nndc.bnl.gov/amdc/masstables/Ame2003/mass.mas03
		#http://www.science.uwaterloo.ca/~cchieh/cact/nuctek/nuclideunstable.html
		# http://en.wikipedia.org/wiki/Unified_atomic_mass_unit
		#http://en.wikipedia.org/wiki/Excess_energy
		#
		set     AH      = 1.00794d0
		#set     AHe     = 4.002602d0
		set     AHe     = 4.00153
		# http://en.wikipedia.org/wiki/Carbon-12
		#set     AC12    = 12.01078d0
		set     AC12    = 12.0 # bind=92,161.753N1 0.014 keV
		# http://en.wikipedia.org/wiki/Oxygen-16
		#set     AO16    = 15.99943d0
		set AO16 = 15.99491461956
		set     ANe20   = 20.17976d0
		# http://www.matpack.de/Info/Nuclear/Nuclids/N/Ne20.html
		set Ane20 = 19.9924402 # bind=160644.852 N1 0.024 keV
		set     AMg24   = 24.30506d0
		set     ASi28   = 28.08553d0
		# 
		#set     AFe56   = 55.8452d0 # periodic table not in terms of $m_u=amu$
		# http://en.wikipedia.org/wiki/Iron-56
		#set AFe56 = 55.9349375 # with electrons?
		#http://www.cartage.org.lb/en/themes/Sciences/Chemistry/NuclearChemistry/NuclChemIndex/NuclearBindingEnergy/NuclearBindingEnergy.htm
		set AFe56 = 55.92066
		#
		print {AHe AC12 AO16 ANe20 AMg24 ASi28 AFe56}
		#
		# override with NUBASE program
		#
		computemass   1   0  0  ((mn-mb)*c**2/ergPmev)  Anut Bindnut
		computemass   1   1  0  ((mp-mb)*c**2/ergPmev)  Aprot Bindprot
		#computemass   1   1  1  (7288.9705*1E-3+13.6*1E-3)  Aprot Bindprot
		computemass   4   2  2  (2424.9156*1E-3)  AHe BindHe
		computemass  12   6  6  (0.0*1E-3)        AC12 BindC12
		computemass  16   8  8  (-4737.0014*1E-3) A016 BindO16
		computemass  20  10 10  (-7041.9313*1E-3) ANe20 BindNe20
		computemass  24  12 12  (-13933.567*1E-3) AMg24 BindMg24
		computemass  28  14 14  (-21492.7968*1E-3) ASi28 BindSi28
		computemass  56  26 26  (-60605.4*1E-3)   AFe56 BindFe56
		#
		#print {Anut Aprot AHe AC12 AO16 ANe20 AMg24 ASi28 AFe56}
		print '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' {Anut Aprot AHe AC12 AO16 ANe20 AMg24 ASi28 AFe56}
		#
		print {Bindnut Bindprot BindHe BindC12 BindO16 BindNe20 BindMg24 BindSi28 BindFe56}
		#
		#
computemass 6   # e.g. for 56Fe without electrons: computemass 56 26 26 -60.6054 AFe56 BindFe56
		#
		set A=$1
		set Z=$2
		# Ze is # of electrons to *remove*
		set Ze=$3
		set N=A-Z
		set MEmev=$4
		set MANUMmev=A*amu*c**2/ergPmev
		set truemevnucele=MEmev+MANUMmev
		# below neglects binding energy of electron itself, which is quite small for our nuclear purposes
		set truemevnuconly=truemevnucele-Ze*me*c**2/ergPmev
		set truepermu=truemevnuconly*ergPmev/c**2/mb
		set freemev=(N*mn+Z*mp)*c**2/ergPmev
		set bindperA=(truemevnuconly-freemev)/A
		#print {truemevnuconly truepermu bindperA}
		#
		set $5=truepermu
		set $6=bindperA
		#
		#
computemutot 0	#
		#
		#
		set mutotstep = r*0
		set mutotstep = (temp>10**9.6) ? 1.0/(0.9877/55.8452d0+0.00745/4.0+0.004779/1) : (temp>10**9.45) ? 28.08553d0 : (temp>10**8.55) ? 15.99943d0 : (temp>10**7.50) ? 4.002602d0 : 1.00794d0
		#
		set mutotlinear = r*0
		set tk=temp
		#
		setAs
		#
		set mutot1=AH
		set mutot2=AHe
		set mutot3=AO16
		set mutot4=ASi28
		set mutot5=1.0/(0.9877/AFe56 + 0.00745/AHe + 0.004779/AH)
		#
		set tk12=10**7.50
		set tk23=10**8.55
		set tk34=10**9.45
		set tk45=10**9.6
 		#
		set mutotlinear = (tk>=tk45) ? \
		    mutot5 : \
		    (tk>=tk34) ? \
		    mutot4 + (tk-tk34)*(mutot5-mutot4)/(tk45-tk34) : \
		    (tk>=tk23) ? \
		    mutot3 + (tk-tk23)*(mutot4-mutot3)/(tk34-tk23) : \
		    (tk>=tk12) ? \
		    mutot2 : \
		    mutot1
		#
		#		    #mutot2 + (tk-tk12)*(mutot3-mutot2)/(tk23-tk12)
		#
		#set rho12=10**(-10)
		set rho12=10**0
		set rho23=10**3.34
		set rho34=10**6.64
		set rho45=10**7.09
 		#
		set mutotlinearrho = (rho>=rho45) ? \
		    mutot5 : \
		    (rho>=rho34) ? \
		    mutot4 + (rho-rho34)*(mutot5-mutot4)/(rho45-rho34) : \
		    (rho>=rho23) ? \
		    mutot3 + (rho-rho23)*(mutot4-mutot3)/(rho34-rho23) : \
		    (rho>=rho12) ? \
		    mutot2 : \
		    mutot1
		#
		#
comparemutot 0 #
		#
		computemutot
		#
		# dostandard 1
		#
		ctype default pl 0 rho abar 1000
		ctype yellow pl 0 rho abarin 1010
		ctype cyan pl 0 rho mutot 1010
		ctype red pl 0 rho mutotlinear 1010
		ctype blue pl 0 rho mutotlinearrho 1010
                ctype green pl 0 rho aheav 1010
		#
comparemutot2 0 #
		#
		computemutot
		#
		# dostandard 1
		#
		ctype default pl 0 temp abar 1000
		ctype yellow pl 0 temp abarin 1010
		ctype cyan pl 0 temp mutot 1010
		ctype red pl 0 temp mutotlinear 1010
		ctype blue pl 0 temp mutotlinearrho 1010
		#
simplemutot 0   #
		#
		# dostandard 1
		computemutot
		#
		define x1label "r"
		define x2label "\mu_e"
		ctype default pl 0 r abar 1000
		ctype yellow pl 0 r abarin 1010
		ctype red pl 0 r mutot 1010
		ctype blue pl 0 r mutotstep 1010
		ctype cyan pl 0 r mutotlinear 1010
		ctype magenta pl 0 r mutotlinearrho 1010
		#
		set mydidconverge=(didconverge==1 ? 1E2 : 0)
		set mydidconverge2=(didconverge==-500 ? 1E1 : 0)
		ctype default pl 0 r (mydidconverge) 1110
		ctype blue pl 0 r (mydidconverge2) 1110
		#
		#
		#
		#
compareabar 0   #
		#
		ctype default pl 0 r mutot 1000
		ctype red pl 0 r abar 1010
                ctype blue pl 0 r aheav 1010
		#
		#read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {etae xnuc npratio   p_photon p_eleposi p_N p_nu rho_photon rho_eleposi rho_N rho_nu  s_photon s_eleposi s_N s_nu  tauael taus tautel tautmu tauamu  Qmel Qmmu Qmtau  qminusel qminusmu}
		#
		#
		#
reldegen 0      #
		#
		# relativity paramter of electrons
		pl 0 r (kb*temp/(me*c**2)) 1000
		# shows inner core is relativistic, while outer is non-relativistic
		#
		set mue=2
		set ne = (rhob/(mue*mp))
		set reldegen = ne/(2*(kb*temp/(hbar*c))**3/(pi**2))
		#
		pl 0 r reldegen 1000
		# shows inner region is certainly degenerate, outer region is not
		#
		#
		#
utotdiffcompute 0 #
		#
		# load stellar model's u and p
		jre grbmodel.m
		dostandard
		set Tstellar=temp
		set ustellar=utot
		set pstellar=ptot
		set rhostellar=rho
		set rstellar=r
		#
		# get kaz diff data
		jre phivsr.m
		redokazmono
		set rhokaz=rhob
		set Tkaz=tk
		set ptotkaz=ptot
		set utotkaz=utot
		set chikaz=chi
		set pfit=pdegenfit
		set ufit=udegenfit
		set chifit=chidegenfit
		set ptotdiffkaz=ptotdiff
		set utotdiffkaz=utotdiff
		set chidiffkaz=chidiff
		#
		redohelm
		set rhohelm=rhob
		set Thelm=tk
		set ptothelm=ptot
		set utothelm=utot
		set chihelm=chi
		set pfit=pdegenfit
		set ufit=udegenfit
		set chifit=chidegenfit
		set ptotdiffhelm=ptotdiff
		set utotdiffhelm=utotdiff
		set chidiffhelm=chidiff
		#
		#
		redohelmmono
		set rhohelmmono=rhob
		set Thelmmono=tk
		set ptothelmmono=ptot
		set utothelmmono=utot
		set chihelmmono=chi
		set pfit=pdegenfit
		set ufit=udegenfit
		set chifit=chidegenfit
		set ptotdiffhelmmono=ptotdiff
		set utotdiffhelmmono=utotdiff
		set chidiffhelmmono=chidiff
		#
utotdiffplot 0  #
		#
		#
		#
		define x1label "\rho"
		define x2label "u"
		#ctype default pl 0 rhostellar ustellar 1101 1E-16 1E15 1 1E38
		#ctype default pl 0 rhostellar ustellar 1101 1E2 1E15 1E12 1E38
		ctype default pl 0 rhostellar ustellar 1101 1E8 1E10 1E25 1E29
		points (LG(rhostellar)) (LG(ustellar))
		#
		set myrhokaz=rhokaz if(Tkaz<=Tkaz[0])
		set myutotkaz=utotkaz if(Tkaz<=Tkaz[0])
		#ctype red pl 0 myrhokaz myutotkaz 1110
		ctype red points (LG(myrhokaz)) (LG(myutotkaz))
		#
		set myrhohelm=rhohelm if(Thelm<=Thelm[0])
		set myutothelm=utothelm if(Thelm<=Thelm[0])
		#ctype blue pl 0 myrhohelm myutothelm 1110
		ctype blue points (LG(myrhohelm)) (LG(myutothelm))
		#
		set myrhohelmmono=rhohelmmono if(Thelmmono<=Thelmmono[0])
		set myutothelmmono=utothelmmono if(Thelmmono<=Thelmmono[0])
		#ctype cyan pl 0 myrhohelmmono myutothelmmono 1110
		ctype cyan points (LG(myrhohelmmono)) (LG(myutothelmmono))
		#
checktaus 0     #
		# optical depth seems too large at t=0
		#
		pl 0 r Hcm 1101 1E5 1E14 1E4 1E17
		#
		#
		ctype default pl 0 r (qtautelohcm*hcm) 1100
		ctype red pl 0 r (Hcm/1E8) 1111 1E5 1E14 1E4 1E17
		#
		# So seems even at non-madeup radii tau=1 is reached
		#
plotgamma 0    #
		#
		define x1label "r [cm]"
		define x2label "\Gamma [1/s]"
		#
		ctype default pl 0 r gammapeglobal 1101 1E5 1E14 1E-10 1E2
		ctype red pl 0 r gammaAeglobal 1111 1E5 1E14 1E-10 1E2
		ctype blue pl 0 r gammapnuglobal 1111 1E5 1E14 1E-10 1E2
		ctype green pl 0 r gammapenuglobal 1111 1E5 1E14 1E-10 1E2
		ctype cyan pl 0 r gammanglobal 1111 1E5 1E14 1E-10 1E2
		ctype magenta pl 0 r gammaneglobal 1111 1E5 1E14 1E-10 1E2
		ctype yellow pl 0 r gammannuglobal 1111 1E5 1E14 1E-10 1E2
		#
                ltype 2 ctype red pl 0 r (gammap2nglobal) 1111 1E5 1E14 1E-10 1E2
                ctype cyan pl 0 r (gamman2pglobal) 1111 1E5 1E14 1E-10 1E2
		ltype 0
		#
		ctype red vertline (LG(rold[0]))
		#
plotqminus 0    #
		#
		# so optically thick related nu rates are still low even
		# though tau>1, which is why dyedt is so negative still
		#
		ctype default pl 0 r (qminusel) 1101 1E4 1E15 1E-20 1E35
		ctype red pl 0 r (qminusmu) 1111 1E4 1E15 1E-20 1E35
		ctype blue pl 0 r (qminustau) 1111 1E4 1E15 1E-20 1E35
		ctype green pl 0 r (Qm) 1111 1E4 1E15 1E-20 1E35
		ctype cyan pl 0 r (Qmel) 1111 1E4 1E15 1E-20 1E35
		ctype magenta pl 0 r (Qmmu) 1111 1E4 1E15 1E-20 1E35
		ctype yellow pl 0 r (Qmtau) 1111 1E4 1E15 1E-20 1E35
		ctype default pl 0 r (qminusel) 1111 1E4 1E15 1E-20 1E35
		ctype magenta pl 0 r (Qmphoton) 1111 1E4 1E15 1E-20 1E35
		#ctype magenta pl 0 r (RufQm-Qmphoton) 1111 1E4 1E15 1E-20 1E35
		#
plotqrat 0    #
		#
		# timescale for changing internal energy
		#
		ctype default pl 0 r (utot/qminusel) 1101 1E4 1E15 1E-20 1E35
		ctype red pl 0 r (utot/qminusmu) 1111 1E4 1E15 1E-20 1E35
		ctype blue pl 0 r (utot/qminustau) 1111 1E4 1E15 1E-20 1E35
		ctype green pl 0 r (utot/Qm) 1111 1E4 1E15 1E-20 1E35
		ctype cyan pl 0 r (utot/Qmel) 1111 1E4 1E15 1E-20 1E35
		ctype magenta pl 0 r (utot/Qmmu) 1111 1E4 1E15 1E-20 1E35
		ctype yellow pl 0 r (utot/Qmtau) 1111 1E4 1E15 1E-20 1E35
		ctype default pl 0 r (utot/qminusel) 1111 1E4 1E15 1E-20 1E35
		ctype magenta pl 0 r (utot/Qmphoton) 1111 1E4 1E15 1E-20 1E35
		#ctype magenta pl 0 r (utot/(RufQm-Qmphoton)) 1111 1E4 1E15 1E-20 1E35
		#
                #
plotnminus 0    #
		ctype default pl 0 r (nminusel) 1101 1E4 1E15 1E1 1E35
		ctype red pl 0 r (nminusmu) 1111 1E4 1E15 1E1 1E35
		ctype blue pl 0 r (nminustau) 1111 1E4 1E15 1E1 1E35
		ctype green pl 0 r (Nm) 1111 1E4 1E15 1E1 1E35
		ctype cyan pl 0 r (Nmel) 1111 1E4 1E15 1E1 1E35
		ctype magenta pl 0 r (Nmmu) 1111 1E4 1E15 1E1 1E35
		ctype yellow pl 0 r (Nmtau) 1111 1E4 1E15 1E1 1E35
		ctype default pl 0 r (nminusel) 1111 1E4 1E15 1E1 1E35
		ctype magenta pl 0 r (RufNm) 1111 1E4 1E15 1E1 1E35
                #
plotnumev 0     #
                #
		define x1label "r [cm]"
		define x2label "E [MeV]"
                # energy per unit neutrino in MeV
		set Qnu = (Qm)
                set numev=(Qnu/Nm/ergPmev)
                set numperkbt=Qnu/Nm/(kb*temp)
                ctype default pl 0 r numev 1101 1E4 1E15 1E-4 1E4
                ctype red pl 0 r numperkbt 1111 1E4 1E15 1E-4 1E4
                ctype blue pl 0 r (Enutot/ergPmev) 1111 1E4 1E15 1E-4 1E4
                ctype cyan pl 0 r (Enue/ergPmev) 1111 1E4 1E15 1E-4 1E4
                ctype green pl 0 r (Enuebar/ergPmev) 1111 1E4 1E15 1E-4 1E4
                #
plotqtau 0      #
                #
		set etaeprime=etae-(me*c*c)/(kb*temp)
		set qdotNe=1.1E31*etaeprime**9*(temp/1E11)**9
		set qdotNenondegen=9.2E33*(temp/1E11)**6*(rho/1E10)
		#ctype cyan pl 0 r qdotNe 1110
		#ctype magenta pl 0 r qdotNenondegen 1110
		#
		#
		set T11=temp/1E11
		#set qdotNetot=(qdotNe+qdotNenondegen)
		set qdotNetot=qdotNe
		set mytauabs=qdotNetot*hcm/(1.98d40*T11**4)
		#
		#
		ctype default pl 0 r (qtautelohcm*hcm) 1100
		ctype blue pl 0 r (qtauaelohcm*hcm) 1110
		ctype green pl 0 r (qtautmuohcm*hcm) 1110
		ctype cyan pl 0 r (qtauamuohcm*hcm) 1110
		ctype magenta pl 0 r (qtauttauohcm*hcm) 1110
		ctype yellow pl 0 r (qtauatauohcm*hcm) 1110
		#ctype red pl 0 r (qtausohcm*hcm) 1110
		#ctype red pl 0 r (mytauabs) 1110
		#ctype red pl 0 r (tauphotonohcm*hcm) 1110
		#
plottauafter 0  #
		#
		# note that for full 5D EOS with rho,T,Ye,Ynu,H (standard stellar model case) that H calculation is immediately exactly correct for fixed rho,T,Ye,Ynu.
		# if using Ynuthermal for Ynu, then could evolve
		#
		# tauafter and hcm/lambdatot should agree if hcm is chosen right
		# This will happen if using recomputeH2 and then
		# compute tauafter using recomputetau
		# This means that hcm used is correct global value
		# In HARM, need not iterate each timestep, just every once in a while starting from old H
		#
		#recomputeH2 lambdatot Hofrtau2
		recomputetau
		#
		# ensure that diagnostic stuff agrees with what will compute in HARM
		#
		ctype default pl 0 r (tauafter) 1100
                # below hcm is what was read-in from EOS table, while Hcm is what was computed last
		ctype red pl 0 r (hcm/lambdatot) 1110
		#ctype blue pl 0 r (qtautelohcm*hcm) 1110
		#
                #
		#
plotqdtau 0      #
                #
		ctype default pl 0 r (qtautelohcm) 1100
		ctype blue pl 0 r (qtauaelohcm) 1110
		ctype green pl 0 r (qtautmuohcm) 1110
		ctype cyan pl 0 r (qtauamuohcm) 1110
		ctype magenta pl 0 r (qtauttauohcm) 1110
		ctype yellow pl 0 r (qtauatauohcm) 1110
		#ctype red pl 0 r (qtausohcm) 1110
		#ctype red pl 0 r (tauphotonohcm) 1110
		ctype red pl 0 r (1/lambdatot) 1110
		#
                #
plotntau 0              #
		ctype default pl 0 r (ntautelohcm*hcm) 1100
		ctype blue pl 0 r (ntauaelohcm*hcm) 1110
		ctype green pl 0 r (ntautmuohcm*hcm) 1110
		ctype cyan pl 0 r (ntauamuohcm*hcm) 1110
		ctype magenta pl 0 r (ntauttauohcm*hcm) 1110
		ctype yellow pl 0 r (ntauatauohcm*hcm) 1110
		#ctype red pl 0 r (ntausohcm*hcm) 1110
		#ctype red pl 0 r (mytauabs) 1110
		#
plotdyedt 0     #
		#
		ctype default pl 0 r dyedt 1101 1E5 1E14 1E-15 1E15
		ctype red pl 0 r dyedtthin 1111 1E5 1E14 1E-15 1E15
		set diff=dyedt-dyedtthin
		ctype cyan pl 0 r diff 1111 1E5 1E14 1E-15 1E15
		#
plottauphoton 0 #
                #
		#print {rho temp hcm xnuc etae etaeprime tdynorye abar zbar}
		#
		set mytauphoton1=4E9*ye*rho/1E10*hcm
		set mytauphoton2=4E9*ye*rho/1E10*Hcmphoton
		#
		# check for photon optical depth
		ctype default pl 0 r (tauphotonohcm*hcm) 1100
		ctype cyan pl 0 r (tauphotonabsohcm*hcm) 1110
		ctype blue pl 0 r (mytauphoton1) 1110
		ctype green pl 0 r (mytauphoton2) 1110
		ctype red pl 0 r (1.0+r*0.0) 1110
		# only optically thin in stellar wind component
		#
		#
plotTdiff 0     #
		#
		ctype default pl 0 r Tdifftot 1100
		ctype red pl 0 r Tthermaltot 1110
		ctype green pl 0 r (Tdifftot-Tthermaltot) 1110
		# see if just limited by speed of light
		ctype blue pl 0 r (hcm/c) 1110
                #
                #
checketas 0     #
		#
		#asdfasdf
		set Qmev=1.29
		set tmev=kb*temp/ergPmev
		#set etanueq = etae+etap-etan-Qmev/tmev
		set etanueq = etae+etap-etan
		set etanubareq= - etanueq
		ctype default pl 0 r etae 1101 1E5 1E14 1E-10 1E10
		ctype red pl 0 r etap 1111 1E5 1E14 1E-10 1E10
		ctype blue pl 0 r etan 1111 1E5 1E14 1E-10 1E10
		ctype cyan pl 0 r etanu 1111 1E5 1E14 1E-10 1E10
		ctype yellow pl 0 r etanueq 1111 1E5 1E14 1E-10 1E10
		#
checketasdebug 0     #
		#
		#
		set Qmev=1.29
		set tmev=kb*temp/ergPmev
		#set etanueq = etae+etap-etan-Qmev/tmev
		set etanueq = etae+etap-etan
		set etanubareq= - etanueq
		ctype default pl 0 r etae 1101 1E5 1E14 1E-2 1E3
		ctype red pl 0 r etap 1111 1E5 1E14 1E-2 1E3
		ptype 4 3
		lweight 2
		points (LG(r)) (LG(abs(etap)))
		#
		ctype blue pl 0 r etan 1111 1E5 1E14 1 1E3
		ctype cyan pl 0 r etanu 1111 1E5 1E14 1 1E3
		ctype yellow pl 0 r etanueq 1111 1E5 1E14 1 1E3
		#
                #
checkeosetas 0  #
		#
                set etahat = etap-etan
		#set Qmev=1.29
		#set tmev=kb*temp/ergPmev
                #set etahat = etap-etan-Qmev/tmev
		set etapnbottom = 1.0/(exp(-etahat)-1.0)
		set etanpbottom = 1.0/(exp(etahat)-1.0)
                #
		ctype default pl 0 r etanpbottom 1001 1E5 1E14 -10 10
		ctype red pl 0 r etapnbottom 1011 1E5 1E14 -10 10
                #
                set Ynp = (2.0*ye-1.0)*etanpbottom
                set Ypn = Ynp*exp(etap-etan)
                #
                #
		set Ynp = (2.0*ye-1.0)/(exp(etap-etan)-1.0)
                set Ypn = exp(etap-etan)*Ynp
		#
		# new method
		set yp=ye
		set myyp=(yp>1.0D-3 ? yp : 1.0D-3)
		set Ynp = (2.0d0*myyp-1.0d0)/(1.0d0-myyp)/(exp(etap-etan)-1.0d0)
		set Ypn = (1.0d0-2.0d0*myyp)/(myyp)/(exp(etan-etap)-1.0d0)
		#
		#
                # fix-up
                set Ynp = (Ynp>1.0) ? 1.0 : Ynp
		set Ynp = (Ynp<0.0) ? 0.0 : Ynp
                set Ypn = (Ypn>1.0) ? 1.0 : Ypn
		set Ypn = (Ypn<0.0) ? 0.0 : Ypn
		#
		# below not needed now for new method
		#set Ypn = (Ypn+Ynp>1.0) ? 1.0-Ynp : Ypn
                #
                #
		ctype default pl 0 r Ynp 1000
		ctype red pl 0 r Ypn 1010
		#
                #
                #
checketas2 0    #
		set delta=3.0*ergPmev
		set etanpdiff=etan-etap
		set Qtilde = etanpdiff + delta/(kb*temp)
		#
		ctype cyan pl 0 r etanpdiff  1111 1E5 1E14 1E-10 1E10
		ctype green pl 0 r Qtilde  1111 1E5 1E14 1E-10 1E10
		#
		#set munhat=etan*kb*temp/ergPmev
		#set muphat=etap*kb*temp/ergPmev
		#print {r munhat muphat}
                #
                #
                computeppwf
                ctype default pl 0 r xnuc 1100
                ctype red pl 0 r xnucpwf 1110
                #
		#
checkgraddot 0  #
		#
		ctype default pl 0 r (yetot*rho) 1101 1E5 1E14 1E-15 1E15
                ctype red pl 0 r graddotrhouyenonthermal 1111 1E5 1E14 1E-15 1E15
		ctype blue pl 0 r graddotrhouye 1111 1E5 1E14 1E-15 1E15
		set graddiff=graddotrhouyenonthermal-graddotrhouye
                ctype cyan pl 0 r graddiff 1111 1E5 1E14 1E-15 1E15
		ctype green pl 0 r Rufgraddotrhouye 1111 1E5 1E14 1E-15 1E15
		#
                #
		#
checkenergy 0   #
		#
		#
		set nb = rhob/mb
		set eperbaryon=utot/nb
		set emev=eperbaryon/ergPmev
		#
		ctype default pl 0 r emev 1000
		#
		#
checktaunse 0   #
		#
		# degen NSE
		ctype default pl 0 r taunse 1101 1E5 1E14 1E-10 1E20
		# non-degen NSE (non-degen regime, high temp)
		ctype red pl 0 r taunse2 1111 1E5 1E14 1E-10 1E20
		ctype blue pl 0 r etae 1111  1E5 1E14 1E-10 1E20
		#
		#
		# r= 10**8.186 cm taunse=1sec
		#
		# rhob<10**7.69549 in star
		# temp<10**9.76274 in star
		#
compareheger 0  #
		# dostandard 0
		#
		set rww=r
		set rhoww=rho
		set tempww=tk
		set vrww=vr
		set abarww=abar
		set zbarww=zbar
		set xnucww=xnuc
		set hcmww=hcm
		set yeww=tdynorye
		#
		#
		# dostandard 1
		#
		set rheger=r
		set rhoheger=rho
		set tempheger=tk
		set vrheger=vr
		set abarheger=abar
		set zbarheger=zbar
		set xnucheger=xnuc
		set hcmheger=hcm
		set yeheger=tdynorye
		#
		#
hegwwplots 0    #
		# Heger is slightly less dense in core
		ctype default pl 0 rww rhoww 1101 1E5 1E14 1E-5 1E15
		ctype red pl 0 rheger rhoheger 1111 1E5 1E14 1E-5 1E15
		ctype red vertline (LG(rold[0]))
		#
		# same temp
		ctype default pl 0 rww tempww 1101 1E5 1E14 1E-5 1E15
		ctype red pl 0 rheger tempheger 1111 1E5 1E14 1E-5 1E15
		ctype red vertline (LG(rold[0]))
		#
		# very similar velocities in core
		ctype default pl 0 rww vrww 1101 1E5 1E14 1E-5 1E15
		ctype red pl 0 rheger vrheger 1111 1E5 1E14 1E-5 1E15
		ctype red vertline (LG(rold[0]))
		#
		# slightly lower abar but small difference (58 vs. 62)
		ctype default pl 0 rww abarww 1101 1E5 1E14 1E-1 1E3
		ctype red pl 0 rheger abarheger 1111 1E5 1E14 1E-1 1E3
		ctype red vertline (LG(rold[0]))
		#
		# very similar zbar
		ctype default pl 0 rww zbarww 1101 1E5 1E14 1E-1 1E3
		ctype red pl 0 rheger zbarheger 1111 1E5 1E14 1E-1 1E3
		ctype red vertline (LG(rold[0]))
		#
		# Heger has fewer free nucleons in core
		ctype default pl 0 rww xnucww 1101 1E5 1E14 1E-6 1E3
		ctype red pl 0 rheger xnucheger 1111 1E5 1E14 1E-6 1E3
		ctype red vertline (LG(rold[0]))
		#
		# Heger is slightly thinner
		ctype default pl 0 rww hcmww 1101 1E5 1E14 1E-6 1E12
		ctype red pl 0 rheger hcmheger 1111 1E5 1E14 1E-6 1E12
		ctype red vertline (LG(rold[0]))
		#
		# Heger has slightly higher Ye
		ctype default pl 0 rww yeww 1101 1E5 1E14 1E-2 1
		ctype red pl 0 rheger yeheger 1111 1E5 1E14 1E-2 1
		ctype red vertline (LG(rold[0]))
		#
		#
		#
nbarcheck 0     #
		#
		#
		set nbar = (abar-zbar)
		set nheav = aheav - zheav
		#
		ctype default pl 0 r nbar  1100
		ctype red pl 0 r nheav 1110
		#
		# WW95:
		# print {abar zbar nbar aheav zheav nheav}
		# 61.55       26.44       35.12       70.37       30.24       40.14
		#
		# Heger:
		# sm: print {abar zbar nbar aheav zheav nheav}
		# 57.44       25.55       31.89       67.31       29.91        37.4
		#
		#
checkrot 0      #
		#
		set lspec = r**2*omega
		#
		#
		set Rhecgs=2.11E8
		set rotcoef=0.05
		set lspeclimit=1E17
		set th = pi*0.5
		set Mcgs = Mvsr*msun
		# 
		#
		#if(r<Rhe){ // Inner radius of Helium envelope
		#
		set omegak=sqrt(G*Mcgs/(Rhecgs)**(3.0))
		set omega0=sqrt(rotcoef)*omegak
		#
		set lspecific=(Rhecgs*sin(th))**(2.0)*omega0
		set llimit=lspeclimit
		set lspecific1 = (lspecific>llimit) ? llimit : lspecific
		#
		#else
		set lspecific=(r*sin(th))**(2.0)*omega0
		set llimit=lspeclimit
		set lspecific2 = (lspecific>llimit) ? llimit : lspecific
		#
		#
		#
		set lspecmwf99 = (r<Rhecgs) ? lspecific1 : lspecific2
		#
		#
		ctype default pl 0 r lspec 1101 1E5 1E14 1E15 1E18
		ctype red pl 0 r lspecmwf99 1111 1E5 1E14 1E15 1E18
		#
		#
jbhfromstar 0   #
		set lspec = r**2*omega
		set Mcgs = Mvsr*msun
		#
		set MBH=3.0*msun
		set Lu = G*MBH/c**2
		set Tu = Lu/c
		set jbhtest = lspec/(Lu**2/Tu)
		#
		set MBH=1.7*msun
		set Lu = G*MBH/c**2
		set Tu = Lu/c
		set jbhtest2 = lspec/(Lu**2/Tu)
		#
		#
		der r Mcgs dr dMcgsdr
		set dJdr = dMcgsdr*lspec
		integrate r dJdr rint Jvsr
		set jbhcum = Jvsr/(Mcgs**2*G/c)
		#
		#
		ctype default pl 0 r jbhcum 1101 1E5 1E14 1E-5 1E2
		ctype blue pl 0 r jbhtest 1111 1E5 1E14 1E-5 1E2
		ctype green pl 0 r jbhtest2 1111 1E5 1E14 1E-5 1E2
		#
		ctype red vertline (LG(Rhecgs))
		#
		#
jbh2 0          #
		#
		#
		ctype default pl 0 rint Jvsr 1100
		set bottom=(Mcgs*G/c)
		set bottom2=(Mcgs**2*G/c)
		ctype red pl 0 rint bottom2 1110
		#
		#
Yecheck 0       #
		define x1label "r[cm]"
		define x2label "Y_e Ynuthermal Y_L"
		#ctype default pl 0 r tdynorye 1101 1E4 1E15 1E-2 1E1
		ctype default pl 0 r ye 1101 1E4 1E15 1E-2 1E1
		ctype red pl 0 r Ynuthermal 1111 1E4 1E15 1E-2 1E1
		#ctype cyan pl 0 r (tdynorye+Ynu) 1111 1E5 1E15 1E-2 1E1
		ctype cyan pl 0 r (ye+Ynu) 1111 1E5 1E15 1E-2 1E1
		#
Ynuratcheck 0   #	
		ctype default pl 0 r (Ynu/Ynuthermal) 1101 1E5 1E15 1E-2 1E2
		#
		#
		#
checkpressures 0 #
		#
		#
		ctype default pl 0 r utot 1100
		ctype red pl 0 r utottest 1110
		#
		set shift=9.14*ergPmev/2
		set nb=rho/mb
		set ne=ye*nb
		set ureste=ne*(me*c**2)
		set utotshifttest=(utot/nb+shift)*nb-ureste
		#
		ctype blue pl 0 r utotshifttest 1110
		#
		#
		#
		# print {utot utottest utotshifttest}
		#
		#
		#
checkbind 0     #
		#OLD:
		#
		#
		http://hyperphysics.phy-astr.gsu.edu/hbase/nucene/nucbin.html#c2
		#
		#
		setAs
		#
		set A=56
		set Z=26
		set N=A-Z
		set Atrue=AFe56
		print {A Z N Atrue}
		#
		set freemass=(mn*N+mp*Z)*c**2/ergPmev
		set boundmass=Atrue*mb*c**2/ergPmev
		set bindmev=freemass-boundmass
		set bindmevperpart=bindmev/A
		#
		print {freemass boundmass bindmev bindmevperpart}
		#
		#set alphabindmev=28.3
		#set alphabindmevperpart=alphabindmev/4
		#
		set A=4
		set Z=2
		set N=A-Z
		set Atrue=AHe
		print {A Z N Atrue}
		#
		set freemass=(mn*N+mp*Z)*c**2/ergPmev
		set boundmass=Atrue*mb*c**2/ergPmev
		set bindmev=freemass-boundmass
		set bindmevperpart=bindmev/A
		#
		print {freemass boundmass bindmev bindmevperpart}
		#
		#
		#
		#
		#
compareubind 0  # Check energy per baryons
		#
		define x2label "MeV/baryon"
		define x1label "r [cm]"
		#
		set mnmev=mn*c**2/ergPmev
 		set mpmev=mp*c**2/ergPmev
		set mbmev=mb*c**2/ergPmev
		set mMmev=938.0
		set mbkazmev=(mn+mp)*0.5*c**2/ergPmev
		set memev=me*c**2/ergPmev
		#
		set Q1=(mnmev-mpmev)
		set Q2=(mnmev-mbmev)
		set Q3=(mpmev-mbmev)
		set Q4=(mbmev-mMmev)
		set Q5=(mbmev-mbkazmev)
		set Q6=(mnmev-mbkazmev)
		#
		print {Q1 Q2 Q3 Q4 Q5 Q6}
		print {mnmev mpmev mbmev mMmev mbkazmev memev}
		#
		#
		set nb=rho/mb
		set u_N=(rho_N-rhob*c**2)
		set umev1=(utottest/nb/ergPmev)
		set umev2=(utotnew/nb/ergPmev)
		set umev3=(ucou/nb/ergPmev)
		set umev4=(rho_photon/nb/ergPmev)
		set umev5=(rho_eleposi/nb/ergPmev)
		set umev6=(u_N/nb/ergPmev)
		#set umev6=(didconverge==1 ? u_N/nb/ergPmev+Q1*2 : u_N/nb/ergPmev)
		#set umev6=(didconverge==1 ? u_N/nb/ergPmev : u_N/nb/ergPmev-Q1*2)
		#set umev6=(didconverge==1 ? u_N/nb/ergPmev : u_N/nb/ergPmev-2.304)
		set umev7=(rho_nu/nb/ergPmev)
		set umev8=(upwfsimple/nb/ergPmev)
		set umev9=(1.5*kb*T/ergPmev/abar)
		#
		#
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype default pl 0 r umev1 1101 1E5 1E14 1E-5 1E5
		ctype red pl 0 r umev2 1111 1E5 1E14 1E-5 1E5
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#ctype green pl 0 r umev3 1111 1E5 1E14 1E-5 1E5
		ctype blue pl 0 r umev4 1111 1E5 1E14 1E-5 1E5
		ctype magenta pl 0 r umev5 1111 1E5 1E14 1E-5 1E5
		ctype cyan pl 0 r umev6 1111 1E5 1E14 1E-5 1E5
		ctype yellow pl 0 r umev7 1111 1E5 1E14 1E-5 1E5
		define PLOTLWEIGHT ($PLOTLWEIGHT+3)
		define NORMLWEIGHT ($NORMLWEIGHT+3)
		ctype yellow pl 0 r umev8 1111 1E5 1E14 1E-5 1E5
		define PLOTLWEIGHT ($PLOTLWEIGHT-3)
		define NORMLWEIGHT ($NORMLWEIGHT-3)
		#
		#
		#  print {umev1 umev2 umev3 umev4 umev5 umev6 umev7 umev8 umev9} 
		#
restmassfix 0   #
		#
		set deltafixnut=(0/1*(mp-mn)+mn-mb)*c**2/ergPmev
		set deltafixprot=(1/1*(mp-mn)+mn-mb)*c**2/ergPmev
		set deltafixalpha=(2/4*(mp-mn)+mn-mb)*c**2/ergPmev
		set deltafixheav=(zheav/aheav*(mp-mn)+mn-mb)*c**2/ergPmev
		set totaldeltafix=deltafixnut+deltafixprot+deltafixalpha+deltafixheav
		#print {totaldeltafix}
		print {deltafixnut deltafixprot deltafixalpha}
		#
		#
		define x1label "r[cm]"
		define x2label "Energy fix per baryon [MeV]"
		#
		pl 0 r totaldeltafix 1000
		#
		#
		#
		
