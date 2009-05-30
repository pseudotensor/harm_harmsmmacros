plotdlm      0 #
		jrdpener 0 2000
		define x1label "t c^3/GM"
		define x2label "\dot{L}/\dot{M}"
		ctype default pl 0 t dlm
		set thin=t*0+2.1
		ctype red pl 0 t thin 0010
		#
		set use1=((t>150)&&(t<800)) ? 1 : 0
		set use2=((t>800)&&(t<1500)) ? 1 : 0
		set use3=(t>1500) ? 1 : 0
		set t1=t if(use1)
		set dlm1=dlm if(use1)
		set t2=t if(use2)
		set dlm2=dlm if(use2)
		set t3=t if(use3)
		set dlm3=dlm if(use3)
		#
		#
		avg t1 dlm1 avgdlm1
		lsq t1 dlm1 t1 lsqdlm1 rms1
		echo $rms1
		set myrms1=$rms1
                set mym1=$a
                set myb1=$b
                set sigm1=$sig_a
                set sigb1=$sig_b
                set chisq1=$CHI2
		#
		avg t2 dlm2 avgdlm2
		lsq t2 dlm2 t2 lsqdlm2 rms2
		echo $rms2
		set myrms2=$rms2
                set mym2=$a
                set myb2=$b
                set sigm2=$sig_a
                set sigb2=$sig_b
                set chisq2=$CHI2
		#
		avg t3 dlm3 avgdlm3
		lsq t3 dlm3 t3 lsqdlm3 rms3
		echo $rms3
		set myrms3=$rms3
                set mym3=$a
                set myb3=$b
                set sigm3=$sig_a
                set sigb3=$sig_b
                set chisq3=$CHI2
		#
plotdem      0 #
		jrdpener 0 2000
		define x1label "t c^3/GM"
		define x2label "\dot{E}/\dot{M}"
		ctype default pl 0 t dem
		set thin=t*0+0.844
		ctype red pl 0 t thin 0010
		#
		set use1=((t>150)&&(t<800)) ? 1 : 0
		set use2=((t>800)&&(t<1500)) ? 1 : 0
		set use3=(t>1500) ? 1 : 0
		set t1=t if(use1)
		set dem1=dem if(use1)
		set t2=t if(use2)
		set dem2=dem if(use2)
		set t3=t if(use3)
		set dem3=dem if(use3)
		#
		#
		avg t1 dem1 avgdem1
		lsq t1 dem1 t1 lsqdem1 rms1
		echo $rms1
		set myrms1=$rms1
                set mym1=$a
                set myb1=$b
                set sigm1=$sig_a
                set sigb1=$sig_b
                set chisq1=$CHI2
		#
		avg t2 dem2 avgdem2
		lsq t2 dem2 t2 lsqdem2 rms2
		echo $rms2
		set myrms2=$rms2
                set mym2=$a
                set myb2=$b
                set sigm2=$sig_a
                set sigb2=$sig_b
                set chisq2=$CHI2
		#
		avg t3 dem3 avgdem3
		lsq t3 dem3 t3 lsqdem3 rms3
		echo $rms3
		set myrms3=$rms3
                set mym3=$a
                set myb3=$b
                set sigm3=$sig_a
                set sigb3=$sig_b
                set chisq3=$CHI2
		#
		#
