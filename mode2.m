                # newer version of mode.m with some discriminate checks
		# 
coefprint  0            #
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
		set val22=bu2**2/EF
		set va022=bu0*bu2/EF
		#
		#
		set EE2=uu2**4 - cms2*uu2**2*(gn322 + uu2**2) + cs2*gn322*val22
		#
		set DD2=2*(-2*uu0*uu2**3 + cms2*uu2*(gn322*uu0 + uu2*(gn302 + 2*uu0*uu2)) - cs2*gn322*va022 - cs2*gn302*val22)
		#
		set CC2=6*uu0**2*uu2**2 - cms2*(gn322*uu0**2 + uu2*(4*gn302*uu0 + gn300*uu2 + 6*uu0**2*uu2)) + cs2*(4*gn302*va022 + gn322*va02 + gn300*val22)
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
		# if this is not the case, then fix it, and check if only due to machine precision
		set unit3=-4*unit2**3 + unit1**2
		# fix unit3
		set bad=(unit3>1E-10) ? 1 : 0
		set badsum=SUM(bad)
		if(badsum) { echo "PROBLEM with unit3" }
		set unit3good=(unit3>0.0) ? 0.0 : unit3
		#
		set newradius=sqrt(unit1**2+ABS(-unit3good))
		# ATAN2(y,x) where tan(phi)=y/x
		set newphi=ATAN2(sqrt(-unit3good),unit1)
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
		set VS2=val2 # not used
		simplevp 'alfven' VS2 2
		#
sonicvp       0 #
		set VS2=cs2
		simplevp 'sonic' VS2 1
		#
fastvp       0 #
		set VS2=(val2 + cs2*(1 - val2))
		simplevp 'fast' VS2 1
		#
		#
		#
simplevp 3      # coordinate basis (primitive coords) simplified characteristic speed relative to fluid frame
		# simplevp 'sonic' VS2 1
		#
		# returned name has convention of being:
		# 1=outgoing
		# 2=ingoing
		#
		set VS2=$2
		#
		# a quadratic equation of the form AA*vp^2 + BB*vp + CC = 0
		if($3==1){\
		       set CC=-uu1**2 + VS2*uu1**2 + (2*VS2*(a**2 + (-2 + r)*r))/(a**2 + 2*r**2 + a**2*cos(2*h))
		       set BB=-2*(-1 + VS2)*uu0*uu1 - (4*VS2*r)/(r**2 + a**2*cos(h)**2)
		       set AA=-uu0**2 + VS2*(-1 + uu0**2 - (2*r)/(r**2 + a**2*cos(h)**2))
		    }
		    # appears AA is always <-1
		#
		#
		# alfven mode
		if($3==2){\
		       set CC=bu1**2/(bsq + rho + p) - uu1**2
		       set BB=(-2*bu0*bu1)/(bsq + rho + p) + 2*uu0*uu1
		       set AA=bu0**2/(bsq + rho + p) - uu0**2
		    }
		#
		# should check to see how small AA is
		#
		# quadratic solutions
		#
		define name ($1+'v1p')
		#
		# disc may be near 0 by machine precision for certain types of flows (i.e. non-magnetic for alfven mode)
		set disc=BB**2 - 4*AA*CC
		set bad=(disc<-1E-10) ? 1 : 0
		set badsum=SUM(bad)
		if(badsum) { echo "PROBLEM with disc" }
		set discgood=(disc<0.0) ? 0.0 : disc
		set $name=-(BB + sqrt(discgood))/(2.*AA)
		#
		set $name=$name/dxdxp1
		#
		define name ($1+'v1m')
		set $name=(-BB + sqrt(discgood))/(2.*AA)
		#
		set $name=$name/dxdxp1		
		#
		#
