jrdp3dener      0 #
		jrdp3denergen ener.out -1E30 1E30 # already assumes ener.out
jrdpgrbener   0 #
		energrbgen ener.out -1E30 1E30 # already assumes ener.out
jrdpener0      0 #
		jrdpener 0 1E30 # already assumes ener.out
jrdpener1      0 #
		jrdpenerjet enerjet0.out 0 1E30
jrdpener2      0 #
		jrdpenerjet enerjet1.out 0 1E30
jrdpener 2              #
		# jrdpener ener.out 0 2000
		# jrdpener jetener0.out 0 2000
		# jrdpener jetener1.out 0 2000
		# generalized ener.out reader
		set notdone=1
		set divbavg=-1
		set bx3dot=-1000
		set dl=-1000
		#
		gammieener
		#
		enercheck $1 $2
		#
		#
jrdpmetricparms 0 #
		metricparmsener metricparms.out
		#
energrbgen 3	#
		# jrdpener ener.out 0 2000
		# jrdpener jetener0.out 0 2000
		# jrdpener jetener1.out 0 2000
		# generalized ener.out reader
		set notdone=1
		set divbavg=-1
		set bx3dot=-1000
		set dl=-1000
		#
		energrb3d $1
		# no checks yet, first macro
		#
		# now find average of useful quantities
		#enersettime $2 $3
		#eneraverages
		enererrors
		#
jrdp3denergen 3	#
		# jrdpener ener.out 0 2000
		# jrdpener jetener0.out 0 2000
		# jrdpener jetener1.out 0 2000
		# generalized ener.out reader
		set notdone=1
		set divbavg=-1
		set bx3dot=-1000
		set dl=-1000
		#
		gammieener3d $1
		# no checks yet, first macro
		#
		# now find average of useful quantities
		#enersettime $2 $3
		#eneraverages
		enererrors
		#
enersettime 2   #
		       set tinner=$1
		       set touter=$2
		       # find the i for a given time
		       define ii (0)
		       while { $ii<dimen(t) } {\
		              if(t[$ii]>=tinner) { break }
		              define ii ($ii+1)
		           }
		           set tinsel=$ii
		           if(tinsel==dimen(t)) { set tinsel=dimen(t)-1 }
		       #
		       # find the i for a given time
		       define ii (0)
		       while { $ii<dimen(t) } {\
		              if(t[$ii]>=touter) { break }
		              define ii ($ii+1)
		           }
		           set toutsel=$ii
		           if(toutsel==dimen(t)) { set toutsel=dimen(t)-1 }
		        #
		           #
		#
enercheck 2     #
		if((divbavg!=-1)||(dimen(divbavg)!=1)) { set notdone=0 echo DONE READING ENER.OUT FILE }
		if(notdone) { gammieenero3 }
		if((notdone)&&((divbavg!=-1)||(dimen(divbavg)!=1))) { set notdone=0 echo DONE READING ENER.OUT FILE }
		if(notdone) { gammieenero2 }
		if((notdone)&&((divbavg!=-1)||(dimen(divbavg)!=1))) { set notdone=0 echo DONE READING ENER.OUT FILE}
		if(notdone) { gammieenero1 }
		if((notdone)&&((divbavg!=-1)||(dimen(divbavg)!=1))) { set notdone=0 echo DONE READING ENER.OUT FILE}
		if(notdone){ set bx3dot=-1000 gammieenerold }
		if((notdone)&&((bx3dot!=-1000)||(dimen(bx3dot)!=1))) { set notdone=0 echo DONE READING ENER.OUT FILE}
		if(notdone){ set dl=-1000 gammieenerold2 }
		if((notdone)&&((dl!=-1000)||(dimen(dl)!=1))) { set notdone=0 echo DONE READING ENER.OUT FILE}
		if(notdone){\
		   echo NEVER GOT ENER.OUT FILE!!
		}
		if(notdone==0){\
		        # now find average of useful quantities
		        #enersettime $1 $2
		        #eneraverages
		        enererrors
		     #
		  }
		  #
		  echo "if code run older than Dec 1, 2004, or so, then need to run through old gammieener macros"
		#
		#
jrdpenerjet 3              #
		# jrdpener ener.out 0 2000
		# jrdpener enerjet0.out 0 2000
		# jrdpener enerjet1.out 0 2000
		# generalized ener.out reader
		gammieenerjet $1
		findtime $2 $3
		eneraverages
		enererrors
		#
findtime 2      # findtime for eneraverages
		#
		set tinner=$1
		set touter=$2
		# find the i for a given time
		define ii (0)
		while { $ii<dimen(t) } {\
		       if(t[$ii]>=tinner) { break }
		       define ii ($ii+1)
		    }
		set tinsel=$ii
		if(tinsel==dimen(t)) { set tinsel=dimen(t)-1 }
		#
		# find the i for a given time
		define ii (0)
		while { $ii<dimen(t) } {\
		       if(t[$ii]>=touter) { break }
		       define ii ($ii+1)
		    }
		set toutsel=$ii
		if(toutsel==dimen(t)) { set toutsel=dimen(t)-1 }
		#
eneraverages  0     #
		        avglim t dm dmavg tinsel toutsel
		        avglim t de deavg tinsel toutsel
		        avglim t dl dlavg tinsel toutsel
		        avglim t dem demavg tinsel toutsel
		        avglim t dlm dlmavg tinsel toutsel
		        avglim t eff effavg tinsel toutsel
		        avglim t da daavg tinsel toutsel
		        set dadmavg=daavg/dmavg
		        set deodmavg=deavg/dmavg
		        set dlodmavg=dlavg/dmavg
		        set eneravglabels={dmavg deavg dlavg demavg dlmavg effavg daavg dadmavg deodmavg dlodmavg}
		        set el0=eneravglabels[0]
		        set el1=eneravglabels[1]
		        set el2=eneravglabels[2]
		        set el3=eneravglabels[3]
		        set el4=eneravglabels[4]
		        set el5=eneravglabels[5]
		        set el6=eneravglabels[6]
		        set el7=eneravglabels[7]
		        set el8=eneravglabels[8]
		        set el9=eneravglabels[9]
		        print '%15s %15s %15s %15s %15s %15s %15s %15s %15s %15s\n' {el0 el1 el2 el3 el4 el5 el6 el7 el8 el9} 
		        print '%15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' \
		            {dmavg deavg dlavg demavg dlmavg effavg daavg dadmavg deodmavg dlodmavg}
		     #
enererrors 0    # error analysis of conservative quantities
		#
		    # total difference
		    set u0tdel=u0-u0fl-u0src-(u0cum1+u0cum3)+(u0cum0+u0cum2)-u0[0]
		    set u1tdel=u1-u1fl-u1src-(u1cum1+u1cum3)+(u1cum0+u1cum2)-u1[0]
		    set u2tdel=u2-u2fl-u2src-(u2cum1+u2cum3)+(u2cum0+u2cum2)-u2[0]
		    set u3tdel=u3-u3fl-u3src-(u3cum1+u3cum3)+(u3cum0+u3cum2)-u3[0]
		    set u4tdel=u4-u4fl-u4src-(u4cum1+u4cum3)+(u4cum0+u4cum2)-u4[0]
		    set u5tdel=u5-u5fl-u5src-(u5cum1+u5cum3)+(u5cum0+u5cum2)-u5[0]
		    set u6tdel=u6-u6fl-u6src-(u6cum1+u6cum3)+(u6cum0+u6cum2)-u6[0]	
		    set u7tdel=u7-u7fl-u7src-(u7cum1+u7cum3)+(u7cum0+u7cum2)-u7[0]
		    #
		    # total percent difference (doesn't make sense for those quantities starting off small)
		    set u0tdiff=u0tdel/u0[0]
		    set u1tdiff=u1tdel/u1[0]
		    set u2tdiff=u2tdel/u2[0]
		    set u3tdiff=u3tdel/u3[0]
		    set u4tdiff=u4tdel/u4[0]
		    set u5tdiff=u5tdel/u5[0]
		    set u6tdiff=u6tdel/u6[0]
		    set u7tdiff=u7tdel/u7[0]
		    #
		    # average difference
		    set u0tdelavg=SUM(u0tdel)/dimen(u0tdel)
		    set u1tdelavg=SUM(u1tdel)/dimen(u1tdel)
		    set u2tdelavg=SUM(u2tdel)/dimen(u2tdel)
		    set u3tdelavg=SUM(u3tdel)/dimen(u3tdel)
		    set u4tdelavg=SUM(u4tdel)/dimen(u4tdel)
		    set u5tdelavg=SUM(u5tdel)/dimen(u5tdel)
		    set u6tdelavg=SUM(u6tdel)/dimen(u6tdel)
		    set u7tdelavg=SUM(u7tdel)/dimen(u7tdel)
		    #
		    # sigma of difference
		    set u0tdelsigma=sqrt(SUM(u0tdel**2)/dimen(u0tdel)-u0tdelavg**2)
		    set u1tdelsigma=sqrt(SUM(u1tdel**2)/dimen(u1tdel)-u1tdelavg**2)
		    set u2tdelsigma=sqrt(SUM(u2tdel**2)/dimen(u2tdel)-u2tdelavg**2)
		    set u3tdelsigma=sqrt(SUM(u3tdel**2)/dimen(u3tdel)-u3tdelavg**2)
		    set u4tdelsigma=sqrt(SUM(u4tdel**2)/dimen(u4tdel)-u4tdelavg**2)
		    set u5tdelsigma=sqrt(SUM(u5tdel**2)/dimen(u5tdel)-u5tdelavg**2)
		    set u6tdelsigma=sqrt(SUM(u6tdel**2)/dimen(u6tdel)-u6tdelavg**2)
		    set u7tdelsigma=sqrt(SUM(u7tdel**2)/dimen(u7tdel)-u7tdelavg**2)
		    #
		    # absolute average+error difference
		    set u0tdeloff=ABS(u0tdelavg)+u0tdelsigma
		    set u1tdeloff=ABS(u1tdelavg)+u1tdelsigma
		    set u2tdeloff=ABS(u2tdelavg)+u2tdelsigma
		    set u3tdeloff=ABS(u3tdelavg)+u3tdelsigma
		    set u4tdeloff=ABS(u4tdelavg)+u4tdelsigma
		    set u5tdeloff=ABS(u5tdelavg)+u5tdelsigma
		    set u6tdeloff=ABS(u6tdelavg)+u6tdelsigma
		    set u7tdeloff=ABS(u7tdelavg)+u7tdelsigma
		    #
		    print {u0tdeloff u1tdeloff u2tdeloff u3tdeloff u4tdeloff u5tdeloff u6tdeloff u7tdeloff}
		    #
		    # real total average
		    set u0avg=SUM(u0)/dimen(u0)
		    set u1avg=SUM(u1)/dimen(u1)
		    set u2avg=SUM(u2)/dimen(u2)
		    set u3avg=SUM(u3)/dimen(u3)
		    set u4avg=SUM(u4)/dimen(u4)
		    set u5avg=SUM(u5)/dimen(u5)
		    set u6avg=SUM(u6)/dimen(u6)
		    set u7avg=SUM(u7)/dimen(u7)
		    #
		    # percent average+error difference
		    set u0tdiffa=(u0tdeloff)/u0avg
		    set u1tdiffa=(u1tdeloff)/u1avg
		    set u2tdiffa=(u2tdeloff)/u2avg
		    set u3tdiffa=(u3tdeloff)/u3avg
		    set u4tdiffa=(u4tdeloff)/u4avg
		    set u5tdiffa=(u5tdeloff)/u5avg
		    set u6tdiffa=(u6tdeloff)/u6avg
		    set u7tdiffa=(u7tdeloff)/u7avg
		    #
		    print {u0tdiffa u1tdiffa u2tdiffa u3tdiffa u4tdiffa u5tdiffa u6tdiffa u7tdiffa}
		    #
		    # below assumes vel/b have correlated components (typically true)
		    set sumv=(SUM(u2)+SUM(u3)+SUM(u4))/3
		    set sumb=(SUM(u5)+SUM(u6)+SUM(u7))/3
		    set u2tdiffb=SUM(u2tdel)/sumv
		    set u3tdiffb=SUM(u3tdel)/sumv
		    set u4tdiffb=SUM(u4tdel)/sumv
		    set u5tdiffb=SUM(u5tdel)/sumb
		    set u6tdiffb=SUM(u6tdel)/sumb
		    set u7tdiffb=SUM(u7tdel)/sumb
		    #
		    print {u0tdiffa u1tdiffa u2tdiffb u3tdiffb u4tdiffb u5tdiffb u6tdiffb u7tdiffb}
		    #
		    #
enerdefs1 0          #
		    # # realu1dot? assignment assumes phys.c's flux[UU]=mhd[0]+flux[RHO], so we subtract that back off
		    set realu1dot0=-(u1dot0-u0dot0)
		    set realu1dot1=-(u1dot1-u0dot1)
		    set realu1dot2=-(u1dot2-u0dot2)
		    set realu1dot3=-(u1dot3-u0dot3)
		    #set realu1dot0=u1dot0
		    #set realu1dot1=u1dot1
		    #set realu1dot2=u1dot2
		    #set realu1dot3=u1dot3
		    set eff0=1-realu1dot0/u0dot0
		    set eff1=1-realu1dot1/u0dot1
		    set eff2=1-realu1dot2/u0dot2
		    set eff3=1-realu1dot3/u0dot3
		    set lom0=u4dot0/u0dot0
		    set lom1=u4dot1/u0dot1
		    set lom2=u4dot2/u0dot2
		    set lom3=u4dot3/u0dot3
		    #
		    set dm=u0dot1
		    set dl=u4dot1
		    set de=realu1dot1
		    set dem=de/dm
		    set dlm=dl/dm
		    set eff=eff1
		    #set da = dl/(2.*a*de)
		    set da = -dl+2.*a*de
		    set dam = -da/dm
		# for use of jons macro
		set min1d=u0dot1
		set ein1d=realu1dot1
		set mx3in1d=u4dot1
		set td=t
		#define GAMMIE (1)
                #
energrb3d 1	# more directions to consider in general
		# below 11 is normal 8 with YL, YNU, and ENTROPY (on regardles of dissipation on/off)
                set NPR=11
                # below always 18 so consistent format
                set NUMDISSVERSIONS=18
		set totalcol= 2 + NPR + 2*NPR*6 + NPR*2 + 2 + NUMDISSVERSIONS
                print {totalcol}
		#
		da $1
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		       u0 u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 u8dot0 u9dot0 u10dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 u8dot1 u9dot1 u10dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 u8dot2 u9dot2 u10dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 u8dot3 u9dot3 u10dot3 \
		    u0dot4 u1dot4 u2dot4 u3dot4 u4dot4 u5dot4 u6dot4 u7dot4 u8dot4 u9dot4 u10dot4 \
		    u0dot5 u1dot5 u2dot5 u3dot5 u4dot5 u5dot5 u6dot5 u7dot5 u8dot5 u9dot5 u10dot5 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 u8cum0 u9cum0 u10cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 u8cum1 u9cum1 u10cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 u8cum2 u9cum2 u10cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 u8cum3 u9cum3 u10cum3 \
		    u0cum4 u1cum4 u2cum4 u3cum4 u4cum4 u5cum4 u6cum4 u7cum4 u8cum4 u9cum4 u10cum4 \
		    u0cum5 u1cum5 u2cum5 u3cum5 u4cum5 u5cum5 u6cum5 u7cum5 u8cum5 u9cum5 u10cum5 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl u8fl u9fl u10fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src u8src u9src u10src \
		    divbmax divbavg \
		    diss0 diss1 diss2 diss3 diss4 diss5 diss6 diss7 \
		    diss8 diss9 diss10 diss11 diss12 diss13 diss14 diss15 \
                    diss16 diss17 }
		    #
		    enerdefs1
		    #
