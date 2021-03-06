		#
gogrb 0         #
		#
                #gogrmhd
                echo "Load phivsr.m"
		jre phivsr.m
                echo "Load grbmodel.m"
		jre grbmodel.m
                echo "Load kaz.m"
		jre kaz.m
                echo "Load kazpostmatlab.m"
		jre kazpostmatlab.m
                echo "Load Done"
                #
		#
		#
		#
rdselfgrav 0   #
		# assume read dump in first
		define mynx ($nx)
		doallread
		#
rdselfgravcut 0   #
		# assume read dump in first
		# normal file has boundary cells, then fix this since no boundary cells ever
		define mynx ($nx-3*2)
		doallread
		#
doallread 0     #
		rdvsr selfgravvsr0.out $mynx rvsr
		rdvsr selfgravvsr1.out $mynx Mvsr
		rdvsr selfgravvsr2.out $mynx Mtotvsr
		rdvsr selfgravvsr3.out $mynx phivsr
		rdvsr selfgravvsr4.out $mynx phitotvsr
		rdvsr selfgravvsr5.out $mynx dTrrvsr
		rdvsr selfgravvsr6.out $mynx dVvsr
		rdvsr selfgravvsr7.out $mynx vrsqvsr
		rdvsr selfgravvsr8.out $mynx Jvsr
		#
		set gammavsr=1.0/(1-2.0*Mvsr/rvsr)
		#
		#
checkrho 0      # for Avery test
		ltype 0 ctype default pl 0 r (8+rho*0) 0101 Rin Rout 1E-1 1E3
		ltype 0 ctype red pl 0 r (rho/1E-11) 0111 Rin Rout 1E-1 1E3
		#agpl 'dump' r (rho/1E-11) 0101 Rin Rout 1E-1 1E3
		#
		# agpl 'dump' r lrho 0001 $rhor Rout -22 0
		#
checkphi 0      #
		rdselfgrav
		set rho0=1E-11
		set myphi=phivsr if(tj==0)
		set myM=Mvsr if(tj==0)
		set myr=rvsr if(tj==0)
		set phitheory=-2*pi/3*myr**2*rho0
		set Mtheory = 4*pi/3*myr**3*rho0
		set mygam=1/(1-2.0*myM/myr)
		#
		#
checkplphi 0    #
		set phirat=myphi/phitheory
		pl 0 myr phirat 1000
		points (LG(myr)) phirat
		#
checkplphi2 0   #
		ctype default
		pl 0 myr myphi 1000
		ctype red
		pl 0 myr phitheory 1010
		#
		#
checkplM 0    #
		set Mrat=myM/Mtheory
		pl 0 myr Mrat 1000
		points (LG(myr)) Mrat
		#
		#
rdvsr 3         # Reads-in F(r,t) data
		# First read-in dump
		#
		# rdphivsr phivsr.out 1280
		# plc 0 phivsr
		#
		#jrdp dump0000
		#jrdp2d dump0000
		set oldti=ti
		set oldtj=tj
		set oldx12=x12
		set oldx22=x22
		da $1
		lines 1 200000000
		define outbound ($2+2)
		read {t 1 nstep 2 $!!3 3-$!!outbound}
		define nx ($2)
		define ny (dimen($3)/$2)
		set i=$3
		set i=0,$nx*$ny-1
                 set ti = i%$nx
                 set tj = int(i/$nx)
		 set tk=(i+1)/(i+1)-1
		 set i=ti
		 set j=tj
		 set k=tk
		 define nz 1
		 #
		 if(0){\
		  echo "Pre-GOD"
		  # below takes a long time if $ny is big, so avoid for now (only useful for pls)
		  set god0=oldx12 if(oldtj==0)
		  set god=god0
		  do kk=0,$ny-2,1{\
		   set god = god CONCAT god0
                  }
		  echo "Post-GOD"
		  #
		  #
		  set x12=god
		}\
		      else{\
		         set x12 = ti
		}
		
		     set x1=x12
		     set dx1=1,$nx*$ny,1
		     set dx1=dx1/dx1
		     set dx12=dx1
		     #
		     set x22=tj
		     set x2=x22
                     set dx2=dx1
		     set dx22=dx2
		     #
		     set x3=x1*0
		     set x32=x3
		     set dx3=dx1*0
		     set dx32=dx3
		     #
                     define Sx (Rin)
                     define Sy (t[0])
                     define Sz (1)
                     define dx (1)
                     define dy (1)
                     define dz (1)
		     define Lx (Rout-Rin)
                     define Ly (t[$ny-1]-t[0])
                     define Lz (1)
                     define ncpux1 1
		     define ncpux2 1
		     define ncpux3 1
		     define interp (0)
                     define coord (1)
	             define x1label "r c^2/GM"
	             define x2label "t c^3/GM"
		     define coord 1
pickmap 3      #
		set timepre=t if($1==nstep)
		define time (timepre[0])
		set steppre=nstep if(($1==nstep))
		define nstep (steppre[0])
		set $3=$2 if(nstep==$1)
		#
dopow1 0 #
		jrdpener 500 2000
		der t u1src td u1srcd
		#fftreal 1 td u1srcd freq pow
		fftreallim 1 td u1srcd freq pow 360 849
		set rfreq=freq if(freq>0)
		set rpow=pow if(freq>0)
		#
		#
		device postencap powcompare.eps
		#
		define x1label "\\nu GM/c^3"
		define x2label "Power"
		ctype default pl 0 rfreq rpow 1101 8E-4 2E-1 1E-14 1E-8
		#
		#
		da powvsnu.txt
		lines 1 100000
		read {rfreq2 1 rpow2 2}
		ctype red pl 0 rfreq2 rpow2 1110
		#
		#
		device X11
		!scp powcompare.eps jon@relativity:/home/jondata/
		#
		#
		#
