readkazeos 0    #
		# some constants
		set kb=1.38E-16
		# erg K^{-1} g^{-1}
		set mp=1.67262E-24
		set mn=1.67493E-24
		set Q=(mn-mp)*c**2
		set me=9.11E-28
		set R=kb/mp
		set Re=kb/me
		set c=2.99792458E10
		set hpl=6.6262E-27
		set hbar=hpl/(2*pi)
		set a=5.6704E-5 * 4 / c
		set K=1.24E15
		set K2=9.9E12
		#
		#
		readaveryeos
		#
		#da eos.dat
		#
		#da ../runcoldsuperprec_zoomplusT_extendedrho/eos.dat
		#da ../allpress/eos.dat
		da ../allpress_xnuc/eos.dat
		lines 1 1000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {tdyn h rhob T ketae nprat ptot etot stot Qsurf kpphoton kpelepos kpN kpnu}
		#
		set kmue=ketae*kb*T
		#
		set Qvol=Qsurf/h
		set lQvol=lg(Qvol)
		#
		#PWF99 (different from all)
		set xnuc0=30.97*(rhob/1E10)**(-3/4)*(T/1E10)**(9/8)*exp(-6.096*1E10/T)
		# from Kohri
		# xnuc1 and xnuc2 same
		set xnuc1=22.16*(rhob/1E10)**(-3/4)*(T/1E10)**(1.125)*exp(-8.209*1E10/T)
		set xnuc2=295.5*(rhob/1E10)**(-3/4)*(T/1E11)**(9/8)*exp(-0.8209*1E11/T)
		# dimatteo (different from all)
		set xnuc3=34.8*(rhob/1E10)**(-3/4)*(T/1E11)**(9/8)*exp(-0.61*1E11/T)
		# print {xnuc xnuc1 xnuc2 xnuc3}
		#
		# use Kohri
		set xnuc=xnuc1
		set xnuc=(xnuc>1) ? 1 : xnuc
		#
		da betaeq.dat
		lines 1 1000000
		read '%g' {jetae}
		#
		set jmue=jetae*(kb*T)
		set ljmu=LG(jmue)
		set ljetae=LG(jetae)
		#
		# see if Kaz and I get same nue
		#print {T rhob jetae ketae}
		#
		set taunse=rhob**(0.2)*exp(179.7*1E9/T-39)
		# non-degen regime, high temp
		set taunse2=(T/1E10)**(-5)
		#
		#
		set rhobfree=xnuc*rhob
		set rhoalpha=(1-xnuc)*rhob
		#
		# fraction of free protons out of all free baryons
		set Yptrue=1/(1+nprat)
		#
		#
		#
		# from surfYp and plc 0 Yptrue plot
		#
		#
		if(1){\
		 set lgrhob=LG(rhob)
		 set lgT=lg(T)
		 #
		 # lower left corner
		 set myuse1=((lgrhob<=7.0)&&(lgT<9.45)) ? 1 : 0
		 # lower middle band
		 #set myuse2=((lgrhob<7.0)&&(lgT<11.2)&&(lgT>9.45)) ? 1 : 0
		 # right part
		 set myuse3=((lgT>9.45)&&(lgrhob<2.88*(lgT-9.74)+7.3)) ? 1 : 0
		 # left upper part
		 set myuse4=((lgrhob>7.0)&&(lgrhob>2.88*(lgT-9.74)+7.3)) ? 1 : 0
		 #
		 #set lgT=LG(T)
		 #set lgr=LG(rhob)
		 #set slope=(11.9782-8.30982)/(10.2258-9.31292)
		 #set fun=8.30982+slope*(lgT-9.31292)
		 #set myuse4=((rhob>10**8.3)&&(lgr>fun)) ? 1 : 0
		 #
		 set Ypfalse=(myuse1) ? 1.0 : ( (myuse3) ? 0.5 : ( (myuse4) ? 1E-3 : 1E30 ) )
		 #
		 set Yp=Ypfalse
		 #
		}
		#
		if(0){\
		 set Yp=Yptrue
		}
		#
		# overwrite Kaz answer
		# number of free neutrons to free protons
		set nprat=(1-Yp)/Yp
		#
		# total number of protons
		set rhop=Yp*rhobfree+rhoalpha/2
		# Yp = rhopfree/rhobfree
		set rhopfree=Yp*rhobfree
		set npfree=rhopfree/mp
		set np=1/mp*rhop
		set ne=np
		# fully ionized electrons
		set nefree=ne
		set rhoe=me*ne
		#
		set nnfree=nprat*npfree
		#
		#
		#
		set kfl=hpl/(me*c)*(3*ne/(8*pi))**(1/3)
		set El=sqrt(kfl**2+1)
		set K3=(2*pi)**3*(me*c/hpl)**3*me*c**2
		set pcold=K3/(12.0*pi**2)*(El*kfl*(kfl**2-3/2)+3/2*LN(kfl+El))
		#
		#set nemod=0.75
		set nemod=1.0
		set pgase=ne*kb*T*nemod
		#
		set Twarm=kb*T/(me*c**2)
		#set Twarm=0
		set phi3=0.63135521966483061017
		set kfwarm=kfl-pi**2/6*(2*kfl**2+1)/kfl**3*(Twarm)**2-3/kfl**7*(Twarm)**4*phi3
		set Ewarm=sqrt(kfwarm**2+1)
		set pwarm0=K3/(12.0*pi**2)*(Ewarm*kfwarm*(kfwarm**2-3/2)+3/2*LN(kfwarm+Ewarm) + 4.0*(pi**2/2*kfwarm*Ewarm*Twarm**2+3*(3*Ewarm*kfwarm**2-Ewarm**3)/kfwarm**3*phi3*Twarm**4)   )
		#set pwarm0=pcold
		#set pwarm0=pwarm0-pgase
		set pwarm=(kfwarm<0) ? 0 : pwarm0
		#
		# baryons
		#set nmod=1.1
		set nmod=1.0
		set num=nmod*(1+3.0*xnuc)/4
		set pbaryon=rhob*R*T*num
		set pphoton=(1/3)*a*T**4
		#
		set nmod=1.1
		#set nmod=0
		set prade=(T>5.93E9) ? (7/12)*a*T**4 : (7/12)*a*T**(4+nmod)/(5.93E9)**nmod
		#
		# hot electrons
		set phote=(pgase>prade) ? pgase : prade
		set pelepos=(pwarm>phote) ? pwarm : phote
		#set pelepos=pcold+phote
		#set pelepos=pwarm+phote
		#
		set ptotsimple=pbaryon+pphoton+pelepos
		#
		set ppwfsimple=pbaryon + 11/12*a*T**4 + 1.24E15*(rhob/2)**(4/3)
		#
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
		#
		#
		set lgQ=LG(Qsurf)
		#
		#set nefree=
		#set kflfree=hpl/(me*c)*(3*ne/(8*pi))**(1/3)
		#set etae=Ewarm*me*c**2/(kb*T)
		#set etae=El*me*c**2/(kb*T)
		#
		set ndegrel=2*(kb*T/(hbar*c))**3/pi**3
		set ndegnonreln=2*(mn*kb*T/(2*pi*hbar**2))**(3/2)
		set ndegnonrele=2*(me*kb*T/(2*pi*hbar**2))**(3/2)
		#
		# degeneracy parameter
		set ndege=(kb*T>me*c**2) ? ndegrel : ndegnonrele
		set ndegn=(kb*T>mn*c**2) ? ndegrel : ndegnonreln
		#
		set neisdeg=(nefree>ndege) ? 1 : 0
		#
		set QNenondegval=9.2E33*(T/1E11)**6*(rhobfree/1E10)
		set QNenondeg=QNenondegval*(1-neisdeg)
		set QNedeg = 1.1E31*etae**9*(T/1E11)**9*neisdeg
		#set QNedeg = QNenondeg
		#set QNe = QNedeg*neisdeg + QNenondeg*(1-neisdeg)
		set QNe = QNedeg + QNenondeg
		set QNefake =QNenondegval
		#
		#
		set Qepnondeg=4.8E33*(T/1E11)**9
		set Qepdeg = 0*T
		set Qep = (nefree>ndege) ? Qepdeg : Qepnondeg
		set Qbremdeg=3.4E33*(T/1E11)**8*(rhobfree/1E13)**(1/3)
		set Qbremnondeg=1.5E33*(T/1E11)*5.5*(rhobfree/1E13)**2
		set Qbrem=(nnfree>ndegnonreln) ? Qbremdeg : Qbremnondeg
		set gamp=5.565E-2*sqrt( (pi**2+3*etae**2)/3 )
		set Qplasmon=1.5E32*(T/1E11)**9*gamp**6*exp(-gamp)*(1+gamp)*(2+gamp**2/(1+gamp))
		#
		#set Qsimplest=QNenondeg+QNedeg+Qepnondeg+Qepdeg+Qbremdeg+Qbremnondeg+Qplasmon
		set Qsimplest=QNe+Qep+Qbrem+Qplasmon
		#
		set lQsimp=LG(Qsimplest)
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
		 set myetae=etae if(myuse)
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
		 #
		 # 