alfvenvp2  0  #  accurate (not simplified) coordinate basis Alfven speed
                # 1=outgoing
                # 2=ingoing
                #
		# this version has mixed coefficients, so doesn't directly give v1p or v1m directly, but always v1m is smaller than v1p
                set alfvenv1p2=(-(bu0*bu1) + bu1*sqrt(bsq + rho + p)*uu0 - bu0*sqrt(bsq + rho + p)*uu1 + bsq*uu0*uu1 + rho*uu0*uu1 + p*uu0*uu1)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + p*uu0**2)
                set alfvenv1m2=(-(bu0*bu1) - bu1*sqrt(bsq + rho + p)*uu0 + bu0*sqrt(bsq + rho + p)*uu1 + bsq*uu0*uu1 + rho*uu0*uu1 + p*uu0*uu1)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + p*uu0**2)
                #
		# this version has mixed coefficients, so doesn't directly give v1p or v1m directly, but always v1m is smaller than v1p
                set alfvenv2p2=(-(bu0*bu2) + bu2*sqrt(bsq + rho + p)*uu0 - bu0*sqrt(bsq + rho + p)*uu2 + bsq*uu0*uu2 + rho*uu0*uu2 + p*uu0*uu2)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + p*uu0**2)
                set alfvenv2m2=(-(bu0*bu2) - bu2*sqrt(bsq + rho + p)*uu0 + bu0*sqrt(bsq + rho + p)*uu2 + bsq*uu0*uu2 + rho*uu0*uu2 + p*uu0*uu2)/(-bu0**2 + bsq*uu0**2 + rho*uu0**2 + p*uu0**2)
                #
		#set alfvenv1p2=alfvenv1p2/dxdxp1
                #set alfvenv1m2=alfvenv1m2/dxdxp1
		#
fastrcalc   4   # fastrcalc which router thetawidth answer
		set fastrouter=$2
		if($1==1){\
		 set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<fastrouter)&&((ABS(h-pi/2)<$3))) ? 1 : 0
		 if(SUM(use)==0) { set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<2*fastrouter)&&((ABS(h-pi/2)<$3))) ? 1 : 0 }
		 if(SUM(use)==0) { set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<4*fastrouter)&&((ABS(h-pi/2)<$3))) ? 1 : 0 }
		 if(SUM(use)==0) { set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<8*fastrouter)&&((ABS(h-pi/2)<$3))) ? 1 : 0 }
		 if(SUM(use)==0) { set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<10*fastrouter)&&((ABS(h-pi/2)<$3))) ? 1 : 0 }
		 if(SUM(use)==0) { set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<=_Rout)&&((ABS(h-pi/2)<$3))) ? 1 : 0 }
		 # if never found, then assume at outer edge since shouldn't be inside inner edge
		 if(SUM(use)==0) { set $4=_Rout }
		}
		if($1==2){\
		       # avoid polar problems
		 set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<fastrouter)&&((ABS(h-pi/2)>pi/2-$3))) ? 1 : 0		 
		 if(SUM(use)==0) {\
		        echo "1" 
		     set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<2*fastrouter)&&((ABS(h-pi/2)>pi/2-$3))&&(ABS(h-pi/2)<pi/2-2*dh[0])) ? 1 : 0
		  }
		 if(SUM(use)==0) {\
		    echo "2" 
		    set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<4*fastrouter)&&((ABS(h-pi/2)>pi/2-$3))&&(ABS(h-pi/2)<pi/2-2*dh[0])) ? 1 : 0
		 }
		 if(SUM(use)==0) {\
		        echo "3" 
		     set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<8*fastrouter)&&((ABS(h-pi/2)>pi/2-$3))&&(ABS(h-pi/2)<pi/2-2*dh[0])) ? 1 : 0
		  }
		 if(SUM(use)==0) {\
		 echo "4"
		set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<10*fastrouter)&&((ABS(h-pi/2)>pi/2-$3))&&(ABS(h-pi/2)<pi/2-2*dh[0])) ? 1 : 0
		}
		 if(SUM(use)==0) {\
		 echo "5" 
		set use=((v1p>-1E-3)&&(v1p<1E-3)&&(r<=_Rout)&&((ABS(h-pi/2)>pi/2-$3))&&(ABS(h-pi/2)<pi/2-2*dh[0])) ? 1 : 0 
		}
		 # if never found, then assume at outer edge since shouldn't be inside inner edge
		 if(SUM(use)==0) {\
		        echo "6"
		     set $4=_Rout
		  }
		}
		if(SUM(use)>0) {\
		 set $4=SUM(r*gdet*area*use)/SUM(gdet*area*use)
		}
		set temptempfastr=$4
		print {temptempfastr}
