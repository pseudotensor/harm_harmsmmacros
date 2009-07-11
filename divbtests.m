startold 0      #
		set _is=0
                set _ie=23
		set _js=0
                set _je=31
		set _ks=0
                set _ke=0
		jrdp3duold dump0000
		jrdp3du dump0000
                #
randomtest 0    #
		#
		#
		jrdp3du dump0000
                set myuse=(ti>=_is && ti<=_ie && tj>=_js && tj<=_je && tk>=_ks && tk<=_ke)
		stresscalc 1
                set integrand=gdet*Tud00*$dx1*$dx2*$dx3 if(myuse)
		set uinitial=-SUM(integrand)
                set integrandEM=gdet*Tud00EM*$dx1*$dx2*$dx3 if(myuse)
		set uinitialEM=-SUM(integrandEM)
		#
		#jrdp3du dump0085
                #jrdp3du dump0008
                #jrdp3du dump0046
                #jrdp3du dump0028
		#jrdp3du dump0049 jrdpdebug debug0049
		#jrdp3du dump0180 jrdpdebug debug0180
                #jrdp3du dump0009 jrdpdebug debug0009
                jrdp3du dump0004 jrdpdebug debug0004
		#jrdp3du dump0020
                set myuse=(ti>=_is && ti<=_ie && tj>=_js && tj<=_je && tk>=_ks && tk<=_ke)
		stresscalc 1
                set integrand=gdet*Tud00*$dx1*$dx2*$dx3 if(myuse)
		set ufinal=-SUM(integrand)
                set integrandEM=gdet*Tud00EM*$dx1*$dx2*$dx3 if(myuse)
		set ufinalEM=-SUM(integrandEM)
		#
		set diff=abs(uinitial-ufinal)/(abs(uinitial)+abs(ufinal))
		set diffEM=abs(uinitialEM-ufinalEM)/(abs(uinitialEM)+abs(ufinalEM))
		print '%21.15g %21.15g %21.15g\n' {uinitial ufinal diff}
		print '%21.15g %21.15g %21.15g\n' {uinitialEM ufinalEM diffEM}
		#
		#
