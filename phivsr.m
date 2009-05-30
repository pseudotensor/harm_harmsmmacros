gogrb 0        #
		#
                #gogrmhd
		jre phivsr.m
		jre grbmodel.m
		jre kaz.m
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
rdvsr 3              # read in dump first
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
checkforcebal 0  #
		#jrdp3du dump0000
		#grid3d gdump
		#
		set phi = -(gv300+1)*0.5
		#
		set vfromphi = sqrt(-phi)
		#
		ctype default pl 0 r vfromphi
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
		ctype default pl 0 r gravaccx 1101 1 1E4 1E-10 10
		ctype red pl 0 r (-pressureaccx) 1111 1 1E4 1E-10 10
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
checktemp2 0    #
		#checkhelmmonoeos
		#redohelmmono
		#nonmonosequence2
		#
		# from nonmonosequence2
		# HELM EOS estimate for 10^(10)K:
		# utot=10**27.6193=4.162e+27
		# rhob=2.073e+09
		#
		# dostandard
		# stellar model
		# print {r rhob utot ptot temp} 
		# utot,ptot come from stellar HELM EOS for given rhob,temp
		# 1.047e+06   3.616e+09   6.512e+27   2.424e+27    8.12e+09
		#
		#ctype default pl 0 rorlold ucgs 1100
		#
		#print {rorlold rhocgs ucgs pcgs tempk}
		#0.1631   3.616e+09   6.512e+27   4.337e+27           0
		#
		#
		#
		#
checktemp3    0 #
		checkhelmeos 0 0
		nonmonosequence2
		ctype cyan pl 0 tempk (6.512e+27+tempk*0) 1110
		ctype cyan vertline (LG(8.12e+09))
		#
		#
checktemp4 0	#
		redohelmmono
		#redohelm
		set god=INT((nrhob/2+nrhob/13))
		set god=115
		set god2=rhob[god]
		print {god god2}
		#
		# from stellar model:
		set therhob=3.616e+09
		set thetemp=8.12e+09
		#set theutot=6.512e+27
		set theutot=6.567e+27
		# FROM 1 point in jonhelm: utot=6.567495770363091E+27
		# FROM 1 point in jonhelmstellar: utot=6.567495770363091E+27
		#
		set codeudegen=8211210.0*Pressureunit
		print {therhob thetemp theutot codeudegen}
		print {therhob codeudegen}
		#
		# FROM HELM EOS MONOTONIZED
		set mymm=115
		set myutot1=utot if(mm==mymm)
		set mytempk1=tempk if(mm==mymm)
		set myrhob1=rhob if(mm==mymm && nn==0 && ll==0 && pp==0)
		set utotdegen1=udegenfit if(mm==mymm && nn==0 && ll==0 && pp==0)
		print {myrhob1 utotdegen1}
		#
		#ctype default pl 0 mytempk1 myutot1 1100
		#ctype default pl 0 mytempk1 myutot1 1101 1E9 1E11 1E27 1E28
		define x1label "T"
		define x2label "utot"
		ctype default pl 0 mytempk1 myutot1 1101 1E4 1E11 1E27 1E29
		points (LG(mytempk1)) (LG(myutot1))
		#
		set mymm=116
		set myutot2=utot if(mm==mymm)
		set mytempk2=tempk if(mm==mymm)
		set myrhob2=rhob if(mm==mymm && nn==0 && ll==0 && pp==0)
		set utotdegen2=udegenfit if(mm==mymm && nn==0 && ll==0 && pp==0)
		print {myrhob2 utotdegen2}
		#
		ctype red pl 0 mytempk2 myutot2 1110
		points (LG(mytempk2)) (LG(myutot2))
		#
		# overlay utot value from stellar model (i.e. initial data)
		ctype cyan pl 0 mytempk1 (theutot+mytempk1*0) 1110
		ctype cyan vertline (LG(thetemp))
		points (LG(thetemp)) (LG(theutot))
		#
		ctype green pl 0 mytempk1 (codeudegen+mytempk1*0) 1110
		#
		ctype blue pl 0 mytempk1 (utotdegen1+mytempk1*0) 1110
		ctype blue pl 0 mytempk2 (utotdegen2+mytempk2*0) 1110
		#
		#
checkmononew0 0 # notice that ptot is not single-valued function of utot even for original kaz EOS
		#redokaz
		#redokazmono
		# seems helm EOS is single-valued in sensitive regions
		#redohelm
		redohelmmono
		#set mymm=115
		set mymm=151
		set myptot=ptot if(mm==mymm)
		set myutot=utot if(mm==mymm)
		set mychi=chi if(mm==mymm)
		#
		ctype default
		define x1label "u_{tot}"
		define x2label "p_{tot}"
		pl 0 myutot myptot 1100
		#
		#print {myutot myptot}
checkmononew1 0 #
		#
		#print {mychi myutot}
		define x1label "\chi"
		define x2label "u_{tot}"
		ctype default pl 0 mychi myutot 1101 1E31 1.5E31 5.0E30 1E31
		ctype red points (LG(mychi)) (LG(myutot))
		#
checkmononew2 0 #
		#
		#print {mychi myptot}
		define x1label "\chi"
		define x2label "u_{tot}"
		ctype default pl 0 mychi myptot 1101 1E31 1.5E31 2.0E30 1E31
		ctype red points (LG(mychi)) (LG(myptot))
		#