interp 0 #
		# sh mkfliinterp.sh 1280 128 256 512 1.398 40 0 40 40 .1411 0 0 0 i1
phivsravg 2     #
		# 
		# jrdp dump0020
		# rdphivsr phivsr.out 1280
		#
		# lumavg.eps
		#
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
		dercalc 0 phivsr phivsrd
		#
		define x1label "r c^2/GM"
		define x2label "Luminosity Average"
		#
		set startny=$1
		set endny=$2
		#
		set lumavg=0,$nx-1,1
		set lumavg=0*lumavg
		#
		# over each time after steady state
 		do iii=startny,endny,1 {\
		       #
		       set lumnow=phivsrdy if(tj==$iii)
		       set lumavg=lumavg+lumnow
		}
		#
		set lumavg=lumavg/(endny-startny+1)
		#
		set myr=x12 if(tj==0)
		fdraft
		#
		define newgx1 ($($gx1 + 500))
		LOCATION 5000 $gx2 $gy1 $gy2
		#ctype default pl 0 myr lumavg 1001 Rin Rout -1E-7 3E-6
		#set god=lumavg*0
		#ctype red pl 0 myr god 1010
		#
		ctype default pl 0 myr lumavg 1101 Rin Rout 1E-9 1E-5
		#
reallumvstvsr 0 #
		#
		# jrdp2d dump0000
		# rdphivsr phivsr.out 2048
		#
		# lumavg.eps
		#
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
		#
		set lumintvsrvst=phivsr
		#
		#do iii=0,$nx*$ny-1,1 {\
		    do jjj=0,$ny-1,1{\
		    do iii=0,$nx-1,1{\
		       #
		       #set myiii=INT($iii)
		       #set indexi=INT((myiii)%$nx)
		       #set indexj=INT(((myiii)%($nx*$ny))/$nx)
		       #set indexi=(myiii)%$nx
		       #set indexj=INT(((myiii)%($nx*$ny))/$nx)
		       #
		       #if(indexi==0){ echo $(indexi[0]) $(indexj[0]) $(myiii[0]) }
		       #
		       #if(indexi!=0){\
		           #set lumintvsrvst[indexi+indexj*$nx]=lumintvsrvst[(indexi-1)+indexj*$nx]+phivsr[indexi+indexj*$nx]
		           #}
		           #
		           if($iii==0){ echo $iii $jjj }
		           #
		           if($iii!=0){\
		                  set lumintvsrvst[$iii+$jjj*$nx]=lumintvsrvst[($iii-1)+$jjj*$nx]+phivsr[$iii+$jjj*$nx]
		                  }
		 }
		}
		#
		#
		dercalc 0 lumintvsrvst lumintvsrvstd
		dercalc 0 lumintvsrvstdx lumintvsrvstdxd
		#
		plc 0 lumintvsrvstdxdy
		#
		# final result is either mixed form such that it's d/dt d/dr (time integrated and radially integrated luminosity (r,t))
		#
		#
		#
realphivsr 0    # take proper sum
		#
		set lumint=lumavg*0
		#
 		do iii=0,$nx-1,1 {\
		       #
		       do iiii=0,$iii,1 {\
		              #echo $iii $iiii
		        set lumint[$iii]=lumint[$iii]+lumavg[$iiii]
		    }
		}
		#
		der myr lumint dmyr realphivsr
		#
		#
doalllumavg 0   # for niayesh
		jrdp2d dump0000
		rdphivsr phivsr.out 2048
		phivsravg 500 750
		realphivsr
		#
		device postencap lumavg.eps
		define x1label "r c^2/GM"
		define x2label "Luminosity Average"
		ctype default pl 0 myr realphivsr 1101 Rin Rout 1E-8 1E-3
		device X11
		#
		#
		device postencap lumint.eps
		define x1label "r c^2/GM"
		define x2label "Integral Luminosity"
		ctype default pl 0 myr lumint 1101 Rin Rout 1E-9 1E-2
		device X11
		#
		print lum_r_avg_int.dat {myr realphivsr lumint}
		#
		# !scp lumavg.eps lumint.eps  lum_r_avg_int.dat jon@relativity:/home/jon/research/papers/thindisk/thindisk_stuff/
		#
		#
lumvstvsr 0	# phivsrt.eps
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
		dercalc 0 phivsr phivsrd
		#
		define x1label "r c^2/GM"
		define x2label "t c^3/GM"
		#
		#
		plc 0 phivsrdy
		#
		#
lumtotvsr 0 # evsr.eps
		#
		set myr=x12 if(tj==$ny-1)
		set myphivsr=phivsr if(tj==$ny-1)
		define x1label "r c^2/GM"
		define x2label "Total Energy"
		ctype default pl 0 myr myphivsr 1101 Rin Rout 1E-7 0.01
		#
		#
nt1      0      #
		#
		ctype default pl 0 myr myphivsr 1101 Rin Rout 1E-7 0.1
		#ctype default pl 0 myr lumavg 1101 Rin Rout 1E-8 3E-6
		set beta=1.0
		set RI=risco
		set AMP=1
		set it=(r<risco) ? 0 : AMP*myr*(1/myr**3)*(1-beta*(RI/myr)**(1/2))
		ctype red pl 0 myr it 1110
		#