competae 0        #compare etae's
		 #
		 ctype default pl 0 T ketae 1100
		 ctype red pl 0 T jetae 1110
		 #
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
		 set doconnect=((myT<1E12)&&(myT>1E6)) ? 1 : 0
		 #
		 ctype default plt 0 myT myptot 1100
		 ctype red plt 0 myT myptotsimple 1110
		 #
		 ctype cyan plt 0 myT pbaryon 1110
		 ctype green plt 0 myT pphoton 1110
		 ctype blue plt 0 myT pelepos 1110
		 #
		 #
		 #ctype cyan plt 0 aTe aP 1110
		 #
Qvst 0         #
		 set doconnect=((T<1E12)&&(T>1E6)) ? 1 : 0
		 define x2label "Q"
		 define x1label "T"
		 #
		 #ctype red plt 0 T Qsimplest 1101 1E10 1E12 1E27 1E42
		 #ctype default plt 0 T Qvol 1111 1E10 1E12 1E27 1E42
		 ctype red plt 0 T Qsimplest 1101 1E8 1E12 1E27 1E42
		 ctype default plt 0 T Qvol 1111 1E8 1E12 1E27 1E42
		 #ctype red plt 0 T Qsimplest 1110
		 #
		 #ctype cyan plt 0 T QNe 1110
		 #ctype green plt 0 T Qep 1110
		 #ctype magenta plt 0 T Qbrem 1110
		 #ctype yellow plt 0 T Qplasmon 1110
		 #ctype cyan plt 0 T QNenondeg 1110
		 #ctype green plt 0 T QNedeg 1110
		 #ctype yellow plt 0 T Qepnondeg 1110
		 #ctype yellow plt 0 T Qepdeg 1110
		 #ctype yellow plt 0 T Qbremdeg 1110
		 #ctype yellow plt 0 T Qbremnondeg 1110
		 #ctype yellow plt 0 T Qbrem 1110
		 #ctype yellow plt 0 T Qplasmon 1110
		 #
		 #
		 #
		 #QNenondeg
		#QNedeg
		#Qepnondeg
		#Qepdeg
		#Qbremdeg
		#Qbremnondeg
		#Qplasmon
		#
		#Qsimplest
		#
		#lgQsimplest=LG(Qsimplest)
		#
		#
impor2 0        #
		set important=(Qsimplest>1E27) ? 1 : 0
		set Qi=Qsimplest*important
		set Qvi=Qvol*important
		#
		set doconnect=((T<1E12)&&(T>1E6)) ? 1 : 0
		define x2label "Q"
		define x1label "T"
		#
		ctype default plt 0 T Qvi 1101 1E10 1E12 1E27 1E42
		ctype red plt 0 T Qi 1111 1E10 1E12 1E27 1E42
		ctype red plt 0 T Qsimplest 1111 1E10 1E12 1E27 1E42
		#
impor 0        #
		# figure out which one is dominant
		#
		# QNe always dominates Qbrem in important regime
 		# Qep and QNe have different regimes of importance
		# plasmon weak
		#
		 #
		 define POSCONTCOLOR red
		 define NEGCONTCOLOR default
		 define BOXCOLOR default
		 define POSCONTLTYPE 0
		 plc 0 important
		 #
		 set rat=(QNe/(Qsimplest+1E-30)>0.2) ? 1 : 0
		 define POSCONTCOLOR blue
		 define NEGCONTCOLOR blue
		 define BOXCOLOR default
		 define POSCONTLTYPE 0
		 plc 0 rat 010
		 #
		 set rat=(Qep/(Qsimplest+1E-30)>0.2) ? 1 : 0
		 define POSCONTCOLOR green
		 define NEGCONTCOLOR green
		 define BOXCOLOR default
		 define POSCONTLTYPE 0
		 plc 0 rat 010
		 #
		 set rat=(Qbrem/(Qsimplest+1E-30)>0.2) ? 1 : 0
		 define POSCONTCOLOR yellow
		 define NEGCONTCOLOR yellow
		 define BOXCOLOR default
		 define POSCONTLTYPE 0
		 plc 0 rat 010
		 #
		 set rat=(Qplasmon/(Qsimplest+1E-30)>0.2) ? 1 : 0
		 define POSCONTCOLOR magenta
		 define NEGCONTCOLOR magenta
		 define BOXCOLOR default
		 define POSCONTLTYPE 0
		 plc 0 rat 010
		 #
		 #
Qrat 0          #
		set ratioQ=(Qsimplest>1E28) ? Qsimplest/(QNefake+1E-50) : 1
		#
		pls 0 ratioQ
		#