plcfastpoint 1	#
		#
		if($1==0) {\
		 plc 0 r 001 0 3 0 pi
		 set rnewfun=newfun
		 plc 0 v1p 001 0 3 0 pi
		}
		if($1==1) {\
		 plc 0 r
		 set rnewfun=newfun
		 plc 0 v1p
		}
		set lev=-1E-5,1E-5,2E-5
		levels lev
		ctype blue contour
		#
		set lev=-1E-3,1E-3,2E-3
		levels lev
		ctype yellow contour
		set lev=-1E-2,1E-3,2E-2
		levels lev
		ctype green contour
		#
		set image[ix,iy] = rnewfun
		set lev=($rhor),($rhor+1E-5),2E-5
		levels lev
		ctype cyan contour		
		#
sol1 0          #
		# find speed of light 3-velocity
		#
		# do first: gammiegridnew3 gdump
		#
		set vu1=uu1/uu0
		set vu2=uu2/uu0
		set vu3=uu3/uu0
		set B=2*(vu2*gv312+vu3*gv313+gv301)/gv311
		set C=(gv300 + 2*(vu2*gv302+vu3*gv303) + vu2*vu2*gv322 + vu3*vu3*gv333 + 2*vu2*vu3*gv323)/gv311
		set vsol1p=(-B+sqrt(B**2-4*C))/2
		set vsol1m=(-B-sqrt(B**2-4*C))/2
		#
		# see if velocity is faster or slower than light speed
		set ratv1=(vu1>0) ? vu1/vsol1p : vu1/vsol1m
		#
		#
		#
		# see if wavespeed is faster or slower than light speed
		set ratp=(v1p>0) ? v1p/vsol1p : v1p/vsol1m
		set ratm=(v1m>0) ? v1m/vsol1p : v1m/vsol1m
		#
		# jetresfl1 has 1.2938c for v1p
		set ratp1=ratp-1
		plc0 0 ratp1 001 5 Rout 0 pi
		# above shows red where too fast, and inside entire blue region
		#
		jre mode2.m
		trueslowfast
		# 4 points with problem with jetresfl1 dump0057 and part3 negative inside sqrt?
		#
		# see if true fast wavespeed is faster or slower than light speed
		set rattp=(tfastv1p>0) ? tfastv1p/vsol1p : tfastv1p/vsol1m
		set rattm=(tfastv1m>0) ? tfastv1m/vsol1p : tfastv1m/vsol1m
		#
		set rattp1=rattp-1
		plc0 0 rattp1 001 5 Rout 0 pi
		# above shows red where too fast, and inside entire blue region (same as simple v1p estimate)
		#
		set rattm1=rattm-1
		plc0 0 rattm1 001 5 Rout 0 pi
		# above shows red where too fast, and inside entire blue region (same as simple v1m estimate)
		#
		#
		# problem with jetresfl1 near v1p=0
		set it=LG(ABS(1-v1p/vsol1p))
		#pls 0 it 001 1.2 1.7 0 pi
		# red shows bad spots
		plc 0 it 001 1.2 1.7 0 pi
		#
testv1pv1m 0    #
		# based on above, but checks to see if phase velocity > c
		#set vu1=v1p
		set vu1=v1m
		#set vu1=uu1/uu0
		set vu2=uu2/uu0
		set vu3=uu3/uu0
		set uu0disc=-gv300-2*(vu1*gv301+vu2*gv302+vu3*gv303)-\
		    (vu1*vu1*gv311+vu2*vu2*gv322+vu3*vu3*gv333+2*(vu1*vu2*gv312+vu1*vu3*gv313+vu2*vu3*gv323))
		set uu0p=1/sqrt(uu0disc)
		#
		# negative (white) regions are faster than light
		plc0 0 uu0disc
		#
		#
		#
tempfix 0       #
		set uu0=uu1
		set uu1=uu2
		set uu2=uu3
		set uu3=ud0
		set v1m=v1p
		set v1p=v2m