gammieener3do1 1	# more directions to consider in general
		# need 132
		# 2 + NPR + 2*NPR*6 + NPR*2 + 2 + NUMDISSVERSIONS(18 currently)
		#
		da $1
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0dot4 u1dot4 u2dot4 u3dot4 u4dot4 u5dot4 u6dot4 u7dot4 \
		    u0dot5 u1dot5 u2dot5 u3dot5 u4dot5 u5dot5 u6dot5 u7dot5 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0cum4 u1cum4 u2cum4 u3cum4 u4cum4 u5cum4 u6cum4 u7cum4 \
		    u0cum5 u1cum5 u2cum5 u3cum5 u4cum5 u5cum5 u6cum5 u7cum5 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src \
		    divbmax divbavg \
		    diss0 diss1 diss2 diss3 diss4 diss5 diss6 diss7 \
		    diss8 diss9 diss10 diss11 diss12 diss13 diss14 diss15 \
                    diss16 diss17 }
		    #
		    enerdefs1
		    #
gammieener3dold 1	# more directions to consider in general
		# need 124
		# 2 + NPR + 2*NPR*6 + NPR*2 + 2
		#
		da $1
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0dot4 u1dot4 u2dot4 u3dot4 u4dot4 u5dot4 u6dot4 u7dot4 \
		    u0dot5 u1dot5 u2dot5 u3dot5 u4dot5 u5dot5 u6dot5 u7dot5 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0cum4 u1cum4 u2cum4 u3cum4 u4cum4 u5cum4 u6cum4 u7cum4 \
		    u0cum5 u1cum5 u2cum5 u3cum5 u4cum5 u5cum5 u6cum5 u7cum5 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src \
		    divbmax divbavg }
		    #
		    enerdefs1
		    #
metricparmsener 1	# more directions to consider in general
		# need 
		#  2 + 18 = 20
		#
		da $1
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		    bhdE bhdJ bhMvst bhavst bhjvst mbh0 mbhvst a0 j0 avst jvst qbh0 qom0 qbhvst qomvst \
		    rhorvst riscovst horizonti}
		    #
gammieener 0	#
		# 2+8*11+2=92
		#
		da ener.out
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src \
		    divbmax divbavg }
		    #
		    enerdefs1
		    #
gammieenerjet 1	#
		da $1
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src}
		    #
		    enerdefs1
		    #
		    #
gammieenero3 0	#
		da ener.out
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t pointa pointb \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    u0src u1src u2src u3src u4src u5src u6src u7src \
		    nstep divbmax divbavg }
		    #
		    set realu1dot0=-(u1dot0-u0dot0)
		    set realu1dot1=-(u1dot1-u0dot1)
		    set realu1dot2=-(u1dot2-u0dot2)
		    set realu1dot3=-(u1dot3-u0dot3)
		    #set realu1dot0=u1dot0
		    #set realu1dot1=u1dot1
		    #set realu1dot2=u1dot2
		    #set realu1dot3=u1dot3
		    set eff0=1-realu1dot0/u0dot0
		    set eff1=1-realu1dot1/u0dot1
		    set eff2=1-realu1dot2/u0dot2
		    set eff3=1-realu1dot3/u0dot3
		    set lom0=u4dot0/u0dot0
		    set lom1=u4dot1/u0dot1
		    set lom2=u4dot2/u0dot2
		    set lom3=u4dot3/u0dot3
		    #
		    set dm=u0dot1
		    set dl=u4dot1
		    set de=realu1dot1
		    set dem=de/dm
		    set dlm=dl/dm
		    set eff=eff1
		    #set da = dl/(2.*a*de)
		    set da = -dl+2.*a*de
		    set dam = -da/dm
		# for use of jons macro
		set min1d=u0dot1
		set ein1d=realu1dot1
		set mx3in1d=u4dot1
		set td=t
		#define GAMMIE (1)
                #
gammieenero2 0	#
		da ener.out
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t pointa pointb \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0cum0 u1cum0 u2cum0 u3cum0 u4cum0 u5cum0 u6cum0 u7cum0 \
		    u0cum1 u1cum1 u2cum1 u3cum1 u4cum1 u5cum1 u6cum1 u7cum1 \
		    u0cum2 u1cum2 u2cum2 u3cum2 u4cum2 u5cum2 u6cum2 u7cum2 \
		    u0cum3 u1cum3 u2cum3 u3cum3 u4cum3 u5cum3 u6cum3 u7cum3 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    nstep divbmax divbavg }
		    set realu1dot0=-(u1dot0-u0dot0)
		    set realu1dot1=-(u1dot1-u0dot1)
		    set realu1dot2=-(u1dot2-u0dot2)
		    set realu1dot3=-(u1dot3-u0dot3)
		    #set realu1dot0=u1dot0
		    #set realu1dot1=u1dot1
		    #set realu1dot2=u1dot2
		    #set realu1dot3=u1dot3
		    set eff0=1-realu1dot0/u0dot0
		    set eff1=1-realu1dot1/u0dot1
		    set eff2=1-realu1dot2/u0dot2
		    set eff3=1-realu1dot3/u0dot3
		    set lom0=u4dot0/u0dot0
		    set lom1=u4dot1/u0dot1
		    set lom2=u4dot2/u0dot2
		    set lom3=u4dot3/u0dot3
		    #
		    set dm=u0dot1
		    set dl=u4dot1
		    set de=realu1dot1
		    set dem=de/dm
		    set dlm=dl/dm
		    set eff=eff1
		    #set da = dl/(2.*a*de)
		    set da = -dl+2.*a*de
		    set dam = -da/dm
		    #
		# for use of jons macro
		set min1d=u0dot1
		set ein1d=realu1dot1
		set mx3in1d=u4dot1
		set td=t
		#define GAMMIE (1)
                #
gammieenero1 0	#
		da ener.out
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t pointa pointb \
		       u0 u1 u2 u3 u4 u5 u6 u7 \
		    u0dot0 u1dot0 u2dot0 u3dot0 u4dot0 u5dot0 u6dot0 u7dot0 \
		    u0dot1 u1dot1 u2dot1 u3dot1 u4dot1 u5dot1 u6dot1 u7dot1 \
		    u0dot2 u1dot2 u2dot2 u3dot2 u4dot2 u5dot2 u6dot2 u7dot2 \
		    u0dot3 u1dot3 u2dot3 u3dot3 u4dot3 u5dot3 u6dot3 u7dot3 \
		    u0fl u1fl u2fl u3fl u4fl u5fl u6fl u7fl \
		    nstep divbmax divbavg }
		    set realu1dot0=-(u1dot0-u0dot0)
		    set realu1dot1=-(u1dot1-u0dot1)
		    set realu1dot2=-(u1dot2-u0dot2)
		    set realu1dot3=-(u1dot3-u0dot3)
		    #set realu1dot0=u1dot0
		    #set realu1dot1=u1dot1
		    #set realu1dot2=u1dot2
		    #set realu1dot3=u1dot3
		    set eff0=1-realu1dot0/u0dot0
		    set eff1=1-realu1dot1/u0dot1
		    set eff2=1-realu1dot2/u0dot2
		    set eff3=1-realu1dot3/u0dot3
		    set lom0=u4dot0/u0dot0
		    set lom1=u4dot1/u0dot1
		    set lom2=u4dot2/u0dot2
		    set lom3=u4dot3/u0dot3
		    #
		    set dm=u0dot1
		    set dl=u4dot1
		    set de=realu1dot1
		    set dem=de/dm
		    set dlm=dl/dm
		    set eff=eff1
		    #set da = dl/(2.*a*de)
		    set da = -dl+2.*a*de
		    set dam = -da/dm
		    #
		# for use of jons macro
		set min1d=u0dot1
		set ein1d=realu1dot1
		set mx3in1d=u4dot1
		set td=t
		#define GAMMIE (1)
                #
gammieenerold    0 #
                da ener.out
		lines 1 10000000
                read {t 1 rmed 2 pp 3 e 4 pmid 5 pmed2 6 mdot 7 edot 8 mx1dot 9 mx2dot 10 ldot 11 bx1dot 12 bx2dot 13 bx3dot 14}
		set realedot=edot-mdot
		set dm=mdot
		set de=edot
		set dl=ldot
		#
		set eff = 1. - de/dm
		set dem = de/dm
		set dlm = dl/dm
		#set da = dl/(2.*a*de)
		set da = -dl+2.*a*de
		set dam = -da/dm
		#		
		# for use of jon's macro
		set min1d=mdot
		set ein1d=realedot
		set mx3in1d=ldot
		set td=t
		#define GAMMIE (1)
                #
gammieenerold2    0 #
                da ener.out		
                lines 1 10000000
		#read {t 1 mass 2 angmom 3 energy 4 pointa 5 pointb 6 dm 7 de 8 dl 9}
                #READ '' { t mass angmom energy pointa pointb dm de dl }
                read '%g %g %g %g %g %g %g %g %g' { t mass angmom energy pointa pointb dm de dl }
		set eff = 1. - de/dm
		set dem = de/dm
		set dlm = dl/dm
		#set da = dl/(2.*a*de)
		set da = -dl+2.*a*de
		set dam = -da/dm
		#
gammiefudgeedener 0
		lines 1 10000000
                read {t 1 rmed 2 pp 3 e 4 pmid 5 pmed2 6 mdot 7 edot 8 ldot 9}
		set dm=mdot
		set dl=ldot
		set realedot=edot
		set de=realedot
		set da=-dl+2*a*de
		set dam=-da/dm
		set eff=1-de/dm
                #
gammieenerout 0 #
		set gu1=u0-u1
		set gu1dot1=u0dot1-u1dot1
		print gener.out {t u0 u4 gu1 pointa pointb u0dot1 gu1dot1 u4dot1}
		#
		#

		#
		# same part numbers as Tcalcud, shown partly below
		#set $1=eta*uu$dir * ud$comp + ptot*deltas-bu$dir * bd$comp
                #set $1EM=bsq*uu$dir * ud$comp - bu$dir * bd$comp
                #set $1MA=w*uu$dir * ud$comp
		#
                #set $1part0=p*uu$dir*ud$comp
                #set $1part1=rho*uu$dir*ud$comp
                #set $1part2=u*uu$dir*ud$comp
                #set $1part3=bsq*uu$dir*ud$comp
                #set $1part4=p*deltas
                #set $1part5=(bsq*0.5)*deltas
                #set $1part6=-bu$dir*bd$comp
		#
		#
		#
flener0     0   #
		flener flener.out
		#
flener1     0   #
		flenerjet flenerjet0.out
		#
flener2     0   #
		flenerjet flenerjet1.out
		#
flener 1	# flener flener.out
		da $1 #
		lines 1 10000000
		# 426 total = 2+8*7*(4+2)+7*8+4*8
		# t,nstep: 2
		# pdot: 4 DIRECTIONS, 8=NPR primary terms, 7=flux secondary parts to each primary term
		# floor: 8=NPR primary terms, 7 source parts to eac
		# src: 4 parts of 8=NPR floors (4*8)
		# jet2special: 2 DIRECTIONS, 8=NPR primary terms, 7=flux secondary parts to each primary term
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t realnstep \
		       u0dot0part0 u0dot0part1 u0dot0part2 u0dot0part3 u0dot0part4 u0dot0part5 u0dot0part6 \
		       u1dot0part0 u1dot0part1 u1dot0part2 u1dot0part3 u1dot0part4 u1dot0part5 u1dot0part6 \
		       u2dot0part0 u2dot0part1 u2dot0part2 u2dot0part3 u2dot0part4 u2dot0part5 u2dot0part6 \
		       u3dot0part0 u3dot0part1 u3dot0part2 u3dot0part3 u3dot0part4 u3dot0part5 u3dot0part6 \
		       u4dot0part0 u4dot0part1 u4dot0part2 u4dot0part3 u4dot0part4 u4dot0part5 u4dot0part6 \
		       u5dot0part0 u5dot0part1 u5dot0part2 u5dot0part3 u5dot0part4 u5dot0part5 u5dot0part6 \
		       u6dot0part0 u6dot0part1 u6dot0part2 u6dot0part3 u6dot0part4 u6dot0part5 u6dot0part6 \
		       u7dot0part0 u7dot0part1 u7dot0part2 u7dot0part3 u7dot0part4 u7dot0part5 u7dot0part6 \
		    \
  		       u0dot1part0 u0dot1part1 u0dot1part2 u0dot1part3 u0dot1part4 u0dot1part5 u0dot1part6 \
		       u1dot1part0 u1dot1part1 u1dot1part2 u1dot1part3 u1dot1part4 u1dot1part5 u1dot1part6 \
		       u2dot1part0 u2dot1part1 u2dot1part2 u2dot1part3 u2dot1part4 u2dot1part5 u2dot1part6 \
		       u3dot1part0 u3dot1part1 u3dot1part2 u3dot1part3 u3dot1part4 u3dot1part5 u3dot1part6 \
		       u4dot1part0 u4dot1part1 u4dot1part2 u4dot1part3 u4dot1part4 u4dot1part5 u4dot1part6 \
		       u5dot1part0 u5dot1part1 u5dot1part2 u5dot1part3 u5dot1part4 u5dot1part5 u5dot1part6 \
		       u6dot1part0 u6dot1part1 u6dot1part2 u6dot1part3 u6dot1part4 u6dot1part5 u6dot1part6 \
		       u7dot1part0 u7dot1part1 u7dot1part2 u7dot1part3 u7dot1part4 u7dot1part5 u7dot1part6 \
		    \
  		       u0dot2part0 u0dot2part1 u0dot2part2 u0dot2part3 u0dot2part4 u0dot2part5 u0dot2part6 \
		       u1dot2part0 u1dot2part1 u1dot2part2 u1dot2part3 u1dot2part4 u1dot2part5 u1dot2part6 \
		       u2dot2part0 u2dot2part1 u2dot2part2 u2dot2part3 u2dot2part4 u2dot2part5 u2dot2part6 \
		       u3dot2part0 u3dot2part1 u3dot2part2 u3dot2part3 u3dot2part4 u3dot2part5 u3dot2part6 \
		       u4dot2part0 u4dot2part1 u4dot2part2 u4dot2part3 u4dot2part4 u4dot2part5 u4dot2part6 \
		       u5dot2part0 u5dot2part1 u5dot2part2 u5dot2part3 u5dot2part4 u5dot2part5 u5dot2part6 \
		       u6dot2part0 u6dot2part1 u6dot2part2 u6dot2part3 u6dot2part4 u6dot2part5 u6dot2part6 \
		       u7dot2part0 u7dot2part1 u7dot2part2 u7dot2part3 u7dot2part4 u7dot2part5 u7dot2part6 \
		    \
  		       u0dot3part0 u0dot3part1 u0dot3part2 u0dot3part3 u0dot3part4 u0dot3part5 u0dot3part6 \
		       u1dot3part0 u1dot3part1 u1dot3part2 u1dot3part3 u1dot3part4 u1dot3part5 u1dot3part6 \
		       u2dot3part0 u2dot3part1 u2dot3part2 u2dot3part3 u2dot3part4 u2dot3part5 u2dot3part6 \
		       u3dot3part0 u3dot3part1 u3dot3part2 u3dot3part3 u3dot3part4 u3dot3part5 u3dot3part6 \
		       u4dot3part0 u4dot3part1 u4dot3part2 u4dot3part3 u4dot3part4 u4dot3part5 u4dot3part6 \
		       u5dot3part0 u5dot3part1 u5dot3part2 u5dot3part3 u5dot3part4 u5dot3part5 u5dot3part6 \
		       u6dot3part0 u6dot3part1 u6dot3part2 u6dot3part3 u6dot3part4 u6dot3part5 u6dot3part6 \
		       u7dot3part0 u7dot3part1 u7dot3part2 u7dot3part3 u7dot3part4 u7dot3part5 u7dot3part6 \
		    \
  		       u0flpart0 u0flpart1 u0flpart2 u0flpart3 \
		       u1flpart0 u1flpart1 u1flpart2 u1flpart3 \
		       u2flpart0 u2flpart1 u2flpart2 u2flpart3 \
		       u3flpart0 u3flpart1 u3flpart2 u3flpart3 \
		       u4flpart0 u4flpart1 u4flpart2 u4flpart3 \
		       u5flpart0 u5flpart1 u5flpart2 u5flpart3 \
		       u6flpart0 u6flpart1 u6flpart2 u6flpart3 \
		       u7flpart0 u7flpart1 u7flpart2 u7flpart3 \
		    \
  		       u0srcpart0 u0srcpart1 u0srcpart2 u0srcpart3 u0srcpart4 u0srcpart5 u0srcpart6 \
		       u1srcpart0 u1srcpart1 u1srcpart2 u1srcpart3 u1srcpart4 u1srcpart5 u1srcpart6 \
		       u2srcpart0 u2srcpart1 u2srcpart2 u2srcpart3 u2srcpart4 u2srcpart5 u2srcpart6 \
		       u3srcpart0 u3srcpart1 u3srcpart2 u3srcpart3 u3srcpart4 u3srcpart5 u3srcpart6 \
		       u4srcpart0 u4srcpart1 u4srcpart2 u4srcpart3 u4srcpart4 u4srcpart5 u4srcpart6 \
		       u5srcpart0 u5srcpart1 u5srcpart2 u5srcpart3 u5srcpart4 u5srcpart5 u5srcpart6 \
		       u6srcpart0 u6srcpart1 u6srcpart2 u6srcpart3 u6srcpart4 u6srcpart5 u6srcpart6 \
		       u7srcpart0 u7srcpart1 u7srcpart2 u7srcpart3 u7srcpart4 u7srcpart5 u7srcpart6 \
		    \
		       u0dotj0part0 u0dotj0part1 u0dotj0part2 u0dotj0part3 u0dotj0part4 u0dotj0part5 u0dotj0part6 \
		       u1dotj0part0 u1dotj0part1 u1dotj0part2 u1dotj0part3 u1dotj0part4 u1dotj0part5 u1dotj0part6 \
		       u2dotj0part0 u2dotj0part1 u2dotj0part2 u2dotj0part3 u2dotj0part4 u2dotj0part5 u2dotj0part6 \
		       u3dotj0part0 u3dotj0part1 u3dotj0part2 u3dotj0part3 u3dotj0part4 u3dotj0part5 u3dotj0part6 \
		       u4dotj0part0 u4dotj0part1 u4dotj0part2 u4dotj0part3 u4dotj0part4 u4dotj0part5 u4dotj0part6 \
		       u5dotj0part0 u5dotj0part1 u5dotj0part2 u5dotj0part3 u5dotj0part4 u5dotj0part5 u5dotj0part6 \
		       u6dotj0part0 u6dotj0part1 u6dotj0part2 u6dotj0part3 u6dotj0part4 u6dotj0part5 u6dotj0part6 \
		       u7dotj0part0 u7dotj0part1 u7dotj0part2 u7dotj0part3 u7dotj0part4 u7dotj0part5 u7dotj0part6 \
		    \
  		       u0dotj1part0 u0dotj1part1 u0dotj1part2 u0dotj1part3 u0dotj1part4 u0dotj1part5 u0dotj1part6 \
		       u1dotj1part0 u1dotj1part1 u1dotj1part2 u1dotj1part3 u1dotj1part4 u1dotj1part5 u1dotj1part6 \
		       u2dotj1part0 u2dotj1part1 u2dotj1part2 u2dotj1part3 u2dotj1part4 u2dotj1part5 u2dotj1part6 \
		       u3dotj1part0 u3dotj1part1 u3dotj1part2 u3dotj1part3 u3dotj1part4 u3dotj1part5 u3dotj1part6 \
		       u4dotj1part0 u4dotj1part1 u4dotj1part2 u4dotj1part3 u4dotj1part4 u4dotj1part5 u4dotj1part6 \
		       u5dotj1part0 u5dotj1part1 u5dotj1part2 u5dotj1part3 u5dotj1part4 u5dotj1part5 u5dotj1part6 \
		       u6dotj1part0 u6dotj1part1 u6dotj1part2 u6dotj1part3 u6dotj1part4 u6dotj1part5 u6dotj1part6 \
		       u7dotj1part0 u7dotj1part1 u7dotj1part2 u7dotj1part3 u7dotj1part4 u7dotj1part5 u7dotj1part6 \
		    }
		    #
		    flenerdefs1
		    flenerdefs2
		    flenerdefs3
		    #
		#