diffpvst 0       #
		set myptot=myptot-kpnu
		#set myptot=myptot
		# PWF99 (fudge 'em)
		#set perdiff=(myptot-ppwfsimple)/myptot
		# Ours!
		set perdiff=(myptot-myptotsimple)/myptot
		#set perdiff=(kpelepos-pelepos)/myptot
		#set perdiff=(kpphoton-pphoton)/myptot
		#set perdiff=(kpN-pbaryon)/myptot
		jre punsly.m
		#ctype default plsplit 0 myT perdiff 1101 
		ticksize 0 0 -1 0
		#limits 2 12 -6 6
		#limits 2 12 -2 2
		# Ours:
		limits -.2 0.2 2 13
		# PWF99:
		#limits -2 2 2 13
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
surfYp 0        #
		set x1=LG(T)
		set x12=x1
		set x2=LG(rhob)
		set x22=x2
		set x2count=x1 if(x1==$(x1[0]))
		set x1count=x2 if(x2==$(x2[0]))
		define nx (dimen(x1count))
		define ny (dimen(x2count))
		define nz 1
		define Sx (x12[0])
		define Sy (x22[$nx-1])
		define Sz (1)
		define Lx (x12[$nx-1]-$Sx)
		define Ly (x22[$ny*$nx-1]-$Sy)
		define Lz (1)
		define dx ($Lx/($nx))
		define dy ($Ly/($ny))
		define dz ($Lz/($nz))
		define ncpux1 1
		define ncpux2 1
		define ncpux3 1
		define interp (0)
		define coord (1)        # don't want any special treatement since uniform grid
		define x1label "T"
		define x2label "\rho"
		set k=1,$nx*$ny,1
		set i=1,$nx*$ny,1
		set j=1,$nx*$ny,1
		set i=k%$nx
		set j=INT(k/$nx)
		set k=0*k
plt	18	# pl <file> <dir> <function> <logx=1000,0000,logy=0100,0000,overlay=0010,0000,limits=0000,0001> <0 0 0 0>
                prepaxes $2 $3
                if($?4 == 1) { define tobebits ($4) } else { define tobebits (0x0) }
                #defaults
                myrd $1
                if( ('$tobebits'=='0000')||('$tobebits'=='0x0') ){\
                 set thebits=0x0
		}\
                else{\
                 set thebits=0x$tobebits
		}
		#
		#
                if(thebits & 0x1000){\
                 set rlx=LG(ABS($2))
		 if(thebits & 0x0001){\
		  set _newxl=LG($5)
		  define newxl (_newxl)
		  set _newxh=LG($6)
		  define newxh (_newxh)
		 }
                }\
                else{\
		 set rlx=$2
                 if(thebits & 0x0001){\
		  set _newxl=$5
		  define newxl (_newxl)
		  set _newxh=$6
		  define newxh (_newxh)
		 }
                }
                if(thebits & 0x0100){\
		 set rly=LG(ABS($3))
                 if(thebits & 0x0001){\
		  set _newyl=LG($7)
		  define newyl (_newyl)
		  set _newyh=LG($8)
		  define newyh (_newyh)
		 }
                }\
                else{\
		 set rly=$3
                 if(thebits & 0x0001){\
		  set _newyl=$7
		  define newyl (_newyl)
		  set _newyh=$8
		  define newyh (_newyh)
		 }
                }
	        if(!(thebits&0x0010)){\
		 if((thebits&0x1000)&&(thebits&0x0100)){\
		  #ticksize -.1 1 -1 10
		  ticksize -1 10 -1 10
		 }
		 if((thebits&0x1000)&&(!(thebits&0x0100))){\
		  ticksize -1 0 0 0
		 }
		 if((!(thebits&0x1000))&&(thebits&0x0100)){\
		  ticksize 0 0 -1 0
		 }
		 if((!(thebits&0x1000))&&(!(thebits&0x0100))){\
		  ticksize 0 0 0 0
		 }
		}
                # (ones->limits)
                # if ones==1 use input limits
                # else if ones==0 use standard limits
                # if tens=1 overlay
                if(thebits & 0x0010){\
		  # define your own ptype,ctype
                  define temptemptemp (0)
                }\
                else{\
                 if(thebits & 0x0001){\
		  limits  $newxl $newxh $newyl $newyh
                 }\
                 else{\
		  limits rlx rly
                 }
		 if($PLOTERASE){\
		  erase
		 }
		 labeltime
                }
		#
		lweight $PLOTLWEIGHT
                if(!($finaldraft)){\
                 #points rlx rly
                }
                connect rlx rly if(doconnect)
		lweight $NORMLWEIGHT
		#
                if(thebits & 0x0010){\
                  define temptemptemp (0)
                }\
                else{\
                  # use real names for labelaxes function
                  #labelaxes $2 $3
                  labelaxes 0
                  mybox1d 
                }
                # some non-general short cuts
		#
		#
rdkazheaderold 0 #
		da eos.head
		lines 1 1
		read '%d %d' {numcol1 numcol2}
		lines 2 2
		read '%d %g %g' {nrhob rhobmin rhobmax}
		lines 3 3
		read '%d %g %g' {ntk tkmin tkmax}
		lines 4 4
		read '%d %g %g' {nhcm hcmmin hcmmax}
		lines 5 5
		read '%d %g %g' {ntdyn tdynmin tdynmax}
		#
		#
rdkazheadernew 0 #
		da eos.head
		lines 1 1
		read '%d %d %d' {whichrnpmethod whichynumethod whichhcmmethod}
		lines 2 2
		read '%d %d %d %d %d' {whichdatatype numdims numcol1 numcol2 numextras}
		lines 3 3
		read '%d %g %g' {nrhob rhobmin rhobmax}
		lines 4 4
		read '%d %g %g' {ntk tkmin tkmax}
		lines 5 5
		read '%d %g %g' {ntdynorye tdynoryemin tdynoryemax}
		lines 6 6
		read '%d %g %g' {ntdynorynu tdynorynumin tdynorynumax}
		lines 7 7
		read '%d %g %g' {nhcm hcmmin hcmmax}
		lines 8 8
		read '%g %g' {lsoffset fakelsoffset}
		#
		#
rdmykazeosold 1      #
		# still function of T (i.e. not yet interpolated to U/P/CHI nor new functions created)
		#
		rdkazheaderold
		#
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g' \
		    {rhob tempk hcm tdyn ptot utot stot qmtot }
		#
		set iii=0,dimen(rhob)-1
		#
		set mm=iii%nrhob
		set nn=INT(iii%(nrhob*ntk)/nrhob)
		set oo=INT(iii%(nrhob*ntk*nhcm)/(nrhob*ntk))
		set pp=INT(iii%(nrhob*ntk*nhcm*ntdyn)/(nrhob*ntk*nhcm))
		#
		set chi=utot+ptot
		#
