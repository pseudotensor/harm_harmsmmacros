		#
randomtest 0    #
		#
		#
		jrdp3du dump0000
		stresscalc 1
		set uinitial=-SUM(gdet*Tud00*$dx1*$dx2*$dx3)
		#
		jrdp3du dump0085
		stresscalc 1
		set ufinal=-SUM(gdet*Tud00*$dx1*$dx2*$dx3)
		#
		print {uinitial ufinal}
		#
		#
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
		