flenerjet 1	# flenerjet flenerjet0.out
		da $1 #
		lines 1 10000000
		# 314 total = 2+8*7*4+7*8+4*8
		# 4 DIRECTIONS, 8=NPR primary terms, 7=flux secondary parts to each primary term
		# 8=NPR primary terms, 7 source parts to eac
		# 4 parts of 8=NPR floors (4*8)
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t realnstep \
		       u0dot0part0 u0dot0part1 u0dot0part2 u0dot0part3 u0dot0part4 u0dot0part5 u0dot0part6 \
		       u1dot0part0 u1dot0part1 u1dot0part2 u1dot0part3 u1dot0part4 u1dot0part5 u1dot0part6 \
		       u2dot0part0 u2dot0part1 u2dot0part2 u2dot0part3 u2dot0part4 u2dot0part5 u2dot0part6 \
		       u3dot0part0 u3dot0part1 u3dot0part2 u3dot0part3 u3dot0part4 u3dot0part5 u3dot0part6 \
		       u4dot0part0 u4dot0part1 u4dot0part2 u4dot0part3 u4dot0part4 u4dot0part5 u4dot0part6 \
		       u5dot0part0 u5dot0part1 u5dot0part2 u5dot0part3 u5dot0part4 u5dot0part5 u5dot0part6 \
		       u6dot0part0 u6dot0part1 u6dot0part2 u6dot0part3 u6dot0part4 u6dot0part5 u6dot0part6 \
		       u7dot0part0 u7dot0part1 u7dot0part2 u7dot0part3 u7dot0part4 u7dot0part5 u7dot0part6 \
		    \
  		       u0dot1part0 u0dot1part1 u0dot1part2 u0dot1part3 u0dot1part4 u0dot1part5 u0dot1part6 \
		       u1dot1part0 u1dot1part1 u1dot1part2 u1dot1part3 u1dot1part4 u1dot1part5 u1dot1part6 \
		       u2dot1part0 u2dot1part1 u2dot1part2 u2dot1part3 u2dot1part4 u2dot1part5 u2dot1part6 \
		       u3dot1part0 u3dot1part1 u3dot1part2 u3dot1part3 u3dot1part4 u3dot1part5 u3dot1part6 \
		       u4dot1part0 u4dot1part1 u4dot1part2 u4dot1part3 u4dot1part4 u4dot1part5 u4dot1part6 \
		       u5dot1part0 u5dot1part1 u5dot1part2 u5dot1part3 u5dot1part4 u5dot1part5 u5dot1part6 \
		       u6dot1part0 u6dot1part1 u6dot1part2 u6dot1part3 u6dot1part4 u6dot1part5 u6dot1part6 \
		       u7dot1part0 u7dot1part1 u7dot1part2 u7dot1part3 u7dot1part4 u7dot1part5 u7dot1part6 \
		    \
  		       u0dot2part0 u0dot2part1 u0dot2part2 u0dot2part3 u0dot2part4 u0dot2part5 u0dot2part6 \
		       u1dot2part0 u1dot2part1 u1dot2part2 u1dot2part3 u1dot2part4 u1dot2part5 u1dot2part6 \
		       u2dot2part0 u2dot2part1 u2dot2part2 u2dot2part3 u2dot2part4 u2dot2part5 u2dot2part6 \
		       u3dot2part0 u3dot2part1 u3dot2part2 u3dot2part3 u3dot2part4 u3dot2part5 u3dot2part6 \
		       u4dot2part0 u4dot2part1 u4dot2part2 u4dot2part3 u4dot2part4 u4dot2part5 u4dot2part6 \
		       u5dot2part0 u5dot2part1 u5dot2part2 u5dot2part3 u5dot2part4 u5dot2part5 u5dot2part6 \
		       u6dot2part0 u6dot2part1 u6dot2part2 u6dot2part3 u6dot2part4 u6dot2part5 u6dot2part6 \
		       u7dot2part0 u7dot2part1 u7dot2part2 u7dot2part3 u7dot2part4 u7dot2part5 u7dot2part6 \
		    \
  		       u0dot3part0 u0dot3part1 u0dot3part2 u0dot3part3 u0dot3part4 u0dot3part5 u0dot3part6 \
		       u1dot3part0 u1dot3part1 u1dot3part2 u1dot3part3 u1dot3part4 u1dot3part5 u1dot3part6 \
		       u2dot3part0 u2dot3part1 u2dot3part2 u2dot3part3 u2dot3part4 u2dot3part5 u2dot3part6 \
		       u3dot3part0 u3dot3part1 u3dot3part2 u3dot3part3 u3dot3part4 u3dot3part5 u3dot3part6 \
		       u4dot3part0 u4dot3part1 u4dot3part2 u4dot3part3 u4dot3part4 u4dot3part5 u4dot3part6 \
		       u5dot3part0 u5dot3part1 u5dot3part2 u5dot3part3 u5dot3part4 u5dot3part5 u5dot3part6 \
		       u6dot3part0 u6dot3part1 u6dot3part2 u6dot3part3 u6dot3part4 u6dot3part5 u6dot3part6 \
		       u7dot3part0 u7dot3part1 u7dot3part2 u7dot3part3 u7dot3part4 u7dot3part5 u7dot3part6 \
		    \
  		       u0flpart0 u0flpart1 u0flpart2 u0flpart3 \
		       u1flpart0 u1flpart1 u1flpart2 u1flpart3 \
		       u2flpart0 u2flpart1 u2flpart2 u2flpart3 \
		       u3flpart0 u3flpart1 u3flpart2 u3flpart3 \
		       u4flpart0 u4flpart1 u4flpart2 u4flpart3 \
		       u5flpart0 u5flpart1 u5flpart2 u5flpart3 \
		       u6flpart0 u6flpart1 u6flpart2 u6flpart3 \
		       u7flpart0 u7flpart1 u7flpart2 u7flpart3 \
		    \
  		       u0srcpart0 u0srcpart1 u0srcpart2 u0srcpart3 u0srcpart4 u0srcpart5 u0srcpart6 \
		       u1srcpart0 u1srcpart1 u1srcpart2 u1srcpart3 u1srcpart4 u1srcpart5 u1srcpart6 \
		       u2srcpart0 u2srcpart1 u2srcpart2 u2srcpart3 u2srcpart4 u2srcpart5 u2srcpart6 \
		       u3srcpart0 u3srcpart1 u3srcpart2 u3srcpart3 u3srcpart4 u3srcpart5 u3srcpart6 \
		       u4srcpart0 u4srcpart1 u4srcpart2 u4srcpart3 u4srcpart4 u4srcpart5 u4srcpart6 \
		       u5srcpart0 u5srcpart1 u5srcpart2 u5srcpart3 u5srcpart4 u5srcpart5 u5srcpart6 \
		       u6srcpart0 u6srcpart1 u6srcpart2 u6srcpart3 u6srcpart4 u6srcpart5 u6srcpart6 \
		       u7srcpart0 u7srcpart1 u7srcpart2 u7srcpart3 u7srcpart4 u7srcpart5 u7srcpart6 \
		    }
		    #
		    flenerdefs1
		    flenerdefs2
		#
		    #
flenerold1 0	#
		da flener.out  # was .dat
		lines 1 10000000
		# 394 total = 2+8*7*(4+2)+7*8
		# 4 DIRECTIONS, 8=NPR primary terms, 7=flux secondary parts to each primary term
		# 2 DIRECTIONS, 8=NPR primary terms, 7=flux secondary parts to each primary term
		# 8=NPR primary terms, 7 source parts to each
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t realnstep \
		       u0dot0part0 u0dot0part1 u0dot0part2 u0dot0part3 u0dot0part4 u0dot0part5 u0dot0part6 \
		       u1dot0part0 u1dot0part1 u1dot0part2 u1dot0part3 u1dot0part4 u1dot0part5 u1dot0part6 \
		       u2dot0part0 u2dot0part1 u2dot0part2 u2dot0part3 u2dot0part4 u2dot0part5 u2dot0part6 \
		       u3dot0part0 u3dot0part1 u3dot0part2 u3dot0part3 u3dot0part4 u3dot0part5 u3dot0part6 \
		       u4dot0part0 u4dot0part1 u4dot0part2 u4dot0part3 u4dot0part4 u4dot0part5 u4dot0part6 \
		       u5dot0part0 u5dot0part1 u5dot0part2 u5dot0part3 u5dot0part4 u5dot0part5 u5dot0part6 \
		       u6dot0part0 u6dot0part1 u6dot0part2 u6dot0part3 u6dot0part4 u6dot0part5 u6dot0part6 \
		       u7dot0part0 u7dot0part1 u7dot0part2 u7dot0part3 u7dot0part4 u7dot0part5 u7dot0part6 \
		    \
  		       u0dot1part0 u0dot1part1 u0dot1part2 u0dot1part3 u0dot1part4 u0dot1part5 u0dot1part6 \
		       u1dot1part0 u1dot1part1 u1dot1part2 u1dot1part3 u1dot1part4 u1dot1part5 u1dot1part6 \
		       u2dot1part0 u2dot1part1 u2dot1part2 u2dot1part3 u2dot1part4 u2dot1part5 u2dot1part6 \
		       u3dot1part0 u3dot1part1 u3dot1part2 u3dot1part3 u3dot1part4 u3dot1part5 u3dot1part6 \
		       u4dot1part0 u4dot1part1 u4dot1part2 u4dot1part3 u4dot1part4 u4dot1part5 u4dot1part6 \
		       u5dot1part0 u5dot1part1 u5dot1part2 u5dot1part3 u5dot1part4 u5dot1part5 u5dot1part6 \
		       u6dot1part0 u6dot1part1 u6dot1part2 u6dot1part3 u6dot1part4 u6dot1part5 u6dot1part6 \
		       u7dot1part0 u7dot1part1 u7dot1part2 u7dot1part3 u7dot1part4 u7dot1part5 u7dot1part6 \
		    \
  		       u0dot2part0 u0dot2part1 u0dot2part2 u0dot2part3 u0dot2part4 u0dot2part5 u0dot2part6 \
		       u1dot2part0 u1dot2part1 u1dot2part2 u1dot2part3 u1dot2part4 u1dot2part5 u1dot2part6 \
		       u2dot2part0 u2dot2part1 u2dot2part2 u2dot2part3 u2dot2part4 u2dot2part5 u2dot2part6 \
		       u3dot2part0 u3dot2part1 u3dot2part2 u3dot2part3 u3dot2part4 u3dot2part5 u3dot2part6 \
		       u4dot2part0 u4dot2part1 u4dot2part2 u4dot2part3 u4dot2part4 u4dot2part5 u4dot2part6 \
		       u5dot2part0 u5dot2part1 u5dot2part2 u5dot2part3 u5dot2part4 u5dot2part5 u5dot2part6 \
		       u6dot2part0 u6dot2part1 u6dot2part2 u6dot2part3 u6dot2part4 u6dot2part5 u6dot2part6 \
		       u7dot2part0 u7dot2part1 u7dot2part2 u7dot2part3 u7dot2part4 u7dot2part5 u7dot2part6 \
		    \
  		       u0dot3part0 u0dot3part1 u0dot3part2 u0dot3part3 u0dot3part4 u0dot3part5 u0dot3part6 \
		       u1dot3part0 u1dot3part1 u1dot3part2 u1dot3part3 u1dot3part4 u1dot3part5 u1dot3part6 \
		       u2dot3part0 u2dot3part1 u2dot3part2 u2dot3part3 u2dot3part4 u2dot3part5 u2dot3part6 \
		       u3dot3part0 u3dot3part1 u3dot3part2 u3dot3part3 u3dot3part4 u3dot3part5 u3dot3part6 \
		       u4dot3part0 u4dot3part1 u4dot3part2 u4dot3part3 u4dot3part4 u4dot3part5 u4dot3part6 \
		       u5dot3part0 u5dot3part1 u5dot3part2 u5dot3part3 u5dot3part4 u5dot3part5 u5dot3part6 \
		       u6dot3part0 u6dot3part1 u6dot3part2 u6dot3part3 u6dot3part4 u6dot3part5 u6dot3part6 \
		       u7dot3part0 u7dot3part1 u7dot3part2 u7dot3part3 u7dot3part4 u7dot3part5 u7dot3part6 \
		    \
		       u0dotj0part0 u0dotj0part1 u0dotj0part2 u0dotj0part3 u0dotj0part4 u0dotj0part5 u0dotj0part6 \
		       u1dotj0part0 u1dotj0part1 u1dotj0part2 u1dotj0part3 u1dotj0part4 u1dotj0part5 u1dotj0part6 \
		       u2dotj0part0 u2dotj0part1 u2dotj0part2 u2dotj0part3 u2dotj0part4 u2dotj0part5 u2dotj0part6 \
		       u3dotj0part0 u3dotj0part1 u3dotj0part2 u3dotj0part3 u3dotj0part4 u3dotj0part5 u3dotj0part6 \
		       u4dotj0part0 u4dotj0part1 u4dotj0part2 u4dotj0part3 u4dotj0part4 u4dotj0part5 u4dotj0part6 \
		       u5dotj0part0 u5dotj0part1 u5dotj0part2 u5dotj0part3 u5dotj0part4 u5dotj0part5 u5dotj0part6 \
		       u6dotj0part0 u6dotj0part1 u6dotj0part2 u6dotj0part3 u6dotj0part4 u6dotj0part5 u6dotj0part6 \
		       u7dotj0part0 u7dotj0part1 u7dotj0part2 u7dotj0part3 u7dotj0part4 u7dotj0part5 u7dotj0part6 \
		    \
  		       u0dotj1part0 u0dotj1part1 u0dotj1part2 u0dotj1part3 u0dotj1part4 u0dotj1part5 u0dotj1part6 \
		       u1dotj1part0 u1dotj1part1 u1dotj1part2 u1dotj1part3 u1dotj1part4 u1dotj1part5 u1dotj1part6 \
		       u2dotj1part0 u2dotj1part1 u2dotj1part2 u2dotj1part3 u2dotj1part4 u2dotj1part5 u2dotj1part6 \
		       u3dotj1part0 u3dotj1part1 u3dotj1part2 u3dotj1part3 u3dotj1part4 u3dotj1part5 u3dotj1part6 \
		       u4dotj1part0 u4dotj1part1 u4dotj1part2 u4dotj1part3 u4dotj1part4 u4dotj1part5 u4dotj1part6 \
		       u5dotj1part0 u5dotj1part1 u5dotj1part2 u5dotj1part3 u5dotj1part4 u5dotj1part5 u5dotj1part6 \
		       u6dotj1part0 u6dotj1part1 u6dotj1part2 u6dotj1part3 u6dotj1part4 u6dotj1part5 u6dotj1part6 \
		       u7dotj1part0 u7dotj1part1 u7dotj1part2 u7dotj1part3 u7dotj1part4 u7dotj1part5 u7dotj1part6 \
		    \
  		       u0srcpart0 u0srcpart1 u0srcpart2 u0srcpart3 u0srcpart4 u0srcpart5 u0srcpart6 \
		       u1srcpart0 u1srcpart1 u1srcpart2 u1srcpart3 u1srcpart4 u1srcpart5 u1srcpart6 \
		       u2srcpart0 u2srcpart1 u2srcpart2 u2srcpart3 u2srcpart4 u2srcpart5 u2srcpart6 \
		       u3srcpart0 u3srcpart1 u3srcpart2 u3srcpart3 u3srcpart4 u3srcpart5 u3srcpart6 \
		       u4srcpart0 u4srcpart1 u4srcpart2 u4srcpart3 u4srcpart4 u4srcpart5 u4srcpart6 \
		       u5srcpart0 u5srcpart1 u5srcpart2 u5srcpart3 u5srcpart4 u5srcpart5 u5srcpart6 \
		       u6srcpart0 u6srcpart1 u6srcpart2 u6srcpart3 u6srcpart4 u6srcpart5 u6srcpart6 \
		       u7srcpart0 u7srcpart1 u7srcpart2 u7srcpart3 u7srcpart4 u7srcpart5 u7srcpart6 \
		    }
		    #
		    #
		    flenerdefs1
		    flenerdefs3
		    #
		#
		#