checketaenew0 2	# 
		#redokaz
		#redokazmono
		set mykaznn=$1
		set myhelmnn=$1
		#set mykaznn=140
		#set myhelmnn=0+140
		#
		if($1==0){\
		       # picking density point
		       set mypickvar=mm
		       set mypick=$2
		    }
		if($1==1){\
		           # picking temperature point
		       set mypickvar=nn
		       set mypick=$2
		    }
		#
		#
		# seems helm EOS is single-valued in sensitive regions
		redohelm
		#redohelmmono
		set helmyefree=1/(1+npratio)
		#
		set myhelmrhob=rhob if(mypickvar==mypick)
		set myhelmptot=ptot if(mypickvar==mypick)
		set myhelmutot=utot if(mypickvar==mypick)
		set myhelmchi=chi if(mypickvar==mypick)
		set myhelmetae=etae-me*c*c/(kb*tempk) if(mypickvar==mypick)
		set myhelmtempk=tempk if(mypickvar==mypick)
		degenpar
		set myhelmrelfact=relfact if(mypickvar==mypick)
		set myhelmreldegen=reldegen if(mypickvar==mypick)
		set myhelmnonreldegen=nonreldegen if(mypickvar==mypick)
		set myhelmnpratio=npratio if(mypickvar==mypick)
		set myhelmyefree=(1/(1+npratio)) if(mypickvar==mypick)
		set myhelmyetot=yetot if(mypickvar==mypick)
		set myhelmxnuc=xnuc if(mypickvar==mypick)
		#print {myhelmtempk myhelmrelfact myhelmreldegen myhelmnonreldegen}
		#print {myhelmtempk}
		#
		#redokazmono
		redokaz
		set kazyefree=1/(1+npratio)
		#
		set mykazrhob=rhob if(mypickvar==mypick)
		set mykazptot=ptot if(mypickvar==mypick)
		set mykazutot=utot if(mypickvar==mypick)
		set mykazchi=chi if(mypickvar==mypick)
		set mykazetae=etae-me*c*c/(kb*tempk) if(mypickvar==mypick)
		set mykaztempk=tempk if(mypickvar==mypick)
		degenpar
		set mykazrelfact=relfact if(mypickvar==mypick)
		set mykazreldegen=reldegen if(mypickvar==mypick)
		set mykaznonreldegen=nonreldegen if(mypickvar==mypick)
		set mykaznpratio=npratio if(mypickvar==mypick)
		set mykazyefree=(1/(1+npratio)) if(mypickvar==mypick)
		set mykazxnuc=xnuc if(mypickvar==mypick)
		#print {mykaztempk myhelmrelfact mykazreldegen mykaznonreldegen}
		#print {mykaztempk}
		#
		#
		#
		ctype default
		define x2label "\eta_e"
		if($1==0){\
		       define x1label "T[K]"
		       # picking density point
		       ctype default pl 0 myhelmtempk myhelmetae 1100
		       ctype red pl 0 mykaztempk mykazetae 1110
		    }
		if($1==1){\
		           define x1label "\rho_b"
		       # picking temperature point
		       ctype default pl 0 myhelmrhob myhelmetae 1100
		       ctype red pl 0 mykazrhob mykazetae 1110
		    }
		#
		#print {myutot myptot}
		#
plreldegen      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "reldegen"
		ctype default pl 0 myhelmrhob myhelmreldegen 1100
		ctype red pl 0 mykazrhob mykazreldegen 1110
		#
plnonreldegen      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "nonreldegen"
		ctype default pl 0 myhelmrhob myhelmnonreldegen 1100
		ctype red pl 0 mykazrhob mykaznonreldegen 1110
		#
plrelfact      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "relfact"
		ctype default pl 0 myhelmrhob myhelmrelfact 1100
		ctype red pl 0 mykazrhob mykazrelfact 1110
		#
plnpratio      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "npratio"
		ctype default pl 0 myhelmrhob myhelmnpratio 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykaznpratio 1110
plyefree      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "yefree"
		ctype default pl 0 myhelmrhob myhelmyefree 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykazyefree 1110
		ctype blue pl 0 myhelmrhob myhelmyetot 1110
		#
degenpar 0      #
		set relfact=(kb*tempk/(me*c**2))
		#
		set mue=2
		set ne = (rhob/(mue*mp))
		set reldegen = ne/(2*(kb*tempk/(hbar*c))**3/(pi**2))
		set nonreldegen = ne/(2*(me*kb*tempk/(2*pi*hbar**2)))**(3/2)
		#
plxnuc      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "xnuc"
		ctype default pl 0 myhelmrhob myhelmxnuc 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykazxnuc 1110
		#
checkrdkaz 0    #
		#
		#
		# let's look in run.200sq.1e15tdyn.1em15hcm:
		# do: less -S -# 5 -N eos.dat
		# let's read in eos.dat into SM:
		jre kaz.m
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/run.200sq.1e15tdyn.1em15hcm/
		# stays high:
		#set utotfix=1
		#cd ~/research/kazeos/eoslarge_corrxnuc_tkcolumn/
		# stays high:
		#set utotfix=1
		#cd ~/research/kazeos/eoslarge_oldxnuc/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/etaefixed_200sq/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/allfixed_200sq_new/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/run.4848163/
		#
		#set utotfix=0
		#cd ~/research/kazeos/kaz_allfixed_changemuektrestmass_200sq/
		#
		#set utotfix=0
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		#
		set utotfix=0
		cd ~/research/kazeos/kaz_allfixed_ye.5_200sq/
		#
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set pkaz_eleposi=p_eleposi
		set ukaz_eleposi=rho_eleposi
		#
checkrdkazmono 0    #
		#
		#
		jre kaz.m
		set utotfix=0
		#cd ~/research/kazeos/allfixed_200sq_new/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		cd ~/research/kazeos/kaz_newdist_rnp1_200sq
		#
		#
		rdmykazmonoeos eosmonodegen.dat
		rdmykazeosother eosother.dat
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set pkaz_eleposi=p_eleposi
		set ukaz_eleposi=rho_eleposi
		#
checkrdhelmmono 0    #
		#
		#
		jre kaz.m
		set utotfix=0
		#cd ~/research/helm/helm_mutot_linearmutot_yefit/
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq
                #
		cd ~/research/helm/200x200x1x50/
		rdmykazmonoeos eosmonodegen.dat
		rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
checkrdhelmmono2 0    #
		#
		#
		jre kaz.m
		set utotfix=0
		#cd ~/research/helm/helm_mutot_linearmutot_yefit/
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq
                #
		cd ~/research/helm/200x200x1x50/
		rdmykazmonoeos eosmonodegen.dat
		#rdmykazeosother eosother.dat
		#rdhelmcou eoscoulomb.dat
		#rdhelmextra eosazbar.dat
		#
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
		#
checkrdhelm 0   #
		#
		# let's look in helm/helm_mutot_yefit
		# do: less -S -# 5 -N eos.dat
		# let's read in eos.dat into SM:
		#jre kaz.m
                #
                #
		cd ~/research/helm/200x200x1x50/
		rdmykazeos eos.dat
                rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
setfixedeos 2   #
		checkrdkaz
		set utotfinal=utot-ukaz_eleposi
		set ptotfinal=ptot-pkaz_eleposi
		checkrdhelm
		set utotfinal=utotfinal+uhelm_eleposi
		set ptotfinal=ptotfinal+phelm_eleposi
		set utot=utotfinal
		set ptot=ptotfinal
		#
		checkanyeos $1 $2
		#
checkkazeos 2   #
		checkrdkaz
		checkanyeos $1 $2
		#
checkkazmonoeos 2   #
		checkrdkazmono
		checkanyeos $1 $2
		#
