gammiepar 0     #
		# ki-rh39
		cd /afs/slac.stanford.edu/u/ki/jmckinne/nfsslac/nobackup/usbdisk/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#
		#jrdp2d dump0020
		jrdp2d dump0040
		#jrdpheader2dold dump0020
		#
		define dx3 1
		set dV=$dx1*$dx2*$dx3
		define myangle 0.6
		#
		faraday
		set ftp=ABS(fdd23)
		set fm=abs(2*pi*gdet*rho*uu1)
		set grat1=ftp/sqrt(abs(fm))
		gcalc2 3 2 $myangle grat1 grat1vsr
		#
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle ftp ftpvsr
		set grat2=ftpvsr/sqrt(abs(-fmvsr))
		#
		#
		ctype default pl 0 newr grat1vsr
		ctype red pl 0 newr grat2 0010
		#
gammieparavg  0 #
		#	
		define startdump (15)
		define enddump (30)
		#
                set _defcoord=0
		set _n3=1
		define dx3 1
                set _dx3=$dx3
		set dV=$dx1*$dx2*$dx3
                jrdp2d dump0000
                set ju0=0*ti
                set ju1=0*ti
                set ju2=0*ti
                set ju3=0*ti
                set jd0=0*ti
		set jd1=0*ti
		set jd2=0*ti
		set jd3=0*ti
                set fu0=0*ti
		set fu1=0*ti
		set fu2=0*ti
		set fu3=0*ti
		set fu4=0*ti
		set fu5=0*ti
                set fd0=0*ti
		set fd1=0*ti
		set fd2=0*ti
		set fd3=0*ti
		set fd4=0*ti
		set fd5=0*ti
		set aphi=0*ti
		avgtimegfull2 'dump' $startdump $enddump
		gwritedump2 dumptavg3
		greaddump2 dumptavg3
                #
		#greaddumpfull2 dumpavg1525n2.txt
		#greaddump2 dumptavg2new
		#
		#########################
		set _n3=1
		define dx3 1
		set dV=$dx1*$dx2*$dx3
		#
		################################
		# fake gammie parameter
		## see also 4panelinflowpre ... in bzplots.m
		set fm=(2*pi*rho*auu1*gdet)
		gcalc2 3 2 0.1 fm fmvsr
		#
		#
		#
		# Gammie = 0.4 - 0.5 for myangle=0.2
		# Gammie=0.4 myangle=0.06
		# Gammie=4 myangle=pi/2
		# Gammie=0.7-0.8 myangle=pi/4
		# Gammie=0.6 myangle=0.6
		define myangle 0.6
		#define myangle (pi/4)
		#
		set ftp=ABS(gdet*absB1)
		set fm=abs(2*pi*gdet*rho*auu1)
		set grat1=ftp/sqrt(abs(fm))
		gcalc2 3 2 $myangle grat1 grat1vsr
		#
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle ftp ftpvsr
		set grat2=ftpvsr/sqrt(abs(-fmvsr))
		#
		#
		ctype default pl 0 newr grat1vsr
		ctype red pl 0 newr grat2 0010
		#
                #
                #
		##############################
		set _n3=1
		define dx3 1
		set dV=$dx1*$dx2*$dx3
		set tk=0*ti
		#
		# TRUE Gammie parameter, with correct factors
		# normal 1-loop:
                # myangle=0.1 : 1.5
		# myangle=pi/4 : 3
		#
		# vert
                # myangle=0.1 : 1-2
		# myangle=pi/4 : 3
		#
		#
		#define myangle 0.1
		define myangle (pi/4)
		#define myangle (pi/4)
                #
                # only do below if using single dump
                if(0){\
                      set absB1=abs(B1)
                      set auu1=abs(uu1)
                      set absE2=abs(B3*uu1/uu0-uu3/uu0*B1)
                      }
                #
		#
		set Dphi=(pi/2)
                set boxfactor=(2*pi)/(Dphi)
                #
                # F_{\theta\phi} = \detg *F^{rt} = \detg B^r = constant
                # d\phi/dt = dx3/dt dphi/dx3 = dx3/dt (Dphi)
                set ftp=ABS(gdet*absB1)/Dphi
                # \detg *F^{r\phi} = \detg (u^r b^\phi - u^\phi b^r) == constant
                set frp=ABS(gdet*absE2)*Dphi
		gcalc2 3 0 $myangle ftp ftpvsr
		gcalc2 3 0 $myangle frp frpvsr
                set unity=ftp*0+1
		gcalc2 3 0 $myangle unity unityvsr
                #
                # account for small \phi wedge
                set ftpvsr=ftpvsr*boxfactor
                set frpvsr=frpvsr*boxfactor
                #
                set omegafavg=frpvsr/ftpvsr
                #
                ctype default pl 0 newr omegafavg 1000
                ctype blue pl 0 newr (1/(newr**(3/2)+a)) 1010
                ctype red vertline (LG(risco))
		#
		set fm=abs(gdet*rho*auu1)
		gcalc2 3 0 $myangle fm fmvsr
                set mdotvsr=fmvsr*boxfactor
                #
		# get local true parameter
                set grat1=sqrt(4*pi)*(ftpvsr/unityvsr)/(sqrt(abs(mdotvsr/(2*$myangle))))
		set omegakisco=1/(risco**(3/2)+a)
                set grat1b=(frpvsr/ftpvsr)/omegakisco
		set horgrat1=grat1[0]
		set horgrat1b=grat1b[0]
		print {horgrat1 horgrat1b}
		#
		#
		set grat2=sqrt(4*pi)*ftp/sqrt(abs(mdotvsr[0]/(2*$myangle)))
		gcalc2 3 2 $myangle grat2 grat2vsr
		set horgrat2vsr=grat2vsr[0] print {horgrat2vsr}
		#
		# get true global ratio
		set grat2=sqrt(2)*(ftpvsr/fmvsr)*sqrt(singlehorvalue)
		set grat2b=sqrt(2)*(frpvsr/fmvsr)*sqrt(singlehorvalue)
		#
		#
		ctype default pl 0 newr grat1vsr 1001 Rin Rout 0 10
		ctype cyan pl 0 newr grat2 1011 Rin Rout 0 10
		#
		ctype red vertline (LG(risco))
                #
                # \Omega_F related thing:
		ctype default pl 0 newr grat1bvsr 1001 Rin Rout 0 0.1
		ctype cyan pl 0 newr grat2b 1011 Rin Rout 0 0.1
		#
		ctype red vertline (LG(risco))
                #
                #
		##############################
		# non-abs on B1 and uu1
		set _n3=1
		define dx3 1
		set dV=$dx1*$dx2*$dx3
		myangle 0.06
		#
		#
		set ftp=ABS(gdet*B1)
		set fm=abs(2*pi*gdet*rho*uu1)
		set grat1=ftp/sqrt(abs(fm))
		gcalc2 3 2 $myangle grat1 grat1vsr
		#
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle ftp ftpvsr
		set grat2=ftpvsr/sqrt(abs(-fmvsr))
		#
		#
		ctype default pl 0 newr grat1vsr
		ctype red pl 0 newr grat2 0010
		#
		#