flenerdefs1 0   #
		    #
		    # assignments
		    #
		    #
		    #
		        set u0dot0tot=u0dot0part0+u0dot0part1+u0dot0part2+u0dot0part3+u0dot0part4+u0dot0part5+u0dot0part6 
		        set u1dot0tot=u1dot0part0+u1dot0part1+u1dot0part2+u1dot0part3+u1dot0part4+u1dot0part5+u1dot0part6
		        set realu1dot0tot=u1dot0tot
		        # to put it in the flux[UU]+flux[RHO] form (i.e. take out rest mass from flux[UU])
		        set u1dot0tot=u1dot0tot+u0dot0tot
		        set u2dot0tot=u2dot0part0+u2dot0part1+u2dot0part2+u2dot0part3+u2dot0part4+u2dot0part5+u2dot0part6 
		        set u3dot0tot=u3dot0part0+u3dot0part1+u3dot0part2+u3dot0part3+u3dot0part4+u3dot0part5+u3dot0part6 
		        set u4dot0tot=u4dot0part0+u4dot0part1+u4dot0part2+u4dot0part3+u4dot0part4+u4dot0part5+u4dot0part6 
		        set u5dot0tot=u5dot0part0+u5dot0part1+u5dot0part2+u5dot0part3+u5dot0part4+u5dot0part5+u5dot0part6 
		        set u6dot0tot=u6dot0part0+u6dot0part1+u6dot0part2+u6dot0part3+u6dot0part4+u6dot0part5+u6dot0part6 
		        set u7dot0tot=u7dot0part0+u7dot0part1+u7dot0part2+u7dot0part3+u7dot0part4+u7dot0part5+u7dot0part6 
		    #
  		        set u0dot1tot=u0dot1part0+u0dot1part1+u0dot1part2+u0dot1part3+u0dot1part4+u0dot1part5+u0dot1part6 
		        set u1dot1tot=u1dot1part0+u1dot1part1+u1dot1part2+u1dot1part3+u1dot1part4+u1dot1part5+u1dot1part6 
		        set realu1dot1tot=u1dot1tot
		        set u1dot1tot=u1dot1tot+u0dot1tot
		        set u2dot1tot=u2dot1part0+u2dot1part1+u2dot1part2+u2dot1part3+u2dot1part4+u2dot1part5+u2dot1part6 
		        set u3dot1tot=u3dot1part0+u3dot1part1+u3dot1part2+u3dot1part3+u3dot1part4+u3dot1part5+u3dot1part6 
		        set u4dot1tot=u4dot1part0+u4dot1part1+u4dot1part2+u4dot1part3+u4dot1part4+u4dot1part5+u4dot1part6 
		        set u5dot1tot=u5dot1part0+u5dot1part1+u5dot1part2+u5dot1part3+u5dot1part4+u5dot1part5+u5dot1part6 
		        set u6dot1tot=u6dot1part0+u6dot1part1+u6dot1part2+u6dot1part3+u6dot1part4+u6dot1part5+u6dot1part6 
		        set u7dot1tot=u7dot1part0+u7dot1part1+u7dot1part2+u7dot1part3+u7dot1part4+u7dot1part5+u7dot1part6 
		    #
  		        set u0dot2tot=u0dot2part0+u0dot2part1+u0dot2part2+u0dot2part3+u0dot2part4+u0dot2part5+u0dot2part6 
		        set u1dot2tot=u1dot2part0+u1dot2part1+u1dot2part2+u1dot2part3+u1dot2part4+u1dot2part5+u1dot2part6
		        set realu1dot2tot=u1dot2tot
		        set u1dot2tot=u1dot2tot+u0dot2tot
		        set u2dot2tot=u2dot2part0+u2dot2part1+u2dot2part2+u2dot2part3+u2dot2part4+u2dot2part5+u2dot2part6 
		        set u3dot2tot=u3dot2part0+u3dot2part1+u3dot2part2+u3dot2part3+u3dot2part4+u3dot2part5+u3dot2part6 
		        set u4dot2tot=u4dot2part0+u4dot2part1+u4dot2part2+u4dot2part3+u4dot2part4+u4dot2part5+u4dot2part6 
		        set u5dot2tot=u5dot2part0+u5dot2part1+u5dot2part2+u5dot2part3+u5dot2part4+u5dot2part5+u5dot2part6 
		        set u6dot2tot=u6dot2part0+u6dot2part1+u6dot2part2+u6dot2part3+u6dot2part4+u6dot2part5+u6dot2part6 
		        set u7dot2tot=u7dot2part0+u7dot2part1+u7dot2part2+u7dot2part3+u7dot2part4+u7dot2part5+u7dot2part6 
		    #
  		        set u0dot3tot=u0dot3part0+u0dot3part1+u0dot3part2+u0dot3part3+u0dot3part4+u0dot3part5+u0dot3part6 
		        set u1dot3tot=u1dot3part0+u1dot3part1+u1dot3part2+u1dot3part3+u1dot3part4+u1dot3part5+u1dot3part6 
		        set realu1dot3tot=u1dot3tot
		        set u1dot3tot=u1dot3tot+u0dot3tot
		        set u2dot3tot=u2dot3part0+u2dot3part1+u2dot3part2+u2dot3part3+u2dot3part4+u2dot3part5+u2dot3part6 
		        set u3dot3tot=u3dot3part0+u3dot3part1+u3dot3part2+u3dot3part3+u3dot3part4+u3dot3part5+u3dot3part6 
		        set u4dot3tot=u4dot3part0+u4dot3part1+u4dot3part2+u4dot3part3+u4dot3part4+u4dot3part5+u4dot3part6 
		        set u5dot3tot=u5dot3part0+u5dot3part1+u5dot3part2+u5dot3part3+u5dot3part4+u5dot3part5+u5dot3part6 
		        set u6dot3tot=u6dot3part0+u6dot3part1+u6dot3part2+u6dot3part3+u6dot3part4+u6dot3part5+u6dot3part6 
		        set u7dot3tot=u7dot3part0+u7dot3part1+u7dot3part2+u7dot3part3+u7dot3part4+u7dot3part5+u7dot3part6 
		    #
  		        set u0srctot=u0srcpart0+u0srcpart1+u0srcpart2+u0srcpart3+u0srcpart4+u0srcpart5+u0srcpart6 
		        set u1srctot=u1srcpart0+u1srcpart1+u1srcpart2+u1srcpart3+u1srcpart4+u1srcpart5+u1srcpart6
		        set realu1srctot=u1srctot
		        # do same for source
		        set u1srctot=u1srctot+u0srctot
		        set u2srctot=u2srcpart0+u2srcpart1+u2srcpart2+u2srcpart3+u2srcpart4+u2srcpart5+u2srcpart6 
		        set u3srctot=u3srcpart0+u3srcpart1+u3srcpart2+u3srcpart3+u3srcpart4+u3srcpart5+u3srcpart6 
		        set u4srctot=u4srcpart0+u4srcpart1+u4srcpart2+u4srcpart3+u4srcpart4+u4srcpart5+u4srcpart6 
		        set u5srctot=u5srcpart0+u5srcpart1+u5srcpart2+u5srcpart3+u5srcpart4+u5srcpart5+u5srcpart6 
		        set u6srctot=u6srcpart0+u6srcpart1+u6srcpart2+u6srcpart3+u6srcpart4+u6srcpart5+u6srcpart6 
		        set u7srctot=u7srcpart0+u7srcpart1+u7srcpart2+u7srcpart3+u7srcpart4+u7srcpart5+u7srcpart6 
		        #
                #
flenerdefs2 0       # floors, added Dec 3, 2004
  		        set u0fltot=u0flpart0+u0flpart1+u0flpart2+u0flpart3 
		        set u1fltot=u1flpart0+u1flpart1+u1flpart2+u1flpart3
		        set realu1fltot=u1fltot
		        # do same for floor
		        set u1fltot=u1fltot+u0fltot
		        set u2fltot=u2flpart0+u2flpart1+u2flpart2+u2flpart3 
		        set u3fltot=u3flpart0+u3flpart1+u3flpart2+u3flpart3 
		        set u4fltot=u4flpart0+u4flpart1+u4flpart2+u4flpart3 
		        set u5fltot=u5flpart0+u5flpart1+u5flpart2+u5flpart3 
		        set u6fltot=u6flpart0+u6flpart1+u6flpart2+u6flpart3 
		        set u7fltot=u7flpart0+u7flpart1+u7flpart2+u7flpart3 
		    #
		    #
flenerdefs3 0       #
		    # special jet2 part
		        set u0dotj0tot=u0dotj0part0+u0dotj0part1+u0dotj0part2+u0dotj0part3+u0dotj0part4+u0dotj0part5+u0dotj0part6 
		        set u1dotj0tot=u1dotj0part0+u1dotj0part1+u1dotj0part2+u1dotj0part3+u1dotj0part4+u1dotj0part5+u1dotj0part6
		        # to put it in the flux[UU]+flux[RHO] form
		        set realu1dotj0tot=u1dotj0tot
		        set u1dotj0tot=u1dotj0tot+u0dotj0tot
		        set u2dotj0tot=u2dotj0part0+u2dotj0part1+u2dotj0part2+u2dotj0part3+u2dotj0part4+u2dotj0part5+u2dotj0part6 
		        set u3dotj0tot=u3dotj0part0+u3dotj0part1+u3dotj0part2+u3dotj0part3+u3dotj0part4+u3dotj0part5+u3dotj0part6 
		        set u4dotj0tot=u4dotj0part0+u4dotj0part1+u4dotj0part2+u4dotj0part3+u4dotj0part4+u4dotj0part5+u4dotj0part6 
		        set u5dotj0tot=u5dotj0part0+u5dotj0part1+u5dotj0part2+u5dotj0part3+u5dotj0part4+u5dotj0part5+u5dotj0part6 
		        set u6dotj0tot=u6dotj0part0+u6dotj0part1+u6dotj0part2+u6dotj0part3+u6dotj0part4+u6dotj0part5+u6dotj0part6 
		        set u7dotj0tot=u7dotj0part0+u7dotj0part1+u7dotj0part2+u7dotj0part3+u7dotj0part4+u7dotj0part5+u7dotj0part6 
		    #
  		        set u0dotj1tot=u0dotj1part0+u0dotj1part1+u0dotj1part2+u0dotj1part3+u0dotj1part4+u0dotj1part5+u0dotj1part6 
		        set u1dotj1tot=u1dotj1part0+u1dotj1part1+u1dotj1part2+u1dotj1part3+u1dotj1part4+u1dotj1part5+u1dotj1part6 
		        set realu1dotj1tot=u1dotj1tot
		        set u1dotj1tot=u1dotj1tot+u0dotj1tot
		        set u2dotj1tot=u2dotj1part0+u2dotj1part1+u2dotj1part2+u2dotj1part3+u2dotj1part4+u2dotj1part5+u2dotj1part6 
		        set u3dotj1tot=u3dotj1part0+u3dotj1part1+u3dotj1part2+u3dotj1part3+u3dotj1part4+u3dotj1part5+u3dotj1part6 
		        set u4dotj1tot=u4dotj1part0+u4dotj1part1+u4dotj1part2+u4dotj1part3+u4dotj1part4+u4dotj1part5+u4dotj1part6 
		        set u5dotj1tot=u5dotj1part0+u5dotj1part1+u5dotj1part2+u5dotj1part3+u5dotj1part4+u5dotj1part5+u5dotj1part6 
		        set u6dotj1tot=u6dotj1part0+u6dotj1part1+u6dotj1part2+u6dotj1part3+u6dotj1part4+u6dotj1part5+u6dotj1part6 
		        set u7dotj1tot=u7dotj1part0+u7dotj1part1+u7dotj1part2+u7dotj1part3+u7dotj1part4+u7dotj1part5+u7dotj1part6 
		    #
