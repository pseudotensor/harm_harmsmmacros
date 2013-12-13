domri 0         #
		mricalc
		mrichecks1
		#mrichecks2 0.05
		mrichecks3
		#mripower
		histogrammri
		#
		#
mricalc 0               #
		# number of wavelengths per zone
		#
		# after doing gammiegridnew2 gdump
        # no, now after grid3d
		#
		#
		set mydr=dxdxp1*$dx1
		set mydH=r*dxdxp2*$dx2
		set mydP=r*sin(h)*dxdxp33*$dx3
		set dxrat=mydr/mydH
		set dxrat=mydr/mydP
		#
                set omegarot=uu3/uu0*dxdxp33
                # gammie, but may not be good:
		#set omegamax=3*sqrt(3)/2/pi*ABS(omegarot)
                # as in Noble and Penna
		set omegamax=ABS(omegarot)/(2*pi)
                #
		set taumax=2*pi/omegamax
		#
		set lambdamax=sqrt(val2)/omegamax
                set WW = rho + u + p
                set EF = bsq + WW
                set val21 = abs(bu1*bd1)/EF
                set val22 = abs(bu2*bd2)/EF
                set val23 = abs(bu3*bd3)/EF
		set lambda1max=sqrt(val21)/omegamax
		set lambda2max=sqrt(val22)/omegamax
		set lambda3max=sqrt(val23)/omegamax
		#
		set dx1mri=mydr/lambda1max
		set dx2mri=mydH/lambda2max
		set dx3mri=mydP/lambda3max
		set dx1fakemri=mydr/lambdamax
		set dx2fakemri=mydH/lambdamax
		set dx3fakemri=mydP/lambdamax
		#
		# number of zones per wavelength
		set idx1mri=1/dx1mri
                # so in the end, with new version get:
                # idx2mri = lambda2max/mydH = valh*2*pi/omegarot
                # idx2mri = lambda2max/mydH = sqrt(val22)*2*pi/omegarot/mydH 
        set idx2mrialt = sqrt(val22)*2*pi/omegarot/mydH
        set idx2mrialtcut = (idx2mrialt>30 ? 30 : idx2mrialt)
        #
		set idx2mri=1/dx2mri
		set idx3mri=1/dx3mri
		set idx1fakemri=1/dx1fakemri
		set idx2fakemri=1/dx2fakemri
		set idx3fakemri=1/dx3fakemri
		#
		# don't weight if not in range
		#
		# set h=_hslope
		#set myidx1mri=idx1mri if((r>1.1*risco)&&(r<0.9*Rout)&&(abs(h-pi/2)<$1))
		#set myidx2mri=idx2mri if((r>1.1*risco)&&(r<0.9*bRout)&&(abs(h-pi/2)<$1))
		#
		# don't weight the zones with rho<1E-2, so give them the average value
		#
		set use=(rho>1E-2) ? 1 : 0
		set myidx1mri=idx1mri if(use)
		set myidx2mri=idx2mri if(use)
		set myrho=rho if(use)
		#
		#
		#
mricalc2 0               #
		# number of wavelengths per zone
		set mydr=dx12
		set mydH=x12*dx22
		set dxrat=mydr/mydH
		#
		# for Kerr metric (see Gammie 2004)
		#
		set Dc=1-2/r+(a/r)**2
		set Cc=1-3/r+2*a*r**(-3/2)
		set omegamax=sqrt(9/16/r**3*(Dc/Cc)**2)
		set taumax=2*pi/omegamax
		set lambdamax=sqrt(val2)/omegamax
		#
		set dx1mri=mydr/lambdamax
		set dx2mri=mydH/lambdamax
		# number of zones per wavelength
		set idx1mri=1/dx1mri
		set idx2mri=1/dx2mri
		#
		#
mripower 0      ## should be done on late time data
		#
		# device postencap mripower.eps
		define x2label "Normalized Power"
		define x1label "number of grid zones"
		set myb2=B2 if((tx1>1.1)&&(tx2==tx2[$nx*$ny/2]))
		set myti=ti if((tx1>1.1)&&(tx2==tx2[$nx*$ny/2]))
		fftreal 1 myti myb2 freq pow		
		set rfreq=freq if(freq>0)
		set rpow0=pow if(freq>0)
		set numzones=1/rfreq
		set trpow=SUM(rpow0/dimen(myb2))
		set rpow=rpow0/trpow
		#
		ctype default pl 0 numzones rpow 1100
		smooth rpow srpow 10
		ctype red pl 0 numzones srpow 1110
		set it=10**(0.6)*(6/numzones)**(-7.66)
		ctype blue pl 0 numzones it 1110
		#
		# device X11
		# !scp mripower.eps metric:research/thindisk/
		#
		#