rdmykazeos 1      ## LATEST : 1944890
		#
		# still function of T (i.e. not yet interpolated to U/P/CHI nor new functions created)
		#
		rdkazheadernew
		#
		da $1
		lines 1 100000000
		#
		if(whichdatatype==1){
                    # 9 total
                    if(numcol1!=9){
                        echo WHICHDATATYPE==1 NOT SETUP in SM
                        }
		read '%g %g %g %g %g %g %g %g %g' \
		    {rhob tempk tdynorye tdynorynu hcm \
                     dptot dutot dstot \
                     qmtot }
		 }
		#
                if(whichdatatype==2){
                    if(numcol1!=24){
                        echo WHICHDATATYPE==2 NOT SETUP in SM
                        }
		 read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		  {rhob tempk tdynorye tdynorynu hcm \
                   dptot dutot dstot \
		       qtautelohcm qtauaelohcm qtautmuohcm qtauamuohcm qtauttauohcm qtauatauohcm \
		       ntautelohcm ntauaelohcm ntautmuohcm ntauamuohcm ntauttauohcm ntauatauohcm \
		   gammapeglobalplusgammaAeglobal gammapnuglobalplusgammapenuglobal gammanglobalplusgammaneglobal gammannuglobal}
		  }
                  #
                  if(whichdatatype==3){
                    if(numcol1!=21){
                        echo WHICHDATATYPE==3 NOT SETUP in SM
                        }
		     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {rhob tempk tdynorye tdynorynu hcm \
                      dptot dutot dstot \
                      Qphoton Qm graddotrhouye Tthermaltot Tdifftot \
                      lambdatot lambdaintot \
                      Enutot Enue Enuebar \
		      Ynuthermal Ynu Ynu0}
                  }
                  if(whichdatatype==4){
                    if(numcol1!=32){
                        echo WHICHDATATYPE==4 NOT SETUP in SM
                        }
		     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {rhob tempk tdynorye tdynorynu hcm \
                      dptot dutot dstot \
                        qtautnueohcm  qtauanueohcm \
                    qtautnuebarohcm  qtauanuebarohcm \
                    qtautmuohcm  qtauamuohcm \
                    ntautnueohcm  ntauanueohcm \
                    ntautnuebarohcm  ntauanuebarohcm \
                    ntautmuohcm  ntauamuohcm \
                    unue0 unuebar0 unumu0 \
                    nnue0 nnuebar0 nnumu0 \
                    lambdatot lambdaintot \
                    tauphotonohcm tauphotonabsohcm \
                    nnueth0 nnuebarth0 \
                      }
                  }
		#
                if(whichdatatype>4){
                 echo whichdatatype>4 not setup in SM
                }
                #
		# eos.dat line 1948
		#
		# rho=0.55908101825122222900E+00010
		# tk=0.86851137375135288239E+00010
		# utot=0.88601890289717108602E+00029
		# 
		set dchi=dutot+dptot
		#
                setupplcgrid
                #
		#
setupplcgrid 0  #
		#
		if(0){\
		       set iii=0,dimen(rhob)-1
		       set mm=iii%nrhob
		       set nn=INT(iii%(nrhob*ntk)/nrhob)
		       set oo=INT(iii%(nrhob*ntk*ntdynorye)/(nrhob*ntk))
		       set pp=mm*0
		    }
		#
		if(0){\
		       set iii=0,dimen(rhob)-1
		       set mm=iii%nrhob
		       set nn=INT(iii%(nrhob*ntk)/nrhob)
		       set oo=INT(iii%(nrhob*ntk*nhcm)/(nrhob*ntk))
		       set pp=INT(iii%(nrhob*ntk*nhcm*ntdyn)/(nrhob*ntk*nhcm))
		}
		#
		#
                set iii=0,dimen(rhob)-1
                set mm=iii%nrhob
                set nn=INT(iii%(nrhob*ntk)/nrhob)
                set oo=INT(iii%(nrhob*ntk*ntdynorye)/(nrhob*ntk))
                set pp=INT(iii%(nrhob*ntk*ntdynorye*ntdynorynu)/(nrhob*ntk*ntdynorye))
		#
                # for now, only do if ==4 type:
		if(whichdatatype==4){\
                 # have to remove ynu or hcm if part of read-in table:
                 set myrhob = rhob if(pp==0)
                 set mytempk = tempk if(pp==0)
                 set mytdynorye = tdynorye if(pp==0)
 		 set mytdynorynu = tdynorynu if(pp==0)
 		 set myhcm = hcm if(pp==0)
		 set mydptot = dptot if(pp==0)
		 set mydutot = dutot if(pp==0)
		 set mydstot = dstot if(pp==0)
                 #
                 # Different order than for Shen tables:
                 define nx (nrhob)
                 define ny (ntk)
                 define nz (ntdynorye)
                 #
                 setupshencontour myrhob mytempk mytdynorye
                #
                # assume normally want to plot rhob vs. T at fixed Yp (high)
                define WHICHLEV (ntdynorye-1)
                define PLANE (3)
                #
                }
		#
                #
rdmykazmonoeos 1      # eos_extract.m outputs this after processing input data and header data
		#     # still function of T (i.e. not yet interpolated to U/P/CHI nor new functions created)
		#
		rdkazheadernew
		#
		#
		da $1
		lines 1 100000000
		#
		# 22 basic and 1 extra = 23 total
		if(whichdatatype==1){
		read '%d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {mmin nnin ooin ppin \
		       rhob tempk hcm tdynorye tdynorynu \
                     dptot dutot dchi stot \
		    pdegenfit udegenfit chidegenfit \
		    ptotoffset utotoffset chioffset \
		    ptotdiff utotdiff chidiff \
		    cs2rhoT \
		    qmtot}
		#
		}
		#
		#
		# 22 basic and 16 extra = 38 total
		if(whichdatatype==2){
		read '%d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {mmin nnin ooin ppin \
		       rhob tempk hcm tdynorye tdynorynu \
                     dptot dutot dchi stot \
		    pdegenfit udegenfit chidegenfit \
		    ptotoffset utotoffset chioffset \
		    ptotdiff utotdiff chidiff \
		    cs2rhoT \
		    qtautelohcm qtauaelohcm qtautmuohcm qtauamuohcm qtauttauohcm qtauatauohcm \
		    ntautelohcm ntauaelohcm ntautmuohcm ntauamuohcm ntauttauohcm ntauatauohcm \
		    gammapeglobal gammapnuglobalplusgammapenuglobal gammanglobalplusgammaneglobal gammannuglobal}
		 }
		#
		#
		# 22 basic and 11 extra = 33 total
		if(whichdatatype==3){
		read '%d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {mmin nnin ooin ppin \
		       rhob tempk hcm tdynorye tdynorynu dptot dutot dchi stot \
		    pdegenfit udegenfit chidegenfit \
		    ptotoffset utotoffset chioffset \
		    ptotdiff utotdiff chidiff \
		    cs2rhoT \
		    Qphoton Qm graddotrhouye Tthermaltot Tdifftot \
                    lambdatot lambdaintot \
		    Enuglobal Enueglobal Enuebarglobal \
		    Ynuthermal Ynu Ynu0}
		}
		#
		# 5+22=27 basic and 24 extra = 51
		if(whichdatatype==4){
		read '%d %d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {mmin nnin ooin ppin qqin \
		     rhob tempk tdynorye tdynorynu hcm \
                     dptot dutot dchi dstot dsspec \
		    utotdegenfit ptotdegenfit chidegenfit stotdegenfit sspecdegenfit \
		    utotoffset ptotoffset chioffset stotoffset sspecoffset \
		    utotin ptotin chiin stotin sspecin \
		    utotout ptotout chiout stotout sspecout \
		    utotdiff ptotdiff chidiff stotdiff sspecdiff \
		    cs2rhoT \
                        qtautnueohcm  qtauanueohcm \
                    qtautnuebarohcm  qtauanuebarohcm \
                    qtautmuohcm  qtauamuohcm \
                    ntautnueohcm  ntauanueohcm \
                    ntautnuebarohcm  ntauanuebarohcm \
                    ntautmuohcm  ntauamuohcm \
                    unue0 unuebar0 unumu0 \
                    nnue0 nnuebar0 nnumu0 \
                    lambdatot lambdaintot \
                    tauphotonohcm tauphotonabsohcm \
                    nnueth0 nnuebarth0 \
                      }
		}
		#
		#
		#
		#set iii=0,dimen(rhob)-1
		#
		#set mm=iii%nrhob
		#set nn=INT(iii%(nrhob*ntk)/nrhob)
		#set oo=INT(iii%(nrhob*ntk*nhcm)/(nrhob*ntk))
		#set pp=INT(iii%(nrhob*ntk*nhcm*ntdynorye)/(nrhob*ntk*nhcm))
		#
                setupplcgrid
		#
		#