nt2      0      #
		#
		ctype default pl 0 myr lumavg 1101 Rin Rout 1E-8 3E-4
		set beta=1.0
		set RI=risco
		set AMP=1e-4
		set it=(r<risco) ? 0 : AMP*myr*(1/myr**3)*(1-beta*(RI/myr)**(1/2))
		ctype red pl 0 myr it 1110
dlogmvst 0      #
		fdraft
		#
		#
		device postencap mdotvstcompare.eps
		#
		jrdpener 0 2000
		define x1label "t c^3/GM"
		define x2label "\dot{M}_0"
		ctype default pl 0 t dm 0101 0 2000 5E-4 .1
		#
		#
		da mdotvst.txt
		lines 1 10000000		
		read {t2 1 mdot2 2}
		ctype red pl 0 t2 mdot2 0111 0 2000 5E-4 .1
		#
		device X11
		!scp mdotvstcompare.eps jon@relativity:/home/jondata/
		#
comparec 3      #
		grid3d gdump$1
		ctype default
		pl 0 r $3
		grid3d gdump$2
		ctype red
		plo 0 r $3
		#
checkmass 1     #
		jrdp3du dump$1
		set totalmass=SUM(rho*uu0*gdet*$dx1*$dx2*$dx3) print {totalmass}
		#
checkmass2 1     #
		jrdp3du dump$1
		set dm=rho*uu0*gdet*$dx1*$dx2*$dx3 if(ti>=7)
		set totalmass=SUM(dm) print {totalmass}
		#
checkmass3 0    #
		jrdpmetricparms
		jrdp3denergen enerother1.out 0 1E30
		#
		# not true updated mass, just metric mass (mbhvst)
		#set totalmass=u0+mbhvst
		# true so-far implicit black hole mass added
		# but missing flux through horizon on prior substep
		set totalmasswithbh=u0+bhMvst
		#
		# below should be conserved
		set totalmass=u0-u0cum1
		#
		#
		set tmdiff=((totalmass-totalmass[0])/totalmass[0])
		#
checkforcebalharm 0  #
		#jrdp3du dump0000
		#grid3d gdump
		#
		set phi = -(gv300+1)*0.5
		#
		set vfromphi = sqrt(-phi)
		#
		#ctype default pl 0 r vfromphi
		#
		# so at most v/c\sim 0.1, so mostly non-relativistic gravity
		#
		#
		dercalc 0 p dp
		dercalc 0 phi dphi
		#
		set gravaccx = -dphix
		set pressureaccx = -dpx/rho
		#
		#ctype default pl 0 r gravaccx 
		#ctype red pl 0 r (-pressureaccx) 0010
		#
		ctype default pl 0 (r*Lunit) gravaccx 1101 (1*Lunit) (1E4*Lunit) 1E-10 100
		ctype red pl 0 (r*Lunit) (-pressureaccx) 1111 (1*Lunit) (1E4*Lunit) 1E-10 100
                #
                #
setupharmcompare 1 # setupharmcompare 0000
		#
		setgrbconsts
		#
                gotoharmdir
		jrdpallgrb $1
		#
		# First get HARM dump versions
		# From: jrdpeos eosdump0000
		####################################
		# below are independent variables
		set rharm = (r*Lunit)
		set rhoharm = (rho*1)
                set nbharm=rhoharm/mb
		set uharm = (u*Pressureunit)
                set Sdenharm = (Sden/Lunit**3)
                set SNUdenharm = (SNU/Lunit**3)
		set yeharm = ye # YE can be used too
		set ynu0harm = ynu # YNU0 can be used too
		set ynu0oldharm = YNU0OLD
                set ynuold = YNUOLD
		set ynulocalharm = ynulocal
		set ylharm = ye+YNUOLD # with new ye evolution method, YNUOLD is actually just true final ynu
		#
		# below is from tau integral
		set h1harm = (Height1*Lunit)
		set h2harm = (Height2*Lunit)
		set h3harm = (Height3*Lunit)
		set h4harm = (Height4*Lunit)
                set PNUharm = PNU*Pressureunit
                set UNUharm = UNU*Pressureunit
		#
		# below are from lookup table directly
		set pharm = (p*Pressureunit)
		set tempharm = (temp*Tempunit)
		set qtautnueohcmharm = (qtautnueohcm/Lunit)
		set qtauanueohcmharm = (qtauanueohcm/Lunit)
		set qtautnuebarohcmharm = (qtautnuebarohcm/Lunit)
		set qtauanuebarohcmharm = (qtauanuebarohcm/Lunit)
		set qtautmuohcmharm = (qtautmuohcm/Lunit)
		set qtauamuohcmharm = (qtauamuohcm/Lunit)
		set ntautnueohcmharm = (ntautnueohcm/Lunit)
		set ntauanueohcmharm = (ntauanueohcm/Lunit)
		set ntautnuebarohcmharm = (ntautnuebarohcm/Lunit)
		set ntauanuebarohcmharm = (ntauanuebarohcm/Lunit)
		set ntautmuohcmharm = (ntautmuohcm/Lunit)
		set ntauamuohcmharm = (ntauamuohcm/Lunit)
		set unue0harm = (unue0*Pressureunit)
		set unuebar0harm = (unuebar0*Pressureunit)
		set unumu0harm = (unumu0*Pressureunit)
		set nnue0harm = (nnue0/Lunit**3)
		set nnuebar0harm = (nnuebar0/Lunit**3)
		set nnumu0harm = (nnumu0/Lunit**3)
		set lambdatotharm = (lambdatot*Lunit)
		set lambdaintotharm = (lambdaintot*Lunit)
		set tauphotonohcmharm = (tauphotonohcm/Lunit)
		set tauphotonabsohcmharm = (tauphotonabsohcm/Lunit)
		set nnueth0harm = (nnueth0/Lunit**3)
		set nnuebarth0harm = (nnuebarth0/Lunit**3)
		#
		# for HARM, derived inside HARM as functions of above while for stellar model computed directly
		set qphotonharm = (qphoton*Pressureunit/Tunit)
		set qmharm = (qm*Pressureunit/Tunit)
		# \nabla_\mu (\rho_0 u^\mu Y_L) = 0
		# d/dt (\rho_0 V^2 u^t Y_L)
		set graddotrhouylharm = (graddotrhouyl*rhounit/Tunit/Vunit**2)
		set tthermaltotharm = (tthermaltot*Tunit)
		set tdifftotharm = (tdifftot*Tunit)
		set rho_nuharm = (rho_nu*Pressureunit)
		set p_nuharm = (p_nu*Pressureunit)
		set s_nuharm = (s_nu*Pressureunit/energyunit)
		set ynulocalharm = ynulocal
		set Ynuthermalharm = Ynuthermal
                set Ynuthermal0harm = Ynuthermal0
                set supposedYnuthermal0harm=(nnueth0harm-nnuebarth0harm)/nbharm
		set enuharm = (enu*energyunit/ergPmev)
		set enueharm = (enue*energyunit/ergPmev)
		set enuebarharm = (enuebar*energyunit/ergPmev)
                #
                set Nmharm = (qm/enu)/Tunit/Lunit**3
		#
                set expectedgraddotrhouylharm = mb*Nmharm
                #
                set cs2harm=(cs2*c*c)
		#
                set tauharm = Height1/lambdatot
		#