mrichecks1 0            #
		# assume already loaded dump
		#jrdp dump0000
		#gammienew
		jrdpener 500 2000
		set mass=SUM(dV*gdet*rho)
		set newt=t if(dm<0)
		set ldm=LG(ABS(-dm/mass)) if(dm<0)
histogrammri  0 #
		define x1label "number of zones/wavelength"
		define x2label "Number per bin"
		sort { myidx1mri }
		sort { myidx2mri }
		set mybins=0,15,.1
		set it=HISTOGRAM(myidx1mri:mybins)
		set avg=SUM(myidx1mri)/dimen(myidx1mri)
		ctype default pl 0 mybins it
		ctype red vertline avg
		#
		set it2=HISTOGRAM(myidx2mri:mybins)
		set avg2=SUM(myidx2mri)/dimen(myidx2mri)
		ctype cyan plo 0 mybins it2
		ctype blue vertline avg2
		print {avg avg2}
		#
histozones  1 #
		define x1label "Ratio of dxr/(r*dxh)"
		define x2label "Number per bin"
		set mydxrat=dxrat if((r>1.1*risco)&&(r<0.9*Rout)&&(abs(h-pi/2)<$1))
		sort { mydxrat }
		set mybins=0,15,.01
		set it=HISTOGRAM(mydxrat:mybins)
		set avg=SUM(mydxrat)/dimen(mydxrat)
		ctype default pl 0 mybins it
		ctype red vertline avg
		print {avg}
		#
histo  1 #
		# after plotting using contour plot, do:
		# histo 0.05 ibeta
		#
		define x1label "Value"
		define x2label "Number per bin"
		set myval=$1
		sort { myval }
		set mybins=$min,$max,$delta
		set it=HISTOGRAM(myval:mybins)
		set avg=SUM(myval)/dimen(myval)
		ctype default pl 0 mybins it
		ctype red vertline avg
		print {avg}
		#
mrichecks2 1    # requires mrichecks1
		mricalc
		set horplus=pi/2+$1
		set horminus=pi/2-$1
		set bRout=0.9*Rout
		plc 0 idx1mri 0001 7 9 horminus horplus
		plc 0 idx1mri 0001 bRout Rout horminus horplus
		plc 0 idx1mri 0001 7 Rout horminus horplus
		plc 0 idx2mri 0001 7 9 horminus horplus
		plc 0 idx2mri 0001 bRout Rout horminus horplus
		plc 0 idx2mri 0001 7 Rout horminus horplus
		joncalc3 2 2 7 9 $1 idx1mri inneridx1mri
		joncalc3 2 2 7 9 $1 idx2mri inneridx2mri
		joncalc3 2 2 bRout Rout $1 idx1mri outeridx1mri
		joncalc3 2 2 bRout Rout $1 idx2mri outeridx2mri
		joncalc3 2 2 7 Rout $1 idx1mri avgidx1mri
		joncalc3 2 2 7 Rout $1 idx2mri avgidx2mri
		#
		set rat=mydr/mydH
		plc 0 rat 0001 7 9 horminus horplus
		plc 0 rat 0001 bRout Rout horminus horplus
		plc 0 rat 0001 7 Rout horminus horplus
		joncalc3 2 2 7 9 $1 rat innerrat
		joncalc3 2 2 bRout Rout $1 rat outerrat
		joncalc3 2 2 7 Rout $1 rat avgrat
		#
		# high field limit
		#
		set ldh=mydH if((h>pi/2-.05)&&(h<pi/2+.05)&&(ti==0))
		set numldh=dimen(ldh)
		set avgldh=SUM(ldh)/numldh
		#
		set ldr=mydr if((r>risco)&&(r<Rout)&&(tj==0))
		set numldr=dimen(ldr)
		set avgldr=SUM(ldr)/numldr
		#
		set hflimitdx1=(Rout-risco)/avgldr
		set hflimitdx2=$1/avgldh
		#
		# field to high when hffun>1
		set hffun=idx2mri*dx22/($1)
		joncalc3 2 2 7 9 $1 hffun innerhf
		joncalc3 2 2 bRout Rout $1 hffun outerhf
		joncalc3 2 2 7 Rout $1 hffun avghf
		#
		print mri.txt '%5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g %5.2g\n' {inneridx1mri outeridx1mri avgidx1mri inneridx2mri outeridx2mri avgidx2mri innerrat outerrat avgrat hflimitdx1 hflimitdx2 innerhf outerhf avghf}
		#!scp mri.txt metric:
		#