multipole    0  #
		# jrdp dump0010 # turb time
		jrdp dump0040   # late time
		set _defcoord=0
		fieldcalc 0 aphi
		# plcergo 0 aphi 001 Rin 2 0 pi
		# 2048by256 H/R=0.05 thin disk
		#set aphiuse=((r>$rhor*.999)&&(r<$rhor*1.001)) ? 1 : 0
		# 456by456 thick disk
		set aphiuse=((r>$rhor*.995)&&(r<$rhor*1.005)) ? 1 : 0
		set myaphi=aphi if(aphiuse)
		set myh=h if(aphiuse)
		set mydh=dh if(aphiuse)
		set mygdet=gdet if(aphiuse)
		#
		set dxdxp11=r
		set mynorm=B1*dxdxp11
		# setlimits $rhor 1.001*$rhor 0 pi 0 1 plflim 0 x2 r h mynorm 0
		set mysupernorm=$rhor*$rhor*ABS(mynorm) if((aphiuse)&&(tj==0))
		print {mysupernorm}
		set myaphi=myaphi/mysupernorm
		#
		set cx=cos(myh)
		#
		set lp0=0.7071067811865475+cx*0
		set lp1=1.224744871391589*cx
		set lp2=0.7905694150420948*(-1. + 3.*cx**2)
		set lp3=-0.9354143466934856*cx*(3. - 5.*cx**2)
		set lp4=0.26516504294495524*(3. - 30.*cx**2 + 35.*cx**4)
		set lp5=0.29315098498896586*cx*(15. - 70.*cx**2 + 63.*cx**4)
		set lp6=0.15934435979977482*(-5. + 105.*cx**2 - 315.*cx**4 + 231.*cx**6)
		set lp7=-0.1711632992203419*cx*(35. - 315.*cx**2 + 693.*cx**4 - 429.*cx**6)
		set lp8=0.022777155839238807*(35. - 1260.*cx**2 + 6930.*cx**4 - 12012.*cx**6 + 6435.*cx**8)
		set lp9=0.024079742199103724*cx*(315. - 4620.*cx**2 + 18018.*cx**4 - 25740.*cx**6 + 12155.*cx**8)
		set lp10=0.01265769667657929*(-63. + 3465.*cx**2 - 30030.*cx**4 + 90090.*cx**6 - 109395.*cx**8 + 46189.*cx**10)
		set lp11=-0.01324673824836985*cx*(693. - 15015.*cx**2 + 90090.*cx**4 - 218790.*cx**6 + 230945.*cx**8 - 88179.*cx**10)
		#
		# works only for defcoord=0
		set aphilp0=SUM(lp0*myaphi*sin(myh)*mydh)
		set aphilp1=SUM(lp1*myaphi*sin(myh)*mydh)
		set aphilp2=SUM(lp2*myaphi*sin(myh)*mydh)
		set aphilp3=SUM(lp3*myaphi*sin(myh)*mydh)
		set aphilp4=SUM(lp4*myaphi*sin(myh)*mydh)
		set aphilp5=SUM(lp5*myaphi*sin(myh)*mydh)
		set aphilp6=SUM(lp6*myaphi*sin(myh)*mydh)
		set aphilp7=SUM(lp7*myaphi*sin(myh)*mydh)
		set aphilp8=SUM(lp8*myaphi*sin(myh)*mydh)
		set aphilp9=SUM(lp9*myaphi*sin(myh)*mydh)
		set aphilp10=SUM(lp10*myaphi*sin(myh)*mydh)
		set aphilp11=SUM(lp11*myaphi*sin(myh)*mydh)
		#
		set mycoefs=0,11,1
		set myaphilps=0,11,1
		set myaphilps=myaphilps*0
		set myaphilps[0]=aphilp0
		set myaphilps[1]=aphilp1
		set myaphilps[2]=aphilp2
		set myaphilps[3]=aphilp3
		set myaphilps[4]=aphilp4
		set myaphilps[5]=aphilp5
		set myaphilps[6]=aphilp6
		set myaphilps[7]=aphilp7
		set myaphilps[8]=aphilp8
		set myaphilps[9]=aphilp9
		set myaphilps[10]=aphilp10
		set myaphilps[11]=aphilp11
		#
		fdraft
		# device postencap moments.eps
		define x1label "Multipole moment"
		define x2label "Normalized amplitude"
		ctype default pl 0 mycoefs myaphilps
		# device X11
		# !scp moments.eps jon@relativity:/home/jondata/
		#
		# device postencap momentreconstruct.eps
		define x1label "\theta"
		define x2label "A_\phi(r_+)"
		ctype default pl 0 myh myaphi
		set godaphi=aphilp0*lp0+aphilp1*lp1+aphilp2*lp2+aphilp3*lp3+aphilp4*lp4+aphilp5*lp5+aphilp6*lp6\
		    +aphilp7*lp7+aphilp8*lp8+aphilp9*lp9+aphilp10*lp10+aphilp11*lp11
		ctype red pl 0 myh godaphi 0010
		# device X11
		# !scp momentreconstruct.eps jon@relativity:/home/jondata/
		#
		#
