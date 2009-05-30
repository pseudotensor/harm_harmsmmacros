readkazeos 0    #
		#
		readaveryeos
		#
		#da eos.dat
		#
		#da ../runcoldsuperprec_zoomplusT_extendedrho/eos.dat
		da ../allpress/eos.dat
		lines 1 1000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {tdyn h rhob T nue nprat ptot etot stot Qsurf kpphoton kpelepos kpN kpnu}
		 #
		 set xnuc=30.97*(rhob/1E10)**(-3/4)*(T/1E10)**(9/8)*exp(-6.096*1E10/T)
		 set xnuc=(xnuc>1) ? 1 : xnuc
		 #
		 set taunse=rhob**(0.2)*exp(179.7*1E9/T-39)
		 # non-degen regime, high temp
		 set taunse2=(T/1E10)**(-5)
		 #
		 set kb=1.38E-16
		 set mue=nue*kb*T
		 # erg K^{-1} g^{-1}
		 set mp=1.67E-24
		 set me=9.11E-28
		 set R=kb/mp
		 set Re=kb/me
		 set c=2.99792458E10
		 set hpl=6.6262E-27
		 set a=5.6704E-5 * 4 / c
		 set K=1.24E15
		 set K2=9.9E12
		 #
		 #
		 set rhobfree=xnuc*rhob
		 set rhoalpha=(1-xnuc)*rhob
		 #
		 # fraction of free protons out of all free baryons
		 #set Yp=1/(1+nprat)
		 set myuse1=((rhob>3E9)&&(T>3*5.93E9)) ? 1 : 0
		 set myuse2=((rhob>3E9)&&(T<3*5.93E9)) ? 1 : 0
		 set myuse3=((rhob<3E9)) ? 1 : 0
		 #
		 set Yp=(myuse1) ? 1/100 : ((myuse2) ? 1/3.5 : 0.5)
		 # total number of protons
		 #set Yp=0.5
		 set rhop=Yp*rhobfree+rhoalpha/2
		 set np=1/mp*rhop
		 set ne=np
		 set rhoe=me*ne
		 #
		 set kfl=hpl/(me*c)*(3*ne/(8*pi))**(1/3)
		 set El=sqrt(kfl**2+1)
		 set K3=(2*pi)**3*(me*c/hpl)**3*me*c**2
		 set pcold=K3/(12.0*pi**2)*(El*kfl*(kfl**2-3/2)+3/2*LN(kfl+El))
		 #
		 set nemod=0.75
		 #set nemod=1.0
		 set pgase=ne*kb*T*nemod
		 #
		 set Twarm=kb*T/(me*c**2)
		 set Twarm=0
		 set phi3=0.63135521966483061017
		 set kfwarm=kfl-pi**2/6*(2*kfl**2+1)/kfl**3*(Twarm)**2-3/kfl**7*(Twarm)**4*phi3
		 set Ewarm=sqrt(kfwarm**2+1)
		 set pwarm0=K3/(12.0*pi**2)*(Ewarm*kfwarm*(kfwarm**2-3/2)+3/2*LN(kfwarm+Ewarm) + pi**2/2*kfwarm*Ewarm*Twarm**2+3*(3*Ewarm*kfwarm**2-Ewarm**3)/kfwarm**3*phi3*Twarm**4   )
		 #set pwarm0=pcold
		 set pwarm0=pwarm0-pgase
		 set pwarm=(kfwarm<0) ? 0 : pwarm0
		 set pwarm=(pwarm>pgase) ? pwarm : pgase
		 #
		 set num=(1+3.0*xnuc)/4
		 set pbaryon=rhob*R*T*num*1.0
		 set pphoton=(1/3)*a*T**4
		 #set prade= (7/12)*a*T**4
		 set nmod=1.1
		 #set nmod=0
		 set prade=(T>5.93E9) ? (7/12)*a*T**4 : (7/12)*a*T**(4+nmod)/(5.93E9)**nmod
		 set phote=(pgase>prade) ? pgase : prade
		 #set phote=(T
		 #set phote=(T<5.93E9) ? pgase : prade
		 #set phote=(T<(12*kb/(11*a))**(1/3)*ne**(1/3)) ? pgase : prade
		 #set phote= pgase + prade
		 set pelepos=pcold+phote
		 #set pelepos=pwarm+phote
		 #
		 set ptotsimple=pbaryon+pphoton+pelepos
		 #
		 #set pgassimple=rhob*R*T*num
		 #set pgassimple=(T>(12*kb/(11*a))**(1/3)*ne**(1/3)) ? pgassimple : pgassimple+
		 #set pradsimple=11/12*a*T**4
		 #set pradsimple=(1/3)*a*T**4
		 #set pelectronrad=(T<(12*kb/(11*a))**(1/3)*ne**(1/3)) ? 0 : (11/12-1/3)*a*T**4
		 #set pradsimple=(T<5.93E9) ? pradsimple :  pradsimple+pelectronrad
		 #set pradsimple=(T>1E12) ? (7/8)*a*T**4 : pradsimple
		 #set pradsimple=(1/3)*a*T**4
		 #set pedegsimple=K*(rhob/2)**(4/3)
		 #set pedegsimple2=K2*(rhob/2)**(5/3)
		 #set pedegsimple2=pcold
		 #set ptotsimple=pgassimple+pradsimple+pedegsimple2
		 #set pgassimple=pgassimple*0
		 #set ptotsimple=pgassimple+pradsimple+pcold
		 #set ptotsimple=pgassimple+iaP
		 #set ptotsimple=ptotsimple*1E-7
		 #
		 #
		 #
		 set Ye=1/(1+nprat)
		 #
		 #
		 #set myuse=((rhob>1E3)&&(rhob<3E3)) ? 1 : 0
		 #set myuse=(rhob<1E8) ? 1 : 0
		 #set myuse=(rhob>1E7) ? 1 : 0
		 #set myuse=((rhob<2E2)) ? 1 : 0
		 set myuse=rhob*0+1
		 #
		 #set myuse=((rhob>50)&&(rhob<150)) ? 1 : 0
		 #
		 #set myuse=(T<1E9) ? myuse : 0
		 #
		 set mytdyn=tdyn if(myuse)
		 set myh=h if(myuse)
		 set myrhob=rhob if(myuse)
		 set myT=T if(myuse)
		 set mynue=nue if(myuse)
		 set mymue=mue if(myuse)
		 set mynprat=nprat if(myuse)
		 set myYe=Ye if(myuse)
		 set myptot=ptot if(myuse)
		 set myetot=etot if(myuse)
		 set mystot=stot if(myuse)
		 set myQsurf=Qsurf if(myuse)
		 set myxnuc=xnuc if(myuse)
		 set mytaunse=taunse if(myuse)
		 #
		 set mypbaryon = pbaryon if(myuse)
		 set mypphoton = pphoton if(myuse)
		 set mypgase = pgase if(myuse)
		 set myprade = prade if(myuse)
		 set myphote = phote if(myuse)
		 set mypelepos = pelepos if(myuse)
		 #
		 set myptotsimple=ptotsimple if(myuse)
		 #
		 #ctype red pl 0 myT myYe 1011 1E2 1E12 -1 2
		 #ctype default pl 0 myT myYe 1001 1E2 1E12 -1 2
		 #ctype default pl 0 myT mynprat 1001 1E2 1E12 -1 2
		 #