rdmykazeosotherold 1      #
		#
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {etae xnuc npratio \
                       p_photon p_eleposi p_N p_nu \
                       rho_photon rho_eleposi rho_N rho_nu \
                       s_photon s_eleposi s_N s_nu \
                       tauael taus tautel tautmu tauamu \
                       Qmel Qmmu Qmtau \
		    qminusel qminusmu}
		#
rdmykazeosothernew 1      #
		#
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {etae xnuc npratio yetot \
                       p_photon p_eleposi p_N p_nu \
                       rho_photon rho_eleposi rho_N rho_nu \
                       s_photon s_eleposi s_N s_nu \
                       tauael taus tautel tautmu tauamu \
                       Qmel Qmmu Qmtau \
		    qminusel qminusmu}
		#
rdmykazeosother 1      # LATEST : qminusel, qtausohcm,qtautelohcm<0
		#ntausohcm<<0
		# lambdatot<<0 Tthermaltot diverges but Tdifftot does not
		# Enutot, Enue<0 Enuebar>0
		# RufQm<0
		#
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {etae etap etan etanu xnuc  npratio \
		       p_tot p_photon  p_eleposi  p_N  p_nu \
		       u_tot rho_photon  rho_eleposi  rho_N  rho_nu \
		       s_tot s_photon  s_eleposi  s_N  s_nu \
		       qtautelohcm qtauaelohcm qtautmuohcm qtauamuohcm qtauttauohcm qtauatauohcm \
		       ntautelohcm ntauaelohcm ntautmuohcm ntauamuohcm ntauttauohcm ntauatauohcm \
		       qtausohcm \
		       Qmel  Qmmu  Qmtau \
		       qminusel  qminusmu qminustau \
		       ntausohcm \
		       Nmel  Nmmu  Nmtau \
		       nminusel  nminusmu nminustau \
		       Qmphoton tauphotonohcm tauphotonabsohcm \
		       yetot yefree yebound dyedt dyedtthin graddotrhouyenonthermal graddotrhouye thermalye \
		       gammapeglobal gammaAeglobal gammapnuglobal gammapenuglobal \
		       gammanglobal gammaneglobal gammannuglobal \
		    gammap2nglobal gamman2pglobal \
                     Qm Nm Tdifftot Tthermaltot lambdatot \
		    Enutot Enue Enuebar \
		    RufNm RufQm Rufgraddotrhouye \
		    Ynu Ynu0 \
		    }
		#
                #
		# translate from Kaz form to HELM form
		#
		set utot=u_tot
		set ptot=p_tot
		set stot=s_tot
		set chi=utot+ptot
		#
		set myetae = etae if(pp==0)
		set myetap = etap if(pp==0)
		set myetan = etan if(pp==0)
		set myetanu = etanu if(pp==0)
		set myxnuc = xnuc if(pp==0)
		set mynpratio = npratio if(pp==0)
		#
		set myp_tot = p_tot if(pp==0)
		set myp_photon = p_photon if(pp==0)
		set myp_eleposi = p_eleposi if(pp==0)
		set myp_N = p_N if(pp==0)
		set myp_nu = p_nu if(pp==0)
		#
		set myu_tot = u_tot if(pp==0)
		set myrho_photon = rho_photon if(pp==0)
		set myrho_eleposi = rho_eleposi if(pp==0)
		set myrho_N = rho_N if(pp==0)
		set myrho_nu = rho_nu if(pp==0)
		#
		set mys_tot = s_tot if(pp==0)
		set mys_photon = s_photon if(pp==0)
		set mys_eleposi = s_eleposi if(pp==0)
		set mys_N = s_N if(pp==0)
		set mys_nu = s_nu if(pp==0)
		#
		#
		#
		#
rdhelmcou 1     #
		da $1
		lines 1 100000000
		# Coulomb corrections for inputed abar and zbar
		read '%g %g %g %g %g' \
		    {pcou ucou scou sion plasgcou}
		#
		#
rdhelmextra 1     #
		da $1
		lines 1 100000000
		# abar, zbar, n_i, n_{e in ion}, n_e, x_neut, x_prot, x_alpha, x_heavy, a_heavy, z_heavy, xcheck, muhat, cv, cp, gam1, gam2, gam3, c_s, didconverge
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {abar zbar xni xnem xne xneut xprot xalfa xheav aheav zheav xcheck \
                     muhat cv cp gam1 gam2 gam3 cshelm didconverge dse dpe dsp lsdse lsdpe lsdsp}
		#
		#jre grbmodel.m
		setgrbconsts
		#
		# to compare with cs2rhoT that is dimensionless
		set cs2helm=cshelm**2/c**2
                #
                #
                #
		set mycshelm = cshelm if(pp==0)
		#
                #
                #agzplc 'dump' pbulk
		#
		#
		#
		#
		#
		#
		############################################
		#
		# Shen Tables
		#
		#############################################
		#
		#
		#
		#
		#
		#                #
