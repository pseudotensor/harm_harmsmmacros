mw99test1 0     #
		set n1=-.566
		set b1=14.1
		set mwz=Lunit*r*cos(h)
		set mwhor=0.4
		set mwtemp=(r*Lunit)**n1*10**b1*exp(-mwz**2/(2*(Lunit*r*mwhor)**2))
		set n2=-1.55
		set b2=19.26
		set mwrho=(r*Lunit)**n2*10**b2*exp(-mwz**2/(2*(Lunit*r*mwhor)**2))
		set mwu=mwrho*kb*mwtemp/mb/(4/3-1)
		#
		set rho=mwrho/rho0
		set u=mwu/(rho0*C**2)
		set temp=mwtemp/Tempunit
		#
grbunits 0      #
		# mass of baryon
		set mb=mn
		# size of bh
		set M = 3*msun
		# physical mdot
		#set Mdot=0.07*msun # MW99
		set Mdot=10*msun # NS-NS BH-NS
		#set Mdot=0.4*msun # proga03/04 
		# average mdot in code units
		#set Mdotc=0.35 # fiducial 456^2
		set Mdotc=.178
		#
agnunits 0 #
		# mass of baryon
		set mb=mn
		# size of bh
		set M = 3*10**9*msun
		# physical mdot
		set ledd=4*pi*C*G*M*mb/sigmamat
		set Mdot=ledd/(1-tdeinfisco)/C**2
		# average mdot in code units
		set Mdotc=0.35
		#
doagn      0  #
		consts0
		agnunits
		neutrinos1
		neutrinos2
		neutrinos3
		neutrinos4
		neutrinos5
		#
dogrb      0  #
		consts0
		grbunits
		neutrinos1
		neutrinos2
		neutrinos3
		neutrinos4
		neutrinos5
		#
consts0    0  #
		# cgs
		#
		#
		set msun=1.989E33
		set lsun=3.89E33
		set G=6.672E-8
		set H=6.6262E-27
		set C=2.99792458E10
		set mn=1.675*10**(-24)
		set me=9.10938188E-28
		set kb=1.3807*10**(-16)
		set arad=8*pi**5*kb**4/(15*C**3*H**3)
		set sigmasb=arad*C/4
		set sigmamat=6.652E-29*100**2
		set mevocsq=1.783E-27
		set ergPmev=1.602E-6
		#
neutrinos1
		#
		set Lunit=G*M/C**2
		set Tunit=G*M/C**3
		set rho0=Mdot/Mdotc/Lunit**2/C
		set Munit=rho0*Lunit**3
		#
		set mdotunit=Munit/Tunit
		set energyunit=Munit*C**2
		set edotunit=energyunit/Tunit
		set edotomdotunit=edotunit/mdotunit
		set ldotomdotunit=G*M/C
		set Pressureunit=rho0*C**2
		set Tempunit=Pressureunit/rho0*mb/kb
		set Bunit=C*sqrt(rho0)
		#
		set massunitPmsun=1.24497E-72*M*Mdot/Mdotc
		#
		# physics stuff
		set ledd=4*pi*C*G*M*mb/sigmamat
		set leddcode=ledd/edotunit
		set Tcode=p/rho
		set Tk=Tcode*Tempunit
		set Tmev=kb*Tk/ergPmev
		#
		#set Xnuccode0=26*(Tcode*Tempunit*kb/ergPmev)**(9/8)/(rho*rho0/1E10)**(3/4)*exp(-7.074/(Tcode*Tempunit*kb/ergPmev))
		set Xnuccode0=30.97*(Tk/1E10)**(9.0/8.0)*(rho*rho0/1.E10)**(-3.0/4.0)*exp(-6.096/(Tk/1E10))
		set Xnuccode=(Xnuccode0>1) ? 1 : Xnuccode0
		set epaircap=9E33*(Tcode*Tempunit/1E11)**6*(rho*rho0/1E10)*Xnuccode
		set epaircapcode=epaircap/(rho0*C**2/Tunit)
		#
		set epaircaplum=-SUM(gdet*epaircapcode*ud0*uu0*dV)*edotunit print {epaircaplum}
		set epaircapcodedisk=((r>2*$rhor)&&(rho>1E-2)&&((h-pi/2)<0.3)) ? epaircapcode : 0
		set epaircapdisklum=-SUM(gdet*epaircapcodedisk*ud0*uu0*dV)*edotunit print {epaircapdisklum}
		set Prad=1/3*arad*(Tcode*Tempunit)**4
		set Pradcode=Prad/Pressureunit
		set rhorad=arad*(Tcode*Tempunit)**4/C**2
		set rhoradcode=rhorad/rho0
		#
		# Kohri & Mineshige 2002 / Lee, Ramirez-Ruiz & Page 2004 astro-ph/0404566
		set epaircap2=1.1E31*(3)**9*(Tk/1E11)**9
		set epaircap2code=epaircap2/(rho0*C**2/Tunit)
		set epaircap2lum=-SUM(gdet*epaircap2code*ud0*uu0*dV)*edotunit print {epaircap2lum}
		#