pvst 0           # 
		 #
		 lweight 3
		 #
		 #set myaP=aP if(myuse)
		 #set myptotsimple=mypgassimple+mypradsimple+myaP
		 #
		 #ctype blue pl 0 myT mypgassimple 1100
		 #ctype green pl 0 myT mypradsimple 1110
		 #ctype yellow pl 0 myT mypedegsimple 1110
		 #ctype yellow pl 0 myT mypedegsimple2 1110
		 #
		 ctype default pl 0 myT myptot 1110
		 ctype red pl 0 myT myptotsimple 1110
		 #
		 #
		 ctype cyan pl 0 aTe aP 1110
		 #
diffpvst 0       #
		set myptot=myptot-kpnu
		#set perdiff=(myptot-myptotsimple)/myptot
		set perdiff=(kpelepos-pelepos)/myptot
		#set perdiff=(kpphoton-pphoton)/myptot
		#set perdiff=(kpN-pbaryon)/myptot
		jre punsly.m
		#ctype default plsplit 0 myT perdiff 1101 
		ticksize 0 0 -1 0
		#limits 2 12 -6 6
		#limits 2 12 -2 2
		limits -2 2 2 13
		erase
		box
		#ctype red connect (LG(myT)) (LG(ABS(perdiff))) if((myT>1E5)&&(perdiff>0))
		#ctype default connect (LG(myT)) (LG(ABS(perdiff))) if((myT>1E5)&&(perdiff<=0))
		set newy=(LG(myT))
		set newx=(perdiff)
		#
		ctype default connect newx newy if((myT>1E5)&&(myrhob<1E6))
		ctype default points newx newy if((myT>1E5)&&(myrhob<1E6))
		#
		ctype red connect newx newy if((myT>1E5)&&(myrhob>1E6)&&(myrhob<1E9))
		ctype red points newx newy if((myT>1E5)&&(myrhob>1E6)&&(myrhob<1E9))
		#
		ctype cyan connect newx newy if((myT>1E5)&&(myrhob>1E9))
		ctype cyan points newx newy if((myT>1E5)&&(myrhob>1E9))
		#
		#ctype default connect (LG(myT)) (perdiff) if((myT>1E5)&&(perdiff<=0))
		#ctype default plsplit 0 myT perdiff 1101 1E2 1E9 1E-15 1E5
		 #
readaveryeos 0   #
		#
		# cd /home/jon/research/kaz/fdgas2/EOS/
		# ./eos_tester
		# sed 's/nan/-1/' foonew.txt > averyeosnew.dat
		#
		da /home/jon/research/kaz/fdgas2/EOS/averyeosnew.dat
		lines 1 1000000
		read '%g %g %g %g %g %g %g %g %g' {aTe arho0 arhof arho aP aPnr aPur aPdeg amue}
		#
electronpress 0 #
		ctype default pl 0 T pgase 1100
		points (LG(T)) (LG(pgase))
		ctype red pl 0 T prade 1110
		#
		#set myfun=rhobfree
		#set myfun=Yp
		set myfun=ne
		set goduse=(rhob<1E7) ? 1 : 0
		set godfun=myfun if(goduse)
		set godT=T if(goduse)
		ctype default pl 0 godT godfun 1100
		points (LG(godT)) (LG(godfun))
		#points (LG(godT)) godfun
		#
diffpelepos 0   #
		#
		ctype default pl 0 T pelepos 1100
		ctype red pl 0 T kpelepos 1110
		#
