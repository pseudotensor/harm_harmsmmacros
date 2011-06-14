getmacros 0     #
		gogrmhd
		jre mri.m
		jre gtwodmaps2.m
		#
dothick1 0      #
		#
		#
		jrdpcf3duentropy dump0000
		#jrdpcf3duentropy dump0096
		#jrdpcf3duentropy dump0170
		#
		# bin2txt 1 2 0 -1 3 136 64 128 1 gdump.bin gdump d 126
		# 
		#
		#grid3d gdump
                grid3ddxdxp gdump
                set dxdxp1=dxdxp11
                set dxdxp2=dxdxp22
                set dxdxp3=dxdxp33
		#
		mricalc
		fieldcalc 0 aphi
		set H=r*cos(h)
		set R=r*sin(h)
		set HoR=H/R
		#
		plc 0 (rho-1)
		#plc 0 aphi 010
		plc 0 ibeta 010
		plc0 0 (HoR-1) 010
		#
		#
		plc 0 (rho-1)
		plc 0 idx2mri 010
		plc0 0 (HoR-1) 010
		#
                # how many wavelengths inside the disk
                # \gtrsim 1 (was 3 with old omegamax) for thickdisk1
                set hor=cs/(r*uu3*dxdxp33)
                set hdisk=hor*r
		plc 0 (rho-1)
		plc 0 idx2mri 010
		plc0 0 (HoR-1) 010
		plc 0 (hdisk/lambda2max) 010
                #
		plc 0 (rho-1)
		plc 0 (sqrt(cs2)/(R*omegak)) 010
		#
		#
		#
		set cour=0.4999
		set dt1p=(abs($dx1/(v1p/cour)))
		set dt1m=(abs($dx1/(v1m/cour)))
		set dt2p=(abs($dx2/(v2p/cour)))
		set dt2m=(abs($dx2/(v2m/cour)))
		set dt3p=(abs($dx3/(v3p/cour)))
		set dt3m=(abs($dx3/(v3m/cour)))
		#
		plc 0 dt1m
		#
betanoble 0     #
		#
		set rhocut=0.25
		#set rhocut=0.2
		#
		set use=(rho>rhocut && r<100 ? 1 : 0)
		#
		set god1=p*gdet if(use)
		set god2=gdet if(use)
		set pgavg=SUM(god1)/SUM(god2)
		#
		set god1=(bsq/2.0)*gdet if(use)
		set god2=gdet if(use)
		set pbavg=SUM(god1)/SUM(god2)
		#
		set betanoble=pgavg/pbavg
		#
		set god1=gdet*(p/(bsq/2)) if(use)
		set god2=gdet if(use)
		set betaavg=SUM(god1)/SUM(god2)
		#
		set god1=gdet*ibeta if(use)
		set god2=gdet if(use)
		set ibetaavg=SUM(god1)/SUM(god2)
		set betaavg2=1/ibetaavg
		#
		#
		print {betanoble betaavg betaavg2}
		#
		# for current setup, so good!
		# minbeta=10
		# betanoble=46
		# betaavg=180
		# betaavg2=46
		#
		#
myoverlay1 0     #		
		# bin2txt 1 2 0 -1 3 136 64 128 1 dump0000.bin dump0000 d 73
		#
		# jrdpcf3duentropy dump0000
		# jrdpcf3duentropy dump0080
		# jrdpcf3duentropy dump0160
		#
		overlayprobe
		#
probestuff1 0    #
		# use mergeprobe.sh
		#
		jrdpheader3d dumps/dump0000
		#
		#
		rdprobe probe.dat.grmhd.0016
		pickprobe 16 32 0 0
		#
		pl 0 prt pr
		#
		showfft 16 32 0 0  1 0.25 1
		#
		set dimenit=dimen(prt)
		print {dimenit}
		#
		#
		#
		set ratio=dimenit/64
		print {ratio}
		#
		sonogram 64
		showsonogram sonogrampow 64
		#
		#
showfftpr1 1    #		
		pickprobe 16 34 0 $1
		set mypr1=(pr < 0 ? -1 : 1)
		set mypr2=pr**2
		showfftlim mypr2 2100 6513
		#
showfftpr2 4    #		
		pickprobe $1 $2 $3 $4
		showfftlim pr 2100 6513
		#
showfftpr3 4    #		
		pickprobe $1 $2 $3 $4
		set mypr2=pr**2
		showfftlim mypr2 2100 6513
		#
foundqpos0  0   #
		showfftpr2 0 32 0 7
		showfftpr2 0 34 0 7
		showfftpr2 0 36 0 7
		showfftpr2 0 38 0 7
		#
		# matches yellow and green lines:
		showfftpr2 8 36 0 7
		#
		#
		#maybe at risco:
		showfftpr2 24 32 0 0
		#
eners1 0        #
		# use mergeeners.sh
		# clean nan's and inf's out
		#
		jrdp3dener
		#
		#
		jrdp3denergen enerother4.out -1E30 1E30
		#
qpointime1 0     #
		set prt=t
		showfftlim u0dot3 0 6500
		#
		# hard to notice, but there in time plot
		pl 0 t u0dot3
		set god=6810.75-6107.3 print {god}
		set frat=1/god/fradius print {frat}
		set fs=1/god/tlunit print {fs}
		#
		# 21Hz for GRS1915+105
		#
		# but, u0dot3 all screwed up like u0dot1?
		#
		pl 0 t u0dot4
		set prt=t
		showfftlim u0dot4 0 6500
		#
		set god=9756.55-6218.95 print {god}
		set fs=1/god/tlunit print {fs}
		#
		# 4Hz for GRS1915+105