itohgen 0      # all of Itoh's formulas
		set swsq=0.2319
		set cv=1/2+2*swsq
		set ca=1/2
		set cvp=1-cv
		set cap=1-ca
		set mue=2
		set nf=2
		set lambda=Tk/(5.9302E9)
		set xi=(rho*rho0/mue/1E9)**(1/3)/lambda
		#
itohpair 0      # e- e+ pair annihilation into neutrinos
		itohgen
		set a0=6.002E19
		set a1=2.084E20
		set a2=1.872E21
		set b1=(Tk<1E10) ? 9.383E-1 : 1.2383
		set b2=(Tk<1E10) ? -4.141E-1 : -0.8141
		set b3=(Tk<1E10) ? 5.829E-2 : 0
		set c1=(Tk<1E10) ? 5.5924 : 4.9924
		set glambda=1-13.04*lambda**2+133.5*lambda**4+1534*lambda**6+918.6*lambda**8
		set fpair=(a0+a1*xi+a2*xi**2)*exp(-c1*xi)/(xi**3+b1/lambda+b2/lambda**2+b3/lambda**3)
		set qpair=(10.7480*lambda**2+0.3967*lambda**(0.5)+1.0050)**(-1.00)*(1+(rho*rho0/mue)*(7.692E7*lambda**3+9.715E6*lambda**(0.5))**(-1.0))**(-0.3)
		set Qpair=1/2*((cv**2+ca**2)+nf*(cvp**2+cap**2))*(1+((cv**2-ca**2)+nf*(cvp**2+cap**2))*qpair/((cv**2+ca**2)+nf*(cvp**2+cap**2)))*glambda*exp(-2/lambda)*fpair
		set Qpaircode=Qpair/(edotunit/Lunit**3)
		set qpairtot=-SUM(gdet*dV*Qpaircode*ud0*uu0)*edotunit print {qpairtot}
		#
itohplasma 0    #
		itohgen
		#
		# whether valid or not, needs to be fully e degenerate (i.e. well below fermi T of electrons)
		set Tfe=5.9302E9*((1+1.018*(rho0*rho/1E6/mue)**(2/3))**(1/2)-1)
		# so the below ratio should be >> 1 to be below Tf
		set Tfok=Tfe/Tk
		#
		set pgam=sqrt(1.1095E11*rho0*rho/mue/(Tk**2*(1+(1.019E-6*rho0*rho/mue)**(2/3))**(1/2)))
		set ft=2.4+0.6*sqrt(pgam)+0.51*pgam+1.25*pgam**(3/2)
		set fl=(8.6*pgam**2+1.35*pgam**(7/2))/(225-17*pgam+pgam**2)
		set xp=1/6*(+17.5+LG(2*rho0*rho/mue)-3*LG(Tk))
		set yp=1/6*(-24.5+LG(2*rho0*rho/mue)+3*LG(Tk))
		set minfun=yp-1.6+1.25*xp
		set minf=(minfun>0) ? 0 : minfun
		set fxy2=1.05+(0.39-1.25*xp-0.35*sin(4.5*xp)-0.3*exp(-(4.5*xp+0.9)**2))*exp(-(minf/(0.57-0.25*xp))**2)
		set fxy=(ABS(xp)>0.7 || yp<0) ? 1 : fxy2
		set Qv=3.00E21*lambda**9*pgam**6*exp(-pgam)*(ft+fl)*fxy
		set Qplasma=(cv**2+nf*cvp**2)*Qv
		set Qplasmacode=Qplasma/(edotunit/Lunit**3)
		set qplasmatot=-SUM(gdet*dV*Qplasmacode*ud0*uu0)*edotunit print {qplasmatot}
		#
		#
neutrinos2  0   #
		#
		#
		#
		set masstot=SUM(gdet*rho*uu0*dV)*massunitPmsun
		set numbaryons=SUM(gdet*rho*uu0*dV)*Munit/mb
		print {masstot numbaryons}
		set baryondensity=rho*uu0*rho0/mb
		#
		# energy of disk in ergs per 10**51
		set energyP51=energyunit*1E-51
		set massetot=-SUM(gdet*rho*uu0*ud0*dV)*energyP51
		set ietot=-SUM(gdet*u*uu0*ud0*dV)*energyP51
		set ietot2=-SUM(gdet*u*dV)*energyP51
		set petot=-SUM(gdet*p*uu0*ud0*dV)*energyP51
		set betot=-SUM(gdet*bsq*uu0*ud0*dV)*energyP51
		set balftot=-SUM(gdet*bu0*bd0*dV)*energyP51
		print {massetot ietot petot betot balftot}
		#
		itohpair
		itohplasma
		#		
		set ielasts=ietot*1E51/epaircaplum
		set ielasts2=ietot*1E51/epaircapdisklum
		set ielasts3=ietot*1E51/(qpairtot+qplasmatot)
		print {ielasts ielasts2 ielasts3}
		set tauorbit=2*pi/(12**(3/2)+a)*Tunit
		set numorbitsielasts=ielasts3/tauorbit
		print {tauorbitten numorbitsielasts}
		#
