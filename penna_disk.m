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
		set ftp=ABS(gdet*absB1)
                set frp=ABS(gdet*absE2)
		set fm=abs(gdet*rho*auu1)
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle ftp ftpvsr
		gcalc2 3 2 $myangle frp frpvsr
		#
		# get local true parameter
		set singlehorvalue=fmvsr[0]
		set grat1=sqrt(2)*(ftp/fm)*sqrt(singlehorvalue)
		set grat1b=sqrt(2)*(frp/fm)*sqrt(singlehorvalue)
		gcalc2 3 2 $myangle grat1 grat1vsr
		gcalc2 3 2 $myangle grat1b grat1bvsr
		#
		# get local old parameter
		set grat1old=(ftp/sqrt(fm))
		set grat1bold=(frp/sqrt(fm))
		gcalc2 3 2 $myangle grat1old grat1oldvsr
		gcalc2 3 2 $myangle grat1bold grat1boldvsr
		#
		# get old global ratio
		set grat2old=ftpvsr/sqrt(abs(-fmvsr))
		set grat2bold=frpvsr/sqrt(abs(-fmvsr))
		# get true global ratio
		set grat2=sqrt(2)*(ftpvsr/fmvsr)*sqrt(singlehorvalue)
		set grat2b=sqrt(2)*(frpvsr/fmvsr)*sqrt(singlehorvalue)
		#
		#
		ctype default pl 0 newr grat1vsr 1001 Rin Rout 0 10
		ctype blue pl 0 newr grat1oldvsr 1011 Rin Rout 0 10
		ctype cyan pl 0 newr grat2 1011 Rin Rout 0 10
		ctype red pl 0 newr grat2old 1011 Rin Rout 0 10
		#
		ctype red vertline (LG(risco))
                #
                # \Omega_F related thing:
		ctype default pl 0 newr grat1bvsr 1001 Rin Rout 0 0.1
		ctype blue pl 0 newr grat1boldvsr 1011 Rin Rout 0 0.1
		ctype cyan pl 0 newr grat2b 1011 Rin Rout 0 0.1
		ctype red pl 0 newr grat2bold 1011 Rin Rout 0 0.1
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
		  # jre bzplots.m
                   #
                  #
                  # for Ldot/Mdot terms
		  set Dphi=pi/2
                  #
		  stresscalc 1
		  #4panelinflowdoall 0.05 _Rin (6) 0.5 1 0
                  4panelinflowdoall 0.05 _Rin (6) 0.5 0 0

4panelinflowpre2
