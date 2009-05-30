coefprint  0    #
		define myi (100)
                define myj (400)
                define loc ($nx*$myj+$myi)
		#
		set god1A=AA[$loc]
		set god1B=BB[$loc]
		set god1C=CC[$loc]
		set god1D=DD[$loc]
		set god1E=EE[$loc]
		print '%21.15g %21.15g %21.15g %21.15g %21.15g\n' {god1A god1B god1C god1D god1E}
		#
		#
		#
fastslowprint 0 #
		#
		set god1=tfastv1m[$loc]
		set god2=tslowv1m[$loc]
		set god3=tslowv1p[$loc]
		set god4=tfastv1p[$loc]
		print '%21.15g %21.15g %21.15g %21.15g\n' {god1 god2 god3 god4}
		#
trueslowfastcoef   0 #
		#
		set va02=bu0**2/EF
		#
		# 1-direction
		#
		set va12=bu1**2/EF
		set va012=bu0*bu1/EF
		#
		#
		set EE=uu1**4 - cms2*uu1**2*(gn311 + uu1**2) + cs2*gn311*va12
		#
		set DD=2*(-2*uu0*uu1**3 + cms2*uu1*(gn311*uu0 + uu1*(gn301 + 2*uu0*uu1)) - cs2*gn311*va012 - cs2*gn301*va12)
		#
		set CC=6*uu0**2*uu1**2 - cms2*(gn311*uu0**2 + uu1*(4*gn301*uu0 + gn300*uu1 + 6*uu0**2*uu1)) + cs2*(4*gn301*va012 + gn311*va02 + gn300*va12)
		#
		set BB=2*(-2*uu0**3*uu1 + cms2*uu0*(gn300*uu1 + uu0*(gn301 + 2*uu0*uu1)) - cs2*gn300*va012 - cs2*gn301*va02)
		#
		set AA=uu0**4 - cms2*uu0**2*(gn300 + uu0**2) + cs2*gn300*va02
		#
		set va22=bu2**2/EF
		set va022=bu0*bu2/EF
		#
		#
		set EE2=uu2**4 - cms2*uu2**2*(gn322 + uu2**2) + cs2*gn322*va22
		#
		set DD2=2*(-2*uu0*uu2**3 + cms2*uu2*(gn322*uu0 + uu2*(gn302 + 2*uu0*uu2)) - cs2*gn322*va022 - cs2*gn302*va22)
		#
		set CC2=6*uu0**2*uu2**2 - cms2*(gn322*uu0**2 + uu2*(4*gn302*uu0 + gn300*uu2 + 6*uu0**2*uu2)) + cs2*(4*gn302*va022 + gn322*va02 + gn300*va22)
		#
		set BB2=2*(-2*uu0**3*uu2 + cms2*uu0*(gn300*uu2 + uu0*(gn302 + 2*uu0*uu2)) - cs2*gn300*va022 - cs2*gn302*va02)
		#
		set AA2=uu0**4 - cms2*uu0**2*(gn300 + uu0**2) + cs2*gn300*va02
		#
		#
		#
		#
		#
trueslowfast   0 #
		trueslowfastcoef
		quarticsol 0 tfastv1p AA BB CC DD EE
		quarticsol 1 tslowv1p AA BB CC DD EE
		quarticsol 2 tslowv1m AA BB CC DD EE
		quarticsol 3 tfastv1m AA BB CC DD EE
		#
		# fix order of ambiguous slow term
		set tslowv1pnew=(tslowv1p>tslowv1m) ? tslowv1p : tslowv1m
		set tslowv1mnew=(tslowv1p>tslowv1m) ? tslowv1m : tslowv1p
		set tslowv1p=tslowv1pnew
		set tslowv1m=tslowv1mnew
		#
		quarticsol 0 tfastv2p AA2 BB2 CC2 DD2 EE2
		quarticsol 1 tslowv2p AA2 BB2 CC2 DD2 EE2
		quarticsol 2 tslowv2m AA2 BB2 CC2 DD2 EE2
		quarticsol 3 tfastv2m AA2 BB2 CC2 DD2 EE2
		#
		# fix order of ambiguous slow term
		set tslowv2pnew=(tslowv2p>tslowv2m) ? tslowv2p : tslowv2m
		set tslowv2mnew=(tslowv2p>tslowv2m) ? tslowv2m : tslowv2p
		set tslowv2p=tslowv2pnew
		set tslowv2m=tslowv2mnew
		#
		#
		#
		#
