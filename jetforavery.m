		#
		#
linkage 0       #
		#
		plc 0 aphi 001 Rin 300 0 pi
		#
		set dirlink=(-B3*sqrt(gv333))/(B1*sqrt(gv311))/(r*sin(h)*uu3*sqrt(gv333))
		plc0 0 dirlink 011 Rin 300 0 pi
		#
                #
mdotvst 2       # mdotvst 0 66
		#
		set startanim=$1
		set endanim=$2
		#
		set mdotvstime=0,endanim-startanim,1
		set mdotvstime=mdotvstime*0
		set mdottime=mdotvstime*0
		#
		#
		do ii=startanim,endanim,$ANIMSKIP {
                  set h1='dump'
                  set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  #
		  #jrdpcf3du $filename
		  #jrdpheader3dold dumps/$filename
		  #
		  jrdpheader3dold dumps/$filename
		  jrdpcf3dudipole $filename
		  #
                  #
		  echo $ii
		  set mdottime[$ii]=_t
		  set god=gdet*$dx1*$dx2*$dx3*rho*uu1 if(ti==0)
		  set mdotvstime[$ii]=SUM(god)
		  #
		  #
		}
		#
		# output results to file
		#
		print mdotvstime$1$2.txt '%21.15g %21.15g\n' {mdottime mdotvstime}
                #
                #
bounded 0       #
		set bunbound=-1-ud0
		set hspec=(rho+u+p)/rho
		set tbunbound=-1-hspec*ud0
		stresscalc 1
		set mtbunbound=(-1-Tud10/(rho*uu1))
		#
		#
		plc0 0 bunbound
		#
		plc0 0 tbunbound 010
		#
		plc0 0 mtbunbound 010
		#
		#
		set god=(bunbound>0 && tbunbound>0 && mtbunbound>0 ? 1 : 0)
		set myB3=(sqrt(gv333)*B3*god)
		#
		faraday
		set myomegaf2=omegaf2*god
		#
		set myud3=ud3*god
		#
		plc0 0 myB3
		#
		#
		#######################
		#
                #/u/ki/jmckinne/nfsslac/lonestar.runs/runlocaldipole3dfiducial
		#
do55 0          #
		getdump
		processdump
		computenumberdensity
		outputdump $filename _t
		#
getdump 0       # jre jetforavery.m
		#
		!head -2 dumps/dump0050 | tail -1 | wc
                #
                set h1='dump'
                set h2=sprintf('%04d',55) set _fname=h1+h2
                define filename (_fname)
		#
		jrdpheader3dold dumps/dump0055
		jrdpcf3dudipole dump0055
                jrdpdissdipole dissdump0055
		#
                jrdpdissdipole dissdump0010
		set diss9superpast=(diss9>0 ? diss9 : 0)
                jrdpdissdipole dissdump0054
		set diss9past=(diss9>0 ? diss9 : 0)
                jrdpdissdipole dissdump0055
		set diss9now=(diss9>0 ? diss9 : 0)
		#
		set diss9diff=diss9now-diss9past
		set diss9superdiff=diss9now-diss9superpast
		#
		grid3d gdump
		jrdpheader3dold dumps/dump0055
		#
getmanydumps 0  #
		set startanim=0
		set endanim=66
		#
		do ii=startanim,endanim,$ANIMSKIP {
                  set h1='dump'
                  set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  if($ii>0){\
		   set h2=sprintf('%04d',$ii-1) set _fname=h1+h2
                   define filenameold1 (_fname)
		  }
		  if($ii>10){\
		         set h2=sprintf('%04d',10) set _fname=h1+h2
                   define filenameold2 (_fname)
		  }
		  #
		  if($ii<=0){ define filenameold1 $filename }
		  if($ii<=10){ define filenameold2 $filename }
		  #
		  #
		  #jrdpcf3du $filename
		  #jrdpheader3dold dumps/$filename
		  #
		  jrdpheader3dold dumps/$filename
		  jrdpcf3dudipole $filename
		  jrdpdissdipole diss$filename
		  set diss9now=(diss9>0 ? diss9 : 0)
		  #
		  jrdpdissdipole diss$filenameold1
		  set diss9past=(diss9>0 ? diss9 : 0)
		  #
		  jrdpdissdipole diss$filenameold2
		  set diss9superpast=(diss9>0 ? diss9 : 0)
		  #
		  set diss9diff=diss9now-diss9past
		  set diss9superdiff=diss9now-diss9superpast
		  #
		  processdump
                  #
		  computenumberdensity
                  #
		  outputdump $filename _t
		  #
		}
		#
