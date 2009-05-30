                # NOTES:
		#
		# One usually does with new code with entropy and dissipation tracking (e.g.):
		# 1) jrdp3duentropy dump0070
		# 2) rdlumvsr lumvsr.out $nx
		# 3) plc 0 lumvsr (maybe do: define coord 1 )
		# 4) reallumvstvsr
		# The "reallumvstvsr" macro shows L(r,t)
                # 5) doalllumavg timeindexstart timeindexfinish (e.g. doalllumavg 0 2850)
                # This shows true dL/dr (solid  line) and true integrated luminosity L(r) (dashed line)
		#
		#
		#
		#
		#
rdlumvsr 2 # read in dump first
		#
		# rdlumvsr lumvsr.out 1280
		# plc 0 lumvsr
		#
		#jrdp dump0000
		#jrdp2d dump0000
		set oldti=ti
		set oldtj=tj
		set oldx12=x12
		set oldx22=x22
		da $1
		lines 1 100000000
		define outbound ($2+2)
		read {t 1 nstep 2 lumvsr 3-$!!outbound}
                # below are space in radius and time dimensions (not x,y,z)
		define nx ($2)
		define ny (dimen(lumvsr)/$2)
		set i=0,$nx*$ny-1
                set ti=INT(i%$nx)
                set tj=INT((i%($nx*$ny))/$nx)
                #set tk=INT(i/($nx*$ny))
                #
                #set ti = i%$nx
                # set tj = int(i/$nx)
		set tk=(i+1)/(i+1)-1
		 set i=ti
		 set j=tj
		 set k=tk
		 #define nz 1
		 set god0=oldx12 if(oldtj==0)
		 set god=god0
		 do kk=0,$ny-2,1{
		         set god = god CONCAT god0
                      }
                     set x12=god
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
                     define coord (3)
	             define x1label "r c^2/GM"
	             define x2label "t c^3/GM"
pickmap 3      #
     set timepre=t if($1==realnstep)
     define time (timepre[0])
     set steppre=realnstep if(($1==realnstep))
     define nstep (steppre[0])
     
     set $3=$2 if(realnstep==$1)
     #
		#
		#
		##########################################
dopow1 0        # seek Fourier modes
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
		#
		#
lumvsravg 2     # lumvsravg 500 750
		# Get average luminosity over certain time-data-index range: lumavg=<L(t)>
		# 
		# jrdp dump0020
		# rdlumvsr lumvsr.out 1280
		#
		# lumavg.eps
		#
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
                # obtain time derivative of time-integrated luminosity
		dercalc 0 lumvsr lumvsrd
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
 		do jjj=startny,endny,1 {\
		       #
                       # lumnow is dL(r,t)/dx1 (i.e. not properly integrated/differentiated in radius)
                       # Only used to grab single time: L(r,t0)
		       set lumnow=lumvsrdy if(tj==$jjj)
                       # lumavg is \Sum_{t0} L(r,t0)
		       set lumavg=lumavg+lumnow
		}
		#
                # now compute time-averaged luminosity after adding up several times
                # lumavg = \Sum_{t0} L(r,t0) / (# of times (t0's))
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
		#
		#
reallumvstvsr 0	# From \int_t \detg dL(r,t) get \int_{t,r} L(r,t)=lumintvsrvst and then get L(r,t)=lumintvsrvstdxdy
		#
		# jrdp2d dump0000
		# rdlumvsr lumvsr.out 2048
		#
		# lumavg.eps
		#
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
		#
		set lumintvsrvst=lumvsr*0
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
		           #set lumintvsrvst[indexi+indexj*$nx]=lumintvsrvst[(indexi-1)+indexj*$nx]+lumvsr[indexi+indexj*$nx]
		           #}
		           #
		           if($iii==0){ echo $iii $jjj }
		           #
		           if($iii!=0){\
                                       # adds-up in radius ($iii) first.  Simple addition since all covariant terms are in place already
		                  set lumintvsrvst[$iii+$jjj*$nx]=lumintvsrvst[($iii-1)+$jjj*$nx]+lumvsr[$iii+$jjj*$nx]
		                  }
		           if($iii==0){\
		                      set lumintvsrvst[$iii+$jjj*$nx]=lumvsr[$iii+$jjj*$nx]
		                  }
		 }
		}
		#
		#
		dercalc 0 lumintvsrvst lumintvsrvstd
		dercalc 0 lumintvsrvstdx lumintvsrvstdxd
		#
                define LOGTYPE 0
                define coord 1
		plc0 0 lumintvsrvstdxdy
		#
		# final result is in mixed form such that it's d/dt d/dr (time integrated and radially integrated luminosity (r,t))
		#
		#
		#
reallumvsr 0    # take correct sum (Requires lumavg=time-averaged \detg dL from lumvsravg)
                # until reallumvsr is used, not correct radial luminosity
		#
		set lumint=lumavg*0
		#
 		do iii=0,$nx-1,1 {\
		       #
		       do iiii=0,$iii,1 {\
		              #echo $iii $iiii
                                    # lumint = <\int_r \detg dL>_{averaged in time}
		        set lumint[$iii]=lumint[$iii]+lumavg[$iiii]
		    }
		}
		#
                # finally compute real dL/dr that was averaged in time
		der myr lumint dmyr reallumvsr
		#
		#
		###############################
doalllumavg 2   # doalllumavg 0 2850 # plot real dL/dr
		###############################
		#jrdp2d dump0000
		#rdlumvsr lumvsr.out 2048
		#rdlumvsr lumvsr.out 32
		lumvsravg $1 $2
		reallumvsr
		#
		#device postencap lumavg.eps
		define x1label "r c^2/GM"
		define x2label "True dL/dr"
		ltype 0 ctype default pl 0 myr reallumvsr 1101 Rin Rout 1E-9 1
		#device X11
		#
		#
		#device postencap lumint.eps
		define x1label "r c^2/GM"
		define x2label "Integral Luminosity"
		ltype 2 ctype default pl 0 myr lumint 1111 Rin Rout 1E-9 1
		#device X11
		#
		#print lum_r_avg_int.dat {myr reallumvsr lumint}
		#
		# !scp lumavg.eps lumint.eps  lum_r_avg_int.dat jon@relativity:/home/jon/research/papers/thindisk/thindisk_stuff/
		#
                ltype 0
		#
lumvstvsr 0	# lumvsrt.eps # just a simple version of L(r,t) (not correct sum)
		set _n1=$nx
		set _n2=$ny
		set _dx1=1
		set _dx2=2
		dercalc 0 lumvsr lumvsrd
		#
		define x1label "r c^2/GM"
		define x2label "t c^3/GM"
		#
		#
		plc 0 lumvsrdy
		#
		#
lumtotvsr 0 # evsr.eps
		#
		set myr=x12 if(tj==$ny-1)
		set mylumvsr=lumvsr if(tj==$ny-1)
		define x1label "r c^2/GM"
		define x2label "Total Energy"
		ctype default pl 0 myr mylumvsr 1101 Rin Rout 1E-7 0.01
		#
		#
nt1      0      #
		#
		ctype default pl 0 myr mylumvsr 1101 Rin Rout 1E-7 0.1
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