neutrinos3 0    # just radiation actually
		#
		# Rosseland mean opacity in cm^2/gram
		set KR=0.4+0.64E23*(rho*rho0)*Tk**(-3)
		set zhere=ABS(r*Lunit*cos(h))
		set ztogo=0.26*ABS(r*Lunit)
		set tautot=KR*(rho*rho0)*ABS(ztogo-zhere)
		#
		plc 0 tautot
		set lev=1,1.001,.001
		levels lev
		ctype blue contour
		#
		# below sigmasb is same as in neutrinos1
		#set sigmasb=pi**2*kb**4/(60*H**3*C**2/(2*pi)**3)
		# per 1E51 ergs/sec out of each element
		set radarea=pi*Lunit**2*(40**2-6**2)
		set qrad=2*sigmasb*Tk**4/(2*tautot)*radarea/1E51
		#
		set myqrad=qrad if(tj==$ny/2)
		set totqrad=SUM(myqrad) print{totqrad}
		#
		#
neutrinos4   0  # Kohri & Mineshige 2002
		#
		# degen e and degen n
		set etae=6.628*(rho0*rho/1E13)**(2/3)*ergPmev/(kb*Tk)
		# approx
		set etae=10*ergPmev/(kb*Tk)
		set etae=5
		# as from Itoh plasma process above in neutrino2
		set Tfe=5.9302E9*((1+1.018*(rho0*rho/1E6/mue)**(2/3))**(1/2)-1)
		# so the below ratio should be >> 1 to be below Tf
		set Tfok=Tfe/Tk
		#
		set etae=Tfok
		# nondegenerate electrons
		set qdotne1=9.2E33*(Tk/1E11)**6*(rho0*rho/1E10)
		# degenerate electrons
		set qdotne2=1.1E31*etae**9*(Tk/1E11)**9
		# degenerate e and n
		set qdotne3=5.0E32*etae**7*(Tk/1E11)**9
		# e- e+ ann (itoh)
		set qdotee1=4.8E33*(Tk/1E11)**9
		# degenerate e
		set qdotee2=0*Tk
		#
		# rest are pretty small
		# n-n brem , degen. n
		set qdotnn1=3.4E33*(Tk/1E11)**8*(rho0*rho/1E13)**(1/3)
		# n-n brem , non-degen. n
		set qdotnn2=1.5E33*(Tk/1E11)**(5.5)*(rho0*rho/1E13)**2
		# high rho and high e degen.
		set gammap=5.565E-2*((pi**2+3*etae**2)/3)**(1/2)
		set qdotplasmon=1.5E32*(Tk/1E11)**9*gammap**6*exp(-gammap)*(1+gammap)*(2+gammap**2/(1+gammap))
		#
neutrinos5  0   # optical depth of neutrinos
		diskhorcalc $rhor Rout rin rmax HOR
		set zhere=ABS(r*Lunit*cos(h))
		set ztogo=HOR*ABS(r*Lunit)
		set height=ABS(ztogo-zhere)
		set ntaua1=2.5E-7*(Tk/1E11)**(5.0)*height
		set ntaua2=4.5E-7*Xnuccode*(Tk/1E11)**2 *(rho0*rho/1E10)*height
		set ntauatot=ntaua1+ntaua2
		set ntaus=2.7E-7*(Tk/1E11)**2 *(rho0*rho/1E10)*height
		set ntautot=ntaua1+ntaua2+ntaus
		set EXT=exp(-ntautot)
		#
		plc 0 ntautot
		set lev=1,1.01,0.01
		levels lev ctype blue contour
		#
		#
neutrinos6 0    # determine significance of each pressure term
		#
		# radiation pressure
		set prad1=3/4*arad*Tk**4
		set prad2=11/12*arad*Tk**4
		set pgas=1/3*u*Pressureunit
		set pgas2=rho0*rho*kb*Tk/mb*(0.25*(1+3*Xnuccode))
		set pgas3=p*Pressureunit
		set pdeg=2*pi*H*C/3*(3*rho0*rho/(mue*8*pi*mb))**(4/3)
		# from di matteo perna narayan 2002
		# 6 neutrino flavors
		set uv=7/8*arad*Tk**4*(6)*(ntautot/2+1/sqrt(3))/(ntautot/2+1/sqrt(3)+1/(3*ntauatot))
		set pneut=uv/3
		#
		set prat=prad/(prad+pgas)
		set rhorad=1.2316E6*temp**4
		#
		# estimate photodisintegration cooling PWF way
		dercalc 0 Xnuccode dX
		set qphoto=1E29*(rho0*rho/1E10)*uu1/uu0*dXx
		#
		#
neutrinos7  0   # degeneracy conditions
		#
		# nonrel. deg condition, below >> 1
		set degcon1=(rho0*rho/mb)/(mb*kb*Tk/(2*pi*H**2/(2*pi)**2))**(3/2)
		# below >> 1
		set trat1=(mb*C**2)/(kb*Tk)
		#
		