checkhelmmonoeos 2	#
		checkrdhelmmono
		checkanyeos $1 $2
		#
checkhelmmonoeos2 2	#
		checkrdhelmmono2
		checkanyeos $1 $2
		#
checkhelmeos 2  #
		checkrdhelm
		checkanyeos $1 $2
		#
nonmonocheck0 0  #
		# should make this consistent with nonmonocheck2
		set myuse=(rhob>1E10 && rhob<1.1E10 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		#define x2label "\rho_{ep}"
		#set whichfun=rho_eleposi
		#define x2label "p_{ep}"
                define x2label "chosenfun"
                # set whichfun=p_eleposi
		set mychosenfun=chosenfun if(myuse)
		#set mychosenfun=rho_N-rhob*C**2 if(myuse)
		#set mychosenfun=rho_nu if(myuse)
		#set mychosenfun=rho_photon if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		pl 0 mytempk mychosenfun 1101 1E5 1E13 1E10 1E40
		points (LG(mytempk)) (LG(mychosenfun))
		#
nonmonocheck02 1  #
		# should make this consistent with nonmonocheck22
		set myuse=(mm==$1 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		#
		# assume checkhelmeos or checkkazeos sets whichfun
		set mychosenfun=chosenfun if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		pl 0 mytempk mychosenfun 1101 1E5 1E13 1E10 1E40
		points (LG(mytempk)) (LG(mychosenfun))
		# below assumes rhob associated with fastest index
		set temprhob=rhob[$1]
		print {temprhob}
                #
nonmonocheck22  1  #
		set myuse=(mm==$1 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		set mychosenfun=chosenfun if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		#define x2label "\rho_{ep}"
		pl 0 mytempk mychosenfun 1111 1E5 1E13 1E10 1E40
		# below assumes rhob associated with fastest index
		set temprhob=rhob[$1]
		print {temprhob}
		#
		#
nonmonosequence 0 #
		ctype default
		nonmonocheck0
		plotnonmono1
		ctype default
		nonmonocheck2 1E2 1.15E2
		plotnonmono1
		ctype default
		nonmonocheck2 1E3 1.15E3
		plotnonmono1
		ctype default
		nonmonocheck2 1E4 1.15E4
		plotnonmono1
		ctype default
		nonmonocheck2 1E5 1.15E5
		plotnonmono1
		ctype default
		nonmonocheck2 1E6 1.15E6
		plotnonmono1
		ctype default
		nonmonocheck2 1E7 1.15E7
		plotnonmono1
		ctype default
		nonmonocheck2 1E8 1.15E8
		plotnonmono1
		ctype default
		nonmonocheck2 1E9 1.15E9
		plotnonmono1
		ctype default
		nonmonocheck2 1E10 1.15E10
		plotnonmono1
		ctype default
		nonmonocheck2 1E11 1.15E11
		plotnonmono1
		ctype default
		nonmonocheck2 1E12 1.15E12
		plotnonmono1
		ctype default
		nonmonocheck2 1E13 1.15E13
		plotnonmono1
		ctype default
		nonmonocheck2 1E14 1.15E14
		plotnonmono1
		ctype default
		nonmonocheck2 1E15 1.15E15
		plotnonmono1
		#
nonmonosequence2 0 #
		ctype default
		nonmonocheck02 (INT(nrhob/14)*0)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*1)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*2)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*3)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*4)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*5)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*6)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*7)
		plotnonmono1
		#
		ctype default
		nonmonocheck22 (INT(nrhob/14)*8)
		plotnonmono1
		#
		#
		#ctype default
		#nonmonocheck22 (nrhob/2+nrhob/20)
		#plotnonmono1
		#
		#
		ctype default
		set god=INT((nrhob/2+nrhob/13))
		nonmonocheck22 god
		plotnonmono1
		#
		ctype default
		nonmonocheck22 (INT(nrhob/14)*9)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*10)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*11)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*12)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*13)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*14)
		plotnonmono1
		#
nonmonocheck1 0  #
		# call nonmonocheck0 first
		der mytempk mychosenfun dmytempk dmychosenfun
		#
		set rat=(dmychosenfun/mychosenfun)
		#
		set mydmytempk=dmytempk if(rat>0)
		set myrat=rat if(rat>0)
		set mydmytempk2=dmytempk if(rat<=0)
		set myrat2=rat if(rat<=0)
		#
plotnonmono1  0  #
		# just did this in prior macro: pl 0 mytempk mychosenfun 1111 1E5 1E13 1E10 1E40
		nonmonocheck1
		set myyo=mychosenfun if(dmychosenfun<0)
		set myxo=mytempk if(dmychosenfun<0)
		ctype red pl 0 myxo myyo 1111 1E5 1E13 1E10 1E40
		ctype red points (LG(myxo)) (LG(myyo))
		#
nonmonocheck1plot 0  #
		ctype red
		pl 0 mydmytempk myrat 1100
		ctype blue
		pl 0 mydmytempk2 myrat2 1110
		#
checkanyeos 2   #
		#
		#
                if($1==0){ set TEMPLIMIT =1.01E4 }
                if($1==1){ set TEMPLIMIT =5E12 }
		#
		# 0 = utot
		# 1 = ptot
		# 2 = chi
		define whichfun $2
		#
		#
		#
		#
		jre grbmodel.m
		setgrbconsts
		# approximately
		set temp=tempk
		setyefit
		#
		#
		#
		#ctype default pl 0 rhob dutot 1100
		ctype default
		erase
		#
		if($whichfun==0){\
		       set chosenfun=dutot
		    }
		if($whichfun==1){\
		       set chosenfun=dptot
		    }
		if($whichfun==2){\
		       set chosenfun=dchi
		    }
		#
		#limits (LG(rhob)) (LG(chosenfun))
		limits (LG(rhob)) 0 40
		erase
		box
		xla "\rho"
		if($whichfun==0){\
		       define x2label "u_{tot}"
		    }
		if($whichfun==1){\
		           define x2label "p_{tot}"
		        }
		#
		if($whichfun==2){\
		           define x2label "\chi"
		        }
		#
		yla $x2label
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set mychosenfun=chosenfun if(myuse)
		set myutot=dutot if(myuse)
		set myptot=dptot if(myuse)
		set mychi=dchi if(myuse)
		#
		ctype default points (LG(myrhob)) (LG(mychosenfun))
		#
		rhobutotpoint
		#
		#
		# plot degen overlay here so uses larger Kaz-EOS span of rhob and tempk
		if($whichfun==0){\
		       plotdegenoverlay
		    }
		#
		#
		#
		#