setupstarcompare 0 #
		#
		gotogrbmodeldir
		####################################
		# NOW GET stellar model versions
		# From: rdmykazeos eos.dat ; rdmykazeosother eosother.dat ; rdhelmcou eoscoulomb.dat ; rdhelmextra eosazbar.dat
		#
                set lambdatot=1
		set utot=1
		#
		dostandard 0
		dostandard 0
		dostandard 0
		#
		# below are independent variables
		set rstar = r
		set rhostar = rhob
                # utot itself has table offset, while utottrue is  true utot
		set ustar = utottrue
		# stottrue is true stot, while original dstot has offset in s_N
		set sdenstar = stottrue
                #
		# in this context, dstot is really total entropy but needs to be corrected with offset
                set Sdenstar = dstot - fakeentropylsoffset*(rhob/mb)
                set SNUdenstar = s_nu
                #
		set yestar = tdynorye
		set ynustar = tdynorynu
		set ynu0star = Ynu0
                set ynustar2 = Ynu
		#
		# below is from tau integral
		set hstar = hcm
		#
		# below are from lookup table directly
		# dptot is really p_tot-p_nu
		set pstar = ptot
		set tempstar = tempk
		#
		# from eosother.dat:
		set qtautnueohcmstar = qtautelohcm
		set qtauanueohcmstar = qtauaelohcm
		set qtautnuebarohcmstar = 0
		set qtauanuebarohcmstar = 0
		set qtautmuohcmstar = qtautmuohcm
		set qtauamuohcmstar = qtauamuohcm
		set ntautnueohcmstar = ntautelohcm
		set ntauanueohcmstar = ntauaelohcm
		set ntautnuebarohcmstar = 0
		set ntauanuebarohcmstar = 0
		set ntautmuohcmstar = ntautmuohcm
		set ntauamuohcmstar = ntauamuohcm
		set unue0star = 0
		set unuebar0star = 0
		set unumu0star = 0
		set nnue0star = 0
		set nnuebar0star = 0
		set nnumu0star = 0
		set lambdatotstar = lambdatot
		set lambdaintotstar = 0
		set tauphotonohcmstar = tauphotonohcm
		set tauphotonabsohcmstar = tauphotonabsohcm
		set nnueth0star = 0
		set nnuebarth0star = 0
		#
		#
		# for HARM, derived inside HARM as functions of above while for stellar model computed directly
		set qphotonstar = Qphoton
		set qmstar = Qm
		set graddotrhouylstar = graddotrhouye
		set tthermaltotstar = Tthermaltot
		set tdifftotstar = Tdifftot
		# eosother.dat:
		set rho_nustar = rho_nu
		set p_nustar = p_nu
		set s_nustar = s_nu
		set ynulocalstar = Ynu
		set Ynuthermalstar = 0
                set nb=rhostar/mb
                #set Ynuthermal0star = (nnueth0-nnuebarth0)/nb # terms don't exist yet
		# back to primary eos.dat:
		set enustar = (Enutot/ergPmev)
		set enuestar = (Enue/ergPmev)
		set enuebarstar = (Enuebar/ergPmev)
		#
		set cs2star=(cs2helm*c*c)
		#
		#
                set taustar = hcm/lambdatot
		#
gotoharmdir  0  #              
		#cd /data/jon/testfulleostable2/harm/run/
		#cd /data/jon/testfulleostable2/harm.test/run/
                #cd /data/jon/testfulleostable2/harm.test.oldgoodpressure/run
		#
		cd /data/jon/latestcode/testnewkazstuffwithgrbmodel/run/
                #
                #
gotogrbmodeldir  0  #
		#
		cd /data/jon/svngrbmodel/
                #
setupstarharm 0  #
		# run macros: gogrmhd and gogrb if haven't already
		#
		setupharmcompare 0000
		#
		setupstarcompare
                #
		gotoharmdir
		#