randomtest2 0   #              
		#
		set god=gdet*B1 if(ti==_is && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		set god=gdet*B1 if(ti==_is+1 && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		set god=gdet*B1 if(ti==_is+2 && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		#
		set god=U5 if(ti==_is-1 && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		set god=U5 if(ti==_is && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		set god=U5 if(ti==_is+1 && tj>=0 && tj<32)
		set god2=SUM(god)
		set goda2=SUM(abs(god))
		set rat=god2/goda2
		print {god2 goda2 rat}
		#
		set god=U5 if(ti==_is+2 && tj>=0 && tj<32)
		set god2=SUM(god) print {god2}
		#
		#
randomtest3 0   #              
		#
                set myline=(ti==_is+1 && tj>=0 && tj<32) ? 1 : 0
		set divblineu=divb if(myline)
		set U5lineu=U5 if(myline)
		set tjlineu=tj if(myline)
		#
		set myline=(ti==_is && tj>=0 && tj<32) ? 1 : 0
		set divblined=divb if(myline)
		set U5lined=U5 if(myline)
		set U6lined=U6 if(myline)
		set tjlined=tj if(myline)
		#
		# print {tjline U5line divbline}
		#
		#
		#
		#
		set divbtest0= (U5lineu[0]-U5lined[0])/$dx1 + (U6lined[1]-U6lined[0])/$dx2
		#
		set divbnorm0=(1.0/2.0)*(abs(U5lineu[0]/$dx1)+abs(U5lined[0]/$dx1) + abs(U6lined[1]/$dx2) +abs(U6lined[0])/$dx2)
		#
		set divbtestnorm0=divbtest0/divbnorm0
		#
		print {divbtest0 divbnorm0 divbtestnorm0}
		#
randomtest4 0   #              
		#
		dercalc 2 U5 dU5
		dercalc 2 U6 dU6
		#
		dercalc 12 U5 sU5
		dercalc 12 U6 sU6
		#
		set mydivb=abs(dU5x + dU6y)
		set mydivbnormed=abs(dU5x + dU6y)/(abs(sU5x)+abs(sU6y)+1E-30)
		#plc 0 mydivb
		#
		plc 0 (LG(ABS(mydivb)+1E-30)) 001 1.5E6 3E6 -3 3
		#
		#
myplots00  0    #
		#
		#plc0 0 (U5) 001 1.5E6 3E6 2.5 9
		plc0 0 (U5) 001 1.5E6 3E6 -3 9
		#
		#
		#plc0 0 (divb) 001 1.5E6 3E6 -3 1
		plc0 0 (mydivb) 001 1.5E6 3E6 -3 1
		#
		#
		#
checkck 0       #
		jrdp3du dump0000
		grid3d gdump
		#
		set lgdet=-LN(gdet)
		dercalc 1 lgdet dlgdet
		#
		# compare:
		plc 0 dlgdetx
		plc 0 ck1
		#
		#
		# compare:
		plc 0 dlgdety
		plc 0 ck2
		#
		#
		set rat=(ck2-dlgdety)/(abs(ck2)+abs(dlgdety))
		plc 0 rat
		#
		#
		#
checkbody 0     #
		#
		jrdp3du dump0000
		grid3d gdump
		#
		set sumc0= (c000+c101+c202+c303)
		set sumc1= (c010+c111+c212+c313)
		set sumc2= (c020+c121+c222+c323)
		set sumc3= (c030+c131+c232+c333)
		#
		set lgdet=LN(gdet)
		dercalc 0 lgdet dlgdet
		#
		print {ti tj sumc1 dlgdetx sumc2 dlgdety}
		#
		#
		#
faildiff 0      #
		#
		jrdp3du dump0020 jrdpdebug debug0020
		set fail0mid=fail0
		set floor0mid=floor0
                #
		jrdp3du dump0040 jrdpdebug debug0040
		set fail0final=fail0
		set floor0final=floor0
		#
                plc0 0 (LG(fail0final-fail0mid+1))
                set sumfail0diff=SUM(fail0final-fail0mid)
                set sumfloor0diff=SUM(floor0final-floor0mid)
                print {sumfail0diff sumfloor0diff}
		#
		#
failwhere 0     #
		#
		plc 0 fail0 001 1.5E6 3E6 -.2 .6
		set myfail0=newfun
		plc 0 ti 001 1.5E6 3E6 -.2 .6
		set myti=newfun
		plc 0 tj 001 1.5E6 3E6 -.2 .6
		set mytj=newfun
		#
		#
		print {myti mytj myfail0}
		#
checkdU 0       #
		#
		jrdp3du dump0000 jrdpdebug debug0000 jrdpflux fluxdump0000
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0001 jrdpdebug debug0001 jrdpflux fluxdump0001
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0002 jrdpdebug debug0002 jrdpflux fluxdump0002
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0003 jrdpdebug debug0003 jrdpflux fluxdump0003
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0004 jrdpdebug debug0004 jrdpflux fluxdump0004
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0005 jrdpdebug debug0005 jrdpflux fluxdump0005
		plc 0 B2 001 1E8 1E9 -3 9
		#
		jrdp3du dump0010 jrdpdebug debug0010 jrdpflux fluxdump0010
		plc 0 B2 001 1E8 1E9 -3 9
		#
		plc 0 U6 001 1E8 1E9 -3 9
		#
		#
		plc 0 (dUr16*_dt/U6) 001 1E8 1E9 -3 9
		#
		plc 0 (dUr16*_dt) 001 1E8 1E9 -3 9
		#
		set god=dUr16
		set god2=dUr16*_dt
		set crap=god if(ti==470 && tj==1)
		set crap2=god2 if(ti==470 && tj==1)
		print '%21.15g %21.15g %21.15g\n' {crap crap2 _dt}
		#
		plc 0 dUr16 001 1E8 1E9 -3 9
		#min:-784682752
		#
		set testdUr16=gdet*(uu1/uu0*B2-uu2/uu0*B1)
		dercalc 2 testdUr16 dtestdUr16
		set mydU = dtestdUr16x
		plc 0 mydU 001 1E8 1E9 -3 9
		#min:-383203968
		#
		set mydUr16 =  gdet*(uu1/uu0*B2-uu2/uu0*B1)*_dt/$dx1
		plc 0 mydUr16 001 1E8 1E9 -3 9
		#
		set ampB2 = exp((uu1/uu0*B2-uu2/uu0*B1)/$dx1*_t/B2)
		plc 0 ampB2 001 1E8 1E9 -3 9
		#
		#
		#
		set startanim=0
		set endanim=63
		#agplc 'dump' (dUr16*_dt) 001 1E8 1E9 -3 9
		agplc 'dump' (B2) 001 1E8 1E9 -3 9
		#agplc 'dump' (uu2) 001 1E8 1E9 -3 9
		#
		#