setfitskaz 0    #
		# plot u_tot - u_degen to see spread in temperature
		#set udegenfit=1.5163*K*((rhob+3E6)*yefit)**(1/3)*rhob
		#set udegenfit=1.51663*K*((rhob+3.7E6)*yefit)**(1/3)*rhob
		#set udegenfit=1.51663*K*((rhob+4.6E6)*yefit)**(0.9999/3)*rhob**(1.0)
		# try log with break
		set npow=1.95
		set udegenfit1=1.516*K*((rhob+0.0E6))**(4.0/3)* yefit**(1.0/3)
		#set udegenfit1=0
		set udegenfit2=1.66*1E2*1.516*K*((rhob+0.0E6))**(1.0)* yefit**(1.0/3)
		#set udegenfit2=0
		#set udegenfit = (1.0/(1.0/udegenfit1**npow+1.0/udegenfit2**npow))**(1/npow)
		set udegenfit = (udegenfit1**npow + udegenfit2**npow)**(1/npow)
		#
		#
		# below not set good fit
		#set pdegenfit1=(3.0335*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=(0.028*K*((rhob+0E6)*yefit)**(1.94/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set npow=1.95
		#
		# below best fit so far for ptot
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		# print '%21.15g %21.15g %21.15g\n' {mydiffptot myrhob pdegenfit1} 
		set pdegenfit1=(K*((rhob+0E6)*yefit)**(1.0001/3)*rhob)*(4.0/3.0-1.0)*yefit
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		set usepdegenfit1=pdegenfit1 if(myuse)
		set ii=1,dimen(usepdegenfit1)
		set P0 = 4.93066895509393e+34
		set P1 = usepdegenfit1[199]
		set pdegenfit1=P0*pdegenfit1/P1
		#set pdegenfit1=0
		#
		set pdegenfit2=(K*((rhob+0E6)*yefit)**(1.5/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=0
		set usepdegenfit2=pdegenfit2 if(myuse)
		set ii=1,dimen(usepdegenfit2)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit2[31]
		set pdegenfit2=P0*pdegenfit2/P1
		#
		set pdegenfit3=(K*((rhob+0E6)*yefit)**(2.0/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit3=0
		set usepdegenfit3=pdegenfit3 if(myuse)
		set ii=1,dimen(usepdegenfit3)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit3[31]
		set pdegenfit3=P0*pdegenfit3/P1
		#
		set npow=3.0
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow+1.0/pdegenfit3**npow))**(1/npow)
		#set pdegenfit = pdegenfit1
		#
		# from SM:
		#       below best fit so far for ptot
		set pdegenfit1=(3.0310*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		set pdegenfit2=(0.0235*K*((rhob+0E6)*yefit)**(2.00/3)*rhob)*(4.0/3.0-1.0)*yefit
 		set npow=1.94
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow))**(1/npow)
		#
		#
		#
redohelmkaz 2   # 
		jre phivsr.m
		checkhelmeos $1 $2
		#
		setfixedeos
		#
		setgennumfits
		#
		# functional fits
		#setfitshelmkaz
		#
		showdegendiff
		#
redokazmono 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkkazmonoeos $1 $2
		showdegendiff
		#
redohelmmono 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkhelmmonoeos $1 $2
		#
		# test of how good mathlab degen is
		#setgennumfits
		#
		#
		showdegendiff
		#
redohelmmono2 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkhelmmonoeos2 $1 $2
		#
		# test of how good mathlab degen is
		#setgennumfits
		#
		#
		showdegendiff
		#
redokaz 2   # 
		#jre phivsr.m
		checkkazeos $1 $2
		#
		# numerical fits
		setgennumfits
		#
		# functional fits
		#setfitskaz
		#
		showdegendiff
		#
		#
redohelm 2   # 
		#jre phivsr.m
		checkhelmeos $1 $2
		#
		# numerical fits
		setgennumfits
		#
		# functional fits
		#setfitshelm
		#
		showdegendiff
		#
		#
setgennumfits 0 #
		# try using numerical fit
		#
		# get lowest temperature utot vs rhob
		#
		# works for Kaz except known problem area (higher temp dip near 1E11K)
		set A0 = 0.999
		# HELM (best can be done due to some non-monotonic stuff at higher temp)
		#set A0 = 0.96
		#
                #
                #
		set udegenfit = dutot if(nn==0 && oo==0 && pp==0)
		set pdegenfit = dptot if(nn==0 && oo==0 && pp==0)
                #
                set utotoffset0 = udegenfit - abs(udegenfit)*(1-A0)
                set ptotoffset0 = pdegenfit - abs(pdegenfit)*(1-A0)
                #
		set chidegenfit = udegenfit+pdegenfit
		set chioffset0 = utotoffset0 + ptotoffset0
		#
		set myusenum=SUM(myuse)
		set numcats=myusenum/dimen(utotoffset0)
		#
		# actually just need to make it as big as normal arrays
		#
		set numcats = dimen(myuse)/dimen(utotoffset0)
		#
		# concat until as long as myuse selection method
		set utotoffset=utotoffset0
		set ptotoffset=ptotoffset0
		do kk=0,numcats-2,1{
		   set utotoffset = utotoffset CONCAT utotoffset0
		   set ptotoffset = ptotoffset CONCAT ptotoffset0
		}
		#
		#
		#
setfitshelmkaz 0    #
		# try log with break
		set npow=1.95
		set udegenfit1=0.73*K*((rhob+0.0E6))**(4.065/3)* yefit**(1.0/3)
		#set udegenfit1=1E50
		#set udegenfit2=.0061*K*((rhob+0.0E6))**(4.9/3.0)* yefit**(1.0/3)
		set udegenfit2=1E50
		set udegenfit = (1.0/(1.0/udegenfit1**npow+1.0/udegenfit2**npow))**(1/npow)
		#set udegenfit = (udegenfit1**npow + udegenfit2**npow)**(1/npow)
		#
		#
		# below not set good fit
		#set pdegenfit1=(3.0335*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=(0.028*K*((rhob+0E6)*yefit)**(1.94/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set npow=1.95
		#
		# below best fit so far for ptot
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		# print '%21.15g %21.15g %21.15g\n' {mydiffptot myrhob pdegenfit1} 
		set pdegenfit1=(K*((rhob+0E6)*yefit)**(1.0001/3)*rhob)*(4.0/3.0-1.0)*yefit
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		set usepdegenfit1=pdegenfit1 if(myuse)
		set ii=1,dimen(usepdegenfit1)
		set P0 = 4.93066895509393e+34
		set P1 = usepdegenfit1[199]
		set pdegenfit1=P0*pdegenfit1/P1
		#set pdegenfit1=0
		#
		set pdegenfit2=(K*((rhob+0E6)*yefit)**(1.5/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=0
		set usepdegenfit2=pdegenfit2 if(myuse)
		set ii=1,dimen(usepdegenfit2)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit2[31]
		set pdegenfit2=P0*pdegenfit2/P1
		#
		set pdegenfit3=(K*((rhob+0E6)*yefit)**(2.0/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit3=0
		set usepdegenfit3=pdegenfit3 if(myuse)
		set ii=1,dimen(usepdegenfit3)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit3[31]
		set pdegenfit3=P0*pdegenfit3/P1
		#
		set npow=3.0
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow+1.0/pdegenfit3**npow))**(1/npow)
		#set pdegenfit = pdegenfit1
		#
		# from SM:
		#       below best fit so far for ptot
		set pdegenfit1=(3.0310*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		set pdegenfit2=(0.0235*K*((rhob+0E6)*yefit)**(2.00/3)*rhob)*(4.0/3.0-1.0)*yefit
 		set npow=1.94
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow))**(1/npow)
		#
showdegendiff 0 #
		#
		if($whichfun==0){\
		       set myudegenfit=utotoffset if(myuse)
		       ctype magenta points (LG(myrhob)) (LG(myudegenfit))
		       set diffutot = dutot-utotoffset
		       set mydiffutot = diffutot if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffutot))
		       ctype red points (LG(myrhob)) (LG(-mydiffutot))
		       #
		       #set myelerestmass = me*c*c*rhob/mb*zbar/abar if(myuse)
                       #ctype blue points (LG(myrhob)) (LG(myelerestmass))
		       #ctype blue points (LG(myrhob)) (LG(2.0*myelerestmass))
                                 
		    }
		#
		if($whichfun==1){\
		       set mypdegenfit=ptotoffset if(myuse)
		       ctype magenta points (LG(myrhob)) (LG(mypdegenfit))
		       set diffptot = dptot-ptotoffset
		       set mydiffptot = diffptot if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffptot))
		       ctype red points (LG(myrhob)) (LG(-mydiffptot))
		    }
		#
		#
		if($whichfun==2){\
		       set mychidegenfit=chioffset if(myuse)
		       #
		       ctype magenta points (LG(myrhob)) (LG(mychidegenfit))
		       set diffchi = dchi-chioffset
		       set mydiffchi = diffchi if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffchi))
		       ctype red points (LG(myrhob)) (LG(-mydiffchi))
		    }
		#
		#