rdshentable0 0  #
                #
                #
                #cd ~/research/eos/sheneos/shen_table/
                da sheneos.tab
		lines 1 100000000
                read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                { lrhob nb lyp yp f ebulk sbulk aheav zheav mstar xneut \
                  xprot xalfa xh pbulk mun mup }
                #
                #
                set rhob=10**lrhob
                #
                set nrhob=104
                set nyp=71
                set ntk=31
                #
                define nx (nrhob)
                define ny (nyp)
                define nz (ntk)
                #
                setupshencontour rhob yp tempk
                #
                set ltempk = -1 + (indexk)*(2+1)/(ntk-1)
                set tempk=10**ltempk
                #
                # assume normally want to plot rhob vs. T at fixed Yp (high)
                define WHICHLEV (nyp-1)
                define PLANE (2)
                #
		# some sanity checks
		set god=aheav if(xh>0.99)
		set god2=god if(god<10.0)
		#
		set god=aheav if(aheav>1E-10)
		#
		set god3=sbulk if(sbulk<0)
		#
                set etanpdiff = (mun-mup)/tempk
                set etapndiff = (mup-mun)/tempk
		#
                set crap=lg(kb*10**9.913/ergPmev)
                print {crap}
		#
		# print {godaheav godxneut godxprot}
                #
		#print {lrho ltempk ye}
		# 9.568       9.913      0.4285
		#crap=-0.1516
		# abar should be 72.0225
		#
                set myuse=(abs(lrhob-9.568)<0.2 && abs(ltempk-crap)<.5 && abs(yp-0.4285)<0.03) ? 1 : 0
		set godaheav = aheav if(myuse)
                set godxneut=xneut if(myuse)
                set godxprot=xprot if(myuse)
		#
                set etap = mup/tempk
                set etan = mun/tempk
                set ye=yp
                #
                set factor = 1.0/(exp(etap-etan)-1.0)
                set Ynp = (2.0*ye-1.0)*factor
                set Ypn = exp(etap-etan)*Ynp
                #
                if(0) {
                 set Yn=1-ye
                 set Yp=ye
                 set Ynp = (Ynp>1.0) ? 1.0 : Ynp
                 set Ynp = (Ynp<0.0) ? 0.0 : Ynp
                 set Ypn = (Ypn>1.0) ? 1.0 : Ypn
                 set Ypn = (Ypn<0.0) ? 0.0 : Ypn
                 #
                 set Ypn = (Ypn+Ynp>1.0) ? 1-Ynp : Ypn
                }
                #
                #
                set tmev=tempk
                set tempkelvin = tmev*ergPmev/kb
                set ndegen = (mb*kb*tempkelvin/(2*pi*hbar**2))**(3.0/2.0)
                set nb = (10**lrhob)/mb
                set rat=nb/ndegen
                set ratm1=rat-1.0
                #
                # Shen equation 31 without n_\alpha
                set Balpha=28.3*ergPmev
                set ealphadiff=(3.0/2.0)*kb*tempkelvin-Balpha
                #
                #
                # Check if in NSE
                set rho=rhob
                set temp=tempkelvin
		# degen low temp regime
		set taunse=rho**(0.2)*exp(179.7*1E9/temp-39)
                # non-degen regime, high temp
                set taunse2=(temp/1E10)**(-5)
                #
                define WHICHLEV (nyp-5)
                plc0 0 ratm1
                #plc0 0 Ypn 010
                plc0 0 Ynp 010
                #
                #
                #plc0 0 (etap-etan)
                #plc0 0 ratm1 010
                #
                #
                #
checkingstarineos 0 #
		#
		# create stellar model (e.g. dostandard 0 a few times)
		#
		cd /u1/ki/jmckinne/research/eos/sheneos/shen_table/
		print starsimple.dat {rho temp ye}
		#
		# then use kaz.m's shenstarcheck after rdshentable0
		#
		#
		#
shenstarcheck 0 #
		#
		da starsimple.dat
		lines 1 1000000
		read '%g %g %g' {starrho startemp starye}
		#
		set startempmev=startemp*kb/ergPmev
		#
		#
		#plc 0 xh
		plc 0 aheav
		points (LG(starrho)) (LG(startempmev))
		#plc 0 (LG(taunse-9)) 010
		plc0 0 (LG(taunse-0)) 010
		plc0 0 (LG(taunse2-0)) 010
                #
		#
		#
shenplots 0     #
		agzplc '' xneut
		#
		define PLANE 2
		define WHICHLEV (nyp-6)
		#define WHICHLEV (nyp-7)
		#plc 0 yp
		#plc 0 xh
		plc0 0 aheav
		#
		#
		# 
                #
setupshencontour 3 # setupshencontour rhob yp tempk
                #
                #
                set iii=0,$nx*$ny*$nz-1,1
                set indexi=INT(iii%$nx)
                set indexj=INT((iii%($nx*$ny))/$nx)
                set indexk=INT(iii/($nx*$ny))
                #
		set i=iii
		#
		set ti = indexi
		set tj = indexj
		set tk = indexk
		#
		set tx1=$1
		set tx2=$2
		set tx3=$3
		#
		#
		set i=ti
		set j=tj
		set k=tk
		#
		#set k=0,$nx*$ny-1,1
		#set i=0,$nx*$ny-1,1
		#set j=0,$nx*$ny-1,1
                #
		#set i=k%$nx
		#set j=INT(k/$nx)
		#set k=0*k
		#
		#
		set x12=tx1
		set x1=x12
		set dx1=1.0+0.0*x1
		set dx12=dx1
		#
		#
		set x22=tx2
		set x2=x22
		set dx2=dx1
		set dx22=dx2
		#
		set x3=tx3
		set x32=x3
		set dx3=dx2
		set dx32=dx3
		#
		define Sx (x1[0])
		define Sy (x2[0])
		define Sz (x3[0])
		define dx (1)
		define dy (1)
		define dz (1)
		define Lx (x1[$nx*$ny*$nz-1]-x1[0])
		define Ly (x2[$nx*$ny*$nz-1]-x2[0])
		define Lz (x3[$nx*$ny*$nz-1]-x3[0])
		define ncpux1 1
		define ncpux2 1
		define ncpux3 1
		define interp (0)
		define coord (3)
		define x1label "\rho_b"
		define x2label "T[K]"
		#
		define LOGTYPE 2
		#
		#
		# $missing_data
		# NaN
                #
                #
rdshenheader 0 #
		da sheneos.head
                #
                lines 1 1
                read '%d' {nc}
                lines 2 2
                read '%d' {ncout}
                lines 3 3
                read '%d %d %d' {nrhobin nypin ntkin}
                lines 4 4
                read '%d %d %d' {nrhobout nypout ntkout}
                lines 5 5
                read '%g %g %g %g %g %g' {lrhobminin lrhobmaxin lypminin lypmaxin ltkminin ltkmaxin}
                lines 6 6
                read '%g %g %g %g %g %g' {lrhobminout lrhobmaxout lypminout lypmaxout ltkminout ltkmaxout}
                #
		set nrhob=nrhobout
		set nyp=nypout
		set ntk=ntkout
		#
                define nx (nrhob)
                define ny (nyp)
                define nz (ntk)
		#
                #