processdump 0   #
		##############
		# KSP -> KS
		#
		set uu0ks=uu0*dxdxp00
		set uu1ks=uu1*dxdxp11+uu2*dxdxp12
		set uu2ks=uu1*dxdxp21+uu2*dxdxp22
		set uu3ks=uu3*dxdxp33
		#
		# inverse of dx^{ks}/dx^{mks}
		set idxdxp00=1/dxdxp00
		set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp33=1/dxdxp33
		#
		set ud0ks=ud0*idxdxp00
		set ud1ks=ud1*idxdxp11+ud2*idxdxp21
		set ud2ks=ud1*idxdxp12+ud2*idxdxp22
		set ud3ks=ud3*idxdxp33
		#
		##############
		##############
		# KSP -> KS
		#
		set bu0ks=bu0*dxdxp00
		set bu1ks=bu1*dxdxp11+bu2*dxdxp12
		set bu2ks=bu1*dxdxp21+bu2*dxdxp22
		set bu3ks=bu3*dxdxp33
		#
		# inverse of dx^{ks}/dx^{mks}
		set idxdxp00=1/dxdxp00
		set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
		set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		set idxdxp33=1/dxdxp33
		#
		set bd0ks=bd0*idxdxp00
		set bd1ks=bd1*idxdxp11+bd2*idxdxp21
		set bd2ks=bd1*idxdxp12+bd2*idxdxp22
		set bd3ks=bd3*idxdxp33
		#
		##############
		# KS -> BL
		#
		set Sigma=r**2+(a*cos(h))**2
		set Delta=r**2-2*r+a**2
		set gdetbl=Sigma*sin(h)
		#
		set geofactbl=Delta*sin(h)**2
		#
		#
		#
		set uu0bl=uu0ks-2*r/Delta*uu1ks
		set uu1bl=uu1ks
		set uu2bl=uu2ks
		set uu3bl=-a/Delta*uu1ks+uu3ks
		#
		set vu1bl=uu1bl/uu0bl
		set vu2bl=uu2bl/uu0bl
		set vu3bl=uu3bl/uu0bl
		#
		set ud0bl=ud0ks
		set ud1bl=(2*r*ud0ks+Delta*ud1ks+a*ud3ks)/Delta
		set ud2bl=ud2ks
		set ud3bl=ud3ks
		#
		##############
		# KS -> BL
		#
		set Sigma=r**2+(a*cos(h))**2
		set Delta=r**2-2*r+a**2
		set gdetbl=Sigma*sin(h)
		#
		set geofactbl=Delta*sin(h)**2
		#
		#
		#
		set bu0bl=bu0ks-2*r/Delta*bu1ks
		set bu1bl=bu1ks
		set bu2bl=bu2ks
		set bu3bl=-a/Delta*bu1ks+bu3ks
		#
		set vu1bl=bu1bl/bu0bl
		set vu2bl=bu2bl/bu0bl
		set vu3bl=bu3bl/bu0bl
		#
		set bd0bl=bd0ks
		set bd1bl=(2*r*bd0ks+Delta*bd1ks+a*bd3ks)/Delta
		set bd2bl=bd2ks
		set bd3bl=bd3ks
		#
		#
		#