flenercheck 1   #
		    # check whether totals from components equals total actual from pdot
		    # 
		    if($1==0) { jrdpener0 flener0 }
		    if($1==1) { jrdpener1 flener1 }
		    if($1==2) { jrdpener2 flener2 }
		    #
		        set u0dot0tdiff=(u0dot0-u0dot0tot)/SUM(u0dot0)/dimen(u0dot0)
		        set u1dot0tdiff=(u1dot0-u1dot0tot)/SUM(u1dot0)/dimen(u1dot0)
		        set u2dot0tdiff=(u2dot0-u2dot0tot)/SUM(u2dot0)/dimen(u2dot0)
		        set u3dot0tdiff=(u3dot0-u3dot0tot)/SUM(u3dot0)/dimen(u3dot0)
		        set u4dot0tdiff=(u4dot0-u4dot0tot)/SUM(u4dot0)/dimen(u4dot0)
		        set u5dot0tdiff=(u5dot0-u5dot0tot)/SUM(u5dot0)/dimen(u5dot0)
		        set u6dot0tdiff=(u6dot0-u6dot0tot)/SUM(u6dot0)/dimen(u6dot0)
		        set u7dot0tdiff=(u7dot0-u7dot0tot)/SUM(u7dot0)/dimen(u7dot0)
		    #
  		        set u0dot1tdiff=(u0dot1-u0dot1tot)/SUM(u0dot1)/dimen(u0dot1)
		        set u1dot1tdiff=(u1dot1-u1dot1tot)/SUM(u1dot1)/dimen(u1dot1)
		        set u1dot1tdiff=(u1dot1-u1dot1tot)/SUM(u1dot1)/dimen(u1dot1)
		        set u2dot1tdiff=(u2dot1-u2dot1tot)/SUM(u2dot1)/dimen(u2dot1)
		        set u3dot1tdiff=(u3dot1-u3dot1tot)/SUM(u3dot1)/dimen(u3dot1)
		        set u4dot1tdiff=(u4dot1-u4dot1tot)/SUM(u4dot1)/dimen(u4dot1)
		        set u5dot1tdiff=(u5dot1-u5dot1tot)/SUM(u5dot1)/dimen(u5dot1)
		        set u6dot1tdiff=(u6dot1-u6dot1tot)/SUM(u6dot1)/dimen(u6dot1)
		        set u7dot1tdiff=(u7dot1-u7dot1tot)/SUM(u7dot1)/dimen(u7dot1)
		    #
  		        set u0dot2tdiff=(u0dot2-u0dot2tot)/SUM(u0dot2)/dimen(u0dot2)
		        set u1dot2tdiff=(u1dot2-u1dot2tot)/SUM(u1dot2)/dimen(u1dot2)
		        set u1dot2tdiff=(u1dot2-u1dot2tot)/SUM(u1dot2)/dimen(u1dot2)
		        set u2dot2tdiff=(u2dot2-u2dot2tot)/SUM(u2dot2)/dimen(u2dot2)
		        set u3dot2tdiff=(u3dot2-u3dot2tot)/SUM(u3dot2)/dimen(u3dot2)
		        set u4dot2tdiff=(u4dot2-u4dot2tot)/SUM(u4dot2)/dimen(u4dot2)
		        set u5dot2tdiff=(u5dot2-u5dot2tot)/SUM(u5dot2)/dimen(u5dot2)
		        set u6dot2tdiff=(u6dot2-u6dot2tot)/SUM(u6dot2)/dimen(u6dot2)
		        set u7dot2tdiff=(u7dot2-u7dot2tot)/SUM(u7dot2)/dimen(u7dot2)
		    #
  		        set u0dot3tdiff=(u0dot3-u0dot3tot)/SUM(u0dot3)/dimen(u0dot3)
		        set u1dot3tdiff=(u1dot3-u1dot3tot)/SUM(u1dot3)/dimen(u1dot3)
		        set u1dot3tdiff=(u1dot3-u1dot3tot)/SUM(u1dot3)/dimen(u1dot3)
		        set u2dot3tdiff=(u2dot3-u2dot3tot)/SUM(u2dot3)/dimen(u2dot3)
		        set u3dot3tdiff=(u3dot3-u3dot3tot)/SUM(u3dot3)/dimen(u3dot3)
		        set u4dot3tdiff=(u4dot3-u4dot3tot)/SUM(u4dot3)/dimen(u4dot3)
		        set u5dot3tdiff=(u5dot3-u5dot3tot)/SUM(u5dot3)/dimen(u5dot3)
		        set u6dot3tdiff=(u6dot3-u6dot3tot)/SUM(u6dot3)/dimen(u6dot3)
		        set u7dot3tdiff=(u7dot3-u7dot3tot)/SUM(u7dot3)/dimen(u7dot3)
		    #
  		        set u0srctdiff=(u0src-u0srctot)/SUM(u0src)/dimen(u0src)
		        set u1srctdiff=(u1src-u1srctot)/SUM(u1src)/dimen(u1src)
		        set u2srctdiff=(u2src-u2srctot)/SUM(u2src)/dimen(u2src)
		        set u3srctdiff=(u3src-u3srctot)/SUM(u3src)/dimen(u3src)
		        set u4srctdiff=(u4src-u4srctot)/SUM(u4src)/dimen(u4src)
		        set u5srctdiff=(u5src-u5srctot)/SUM(u5src)/dimen(u5src)
		        set u6srctdiff=(u6src-u6srctot)/SUM(u6src)/dimen(u6src)
		        set u7srctdiff=(u7src-u7srctot)/SUM(u7src)/dimen(u7src)
		        #
		        #
  		        set u0fltdiff=(u0fl-u0fltot)/SUM(u0fl)/dimen(u0fl)
		        set u1fltdiff=(u1fl-u1fltot)/SUM(u1fl)/dimen(u1fl)
		        set u2fltdiff=(u2fl-u2fltot)/SUM(u2fl)/dimen(u2fl)
		        set u3fltdiff=(u3fl-u3fltot)/SUM(u3fl)/dimen(u3fl)
		        set u4fltdiff=(u4fl-u4fltot)/SUM(u4fl)/dimen(u4fl)
		        set u5fltdiff=(u5fl-u5fltot)/SUM(u5fl)/dimen(u5fl)
		        set u6fltdiff=(u6fl-u6fltot)/SUM(u6fl)/dimen(u6fl)
		        set u7fltdiff=(u7fl-u7fltot)/SUM(u7fl)/dimen(u7fl)
		        #
                #
flenerpldiff 0   #
		    # plot the percent differences
		    # 
		    #
		        pl 0 t u0dot0tdiff
			!sleep 1
		        pl 0 t u1dot0tdiff
			!sleep 1
		        pl 0 t u2dot0tdiff
			!sleep 1
		        pl 0 t u3dot0tdiff
			!sleep 1
		        pl 0 t u4dot0tdiff
			!sleep 1
		        pl 0 t u5dot0tdiff
			!sleep 1
		        pl 0 t u6dot0tdiff
			!sleep 1
		        pl 0 t u7dot0tdiff
			!sleep 1
		    #
  		        pl 0 t u0dot1tdiff
			!sleep 1
		        pl 0 t u1dot1tdiff
			!sleep 1
		        pl 0 t u1dot1tdiff
			!sleep 1
		        pl 0 t u2dot1tdiff
			!sleep 1
		        pl 0 t u3dot1tdiff
			!sleep 1
		        pl 0 t u4dot1tdiff
			!sleep 1
		        pl 0 t u5dot1tdiff
			!sleep 1
		        pl 0 t u6dot1tdiff
			!sleep 1
		        pl 0 t u7dot1tdiff
			!sleep 1
		    #
  		        pl 0 t u0dot2tdiff
			!sleep 1
		        pl 0 t u1dot2tdiff
			!sleep 1
		        pl 0 t u1dot2tdiff
			!sleep 1
		        pl 0 t u2dot2tdiff
			!sleep 1
		        pl 0 t u3dot2tdiff
			!sleep 1
		        pl 0 t u4dot2tdiff
			!sleep 1
		        # below is quite large, but anomalously due to small actual flux compared to approx. summed computed flux
		        pl 0 t u5dot2tdiff
			!sleep 1
		        pl 0 t u6dot2tdiff
			!sleep 1
		        pl 0 t u7dot2tdiff
			!sleep 1
		    #
  		        pl 0 t u0dot3tdiff
			!sleep 1
		        pl 0 t u1dot3tdiff
			!sleep 1
		        pl 0 t u1dot3tdiff
			!sleep 1
		        pl 0 t u2dot3tdiff
			!sleep 1
		        pl 0 t u3dot3tdiff
			!sleep 1
		        pl 0 t u4dot3tdiff
			!sleep 1
		        pl 0 t u5dot3tdiff
			!sleep 1
		        pl 0 t u6dot3tdiff
			!sleep 1
		        pl 0 t u7dot3tdiff
			!sleep 1
		    #
  		        pl 0 t u0srctdiff
			!sleep 1
		        pl 0 t u1srctdiff
			!sleep 1
		        pl 0 t u2srctdiff
			!sleep 1
		        pl 0 t u3srctdiff
			!sleep 1
		        pl 0 t u4srctdiff
			!sleep 1
		        pl 0 t u5srctdiff
			!sleep 1
		        pl 0 t u6srctdiff
			!sleep 1
		        pl 0 t u7srctdiff
			!sleep 1
		        #
		        #
  		        pl 0 t u0fltdiff
			!sleep 1
		        pl 0 t u1fltdiff
			!sleep 1
		        pl 0 t u2fltdiff
			!sleep 1
		        pl 0 t u3fltdiff
			!sleep 1
		        pl 0 t u4fltdiff
			!sleep 1
		        pl 0 t u5fltdiff
			!sleep 1
		        pl 0 t u6fltdiff
			!sleep 1
		        pl 0 t u7fltdiff
			!sleep 1
		        #
                #
gammiegrid 1	# read in grid data
		da dumps/$1
		lines 1 1
		read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  ti   tj   x1   x2   r   h \
		       c000 c001 c002 c003 \
		       c010 c011 c012 c013 \
		       c020 c021 c022 c023 \
		       c030 c031 c032 c033 \
		       c100 c101 c102 c103 \
		       c110 c111 c112 c113 \
		       c120 c121 c122 c123 \
		       c130 c131 c132 c133 \
		       c200 c201 c202 c203 \
		       c210 c211 c212 c213 \
		       c220 c221 c222 c223 \
		       c230 c231 c232 c233 \
		       c300 c301 c302 c303 \
		       c310 c311 c312 c313 \
		       c320 c321 c322 c323 \
		       c330 c331 c332 c333 \
		       gn000 gn001 gn002 gn003 \
		       gn010 gn011 gn012 gn013 \
		       gn020 gn021 gn022 gn023 \
		       gn030 gn031 gn032 gn033 \
		       gn100 gn101 gn102 gn103 \
		       gn110 gn111 gn112 gn113 \
		       gn120 gn121 gn122 gn123 \
		       gn130 gn131 gn132 gn133 \
		       gn200 gn201 gn202 gn203 \
		       gn210 gn211 gn212 gn213 \
		       gn220 gn221 gn222 gn223 \
		       gn230 gn231 gn232 gn233 \
		       gn300 gn301 gn302 gn303 \
		       gn310 gn311 gn312 gn313 \
		       gn320 gn321 gn322 gn323 \
		       gn330 gn331 gn332 gn333 \
		       gv000 gv001 gv002 gv003 \
		       gv010 gv011 gv012 gv013 \
		       gv020 gv021 gv022 gv023 \
		       gv030 gv031 gv032 gv033 \
		       gv100 gv101 gv102 gv103 \
		       gv110 gv111 gv112 gv113 \
		       gv120 gv121 gv122 gv123 \
		       gv130 gv131 gv132 gv133 \
		       gv200 gv201 gv202 gv203 \
		       gv210 gv211 gv212 gv213 \
		       gv220 gv221 gv222 gv223 \
		       gv230 gv231 gv232 gv233 \
		       gv300 gv301 gv302 gv303 \
		       gv310 gv311 gv312 gv313 \
		       gv320 gv321 gv322 gv323 \
		       gv330 gv331 gv332 gv333 \
		       gdet0 gdet1 gdet2 gdet3}
		jre gtwod.m
		gsetup
		setgrd
		#
gammiegridnew 1	# read in grid data with extra connection2
		da dumps/$1
		lines 1 1
		read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  ti   tj   x1   x2   r   h \
		       c000 c001 c002 c003 \
		       c010 c011 c012 c013 \
		       c020 c021 c022 c023 \
		       c030 c031 c032 c033 \
		       c100 c101 c102 c103 \
		       c110 c111 c112 c113 \
		       c120 c121 c122 c123 \
		       c130 c131 c132 c133 \
		       c200 c201 c202 c203 \
		       c210 c211 c212 c213 \
		       c220 c221 c222 c223 \
		       c230 c231 c232 c233 \
		       c300 c301 c302 c303 \
		       c310 c311 c312 c313 \
		       c320 c321 c322 c323 \
		       c330 c331 c332 c333 \
		       gn000 gn001 gn002 gn003 \
		       gn010 gn011 gn012 gn013 \
		       gn020 gn021 gn022 gn023 \
		       gn030 gn031 gn032 gn033 \
		       gn100 gn101 gn102 gn103 \
		       gn110 gn111 gn112 gn113 \
		       gn120 gn121 gn122 gn123 \
		       gn130 gn131 gn132 gn133 \
		       gn200 gn201 gn202 gn203 \
		       gn210 gn211 gn212 gn213 \
		       gn220 gn221 gn222 gn223 \
		       gn230 gn231 gn232 gn233 \
		       gn300 gn301 gn302 gn303 \
		       gn310 gn311 gn312 gn313 \
		       gn320 gn321 gn322 gn323 \
		       gn330 gn331 gn332 gn333 \
		       gv000 gv001 gv002 gv003 \
		       gv010 gv011 gv012 gv013 \
		       gv020 gv021 gv022 gv023 \
		       gv030 gv031 gv032 gv033 \
		       gv100 gv101 gv102 gv103 \
		       gv110 gv111 gv112 gv113 \
		       gv120 gv121 gv122 gv123 \
		       gv130 gv131 gv132 gv133 \
		       gv200 gv201 gv202 gv203 \
		       gv210 gv211 gv212 gv213 \
		       gv220 gv221 gv222 gv223 \
		       gv230 gv231 gv232 gv233 \
		       gv300 gv301 gv302 gv303 \
		       gv310 gv311 gv312 gv313 \
		       gv320 gv321 gv322 gv323 \
		       gv330 gv331 gv332 gv333 \
		       gdet0 gdet1 gdet2 gdet3 \
		       ck0 ck1 ck2 ck3}
		jre gtwod.m
		gsetup
		setgrd
		#
