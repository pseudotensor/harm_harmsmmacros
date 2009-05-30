vdotBcheck 0 #
		set vdotB=abs(uu1*B1*gv311+uu2*B2*gv322+uu3*B3*gv333)/uu0
		set v0=vdotB/sqrt(B1*B1*gv311+B2*B2*gv322+B3*B3*gv333)
		#
checkF 0     #
		jrdp3du dump0001
		jrdpflux fluxdump0001
		#
		set godup=F22 if(tj==64)
		set goddn=F22 if(tj==0)
		set myr=r if(tj==0)
		#
		#pl 0 myr goddn
		#
		set godpl=p2l0 if(tj==0)
		set godpr=p2r0 if(tj==0)
		#
		# dir=2 pl=v2
		set godpl=p2l3 if(tj==0) set godpr=p2r3 if(tj==0)
		set diff=(godpl+godpr)/(abs(godpl)+abs(godpr))
		print '%21.15g %21.15g %21.15g %21.15g\n' {myr godpl godpr diff}
		#
		# dir=2 pl=B2
		set godpl=p2l6 if(tj==0) set godpr=p2r6 if(tj==0)
		set diff=(godpl+godpr)/(abs(godpl)+abs(godpr))
		print '%21.15g %21.15g %21.15g %21.15g\n' {myr godpl godpr diff}
		#
		# Fl=Fr !!!1 WTF!
		# dir=2 pl=v1
		set godpl=F2l2 if(tj==0) set godpr=F2r2 if(tj==0)
		set diff=(godpl+godpr)/(abs(godpl)+abs(godpr))
		print {myr godpl godpr diff}
		#
		# Fl=-Fr
		# dir=2 pl=v1
		set godpl=F2l2 if(tj==64) set godpr=F2r2 if(tj==64)
		set diff=(godpl+godpr)/(abs(godpl)+abs(godpr))
		print {myr godpl godpr diff}
		#
checkv 0        #
		jrdp3du dump0001
		grid3d gdump
		#
		set myvx=uu1*sqrt(gv311)
		set myvy=uu2*sqrt(gv322)
		define SKIPFACTOR 2
		vpl 0 myv 10 12
		fieldcalc 0 aphi
		plc 0 aphi 010
		plc 0 uu0 010
		#
checkuu0 0      #
		jrdp3du dump0001
		#
		define myti (0)
		#
		set myuu0=uu0 if(ti==$myti)
		set myuu1=uu1 if(ti==$myti)
		set myuu2=uu2 if(ti==$myti)
		set myh=h if(ti==$myti)
		#
		pl 0 myh myuu0
		points myh myuu0
		#
checkmachb 0    #
		jrdp3du dump0000
		#
		set absb=sqrt(bsq)
		dercalc 0 absb dabsb
		#
		set machb1=sqrt((dabsbx*$dx1)**2/rho)
		set machb2=sqrt((dabsby*$dx2)**2/rho)
		#
		jrdp3du dump0001
		device postencap machb1.eps
		plc 0 machb1
		plc 0 uu0 010
		device X11
		!cp machb1.eps ~/
		#
		device postencap machb2.eps
		plc 0 machb2
		plc 0 uu0 010
		device X11
		!cp machb2.eps ~/
		#