penna4panelgammie 0    #
		  # jre bzplots.m
                   #
                  #
		set aphi=0*ti
		avgtimegfull2 'dump' $startdump $enddump
		gwritedump2 dumptavg3
		greaddump2 dumptavg3
                  #
                  # for Ldot/Mdot terms and normalization for Fm
		  set Dphi=pi/2
                  #
		  #
		  stresscalc 1
		  #4panelinflowdoall 0.05 _Rin (6) 0.5 1 0
                  #4panelinflowdoall 0.05 _Rin (6) 0.5 0 0
		  4panelinflowdoall 0.05 _Rin 7 0.25 1 0  
		  #
                  #set myfmvsrg=.5 4panelinflowdoall 0.1 _Rin 7 0.45 1 0
                  #
                  set myfmvsrg=.57 4panelinflowdoall 0.1 _Rin 7 0.42 1 0 
                  #
		  #
gammiedata 0      #
		#
		#da lookat.dat
		da lookatall.dat
		 read '%g %g %g %g %g %g' {a Fhp joneff reldeff jonl reldl}
		 #
		set numa=8
		set numFhp=dimen(a)/numa
		 #
		 pl 0 Fhp reldl 1101 1E-3 10 1E-3 300
		 erase
		 box
		 points (LG(Fhp)) (LG(-reldl))
		#
		#
		#set picka=numFhp*(numa-2)
		set picka=numFhp*2
		 set ii=0,dimen(a)-1,1
		 set myuse=(a==a[picka] ? 1 : 0)
		 set mya=a if(myuse)
		 set myFhp=Fhp if(myuse)
		 set myreldeff=reldeff if(myuse)
		 set myreldl=reldl if(myuse)
		 #
		 pl 0 myFhp myreldl 1101 1E-3 10 1E-3 300
		 erase
		 box
		 points (LG(myFhp)) (LG(-myreldl))
		 set myfit=((1.1*pi*myFhp)**(5/3))
		 set myfit2=((1.15*pi*myFhp)**(1.6))
		 set myfit3=((1.15*pi*myFhp)**(1.55))
		 ctype red pl 0 myFhp myfit 1111 1E-3 10 1E-3 300
		 ctype blue pl 0 myFhp myfit2 1111 1E-3 10 1E-3 300
		 ctype cyan pl 0 myFhp myfit3 1111 1E-3 10 1E-3 300
		#
		#
		#
		set pickFhp=3
		 set ii=0,dimen(a)-1,1
		 set myuse=(Fhp==Fhp[pickFhp] ? 1 : 0)
		 set mya=a if(myuse)
		 set myFhp=Fhp if(myuse)
		 set myreldeff=reldeff if(myuse)
		 set myreldl=reldl if(myuse)
		 #
		 #
		 print {myFhp mya myreldl}
		 #
		 #
		 pl 0 mya (-myreldl) 0101 -0.1 1 1E-3 1
		 erase
		 box
		 points mya (LG(-myreldl))
		 set myfit=((1.1*pi*myFhp)**(5/3)+(mya/myFhp/70)**(6/3))
		 ctype red pl 0 mya myfit 0111 -0.1 1 1E-3 1
		#
		#
