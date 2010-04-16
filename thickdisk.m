getmacros 0     #
		gogrmhd
		jre mri.m
		#
dothick1 0      #
		#
		#
		jrdpcf3duentropy dump0000
		#jrdpcf3duentropy dump0096
		#jrdpcf3duentropy dump0170
		grid3d gdump
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
		set god1=p*gdet if(rho>rhocut)
		set god2=gdet if(rho>rhocut)
		set pgavg=SUM(god1)/SUM(god2)
		#
		set god1=(bsq/2.0)*gdet if(rho>rhocut)
		set god2=gdet if(rho>rhocut)
		set pbavg=SUM(god1)/SUM(god2)
		#
		set betanoble=pgavg/pbavg
		#
		set god1=gdet*(p/(bsq/2)) if(rho>rhocut)
		set god2=gdet if(rho>rhocut)
		set betaavg=SUM(god1)/SUM(god2)
		#
		set god1=gdet*ibeta if(rho>rhocut)
		set god2=gdet if(rho>rhocut)
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
