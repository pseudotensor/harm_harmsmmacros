		jrdp dump1290
		stresscalc 1
   set vanal=1E-4*r/(1+1E-4*_t)
   set uanal=1E-13/(1+1E-4*_t)**($gam)
   set rhoanal=1/(1+1E-4*_t)
   set vtrue=v1/uu0*sqrt(gv311)
   set vrat=vtrue/vanal
   set urat=u/uanal
   set rhorat=rho/rhoanal
   set vdiff=(vtrue-vanal)/vanal
   set udiff=(u-uanal)/uanal
   set rhodiff=(rho-rhoanal)/rhoanal
   set ludiff=LG(ABS(udiff))
   set lrhodiff=LG(ABS(rhodiff))
   set lvdiff=LG(ABS(vdiff))
		#
		set t=_t
		set a=1E-4
		set b=1E-13
		set gam=$gam
		#
		set vm=vanal*uu0/sqrt(gv311)
		set Tud11analother=(rhoanal+uanal+($gam-1)*uanal)*gv311*vm**2+p
		set Tud11ratother=Tud11/Tud11analother
		#
		set Tud11anal=(a**2*r**2*uu0**2)/(1 + a*t)**3 + b*(1/(1 + a*t))**gam*(-1 + gam + (a**2*gam*r**2*uu0**2)/(1 + a*t)**2)
		set Tud11diff=(Tud11-Tud11anal)/Tud11anal
		set Tud11rat=Tud11/Tud11anal
		#
		#
		set dTud11dranal=dxdxp11*((2*a**2*r*(1 + b*gam*(1/(1 + a*t))**(-1 + gam))*uu0**2)/(1 + a*t)**3)
		set tiold=ti
		set tjold=tj
		set ti=ti+3
		set tj=tj+3
		dercalc 0 Tud11 Tud11d
		set dTuddrdiff=(Tud11dx-dTud11dranal)/dTud11dranal
   #

		#
		#
		set myuse=((ti!=0)&&(tj==0)) ? 1 : 0
		set mynewr=r if(myuse)
		#
		set Tud10mrmanal=(a*r*uu0)/(sqrt(gv311)*(1 + a*t)**2) - (a*r*(1 + b*gam*(1/(1 + a*t))**(-1 + gam))*uu0**2)/(sqrt(gv311)*(1 + a*t)**2)
		dercalc 0 Tud10mrmanal dTud10mrmanal
		#
		#
		set Tud10mrm=(Tud10+rho*uu1)
		dercalc 0 Tud10mrm Tud10mrmd
		set Tud10mrmdx=Tud10mrmdx if(myuse)
		#
		set Tud10diff=(Tud10mrm-Tud10mrmanal)/Tud10mrmanal
		set Tud10rat=Tud10mrm/Tud10mrmanal
		#
		#set dTud10mrmanal=-dxdxp11*((a*uu0*(-1 + uu0 + b*gam*(1/(1 + a*t))**(-1 + gam)*uu0))/(sqrt(gv311)*(1 + a*t)**2))
		#
		set dTud10mrmanal=dxdxp11*(-((a**2*r*(1 + b*gam*(1/(1 + a*t))**(-1 + gam)))/(sqrt(gv311)*(-1 + a*(r - t))*(1 + a*(r + t))**2)) - \
		  (a**2*r*(1 + b*gam*(1/(1 + a*t))**(-1 + gam)))/(sqrt(gv311)*(-1 + a*(r - t))**2*(1 + a*(r + t))) + \
		      (a*(1 + b*gam*(1/(1 + a*t))**(-1 + gam)))/(sqrt(gv311)*(-1 + a*(r - t))*(1 + a*(r + t))) + \
		      (a**3*r**2)/(sqrt(gv311)*(1 + a*t)**4*(1 - (a**2*r**2)/(1 + a*t)**2)**1.5) + \
		      a/(sqrt(gv311)*(1 + a*t)**2*sqrt(1 - (a**2*r**2)/(1 + a*t)**2))) if(myuse)
		#
		#
		set dTud10diff=(Tud10mrmdx-dTud10mrmanal)/dTud10mrmanal
		set dTud10rat=Tud10mrmdx/dTud10mrmanal
		#
		set rat=dTud10mrmanal/Tud10mrmdx
		#pl 0 mynewr rat
		#
		#set rattest=dTud10mrmanalx/Tud10mrmdx
		#pl 0 mynewr rattest
		#
		set ldTud10diff=LG(ABS(dTud10diff))
		#ctype default pl 0 mynewr ldTud10diff 0001 -11 -5 -10 0
		#ctype red pl 0 mynewr ldTud10diff 0010
		#ctype blue pl 0 mynewr ldTud10diff 0010
		#
		ctype default pl 0 mynewr dTud10diff 0001 -11 -5 -10 10
		#ctype red pl 0 mynewr dTud10diff 0011 -11 -5 -1E-4 1E-4
		#ctype blue pl 0 mynewr dTud10diff 0011 -11 -5 -1E-4 1E-4
		#
		#
		#
		#set startanim=50 set endanim=57 agpl 'dump' r lvdiff 0001 -11 11 -20 0
		#set startanim=50 set endanim=57 agpl 'dump' r vdiff
		#set startanim=0 set endanim=130 agpl 'dump' r ludiff 0001 -11 11 -20 0