gammiegridnew2 1	# read in grid data with extra connection2 and diagonal dxdxp
		da dumps/$1
		lines 1 1
		read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  ti   tj   x1   x2   r   h \
		       c000 c001 c002 c003 \
		       c010 c011 c012 c013 \
		       c020 c021 c022 c023 \
		       c030 c031 c032 c033 \
		       c100 c101 c102 c103 \
		       c110 c111 c112 c113 \
		       c120 c121 c122 c123 \
		       c130 c131 c132 c133 \
		       c200 c201 c202 c203 \
		       c210 c211 c212 c213 \
		       c220 c221 c222 c223 \
		       c230 c231 c232 c233 \
		       c300 c301 c302 c303 \
		       c310 c311 c312 c313 \
		       c320 c321 c322 c323 \
		       c330 c331 c332 c333 \
		       gn000 gn001 gn002 gn003 \
		       gn010 gn011 gn012 gn013 \
		       gn020 gn021 gn022 gn023 \
		       gn030 gn031 gn032 gn033 \
		       gn100 gn101 gn102 gn103 \
		       gn110 gn111 gn112 gn113 \
		       gn120 gn121 gn122 gn123 \
		       gn130 gn131 gn132 gn133 \
		       gn200 gn201 gn202 gn203 \
		       gn210 gn211 gn212 gn213 \
		       gn220 gn221 gn222 gn223 \
		       gn230 gn231 gn232 gn233 \
		       gn300 gn301 gn302 gn303 \
		       gn310 gn311 gn312 gn313 \
		       gn320 gn321 gn322 gn323 \
		       gn330 gn331 gn332 gn333 \
		       gv000 gv001 gv002 gv003 \
		       gv010 gv011 gv012 gv013 \
		       gv020 gv021 gv022 gv023 \
		       gv030 gv031 gv032 gv033 \
		       gv100 gv101 gv102 gv103 \
		       gv110 gv111 gv112 gv113 \
		       gv120 gv121 gv122 gv123 \
		       gv130 gv131 gv132 gv133 \
		       gv200 gv201 gv202 gv203 \
		       gv210 gv211 gv212 gv213 \
		       gv220 gv221 gv222 gv223 \
		       gv230 gv231 gv232 gv233 \
		       gv300 gv301 gv302 gv303 \
		       gv310 gv311 gv312 gv313 \
		       gv320 gv321 gv322 gv323 \
		       gv330 gv331 gv332 gv333 \
		       gdet0 gdet1 gdet2 gdet3 \
		       ck0 ck1 ck2 ck3 \
		       dxdxp0 dxdxp1 dxdxp2 dxdxp3}
		jre gtwod.m
		gsetup
		setgrd
		#
gammiegridnew3 1	# read in grid data with extra connection2 and all dxdxp's
		#da dumps/$1
		#lines 1 1
		#read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}	
		#lines 2 100000000
		#
		jrdpheader2d $1
		da dumps/$1
		lines 2 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  ti   tj   x1   x2   r   h \
		       c000 c001 c002 c003 \
		       c010 c011 c012 c013 \
		       c020 c021 c022 c023 \
		       c030 c031 c032 c033 \
		       c100 c101 c102 c103 \
		       c110 c111 c112 c113 \
		       c120 c121 c122 c123 \
		       c130 c131 c132 c133 \
		       c200 c201 c202 c203 \
		       c210 c211 c212 c213 \
		       c220 c221 c222 c223 \
		       c230 c231 c232 c233 \
		       c300 c301 c302 c303 \
		       c310 c311 c312 c313 \
		       c320 c321 c322 c323 \
		       c330 c331 c332 c333 \
		       gn000 gn001 gn002 gn003 \
		       gn010 gn011 gn012 gn013 \
		       gn020 gn021 gn022 gn023 \
		       gn030 gn031 gn032 gn033 \
		       gn100 gn101 gn102 gn103 \
		       gn110 gn111 gn112 gn113 \
		       gn120 gn121 gn122 gn123 \
		       gn130 gn131 gn132 gn133 \
		       gn200 gn201 gn202 gn203 \
		       gn210 gn211 gn212 gn213 \
		       gn220 gn221 gn222 gn223 \
		       gn230 gn231 gn232 gn233 \
		       gn300 gn301 gn302 gn303 \
		       gn310 gn311 gn312 gn313 \
		       gn320 gn321 gn322 gn323 \
		       gn330 gn331 gn332 gn333 \
		       gv000 gv001 gv002 gv003 \
		       gv010 gv011 gv012 gv013 \
		       gv020 gv021 gv022 gv023 \
		       gv030 gv031 gv032 gv033 \
		       gv100 gv101 gv102 gv103 \
		       gv110 gv111 gv112 gv113 \
		       gv120 gv121 gv122 gv123 \
		       gv130 gv131 gv132 gv133 \
		       gv200 gv201 gv202 gv203 \
		       gv210 gv211 gv212 gv213 \
		       gv220 gv221 gv222 gv223 \
		       gv230 gv231 gv232 gv233 \
		       gv300 gv301 gv302 gv303 \
		       gv310 gv311 gv312 gv313 \
		       gv320 gv321 gv322 gv323 \
		       gv330 gv331 gv332 gv333 \
		       gdet0 gdet1 gdet2 gdet3 \
		       ck0 ck1 ck2 ck3 \
		       dxdxp00 dxdxp01 dxdxp02 dxdxp03 \
		       dxdxp10 dxdxp11 dxdxp12 dxdxp13 \
		       dxdxp20 dxdxp21 dxdxp22 dxdxp23 \
		       dxdxp30 dxdxp31 dxdxp32 dxdxp33}
		jre gtwod.m
		gsetup
		setgrd
		#
grid3d  1	# read in grid data with extra connection2 and all dxdxp's
		#
                !if [ -f dumps/$1 ]; then echo "1" > testifexists.$1.temp ; else echo "0" > testifexists.$1.temp; fi
		da testifexists.$1.temp
		read '%d' {fileexists}
		!rm -rf testifexists.$1.temp
		define filexistsdef (fileexists)
		#
		if($filexistsdef ==0){\
		 echo "File dumps/$!!1 does not exist"
		}
                #
		if($filexistsdef ==1){\
		 #
		 jrdpheader3d dumps/$1
		 da dumps/$1
		 lines 2 10000000
		 #
		 read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  ti   tj   tk  x1   x2   x3   V1   V2  V3 \
		       c000 c001 c002 c003 \
		       c010 c011 c012 c013 \
		       c020 c021 c022 c023 \
		       c030 c031 c032 c033 \
		       c100 c101 c102 c103 \
		       c110 c111 c112 c113 \
		       c120 c121 c122 c123 \
		       c130 c131 c132 c133 \
		       c200 c201 c202 c203 \
		       c210 c211 c212 c213 \
		       c220 c221 c222 c223 \
		       c230 c231 c232 c233 \
		       c300 c301 c302 c303 \
		       c310 c311 c312 c313 \
		       c320 c321 c322 c323 \
		       c330 c331 c332 c333 \
		       gn300 gn301 gn302 gn303 \
		       gn310 gn311 gn312 gn313 \
		       gn320 gn321 gn322 gn323 \
		       gn330 gn331 gn332 gn333 \
		       gv300 gv301 gv302 gv303 \
		       gv310 gv311 gv312 gv313 \
		       gv320 gv321 gv322 gv323 \
		       gv330 gv331 gv332 gv333 \
		       gdet \
		       ck0 ck1 ck2 ck3 \
		       dxdxp00 dxdxp01 dxdxp02 dxdxp03 \
		       dxdxp10 dxdxp11 dxdxp12 dxdxp13 \
		       dxdxp20 dxdxp21 dxdxp22 dxdxp23 \
		       dxdxp30 dxdxp31 dxdxp32 dxdxp33}
		       #
		       set r=V1
		       set h=V2
		       set ph=V3
		       #
		 jre gtwod.m
		 gsetup
		 setgrd
		}
		#
gammiestress 5 # gammiestress tot2em tot2ma totmdot 6 PI/2
		gammieflux $4 $5 lflem $1
		gammieflux $4 $5 lflma $2
		set fmdot=rho*uu1
                gammieflux $4 $5 fmdot $3
              #
stressdoallg             #
		     ctype default
		     #rdnumd
		     #set start=2*$NUMDUMPS/3
		     #set end=$NUMDUMPS-1
		     set start=83
		     set end=125
		     avgtimeg 'dump' start end
		     # or just 1 dump
		     #rdp dump125.dat
		     #set Flmtime=-br*bp
		     #set entime=u
		     #set b2time=br**2+bh**2+bp**2
		     echo doing flm
		     thetaphiavg PI/6 Flmtime avgflm newx1
		     echo doing en
		     thetaphiavg PI/6 entime avgen newx1
		     echo doing b2
		     thetaphiavg PI/6 b2time avgb2 newx1
		     echo doing plot
		     define totalgrid (0)
		     stressplotgreal	
stressplotgreal #
		     erase
                     device postencap plotallgrmhdslimtimeavg.eps
		     set lgnewx1=LG(newx1)
		     if($totalgrid){\
		            set innerr = newx1[2]*.9999
		            set outerr = newx1[$nx-3]*1.0001
		         }
		     if($totalgrid==0){\
		            set innerr = newx1[0]*.9999
		            set outerr = newx1[$nx-1]*1.0001
		         }		         
		     set max=avgflm if((newx1>=innerr)&&(newx1<=outerr))
		     set press=avgen*($gam-1) if((newx1>=innerr)&&(newx1<=outerr))
		     set magpress=0.5*avgb2 if((newx1>=innerr)&&(newx1<=outerr))
		     set realx1=newx1 if((newx1>=innerr)&&(newx1<=outerr))		     
		     #limits lgnewx1 -8 -3
                     limits realx1 -8 -2
                     #ticksize -1 0 -1 0
		     ticksize 0 0 -1 0
		     fdraft
		     box
		     xla R c^2/GM
		     ltype 0
		     # maxwell stress
		     #connect lgnewx1 (LG(ABS(max))) 
		     connect realx1 (LG(ABS(max)))
		     # gas prssure
		     ltype 3
		     #connect lgnewx1 (LG(ABS(press)))
		     connect realx1 (LG(ABS(press)))
		     # magnetic pressure
		     ltype 4
		     connect realx1 (LG(ABS(magpress)))
		     device X11
		     #ctype red connect lgnewx1 (-2.45-2*lgnewx1)		
forfline    0   # (out of date)
		# use avgtimeg2
		define print_noheader (1)
		print "dumps/forfldump" {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope}
		#print + "dumps/forfldump" {ti tj btimex btimey btimez gdet}
		print + "dumps/forfldump" {ti tj B1 B2 B3 gdet}
		# then run:
		#!./dumps/smcalc 1 1 456 456 ./dumps/forfldump ./dumps/tavgfl
		#!./dumps/iinterp 1 1 1 1 456 456 1.0 0 1.0 512 1024 1.321 40 0 40 40 0.3 < ./dumps/tavgfl > ./dumps/itavgfl
		#!./dumps/iinterp 1 1 1 1 456 456 1.0 0 1.0 512 1024 1.321 40 0 6 6 0.3 < ./dumps/tavgfl > ./dumps/itavgfl
		#
		!./dumps/smcalc 1 1 456 456 ./dumps/forfldump ./dumps/1fline
		!./dumps/iinterp 1 1 1 1 456 456 1.0 0 1.0 512 1024 1.321 40 0 40 40 0.3 < ./dumps/1fline > ./dumps/i1fline
		print {_Rin _Rout _R0 _hslope}
		#
		# 
		#
setupbasicdirs 0 #
		# # imagesdir, dumpsdir, idumpsdir, iimagesdir used by interps3ddump and interps3dimage
		# non-interpolated images and dumps
		define imagesdir "./images/"
		define dumpsdir "./dumps/"
		#
		# thing to preappend to file name for interpolated things
		define dumpspreappend "i"
		define imagespreappend "i"
		#
		# interpolated dumps (same location for idumps for now)
		define idumpsdir "./idumps/" 
		#
		#