rdshenmatlab 0  #
		# read-in header
		rdshenheader
		#
		###########################################################################
		# reads-in and checks data for table consistency
		#
		#
                #cd /afs/slac.stanford.edu/u/ki/jmckinne/research/helm
                #
		# sed 's\NaN\0.0\g' sheneos.dat > sheneosnonan.dat
		da sheneosnonan.dat
		#
		# CAN plc 0 <var> below vars:
		lines 1 100000000
                read '%d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                { rhoi ypi tki goodrow lrhob nb lyp yp f ebulk sbulk aheav zheav mstar xneut \
                  xprot xalfa xh pbulk mun mup ltempk tempk}
                #
		set rhob=10.0**lrhob
		#
                set iii=0,$nx*$ny*$nz-1,1
                set indexi=INT(iii%$nx)
                set indexj=INT((iii%($nx*$ny))/$nx)
                set indexk=INT(iii/($nx*$ny))
		#
                # assume normally want to plot rhob vs. T at fixed Yp (high)
                define WHICHLEV (nyp-1)
                define PLANE (2)
                #
                setupshencontour rhob yp tempk
		#
                #####################################################################
		set badvalue=-1E20*.9
		#
		# BELOW SHOULD REPORT NO ELEMENTS!
		set mylrhob=lrhob if(goodrow && lrhob<badvalue)
		set mynb=nb if(goodrow && nb<badvalue)
		set mylyp=lyp if(goodrow && lyp<badvalue)
		set myyp=yp if(goodrow && yp<badvalue)
		set myf=f if(goodrow && f<badvalue)
		set myebulk=ebulk if(goodrow && ebulk<badvalue)
		set mysbulk=sbulk if(goodrow && sbulk<badvalue)
		set myaheav=aheav if(goodrow && aheav<badvalue)
		set myzheav=zheav if(goodrow && zheav<badvalue)
		set mymstar=mstar if(goodrow && mstar<badvalue)
		set myxneut=xneut if(goodrow && xneut<badvalue)
		set myxprot=xprot if(goodrow && xprot<badvalue)
		set myxalfa=xalfa if(goodrow && xalfa<badvalue)
		set myxh=xh if(goodrow && xh<badvalue)
		set mypbulk=pbulk if(goodrow && pbulk<badvalue)
		set mymun=mun if(goodrow && mun<badvalue)
		set mymup=mup if(goodrow && mup<badvalue)
		set myltempk=ltempk if(goodrow && ltempk<badvalue)
		set mytempk=tempk if(goodrow && tempk<badvalue)
		#
		########################################################################
		# Setup same size as 200^2 normal HELM version for study with comparison contour plots
		#
		#
		###########################################################################
		#set myuse=(abs(yp-0.4285)<0.06) ? 1 : 0
		set myuse=(tki==$nz-10) ? 1 : 0
		set myxneut = xneut if(myuse)
		#
		set rat1=dimen(myxneut)/($nx*$ny)
		print {rat1}
		echo "Above should be 1 for contour plots"
		#
		###########################################################################
		# CAN pl 0 <var> below vars
		set myxneut = xneut if(myuse)
		set mylrhob=lrhob if(myuse)
		set mynb=nb if(myuse)
		set mylyp=lyp if(myuse)
		set myyp=yp if(myuse)
		set myf=f if(myuse)
		set myebulk=ebulk if(myuse)
		set mysbulk=sbulk if(myuse)
		set myaheav=aheav if(myuse)
		set myzheav=zheav if(myuse)
		set mymstar=mstar if(myuse)
		set myxneut=xneut if(myuse)
		set myxprot=xprot if(myuse)
		set myxalfa=xalfa if(myuse)
		set myxh=xh if(myuse)
		set mypbulk=pbulk if(myuse)
		set mymun=mun if(myuse)
		set mymup=mup if(myuse)
		set myltempk=ltempk if(myuse)
		set mytempk=tempk if(myuse)
		#
		set myxnuc = (xprot+xneut) if(myuse)
		#
		#
		###########################################################################
		#
                set crap=lg(kb*10**9.913/ergPmev)
                print {crap}
		#
		# print {godaheav godxneut godxprot}
                #
		#print {lrho ltempk ye}
		# 9.568       9.913      0.4285
		#crap=-0.1516
		# abar should be 72.0225
		#
                set myuse=(abs(lrhob-9.568)<0.2 && abs(ltempk-crap)<.1 && abs(yp-0.4285)<0.03) ? 1 : 0
		set godaheav = aheav if(myuse)
                set godxneut=xneut if(myuse)
                set godxprot=xprot if(myuse)
		#
		#  print {godaheav godxneut godxprot}
		#
		#
		set myuse = (yp<1.1E-2) ? 1 : 0
		set myltempk = ltempk if(myuse)
		set mymun = mun if(myuse)
		set mymup = mup if(myuse)
		#
		set mymuhat = mymun-mymup
		#
		#
		# pl 0 myltempk mymuhat 0100
		#
		#
checkmup 0      #
		#
		#set myuse=(abs(lrhob-11)<0.2 && abs(yp-0.5)<0.03) ? 1 : 0
		set myuse=(abs(lrhob-11)<0.01 && abs(yp-0.5)<0.03) ? 1 : 0
		set godmup = mup if(myuse)
		set godtempk = tempk if(myuse)
		ctype default pl 0 godtempk godmup 1100
		#
		#
		#
prepleos2dp 0   #   Pre-Matlab version of similar macro in phivsr.m
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		set fracbase=0.4
		set basefun=abs(mydptot)
		set mybad=sqrt(-1)+basefun*0
                #
		set whichfun=myp_photon
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set whichfun=abs(myp_eleposi)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
                # (full ion+coul part)
		set whichfun=abs(myp_N)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set whichfun=abs(myp_nu)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		#if(0 && $whicheos==1){\
		#set whichfun=abs(mypcou)
		#set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		#define POSCONTCOLOR green
		#define NEGCONTCOLOR default
		#plc 0 mylgfun 010
		#}
		#
		#
prepleos2du 0   #   Pre-Matlab version of similar macro in phivsr.m
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		set fracbase=0.4
		set basefun=abs(mydutot)
		set mybad=sqrt(-1)+basefun*0
		set whichfun=abs(myrho_photon)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set whichfun=abs(myrho_eleposi)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
                # full ion+coul part
                set whichfun=abs(myrho_N-myrhob*c*c)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set whichfun=abs(myrho_nu)
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		#if(0 && $whicheos==1){\
		#set whichfun=abs(myucou)
		#set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		#define POSCONTCOLOR green
		#define NEGCONTCOLOR default
		#plc 0 mylgfun 010
		#}
		#
		#
prepleos2ds 0   #   Pre-Matlab version of similar macro in phivsr.m
		#
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		#
		#
		set fracbase=0.4
                set basefun=mydstot
                #
		set mybad=sqrt(-1)+basefun*0
		set whichfun=mys_photon
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 mylgfun
		#
		set whichfun=mys_eleposi
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR magenta
		plc 0 mylgfun 010
		#
		# full nucleon part (ion+coulomb)
		set whichfun=mys_N
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		plc 0 mylgfun 010
		#
		set whichfun=mys_nu
		set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR yellow
		plc 0 mylgfun 010
		#
		#if(0 && $whicheos==1){\
		#set whichfun=myscou
		#set mylgfun=(whichfun>fracbase*basefun) ? LG(whichfun) : mybad
		#define POSCONTCOLOR green
		#define NEGCONTCOLOR green
		#plc 0 mylgfun 010
		#}
		#
		#
showpressure  2 # showpressure 1 1
		# show pressures for kaz or helm EOS
		# before processing by eos_extract.m
		#
		# 0=KAZ 1=HELM
		define whicheos $1
		# 0=no mono  1=mono
		define whichmono $2
		#
		#
		# HELM:
		if($whicheos==1){\
		       if($whichmono){ checkrdhelmmono}
		       if($whichmono==0){ checkrdhelm }
		       set temp=tempk
		    }
		#
		# KAZ:
		if($whicheos==0){\
		       if($whichmono){ checkrdkazmono}
		       if($whichmono==0){ checkrdkaz }
		       set temp=tempk
		    }
		#
		#ctype default pl 0 temp ptot 1100
                #
                setupplc nrhob ntk ntdynorye rhob tempk tdynorye
                #
simpleread 1    #simpleread 'test1'
		#
		#
		#cd ~/research/helm/200x200x1x50/
		rdmykazeos $1
		#
		setupplc nrhob ntk ntdynorye rhob tempk tdynorye
                #
                setgrbconsts
		#
		#