plotstarharm 0  #
		#############
		# Plot star and HARM versions
		#
                #####################
                # MOSTLY NON-NEUTRINO STUFF:
                #
                # P
		ctype default pl 0 rharm pharm 1100
                ctype blue pl 0 rharm PNUharm 1110
		ctype red pl 0 rstar pstar 1110
                ctype green pl 0 rstar p_nustar 1110
		#
                # U
		ctype default pl 0 rharm uharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E15 1E40
                ctype blue pl 0 rharm UNUharm 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E15 1E40
		ctype red pl 0 rstar ustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E15 1E40
		ltype 2 ctype cyan pl 0 rstar (fakelsoffset*rhostar*C*C/(mb*C*C)) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E15 1E40
                ltype 0
		#
                # Temp
		ctype default pl 0 rharm tempharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E5 1E13
		ctype red pl 0 rstar tempstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E5 1E13
		#
                # rho
		ctype default pl 0 rharm rhoharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E15
		ctype red pl 0 rstar rhostar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E15
		ctype blue pl 0 rstar (rho_nustar/C**2) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E15
                #
                # Temp
                ctype default pl 0 rhoharm tempharm 1100
                ctype red pl 0 rhostar tempstar 1110
		#
                # Sden
		ltype 0
		ctype default pl 0 rharm Sdenharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
		ctype red pl 0 rstar Sdenstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ctype cyan  pl 0 rharm SNUdenharm 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ctype blue  pl 0 rstar SNUdenstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ctype green  pl 0 rstar s_photon 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ctype magenta  pl 0 rstar s_eleposi 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ctype yellow  pl 0 rstar (s_N-fakeentropylsoffset*rhostar*C*C/(mb*C*C)) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
                ltype 3 ctype yellow  pl 0 rstar (s_N) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
		ltype 2 ctype cyan   pl 0 rstar (fakeentropylsoffset*rhostar*C*C/(mb*C*C)) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E20 1E40
		ltype 0
		#
                # c_s : sound speed
                ctype default pl 0 rharm (sqrt(cs2harm)) 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E6 (10*c)
                ltype 2
                ctype green pl 0 rharm (c+rharm*0) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E6 (10*c)
                ctype blue pl 0 rharm (c/3+rharm*0) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E6 (10*c)
                ltype 0
                set cs2starapprox=(4.0/3.0)*p/(rho0+u+p)
                ctype cyan pl 0 rharm (sqrt(cs2starapprox)*c) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E6 (10*c)
                ctype red pl 0 rstar (sqrt(cs2star)) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E6 (10*c)
                #
                #
                # YE
		ctype default pl 0 rharm yeharm 1100
		ctype red pl 0 rstar yestar 1110
		#
                #####################
                # NEUTRINO STUFF:
                #
                # H
		ctype default pl 0 rharm h1harm 1100
		ctype blue pl 0 rharm h2harm 1110
		ctype blue pl 0 rharm h3harm 1110
		ctype blue pl 0 rharm h4harm 1110
		ctype red pl 0 rstar hstar 1110
		#
                # YNU
                # ynuharm : initial primitive YNU read-in from stellar model
		#ctype default pl 0 rharm ynuharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-21 1
                # above not used anymore
                # ynulocalharm: Using latest Ynu0 to get Ynu[Ynu0] (currently 3 iterations)
		ctype default pl 0 rharm ynulocalharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-21 1
                # ynustar : initial stellar model value of YNU
		ctype red pl 0 rstar ynustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-21 1
		#
                # YNU0
                # ynu0harm : Latest Ynu0 (after 3 iterations so far) for the lookup table
		ctype default pl 0 rharm ynu0harm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-21 1
		ctype red pl 0 rstar ynu0star 1110
		#
		# stellar YNU0 and YNU
		ctype default pl 0 rstar ynu0star 1101 (rstar[0]) (rstar[dimen(rstar)-1]) 1E-21 1
		ctype green pl 0 rstar ynustar 1110
                #
		ctype default pl 0 rharm tauharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 10
		ctype red pl 0 rstar taustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 10
                #
		ctype default pl 0 rharm lambdatotharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E20
		ctype red pl 0 rstar lambdatotstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E20
		#
		ctype default pl 0 rharm qmharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E45
		ctype blue pl 0 rharm qphoton 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E45
		ctype red pl 0 rstar qmstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E45
		#
		# 
		ctype default pl 0 rharm graddotrhouylharm 1101  (rharm[0]) (rharm[dimen(rharm)-1]) 1E-15 1E30
		ctype red pl 0 rstar graddotrhouylstar 1111  (rharm[0]) (rharm[dimen(rharm)-1]) 1E-15 1E30
                ctype blue pl 0 rharm expectedgraddotrhouylharm 1111  (rharm[0]) (rharm[dimen(rharm)-1]) 1E-15 1E30
		#
                set Nmharm = (qm/enu)/Tunit/Lunit**3
		set tscaleharm = (ylharm*rhoharm)/(mb*Nmharm)
                set tscalestar= ((rhostar*ye)/(graddotrhouylstar+1E-30))
		ctype default pl 0 rharm tscaleharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-15 1E10
                ctype red pl 0 rstar tscalestar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-15 1E10
                #
		ctype default pl 0 rharm tthermaltotharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		ctype red pl 0 rstar tthermaltotstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		ctype blue pl 0 rharm tdifftotharm 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		ctype cyan pl 0 rstar tdifftotstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		ctype green pl 0 rharm (h1harm/c) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		ctype magenta pl 0 rstar (hstar/c) 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-10 1E10
		#
		ctype default pl 0 rharm rho_nuharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		ctype red pl 0 rstar rho_nustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		#
		ctype default pl 0 rharm p_nuharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		ctype red pl 0 rstar p_nustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		#
		ctype default pl 0 rharm s_nuharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		ctype red pl 0 rstar s_nustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1 1E40
		#
		ctype default pl 0 rharm enuharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		ctype red pl 0 rstar enustar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		#
		ctype default pl 0 rharm enueharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		ctype red pl 0 rstar enuestar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		#
		ctype default pl 0 rharm enuebarharm 1101 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		ctype red pl 0 rstar enuebarstar 1111 (rharm[0]) (rharm[dimen(rharm)-1]) 1E-3 10
		#
		#
		#
		# check interpolation (related to DEBUG code in kazfulleos.c)
		#
		#ctype default pl 0 rharm tauphotonabsohcm 1100
                #
