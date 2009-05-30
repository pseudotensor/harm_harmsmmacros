setupdata 0     #
		jrdp dump0000
		gammienew
		#
		set mydx1=$dx1
		set mydx2=$dx2
		set hor=.05
		set use=((r>2.1)&&(r<40)&&(ABS(h-pi/2)<hor)) ? 1 : 0
		#
		set mytruenx=$nx
		set mytrueny=$ny
		#
		set myi=i if(use)
		set myj=j if(use)
		set mynx=myi[dimen(myi)-1]-myi[0]+1
		set myny=myj[dimen(myj)-1]-myj[0]+1
		#
		set myx1=x1 if(use)
		set myx2=x2 if(use)
		set myr=r if(use)
		set myh=h if(use)
		set mygdet=gdet if(use)
		set mydxdxp1=dxdxp1 if(use)
		set mydxdxp2=dxdxp2 if(use)
		set myomega3=omega3 if(use)
		set myrho=rho if(use)
		set myu=u if(use)
		set myp=p if(use)
		set mybsq=bsq if(use)
writedata 1     #
		#
		define print_noheader (1)
		print $1 {mydx1 mydx2 mynx myny mytruenx mytrueny}
		print + $1 {myi myj myx1 myx2 myr myh mygdet mydxdxp1 mydxdxp2 myomega3 myrho myu myp mybsq}
		#
		#
readdata 1      #
		da $1
		lines 1 2
		read '%g %g %g %g %g %g' {mydx1 mydx2 mynx myny mytruenx mytrueny}
		define dx1 (mydx1)
		define dx2 (mydx2)
		define nx (mynx)
		define ny (myny)
		define n1 (mynx)
		define n2 (myny)
		#
		# gammienew (jon's stuff for setting up plotting)
		#
		lines 2 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g' {i j x1 x2 r h gdet dxdxp1 dxdxp2 omega3 rho u p bsq}
		#
		set WW = rho + u + p
                set EF = bsq + WW
		set val2=bsq/EF
		#
new2oldgrid 0   #
		set dxdxp1=dxdxp11
		set dxdxp2=dxdxp22
mricalc 0       #
		# number of wavelengths per zone
		#
		set mydr=dxdxp1*$dx1
		set mydH=r*dxdxp2*$dx2
		set dxrat=mydr/mydH
		#
		set omegamax=3*sqrt(3)/2/pi*ABS(omega3)
		set taumax=2*pi/omegamax
		#
		set lambdamax=sqrt(val2)/omegamax
		#
		set dx1mri=mydr/lambdamax
		set dx2mri=mydH/lambdamax
		#
		# number of zones per wavelength
		set idx1mri=1/dx1mri
		set idx2mri=1/dx2mri
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
mricalc2 0      #
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
histogrammri  0 #
		define x1label "number of zones/wavelength"
		define x2label "Number per bin"
		sort { myidx1mri }
		sort { myidx2mri }
		set mybins=0,15,.1
		set it=HISTOGRAM(myidx1mri:mybins)
		set avg=SUM(myidx1mri)/dimen(myidx1mri)
		#
		erase
		limits mybins it
		ctype default box		
		ctype default connect mybins it
		ctype red vertline avg
		#
		set it2=HISTOGRAM(myidx2mri:mybins)
		set avg2=SUM(myidx2mri)/dimen(myidx2mri)
		ctype cyan connect mybins it2
		ctype blue vertline avg2
		print {avg avg2}
		#
histozones  0 #
		set hor=0.05
		define x1label "Ratio of dxr/(r*dxh)"
		define x2label "Number per bin"
		set mydxrat=dxrat
		sort { mydxrat }
		set mybins=0,15,.01
		set it=HISTOGRAM(mydxrat:mybins)
		set avg=SUM(mydxrat)/dimen(mydxrat)
		#
		erase
		limits mybins it
		ctype default box		
		ctype default connect mybins it
		#
		ctype red vertline avg
		print {avg}
		#
vertline  1     #
                set myx=0,1,1
                set myx=$1+myx*1E-5
                set myy=0,1,1
                set myy[0]=-1000
                set myy[1]=1000
                connect myx myy