quarticsol  7   # quarticsol 0 sol0 AA BB CC DD EE
		if($1==3) { set sign1=-1 set sign2=-1 }
		# order for 2,1 is ambiguous
		if($1==2) { set sign1=-1 set sign2=1 }
		if($1==1) { set sign1=1 set sign2=-1 }
		if($1==0) { set sign1=1 set sign2=1 }
		#
		set AAA=$3
		set BBB=$4
		set CCC=$5
		set DDD=$6
		set EEE=$7
		#
		set unit1=2*CCC**3 - 9*BBB*CCC*DDD + 27*AAA*DDD**2 + 27*BBB**2*EEE - 72*AAA*CCC*EEE
		# unit2 is always positive or 0
		set unit2=CCC**2 - 3*BBB*DDD + 12*AAA*EEE
		# unit3 is always negative or 0
		set unit3=-4*unit2**3 + unit1**2
		#
		set newradius=sqrt(unit1**2+ABS(-unit3))
		# ATAN2(y,x) where tan(phi)=y/x
		set newphi=ATAN2(sqrt(-unit3),unit1)
		# unit4 is always positive
		set unit4=(1/(3*AAA))*2**(2/3)*newradius**(1/3)*cos(newphi/3)
		#
		# part1 can be anything
		set part1 = -BBB/(4*AAA)
		#
		# part2 >0 always
		set part2 = sqrt(BBB**2/(4*AAA**2) - 2/3*CCC/AAA + unit4)
		#
		# part25 can be anything
		set part25 = (-BBB**3/AAA**3 + 4*BBB*CCC/AAA**2 - 8*DDD/AAA)/(4*part2)
		# part3>0 always
		set part3 = sqrt(BBB**2/(2*AAA**2) - 4/3*CCC/AAA - unit4 +sign1*part25)
		set $2 = part1 +sign1* 1/2*part2 +sign2* 1/2*part3
		#
		#
		#
		#
alfvenvp       0 #
		set VS2=va2 # not used
		simplevp 'alfven' VS2 2
		#
sonicvp       0 #
		set VS2=cs2
		simplevp 'sonic' VS2 1
		#
fastvp       0 #
		set VS2=(va2 + cs2*(1 - va2))
		simplevp 'fast' VS2 1
		#
simplevp 3      # simplevp 'sonic' VS2 1
		#
		# returned name has convention of being:
		# 1=outgoing
		# 2=ingoing
		#
		set VS2=$2
		#
		# a quadratic equation of the form AA*vp^2 + BB*vp + CC = 0
		if($3==1){\
		       set CC=-ksuu1**2 + VS2*ksuu1**2 + (2*VS2*(a**2 + (-2 + r)*r))/(a**2 + 2*r**2 + a**2*cos(2*h))
		       set BB=-2*(-1 + VS2)*uu0*ksuu1 - (4*VS2*r)/(r**2 + a**2*cos(h)**2)
		       set AA=-uu0**2 + VS2*(-1 + uu0**2 - (2*r)/(r**2 + a**2*cos(h)**2))
		    }
		    # appears AA is always <-1
		#
		#
		# alfven mode
		if($3==2){\
		       set CC=ksbu1**2/(bsq + rho + $gam*u) - ksuu1**2
		       set BB=(-2*bu0*ksbu1)/(bsq + rho + $gam*u) + 2*uu0*ksuu1
		       set AA=bu0**2/(bsq + rho + $gam*u) - uu0**2
		    }
		#
		# should check to see how small AA is
		#
		# quadratic solutions
		#
		define name ($1+'v1p')
		#
		set $name=-(BB + sqrt(BB**2 - 4*AA*CC))/(2.*AA)
		#
		set $name=$name/dxdxp1
		#
		define name ($1+'v1m')
		set $name=(-BB + sqrt(BB**2 - 4*AA*CC))/(2.*AA)
		#
		set $name=$name/dxdxp1		
		#
alfvenvp2  0  #
                # 1=outgoing
                # 2=ingoing
                #
		# this version has mixed coefficients, so doesn't directly give v1p or v1m directly, but always v1m is smaller than v1p
                set alfvenv1p2=(-(bu0*ksbu1) + ksbu1*sqrt(bsq + rho + $gam*u)*uu0 - bu0*sqrt(bsq + rho + $gam*u)*ksuu1 + bsq*uu0*ksuu1 + rho*uu0*ksuu1 + $gam*u*uu0*ksuu1)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + $gam*u*uu0**2)
                set alfvenv1m2=(-(bu0*ksbu1) - ksbu1*sqrt(bsq + rho + $gam*u)*uu0 + bu0*sqrt(bsq + rho + $gam*u)*ksuu1 + bsq*uu0*ksuu1 + rho*uu0*ksuu1 + $gam*u*uu0*ksuu1)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + $gam*u*uu0**2)
                #
                set alfvenv1p2=alfvenv1p2/dxdxp1
                set alfvenv1m2=alfvenv1m2/dxdxp1
		#