checkynuharm 0  # when debug on and doing loopit
		#
		!grep TOPLOT nohup.out | sed 's/TOPLOT//g'  > mydata.dat
		#
		da mydata.dat
		lines 1 1000000
		read '%g %g' {ynu0 ynu}
		pl 0 ynu0 ynu 1100
                #
testynueos 0    #
		#
		gotogrbmodeldir
		#
		# harm
		#set rho1 = 3698177672.97952
		# star
		set rho1 = 3698268044.70451
		set u1 = 2.74411482190307e+28
		set ye1 = 0.428493
		set  ynu0star1 = 0.00109834311532855
		#set h1 = 36510204.3851301
		#set h1 = 36497750.345734
		set h1=40845928.1475294
		#
		# harm:
		#set tk1 = 7650875554.28765
		set tk1 = 8183138022.48367
		#
		set ynu0harm1 = 0.476587890201402
		set ynustar1 = 1.6929529503307e-06
		#
		#set myindex = 0,1000-1,1
		set myindex = 0,0,1
		#
		set rhotest=rho1 + myindex*0
		set tktest=tk1 + myindex*0
		set yetest=ye1+myindex*0
		set htest=h1+myindex*0
		#
		set abarintest=abarin[0]+myindex*0
		set abarboundintest=abarboundin[0]+myindex*0
		set nucleonstest=nucleons[0]+myindex*0
		set heliumtest=helium[0]+myindex*0
		set carbontest=carbon[0]+myindex*0
		set oxygentest=oxygen[0]+myindex*0
		set neontest=neon[0]+myindex*0
		set magnesiumtest=magnesium[0]+myindex*0
		set sitest=si[0]+myindex*0
		set irontest=iron[0]+myindex*0
		set Hcmtest=Hcm[0]+myindex*0
		set Ynutest=Ynu[0]+myindex*0
		#
		#
		define print_noheader (1)
		#
		set numlines=dimen(myindex)
		#
		print stellarmodel.head '%d\n' {numlines}
		#
		#
		# now print out data
		#
		print stellarmodel.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
                {rhotest tktest yetest abarintest abarboundintest nucleonstest heliumtest carbontest oxygentest neontest magnesiumtest sitest irontest Hcmtest Ynutest}
		#
                !rm -rf eosdetails.dat eosother.dat eos.dat eoscoulomb.dat eosazbar.dat
		#
		echo "HELM begin"
		!./helmstareos.exe > processeos.output
		echo "HELM end"
		#
		# input
		processeos2
		#
		#
		print {Ynu0 Ynu}
		#
		#
checkdt 0       #
		#
		jre courant.m
		#
		define whichvar dxdxp11
		#
		cd ../run.unisinth_dtlarge
		!ls dumps/dump*
		jrdp3du dump0001
		grid3d gdump0001
		courantharm
		set myv1=uu1*sqrt(gv311)/uu0
		#
		ctype default
		#pl 0 r myv1
		#pl 0 r rho 1100
		#pl 0 r p 1100
		#pl 0 r idtx1
		pl 0 ti $whichvar
		#
		cd ../run.uni2log_dtsmall
		!ls dumps/dump*
		jrdp3du dump0001
		grid3d gdump0001
		courantharm
		set myv1=uu1*sqrt(gv311)/uu0
		#
		ctype red
		#pl 0 r myv1 0010
		#pl 0 r rho 1110
		#pl 0 r p 1110
		#pl 0 r idtx1 0010
		pl 0 ti $whichvar 0010
		#
		#
		#
		#
		#
checkcrazy 0    #
		set startanim=0 set endanim=33 agpl 'dump' r (uu1*sqrt(gv311)/uu0) 1101 1E-2 Rout 0.01 10
		#
		set startanim=0 set endanim=33 agpl 'dump' r p 1100
		#
		#
		set Mfactor=4.67747316205312e-18
		set startanim=0 set endanim=62 agpl 'dump' r (2*gdet*rho*uu0*Mfactor/r) 1100
		#
		#
		set totu0 = SUM(gdet*rho*uu0*dV*Mfactor) print {totu0}
		##
		#
		#
		set startanim=0 set endanim=100 agplcompare 'dump' r rho 1100
		#
		#
checkgdetjac 0  #
		#
		#jrdp3du dump0000
		#grid3d gdump0000
		#
		#
		der ti r di dr
		set drother=$dx1*dxdxp11
		#
		set myjac = 4*pi*r**2*dr
		set myjacgdetV= (gdet*$dx1*$dx2*$dx3)/(sqrt(-gv300)*sqrt(gv311/dxdxp11**2))
		#
		set ratjac=myjac/myjacgdetV
		#
		pl 0 r ratjac 1000
		#
		#
		set ratdr=drother/dr
		pl 0 r ratdr 1000
		#
		#