interpsingle 18   #
		# interpsingle aphi 384 768 xin xout yin yout
		# interpsingle aphi 384 768 xin xout yin yout 1
		#
		#define program "iinterp"
		#define program "iinterpextrap"
		define program "iinterpnoextrap"
		#define program "iinterpsuperextrap"
		#
		# outputs single data column to be interpolated by iinterp
		#
		echo "interpolating $!1"
		#
		if($?2 == 1) { set getnxy=1 } else { set getnxy=0 }
		if($?4 == 1) { set getxymax=1 } else { set getxymax=0 }
		if($?8 == 1) { set getgrid=1 } else { set getgrid=0 }
		set todump=$1
		define print_noheader (1)
		# must keep header in line with code's expectation
		print "dumps/$!!1" {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		print + "dumps/$!!1" '%21.15g\n' {todump}
		# then run:
		if(getnxy) { define inx ($2) define iny ($3) define inz (1) }
		if(getnxy==0) { define inx ($nx) define iny ($nx*2) define inz (1) }
		if(getxymax) { define ixmin ($4) define ixmax ($5) define iymin ($6) define iymax ($7) }
		if(getxymax==0) { define ixmin (0) define ixmax (_Rout) define iymin (-_Rout) define iymax (_Rout) }
		#
		define iRin (_Rin)
		define iRout (_Rout)
		define ihslope (_hslope)
		define idt (_dt)
		define iR0 (_R0)
		#
		if(getgrid==0){ define igrid (0) }
		if(getgrid==1){ define igrid ($8) }
		#
		define idefcoord (_defcoord)
		#
		# only need refinement (1.0 below to >1.0) if original at low resolution - say 64^2 and lower)
		# currently 25 user args
		# INTERPTYPE: 0=nearest 1=bi-linear 2=planar 3=bicubic
		define interptype (3)
		#define interptype (0)
		#
		# spherical polar assumed as input
		define oldgrid (1)
		#
		!~/sm/$program 1 $interptype 1 1 $nx $ny $nz  2.0 0 0  $oldgrid $igrid  $inx $iny $inz  $ixmin $ixmax $iymin $iymax 0 0  $iRin $iRout $iR0 $ihslope $idefcoord < ./dumps/$1 > ./dumps/i$1
		#
		#
interps3d    18 #
                #
                if($?8 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 $8 }\
                else{\
                     if($?4 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 }\
                     else{\
                          if($?2 == 1) { interps3dpre $1 $2 $3 }\
                          else{\
                               interps3dpre $1
                          }\
                     }\
                }
                #
                # no extrapolation
                interps3ddump $1 0
                #
interps3dextrap 18 #
                #
                if($?8 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 $8 }\
                else{\
                     if($?4 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 }\
                     else{\
                          if($?2 == 1) { interps3dpre $1 $2 $3 }\
                          else{\
                               interps3dpre $1
                          }\
                     }\
                }
                #
                # normal extrapolation
                interps3ddump $1 1
                #
interps3dr8 18  # must define iimagesdir
                #
                if($?8 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 $8 }\
                else{\
                     if($?4 == 1) { interps3dpre $1 $2 $3 $4 $5 $6 $7 }\
                     else{\
                          if($?2 == 1) { interps3dpre $1 $2 $3 }\
                          else{\
                               interps3dpre $1
                          }\
                     }\
                }
                #
                # no extrapolation
                interps3dimage $1 0
                #
interps3dpre 18 #
		# interpsingle aphi 384 768 xin xout yin yout
		# interpsingle aphi 384 768 xin xout yin yout 1
		#
		#define program "iinterp"
		#define program "iinterpextrap"
		define program "iinterpnoextrap"
		#define program "iinterpsuperextrap"
		#
		# outputs single data column to be interpolated by iinterp
		#
		echo "interpolating $!1"
		#
		if($?2 == 1) { set getnxy=1 } else { set getnxy=0 }
		if($?4 == 1) { set getxymax=1 } else { set getxymax=0 }
		if($?8 == 1) { set getgrid=1 } else { set getgrid=0 }
                #
		# then run:
		if(getnxy) { define inx ($2) define iny ($3) define inz (1) }
		if(getnxy==0) { define inx ($nx) define iny ($nx*2) define inz (1) }
		if(getxymax) { define ixmin ($4) define ixmax ($5) define iymin ($6) define iymax ($7) }
                  # Note iymin,iymax determine what j=0,iny means for new grid where ymin associated with j=0
		if(getxymax==0) { define ixmin (0) define ixmax (_Rout) define iymin (-_Rout) define iymax (_Rout) }
		#
		define iRin (_Rin)
		define iRout (_Rout)
		define ihslope (_hslope)
		define idt (_dt)
		define iR0 (_R0)
		#
		if(getgrid==0){ define igrid (0) }
		if(getgrid==1){ define igrid ($8) }
		#
		define idefcoord (_defcoord)
		#
		# only need refinement (1.0 below to >1.0) if original at low resolution - say 64^2 and lower)
		# currently 25 user args
		# INTERPTYPE: 0=nearest 1=bi-linear 2=planar 3=bicubic
		define interptype (3)
		#define interptype (0)
		#
		# spherical polar assumed as input
		define oldgrid (1)
		#
                define doing3d ($nz>1)
                define doing2d (!$doing3d)
                #
interps3ddump 2 #              
		set todump=$1
                set toextrap=$2
                #
		define print_noheader (1)
		# must keep header in line with code's expectation
		print "dumps/$!!1" {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH _is _ie _js _je _ks _ke}
		print + "dumps/$!!1" '%21.15g\n' {todump}
                #
                set h0='$dumpsdir/'
                set h2='$1'
                set _fin = h0+h2
                define filein (_fin)
                #
                set h0='$idumpsdir/'
                set h1='$dumpspreappend'
                set h2='$1'
                set _fout = h0+h1+h2
                define fileout (_fout)
                #
                if(toextrap==1){\
                                define program "iinterpextrap"
                               }
                if(toextrap==0){\
                                define program "iinterpnoextrap"
                               }
                #
                define refinement (2.0)
                #define refinement (1.0)
                #
		!~/sm/$program 1 $interptype 1 1 $nx $ny $nz  $refinement 0 0  $oldgrid $igrid  $inx $iny $inz  $ixmin $ixmax $iymin $iymax 0 0  $iRin $iRout $iR0 $ihslope $idefcoord < $filein > $fileout
		#
		#
		#
interps3dimage 2 #
                 #
                 set toextrap=$2
                 #
                 if($doing2d==0) { define numheaderlines 0 }
                 if($doing2d==1) { define numheaderlines 4 }
                 #
                 # if doing DOUBLEWORK then can't write header since as if data and image not read correctly then
                 define WRITEHEADER 0
                 #
                 #
                 set h0='$imagesdir/'
                 set h2='$1'
                 set _fin = h0+h2
                 define filein (_fin)
                 #
                 set h0='$iimagesdir/'
                 set h1='$imagespreappend'
                 set h2='$1'
                 set _fout = h0+h1+h2
                 define fileout (_fout)
                 #
                 #
                 if(toextrap==1){\
                                 define program "iinterpextrap"
                                }
                 if(toextrap==0){\
                                 define program "iinterpnoextrap"
                                }
                #
                #define refinement (2.0)
                define refinement (1.0)
                #
                # flip image to be compatible with SM plot
                if($iymin<$iymax){\
                                  define tempmin $iymin
                                  define iymin $iymax
                                  define iymax $tempmin
                                  }
                 #
                 # Note images go into $iimagesdir directory
		!~/sm/$program 0 $interptype $doing2d $WRITEHEADER $nx $ny $nz  $refinement 0 0  $oldgrid $igrid  $inx $iny $inz  $ixmin $ixmax $iymin $iymax 0 0  $iRin $iRout $iR0 $ihslope  $idefcoord < $filein > $fileout
		#
		#
		#
readinterp   1  # read an interpolated data column
		jrdp1ci i$1 i$1
		#define x1label "R c^2/GM"
		#define x2label "z c^2/GM"
		define x1label "R"
		define x2label "z"
		#		
readinterp3d   1  # read an interpolated data column
		jrdp3d1ci i$1 i$1
		#define x1label "R c^2/GM"
		#define x2label "z c^2/GM"
		define x1label "R"
		define x2label "z"
		#		
readtavgfl  2   #
		da ./dumps/$1
		lines 2 10000000
		read {temptemp 1}
		set $2=temptemp
		#
gammie1  #
	 define interp (0)
	 define PLANE (3)
	 define nx 128
	 define ny 128
         define nz 1
         define Lx 1
         define Ly 1         
	 define Lz 1
         define Sx 0
         define Sy 0         
	 define Sz 0
         define dx ($Lx/($nx))
         define dy ($Ly/($ny))
         define dz ($Lz/($nz))
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
gammie12  #
         # used for reversed ordering of radius and theta
         set x12=h # my x1 is his theta
         set x22=r # my x2 is his radius
	 define nx $n2
	 define ny $n1
         define nz 1
	 define Sx ($startx2)
	 define Sy ($startx1)
         define Sz (1)
         define dx ($dx2)
         define dy ($dx1)
         define dz (1)
	 define Lx ($n2*$dx2)
         define Ly ($n1*$dx1)
	 define Lz (1)
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
	 define interp (0)
	 define coord (1) # don't want any special treatement since uniform grid
         set x1=h
         set x2=r
         set x12=h
         set x22=r
         set r=rho
         set en=u
         set vx=v1
         set vy=v2
         set vz=v3
         set bx=B1
         set by=B2
         set bz=B3
         set g4=sin(x1)
         set g42=sin(x12)
         set g2=x2
         set g22=x22
         set g3=x2
         set g32=x22
         set g1=1
         set g12=1
	 define x1label "\theta"
	 define x2label "radius"
	 set k=1,$nx*$ny,1
	 set k=0*k
	 #
jrdpbz 1 #
		#
		jrdpcf $1
		#gammiegridnew3 gdump
		faraday
		jsq
		qsq
		stresscalc 1
		
		# account for negative h or h not being monotonic
		set h=(tj<0) ? -h : ((tj>$ny-3*2-1)? (h+(pi-h)*2): h)
		#
		gammienew
		#
		#
gammienew 0     #
		#
		gammienew3d
		#
gammienew2d 0  #
         # used for normal ordering of radius and theta
	 # set whether boundary zones
	 define bc (0) # 2*2 or 0
	 # x1
	 set x12=r
         set x1=r
         set dx1=dr
	 set dx12=dr
	 # x2
         set x22=h
         set x2=h
         set dx2=dh
	 set dx22=dh
         # x3
	 set x3=r*0
	 set x32=x3		
         set dx3=r*0
         set dx3=dx3+2*PI
	 set dx32=dx3		
	 define nx ($n1+$bc)
	 define ny ($n2+$bc)
         define nz 1
	 define Sx (r[0])
	 define Sy (h[0])
         define Sz (1)
         define dx ($dx1)
         define dy ($dx2)
         define dz (1)
	 define Lx (r[$nx*$ny-1]-r[0])
         define Ly (h[$nx*$ny-1]-h[0])
	 define Lz (1)
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
	 define interp (0)
	 #define coord (1) # dont want any special treatement since uniform grid
         define coord (3)
	 define x1label "radius"
	 define x2label "\theta"
	 set k=0,$nx*$ny-1,1
	 set i=0,$nx*$ny-1,1
	 set j=0,$nx*$ny-1,1
	 set i=k%$nx
	 set j=INT(k/$nx)
	 set k=0*k
         #
         #set r=rho
         #set en=u
         set vx=v1
         set vy=v2
         set vz=v3
         set bx=B1
         set by=B2
         set bz=B3
         set g4=sin(x2)
         set g42=sin(x22)
         set g2=x1
         set g22=x12
         set g3=x1
         set g32=x12
         set g1=x1/x1
         set g12=x12/x12
	 set k=1,$nx*$ny,1
	 set k=0*k	 
	 #
		#
		#
gammienew3d 0  #
         # used for normal ordering of radius and theta
	 # set whether boundary zones
	 define bc (0) # 2*2 or 0
	 # x1
	 set x12=r
         set x1=r
         set dx1=dr
	 set dx12=dr
	 # x2
         set x22=h
         set x2=h
         set dx2=dh
	 set dx22=dh
         # x3
	 set x3=ph
	 set x32=ph
         set dx3=dp
	 set dx32=dx3
	 define nx ($n1+$bc)
	 define ny ($n2+$bc)
	 define nz ($n3+$bc)
	 define Sx (r[0])
	 define Sy (h[0])
         define Sz (ph[0])
         define dx ($dx1)
         define dy ($dx2)
         define dz ($dx3)
	 define Lx (r[$nx*$ny-1]-r[0])
         define Ly (h[$nx*$ny-1]-h[0])
         define Lz (ph[$nx*$ny*$nz-1]-ph[0])
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
	 define interp (0)
	 #define coord (1) # dont want any special treatement since uniform grid
         #define coord (3)
	 define x1label "radius"
	 define x2label "\theta"
	 define x3label "\phi"
	 set k=0,$nx*$ny*$nz-1,1
	 set i=0,$nx*$ny*$nz-1,1
	 set j=0,$nx*$ny*$nz-1,1
	 set i=INT(k%($nx))
	 set j=INT((k%($nx*$ny))/$nx)
	 set k=INT(k/($nx*$ny))
         #
         #set r=rho
         #set en=u
         set vx=v1
         set vy=v2
         set vz=v3
         set bx=B1
         set by=B2
         set bz=B3
         set g4=sin(x2)
         set g42=sin(x22)
         set g2=x1
         set g22=x12
         set g3=x1
         set g32=x12
         set g1=x1/x1
         set g12=x12/x12
	 #
gammienewcart 0  #
         # used for normal ordering of radius and theta
	 # set whether boundary zones
	 define bc (0) # 2*2 or 0
	 # x1
	 set x12=r
         set x1=r
         set dx1=dr
	 set dx12=dr
	 # x2
         set x22=h
         set x2=h
         set dx2=dh
	 set dx22=dh
         # x3
	 set x3=r*0
	 set x32=x3		
         set dx3=r*0
         set dx3=dx3+2*PI
	 set dx32=dx3		
	 define nx ($n1+$bc)
	 define ny ($n2+$bc)
         define nz 1
	 define Sx (r[0])
	 define Sy (h[0])
         define Sz (1)
         define dx ($dx1)
         define dy ($dx2)
         define dz (1)
	 define Lx (r[$nx*$ny-1]-r[0])
         define Ly (h[$nx*$ny-1]-h[0])
	 define Lz (1)
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
	 define interp (1)
	 #define coord (1) # dont want any special treatement since uniform grid
         define coord (1)
	 define x1label "x"
	 define x2label "y"
	 set k=0,$nx*$ny-1,1
	 set i=0,$nx*$ny-1,1
	 set j=0,$nx*$ny-1,1
	 set i=k%$nx
	 set j=INT(k/$nx)
	 set k=0*k
         #
         #set r=rho
         #set en=u
         set vx=v1
         set vy=v2
         set vz=v3
         set bx=B1
         set by=B2
         set bz=B3
         set g4=sin(x2)
         set g42=sin(x22)
         set g2=x1
         set g22=x12
         set g3=x1
         set g32=x12
         set g1=x1/x1
         set g12=x12/x12
	 set k=1,$nx*$ny,1
	 set k=0*k	 
	 #
gammienew3  #
	 define gam (5.0/3.0)
         # used for normal ordering of radius and theta
	 # set whether boundary zones
	 define bc (0) # 2*2 or 0
	 # x1
	 set x12=x1
	 #set x1=x1
         set temptemp=x1[1]-x1[0]
	 set dx1=h*0+temptemp
	 set dx12=dx1
	 # x2
         set x22=x2
	 #set x2=h
	 set temptemp=x2[$nx]-x2[0]
	 set dx2=h*0+temptemp
	 set dx22=dx2
         # x3
	 set x3=r*0
	 set x32=x3		
         set dx3=r*0
         set dx3=dx3+2*PI
	 set dx32=dx3		
	 define nx (64+$bc)
	 define ny (64+$bc)
         define nz 1
	 define Sx (x12[0])
	 define Sy (x22[$nx-1])
         define Sz (1)
	 define Lx (x12[$nx-1])
	 define Ly (x22[$ny*$nx-1])
	 define Lz (1)
         define dx ($Lx/($nx))
         define dy ($Ly/($ny))
         define dz ($Lz/($nz))
         define ncpux1 1
         define ncpux2 1
         define ncpux3 1
	 define interp (0)
         define coord (1) # don't want any special treatement since uniform grid
	 define x1label "radius"
	 define x2label "\theta"
	 set k=1,$nx*$ny,1
	 set i=1,$nx*$ny,1
	 set j=1,$nx*$ny,1
	 set i=k%$nx
	 set j=INT(k/$nx)
	 set k=0*k
	 
	 #
gammie2  1 #
	 da $1
         read{which 1 cpu 2 i 3 j 4 pr 5 val 6}
         #set x12=-2*$dx,$Lx+2*$dx,$dx
         #set x22=-2*$dy,$Ly+2*$dy,$dy
	 set x12=j if((pr==0)&&(which==0)&&(cpu==0))
	 set x22=i if((pr==0)&&(which==0)&&(cpu==0))
	 define interp (0)
	 define coord (1)
	 define Sx (x12[0])
	 define Sy (x22[0])
	 #define Sz (x32[0])      # 3D
	 define Sz (x3[0])      # 2D
	#
localdiff #
          set vpos=1,4,1
          set vpos=vpos*0
          set maxdiff=rho*0
         do ii=0,$nx*$ny-1,1 {
           set iindex=INT($ii%($nx))
           set jindex=INT($ii/($nx))
           if((iindex>0)&&(iindex<($nx-1))&&(jindex>0)&&(jindex<($ny-1))){\
             set v0=rho[$ii]
             set vpos[0]=rho[$ii+1]
             set vpos[1]=rho[$ii-1]
             set vpos[2]=rho[$ii+$nx]
             set vpos[3]=rho[$ii-$nx]
             #set olddiff=ABS(v0-vpos[0])
             set olddiff=ABS(vpos[0]/v0)
             do jj=1,3,1 {
              #set newdiff=ABS(v0-vpos[$jj])
              set newdiff=ABS(vpos[$jj]/v0)
              if(newdiff>olddiff){ set olddiff=newdiff}
             }
             set maxdiff[$ii]=olddiff
           }\
           else{\
             #set maxdiff[$ii]=0
             set maxdiff[$ii]=1
           }
         }
utcalc   0 
		print {n}
evolvea  0      #
		set MDOBH=10**(-6)
		#set evda=-dl+2*a*de
		set evda=MDOBH*(-dl+2*a*de)
		#
		set newa=0,dimen(evda)-1,1
		set newa=0*newa
		#
		set newa[0]=a
		do kk=1,dimen(evda)-1,1 {
		   set newa[$kk]=newa[$kk-1]+(t[$kk]-t[$kk-1])*evda[$kk]
		}
superdebug 0    ##
		#
		# from HARM's global.h
		#
		# define COUNTUTOPRIMFAILCONV 0 // if failed to converge
		# define COUNTFLOORACT 1 // if floor activated
		# define COUNTLIMITGAMMAACT 2 // if Gamma limiter activated
		# define COUNTINFLOWACT 3 // if inflow check activated
		# define COUNTUTOPRIMFAILRHONEG 4
		# define COUNTUTOPRIMFAILUNEG 5
		# define COUNTUTOPRIMFAILRHOUNEG 6
		#
		#
		#
		da superdebug.out
		# skip first possibly truncated line
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		{ t nstep step stepnum wc \
		    r    th   ti  tj \
		    rhoi rhof U0i U0f \
		    ui   uf   U1i U1f \
		    v1i  v1f  U2i U2f \
		    v2i  v2f  U3i U3f \
		    v3i  v3f  U4i U4f \
		    B1i  B1f  U5i U5f \
		    B2i  B2f  U6i U6f \
		    B3i  B3f  U7i U7f }
		    #
		    set realU1i=U1i-U0i
		    set realU1f=U1f-U0f
		    #
		    #
		    set numm1=(wc==-1) ? 1 : 0 set numm1=SUM(numm1)
		    set num0=(wc==0) ? 1 : 0 set num0=SUM(num0)
		    set num1=(wc==1) ? 1 : 0 set num1=SUM(num1)
		    set num2=(wc==2) ? 1 : 0 set num2=SUM(num2)
		    set num3=(wc==3) ? 1 : 0 set num3=SUM(num3)
		    set num4=(wc==4) ? 1 : 0 set num4=SUM(num4)
		    set num5=(wc==5) ? 1 : 0 set num5=SUM(num5)
		    set num6=(wc==6) ? 1 : 0 set num6=SUM(num6)
		    print {numm1 num0 num1 num2 num3 num4 num5 num6}
		    #
		    # U1=rho u^t + T^t_t
		    # realU1 = T^t_t <0 normal, >0 only in ergosphere is allowed
		    #
		    #
checkU1 1 #
		checkabs myrealU1i myrealU1f $1		
		    #
check    3 # check myrhoi myrhof lgtype
		# lgtype=0 = linear/linear
		# 1 = linear/log
		# 2 = log / linear
		# 3 = log / log
		#
		#
		picksd -1 wc
		#
		if($3==0){\
		       set one=$1
		       set two=$2
		    }
		if($3==1){\
		       set one=$1
		       set two=LG(ABS($2)+1E-10)
		    }
		if($3==2){\
		       set one=LG(ABS($1)+1E-10)
		       set two=$2
		    }
		if($3==3){\
		       set one=LG(ABS($1)+1E-10)
		       set two=LG(ABS($2)+1E-10)
		    }
		limits one two
		#
		set numtoreduce=INT(dimen(one)/50000)
		reduce one two oner twor numtoreduce
		#
		set lx=$fx1
		set ux=$fx2
		set ly=$fy1
		set uy=$fy2
		#
		if(num0>0){ doabnormal $1 $2 $3  0 }
		if(num1>0){ doabnormal $1 $2 $3  1 }
		if(num2>0){ doabnormal $1 $2 $3  2 }
		if(num3>0){ doabnormal $1 $2 $3  3 }
		if(num4>0){ doabnormal $1 $2 $3  4 }
		if(num5>0){ doabnormal $1 $2 $3  5 }
		if(num6>0){ doabnormal $1 $2 $3  6 }
		#
		setchecklimits
		#
		dofinalplot $3 0
		#
		#
setchecklimits 0 #
		define mylx (lx)
		define myux (ux)
		define myly (ly)
		define myuy (uy)
		#
setchecklimits2 4 #
		define mylx ($1)
		define myux ($2)
		define myly ($3)
		define myuy ($4)
		#
dofinalplot 2   # dofinalplot <same as used above 0-3 for log/log> <points 0/1>
		limits $mylx $myux $myly $myuy
		if($1==0){\
		       ticksize 0 0 0 0
		    }
		if($1==1){\
		       ticksize 0 0 -1 0
		    }
		if($1==2){\
		       ticksize -1 0 0 0
		    }
		if($1==3){\
		       ticksize -1 0 -1 0
		    }
		#
		erase
		ctype default box
		# -1
		ptype 4 1
		ctype default points oner twor
		ptype 4 1
		if(num0>0){ ctype cyan points oner0 twor0 }
		if($2==0){ ptype 4 1 }
		if($2==1){ ptype 1 1 }
		if(num1>0){ ctype blue points oner1 twor1 }
		if(num2>0){ ctype yellow points oner2 twor2 }
		if(num3>0){ ctype green points oner3 twor3 }
		if(num4>0){ ctype green points oner4 twor4 }
		if(num5>0){ ctype red points oner5 twor5 }
		if(num6>0){ ctype green points oner6 twor6 }
		# do
		#	
		#
		#
doabnormal 4    # doabnormal (same 3 args as check) 0
		#
		echo $1 $2 $3 $4
		#
		picksd $4 wc
		#
		if($3==0){\
		       set one=$1
		       set two=$2
		    }
		if($3==1){\
		       set one=$1
		       set two=LG(ABS($2)+1E-10)
		    }
		if($3==2){\
		       set one=LG(ABS($1)+1E-10)
		       set two=$2
		    }
		if($3==3){\
		       set one=LG(ABS($1)+1E-10)
		       set two=LG(ABS($2)+1E-10)
		    }
		limits one two
		#
		set numtoreduce=INT(dimen(one)/50000)
		reduce one two oner$4 twor$4 numtoreduce
		#
		set lx=($fx1<lx) ? $fx1 : lx 
		set ux=($fx2>ux) ? $fx2 : ux 
		set ly=($fy1<ly) ? $fy1 : ly 
		set uy=($fy2>uy) ? $fy2 : uy
		#	#
		#
checkabs    3 # checkabs myrhoi myrhof 0
		#
		#
		picksd -1 wc
		#
		set one=LG(-$1)
		set two=LG(-$2)
		reduce one two oner twor 100
		#
		limits oner twor
		set lx=$fx1
		set ux=$fx2
		set ly=$fy1
		set uy=$fy2
		#
		picksd $3 wc
		#
		set checkri=myr if($1>0)
		set checkthi=myth if($1>0)
		set checkrf=myr if($2>0)
		set checkthf=myth if($2>0)
		#
		set one=LG(-$1)
		set two=LG(-$2)
		limits one two
		#
		set lx=($fx1<lx) ? $fx1 : lx 
		set ux=($fx2>ux) ? $fx2 : ux 
		set ly=($fy1<ly) ? $fy1 : ly 
		set uy=($fy2>uy) ? $fy2 : uy
		#
		define mylx (lx)
		define myux (ux)
		define myly (ly)
		define myuy (uy)
		#
		limits $mylx $myux $myly $myuy
		ticksize -1 0 -1 0
		erase
		ctype default box		
		ptype 1 1
		ctype default points oner twor
		ptype 4 1
		ctype red points one two
		# do
		#	
	#
myplot1 0       #
		picksd 0 wc
		set godr=myr if(ABS(mylinff)<1E-14)
		set godth=myth if(ABS(mylinff)<1E-14)
		pdimen myr
		pdimen godr		
		#
		limits -1E-14 1E-14 0 2000
		ctype default erase box
		ctype cyan points mylinff myeinff
		#
		picksd 5 wc
		set god5=myr if(ABS(mylinff)<1E-14)
		set godt5=myth if(ABS(mylinff)<1E-14)
		pdimen myr
		pdimen god5
		#
myplot2 0       #
		#
		picksd -1 wc
		set use=((myr>50)&&(ABS(myth-pi/2)>pi/2-1.0)) ? 1 : 0
		set myxm1=mylinfi if(use)
		set myym1=myeinfi if(use)
		#
		#limits myxm1 myym1
		#ctype default erase box
		#ctype default points myxm1 myym1
		#
		picksd 0 wc
		set use=((myr>50)&&(ABS(myth-pi/2)>pi/2-1.0)) ? 1 : 0
		set myx0=mylinfi if(use)
		set myy0=myeinfi if(use)
		#
		limits myx0 myy0
		#ctype default erase box
		#ctype cyan points myx0 myy0
		#
		picksd 5 wc
		set use=((myr>50)&&(ABS(myth-pi/2)>pi/2-1.0)) ? 1 : 0
		set myx5=mylinfi if(use)
		set myy5=myeinfi if(use)
		#
		limits myx5 myy5
		#ctype default erase box
		#ctype red points myx5 myy5
		#
		replot2
		#
replot2 0       #
		set lmyxm1=LG(ABS(myxm1))
		set lmyym1=LG(ABS(myym1))
		set lmyx0=LG(ABS(myx0))
		set lmyy0=LG(ABS(myy0))
		set lmyx5=LG(ABS(myx5))
		set lmyy5=LG(ABS(myy5))
		limits lmyxm1 lmyym1
		ticksize -1 0 -1 0
		ctype default erase box
		ptype 1 1
		ctype default points lmyxm1 lmyym1
		ptype 4 1
		ctype cyan points lmyx0 lmyy0
		ctype red points lmyx5 lmyy5
		#
pointssd 2 #
		ticksize 0 0 0 0
		erase
		limits $1 $2
		box
		points $1 $2
		#
		#
lglgsd 2 #
		erase
		ticksize -1 0 -1 0
		set lx=LG($1)
		set ly=LG($2)
		limits lx ly
		box
		points lx ly
		#
		#
lgxsd 2 #
		erase
		ticksize -1 0 0 0
		set lx=LG($1)
		limits lx $2
		box
		points lx $2
		#
		#
lgysd 2 #
		erase
		ticksize 0 0 -1 0
		set ly=LG($2)
		limits $1 ly
		box
		points $1 ly
		#
		#
picksd 2        # picksd 0 wc # to pick wc=0
		set myt=t if($1==$2)
		set mynstep=nstep if($1==$2)
		set mystep=step if($1==$2)
		set mystepnum=stepnum if($1==$2)
		set myr=r if($1==$2)
		set myth=th if($1==$2)
		set myti=ti if($1==$2)
		set mytj=tj if($1==$2)
		set myrhoi=rhoi if($1==$2)
		set myrhof=rhof if($1==$2)
		set myU0i=U0i if($1==$2)
		set myU0f=U0f if($1==$2)
		set myui=ui if($1==$2)
		set myuf=uf if($1==$2)
		set myU1i=U1i if($1==$2)
		set myU1f=U1f if($1==$2)
		set myrealU1i=realU1i if($1==$2)
		set myrealU1f=realU1f if($1==$2)
		set myeinfi=-realU1i/U0i if($1==$2)
		set myeinff=-realU1f/U0f if($1==$2)
		set myv1i=v1i if($1==$2)
		set myv1f=v1f if($1==$2)
		set myU2i=U2i if($1==$2)
		set myU2f=U2f if($1==$2)
		set myv2i=v2i if($1==$2)
		set myv2f=v2f if($1==$2)
		set myU3i=U3i if($1==$2)
		set myU3f=U3f if($1==$2)
		set myv3i=v3i if($1==$2)
		set myv3f=v3f if($1==$2)
		set myU4i=U4i if($1==$2)
		set myU4f=U4f if($1==$2)
		set mylinfi=-U4i/U0i if($1==$2)
		set mylinff=-U4f/U0f if($1==$2)
		set myB1i=B1i if($1==$2)
		set myB1f=B1f if($1==$2)
		set myb1pbi=B1i/U0i if($1==$2)
		set myb1pbf=B1f/U0f if($1==$2)
		set myU5i=U5i if($1==$2)
		set myU5f=U5f if($1==$2)
		set myB2i=B2i if($1==$2)
		set myB2f=B2f if($1==$2)
		set myb2pbi=B2i/U0i if($1==$2)
		set myb2pbf=B2f/U0f if($1==$2)
		set myU6i=U6i if($1==$2)
		set myU6f=U6f if($1==$2)
		set myB3i=B3i if($1==$2)
		set myB3f=B3f if($1==$2)
		set myb3pbi=B3i/U0i if($1==$2)
		set myb3pbf=B3f/U0f if($1==$2)
		set myU7i=U7i if($1==$2)
		set myU7f=U7f if($1==$2)
		#
		#
		#
		    #
debugener 0	#
		#
		#
		da debug.out
		#
		# 2+2+3+3*3+2+4*12 = 66
		#
                # See jrdpdebuggen for more descriptions/details
		#
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
                       dt strokes \
                       wavedt sourcedt gravitydt \
                       wavedti1 wavedtj1 wavedtk1 \
                       wavedti2 wavedtj2 wavedtk2 \
                       wavedti3 wavedtj3 wavedtk3 \
                       horizoni horizoncpupos1 \
		    failt0 floort0 limitt0 inflowt0 failrhot0 failut0 failrhout0 precgamt0 precut0 toentropyt0 tocoldt0 eosfailt0 \
		    failt1 floort1 limitt1 inflowt1 failrhot1 failut1 failrhout1 precgamt1 precut1 toentropyt1 tocoldt1 eosfailt1  \
		    failt2 floort2 limitt2 inflowt2 failrhot2 failut2 failrhout2 precgamt2 precut2 toentropyt2 tocoldt2 eosfailt2  \
		    failt3 floort3 limitt3 inflowt3 failrhot3 failut3 failrhout3 precgamt3 precut3 toentropyt3 tocoldt3 eosfailt3  }
		    #
		    #
		    	# shows where *ever* failed or not
		set lg1failt=lg(failt0+1)
		set lg1tott=lg(failt0+failrhot0+failut0+failrhout0+1)
		#
		set lg1precgamt=lg(precgamt0+1)
		set lg1precut=lg(precut0+1)
		#
		set failtott0=failt0+failrhot0+failut0+failrhout0
		set failtott1=failt1+failrhot1+failut1+failrhout1
		set failtott2=failt2+failrhot2+failut2+failrhout2
		set failtott3=failt3+failrhot3+failut3+failrhout3
		#
		set lgftott0=lg(failtott0+1)
		set lgftott1=lg(failtott1+1)
		set lgftott2=lg(failtott2+1)
		set lgftott3=lg(failtott3+1)
		#
		#
		# absolute totals
		set dtott0=failt0+floort0+limitt0+failrhot0+failut0+failrhout0+precgamt0+precut0
		set dtott1=failt1+floort1+limitt1+failrhot1+failut1+failrhout1+precgamt1+precut1
		set dtott2=failt2+floort2+limitt2+failrhot2+failut2+failrhout2+precgamt2+precut2
		set dtott3=failt3+floort3+limitt3+failrhot3+failut3+failrhout3+precgamt3+precut3
		#
		set lgdtott0=lg(dtott0+1)
		set lgdtott1=lg(dtott1+1)
		set lgdtott2=lg(dtott2+1)
		set lgdtott3=lg(dtott3+1)
		#
		    #
		    #
