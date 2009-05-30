fluidtable 0    #
		#greaddump dumptavg2040equalize
		#
		set disk=(libeta<LG(1/3)) ? 1 : 0
		set diskvol=SUM(disk*dV*gdet)
		set rhodisk=SUM(rho*disk)/dimen(disk) print {rhodisk}
		# joncalc3 2 2 8 20 0.26 rho rhoavg (not used here)
		set plunge=((ABS(h-pi/2)<0.26)&&(libeta>LG(1/3))) ? 1 : 0
		set plungevol=SUM(plunge*dV*gdet)
		set rhoplunge=SUM(rho*plunge*gdet*dV)/plungevol print {rhoplunge}
		#joncalc3 2 2 $rhor risco 0.26 rho rhoavg (not used here)
		set corona=((libeta>LG(1/3))&&(libeta<0)) ? 1 : 0
		set coronavol=SUM(corona*dV*gdet)
		set rhocorona=SUM(rho*corona*dV*gdet)/coronavol print {rhocorona}
		#set funnel=((lbrel>0)&&(r>2)&&(ABS(h-pi/2)<1.3)) ? 1 : 0
		set funnel=(lbrel>0) ? 1 : 0
		set funnelvol=SUM(funnel*dV*gdet)		
		set rhofunnel=SUM(rho*funnel)/funnelvol print {rhofunnel}
		print {rhodisk rhoplunge rhocorona rhofunnel}
		#		
		set breldisk=SUM(10**(lbrel)*disk*dV*gdet)/diskvol print {breldisk}
		set brelplunge=SUM(10**(lbrel)*plunge*dV*gdet)/plungevol print {brelplunge}
		set brelcorona=SUM(10**(lbrel)*corona*dV*gdet)/coronavol print {brelcorona}
		set brelfunnel=SUM(10**(lbrel)*funnel*dV*gdet)/funnelvol print {brelfunnel}
		print {breldisk brelplunge brelcorona brelfunnel}
		#
		set temp=p/rho
		#
		set tempdisk=SUM(temp*disk*dV*gdet)/diskvol print {tempdisk}
		set tempplunge=SUM(temp*plunge*dV*gdet)/plungevol print {tempplunge}
		set tempcorona=SUM(temp*corona*dV*gdet)/coronavol print {tempcorona}
		set tempfunnel=SUM(temp*funnel*dV*gdet)/funnelvol print {tempfunnel}
		print {tempdisk tempplunge tempcorona tempfunnel}
		#
scn1   0        #
		ctype default pl 0 B1 B3
		erase ctype default box points B1 B3
		set myB1=B1 if(rho>1E-3)
		set myB3=B3 if(rho>1E-3)
		#erase
		ctype default box ctype red points myB1 myB3
		#
		set my2B1=B1 if(rho<1E-3)
		set my2B3=B3 if(rho<1E-3)
		pl 0 my2B1 my2B3
		erase ctype default box ctype default points my2B1 my2B3
		#
		set lb1=LG(-my2B1) if((my2B1<0)&&(my2B3<0))
		set lb3=LG(-my2B3) if((my2B1<0)&&(my2B3<0))
		#
		pl 0 lb1 lb3
		#
		erase ctype default box ctype default points lb1 lb3
		xla "Log(B1)"
		yla "Log(B3)"
		#device postencap lb3vslb1.eps
		#device X11
		#
		# jre idealmhdcheck.m
		# use jrdpcf dump0040
		#
		#
imhdc1	0               # # d(gdet*b^i)/dt = -d/dj(emf^{ij}-4*pi*eta*J/c)		
		# emf^{ij} = b^j u^i - b^i u^j
		# db^i = gdet*b^i
		set emf11=0
		set emf12=gdet*(bu1*uu2-bu2*uu1)
		set emf13=gdet*(bu1*uu3-bu3*uu1)
		#
		set emf21=-emf12
		set emf22=0
		set emf23=gdet*(bu2*uu3-bu3*uu2)
		#
		set emf31=-emf13
		set emf32=-emf23
		set emf33=0
		#
		dercalc 0 emf12 emf12d
		dercalc 0 emf13 emf13d
		set emf21dx=-emf12dx
		set emf21dy=-emf12dy
		dercalc 0 emf23 emf23d
		set emf31dx=-emf13dx
		set emf31dy=-emf13dy
		set emf32dx=-emf23dx
		set emf32dy=-emf23dy
		#
		set db1=-(emf21dy) # other term phi dir, 0 derivative
		set db2=-(emf12dx) # ""
		set db3=-(emf13dx+emf23dy)
		#
		#
resist   0      # jre bzplots.m
		#
		set eta=234*sqrt(Tempunit*p/rho)
		set gam=2.75*10**13
		set resistpre=4*pi*eta/C
		set jres0=resistpre*ju0
		set jres1=resistpre*ju1
		set jres2=resistpre*ju2
		set jres3=resistpre*ju3
god1      0     #