agplcompare  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		set h1gdump='gdump'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fnamegdump=h1gdump+h2
                  define filename (_fname)
                  define filenamegdump (_fnamegdump)
		  #jrdp2d $filename
		  #jrdp3du $filename
		  #
		  #
		  #
		  #
		  #cd ../run.badbhformation_withjacdebugoff/
		  cd ../run.unirsinth
		  #
		  jrdp3duold $filename
		  grid3d $filenamegdump
		  #
		  set dphidt = c000*gv300 + c100*gv301 + c200*gv302 + c300*gv303
		  #
		  faraday
		  ctype default
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #
		  #
		  ctype default
		  #
                  if($numsend==2){ pl  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
		  #
		  #
		  #cd ../run.badbhformation_withjacdebugon/
		  #cd ../run.unirsinth2/
		  #cd ../run.unirsinth2_withnomhdtensorinmetriccalc/
		  cd ../run.unirsinth2_newmhdfix/
		  #
		  jrdp3duold $filename
		  grid3d $filenamegdump
		  #
		  set dphidt = c000*gv300 + c100*gv301 + c200*gv302 + c300*gv303
		  #
		  faraday
		  ctype default
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #
		  #
		  ctype red
		  #
		  if(1){\
                  if($numsend==2){ plo  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 1110}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 1111 $5 $6 $7 $8}
                   }
                  }
		  #
		  }
		  if(0){\
                  if($numsend==2){ plo  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 1010}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 1011 $5 $6 $7 $8}
                   }
                  }
		  #
		  }
		  #
		}
		#
		# animate pls in HARM
		#
checkgrid 0     #
		#
		jrdp3du dump0000
		grid3d gdump
		set mydr = $dx1*dxdxp11
		der ti r dti mydrfromder
		#
		#
		print {ti r mydr mydrfromder}
		#
		#
checkpressuredrop 0
		#
		#
		jrdp3du dump0008
		grid3d gdump0008
		ctype default pl 0 r p 1100
		#
		jrdp3du dump0009
		grid3d gdump0009
		ctype red pl 0 r p 1110
		#
		#
		jrdp3du dump0008
		grid3d gdump0008
		ctype default pl 0 r gv300 1100
		#
		jrdp3du dump0009
		grid3d gdump0009
		ctype red pl 0 r gv300 1110
		#
		#
		jrdp3du dump0008
		grid3d gdump0008
		ctype default pl 0 r (gv311/dxdxp11**2) 1100
		#
		jrdp3du dump0009
		grid3d gdump0009
		ctype red pl 0 r (gv311/dxdxp11**2) 1110
		#
		#
		#
		#
		#
plottemp0  0    #
		#
		#
		cd ~/latestcode/run/
		jrdpall 0
		set rorlold=r
		set Routold=Rout
		#
		set tempcgs=temp*Tempunit
                #
                if(rho0unittype==0){ set rhocgs=rho*rhounit } \
                else{ set rhocgs=rho*rhomassunit }
                #
		set pcgs=p*Pressureunit
		set ucgs=u*Pressureunit
                set lambdatotcgs=lambdatot*Lunit
		#
                recomputeH2
                set Hother=Hofrtau2*Lunit
                set Hcode=Height*Lunit
		#
		jre grbmodel.m
		cd ~/research/grbmodel/
		dostandard 1
                # need at least 1 iteration for H
		dostandard 1
		# get data in stellar model
		# set i=1,dimen(r),1
		# print {i r rhob temp}
		# 25   1.271e+07   3.371e+09    8.09e+09
		#
		cd ~/latestcode/run/
		#
                set ylstar = ye+Ynu
		set rorl = r/rl
                #
                plotplottemp0
                #
                #
plotplottemp0 0 #
		#ctype default pl 0 rorlold rhocgs 1100
		#ctype default pl 0 rorlold ucgs 1100
                #ctype default pl 0 rorlold yl 1000
                #ctype default pl 0 rorlold (Height*Lunit) 1101 0.1 Routold 1E6 1E12
		#ctype blue pl 0 rorlold Hother 1111 0.1 Routold 1E6 1E12
                #ctype default pl 0 rorlold lambdatotcgs 1101 0.1 Routold 1E6 1E15
		#ctype default pl 0 rorlold pcgs 1100
		ctype default pl 0 rorlold tempcgs 1101 0.1 Routold 1E8 1E11
                #
		#ctype red pl 0 rorl rho 1110
		#ctype red pl 0 rorl utot 1110
                #ctype red pl 0 rorl (ye+Ynu) 1010
                #ctype red pl 0 rorl hcm 1111 0.1 Routold 1E6 1E12
                #ctype red pl 0 rorl lambdatot 1111 0.1 Routold 1E6 1E15
		#ctype red pl 0 rorl ptot 1110
		ctype red pl 0 rorl temp 1110
                #
                set Hcode=Height*Lunit
                # print {rorlold rhocgs ucgs yl Hcode pcgs tempcgs}
                # 0.1631   2.856e+09   2.377e+28      0.4461   4.304e+07    1.75e+27   4.915e+09
		#
                #
                #
                # print {rorl rho utot ylstar hcm ptot temp}
                #
		# 0.3984   2.856e+09   2.377e+28      0.4461   5.749e+07   1.805e+27   7.997e+09
                #
		#
		#
tempcheck5 0    #
		# jrdpall 0
		#
		ctype default pl 0 r (1E-5*u**(1/4)) 1100
		ctype blue pl 0 r (3E-2*u/rho) 1110
		ctype red pl 0 r temp 1110
		#
		#
		#