redogammieplot 0 #
		#
		set hor=0.1
		#
		set aphi=0*ti
		avgtimegfull2 'dump' $startdump $enddump
		gwritedump2 dumptavg3
		greaddump2 dumptavg3
		#
		# for Ldot/Mdot terms and normalization for Fm
		set Dphi=pi/2
		#
		set FM=gdet*rho0*auu1
		#
		gcalc2 8 0 hor FM FMvsr $rinner $router
		#
		#
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#now setup
		#
		set uu1vsr=uu1vsr
		trueminmax newr uu1vsr
		define uu1min (truemin)
		#
		limits  $rinner $router $uu1min 0
		#
		ctype default window 2 2 1 2 box 1 2 0 0
		yla u^r
		#xla r c^2/(GM)
		xla r/M
		ctype default ltype 0 plo 0 newr uu1vsr
		#
		ctype blue ltype 0 plo 0 gr guu1
		ctype red ltype 0 vertline risco
		#
		limits $rinner $router -0.5 4
		ctype default window 2 2 2 2 box 1 2 0 0
		define x1label "r/M"
		define x2label "j"
		xla $x1label
		yla $x2label
		ctype default ltype 1 plo 0 newr tdflvsr
		ctype green ltype 0 plo 0 newr (FLEMvsr/Dphi)
		ctype magenta ltype 0 plo 0 newr (FLIEvsr/Dphi)
		#
		#
		ctype blue ltype 0 plo 0 gr gFLEM
		#ctype cyan ltype 0 plo 0 newr FLPAvsr
		ctype cyan ltype 0 plo 0 newr (ud3vsr*$dx3*_n3/(Dphi))
		# particle term for gammie
		ctype blue ltype 0 plo 0 gr gl
		#
		ctype red ltype 0 vertline risco
		#
		limits $rinner $router -5 1
		notation -2 2 -2 2
		#
		ticksize 0 0 -1 0
		ctype default window 2 2 1 1 box 1 2 0 0
		xla r/M
		yla "comoving energy density"
		set lbcog=LG(bcog)
		ctype green ltype 0 plo 0 newr lbcog
		set lrhovsrg=LG(rhovsrg)
		ctype cyan ltype 0 plo 0 newr lrhovsrg
		set luvsrg=LG(uvsrg)
		ctype magenta ltype 0 plo 0 newr luvsrg
		#
		set lmygbsqvsr=LG(mygbsqvsr)
		set lged=LG(ged)
		#
		ctype blue ltype 0 plo 0 gr lged
		#
		set lgrho=LG(grho)
		#
		ctype blue ltype 0 plo 0 gr lgrho
		#
		#set lgco=LG(gco)
		ctype red ltype 0 vertline risco
		#
		limits $rinner $router -0.1 1.0
		#limits $rinner $router -5 1.0
		ticksize 0 0 0 0
		ctype default window 2 2 2 1 box 1 2 0 0
		#
		#define x1label "r c^2/(GM)"
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