mrichecks2vst 3 # mrichecks2vst .05 0 40
		set numstart=$2
                set numend=$3
                set numtotal=numend-numstart+1
		set h1='dump'
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  mrichecks2 $1
		  print + mrivst.txt '%10g %10g %10g %10g %10g %10g %10g %10g %10g %10g %10g %10g %10g %10g %10g\n' {_t inneridx1mri outeridx1mri avgidx1mri inneridx2mri outeridx2mri avgidx2mri innerrat outerrat avgrat hflimitdx1 hflimitdx2 innerhf outerhf avghf}
		}
		#
mrichecks3   0  # requires mrichecks1
		define x2label "\dot{M}_0"
		define x1label "t c^3/(GM)"
		#
		ctype default pl 0 newt ldm
		set NORM=10**(-3.97)
		set AMP=10**(-4.34)
		set tgrow=112
		set tss=112
		set tdecay=300
		set fit=NORM+AMP*exp(-(newt-tss)/tdecay)
		#ctype red pl 0 newt fit 0110
		#
		set lsqt=t if(t>1500)
		set lsqdm=ABS(-dm/mass) if(t>1500)
		lsq lsqt lsqdm lsqt fitdm rms
		avg lsqt lsqdm avg
		set rmsrat=$rms/avg
		print {rmsrat}
		#
		#
		#
                #
betacheck1 0    #
		plc 0 libeta
		#define max (1)
		#define min (0.0001)
		#define delta (($max-$min)/$cres)
		set myibeta=ibeta if(rho>1E-2)
		set mygdet=gdet if(rho>1E-2)
		set myrho=rho if(rho>1E-2)
		#
		histo myibeta
		set avgbeta1=1/avg print {avgbeta1}
		#
		set avgibeta=SUM(myibeta*mygdet)/SUM(mygdet)
		set avgbeta2=1/avgibeta 
		print {avgbeta2}
		set avgibeta=SUM(myibeta*myrho*mygdet)/SUM(myrho*mygdet)
		set avgbeta3=1/avgibeta
		print {avgbeta3}
		#
mricheck5 0     #
		plc 0 taumax 001 23 25 1.5 1.7
gridcheck1 1    #
		set hinner=(pi/2-$1)
		set houter=(pi/2+$1)
		plc 0 dxrat 001 Rin Rout hinner houter
gridcheck2 1    #
		set hinner=(pi/2-$1)
		set houter=(pi/2+$1)
		ctype default setlimits 10 10.1 0 pi 0 1 plflim 0 x2 r h dxrat 0 010
		ctype red vertline hinner
		ctype red vertline houter
		#
gridcheck3 2   #
		set mydr=dx12
		set newdh=(ABS(h-pi/2))>$1 ? dx22 : dx22[$2*$nx]
		set mydH=x12*newdh
		set dxratnew=mydr/(r*mydH)
		set hinner=(pi/2-$1)
		set houter=(pi/2+$1)
		ctype default setlimits 10 10.1 0 pi 0 1 plflim 0 x2 r h dxratnew 0 010
		ctype red vertline hinner
		ctype red vertline houter
newgridplot 0   #
		# after doing jrdp dump0000 or gammiegridnew gdump
		#
		define x1label "j"
		define x2label "d\theta/dj"
		set sliceh=h if(ti==0)
		set slicej=tj if(ti==0)
		der slicej sliceh dslicej dsliceh
		ctype default pl 0 dslicej dsliceh 0001 0 $ny 0 0.1
		ctype red plo 0 tj dh
newgridplot2 0   #
		# after doing jrdp dump0000 or gammiegridnew gdump
		#
		define x1label "\theta"
		define x2label "d\theta"
		set sliceh=h if(ti==0)
		set slicej=tj if(ti==0)
		der slicej sliceh dslicej dsliceh
		ctype default pl 0 sliceh dsliceh 0001 0 pi 0 0.1
		ctype red plo 0 h dh
		#
		set hor=0.05
		#
		set hinner=(pi/2-hor)
		set houter=(pi/2+hor)
		ctype blue vertline hinner
		ctype blue vertline houter
		#
		set hinner=(pi/2-2*hor)
		set houter=(pi/2+2*hor)
		ctype cyan vertline hinner
		ctype cyan vertline houter
gammiedata 0    #
		print gdata.txt {i j x1 x2 r h dxdxp1 dxdxp2 omega3 rho p bsq