rhobutotpoint 0 #
		set rhobpoint=3.5E9+0*myrhob
		ctype red connect (LG(rhobpoint)) (LG(myutot))
		#
		set utotpoint=5.95E27+0*myrhob
		ctype red connect (LG(myrhob)) (LG(utotpoint))
		#
		#
		#
checkkazetae 0  #
		checkrdkaz
		#
		erase
		ticksize -1 10 -1 10
		#
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myetae=etae if(myuse)
		#
		ctype default
		limits (LG(rhob)) (LG(etae))
		erase
		box
		xla "\rho"
		yla "\eta_e"
		ctype default points (LG(myrhob)) (LG(myetae))
		#
checkkazetae2 0  #
		checkrdkaz
		#
		erase	
		ticksize -1 10 -1 10
		#
		set myuse=(rhob>9.7E11 && rhob<1.2E12) ? 1 : 0
		#set myuse=(rhob>1E4 && rhob<3E4) ? 1 : 0
		set mytempk=tempk if(myuse)
		set myetae=etae if(myuse)
		#
		ctype default
		#
		#limits (LG(tempk)) (LG(etae))
		limits (LG(tempk)) -15 15
		erase
		box
		xla "T"
		yla "\eta_e"
		ctype default points (LG(mytempk)) (LG(myetae))
		#
checkhelmetae 0 #
		checkrdhelm
		#erase
		#
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myetae=etae if(myuse)
		#
		#limits (LG(myrhob)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		ctype blue points (LG(myrhob)) (LG(myetae))
		#
checkhelmetae2 0 #
		checkrdhelm
		#erase
		#
		set myuse=(rhob>9.7E11 && rhob<1.2E12) ? 1 : 0
		#set myuse=(rhob>1E4 && rhob<3E4) ? 1 : 0
		set mytempk=tempk if(myuse)
		set myetae=etae if(myuse)
		#
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		ctype blue points (LG(mytempk)) (LG(myetae))
		#
overlayetaes 2  #
		#
		checketaenew0 $1 $2
		checkmyetae $1 $2
		#
		#
checkmyetae 2 #
		set oldmyetae=myetae
		#
		#erase
		#
		#
		#set myuse=(tempk<TEMPLIMIT) ? 1 : 0
 		if($1==0){\
		       # pick density point
		       set myuse=(mm==$2) ? 1 : 0
		    }
 		if($1==1){\
		       # pick temp point
		       set myuse=(nn==$2) ? 1 : 0
		    }
		set myrhob=rhob if(myuse)
		set mytempk=tempk if(myuse)
		#
		if($1==0){\
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		#ctype red points (LG(myrhob)) (LG(myetae))
		#
		# works for rhob=1E12
		#set myfitetae=10**6.66764*(tempk/10**5.01258)**(-1)
		# works for rhob=2E4
		#set myfitetae=10**6.66764*(2.2/.03*tempk/10**5.01258)**(-1)
		computefitetae
		computemyetae
		#
		ctype green points (LG(mytempk)) (LG(myfitetaechop))
		ctype blue points (LG(mytempk)) (LG(mycomputedetae))
		#
		}
		#
		if($1==1){\
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		#ctype red points (LG(myrhob)) (LG(myetae))
		#
		# works for rhob=1E12
		#set myfitetae=10**6.66764*(tempk/10**5.01258)**(-1)
		# works for rhob=2E4
		#set myfitetae=10**6.66764*(2.2/.03*tempk/10**5.01258)**(-1)
		computefitetae
		computemyetae
		#
		ctype green points (LG(myrhob)) (LG(myfitetaechop))
		ctype blue points (LG(myrhob)) (LG(mycomputedetae))
		#
		set np=myrhob/mp
		set km02fit=(3*pi**2*np)**(1/3)*hbar*c/(kb*mytempk)
		ctype cyan points (LG(myrhob)) (LG(km02fit))
		#
		set np=myrhob/mp
		set km02fit=(3*pi**2*np)**(1/3)*hbar*c/(kb*mytempk)
		ctype magenta points (LG(myrhob)) (LG(km02fit))
		#
		}
		#set rat=oldmyetae/myetae
		#