checkpmig 0     # 
		# jrdpallgrb 0  
		#
		set rhoe=rho/mb*me*ye
		#
		#set offset=7.8E-3
		#set offset=7.6E-3
		set offset=7.57E-3
		#set offset=7.8E-3
		#
		set offsetmev=offset*mb*c*c/ergPmev
		print {offset offsetmev}
		#
		#
		ctype default pl 0 r p 1100
		ctype red pl 0 r ((4/3-1.0)*(u/rho-offset)*rho) 1110
		ctype blue pl 0 r ((5/3-1.0)*(u/rho-offset)*rho) 1110
		#
		set myuorho=u/rhoe-offset*mb/me
		set mypmig=rhoe*myuorho*(2+myuorho)/(3*(1+myuorho))
		ctype cyan pl 0 r mypmig 1110
		#
		#
		#
plotsm 0        #
		#
		define newgy1 ($gy1-100)
		erase
		AXIS -1 4 -1 -10 $gx1 $newgy1 $($gx2-$gx1) 1 0
		#
		#
		gogrmhd
		jre phivsr.m
		gogrb
		jrdpallgrb 0
		pl 0 r p 1100
		#
		#
		#
		#
		#
		gogrmhd
		jre phivsr.m
		gogrb
		jrdpallgrb 0
		#
		#set lgr=lg(abs(r))/lg(100)
		#set lgp=lg(p)/lg(100)
		#
		set lgr=lg(abs(r))/lg(10)
		set lgp=lg(p)/lg(10)
		#
		limits lgr lgp
		ticksize -1 0 -1 0
		erase box
		connect lgr lgp
		#
                #
checkinv 0      #
		#
		set rho0=1.00405028296078e+15
		set uu0=1.21624915276967
		set ud0=-0.822288519792998
		set u=127146518574121
		set p=178276753.620458 # (4/3-1)*u #  hack, don't have pressure
		set bu0=0
		set bu1=0
		set bu2=-1.4772753983733e-08
		set bu3=0
		set bd0=0
		set bd1=0
		set bd2=-1.57269994118938e-09
		set bd3=0
		set bsq=bu0*bd0+bu1*bd1+bu2*bd2+bu3*bd3
		#
		set Tud00geomfree = rho0*uu0*(1+ud0) + (u+p)*uu0*ud0 -bu0*bd0 + (p+bsq/2)
		print '%21.15g\n' {Tud00geomfree}
checkinv2 0      #
		#
		set rho0=1.01237058317292e+15
		set uu0=1.26711016899635
		set ud0=-0.92615821012561
		set u=3.77278085970973e+16
		set p=1.31885760048493e+16
		set bu0=0
		set bu1=0
		set bu2=0.0112773290431803
		set bu3=0
		set bd0=0
		set bd1=0
		set bd2=0.0103778561751287
		set bd3=0
		set bsq=bu0*bd0+bu1*bd1+bu2*bd2+bu3*bd3
		#
		set Tud00geomfree = rho0*uu0*(1+ud0) + (u+p+bsq)*uu0*ud0 -bu0*bd0 + (p+bsq/2)
		print '%21.15g\n' {Tud00geomfree}
                #
		set U1old=-4.69307390202212e+16
                set U1new=-4.646934325453e+16
                #
                set olddiff=(Tud00geomfree-U1old)/(abs(Tud00geomfree)+abs(U1old))
                set newdiff=(Tud00geomfree-U1new)/(abs(Tud00geomfree)+abs(U1new))
                print {olddiff newdiff}
                #
		#
		#
		#
plotvst 0       #
		#
		der t u1srcpart1 dt du1srcpart1
		set god=(du1srcpart1*energyunit/Tunit)
		pl 0 dt god
		#
		#
		ctype default
		pl 0 t (-u1srcpart1*energyunit) 0101 (t[0]) (t[dimen(t)-1]) 1E40 1E53
		#
		ctype red
		pl 0 t (-u8srcpart1*energyunit/(mb*c**2)*(4*ergPmev)) 0111 (t[0]) (t[dimen(t)-1]) 1E45 1E55
		#
		#
		#checkforcebalharm
agplgrb  0	# agplgrb
		#
		set startanim=6000
		set endanim=10000
		#
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1='dump'
		set h1gdump='gdump'
		set h1debug='debug'
		set h1eosdump='eosdump'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fnamedebug=h1debug+h2
		   set _fnamegdump=h1gdump+h2
		   set _fnameeosdump=h1eosdump+h2
                  define filename (_fname)
                  define filenameeosdump (_fnameeosdump)
                  define filenamedebug (_fnamedebug)
                  define filenamegdump (_fnamegdump)
		  #jrdp2d $filename
		  #
		  # NEW
                  #jrdpall $ii
                  #jrdp3du $filename
                  define arg (h2)
                  jrdpallgrb $arg
		  #
		  # OLD
		  #jrdp3duold $filename
		  #
		  # GENERAL
		  #grid3d $filenamegdump
                  #
		  #set dphidt = c000*gv300 + c100*gv301 + c200*gv302 + c300*gv303
		  #
		  #
		  #
		  checkforcebalharm
		  #
		  #
		  ctype cyan pl 0 (r*Lunit) (rho/1E14) 1111 (1*Lunit) (1E4*Lunit) 1E-10 100
		  #
		  #
                  #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  #!sleep .5s
		}
		#
		# animate pls in HARM
		#
                # End HARM phivsr.m macros
                #####################