computenumberdensity 0 #
		#
		# erg K^{-1} g^{-1}
		set kb=1.3807*10**(-16)
		set mp=1.67262E-24
		set me=9.11E-28
		set C=2.99792458E10
		set hbar=1.0545716293001394e-27
		set mion=mp
		set mb=1.660540186674939e-24
		#
		#set thetaion=p/(rho)
		#set Tion=thetaion*(mion*C**2/kb)
		#set Tele=me/mp*Tion
		#
		# just p=(\gamma-1)u
		#set ndenrad = (1.80309)*(u/5.6822)/(kb*T)
		# P = \rho_b (k_b/m_b) T
		#
		set Tpart = p/rho*mb/kb
		set ndenpart=(rho/mb*me)
		#
		set Trad = (u*(2*pi*hbar**3*C**3/(kb**4*5.6822)))**(1/4)
		set ndenrad = (kb**3*Trad**3)/(2*pi**2*hbar**3*C**3*1.80309)
		#
		set cut=2/(1 + exp(rho/(bsq/2)))
                #
		############################
		# Jon original shock stuff
		############################
                #
                set lptot=lg(ptot)
		dercalc 0 lptot dlptot
		#dercalc 0 p dp
                #dercalc 0 bsq dbsq
		# old way:
		#set mydptot=(dlptotx*$dx1+dlptoty*$dx2+dlptotz*$dx3)/3.0
		# new way:
		set mydpoptot1=abs(dlptotx*$dx1)
		set mydpoptot2=abs(dlptoty*$dx2)
		set mydpoptot3=abs(dlptotz*$dx3)
		set mydpoptot=(mydpoptot1>mydpoptot2 ? mydpoptot1 : mydpoptot2)
		set mydpoptot=(mydpoptot>mydpoptot3 ? mydpoptot : mydpoptot3)
		#
		set guu1=rho*gdet*uu1
		set guu2=rho*gdet*uu2
                set guu3=rho*gdet*uu3
		dercalc 0 guu1 dguu1
		dercalc 0 guu2 dguu2
		dercalc 0 guu3 dguu3
		set divv=dguu1x+dguu2y+dguu3z
		set shockind1=(divv<0) ? 1 : 0
		#
		set gammamin=1
		set coefmax=1.0
		#set absdpoptot=0.5*abs(mydbsq/bsq + (dpx+dpy+dpz)/p)
		#set absdpoptot=0.5*abs(mydpoptot/ptot)
		set absdpoptot=abs(mydpoptot)
                #*(3*p-2)/(2*p-1)
                set thetaion=p/rho
		set absdpoptot2=absdpoptot*thetaion*mion/me/gammamin
		set coef=(shockind1<0.5) ? 0 : absdpoptot2
		#set coef=absdpoptot2
		#set coef=(coef>coefmax) ? coefmax : coef
		#
                #
		############################
		# PPM shock stuff
		############################
		#
		# don't use 0.75 since only then would find strong shocks
		#
		ficalc 0.2
		#
		set ficalc=(ficalc1>ficalc2 ? ficalc1 : ficalc2)
		set ficalc=(ficalc>ficalc3 ? ficalc : ficalc3)
		#
		#
                #
                set truediss1=(diss9past>0 ? diss9past : 0)
                set truediss2=(diss9now>0 ? diss9now : 0)
                set truediss3=(diss9diff>0 ? diss9diff : 0)
		set truediss4=(diss9superdiff>0 ? diss9superdiff : 0)
		#
		#
		####### versions of number density of non-thermal electrons
                #set nden1 = truediss1
                #set nden2 = truediss2
                #set nden3 = truediss3
                #set nden4 = truediss4
		#
		#
		#
		#
		#
outputdump 2    # outputdump $filename _t
		#
		##############
		# Print out Avery's desired quantities
		#
		define print_noheader (0)
		define mydump $1
		define mytime ($2)
		#
                #*sqrt(4.0*pi)
                # Obtain field strength in Gaussian units
		set bu0blG=bu0bl*sqrt(4.0*pi)
		set bu1blG=bu1bl*sqrt(4.0*pi)
		set bu2blG=bu2bl*sqrt(4.0*pi)
		set bu3blG=bu3bl*sqrt(4.0*pi)
		#
		#
		#
		######################
		# old:
		#print averydata_dipole_$!!mydump.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		#    {r h ph rho u nden1 nden2 nden3 nden4 nden5 nden6 nden7 uu0bl uu1bl uu2bl uu3bl bu0blG bu1blG bu2blG bu3blG}
		#
		######################
		# new:
		#print averydata_dipole_$!!mydump.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		#    {r h ph rho u cut absdpoptot shockind1 ficalc1 ficalc2 ficalc3 ficalc truediss1 truediss2 truediss3 truediss4 uu0bl uu1bl uu2bl uu3bl bu0blG bu1blG bu2blG bu3blG}
		#
		######################
		# new2:
		print averydata_dipole_$!!mydump.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {r h ph rho u uu0bl uu1bl uu2bl uu3bl bu0blG bu1blG bu2blG bu3blG cut absdpoptot shockind1 ficalc1 ficalc2 ficalc3 ficalc truediss1 truediss2 truediss3 truediss4}
		#
                #
		#
		#
		#
		#