plotrat 0       #
		ctype default
		pl 0 mytempk rat 1000
		#
computefitetae 0  #
		set myn = (LG(4.5)-LG(2.2/.03))/(10.2039-6.5629)
		#set myA = (rhob<10**6.5629) ? 2.2/.03 : (rhob>10**10.2039) ? 1.0 : 2.2/.03*(rhob/10**6.5629)**myn
		set myA = (rhob<10**6.5629) ? 2.2/.03 : 2.2/.03*(rhob/10**6.5629)**myn
		set myfitetae=10**6.66764*(myA*tempk/10**5.01258)**(-1)
		#
		set myfitetaechop=myfitetae if(myuse)
		#
computemyetae 0        #
		#set T=tempk*2.2
		set T=tempk
		#set T=tempk*.03
		set E=exp(1.0)
		#
		set rhosick=rhob
		set A=1.9892646415649775e7
		set B=5.00266040170966e9
		set log1=B/T + LN(A*rhosick**(1/3)/T)
		#set log1=(log1>1E-30) ? log1 : 1E-30
		#
		#set log2 = LN((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)
		set log2=B/T + LN(rhosick**(1/3)/T)
		#
		#set computedetae=(3.*log1**4 - \
		#    3.*(15.805860694551079 + log2)*(1. + log1**2)*LN(log1) + \
		#    (20.70879104182662 + 1.5*log4)* LN(log1)**2 + \
		#    LN(log1)**3)/ \
		#    log1**3
		#
		#   
		#
		set computedetae=3.*log1 - (47.41758208365324*LN(log1))/log1**3 - (47.41758208365324*LN(log1))/log1 - \
		 (3.*log2*LN(log1))/log1**3 - (3.*log2*LN(log1))/log1 + (20.70879104182662*LN(log1)**2)/log1**3 + \
		 (1.5*log2*LN(log1)**2)/log1**3 + (1.*LN(log1)**3)/log1**3
		 #
		#
		#  
		#
		# (3.*Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**4 - 
		#-    3.*(15.805860694551079 + Log((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))*
		#-     (1. + Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**2)*
		#-     Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)) + 
		#-    (20.70879104182662 + 1.5*Log((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))*
		#-     Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))**2 + 
		#-    1.*Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))**3)/
		#-  Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**3
		#
		set mycomputedetae=computedetae if(myuse)
		#
plotdegenoverlay 0 #
		# PWF99 with my Y_e
		set udegenpwf99myye=3.0*K*(rhob*yefit)**(1/3)*rhob
		# apparently what HELM EOS gives
		set udegenhelm=1.6*K*(rhob*yefit)**(1/3)*rhob
		# pure PWF99
		set udegenpurepwf99=3.0*K*(rhob*0.5)**(1/3)*rhob
		#
		#ctype cyan points (LG(rhob)) (LG(udegenpwf99myye))
		ctype green points (LG(rhob)) (LG(udegenhelm))
		#ctype magenta points (LG(rhob)) (LG(udegenpurepwf99))
		#
		#
checkhelmcs0  0 #
		redohelmmono
		# HELM's output
		ctype default pl 0 tempk cs2helm 1100
		# MY OUTPUT (should be same if rhob,T,utot,ptot same)
		ctype red pl 0 tempk cs2rhoT 1110
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
		#
		#
		#
		#
		#
		#
		# REMAINING MACROS ARE FOR FINAL TABLES for F(U/P/CHI)
		#
		#
checkeossimplenew 0
		#jre kaz.m
		#cd ~/research/kazeos/run.200sq.1e15tdyn.1em15hcm/
		#rdjoneos eossimplenew.dat
		#
		# new format of eosnew.dat
		#cd ~/research/kazeos/allfixed_200sq_new/
		#cd ~/research/kazeos/4848163.allfixed.new/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
                #cd /u1/ki/jmckinne/research/helm/200x200x1x50/
                #cd /u1/ki/jmckinne/research/helm/100x50x20x50/
                cd /u1/ki/jmckinne/research/helm/200x200x1x50x1/
		rdjoneos eosnew.dat
		rdjondegeneos eosdegennew.dat
		#
		set myuse=(sm==115 && sn==105 && so==0 && sp==0) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myie=utotdiff if(myuse)
		set mypofu=pofu if(myuse)
		#print {myrhob myie mypofu}
		#
		#
                setupplc nrhob nutotout ntdynorye rhob utotdiff tdynorye
                #
                #
                #
                set i=0,dimen(rhob)-1,1
		#
		set tti = i%$nx
		set ttj = int(i/$nx)
                set ttk=INT(i/($nx*$ny))
                set ttl=INT(i/($nx*$ny*$nz))
                #
		set myuse = (sp==46 && so==10) ? 1 : 0
                set mytemp=tkofU if(myuse)
		set myu=uofutotdiff if(myuse)
		set myutotoffset=utotoffset if(sdo==10 && sdp==46)
		set mysdm=sdm if(sdo==10 && sdp==46)
		#
		#
                #
                #
checkcs0 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "T"
		define x2label "c_s^2/c^2"
		ctype default pl 0 tkofU (cs2cgs/c**2) 1001 1 1E13 -0.1 1.0
		ctype cyan pl 0 tkofU (3.1/3.0-1.0+tkofU*0) 1010
		ctype red pl 0 tkofU (4.0/3.0-1.0+tkofU*0) 1010
		ctype blue pl 0 tkofU (5.0/3.0-1.0+tkofU*0) 1010
		#
checkcs1 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "\rho_b"
		define x2label "c_s^2/c^2"
		ctype default pl 0 rhob (cs2cgs/c**2) 1001 1E2 1E15 -0.1 1.0
		ctype cyan pl 0 rhob (3.1/3.0-1.0+rhob*0) 1010
		ctype red pl 0 rhob (4.0/3.0-1.0+rhob*0) 1010
		ctype blue pl 0 rhob (5.0/3.0-1.0+rhob*0) 1010
		#
		#
checkcs2 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "T"
		define x2label "c_s^2/c^2"
		ctype default pl 0 tkofU dpofchidchi 1000
		set gam=3.1
		set myfun=(gam-1)/gam
		ctype cyan pl 0 tkofU (myfun+tkofU*0) 1010
		set gam=4.0/3.0
		set myfun=(gam-1)/gam
		ctype red pl 0 tkofU (myfun+tkofU*0) 1010
		set gam=5.0/3.0
		set myfun=(gam-1)/gam
		ctype blue pl 0 tkofU (myfun+tkofU*0) 1010
		#