setupplc 6      #  setup contour plotting of post-Matlab EOSs
		#  note that if Ynu varied, then plotting will ignore all but first/lowest Ynu in table.  Can extract like done for pre-Matlab tables.
		#
		#
		define nx ($1)
		define ny ($2)
		define nz ($3)
		#
		set _n1=$nx
		set _n2=$ny
		set _n3=$nz
		#
		#
		set i=0,$nx*$ny*$nz-1,1
		#
		set ti = i%$nx
		set tj = int(i/$nx)
                set tk=INT(i/($nx*$ny))
                set tl=INT(i/($nx*$ny*$nz))
		#set tk=(i+1)/(i+1)-1
		#
		set tx1=$4
		set tx2=$5
		set tx3=$6
		#
		#
		set i=ti
		set j=tj
		set k=tk
		#
		#
		set x12=tx1
		set x1=x12
		set dx1=1.0+0.0*x1
		set dx12=dx1
		#
		#
		set x22=tx2
		set x2=x22
		set dx2=dx1
		set dx22=dx2
		#
		set x3=tx3
		set x32=x3
		set dx3=dx1*0
		set dx32=dx3
		#
		define Sx (x1[0])
		define Sy (x2[0])
		define Sz (x3[0])
		define dx (1)
		define dy (1)
		define dz (1)
		define Lx (x1[$nx*$ny*$nz-1]-x1[0])
		define Ly (x2[$nx*$ny*$nz-1]-x2[0])
		define Lz (x3[$nx*$ny*$nz-1]-x3[0])
		define ncpux1 1
		define ncpux2 1
		define ncpux3 1
		define interp (0)
		define coord (3)
                define PLANE 3
                define WHICHLEV 0
		define x1label "\rho_b"
		define x2label "T[K]"
		#
		set _startx1=$Sx
		set _startx2=$Sy
		set _startx3=$Sz
		set _dx1=$dx
		set _dx2=$dy
		set _dx3=$dz
		set _realnstep=0
		set _gam=0
		set _a=0
		set _R0=0
		set _Rin=0
		set _Rout=1
		set _hslope=1
		set _dt=1
		set _defcoord=0
		#
		#!mkdir dumps
		#
		#
		define LOGTYPE 2
		#
		#
		# $missing_data
		# NaN
		#
		#    p_photon p_eleposi p_N p_nu
		#    rho_photon rho_eleposi rho_N rho_nu
                #    s_photon s_eleposi s_N s_nu
		#
		# FOR HELM:
		#    pcou ucou sdencou
		#
plcs2helm 0      #
		# how the hell is this so smooth if stot is so erratic?
		# dimensionless
		#
		plc 0 cs2helm
		#
		#

pleos2dconv 0    #
		#
		fdraft
		#
		set funplot=LG(rhob)
		set mybad=sqrt(-1)+funplot*0
		set funplot2=LG(temp)
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		#
		set convvalue=1
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 mylgfun
		#
		set convvalue=0
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-1
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-2
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-3
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-4
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-10
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		define cres 250
		plc 0 mylgfun 010
		define cres 50
		#
		set convvalue=-11
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-12
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-13
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR green
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-100
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-200
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		set convvalue=-500
		set mylgfun=(abs(didconverge-convvalue)<1E-10) ? funplot2 : mybad
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		plc 0 mylgfun 010
		#
		#
		# To compare my LS accurat.eps plot with Lat wrapper
		#
		# eos.dat
		# rhob, tempk
		# 26770      1.096985797892386E+13      1.035321843295664E+10
		#
		# eosazbar.dat:
		#abar, zbar
		#4.002337469845328E+00      1.145490890024282E+00
		# implies ye=zbar/abar =
		# 0.2862
		#
		# feed to lat wrap:
		# 0.2862 1.035321843295664E+10 1.096985797892386E+13
		#
		## from wrap:
		#abar =  9.0242E+01  zbar =  2.5827E+01
		#
		#
shownpratio 0   #  using pre-Matlab
		showpressure 0 0
		#
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 npratio
		#
		cd ~/research/kazeos/allfixed_200sq_new/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 npratio 010
		#
shownpratio1 0  # using pre-Matlab
		showpressure 0 0
		showpressure 1 0
		pleos2dconv
		#
		# now overlay npratio
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		define cres 50
		#
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		#
		set rho10=rhob/1E10
		set T10=temp/1E10
		set xnuc = 11.3226d0*rho10**(-0.75d0)*T10**1.125d0*exp(-8.20899d0/T10)
		set xnuc=(xnuc>1.0) ? 1.0 : xnuc
		set xnuc=(xnuc<0.0) ? 0.0 : xnuc
		#
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR default
		plc 0 xnuc 010
		#
		define POSCONTCOLOR blue
		define NEGCONTCOLOR default
		plc 0 npratio 010
		#
		# See where Tod Thompson used LSEOS
		set lowT = 10**(-0.8)*ergPmev/kb
		set highT = 10**(1)*ergPmev/kb
		#
		define PLOTWEIGHT 7
		define lweight 7
		set myusex=((temp>lowT)&&(temp<highT)) ? 1 : 0
		set myusey=((rhob>10**6.4)&&(rhob<10**15.1)) ? 1 : 0
		set myrhob=rhob if(myusex&&myusey)
		set mylowT=(lowT+rhob*0) if(myusex&&myusey)
		set myhighT=(highT+rhob*0) if(myusex&&myusey)
		ctype cyan pl 0 myrhob mylowT 1110
		ctype cyan pl 0 myrhob myhighT 1110
		#
		set myx=0,1,1
		set myx=6.4 + myx*1E-5
		set myy=0,1,1
		set myy[0]=LG(lowT)
		set myy[1]=LG(highT)
		connect myx myy
		#
		#
		set myx=0,1,1
		set myx=15.1 + myx*1E-5
		set myy=0,1,1
		set myy[0]=LG(lowT)
		set myy[1]=LG(highT)
		connect myx myy
		#
		defaults
		#
		#
showpcontrib0 0 #
		redohelm
		#redokaz
		#
		set myrho_photon=rho_photon if(nn==0)
		set myrho_eleposi=rho_eleposi if(nn==0)
		set myrho_N=rho_N-rhob*c*c if(nn==0)
		set myrho_nu=rho_nu if(nn==0)
		set myrhob=rhob if(nn==0)
		#
		erase
		ctype default box
		#
		fdraft
		define PLOTWEIGHT 5
		ctype default pl 0 myrhob myrho_photon 1110
		ctype red pl 0 myrhob myrho_eleposi 1110
		ctype blue pl 0 myrhob myrho_N 1110
		ctype magenta pl 0 myrhob myrho_nu 1110
		define PLOTWEIGHT 3
		#
checkloTrho 0   #
		#
		redokaz
		set myrhob= rhob if(tempk<=1E4)
		set myutot= utot if(tempk<=1E4)
		pl 0 myrhob myutot 1100 
		#
		#
		#
checkne 0       #
		set myxne=xne if(nn==0)
		set myrhob=rhob if(nn==0)
		set myetae=etae if(nn==0)
		set mynp=myrhob/mb/2
		set myzbar=zbar if(nn==0)
		print {myrhob myxne mynp myetae myzbar}
checkrhoele 0   #
		#redokaz
		redohelm
		#
		set god=me*c**2*rhob/mp if(nn==0)
		set myrhob=rhob if(nn==0)
		ctype blue pl 0 myrhob god 1110
		#
                # End pre-Matlab EOS
                #####################