bz1          0          #
		define cres 100
		jrdp dump0040
		stresscalc 1
		set it=gdet*Tud10EM
		plc 0 it
bz2          0  #
		readg42 tavg422040.txt
		device postencap femvsthetatd.eps
		#
		set it=gdet*Tud10EM
		define x1label "\theta"
		define x2label "F^{(EM)}"
		setlimits Rin $rhor 0 pi 0 1 plflim 0 x2 r h it
		#
		device X11
		!scp femvsthetatd.eps metric:research/thindisk/
		#
bz3          0  #
		set rinner=Rin
		set router=$rhor
		set pdh=0.9
		#
		joncalc3 1 1 rinner router pdh Tud10EM eempole
		joncalc3 2 1 rinner router pi/2 Tud10EM eemtot
		joncalc3 1 1 rinner router pdh Tud10MA emapole
		joncalc3 2 1 rinner router pi/2 Tud10MA ematot
		#
		joncalc3 2 1 rinner router pi/2 Tud10EM Tud10EMhor
		joncalc3 2 1 rinner router pi/2 Tud10MA Tud10MAhor
		set rat=Tud10EMhor/Tud10MAhor print{rat}
		jrdpener 500 2000
		set it1=Tud10EMhor/dmavg
		set it2=Tud10MAhor/dmavg
		print {it1 it2}
bz4          0  #
		greaddump dumptavg2040v2
		set it=LG(u)
		setlimits Rin Rout (pi/2-0.1) (pi/2+0.1) 0 1 plflim 0 x1 r h it
		#
		set it=lg(bsq/u)
		setlimits Rin Rout (pi/2-0.1) (pi/2+0.1) 0 1 plflim 0 x1 r h it
td1         0   #
		jrdp dump0000
		diskhorc52 newr z0 hor
		ctype default pl 0 newr hor 0001 Rin Rout 0 0.5
		#
		jrdp dump0020
		diskhorc52 newr z02 hor2
		ctype red plo 0 newr hor2
		#
		jrdp dump0040
		diskhorc52 newr z04 hor4
		ctype blue plo 0 newr hor4
		#
		#
		ctype default pl 0 newr hor 0001 Rin Rout 0 0.5
		ctype red plo 0 newr hor2
		ctype blue plo 0 newr hor4
		#
		#
		set it=(hor2+hor4)/2 if((newr>11)&&(newr<13)) set itavg1=SUM(it)/dimen(it) print{itavg1}
		#
		set it=(hor2+hor4)/2 if((newr>Rin+0.15*(Rout-Rin))&&(newr<Rin+(Rout-Rin)*0.85)) set itavg2=SUM(it)/dimen(it)   print{itavg2}
		#
		ctype default pl 0 newr z0 0001 Rin Rout -3 3
		ctype red plo 0 newr z02
		ctype blue plo 0 newr z04
		#
		# outflow
		#
		set it=(uu1>0&&ud0+1<0) ? ud0 : 0
		plc 0 it
		#
		#