checkcs3 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "\rho_b"
		define x2label "c_s^2/c^2"
		ctype default pl 0 rhob dpofchidchi 1000
		set gam=3.1
		set myfun=(gam-1)/gam
		ctype cyan pl 0 rhob (myfun+rhob*0) 1010
		set gam=4.0/3.0
		set myfun=(gam-1)/gam
		ctype red pl 0 rhob (myfun+rhob*0) 1010
		set gam=5.0/3.0
		set myfun=(gam-1)/gam
		ctype blue pl 0 rhob (myfun+rhob*0) 1010
		#
checknewdiff1 0 #
		ctype default pl 0 utotdiff pofu 1100
		ctype red pl 0 ptotdiff uofp 1110
		ctype blue pl 0 chidiff pofchi 1110
		#
checknewdiff2 0  #
		#
		define x1label "rhob"
		define x2label "utotdiff & utotoffset"
		ctype default pl 0 rhob utotdiff 1100
		ctype blue pl 0 rhobdegen utotoffset 1110
		#
		#
		# notice that utot = utotoffset+utotdiff
		#
		#
		#
checkeossimplenewhelm 0
		jre kaz.m
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq/
                #
                #
                #
                cd /u1/ki/jmckinne/research/helm/200x200x1x50/
                #
		rdjoneos eossimplenew.dat
		rdjondegeneos eosdegennew.dat
		#
		set myuse=(sm==19 && sn==216 && so==0 && sp==0) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myie=ie if(myuse)
		set mypofu=pofu if(myuse)
		#print {myrhob myie mypofu}
		#
		# not a bad value for the interpolation to use
		# 3.255e+09   6.143e+27   2.048e+27
checkbadtemp 0  #
		#
		erase
		set myx=(LG(rhob))
		set myy=(LG(ABS(tkofU)+1E-20))
		limits myx myy
		box
		points myx myy
		#
checkPvsTk   0  #
		erase
		xla "P(U)"
		yla "T[K]"
		set myx=(LG(pofu))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 15 38 1 13
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		#
checkUvsTk   0  #
		erase
		xla "ie"
		yla "T[K]"
		set myx=(LG(ie))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 15 38 1 13
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		#
checkrhobvsTk   0  #
		erase
		ctype default
		xla "\rho"
		yla "T[K]"
		set myx=(LG(rhob))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 2 14 1 14
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		ctype red
		lweight 5
		# rhob
		set myboxx={1E9 1E9 1E12 1E12 1E9}
		# Tk
		set myboxy={1E8 1E11 1E11 1E8 1E8}
		connect (LG(myboxx)) (LG(myboxy))
		lweight 3
		#
		#
		set dlrho = (15-2)/200
		set dlrho2 = (12-8)/50
		print {dlrho dlrho2}
		#
                #
		#
showpressure  2 #
		# show pressures for kaz or helm EOS
		# before processing by eos_extract.m
		#
		# 0=KAZ 1=HELM
		define whicheos $1
		# 0=no mono  1=mono
		define whichmono $2
		#
		#
		# HELM:
		if($whicheos==1){\
		       if($whichmono){ checkrdhelmmono}
		       if($whichmono==0){ checkrdhelm }
		       set temp=tempk
		    }
		#
		# KAZ:
		if($whicheos==0){\
		       if($whichmono){ checkrdkazmono}
		       if($whichmono==0){ checkrdkaz }
		       set temp=tempk
		    }
		#
		#ctype default pl 0 temp ptot 1100
                #
                setupplc nrhob ntk ntdynorye rhob tempk tdynorye
                #
simpleread 0    #
		#
		#
		cd ~/research/helm/200x200x1x50/
		rdmykazeos eos.dat
		#
		setupplc nrhob ntk ntdynorye rhob tempk tdynorye
                #
                setgrbconsts
		#
		#
setupplc 6      #              
		#
		#
		define nx ($1)
		define ny ($2)
		define nz ($3)
		#
		set _n1=$nx
		set _n2=$ny
		set _n3=$nz
		#
		#
		set i=0,$nx*$ny*$nz-1,1
		#
		set ti = i%$nx
		set tj = int(i/$nx)
                set tk=INT(i/($nx*$ny))
                set tl=INT(i/($nx*$ny*$nz))
		#set tk=(i+1)/(i+1)-1
		#
		set tx1=$4
		set tx2=$5
		set tx3=$6
		#
		#
		set i=ti
		set j=tj
		set k=tk
		#
		#
		set x12=tx1
		set x1=x12
		set dx1=1.0+0.0*x1
		set dx12=dx1
		#
		#
		set x22=tx2
		set x2=x22
		set dx2=dx1
		set dx22=dx2
		#
		set x3=tx3
		set x32=x3
		set dx3=dx1*0
		set dx32=dx3
		#
		define Sx (x1[0])
		define Sy (x2[0])
		define Sz (x3[0])
		define dx (1)
		define dy (1)
		define dz (1)
		define Lx (x1[$nx*$ny*$nz-1]-x1[0])
		define Ly (x2[$nx*$ny*$nz-1]-x2[0])
		define Lz (x3[$nx*$ny*$nz-1]-x3[0])
		define ncpux1 1
		define ncpux2 1
		define ncpux3 1
		define interp (0)
		define coord (3)
                define PLANE 3
                define WHICHLEV 0
		define x1label "\rho_b"
		define x2label "T[K]"
		#
		set _startx1=$Sx
		set _startx2=$Sy
		set _startx3=$Sz
		set _dx1=$dx
		set _dx2=$dy
		set _dx3=$dz
		set _realnstep=0
		set _gam=0
		set _a=0
		set _R0=0
		set _Rin=0
		set _Rout=1
		set _hslope=1
		set _dt=1
		set _defcoord=0
		#
		!mkdir dumps
		#
		#
		define LOGTYPE 2
		#
		#
		# $missing_data
		# NaN
		#
		#    p_photon p_eleposi p_N p_nu
		#    rho_photon rho_eleposi rho_N rho_nu
                #    s_photon s_eleposi s_N s_nu
		#
		# FOR HELM:
		#    pcou ucou sdencou
		#
pleos2dp 0    #
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		set fracbase=0.4
		set basefun=abs(ptot)
		set mybad=sqrt(-1)+basefun*0
                #
		set whichfun=p_photon
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set whichfun=abs(p_eleposi)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
                # (full ion+coul part)
		set whichfun=abs(p_N)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set whichfun=abs(p_nu)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		if(0 && $whicheos==1){\
		set whichfun=abs(pcou)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		}
		#
		#