debugenero3 0	#
		da debug.out
		# 2+4 currently
		#
		# ALLTS 0
		# ENERTS 1
		# IMAGETS 2
		# DEBUGTS 3
		#
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		    failt0 floort0 limitt0 inflowt0 failrhot0 failut0 failrhout0 \
		    failt1 floort1 limitt1 inflowt1 failrhot1 failut1 failrhout1 \
		    failt2 floort2 limitt2 inflowt2 failrhot2 failut2 failrhout2 \
		    failt3 floort3 limitt3 inflowt3 failrhot3 failut3 failrhout3 }
		    #
		    #
debugenerplot1 0    #
		#
		ctype cyan pl 0 t failt0
		ctype blue pl 0 t floort0 0010
		ctype yellow pl 0 t limitt0 0010
		ctype red pl 0 t failut0 0010
		    #
debugenerplot2 0    #
		#
		ctype cyan pl 0 t failt0 0101 0 2000 1 1E8
		ctype blue pl 0 t floort0 0111 0 2000 1 1E8
		ctype yellow pl 0 t limitt0 0111 0 2000 1 1E8
		ctype red pl 0 t failut0 0111 0 2000 1 1E8
		    #
debugenero2 0	#
		da debug.out
		# 2+4 currently
		#
		# ALLTS 0
		# ENERTS 1
		# IMAGETS 2
		# DEBUGTS 3
		#
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {  t nstep \
		    failt0 floort0 limitt0 inflowt0 \
		    failt1 floort1 limitt1 inflowt1 \
		    failt2 floort2 limitt2 inflowt2 \
		    failt3 floort3 limitt3 inflowt3 }
		    #
debugenero1 0	#
		da debug.out
		# 2+4 currently
		# 0=UTOPRIMFAIL
		# 1=FLOORACT
		# 2=LIMITGAMMAACT
		# 3=INFLOWACT (probably should never be nonzero)
		lines 1 10000000
		read '%g %g %g %g %g %g' \
		    {  t nstep \
		    debug0 debug1 debug2 debug3 }
		    #
getBd3 0           #
		#
		#
		#
		 set Bu1=B1
		 set Bu2=B2
		 set gcon03=gn303
		 set gcon13=gn313
		 set gcon23=gn323
		 set gcon33=gn333
		 #
		 set gcov01=gv301
		 set gcov02=gv302
		 set gcov11=gv311
		 set gcov12=gv312
		 set gcov21=gcov12
		 set gcov22=gv322
		 set gcov03=gv303
		 set gcov13=gv313
		 set gcov23=gv323
		 #
		 #
		#
		set Bd3=B1*gv313 + B2*gv323 + B3*gv333
		#
		set bottom=(-1 + gcon03*gcov03 + gcon13*gcov13 + gcon23*gcov23)
		set myBu3 = (-(Bd3*gcon33) - Bu1*gcon03*gcov01 - Bu2*gcon03*gcov02 - Bu1*gcon13*gcov11 - Bu2*gcon13*gcov12 - Bu1*gcon23*gcov21 - Bu2*gcon23*gcov22)/bottom
		#
		#
		#
		#