diskhorcalc 6   # diskhorcalc whichvar rinner router rin rmax hor
		# diskhorcalc rho Rin Rout rin rmax hor
		set whichvar=$1
		set horrinner=$2
		set horrouter=$3
		plc 0 whichvar 001 horrinner horrouter 0 pi
		set maxvalue=$max
		#
		set levtop=maxvalue/(exp(1)-1E-3)
		set levbottom=maxvalue/(exp(1)+1E-3)
		set levdelta=(levtop-levbottom)/1.0
		set lev=levbottom,levtop,levdelta
		levels lev
		ctype cyan contour
		#
		set levtop=maxvalue/(exp(0)-1E-3)
		set levbottom=maxvalue/(exp(0)+1E-3)
		#
		set use1=((whichvar>levbottom)&&(whichvar<levtop)) ? 1 : 0
		set Rmax=SUM(r*gdet*area*use1)/SUM(gdet*area*use1)
		set use0=((r>=6)&&(r<Rmax)&&(ABS(h-pi/2)<1.5*dh[$nx*$ny/2])&&(whichvar>0)&&(whichvar<1E-4)) ? 1 : 0
		# or 1E-4 -> some floor value?
		set Rint=SUM(r*gdet*area*use0)/SUM(gdet*area*use0)
		# find the i for a given radius
		define tempi (0)
		while { $tempi<$nx } {\
		       if(r[0*$nx+$tempi]>=Rmax) { break }
		       define tempi ($tempi+1)
		}
		set isel=$tempi
		if(isel==$nx) { set isel=$nx-1 }
		#
		set god=LG(Rmax)
		ctype blue vertline god
		#
		# we arne't certain any such small interval of whichvar exists
		set levtop=maxvalue/(exp(1)-1E-3)
		set levbottom=maxvalue/(exp(1)+1E-3)
		set use2=((whichvar>levbottom)&&(whichvar<levtop)&&(ti==isel)&&(h<pi/2)) ? 1 : 0
		if(SUM(use2)==0) {\
		       set levtop=maxvalue/(0.9*exp(1)-1E-3)
		       set levbottom=maxvalue/(1.1*exp(1)+1E-3)
		       set levdelta=(levtop-levbottom)/1.0
		       set lev=levbottom,levtop,levdelta
		       levels lev
		       ctype red contour
		       set use2=((whichvar>levbottom)&&(whichvar<levtop)&&(ti==isel)&&(h<pi/2)) ? 1 : 0
		    }
		if(SUM(use2)==0) {\
		       set levtop=maxvalue/(0.5*exp(1)-1E-3)
		       set levbottom=maxvalue/(2.0*exp(1)+1E-3)
		       set levdelta=(levtop-levbottom)/1.0
		       set lev=levbottom,levtop,levdelta
		       levels lev
		       ctype blue contour
		       set use2=((whichvar>levbottom)&&(whichvar<levtop)&&(ti==isel)&&(h<pi/2)) ? 1 : 0
		    }
		#
		# below is old version of H/R, not standard, so using 2nd below now
		#set HOR=pi/2-SUM(h*gdet*area*use2)/SUM(gdet*area*use2)
		set HOR=(pi/2-SUM(h*gdet*area*use2)/SUM(gdet*area*use2))/sqrt(2)
		#
		set $4=Rint
		set $5=Rmax
		set $6=HOR
		print {Rint Rmax HOR}
		#
		#
diskhorc2   3   # diskhorc2 Rin Rout horavg
		#
		set dtheta=1.0 # around equator
		set hor=sqrt(cs2)/(r*omega3)
		joncalc3 2 2 $1 $2 dtheta hor $3
		#
		#
diskhorc3   3   # diskhorc3 whichval sigma r
		# diskhorc3 u 0.26 12
		#
		set whichval=$1
		#
		set sigma=$2
		set myr=$3
		set myrplus=myr*1.1
		ctype default setlimits myr myrplus 0 pi 0 1
		plflim 0 x2 r h u
		# find the i for a given radius
		define tempi (0)
		while { $tempi<$nx } {\
		       if(r[0*$nx+$tempi]>=myr) { break }
		       define tempi ($tempi+1)
		}
		set isel=$tempi
		if(isel==$nx) { set isel=$nx-1 }
		#
		# find norm/peak
		set peaknorm=whichval[isel+$ny/2*$nx]
		#
		set gaussu=sqrt(2*pi)*sigma*peaknorm*gauss(newx,pi/2,sigma)
		ctype red plo 0 newx gaussu
		#
		#
diskhorc4   3   #diskhorc4 Rpick z0 hor
		# gives z0 and hor for one Rpick
		#
		# find the i for a given radius
		define tempi (0)
		while { $tempi<$nx } {\
		       if(r[0*$nx+$tempi]>=Rpick) { break }
		       define tempi ($tempi+1)
		}
		set isel=$tempi
		if(isel==$nx) { set isel=$nx-1 }
		#
		diskhorc42 isel $2 $3
		#