pleos2du 0    #
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		set fracbase=0.4
		set basefun=abs(utot)
		set mybad=sqrt(-1)+basefun*0
		set whichfun=abs(rho_photon)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set whichfun=abs(rho_eleposi)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
                # full ion+coul part
                set whichfun=abs(rho_N-rhob*c*c)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set whichfun=abs(rho_nu)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		if(0 && $whicheos==1){\
		set whichfun=abs(ucou)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		}
		#
		#
pleos2ds 0    #
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		#
		set fracbase=0.4
                set basefun=stot
                #
		set mybad=sqrt(-1)+basefun*0
		set whichfun=s_photon
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 mylgfun
		#
		set whichfun=s_eleposi
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR magenta
		plc 0 mylgfun 010
		#
		# full nucleon part (ion+coulomb)
		set whichfun=s_N
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		plc 0 mylgfun 010
		#
		set whichfun=s_nu
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR yellow
		plc 0 mylgfun 010
		#
		if(0 && $whicheos==1){\
		set whichfun=scou
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 mylgfun 010
		}
		#
plcs2helm 0      #
		# how the hell is this so smooth if stot is so erratic?
		# dimensionless
		plc 0 cs2helm
		#
		#

pleos2dconv 0    #
		#
		fdraft
		#
		set funplot=LG(rhob)
		set mybad=sqrt(-1)+funplot*0
		set funplot2=LG(temp)
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		#
		set convvalue=1
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set convvalue=0
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-1
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-2
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-3
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-4
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-10
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		define cres 250
		plc 0 mylgfun 010
		define cres 50
		#
		set convvalue=-11
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-12
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-13
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-100
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-200
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-500
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		#
		# To compare my LS accurat.eps plot with Lat wrapper
		#
		# eos.dat
		# rhob, tempk
		# 26770      1.096985797892386E+13      1.035321843295664E+10
		#
		# eosazbar.dat:
		#abar, zbar
		#4.002337469845328E+00      1.145490890024282E+00
		# implies ye=zbar/abar =
		# 0.2862
		#
		# feed to lat wrap:
		# 0.2862 1.035321843295664E+10 1.096985797892386E+13
		#
		## from wrap:
		#abar =  9.0242E+01  zbar =  2.5827E+01
		#
		#
shownpratio 0   #
		showpressure 0 0
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 npratio
		#
		cd ~/research/kazeos/allfixed_200sq_new/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 npratio 010
		#
shownpratio1 0  #
		showpressure 0 0
		showpressure 1 0
		pleos2dconv
		#
		# now overlay npratio
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		#
		set rho10=rhob/1E10
		set T10=temp/1E10
		set xnuc = 11.3226d0*rho10**(-0.75d0)*T10**1.125d0*exp(-8.20899d0/T10)
		set xnuc=(xnuc>1.0) ? 1.0 : xnuc
		set xnuc=(xnuc<0.0) ? 0.0 : xnuc
		#
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 xnuc 010
		#
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 npratio 010
		#
		# See where Tod Thompson used LSEOS
		set lowT = 10**(-0.8)*ergPmev/kb
		set highT = 10**(1)*ergPmev/kb
		#
		define PLOTWEIGHT 7
		define lweight 7
		set myusex=((temp>lowT)&&(temp<highT)) ? 1 : 0
		set myusey=((rhob>10**6.4)&&(rhob<10**15.1)) ? 1 : 0
		set myrhob=rhob if(myusex&&myusey)
		set mylowT=(lowT+rhob*0) if(myusex&&myusey)
		set myhighT=(highT+rhob*0) if(myusex&&myusey)
		ctype cyan pl 0 myrhob mylowT 1110
		ctype cyan pl 0 myrhob myhighT 1110
		#
		set myx=0,1,1
		set myx=6.4 + myx*1E-5
		set myy=0,1,1
		set myy[0]=LG(lowT)
		set myy[1]=LG(highT)
		connect myx myy
		#
		#
		set myx=0,1,1
		set myx=15.1 + myx*1E-5
		set myy=0,1,1
		set myy[0]=LG(lowT)
		set myy[1]=LG(highT)
		connect myx myy
		#
		defaults
		#
		#
showpcontrib0 0 #
		redohelm
		#redokaz
		#
		set myrho_photon=rho_photon if(nn==0)
		set myrho_eleposi=rho_eleposi if(nn==0)
		set myrho_N=rho_N-rhob*c*c if(nn==0)
		set myrho_nu=rho_nu if(nn==0)
		set myrhob=rhob if(nn==0)
		#
		erase
		ctype default box
		#
		fdraft
		define PLOTWEIGHT 5
		ctype default pl 0 myrhob myrho_photon 1110
		ctype red pl 0 myrhob myrho_eleposi 1110
		ctype blue pl 0 myrhob myrho_N 1110
		ctype magenta pl 0 myrhob myrho_nu 1110
		define PLOTWEIGHT 3
		#
checkloTrho 0   #
		#
		redokaz
		set myrhob= rhob if(tempk<=1E4)
		set myutot= utot if(tempk<=1E4)
		pl 0 myrhob myutot 1100 
		#
		#
		#
checkne 0       #
		set myxne=xne if(nn==0)
		set myrhob=rhob if(nn==0)
		set myetae=etae if(nn==0)
		set mynp=myrhob/mb/2
		set myzbar=zbar if(nn==0)
		print {myrhob myxne mynp myetae myzbar}
checkrhoele 0   #
		#redokaz
		redohelm
		#
		set god=me*c**2*rhob/mp if(nn==0)
		set myrhob=rhob if(nn==0)
		ctype blue pl 0 myrhob god 1110
		#
		#
checkingders 0  #
		#
		checkeossimplenew
		#       
		dercalc 0 pofchi pofchid
		#
		set myrhob=rhob if(tj==197)    	
		set myrhobcsq=myrhob*c*c
		set mypofchidx=pofchidx if(tj==197)	
		set mydpofchidrho0=dpofchidrho0 if(tj==197)
		set mypofchi=pofchi if(tj==197) 
		#
		der myrhobcsq mypofchi dmyrhob dmypofchidrhobcsq
		#
		#
		ctype default pl 0 myrhob mydpofchidrho0 1100 
		ctype red pl 0 myrhob (1/4+myrhob*0) 1110  
		ctype blue pl 0 myrhob dmypofchidrhobcsq 1110
		ctype cyan pl 0 myrhob (mypofchi/myrhobcsq) 1110
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
		#