plotjetfeatures 0 #		  
		#
		# gogrmhd
		# jre blandford.m
		# jet jetforavery.m
		#
		# on ki-rh42:
		# cd /data/jon/orange3d/
		# scp breakdump.sh jmckinne@ki-rh39:/u/ki/jmckinne/nfsslac/lonestar.runs/runlocaldipole3dfiducial/
		#
		################
		# get HARM data file
		#
		jrdpheader3dold dumps/dump0055
		jrdpcf3du dump0055
		#
		#
		############################
		# interpolate
		#
		interpaverysingle 0055 lrho
		interpaverysingle 0055 lbrel
		interpaverysingle 0055 ud0
		#
		#
		##################
		# read-in results
		#
		#jrdp3d1ci
		#readinterp3d
		#
		jrdp3d1ci idumpsingle0055_lrho ilrho
		jrdp3d1ci idumpsingle0055_lbrel ilbrel
		jrdp3d1ci idumpsingle0055_ud0 iud0
                #
		#
		###################
		# plot results
		#
		# for WHICHPLANE==3:
		define LOGTYPE 0
		define coord 1
		# plane 3 and 1
		define PLANE 1
		define WHICHLEV ($nz/2)
		#
		#
		define x1label "R"
                define x2label "z"
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 ilrho
		#
		define POSCONTCOLOR blue
		define NEGCONTCOLOR cyan
		set var=(LG(1E-1 + 10**ilbrel))
		plc 0 var 010
		#
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR yellow
		plc 0 iud0 010
		#
		#
		# can animage 3D result:
		#agzplc 0 ilrho
		#
		#
		#
interpaverysingle 2   #
		#
		# interpaverysingle 0055 lrho 
		#
		# GODMARK: might consider just breaking up file directly, but have to read into SM anyways so probably ok
		#
		set _whichdump=0
		set _whichdumpversion=0
		set _numcolumns=0
		#
		set todump=$2
		#
		define dumpsingle "dumpsingle$!!1_$!!2"
		#
		define print_noheader (1)
                # must keep header in line with code's expectation
		print "dumps/$!!dumpsingle" {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a \
		       _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH _is _ie _js _je _ks _ke _whichdump _whichdumpversion _numcolumns}
		#
                print + "dumps/$!!dumpsingle" '%21.15g\n' {todump}
		#
                #
		#
		#
		define idumpsdir "idumps/"
		#
		!mkdir $idumpsdir
		#
		#
		# from vis5dpremake:
		#
		define inx 128
                define iny 128
                define inz 128
		#
		set myRout=950.0
                define ixmin (-myRout)
                define ixmax (myRout)
                define iymin (-myRout)
                define iymax (myRout)
                define izmin (-myRout)
                define izmax (myRout)
		#
		define iinx ($inx)
                define iiny ($inz)
                define iinz ($iny)
                #
                define iixmin ($ixmin)
                define iixmax ($ixmax)
                define iiymin ($izmin)
                define iiymax ($izmax)
                define iizmin ($iymin)
                define iizmax ($iymax)
		#
		#
		# from vis5dmakepart2:
		#
		define filein "dumps/$!!dumpsingle"
		define fileout "idumps/i$!!dumpsingle"
		#
		# bi-linear (works for 3D and very fast)
                define interptype (1)
		define refinement (1.0)
		define iRin (_Rin)
                define iRout (_Rout)
                define ihslope (_hslope)
                define idt (_dt)
                define iR0 (_R0)
		#
		define READHEADERDATA 1
                define WRITEHEADERDATA 1
                #
                define WRITEHEADER 0
                define igrid (0)
                #
                define idefcoord (_defcoord)
                define oldgrid (1)
                define doing3d ($nz>1)
                define doing2d (!$doing3d)
		#
		#
		define DATATYPE 1
                # want extrapolation so smoothly connects at outer edges
                # GODMARK: sets to 0 otherwise, and should really choose (maybe) min for scalars and 0 for vectors
                define program "iinterp.rh39"
                define EXTRAPOLATE 0
		#define DEFAULTVALUETYPE 4
		define DEFAULTVALUETYPE 1
		#
		define dofull2pi 1
		#
		echo ~/bin/$program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
                    $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    $iinx $iiny $iinz  $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
                    $iRin $iRout $iR0 $ihslope  $idefcoord $dofull2pi $EXTRAPOLATE $DEFAULTVALUETYPE
		#
		#
		#
		!source /u/ki/jmckinne/intel/mkl/10.0.3.020/tools/environment/mklvarsem64t.sh
		#
		!~/bin/$program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
                    $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    $iinx $iiny $iinz  $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
                    $iRin $iRout $iR0 $ihslope  $idefcoord $dofull2pi $EXTRAPOLATE $DEFAULTVALUETYPE < $filein > $fileout
                #
		#
othercrap 0     #
		#
		#
		#