diskhorc5    3  #diskhorc5 newr z0 hor
		# find z0 and hor=z/r vs r
		set $1=r if(tj==0)
		#
		set $2=newr*0
		set $3=newr*0
		#
		do ii=0,$nx-1,1 {
		   diskhorc42 $ii z0temp hortemp
		   set $2[$ii]=z0temp
		   set $3[$ii]=hortemp
		   echo done $ii
		}
		#	
		# 
		#
diskhorc52    3  #diskhorc52 newr z0 hor
		# find z0 and hor=theta vs r
		set $1=r if(tj==0)
		#
		set $2=newr*0
		set $3=newr*0
		#
		do ii=0,$nx-1,1 {
		   diskhorc43 $ii z0temp hortemp
		   set $2[$ii]=z0temp
		   set $3[$ii]=hortemp
		   echo done $ii
		}
		#	
		# 
diskhorc53    3  #diskhorc53 newr z0 hor
		# find z0 and hor=cs/vk vs r
		set $1=r if(tj==0)
		#
		set $2=newr*0
		set $3=newr*0
		#
		do ii=0,$nx-1,1 {
		   diskhorc44 $ii z0temp hortemp
		   set $2[$ii]=z0temp
		   set $3[$ii]=hortemp
		   echo done $ii
		}
		#	
		# 
		#
diskhorc42   3  # diskhorc42 whichi z0 hor
		# z-thickness (problems near r-theta edges)
		#
		set isel=$1
		#
		set R=r*sin(h)
		set z=r*cos(h)
		#
		set use=(ABS(R-r[$ny/2*$nx+isel])<2*dr[$ny/2*$nx+isel]) ? 1 : 0
		set numpoints=SUM(use)
		#		#		
		set $2=SUM(z*rho*gdet*$dx1*$dx2*use)/SUM(rho*gdet*$dx1*$dx2*use)
		set Hsqtemp=SUM((z-$2)*(z-$2)*rho*gdet*$dx1*$dx2*use)/SUM(rho*gdet*$dx1*$dx2*use)
		set $3=sqrt(Hsqtemp)/r[$ny/2*$nx+isel]
		#print {z0 hoverr numpoints}
		#
		#ctype default pl 0 r h
		#ctype red points rslice hslice
		#
diskhorc43   3  # diskhorc43 whichi z0 hor
		# theta thickness
		#
		set isel=$1
		#
		set R=r*sin(h)
		set z=r*cos(h)
		#
		set use=(ABS(r-r[$ny/2*$nx+isel])<2*dr[$ny/2*$nx+isel]) ? 1 : 0
		set numpoints=SUM(use)
		#		#		
		set $2=SUM(h*rho*gdet*$dx1*$dx2*use)/SUM(rho*gdet*$dx1*$dx2*use)
		set Hsqtemp=SUM((h-$2)*(h-$2)*rho*gdet*$dx1*$dx2*use)/SUM(rho*gdet*$dx1*$dx2*use)
		set $3=sqrt(Hsqtemp)
		#print {z0 hoverr numpoints}
		#
		#ctype default pl 0 r h
		#ctype red points rslice hslice
		#
diskhorc44   3  # diskhorc43 whichi z0 hor
		# H/R=cs/vk thickness
		#
		set isel=$1
		#
		set R=r*sin(h)
		set z=r*cos(h)
		#
		set use=(ABS(r-r[$ny/2*$nx+isel])<2*dr[$ny/2*$nx+isel]) ? 1 : 0
		set numpoints=SUM(use)
		#		#		
		set $2=SUM(sqrt(cs2)/(r*omega3)*gdet*$dx1*$dx2*use)/SUM(gdet*$dx1*$dx2*use)
		set Hsqtemp=SUM((sqrt(cs2)/(r*omega3)-$2)*(sqrt(cs2)/(r*omega3)-$2)*gdet*$dx1*$dx2*use)/SUM(gdet*$dx1*$dx2*use)
		set $3=sqrt(Hsqtemp)
		#print {z0 hoverr numpoints}
		#
		#ctype default pl 0 r h
		#ctype red points rslice hslice
		#
