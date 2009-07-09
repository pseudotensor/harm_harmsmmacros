gcalc2          17       # gcalc2 1 0 pi/2   or gcalc2 2 rho (1E-3**r**(-1.5)) (last as new variable though)
		# for pi/2 away from equator do:
		# or gcalc2 3 0 pi/2 lflem lflemvsr
		# for 1.0 away from both poles do:
		# gcalc2 4 0 1.0 eflem eflemvsr
		#
		# defined usage, with angle not used
		# set inputuse=(lbrel<0) ? 1 : 0
		# gcalc2 5 2 0 abs absvsr
		#
		#
		# old    0,1,2,3,4
		# gcalc2 6,7,8,9,10 0 1.0 eflem eflemvsr rinner router
		#
		set myomegak= sqrt(1.0/(6.0**3 * (1.0-2/6.0)**2 ) )
                set myliscovar=6.0**2.0*myomegak
		#set myliscovar=1
                define mylisco (myliscovar)
		#
		set calctype=$1
		set iinner=0
		set iouter=$nx-1
		define mynx ($nx)
		#
		if(calctype==3) { set $5=0,$nx-1,1 set $5=$5*0 }
		if(calctype==4) { set $5=0,$nx-1,1 set $5=$5*0 }
		if(calctype==5) { set $5=0,$nx-1,1 set $5=$5*0 }
		if(calctype==6) { set $5=0,$nx-1,1 set $5=$5*0 }
		if((calctype>=7)&&(calctype<=13)) {\
		       # find the i for a given radius
		       define ii (0)
		       while { $ii<$nx } {\
		              if(r[0*$nx+$ii]>=$6) { break }
		              define ii ($ii+1)
		           }
		           set iinner=$ii
		           if(iinner==$nx) { set iinner=$nx-1 }
		           #
		       # find the i for a given radius
		       define ii (0)
		       while { $ii<$nx } {\
		              if(r[0*$nx+$ii]>=$7) { break }
		              define ii ($ii+1)
		           }
		           set iouter=$ii
		           if(iouter==$nx) { set iouter=$nx-1 }
		           #
		       define mynx (iouter-iinner+1)
		       set $5=0,$mynx-1,1
		       set $5=$5*0
		       #
		       if(calctype==7) { set calctype=0 }
		       if(calctype==8) { set calctype=1 }
		       if(calctype==9) { set calctype=2 }
		       if(calctype==10) { set calctype=3 }
		       if(calctype==11) { set calctype=4 }
		       if(calctype==12) { set calctype=5 }
		       if(calctype==13) { set calctype=6 }
		    }
		 #
		set mtot=0,$mynx-1
		set mtot=0*mtot
		set mtot1=mtot
		set mtot2=mtot
		set ltot=mtot
		set ltot1=mtot
		set ltot2=mtot
		set etot=mtot
		set etot1=mtot
		set etot2=mtot
		set etot3=mtot
		set newx1=mtot
		set newr=mtot
		#
		#
		do ii=iinner,iouter,1 {
		   echo $ii
		   if(calctype==0) { set use = (ti==$ii) ? 1 : 0 }
		   if(calctype==1) { set use = ((abs(h-0.5*pi)<$3) && ti==$ii) ? 1 : 0 }
		   if(calctype==2) { set use = (($3>$4) && ti==$ii) ? 1 : 0 }
		   if(calctype==3) { set use = ((abs(h-0.5*pi)<$3) && ti==$ii) ? 1 : 0 }
		   if(calctype==4) { set use = ((abs(h-0.5*pi)>0.5*pi-$3) && ti==$ii) ? 1 : 0 }
		   if(calctype==5) { set use = ((inputuse)&&(ti==$ii)) ? 1 : 0 }
		   if(calctype==6) { set use = ((h>=0.0 && h<$3) && ti==$ii) ? 1 : 0 }
		   #
		   if(calctype<3){\
		 set mtot1[$ii-iinner]=SUM(mflux*use)
		 #set mtot2[$ii-iinner]=SUM(flux01*area*gdet*use)
		 set etot1[$ii-iinner]=SUM(eflux*use)
		 #set etot2[$ii-iinner]=SUM(flux11*area*gdet*use)
		 #set etot3[$ii-iinner]=SUM((flux11-flux01)*area*gdet*use)
		 set ltot1[$ii-iinner]=SUM(lflux*use)
		 #set ltot2[$ii-iinner]=SUM(flux41*area*gdet*use)
		 }
		 # flux in per unit area form
		 if($2==0){\
		  set $5[$ii-iinner]=SUM($4*area*gdet*use)
		}
		# assume already full flux
		 if($2==1){\
		  set $5[$ii-iinner]=SUM($4*area*use)
		}
		# volume average
		 if($2==2){\
		  set $5[$ii-iinner]=SUM($4*use*gdet*dV)/SUM(use*gdet*dV)
		}
		# just average
		 if($2==3){\
		  set $5[$ii-iinner]=SUM($4*use)/SUM(use)
		}
		# pure difference volume average
		 if($2==4){\
		  set $5[$ii-iinner]=SUM($4*use*dV)/SUM(use*dV)
		}
		 #
		  set newrtemp=r if((ti==$ii)&&(tj==0)&&(tk==0))
		  set newx1temp=x1 if((ti==$ii)&&(tj==0)&&(tk==0))
		  set newx1[$ii-iinner]=newx1temp
		  set newr[$ii-iinner]=newrtemp
		}
		if(calctype<3){\
		set ltot=ltot1
		set mtot=mtot1
		set etot=etot1
		set ltotomtot=ltot/mtot
		set etotomtot=etot/mtot
		set etotomtot2=1+etot/mtot
		define dumppos (2)
		set mtotp=mtot[$dumppos]
		set etotp=etot[$dumppos]
		set ltotp=ltot[$dumppos]
		set ltotomtotp=ltotomtot[$dumppos]
		set etotomtot2p=etotomtot2[$dumppos]
		#print {mtot etot ltot ltotomtot etotomtot2}
		print {mtotp etotp ltotp ltotomtotp etotomtot2p}
		print gcalc2.txt {mtotp etotp ltotp ltotomtotp etotomtot2p}
		}
		#
		#
gcalc2tavg 5    # gcalc2tavg (gcalc2 args) startdump# enddump# 
		# must load a dump file first fir nx
		set mfluxtavg=0,$nx-1
		set mfluxtavg=0*mfluxtavg
		set efluxtavg=mfluxtavg
		set lfluxtavg=mfluxtavg
		set start=$4
		set end=$5
		do ii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$ii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$ii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 gcalc2 $1 $2 $3
		 set mfluxtavg=mfluxtavg+mtot
		 set efluxtavg=efluxtavg+etot
		 set lfluxtavg=lfluxtavg+ltot
		}
		set mfluxtavg=mfluxtavg/(end-start+1)
		set efluxtavg=efluxtavg/(end-start+1)
		set lfluxtavg=lfluxtavg/(end-start+1)
		#
		set emfluxtavg=(efluxtavg/mfluxtavg)
		set lmfluxtavg=(lfluxtavg/mfluxtavg)
		print fluxtavg.txt '%21.15g %21.15g %21.15g %21.15g %21.15g\n' {mfluxtavg efluxtavg lfluxtavg emfluxtavg lmfluxtavg}
		#
		set m1=mfluxtavg
		set e1=efluxtavg
		set l1=lfluxtavg
		set em1=emfluxtavg
		set lm1=lmfluxtavg
		# read '%g %g %g %g %g' {m2 e2 l2 em2 lm2}
gcalc23tavg 6    # gcalc2tavg (gcalc2 args (4 of them)) startdump# enddump# 
		# must load a dump file first fir nx
		set tavg=0,$nx-1
		set start=$5
		set end=$6
		do ii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$ii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$ii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 gcalc2 $1 $2 $3 $3vsr
		 set tavg=tavg+$3vsr
		}
		set tavg=tavg/(end-start+1)
		print + tavg.txt {tavg}
		#
gcalc22tavg 16          # gcalc22tavg (gcalc2 args minus vsr arg ) tavgvsrvalue startdump# enddump#
		# e.g. gcalc22tavg 3 pi/2 mflux mfluxtavgvsr 10 40
		# e.g. gcalc22tavg 4 1.0 eflem eflemtavgvsr 10 40
		# must load a dump file first fir nx
		set $4=0,$nx-1
		set $4=$4*0
		set start=$5
		set end=$6
		do ii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$ii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$ii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 gcalc2 $1 $2 $3 $3vsr
		 set $4=$4+$3vsr
		}
		set $4=$4/(end-start+1)
		#
		#
gcalc3          4       # gcalc3 2.0 pi/2 eflem eflemavg
		# gives average in theta at a specific radius
		#
		# find the i for a given radius
		define ii (0)
		while { $ii<$nx } {\
		   if(r[0*$nx+$ii]>=$1) { break }
		   define ii ($ii+1)
		}
		set isel=$ii
		if(isel==$nx) { set isel=$nx-1 }
		#
		set use = ((abs(h-0.5*pi)<=$2) && (ti==isel) ) ? 1 : 0
		set $4=SUM($3*area*gdet*use)
		set toprint=$4
		print {toprint}
		#
gcalc5          6       # gcalc5 rinner router hinner houter eflem eflemavg
		#
		#
		set use = ((r>=$1)&&(r<=$2)&&(h>=$3)&&(h<=$4)) ? 1 : 0
		set $6=SUM($5*dV*use)/SUM(dV*use)
		set toprint=$6
		print {toprint}
		#
gcalc5ij        6       # gcalc5 rinner router hinner houter eflem eflemavg
		#
		#
		set use = ((ti>=$1)&&(ti<=$2)&&(tj>=$3)&&(tj<=$4)) ? 1 : 0
		set $6=SUM($5*dV*use)/SUM(dV*use)
		set toprint=$6
		print {toprint}
		#
gcalc52          6       # gcalc5 rinner router hinner houter eflem eflemavg
		#
		#
		set use = ((r>=$1)&&(r<=$2)&&(h>=$3)&&(h<=$4)) ? 1 : 0
		set $6=SUM($5*gdet*dV*use)/SUM(dV*gdet*use)
		set toprint=$6
		print {toprint}
		#
gcalc4          3       # gcalc4 2.0 eflem eflemvsth
		# gives something vs theta at a specific radius
		#
		# find the i for a given radius
		define ii (0)
		while { $ii<$nx } {\
		   if(r[0*$nx+$ii]>=$1) { break }
		   define ii ($ii+1)
		}
		set isel=$ii
		if(isel==$nx) { set isel=$nx-1 }
		#
		# should have dimensions of $ny
		# just pluck out a value, so not an average (if averaged, would need to average flux then divide it back out!)
		set $3=$2 if(ti==isel)
		set newh=h if(ti==0)
		set newx2=tx2 if(ti==0)
		#
gcalc6          4       # gcalc6 rinner router fdd12 fdd12vsth
		# gives a value radially averaged as a function of theta
		set $4=0,$ny-1,1
		set newh=0,$ny-1,1
		#
		do jj=0,$ny-1,1 {
		   set use = ((r>=$1)&&(r<=$2) && (tj==$jj )) ? 1 : 0
		   # volume average only currently
		   set $4[$jj]=SUM($3*dV*gdet*use)/(SUM(dV*gdet*use))
		   set newh[$jj]=h[$nx*$jj]
		}
		#
gcalc62         6       # gcalc62 rinner router hinner houter fdd12 fdd12vsth
		# gives a value radially averaged as a function of theta
		# average is pure, as needed sometimes
		# find the i for a given radius
		define jj (0)
		while { $jj<$ny } {\
		       if(h[$nx*$jj]>=$3) { break }
		       define jj ($jj+1)
		    }
		    set jinner=$jj
		    if(jinner==$ny) { set jinner=$ny-1 }
		    #
		    # find the i for a given radius
		    define jj (0)
		    while { $jj<$ny } {\
		           if(h[$nx*$jj]>=$4) { break }
		           define jj ($jj+1)
		        }
		        set jouter=$jj
		        if(jouter==$ny) { set jouter=$ny-1 }
		        #
		#
		define myny (jouter-jinner+1)
		#
		set $6=0,$myny-1,1
		set newh=0,$myny-1,1
		do jj=jinner,jouter,1 {
		   set use = ((r>=$1)&&(r<=$2) && (tj==$jj )) ? 1 : 0
		   set $6[$jj-jinner]=SUM($5*dV*use)/SUM(dV*use)
		   set newh[$jj-jinner]=h[$nx*$jj]
		}
		#
gcalc63         6       # gcalc6 hinner houter rinner router fdd02 fdd02vsr
		# gives a value theta averaged as a function of radius
		# average is pure, as needed sometimes
		# find the i for a given radius
		define ii (0)
		while { $ii<$nx } {\
		       if(r[0*$nx+$ii]>=$1) { break }
		       define ii ($ii+1)
		    }
		    set iinner=$ii
		    if(iinner==$nx) { set iinner=$nx-1 }
		    #
		    # find the i for a given radius
		    define ii (0)
		    while { $ii<$nx } {\
		           if(r[0*$nx+$ii]>=$2) { break }
		           define ii ($ii+1)
		        }
		        set iouter=$ii
		        if(iouter==$nx) { set iouter=$nx-1 }
		        #
		#
		#
		define mynx (iouter-iinner+1)
		#
		set $6=0,$mynx-1,1
		set newr=0,$mynx-1,1
		do ii=iinner,iouter,1 {
		   set use = ((h>=$3)&&(h<=$4) && (ti==$ii )) ? 1 : 0
		   set $6[$ii-iinner]=SUM($5*dV*use)/(SUM(dV*use))
		   set newr[$ii-iinner]=r[$ii]
		}
		#
gcalc32     0   #
		# energy flux on a shell at a given radius, theta, phi
		set it=gdet*eflem
		setlimits 2.00 2.001 0 pi 0 1 plflim 0 x2 r h it 0
		set god=SUM(newfun)
		print {god}
gcalc4tavg 5    # gcalc4tavg (gcalc4 args minus the vsth one) tavgvsth startdump# enddump#
		# gcalc4tavg 2.0 eflem eflemtavgvsth 0 40
		# must load a dump file first fir nx
		set $3=0,$ny-1
		set $3=$3*0
		set start=$4
		set end=$5
		do iii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$iii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$iii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 #if($GAMMIE==0) { jrdp $filename }
		 if($FFED) {\
		        jrdpcf $filename
		        faraday
		        fsq
		     }
		 gcalc4 $1 $2 $2vsth
		 set $3=$3+$2vsth
		}
		set $3=$3/(end-start+1)
		#
joncalc4tavg 3    # 
		# joncalc4tavg ($rhor) 10 40
		# must load a dump file first fir nx
		set eflemvsthtavg=0,$ny-1
		#
		set eflemvsthtavg=eflemvsthtavg*0
		set eflmavsthtavg=eflemvsthtavg
		set aeflemvsthtavg=eflemvsthtavg
		set aeflmavsthtavg=eflemvsthtavg
		set brvsthtavg=eflemvsthtavg
		set br2vsthtavg=eflemvsthtavg
		set bsqvsthtavg=eflemvsthtavg
		set wfoomegahvsthtavg=eflemvsthtavg
		set start=$2
		set end=$3
		do iii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$iii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$iii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 gcalc4 $1 eflem eflemvsth
		 gcalc4 $1 eflma eflmavsth
		 gcalc4 $1 B1 brvsth
		 gcalc4 $1 bsq bsqvsth
		 set B1sq=B1**2
		 gcalc4 $1 B1sq br2vsth
		 bzeflux
		 set it=omegaf2/omegah
		 gcalc4 $1 it wfoomegahvsth
		 set eflemvsthtavg=eflemvsthtavg+eflemvsth
		 set eflmavsthtavg=eflmavsthtavg+eflmavsth
		 set aeflemvsthtavg=aeflemvsthtavg+ABS(eflemvsth)
		 set aeflmavsthtavg=aeflmavsthtavg+ABS(eflmavsth)
		 set brvsthtavg=brvsthtavg+brvsth
		 set br2vsthtavg=br2vsthtavg+br2vsth
		 set bsqvsthtavg=bsqvsthtavg+bsqvsth
		 set wfoomegahvsthtavg=wfoomegahvsthtavg+wfoomegahvsth
		}
		set eflemvsthtavg=eflemvsthtavg/(end-start+1)
		set eflmavsthtavg=eflmavsthtavg/(end-start+1)
		set aeflemvsthtavg=aeflemvsthtavg/(end-start+1)
		set aeflmavsthtavg=aeflmavsthtavg/(end-start+1)
		set brvsthtavg=brvsthtavg/(end-start+1)
		set br2vsthtavg=br2vsthtavg/(end-start+1)
		set bsqvsthtavg=bsqvsthtavg/(end-start+1)
		set wfoomegahvsthtavg=wfoomegahvsthtavg/(end-start+1)
		set myarea=area*gdet if(ti==isel)
		set tempem=SUM(myarea*eflemvsthtavg)
		set tempma=SUM(myarea*eflmavsthtavg)
		set tempaem=SUM(myarea*aeflemvsthtavg)
		set tempama=SUM(myarea*aeflmavsthtavg)
		set tempbr=SUM(myarea*brvsthtavg)
		set tempwf=SUM(myarea*wfoomegahvsthtavg)
		set ratemoma=tempem/tempma
		print {ratemoma tempem tempma tempaem tempama tempbr tempwf}
		#
joncalc4write   0
		define print_noheader (1)
		print "dumps/joncalc4.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		{newh eflemvsthtavg eflmavsthtavg aeflemvsthtavg aeflmavsthtavg brvsthtavg br2vsthtavg wfoomegahvsthtavg}
		#
joncalc4read    0
		#
		da ./dumps/joncalc4.txt
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g\n' \
		{newh eflemvsthtavg eflmavsthtavg aeflemvsthtavg aeflmavsthtavg brvsthtavg br2vsthtavg wfoomegahvsthtavg}
		#
localdiff 0 #
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
joncalc1  2 # joncalc1 4 .025
		# OLD
		# around equator
		set use = ((abs(h-0.5*pi)<$2) && (r<=$1) ) ? 1 : 0
		set numshells=SUM(use)/$ny
		set dxdxpr=(r-R0)
		set fhp=SUM(ABS(gdet*area*B1*use))
		set fm=SUM(ABS(mfl*area*use))
		set fe=SUM(ABS(efl*area*use))
		set fl=SUM(ABS(lfl*area*use))
		set rat1=fhp/fm
		set rat2=fe/fm
		set rat3=fl/fm
		set it1=SUM(ABS(uu1*bu3-uu3*bu1)*use)
		set it2=SUM(ABS(B1)*use)
		set rat4=it1/it2
		set it1=SUM(ABS(uu2*bu3-uu3*bu2)*use)
		set it2=SUM(ABS(uu2*bu0-uu0*bu2)*use)
		set rat5=it1/it2
		set omega=SUM(ABS(ud3/ud0)*use)
		print {rat1 rat2 rat3 rat4 rat5 omega}
		#
gojon2    1  #
		!scp metric:sm/gtwod.m ~/sm
		jre gtwod.m
		jrdp dump0000
		!rm joncalc2tavg.txt
		joncalc2tavg $rhor (1.2*$rhor) $1 10 40
		!sh ~/sm/copyscript.sh
		#
joncalc2  3 # joncalc2 $rhor 2.1 .4 # 23degrees
		# around poles in a thick shell
		set shell = ((r>=$1)&&(r<=$2)) ? 1 : 0
		set numshells=SUM(shell)/$ny
		set use1 = ((abs(h-0.5*pi)>0.5*pi-$3) && (r>=$1)&&(r<=$2) ) ? 1 : 0
		# all Pi
		set use2 = ((r>=$1)&&(r<=$2) ) ? 1 : 0
		set volume=SUM(gdet*dV*use1)
		set fb1=SUM(bsq*gdet*dV*use1)/volume
		set fb2=SUM((B1*gdet*area)**2 *use1)/numshells
		set fm=SUM(mfl*area*use2)/numshells
		set fe1=SUM(efl*area*use1)/numshells
		set fe2=SUM(efl*area*use2)/numshells
		set fe3=SUM(eflem*gdet*area*use1)/numshells
		set fe4=SUM(eflem*gdet*area*use2)/numshells
		#
		set it1=SUM(ABS(uu1*bu3-uu3*bu1)*use1)
		set it2=SUM(ABS(B1)*use1)
		#set rat14=it1/it2*6**(1.5)
		set rat14=it1/it2
		set it1=SUM(ABS(uu2*bu3-uu3*bu2)*use1)
		set it2=SUM(ABS(uu2*bu0-uu0*bu2)*use1)
		#set rat15=it1/it2*6**(1.5)
		set rat15=it1/it2
		#
		set rat1=fb1
		set rat2=fb2
		set rat3=fm
		set rat4=fb1/fm
		set rat5=fb2/fm
		set rat6=fe1
		set rat7=fe2
		set rat8=fe3
		set rat9=fe4
		set rat10=fe1/fm
		set rat11=fe2/fm
		set rat12=fe3/fm
		set rat13=fe4/fm
		print {rat1 rat2 rat3 rat4 rat5 rat6 rat7 rat8 rat9 rat10 rat11 rat12 rat13}
		print {rat14 rat15}
		#	
joncalc2tavg 5    # joncalctavg rin rout dtheta start end
		#  joncalc2tavg $rhor (1.2*$rhor) .4 10 40
		# scp joncalc2tavg.txt metric:research/spinup/joncalc2tavg-
		# must load a dump file first fir nx
		set rat1tavg=0
		set rat2tavg=0
		set rat3tavg=0
		set rat4tavg=0
		set rat5tavg=0
		set rat6tavg=0
		set rat7tavg=0
		set rat8tavg=0
		set rat9tavg=0
		set rat10tavg=0
		set rat11tavg=0
		set rat12tavg=0
		set rat13tavg=0
		set start=$4
		set end=$5
		print joncalc2tavg.txt {start end}
		do iii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$iii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$iii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 joncalc2 $1 $2 $3		 
		 set rat1tavg=rat1tavg+rat1
		 set rat2tavg=rat2tavg+rat2
		 set rat3tavg=rat3tavg+rat3
		 set rat4tavg=rat4tavg+rat4
		 set rat5tavg=rat5tavg+rat5
		 set rat6tavg=rat6tavg+rat6
		 set rat7tavg=rat7tavg+rat7
		 set rat8tavg=rat8tavg+rat8
		 set rat9tavg=rat9tavg+rat9
		 set rat10tavg=rat10tavg+rat10
		 set rat11tavg=rat11tavg+rat11
		 set rat12tavg=rat12tavg+rat12
		 set rat13tavg=rat13tavg+rat13
		 print + joncalc2tavg.txt {_t rat1 rat2 rat3 rat4 rat5 rat6 rat7 rat8 rat9 rat10 rat11 rat12 rat13}
		}
		set rat1tavg=rat1tavg/(end-start+1)
		set rat2tavg=rat2tavg/(end-start+1)
		set rat3tavg=rat3tavg/(end-start+1)
		set rat4tavg=rat4tavg/(end-start+1)
		set rat5tavg=rat5tavg/(end-start+1)
		set rat6tavg=rat6tavg/(end-start+1)
		set rat7tavg=rat7tavg/(end-start+1)
		set rat8tavg=rat8tavg/(end-start+1)
		set rat9tavg=rat9tavg/(end-start+1)
		set rat10tavg=rat10tavg/(end-start+1)
		set rat11tavg=rat11tavg/(end-start+1)
		set rat12tavg=rat12tavg/(end-start+1)
		set rat13tavg=rat13tavg/(end-start+1)
		print + joncalc2tavg.txt {rat1tavg rat2tavg rat3tavg rat4tavg rat5tavg rat6tavg rat7tavg rat8tavg rat9tavg rat10tavg rat11tavg rat12tavg rat13tavg}
		# b^2/Mdot
		set bsqomdot=rat1tavg/rat3tavg
		# bflux^2/mdot
		set bfl2omdot=rat2tavg/rat3tavg
		# eem
		set eflempole=rat8tavg
		# eem
		set eflemtot=rat9tavg
		# eem/mdot
		set eflemomdotpole=rat8tavg/rat3tavg
		# eem/mdot
		set eflemomdottot=rat9tavg/rat3tavg
		# e
		set eflpole=rat6tavg
		# e
		set efltot=rat7tavg
		# e/mdot
		set eflomdotpole=rat6tavg/rat3tavg
		# e/mdot
		set eflomdottot=rat7tavg/rat3tavg
		# eem/b^2
		set eflempoleobsq=rat8tavg/rat1tavg
		# eem/b^2
		set eflemtotobsq=rat9tavg/rat1tavg
		# eem/e
		set fracetot=eflemtot/efltot
		# eem/e
		set fracepole=eflempole/eflpole
		# mdot
		set mflavg=rat3tavg
		print + joncalc2tavg.txt {_a mflavg bsqomdot bfl2omdot eflempole eflemtot eflemomdotpole eflemomdottot eflpole efltot eflomdotpole eflomdottot eflempoleobsq eflemtotobsq fracepole fracetot}
		#
joncalc1tavg 4    # joncalctavg r theta start end 
		# must load a dump file first fir nx
		set rat1tavg=0
		set rat2tavg=0
		set rat3tavg=0
		set rat4tavg=0
		set start=$3
		set end=$4
		print joncalctavg.txt {start end}
		do iii=start,end,1 {
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$iii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$iii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 joncalc1 $1 $2		 
		 set rat1tavg=rat1tavg+rat1
		 set rat2tavg=rat2tavg+rat2
		 set rat3tavg=rat3tavg+rat3
		 set rat4tavg=rat4tavg+rat4
		 print + joncalctavg.txt {_t rat1 rat2 rat3 rat4}
		}
		set rat1tavg=rat1tavg/(end-start+1)
		set rat2tavg=rat2tavg/(end-start+1)
		set rat3tavg=rat3tavg/(end-start+1)
		set rat4tavg=rat4tavg/(end-start+1)
		print + joncalctavg.txt {rat1tavg rat2tavg rat3tavg rat4tavg}
		#
rdjoncalctavg  0 #
		da joncalctavg.txt
		lines 4 10000000
		read '%g %g %g %g %g' {t rat1 rat2 rat3 rat4}
		#
		set use = ((t>=500) && (t<=1500) ) ? 1 : 0
		set rat1tavg=SUM(rat1*use)/SUM(use)
		set rat2tavg=SUM(rat2*use)/SUM(use)
		set rat3tavg=SUM(rat3*use)/SUM(use)
		set rat4tavg=SUM(rat4*use)/SUM(use)
		set rat2test=.06804*rat3tavg+.707107
		print {rat1tavg rat2tavg rat3tavg rat4tavg rat2test}
		#
rdjoncalc2tavg  0 #
		da myvsa.txt
		lines 1 10000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {a mflavg bsqomdot bfl2omdot eflempole eflemtot eflemomdotpole eflemomdottot eflpole efltot eflomdotpole eflomdottot eflempoleobsq eflemtotobsq fracepole fracetot}
		#read { a 1 dm 2 dbsqdm 3 dblsqdm 4 deflempole 5 deflemtot 6 deflemdmpole 7 deflemomdottot 8 defldmpole 9 deflem 10}
		# m=2.912      b=-1.473 #including a=0.5
		# but more like m=3 for a>0.5
		#print newvsa.txt {a dm dbsqdm dblsqdm deflempole deflemdmpole defldmpole deflem deflemdbsq}
		#
		#
		#
gojon3    7     #
		# if you change THIS macro, must copy manually, can't just copy and expect macro itself when already running to change.
		!scp metric.physics.uiuc.edu:sm/gtwod.m metric:sm/copyscriptjon3.sh ~/sm/
		#
		jre gtwod.m
		define DOGCALCS (1)
		jrdp dump0000
		gammienew
		rhouumincalc rhomin uumin nrho nuu
		diskhorcalc _Rin _Rout rin0 rmax0 diskhor		
		#
		echo $1
		echo $2
		# this is the dtheta around the disk, which we will for now not read from user, but set by H/R calculation
		#set par2=$2
		set par2=diskhor  # kinda ok
		set par1=$1   # not sure generally how could set
		# revert to user estimation if problems
		if(par2>1.56) { set par2=$2 set par1=$1 }
		# par1 is dtheta around pole
		#
		define myhostname {'$3'}
		define mydirname {'$4'}
		set start=$5
		set end=$6
		if ($7==0) { define myfilename "joncalc3tavg.txt" !rm joncalc3tavg.txt }
		if ($7!=0) { define myfilename "joncalc3tavg$7.txt" }
		#
		#
		echo starting $myhostname $mydirname $myfilename
		#
		# was 37
		set numvariables=47
		define print_noheader (1)
		#
		setdirname $mydirname
		sethostname $myhostname
		#
		set godrinner=$rhor
		set godrouter=(1.1*$rhor)
		print $myfilename {start end dirname a}
		#
		#
		# do other calculations (aphitavg)
		#getfline
		if($7==0) { set fieldstart=start+10 }
		if($7!=0) { set fieldstart=start }
		fieldcalcavg fieldstart end aphitavg # time average
		fieldcollcalc aphitavg newh collrat par1 colltavg
		print {start end hostname dirname a colltavg}
		#
		#
		joncalc3tavg numvariables godrinner godrouter par1 par2 start end $myfilename
		#
		# get ener.out avgerage values
		set tinner=50*start
		set touter=50*end
		jrdpener tinner touter
		#
		#
		#
		print + $myfilename '%s %s %d %d %g %g %g %g %g %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g '\
		    {hostname dirname \
		       start end \
		    godrinner godrouter par1 par2 a \
		       _n1 _n2 \
		    _gam _R0 _Rin _Rout _hslope rhomin uumin nrho nuu rin0 rmax0 diskhor colltavg }
		    #
		print + $myfilename '%g %g %g %g %g %g %g %g '\
		    {dmavg deavg dlavg demavg dlmavg effavg daavg dadmavg}
		    #
		# that's 24+8=32 columns so far
		#
		# now do final calculations and output (this is what's actually used, before time average just prints out each result)
		# this is numvaraibles more columns
		do iiii=0,numvariables-1,1 {
		 set temptemp=rattavg[$iiii]
		 print + $myfilename '%g ' {temptemp}
		}
		#
		# now add on extra calculations we want
		#
		set bsqpoi=rattavg[6]/rattavg[7]
		set bsqpoc=rattavg[6]/rattavg[8]
		set bsqhoe=rattavg[38]/rattavg[37]
		set bsqpoe=rattavg[6]/rattavg[37]
		set bsqpoh=rattavg[6]/rattavg[38]
		#
		set empomat=rattavg[0]/rattavg[3]
		set emtomat=rattavg[1]/rattavg[3]
		#
		set omegarat1=rattavg[4]/omegah
		set omegarat2=rattavg[5]/omegah
		set omegarat3=rattavg[11]/rattavg[10]/omegah # polar
		set omegarat4=rattavg[13]/rattavg[12]/omegah # total
		set omegarat5=rattavg[15]/rattavg[14]         # inflow (true value)
		set omegarat6=rattavg[26]/rattavg[25] # isco wf #is this equal to above?
		set omegarat7=omegarat5/omegarat6 # ala above
		set omegarat8=omegarat6/rattavg[24] # ala above# isco omega3 is this and above equal?
		#
		set mygirat=rattavg[17]/rattavg[19] # aefl/aefl2~1.0?
		# magparam in bl-coords in gammie form (2\pi already taken care of)
		# fm(ksp')/(h*pi)=fm(bl)
		# finally, we have F_{hp} for gam99 paper
		# the sqrt(4*pi) is due to differences in how define B in gammie99 and harm
		set magparam=sqrt(4*pi)*rattavg[14]/(hslope*pi)/sqrt(rattavg[16]/(hslope*pi))
		set einfrat=rattavg[22]/tdeinfisco # ~1?
		set linfrat=rattavg[23]/tdlinfisco # ~1?
		set fdd23rat=rattavg[14]/rattavg[25] # ~1?
		set fdd02rat=rattavg[15]/rattavg[26] # ~1?
		set mrat=rattavg[16]/rattavg[27] # ~1?
		set lrat=rattavg[17]/rattavg[28] # ~1?
		set erat=rattavg[18]/rattavg[29] # ~1?
		set uu1rat=rattavg[21]/rattavg[9] # <<1?
		# 5+2+8+10=25
		print + $myfilename '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g ' \
		    {bsqpoi bsqpoc bsqhoe bsqpoe bsqpoh \
		       empomat emtomat \
		       omegarat1 omegarat2 omegarat3 omegarat4 omegarat5 omegarat6 omegarat7 omegarat8 \
		       mygirat magparam einfrat linfrat fdd23rat fdd02rat mrat lrat erat uu1rat}
		print + $myfilename '\n' {}
		#		
		#  now copy file over
		#
		if($7==0){\
		 echo copyscript for $myhostname $mydirname
		 !sh ~/sm/copyscriptjon3.sh
		 echo done copyscript for $myhostname $mydirname
		}
		#
		echo all done $mydirname
		#
zoomgojon3      0
		#
		set godstart=20
		set godend=219
		do iii=godstart,godend,100 {\
		 set gostart=$iii
		 set goend=($iii+99)
		 gojon3 0.82 0.3 metric "/us5/jon/grmhd-a.9375-456by456-fl46-restart" gostart goend $iii
		}
		#
		#
		#
gojon3cp  7     #
		#
		!scp metric.physics.uiuc.edu:sm/gtwod.m metric:sm/copyscriptjon3.sh ~/sm/
		#
		echo $1
		echo $2
		set par1=$1
		set par2=$2
		define myhostname {'$3'}
		define mydirname {'$4'}
		set start=$5
		set end=$6
		# DON'T rm !
		if ($7==0) { define myfilename "joncalc3tavg.txt" }
		if ($7!=0) { define myfilename "joncalc3tavg$7.txt" }
		#
		#
		echo starting $myhostname $mydirname $myfilename
		#
		echo starting $myhostname $mydirname
		#
		setdirname $mydirname
		sethostname $myhostname
		#
		echo copyscript for $myhostname $mydirname
		!sh ~/sm/copyscriptjon3.sh
		echo done copyscript for $myhostname $mydirname
		#
		echo all done $mydirname
		#
dobzcalcs  5     # dobzcalcs numvariables rinner router poletheta disktheta
		bzeflux		
		set rinner=$2
		#
		# for inflow region average
		set irinner=$rhor*1.01
		set irouter=risco*0.99
		#
		if (irouter<irinner) { set irouter=irinner }
		set router=$3
		set routergi=0.9*risco
		set thlowergi=pi/2-0.05
		set thuppergi=pi/2+0.05
		set pdh=$4
		set ddh=$5
		set iddh=ddh
		# integrated em energy flux around pole
		joncalc3 1 1 rinner router pdh eflem eempole
		joncalc3 2 1 rinner router pi/2 eflem eemtot
		joncalc3 1 1 rinner router pdh eflma emapole
		joncalc3 2 1 rinner router pi/2 eflma ematot
		joncalc3 1 2 rinner router pdh omegaf2 wfpole
		set absomegaf2=abs(omegaf2)
		joncalc3 1 2 rinner router pdh absomegaf2 abswfpole
		joncalc3 1 2 rinner router pdh bsq bsqpole
		joncalc3 2 2 irinner irouter iddh bsq bsqinflow
		set rcorein=0.9*rmax0
		set rcoreout=1.1*rmax0
		joncalc3 2 2 rcorein rcoreout ddh bsq bsqcore
		set rinin=risco*0.9
		set rinout=risco*1.1
		joncalc3 2 2 (rinin) (rinout) ddh bsq bsqedge
		set rhin=$rhor*0.98
		set rhout=$rhor*1.02
		joncalc3 2 2 (rhin) (rhout) ddh bsq bsqhor
		#
		set auu1=ABS(uu1)
		set afdd23=ABS(fdd23)
		set afdd02=ABS(fdd02)
		set amfl=ABS(mfl)
		set aefl=ABS(efl)
		set alfl=ABS(lfl)
		set aefl2=ABS(efl2)
		#
		# a volume average is used since we want an estimate
		# for the quantity over a volume range.  That is, we don't want a surface value which would
		# be a pure average of the quantity.  Think of this as a point by point average of the individual
		# quantity, averaged to account for its density of value in space
		joncalc3 2 2 rinner router ddh auu1 auu1hor
		#
		joncalc3 1 2 rinner router pdh afdd23 afdd23pole
		joncalc3 1 2 rinner router pdh afdd02 afdd02pole		
		joncalc3 2 2 rinner router pi/2 afdd23 afdd23tot
		joncalc3 2 2 rinner router pi/2 afdd02 afdd02tot	
		#
		joncalc3 2 2 irinner irouter iddh afdd23 afdd23inflow
		joncalc3 2 2 irinner irouter iddh afdd02 afdd02inflow
		joncalc3 2 2 irinner irouter iddh amfl amflinflow
		joncalc3 2 2 irinner irouter iddh aefl aeflinflow
		joncalc3 2 2 irinner irouter iddh alfl alflinflow
		joncalc3 2 2 irinner irouter iddh aefl2 aefl2inflow
		#
		joncalc3 2 2 irinner irouter iddh girat giratinflow		
		#
		set iscoin=0.9*risco
		set iscoout=1.1*risco
		joncalc3 2 2 iscoin iscoout iddh auu1 auu1isco
		joncalc3 2 2 iscoin iscoout iddh einf einfisco
		joncalc3 2 2 iscoin iscoout iddh linf linfisco
		joncalc3 2 2 iscoin iscoout iddh omega3 omega3isco
		#
		joncalc3 2 2 iscoin iscoout iddh afdd23 afdd23isco
		joncalc3 2 2 iscoin iscoout iddh afdd02 afdd02isco
		joncalc3 2 2 iscoin iscoout iddh amfl amflisco
		joncalc3 2 2 iscoin iscoout iddh aefl aeflisco
		joncalc3 2 2 iscoin iscoout iddh alfl alflisco
		joncalc3 2 2 iscoin iscoout iddh aefl2 aefl2isco
		#
		joncalc3 2 2 iscoin iscoout iddh girat giratisco
		#		
		fastrcalc 1 (2*risco) iddh myfastrinflow
		#
		#
		joncalc3 2 3 $rhor $rhor pi/2 mfl mdothor
		set realefl=-(efl-mfl)
		joncalc3 2 3 $rhor $rhor pi/2 realefl edothor
		set effdothor=1-edothor/mdothor
		joncalc3 2 3 $rhor $rhor pi/2 lfl ldothor
		set demdothor=edothor/mdothor
		set dlmdothor=ldothor/mdothor
		set dafl=-lfl+2.0*a*realefl
		joncalc3 2 3 $rhor $rhor pi/2 dafl dadothor
		set dadmdothor=dadothor/mdothor
		#
		fastrcalc 2 risco pdh myfastrpole
		#
		fieldcalc 1 aphi
		fieldcollcalc aphi newh collrat pdh collpole
		#
		diskhorcalc _Rin _Rout rin ratrmax ratdiskhor		
		#
		#setup assignments for averaging
		set rat=0,$1-1,1
		set rat=rat*0
		#
		set rat[0]=eempole
		set rat[1]=eemtot
		set rat[2]=emapole
		set rat[3]=ematot
		set rat[4]=wfpole
		set rat[5]=abswfpole
		set rat[6]=bsqpole
		set rat[7]=bsqinflow
		set rat[8]=bsqcore
		set rat[9]=auu1hor
		set rat[10]=afdd23pole
		set rat[11]=afdd02pole
		set rat[12]=afdd23tot
		set rat[13]=afdd02tot
		set rat[14]=afdd23inflow
		set rat[15]=afdd02inflow
		# 2\pi's are because gam1999 has them
		# no transformations here
		set rat[16]=amflinflow*2*pi
		set rat[17]=aeflinflow*2*pi
		set rat[18]=alflinflow*2*pi
		set rat[19]=aefl2inflow*2*pi
		set rat[20]=giratinflow
		set rat[21]=auu1isco
		set rat[22]=einfisco
		set rat[23]=linfisco
		set rat[24]=omega3isco
		set rat[25]=afdd23isco
		set rat[26]=afdd02isco
		set rat[27]=amflisco*2*pi
		set rat[28]=aeflisco*2*pi
		set rat[29]=alflisco*2*pi
		set rat[30]=aefl2isco*2*pi
		set rat[31]=giratisco
		set rat[32]=myfastrinflow
		set rat[33]=myfastrpole
		set rat[34]=collpole
		set rat[35]=ratrmax
		set rat[36]=ratdiskhor
		set rat[37]=bsqedge
		set rat[38]=bsqhor
		set rat[39]=mdothor
		set rat[40]=edothor
		set rat[41]=ldothor
		set rat[42]=demdothor
		set rat[43]=dlmdothor
		set rat[44]=effdothor
		set rat[45]=dadothor
		set rat[46]=dadmdothor
		#
		#
joncalc3      7 # joncalc3 1 0 $rhor 2.1 1.0 eflem result
		# joncalc3 spatialtype inttype rinner router thetarange variable output
		# around poles in a thick shell
		set spatialtype=$1
		set inttype=$2
		# realize we have discrete grid, at least give 1 point, nearest one
		# find the i for a given radius
		define newii (0)
		while { $newii<$nx } {\
		       if(r[0*$nx+$newii]>=$3) { break }
		       define newii ($newii+1)
		    }
		    set iselinner=$newii
		    if(iselinner==$nx) { set iselinner=$nx-1 }
		define newii (0)
		while { $newii<$nx } {\
		       if(r[0*$nx+$newii]>=$4) { break }
		       define newii ($newii+1)
		    }
		    set iselouter=$newii
		    if(iselouter==$nx) { set iselouter=$nx-1 }
		set joncalc3rinner=r[iselinner]
		set joncalc3router=r[iselouter]
		#
		set shell = ((r>=joncalc3rinner)&&(r<=joncalc3router)) ? 1 : 0
		set numshells=SUM(shell)/$ny
		#
		set joncalc3dtheta=$5
		# spatialtype==1 means over polar referenced angle and radial range
		if(spatialtype==1){\
		 if(joncalc3dtheta<1.1*dh[0]){ set joncalc3dtheta=1.1*dh[0] }		        
 		 set use = ((abs(h-0.5*pi)>0.5*pi-joncalc3dtheta) && (r>=joncalc3rinner)&&(r<=joncalc3router) ) ? 1 : 0
		}
		# spatialtype==2 means over equatorial referenced angle and radial range
		if(spatialtype==2){\
		 if(joncalc3dtheta<1.1*dh[$ny*$nx/2]){ set joncalc3dtheta=1.1*dh[$ny*$nx/2] }		        
 		 set use = ((abs(h-0.5*pi)<joncalc3dtheta) && (r>=joncalc3rinner)&&(r<=joncalc3router) ) ? 1 : 0
		}
		set volume=SUM(gdet*dV*use)
		set totalarea=SUM(gdet*area*use)
		#
		# inttype=1 means treat variable as a flux (e.g. eflem) to integrate over a surface
		# this is averaged over numshells shells in radius
		if(inttype==1){\
		 set $7=SUM($6*gdet*area*use)/numshells
		}
		# inttype==2
		# this is a volume integral over the volume giving average quantity where variable is a quantity per unit volume like any energy density
		if(inttype==2){\
		 set $7=SUM($6*gdet*dV*use)/volume
		}
		# inttype==3 is when variable is already *gdet, so is already a conserved flux or something like gdet*quantity, then find total integrated value
		if(inttype==3){\
		 set $7=SUM($6*area*use)/numshells
		}
		# inttype==4 is when variable is a non-weighted average
		# note, this is normally not useful!
		if(inttype==4){\
		 set $7=SUM($6*use)/SUM(use)
		}
		# inttype==5
		# this is averaged over numshells shells in radius and is the average value of the flux on the surface, not integrated value
		if(inttype==5){\
		 set $7=SUM($6*gdet*area*use)/totalarea
		}
		# inttype==6
		# pure volume average
		if(inttype==6){\
		 set $7=SUM($6*dV*use)/volume
		}
		# inttype==7 is when variable is a non-weighted average
		# note, this is normally not useful!
		if(inttype==7){\
		 set $7=SUM($6*dV*use)/SUM(dV*use)
		}
		#
		set resulttemp=$7
		print {resulttemp}
		#
setdirname 1    # setdirname $mydirname
		set dirname=$1
		#
		#
sethostname 1    # sethostname $myhostname
		set hostname=$1
		#
		#
joncalc3tavg 8    # joncalc3tavg numberofterms rin rout dthetapole dthetadisk start end filename
		#  joncalc3tavg 31 $rhor (1.2*$rhor) .4 .05 10 40
		# see dobzcalcs
		# scp joncalc3tavg.txt metric:research/bz/joncalc3tavg-
		# must load a dump file first fir nx
		set rattavg=0,$1-1,1
		set rattavg=rattavg*0
		set start=$6
		set end=$7
		define localfilename $8
		#
		do iii=start,end,1 {\
		 set h1='dump'
		 if($GAMMIE==1) { set h2=sprintf('%03d',$iii) }
		 if($GAMMIE==0) { set h2=sprintf('%04d',$iii) }
		 set _fname=h1+h2
		 define filename (_fname)
		 if($GAMMIE==1) { grdp $filename }
		 if($GAMMIE==0) { jrdp $filename }
		 dobzcalcs $1 $2 $3 $4 $5
		 # set variables here based upon dobzcalcs
		 print + $localfilename '%g ' {_t}
		 do iiii=0,$1-1,1 {\
		  set rattavg[$iiii]=rattavg[$iiii]+rat[$iiii]
		  set temptemp=rat[$iiii]
	 	  print + $localfilename '%g ' {temptemp}
		 }
 		 print + $localfilename '\n' {}
		}
		do iiii=0,$1-1,1 {\
		 set rattavg[$iiii]=rattavg[$iiii]/(end-start+1)
		}
		#
equatorequalize 0       # in r-theta coordinates, make upper and lower equator averaged and same
		# not a quick calculation
		#
		do ii=0,$nx*$ny*$nz-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   set indexk=INT($ii/($nx*$ny))
		   define tempi (indexi)
		   define tempj (indexj)
		   define tempk (indexk)
		   #
		   set symii=($ny-1-indexj)*$nx+indexi
		   #
		   if(indexi==0) { echo $tempj }
		   if(indexj<=$ny/2) {\
		   set rho[$ii]=0.5*(rho[$ii]+rho[symii])
		   set bsq[$ii]=0.5*(bsq[$ii]+bsq[symii])
		   set aphi[$ii]=0.5*(aphi[$ii]+aphi[symii])
		   set omegaf2[$ii]=0.5*(omegaf2[$ii]+omegaf2[symii])
		   set u[$ii]=0.5*(u[$ii]+u[symii])
		   set v1[$ii]=0.5*(v1[$ii]+v1[symii])
		   set v2[$ii]=0.5*(v2[$ii]-v2[symii])
		   set v3[$ii]=0.5*(v3[$ii]+v3[symii])
		   set B1[$ii]=0.5*(B1[$ii]+B1[symii])
		   set B2[$ii]=0.5*(B2[$ii]-B2[symii])
		   # sign depends on model
		   set B3[$ii]=0.5*(B3[$ii]-B3[symii])
		   set divb[$ii]=0.5*(divb[$ii]+divb[symii])
		   #
		   set uu0[$ii]=0.5*(uu0[$ii]+uu0[symii])
		   set uu1[$ii]=0.5*(uu1[$ii]+uu1[symii])
		   set uu2[$ii]=0.5*(uu2[$ii]-uu2[symii])
		   set uu3[$ii]=0.5*(uu3[$ii]+uu3[symii])
		   set ud0[$ii]=0.5*(ud0[$ii]+ud0[symii])
		   set ud1[$ii]=0.5*(ud1[$ii]+ud1[symii])
		   set ud2[$ii]=0.5*(ud2[$ii]-ud2[symii])
		   set ud3[$ii]=0.5*(ud3[$ii]+ud3[symii])
		   #
		   set bu0[$ii]=0.5*(bu0[$ii]+bu0[symii])
		   set bu1[$ii]=0.5*(bu1[$ii]+bu1[symii])
		   set bu2[$ii]=0.5*(bu2[$ii]-bu2[symii])
		   set bu3[$ii]=0.5*(bu3[$ii]+bu3[symii])
		   set bd0[$ii]=0.5*(bd0[$ii]+bd0[symii])
		   set bd1[$ii]=0.5*(bd1[$ii]+bd1[symii])
		   set bd2[$ii]=0.5*(bd2[$ii]-bd2[symii])
		   set bd3[$ii]=0.5*(bd3[$ii]+bd3[symii])
		   #
		   set v1m[$ii]=0.5*(v1m[$ii]+v1m[symii])
		   set v1p[$ii]=0.5*(v1p[$ii]+v1p[symii])
		   set v2m[$ii]=0.5*(v2m[$ii]+v2m[symii])
		   set v2p[$ii]=0.5*(v2p[$ii]+v2p[symii])
		   #
		}
		   if(indexj>$ny/2) {\
		   set rho[$ii]=rho[symii]
		   set bsq[$ii]=bsq[symii]
		   set aphi[$ii]=aphi[symii]
		   set omegaf2[$ii]=omegaf2[symii]
		   set u[$ii]=u[symii]
		   set v1[$ii]=v1[symii]
		   set v2[$ii]=v2[symii]
		   set v3[$ii]=v3[symii]
		   set B1[$ii]=B1[symii]
		   set B2[$ii]=B2[symii]
		   set B3[$ii]=B3[symii]
		   set divb[$ii]=divb[symii]
		   #
		   set uu0[$ii]=uu0[symii]
		   set uu1[$ii]=uu1[symii]
		   set uu2[$ii]=uu2[symii]
		   set uu3[$ii]=uu3[symii]
		   set ud0[$ii]=ud0[symii]
		   set ud1[$ii]=ud1[symii]
		   set ud2[$ii]=ud2[symii]
		   set ud3[$ii]=ud3[symii]
		   #
		   set bu0[$ii]=bu0[symii]
		   set bu1[$ii]=bu1[symii]
		   set bu2[$ii]=bu2[symii]
		   set bu3[$ii]=bu3[symii]
		   set bd0[$ii]=bd0[symii]
		   set bd1[$ii]=bd1[symii]
		   set bd2[$ii]=bd2[symii]
		   set bd3[$ii]=bd3[symii]
		   #
		   set v1m[$ii]=v1m[symii]
		   set v1p[$ii]=v1p[symii]
		   set v2m[$ii]=v2m[symii]
		   set v2p[$ii]=v2p[symii]
		   #
		}
		
		}
		#
avgtimeg   3	# avgtimeg (e.g. avgtimeg 'dump' start end)
		#
                set h1=$1
		set h3='.dat'
		#
		set rtime=1,$nx*$ny*$nz,1
		set entime=1,$nx*$ny*$nz,1
                set cs2time=1,$nx*$ny*$nz,1
		set b2time=1,$nx*$ny*$nz,1
                set vtimex=1,$nx*$ny*$nz,1
                set vtimey=1,$nx*$ny*$nz,1
                set vtimez=1,$nx*$ny*$nz,1
		set btimex=1,$nx*$ny*$nz,1
		set btimey=1,$nx*$ny*$nz,1
		set btimez=1,$nx*$ny*$nz,1
		set Fltime=1,$nx*$ny*$nz,1
		set Flrtime=1,$nx*$ny*$nz,1
		set Flmtime=1,$nx*$ny*$nz,1
		set Mftimex=1,$nx*$ny*$nz,1
		set Mftimey=1,$nx*$ny*$nz,1
		set Lftimex=1,$nx*$ny*$nz,1
		set Lftimey=1,$nx*$ny*$nz,1
		set Fvzdxtime=1,$nx*$ny*$nz,1
		set Fvzdytime=1,$nx*$ny*$nz,1            
		set Fmdxtime=1,$nx*$ny*$nz,1
		set Fmdytime=1,$nx*$ny*$nz,1		
                #
                set rtime=rtime*0
                set entime=entime*0
                set cs2time=cs2time*0
                set b2time=b2time*0
                set vtimex=vtimex*0
                set vtimey=vtimey*0
                set vtimez=vtimez*0
		set Fltime=Fltime*0
		set Flrtime=Flrtime*0
		set Flmtime=Flmtime*0
		set Mftimex=Mftimex*0
		set Mftimey=Mftimey*0
		set Lftimex=Lftimex*0
		set Lftimey=Lftimey*0
		set btimex=btimex*0
		set btimey=btimey*0
		set btimez=btimez*0
		set Fvzdxtime=Fvzdxtime*0
		set Fvzdytime=Fvzdytime*0
		set Fmdxtime=Fmdxtime*0
		set Fmdytime=Fmdytime*0		
                #
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%03d',$ii)
                  set _fname=h1+h2+h3
                  define filename (_fname)
		  rdp $filename
		  set rtime=rtime+rho
                  set entime=entime+u
                  set cs2time=cs2time+cs*cs
		  set b2time=b2time+br*br+bh*bh+bp*bp
                  set vtimex=vtimex+ur
                  set vtimey=vtimey+uh
                  set vtimez=vtimez+up
		  set btimex=btimex+br
		  set btimey=btimey+bh
		  set btimez=btimez+bp
		  set Fmdx=rho*ur
		  set Fmdy=rho*uh
		  set Fmdz=rho*up
		  set Fmx=Fmdx*x12*x12*sin(x22)
		  set Fmy=Fmdy*x12*sin(x22)
		  set Fmz=Fmdz*x12
		  set Fvzdx=x12*sin(x22)*(rho*ur*up)
		  set Fvzdy=x12*sin(x22)*(rho*uh*up)
		  set Fvzdz=x12*sin(x22)*(rho*up*up)
		  set Fvzx=Fvzdx*x12*x12*sin(x22)
		  set Fvzy=Fvzdy*x12*sin(x22)
		  set Fvzz=Fvzdz*x12
		  set Mftimex=Mftimex+Fmx
		  set Mftimey=Mftimey+Fmy
		  set Lftimex=Lftimex+Fvzx
		  set Lftimey=Lftimey+Fvzy
		  set Flrtime=Flrtime+(r*ur*up)
		  set Fltime=Fltime+(r*ur*up-bp*br)
		  set Flmtime=Flmtime+(-bp*br)
		  set Fvzdxtime=Fvzdxtime+Fvzdx
		  set Fvzdytime=Fvzdytime+Fvzdy
		  set Fmdxtime=Fmdxtime+Fmdx
		  set Fmdytime=Fmdytime+Fmdy
		}
                set rtime=rtime/numtotal
                set entime=entime/numtotal
                set cs2time=cs2time/numtotal
		set b2time=b2time/numtotal
                set vtimex=vtimex/numtotal
                set vtimey=vtimey/numtotal
                set vtimez=vtimez/numtotal
		set btimex=btimex/numtotal
		set btimey=btimey/numtotal
		set btimez=btimez/numtotal
		set Fltime=Fltime/numtotal
		set Flrtime=Flrtime/numtotal
		set Flmtime=Flmtime/numtotal
		set Mftimex=Mftimex/numtotal
		set Mftimey=Mftimey/numtotal
		set Lftimex=Lftimex/numtotal
		set Lftimey=Lftimey/numtotal
		set Fvzdxtime=Fvzdxtime/numtotal
		set Fvzdytime=Fvzdytime/numtotal
		set Fmdxtime=Fmdxtime/numtotal
		set Fmdytime=Fmdytime/numtotal
                #
avgtimelaf   3	# avgtimeg (e.g. avgtimelaf 'dump' start end)
		#
                set h1=$1
		#
		set laftime=1,$nx*$ny*$nz,1
                #
		set laftime=laftime*0
		set lafatime=laftime*0
		set lafbtime=laftime*0
                #
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdpcf $filename
		  set laftime=laftime+laf
		  set lafatime=lafatime+lafa
		  set lafbtime=lafbtime+lafb
		}
                set laftime=laftime/numtotal
                set lafatime=lafatime/numtotal
                set lafbtime=lafbtime/numtotal
                #
avgtimeg2   3	# avgtimeg2 (e.g. avgtimeg2 'dump' start end)
		#
                set h1=$1
		#
		set btimex=1,$nx*$ny*$nz,1
		set btimey=1,$nx*$ny*$nz,1
		set btimez=1,$nx*$ny*$nz,1
                #
		set btimex=btimex*0
		set btimey=btimey*0
		set btimez=btimez*0
                #
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  set btimex=btimex+B1
		  set btimey=btimey+B2
		  set btimez=btimez+B3
		}
		set btimex=btimex/numtotal
		set btimey=btimey/numtotal
		set btimez=btimez/numtotal
                #
avgtimegfull   3	# avgtimegfull (e.g. avgtimeg 'dump' start end)
		#
                set h1=$1
		define DOGCALC (1)
		#
		set rhotavg=1,$nx*$ny*$nz,1
		set rhotavg=rhotavg*0
		set utavg=rhotavg*0
                set v1tavg=rhotavg*0
                set v2tavg=rhotavg*0
                set v3tavg=rhotavg*0
		set B1tavg=rhotavg*0
		set B2tavg=rhotavg*0
		set B3tavg=rhotavg*0
		set divbtavg=rhotavg*0
		set uu0tavg=rhotavg*0
		set uu1tavg=rhotavg*0
		set uu2tavg=rhotavg*0
		set uu3tavg=rhotavg*0
		set ud0tavg=rhotavg*0
		set ud1tavg=rhotavg*0
		set ud2tavg=rhotavg*0
		set ud3tavg=rhotavg*0
		set bu0tavg=rhotavg*0
		set bu1tavg=rhotavg*0
		set bu2tavg=rhotavg*0
		set bu3tavg=rhotavg*0
		set bd0tavg=rhotavg*0
		set bd1tavg=rhotavg*0
		set bd2tavg=rhotavg*0
		set bd3tavg=rhotavg*0
		set v1mtavg=rhotavg*0
		set v1ptavg=rhotavg*0
		set v2mtavg=rhotavg*0
		set v2ptavg=rhotavg*0
		#
		set bsqtavg=rhotavg*0
		set aphitavg=rhotavg*0
		set omega3tavg=rhotavg*0
		set Ktavg=rhotavg*0
		set val2tavg=rhotavg*0
		set cs2tavg=rhotavg*0
		set cms2tavg=rhotavg*0
		#
		set sonicv1ptavg=rhotavg*0
		set alfvenv1ptavg=rhotavg*0
		set fastv1ptavg=rhotavg*0
		set sonicv1mtavg=rhotavg*0
		set alfvenv1mtavg=rhotavg*0
		set fastv1mtavg=rhotavg*0
		#
		set tslowv1ptavg=rhotavg*0
		set tfastv1ptavg=rhotavg*0
		set tslowv1mtavg=rhotavg*0
		set tfastv1mtavg=rhotavg*0
		#
		set alphamagtavg=rhotavg*0
		set alphamag2tavg=rhotavg*0
		#
		set uu1tavg=rhotavg*0
		set auu1tavg=rhotavg*0
		set ud3tavg=rhotavg*0
		set aud3tavg=rhotavg*0
		set magenthalpytavg=rhotavg*0
		set ldotadvtavg=rhotavg*0
		set aldotadvtavg=rhotavg*0
		#
		set hor1tavg=rhotavg*0
		set ldotextmatavg=rhotavg*0
		set ldotextemtavg=rhotavg*0
		#
		set mdottavg=rhotavg*0
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp2d $filename
		  define nz (1)
		  #
 		set rhotavg=rhotavg+rho
		set utavg=utavg+u
                set v1tavg=v1tavg+v1
                set v2tavg=v2tavg+v2
                set v3tavg=v3tavg+v3
		set B1tavg=B1tavg+B1
		set B2tavg=B2tavg+B2
		set B3tavg=B3tavg+B3
		set divbtavg=divbtavg+divb
		set uu0tavg=uu0tavg+uu0
		set uu1tavg=uu1tavg+uu1
		set uu2tavg=uu2tavg+uu2
		set uu3tavg=uu3tavg+uu3
		set ud0tavg=ud0tavg+ud0
		set ud1tavg=ud1tavg+ud1
		set ud2tavg=ud2tavg+ud2
		set ud3tavg=ud3tavg+ud3
		set bu0tavg=bu0tavg+bu0
		set bu1tavg=bu1tavg+bu1
		set bu2tavg=bu2tavg+bu2
		set bu3tavg=bu3tavg+bu3
		set bd0tavg=bd0tavg+bd0
		set bd1tavg=bd1tavg+bd1
		set bd2tavg=bd2tavg+bd2
		set bd3tavg=bd3tavg+bd3
		set v1mtavg=v1mtavg+v1m
		set v1ptavg=v1ptavg+v1p
		set v2mtavg=v2mtavg+v2m
		set v2ptavg=v2ptavg+v2p
		#
		set bsqtavg=bsqtavg+bsq
		fieldcalc aphitemp aphi
		set aphitavg=aphitavg+aphi
		set omega3tavg=omega3tavg+omega3
		set Ktavg=Ktavg+K
		set val2tavg=val2tavg+val2
		set cs2tavg=cs2tavg+cs2
		set cms2tavg=cms2tavg+cms2
		#
		set sonicv1ptavg=sonicv1ptavg+sonicv1p
		set alfvenv1ptavg=alfvenv1ptavg+alfvenv1p
		set fastv1ptavg=fastv1ptavg+fastv1p
		#
		set sonicv1mtavg=sonicv1mtavg+sonicv1m
		set alfvenv1mtavg=alfvenv1mtavg+alfvenv1m
		set fastv1mtavg=fastv1mtavg+fastv1m
		#
		trueslowfast
		#
		set tslowv1ptavg=tslowv1ptavg+tslowv1p
		set tfastv1ptavg=tfastv1ptavg+tfastv1p
		#
		set tslowv1mtavg=tslowv1mtavg+tslowv1m
		set tfastv1mtavg=tfastv1mtavg+tfastv1m
		#
		#
		set alphamag=-bu1*bd3/(bsq/2)
		set alphamagtavg=alphamagtavg+alphamag
		set alphamag2=-bu1*bd3/ptot
		set alphamag2tavg=alphamag2tavg+alphamag2
		#
		set uu1tavg=uu1tavg+uu1
		set auu1tavg=auu1tavg+abs(uu1)
		set ud3tavg=ud3tavg+ud3
		set aud3tavg=aud3tavg+abs(ud3)
		set magenthalpytavg=magenthalpytavg+(rho+u+p+bsq)
		set ldotadvtavg=ldotadvtavg+(rho*uu1*ud3)
		set aldotadvtavg=aldotadvtavg+(rho*abs(uu1)*abs(ud3))
		#
		# set other things
		#
		set hor1tavg=hor1tavg+(sqrt(cs2)/(r*omega3))
		# other one from cs2tavg and omega3tavg   hor2tavg=sqrt(cs2tavg)/(sqrt(gv333)*omega3tavg)
		#
		# can also get below from separate stress average routiney
		stresscalc 1
		set ldotextmatavg=ldotextmatavg+Tud13MA
		set ldotextemtavg=ldotextemtavg+Tud13EM
		#
		set mdottavg=mdottavg+rho*uu1
		#
		}
		set rhotavg=rhotavg/numtotal
		set utavg=utavg/numtotal
                set v1tavg=v1tavg/numtotal
                set v2tavg=v2tavg/numtotal
                set v3tavg=v3tavg/numtotal
		set B1tavg=B1tavg/numtotal
		set B2tavg=B2tavg/numtotal
		set B3tavg=B3tavg/numtotal
		set divbtavg=divbtavg/numtotal
		set uu0tavg=uu0tavg/numtotal
		set uu1tavg=uu1tavg/numtotal
		set uu2tavg=uu2tavg/numtotal
		set uu3tavg=uu3tavg/numtotal
		set ud0tavg=ud0tavg/numtotal
		set ud1tavg=ud1tavg/numtotal
		set ud2tavg=ud2tavg/numtotal
		set ud3tavg=ud3tavg/numtotal
		set bu0tavg=bu0tavg/numtotal
		set bu1tavg=bu1tavg/numtotal
		set bu2tavg=bu2tavg/numtotal
		set bu3tavg=bu3tavg/numtotal
		set bd0tavg=bd0tavg/numtotal
		set bd1tavg=bd1tavg/numtotal
		set bd2tavg=bd2tavg/numtotal
		set bd3tavg=bd3tavg/numtotal
		set v1mtavg=v1mtavg/numtotal
		set v1ptavg=v1ptavg/numtotal
		set v2mtavg=v2mtavg/numtotal
		set v2ptavg=v2ptavg/numtotal
		#
		set bsqtavg=bsqtavg/numtotal
		set aphitavg=aphitavg/numtotal
		set omega3tavg=omega3tavg/numtotal
		set Ktavg=Ktavg/numtotal
		set val2tavg=val2tavg/numtotal
		set cs2tavg=cs2tavg/numtotal
		set cms2tavg=cms2tavg/numtotal
		#
		set sonicv1ptavg=sonicv1ptavg/numtotal
		set alfvenv1ptavg=alfvenv1ptavg/numtotal
		set fastv1ptavg=fastv1ptavg/numtotal
		#
		set sonicv1mtavg=sonicv1mtavg/numtotal
		set alfvenv1mtavg=alfvenv1mtavg/numtotal
		set fastv1mtavg=fastv1mtavg/numtotal
		#
		set tslowv1ptavg=tslowv1ptavg/numtotal
		set tfastv1ptavg=tfastv1ptavg/numtotal
		#
		set tslowv1mtavg=tslowv1mtavg/numtotal
		set tfastv1mtavg=tfastv1mtavg/numtotal
		#
		set alphamagtavg=alphamagtavg/numtotal
		set alphamag2tavg=alphamag2tavg/numtotal
		#
		set uu1tavg=uu1tavg/numtotal
		set auu1tavg=auu1tavg/numtotal
		set ud3tavg=ud3tavg/numtotal
		set aud3tavg=aud3tavg/numtotal
		set magenthalpytavg=magenthalpytavg/numtotal
		set ldotadvtavg=ldotadvtavg/numtotal
		set aldotadvtavg=aldotadvtavg/numtotal
		set hor1tavg=hor1tavg/numtotal
		set ldotextmatavg=ldotextmatavg/numtotal
		set ldotextemtavg=ldotextemtavg/numtotal
		#
		set mdottavg=mdottavg/numtotal
		#
		define DOGCALC (1)
		gfull2normal		
		#
gfull2normal    0
 		set rho=rhotavg
		set u=utavg
                set v1=v1tavg
                set v2=v2tavg
                set v3=v3tavg
		set B1=B1tavg
		set B2=B2tavg
		set B3=B3tavg
		set divb=divbtavg
		set uu0=uu0tavg
		set uu1=uu1tavg
		set uu2=uu2tavg
		set uu3=uu3tavg
		set ud0=ud0tavg
		set ud1=ud1tavg
		set ud2=ud2tavg
		set ud3=ud3tavg
		set bu0=bu0tavg
		set bu1=bu1tavg
		set bu2=bu2tavg
		set bu3=bu3tavg
		set bd0=bd0tavg
		set bd1=bd1tavg
		set bd2=bd2tavg
		set bd3=bd3tavg
		set v1m=v1mtavg
		set v1p=v1ptavg
		set v2m=v2mtavg
		set v2p=v2ptavg
		#
		set bsq=bsqtavg
		set aphi=aphitavg
		set omega3=omega3tavg
		set K=Ktavg
		set val2=val2tavg
		set cs2=cs2tavg
		set cms2=cms2tavg
		#
		set sonicv1p=sonicv1ptavg
		set alfvenv1p=alfvenv1ptavg
		set fastv1p=fastv1ptavg
		#
		set sonicv1m=sonicv1mtavg
		set alfvenv1m=alfvenv1mtavg
		set fastv1m=fastv1mtavg
		#
		set tslowv1p=tslowv1ptavg
		set tfastv1p=tfastv1ptavg
		#
		set tslowv1m=tslowv1mtavg
		set tfastv1m=tfastv1mtavg
		#
		set alphamag=alphamagtavg
		set alphamag2=alphamag2tavg
		#
		set uu1=uu1tavg
		set auu1=auu1tavg
		set ud3=ud3tavg
		set aud3=aud3tavg
		set magenthalpy=magenthalpytavg
		set ldotadv=ldotadvtavg
		set aldotadv=aldotadvtavg
		set hor1=hor1tavg
		set ldotextma=ldotextmatavg
		set ldotextem=ldotextemtavg
		#
		#
greaddumpfull 1 # 2D only right now
		jrdp2d $1
		da ./dumps/$1
		lines 2 10000000
		read {bsqtavg 37 aphitavg 38 omega3tavg 39 Ktavg 40 val2tavg 41 cs2tavg 42 cms2tavg 43 sonicv1ptavg 44 sonicv1mtavg 45 alfvenv1ptavg 46 alfvenv1mtavg 47 fastv1ptavg 48 fastv1mtavg 49 tslowv1ptavg 50 tfastv1ptavg 51 tslowv1mtavg 52 tfastv1mtavg 53 }
		#
		set bsq=bsqtavg
		set aphi=aphitavg
		set omega3=omega3tavg
		set K=Ktavg
		set val2=val2tavg
		set cs2=cs2tavg
		set cms2=cms2tavg
		#
		set sonicv1p=sonicv1ptavg
		set alfvenv1p=alfvenv1ptavg
		set fastv1p=fastv1ptavg
		#
		set sonicv1m=sonicv1mtavg
		set alfvenv1m=alfvenv1mtavg
		set fastv1m=fastv1mtavg
		#
		set tslowv1p=tslowv1ptavg
		set tfastv1p=tfastv1ptavg
		#
		set tslowv1m=tslowv1mtavg
		set tfastv1m=tfastv1mtavg
		#
		gcalcother
		#
greaddumpfull2 1 # 2D only right now (new version with alpha)
		jrdp2d $1
		da ./dumps/$1
		lines 2 10000000
		read {bsqtavg 37 aphitavg 38 omega3tavg 39 Ktavg 40 val2tavg 41 cs2tavg 42 cms2tavg 43 sonicv1ptavg 44 sonicv1mtavg 45 alfvenv1ptavg 46 alfvenv1mtavg 47 fastv1ptavg 48 fastv1mtavg 49 tslowv1ptavg 50 tfastv1ptavg 51 tslowv1mtavg 52 tfastv1mtavg 53 alphamagtavg 54 alphamag2tavg 55 uu1tavg 56 auu1tavg 57 ud3tavg 58 aud3tavg 59 magenthalpytavg 60 ldotadvtavg 61 aldotadvtavg 62 hor1tavg 63 ldotextmatavg 64 ldotextemtavg 65}
		#
		set bsq=bsqtavg
		set aphi=aphitavg
		set omega3=omega3tavg
		set K=Ktavg
		set val2=val2tavg
		set cs2=cs2tavg
		set cms2=cms2tavg
		#
		set sonicv1p=sonicv1ptavg
		set alfvenv1p=alfvenv1ptavg
		set fastv1p=fastv1ptavg
		#
		set sonicv1m=sonicv1mtavg
		set alfvenv1m=alfvenv1mtavg
		set fastv1m=fastv1mtavg
		#
		set tslowv1p=tslowv1ptavg
		set tfastv1p=tfastv1ptavg
		#
		set tslowv1m=tslowv1mtavg
		set tfastv1m=tfastv1mtavg
		#
		set alphamag=alphamagtavg
		set alphamag2=alphamag2tavg
		#	
		set uu1=uu1tavg
		set auu1=auu1tavg
		set ud3=ud3tavg
		set aud3=aud3tavg
		set magenthalpy=magenthalpytavg
		set ldotadv=ldotadvtavg
		set aldotadv=aldotadvtavg
		set hor1=hor1tavg
		set ldotextma=ldotextmatavg
		set ldotextem=ldotextemtavg
		#
		gcalcother
		#
greaddumpfull3 1 # 2D only right now (new version with alpha)
		jrdp2d $1
		da ./dumps/$1
		lines 2 10000000
		read {bsqtavg 37 aphitavg 38 omega3tavg 39 Ktavg 40 val2tavg 41 cs2tavg 42 cms2tavg 43 sonicv1ptavg 44 sonicv1mtavg 45 alfvenv1ptavg 46 alfvenv1mtavg 47 fastv1ptavg 48 fastv1mtavg 49 tslowv1ptavg 50 tfastv1ptavg 51 tslowv1mtavg 52 tfastv1mtavg 53 alphamagtavg 54 alphamag2tavg 55 uu1tavg 56 auu1tavg 57 ud3tavg 58 aud3tavg 59 magenthalpytavg 60 ldotadvtavg 61 aldotadvtavg 62 hor1tavg 63 ldotextmatavg 64 ldotextemtavg 65 mdottavg 66}
		#
		set bsq=bsqtavg
		set aphi=aphitavg
		set omega3=omega3tavg
		set K=Ktavg
		set val2=val2tavg
		set cs2=cs2tavg
		set cms2=cms2tavg
		#
		set sonicv1p=sonicv1ptavg
		set alfvenv1p=alfvenv1ptavg
		set fastv1p=fastv1ptavg
		#
		set sonicv1m=sonicv1mtavg
		set alfvenv1m=alfvenv1mtavg
		set fastv1m=fastv1mtavg
		#
		set tslowv1p=tslowv1ptavg
		set tfastv1p=tfastv1ptavg
		#
		set tslowv1m=tslowv1mtavg
		set tfastv1m=tfastv1mtavg
		#
		set alphamag=alphamagtavg
		set alphamag2=alphamag2tavg
		#	
		set uu1=uu1tavg
		set auu1=auu1tavg
		set ud3=ud3tavg
		set aud3=aud3tavg
		set magenthalpy=magenthalpytavg
		set ldotadv=ldotadvtavg
		set aldotadv=aldotadvtavg
		set hor1=hor1tavg
		set ldotextma=ldotextmatavg
		set ldotextem=ldotextemtavg
		#
		set mdot=mdottavg
		#
		gcalcother
		#
gwritedumpfull  1 # writedump name
		#
		# for use with avgtimegfull
		#
		define print_noheader (1)
		# 16 header words
		print "./dumps/$!!1" '%21.15g %d %d %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    #
		    # 11+4+ 4*4+ 4 + 1 + 17 + 2 +1 = 56
		print + "./dumps/$!!1" '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g  %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g\n' \
		    {ti tj x1 x2 r h rho u v1 v2 v3 \
                      B1 B2 B3 divb \
                      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
                      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                     v1m v1p v2m v2p gdet \
		        bsqtavg aphitavg  omega3tavg  Ktavg  val2tavg \
		        cs2tavg  cms2tavg  sonicv1ptavg  sonicv1mtavg  \
		        alfvenv1ptavg alfvenv1mtavg  fastv1ptavg  fastv1mtavg  \
		        tslowv1ptavg  tfastv1ptavg  tslowv1mtavg  tfastv1mtavg alphamagtavg alphamag2tavg \
		        uu1tavg auu1tavg ud3tavg aud3tavg magenthalpytavg ldotadvtavg aldotadvtavg hor1tavg ldotextmatavg ldotextemtavg mdottavg }
		        #
		define print_noheader (1)
		#
avgtimegfull2   3	# avgtimegfull2 (e.g. avgtimeg 'dump' start end)
		# with currents and field extra stuff
		#
                set h1=$1
		define DOGCALC (1)
		#
		set rhotavg=1,$nx*$ny*$nz,1
		set rhotavg=rhotavg*0
		set utavg=rhotavg*0
                set v1tavg=rhotavg*0
                set v2tavg=rhotavg*0
                set v3tavg=rhotavg*0
		set B1tavg=rhotavg*0
		set B2tavg=rhotavg*0
		set B3tavg=rhotavg*0
		set divbtavg=rhotavg*0
		set uu0tavg=rhotavg*0
		set uu1tavg=rhotavg*0
		set uu2tavg=rhotavg*0
		set uu3tavg=rhotavg*0
		set ud0tavg=rhotavg*0
		set ud1tavg=rhotavg*0
		set ud2tavg=rhotavg*0
		set ud3tavg=rhotavg*0
		set bu0tavg=rhotavg*0
		set bu1tavg=rhotavg*0
		set bu2tavg=rhotavg*0
		set bu3tavg=rhotavg*0
		set bd0tavg=rhotavg*0
		set bd1tavg=rhotavg*0
		set bd2tavg=rhotavg*0
		set bd3tavg=rhotavg*0
		set ju0tavg=rhotavg*0
		set ju1tavg=rhotavg*0
		set ju2tavg=rhotavg*0
		set ju3tavg=rhotavg*0
		set jd0tavg=rhotavg*0
		set jd1tavg=rhotavg*0
		set jd2tavg=rhotavg*0
		set jd3tavg=rhotavg*0
		set v1mtavg=rhotavg*0
		set v1ptavg=rhotavg*0
		set v2mtavg=rhotavg*0
		set v2ptavg=rhotavg*0
		#
		set rhoqtavg=rhotavg*0
		set zetatavg=rhotavg*0
		set jsqtavg=rhotavg*0
		set fsqtavg=rhotavg*0
		set absB1tavg=rhotavg*0
		set absB2tavg=rhotavg*0
		set absB3tavg=rhotavg*0
		#
		set bsqtavg=rhotavg*0
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdpcf2d $filename
		  # could use read-in faraday
		  faraday
		  jsq
		  set absB1=ABS(B1)
		  set absB2=ABS(B2)
		  set absB3=ABS(B3)
		  #
		  #set absb1=ABS(bsq*uu0)
		  #set absb2=ABS(bsq*uu0*ud0)
		  #set absb3=ABS(bsq*ud0*ud0-bd0*bd0)
		  #
		  fieldcalc 0 aphi
		  #
 		set rhotavg=rhotavg+rho
		set utavg=utavg+u
                set v1tavg=v1tavg+v1
                set v2tavg=v2tavg+v2
                set v3tavg=v3tavg+v3
		set B1tavg=B1tavg+B1
		set B2tavg=B2tavg+B2
		set B3tavg=B3tavg+B3
		set divbtavg=divbtavg+divb
		set uu0tavg=uu0tavg+uu0
		set uu1tavg=uu1tavg+uu1
		set uu2tavg=uu2tavg+uu2
		set uu3tavg=uu3tavg+uu3
		set ud0tavg=ud0tavg+ud0
		set ud1tavg=ud1tavg+ud1
		set ud2tavg=ud2tavg+ud2
		set ud3tavg=ud3tavg+ud3
		set bu0tavg=bu0tavg+bu0
		set bu1tavg=bu1tavg+bu1
		set bu2tavg=bu2tavg+bu2
		set bu3tavg=bu3tavg+bu3
		set bd0tavg=bd0tavg+bd0
		set bd1tavg=bd1tavg+bd1
		set bd2tavg=bd2tavg+bd2
		set bd3tavg=bd3tavg+bd3
		set ju0tavg=ju0tavg+ju0
		set ju1tavg=ju1tavg+ju1
		set ju2tavg=ju2tavg+ju2
		set ju3tavg=ju3tavg+ju3
		set jd0tavg=jd0tavg+jd0
		set jd1tavg=jd1tavg+jd1
		set jd2tavg=jd2tavg+jd2
		set jd3tavg=jd3tavg+jd3
		set v1mtavg=v1mtavg+v1m
		set v1ptavg=v1ptavg+v1p
		set v2mtavg=v2mtavg+v2m
		set v2ptavg=v2ptavg+v2p
		#
		set rhoqtavg=rhoqtavg+rhoq
		set zetatavg=zetatavg+zeta
		set jsqtavg=jsqtavg+jsq
		set fsqtavg=fsqtavg+fsq
		#
		set absB1tavg=absB1tavg+absB1
		set absB2tavg=absB2tavg+absB2
		set absB3tavg=absB3tavg+absB3
		#
		set bsqtavg=bsqtavg+bsq
		#
		set aphitavg=aphitavg+aphi
		#
		#		
		}
		set rhotavg=rhotavg/numtotal
		set utavg=utavg/numtotal
                set v1tavg=v1tavg/numtotal
                set v2tavg=v2tavg/numtotal
                set v3tavg=v3tavg/numtotal
		set B1tavg=B1tavg/numtotal
		set B2tavg=B2tavg/numtotal
		set B3tavg=B3tavg/numtotal
		set divbtavg=divbtavg/numtotal
		set uu0tavg=uu0tavg/numtotal
		set uu1tavg=uu1tavg/numtotal
		set uu2tavg=uu2tavg/numtotal
		set uu3tavg=uu3tavg/numtotal
		set ud0tavg=ud0tavg/numtotal
		set ud1tavg=ud1tavg/numtotal
		set ud2tavg=ud2tavg/numtotal
		set ud3tavg=ud3tavg/numtotal
		set bu0tavg=bu0tavg/numtotal
		set bu1tavg=bu1tavg/numtotal
		set bu2tavg=bu2tavg/numtotal
		set bu3tavg=bu3tavg/numtotal
		set bd0tavg=bd0tavg/numtotal
		set bd1tavg=bd1tavg/numtotal
		set bd2tavg=bd2tavg/numtotal
		set bd3tavg=bd3tavg/numtotal
		set ju0tavg=ju0tavg/numtotal
		set ju1tavg=ju1tavg/numtotal
		set ju2tavg=ju2tavg/numtotal
		set ju3tavg=ju3tavg/numtotal
		set jd0tavg=jd0tavg/numtotal
		set jd1tavg=jd1tavg/numtotal
		set jd2tavg=jd2tavg/numtotal
		set jd3tavg=jd3tavg/numtotal
		set v1mtavg=v1mtavg/numtotal
		set v1ptavg=v1ptavg/numtotal
		set v2mtavg=v2mtavg/numtotal
		set v2ptavg=v2ptavg/numtotal
		#
		set rhoqtavg=rhoqtavg/numtotal
		set zetatavg=zetatavg/numtotal
		set jsqtavg=jsqtavg/numtotal
		set fsqtavg=fsqtavg/numtotal
		#
		set absB1tavg=absB1tavg/numtotal
		set absB2tavg=absB2tavg/numtotal
		set absB3tavg=absB3tavg/numtotal
		#
		set bsqtavg=bsqtavg/numtotal
		#
		set aphitavg=aphitavg/numtotal
		#
		define DOGCALC (1)
		gfull2normal2
		#
gfull2normal2    0
 		set rho=rhotavg
		set u=utavg
                set v1=v1tavg
                set v2=v2tavg
                set v3=v3tavg
		set B1=B1tavg
		set B2=B2tavg
		set B3=B3tavg
		set divb=divbtavg
		set uu0=uu0tavg
		set uu1=uu1tavg
		set uu2=uu2tavg
		set uu3=uu3tavg
		set ud0=ud0tavg
		set ud1=ud1tavg
		set ud2=ud2tavg
		set ud3=ud3tavg
		set bu0=bu0tavg
		set bu1=bu1tavg
		set bu2=bu2tavg
		set bu3=bu3tavg
		set bd0=bd0tavg
		set bd1=bd1tavg
		set bd2=bd2tavg
		set bd3=bd3tavg
		set ju0=ju0tavg
		set ju1=ju1tavg
		set ju2=ju2tavg
		set ju3=ju3tavg
		set jd0=jd0tavg
		set jd1=jd1tavg
		set jd2=jd2tavg
		set jd3=jd3tavg
		set v1m=v1mtavg
		set v1p=v1ptavg
		set v2m=v2mtavg
		set v2p=v2ptavg
		#
		set rhoq=rhoqtavg
		set zeta=zetatavg
		set jsq=jsqtavg
		set fsq=fsqtavg
		#
		set absB1=absB1tavg
		set absB2=absB2tavg
		set absB3=absB3tavg
		#
		set bsq=bsqtavg
		#
		set aphi=aphitavg
		#
gcalcother      0
		#
		set lbrel=lg(bsq/rho)
		set libeta=lg(0.5*bsq/(u*($gam-1)))		
		set EE = bsq + EF
		#
greaddumpold       1 # 2D only right now
		jrdp2d $1
		da ./dumps/$1
		lines 2 10000000
		read {bsqtavg 37 aphitavg 38}
		#
		set bsq=bsqtavg
		set aphi=aphitavg
		gcalcother
		#
greaddump2       1 # with currents
		jrdpcf2d $1
		da ./dumps/$1
		lines 2 10000000
		read {rhoqtavg 57 zetatavg 58 jsqtavg 59 fsqtavg 60 absB1 61 absB2 62 absB3 63 bsq 64 aphi 65}
		#
		#
gwritedump2       1 # writedump name
		#
		define print_noheader (1)
		print "./dumps/$!!1" '%21.15g %d %d %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    #
		    # 11+4+8+8+4+1+4+4+6+6=56
		print + "./dumps/$!!1" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {ti tj x1 x2 r h rho u v1 v2 v3 \
                      B1 B2 B3 divb \
                      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
                      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                     v1m v1p v2m v2p gdet \
                    ju0 ju1 ju2 ju3  \
                    jd0 jd1 jd2 jd3  \
                    fu0 fu1 fu2 fu3 fu4 fu5 \
                    fd0 fd1 fd2 fd3 fd4 fd5 \
		        rhoq zeta jsq fsq \
		        absB1 absB2 absB3 \
		        bsq aphi}
		      #
		define print_noheader (1)
		#
avgtimeg3   3	# avgtimegfull (e.g. avgtimeg 'dump' start end)
		#
                set h1=$1
		define DOGCALC (1)
		#
		set uu1tavg=1,$nx*$ny*$nz,1
		set fdd23tavg=1,$nx*$ny*$nz,1
		set fdd02tavg=1,$nx*$ny*$nz,1
		set fdd13tavg=1,$nx*$ny*$nz,1
		set fdd01tavg=1,$nx*$ny*$nz,1
		set fdd03tavg=1,$nx*$ny*$nz,1
		set fdd12tavg=1,$nx*$ny*$nz,1 # \detg B^{\phi}
		set omega3tavg=1,$nx*$ny*$nz,1
		set mfltavg=1,$nx*$ny*$nz,1
		set lfltavg=1,$nx*$ny*$nz,1
		set efltavg=1,$nx*$ny*$nz,1
		set efl2tavg=1,$nx*$ny*$nz,1
		set v1ptavg=1,$nx*$ny*$nz,1
		set wf1tavg=1,$nx*$ny*$nz,1
		set wf2tavg=1,$nx*$ny*$nz,1
		set einftavg=1,$nx*$ny*$nz,1
		set linftavg=1,$nx*$ny*$nz,1
		#
		set auu1tavg=1,$nx*$ny*$nz,1
		set afdd23tavg=1,$nx*$ny*$nz,1
		set afdd02tavg=1,$nx*$ny*$nz,1
		set afdd13tavg=1,$nx*$ny*$nz,1
		set afdd01tavg=1,$nx*$ny*$nz,1
		set afdd03tavg=1,$nx*$ny*$nz,1
		set afdd12tavg=1,$nx*$ny*$nz,1
		set amfltavg=1,$nx*$ny*$nz,1
		set alfltavg=1,$nx*$ny*$nz,1
		set aefltavg=1,$nx*$ny*$nz,1
		set aefl2tavg=1,$nx*$ny*$nz,1
		set awf1tavg=1,$nx*$ny*$nz,1
		set awf2tavg=1,$nx*$ny*$nz,1
                #
		set uu1tavg=uu1tavg*0
		set fdd23tavg=fdd23tavg*0
		set fdd02tavg=fdd02tavg*0
		set fdd13tavg=fdd13tavg*0
		set fdd01tavg=fdd01tavg*0
		set fdd03tavg=fdd03tavg*0
		set fdd12tavg=fdd12tavg*0
		set omega3tavg=omega3tavg*0
		set mfltavg=mfltavg*0
		set lfltavg=lfltavg*0
		set efltavg=efltavg*0
		set efl2tavg=efl2tavg*0
		set v1ptavg=v1ptavg*0
		set wf1tavg=wf1tavg*0
		set wf2tavg=wf2tavg*0
		set einftavg=einftavg*0
		set linftavg=linftavg*0
		#
		set auu1tavg=auu1tavg*0
		set afdd23tavg=afdd23tavg*0
		set afdd02tavg=afdd02tavg*0
		set afdd13tavg=afdd13tavg*0
		set afdd01tavg=afdd01tavg*0
		set afdd03tavg=afdd03tavg*0
		set afdd12tavg=afdd12tavg*0
		set amfltavg=amfltavg*0
		set alfltavg=alfltavg*0
		set aefltavg=aefltavg*0
		set aefl2tavg=aefl2tavg*0
		set awf1tavg=awf1tavg*0
		set awf2tavg=awf2tavg*0
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp2d $filename
		  bzeflux
		 set uu1tavg=uu1tavg+uu1
		 set fdd23tavg=fdd23tavg+fdd23
		 set fdd02tavg=fdd02tavg+fdd02
		 set fdd13tavg=fdd13tavg+fdd13
		 set fdd01tavg=fdd01tavg+fdd01
		 set fdd03tavg=fdd03tavg+fdd03
		 set fdd12tavg=fdd12tavg+fdd12
		 set omega3tavg=omega3tavg+omega3
		 set mfltavg=mfltavg+mfl # with gdet, no area
		 set lfltavg=lfltavg+lfl
		 set efltavg=efltavg+efl
		 set efl2tavg=efl2tavg+efl2
		 set v1ptavg=v1ptavg+v1p
		 set wf1tavg=wf1tavg+omegaf2
		 set wf2tavg=wf2tavg+omegaf1
		 set einftavg=einftavg+einf
		 set linftavg=linftavg+linf
		 #
		 set auu1tavg=auu1tavg+uu1a
		 set afdd23tavg=afdd23tavg+afdd23
		 set afdd02tavg=afdd02tavg+afdd02
		 set afdd13tavg=afdd13tavg+afdd13
		 set afdd01tavg=afdd01tavg+afdd01
		 set afdd03tavg=afdd03tavg+afdd03
		 set afdd12tavg=afdd12tavg+afdd12
		 set amfltavg=amfltavg+ABS(mfl) # with gdet, no area
		 set alfltavg=alfltavg+alfl
		 set aefltavg=aefltavg+aefl
		 set aefl2tavg=aefl2tavg+ABS(efl2)
		 set awf1tavg=awf1tavg+aomegaf1
		 set awf2tavg=awf2tavg+aomegaf2
		}
		 set uu1tavg=uu1tavg/numtotal
		 set fdd23tavg=fdd23tavg/numtotal
		 set fdd02tavg=fdd02tavg/numtotal
		 set fdd13tavg=fdd13tavg/numtotal
		 set fdd01tavg=fdd01tavg/numtotal
		 set fdd03tavg=fdd03tavg/numtotal
		 set fdd12tavg=fdd12tavg/numtotal
		 set omega3tavg=omega3tavg/numtotal
		 set mfltavg=mfltavg/numtotal
		 set lfltavg=lfltavg/numtotal
		 set efltavg=efltavg/numtotal
		 set efl2tavg=efl2tavg/numtotal
		 set v1ptavg=v1ptavg/numtotal
		 set wf1tavg=wf1tavg/numtotal
		 set wf2tavg=wf2tavg/numtotal
		 set einftavg=einftavg/numtotal
		 set linftavg=linftavg/numtotal
		 #
		 set auu1tavg=auu1tavg/numtotal
		 set afdd23tavg=afdd23tavg/numtotal
		 set afdd02tavg=afdd02tavg/numtotal
		 set afdd13tavg=afdd13tavg/numtotal
		 set afdd01tavg=afdd01tavg/numtotal
		 set afdd03tavg=afdd03tavg/numtotal
		 set afdd12tavg=afdd12tavg/numtotal
		 set amfltavg=amfltavg/numtotal
		 set alfltavg=alfltavg/numtotal
		 set aefltavg=aefltavg/numtotal
		 set aefl2tavg=aefl2tavg/numtotal
		 set awf1tavg=awf1tavg/numtotal
		 set awf2tavg=awf2tavg/numtotal
		#
		set girattavg=aefltavg/aefl2tavg
		set magpartavg=sqrt(4*pi)*afdd23tavg/(hslope*pi)/sqrt(2*pi*amfltavg/(hslope*pi))
readg3      1   #
		da ./dumps/$1
		lines 1 10000000
		#
		# 32 columns
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {uu1tavg fdd23tavg fdd02tavg fdd13tavg fdd01tavg fdd03tavg fdd12tavg omega3tavg mfltavg \
		       lfltavg efltavg efl2tavg v1ptavg wf1tavg wf2tavg einftavg linftavg auu1tavg \
		    afdd23tavg afdd02tavg afdd13tavg afdd01tavg afdd03tavg afdd12tavg amfltavg alfltavg aefltavg aefl2tavg awf1tavg awf2tavg \
		    girattavg magpartavg}
		    # 
		    #
		    set a2wftavg=afdd02tavg/afdd23tavg
printg3     1   # printg3 bigg3.txt printg3 tavg3.txt
		#
		define myname $1
		# 32 columns
		print "./dumps/$!myname" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {uu1tavg fdd23tavg fdd02tavg fdd13tavg fdd01tavg fdd03tavg fdd12tavg omega3tavg mfltavg \
		       lfltavg efltavg efl2tavg v1ptavg wf1tavg wf2tavg einftavg linftavg auu1tavg \
		    afdd23tavg afdd02tavg afdd13tavg afdd01tavg afdd03tavg afdd12tavg amfltavg alfltavg aefltavg aefl2tavg awf1tavg awf2tavg \
		    girattavg magpartavg}
		    #
		    #
printg3alt  0           #
		    # for dobzcalcs
		    #set eflem=
		    set eflma=amfltavg
		    set omegaf2=wftavg
		    set absomegaf2=awftavg
		    #set bsq=
		    set auu1=auu1tavg
		    set afdd23=afdd23tavg
		    set afdd02=afdd02tavg
		    set amfl=amfltavg
		    set aefl=aefltavg
		    set alfl=alfltavg
		    set aefl2=efl2tavg
		    set omega3=omega3tavg
		    #
		    dobzcalcs 35 ($rhor) (1.2*$rhor) 0.82 0.3
		    print  '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g '\
		    {bsqpoi bsqpoc empomat emtomat \
		           omegarat1 omegarat2 omegarat3 omegarat4 omegarat5 omegarat6 omegarat7 omegarat8 \
		       mygirat magparam einfrat linfrat fdd23rat fdd02rat mrat lrat erat uu1rat}
		       #
		       #
		    #
avgtimeg5   3	# avgtimeg5 (e.g. avgtimeg5 'dump' start end)
		#
		#
		# computes the time average of some additional JET related quantities for jet paper
		#
		#
                set h1=$1
		define DOGCALC (1)
		#
		set EN1tavg=1,$nx*$ny*$nz,1
		set LN1tavg=1,$nx*$ny*$nz,1
		set eta1tavg=1,$nx*$ny*$nz,1
		set D2tavg=1,$nx*$ny*$nz,1
		set B1bltavg=1,$nx*$ny*$nz,1
		set B2bltavg=1,$nx*$ny*$nz,1
		set B3bltavg=1,$nx*$ny*$nz,1
		set Bd3bltavg=1,$nx*$ny*$nz,1
		set uu0bltavg=1,$nx*$ny*$nz,1
		set uu1bltavg=1,$nx*$ny*$nz,1
		set uu2bltavg=1,$nx*$ny*$nz,1
		set uu3bltavg=1,$nx*$ny*$nz,1
		set ud0bltavg=1,$nx*$ny*$nz,1
		set ud1bltavg=1,$nx*$ny*$nz,1
		set ud2bltavg=1,$nx*$ny*$nz,1
		set ud3bltavg=1,$nx*$ny*$nz,1
		set accemtavg=1,$nx*$ny*$nz,1
		set accmatavg=1,$nx*$ny*$nz,1
		set collmatavg=1,$nx*$ny*$nz,1
		set collematavg=1,$nx*$ny*$nz,1
		set collembtavg=1,$nx*$ny*$nz,1
		set gammainftavg=1,$nx*$ny*$nz,1
		set acctrueemtavg=1,$nx*$ny*$nz,1
		set colltrueemtavg=1,$nx*$ny*$nz,1
                #
		#
		set emefluxalongBtavg=1,$nx*$ny*$nz,1
		set maefluxalongBtavg=1,$nx*$ny*$nz,1
		set emlfluxalongBtavg=1,$nx*$ny*$nz,1
		set malfluxalongBtavg=1,$nx*$ny*$nz,1
		#
		set emefluxacrossBtavg=1,$nx*$ny*$nz,1
		set maefluxacrossBtavg=1,$nx*$ny*$nz,1
		set emlfluxacrossBtavg=1,$nx*$ny*$nz,1
		set malfluxacrossBtavg=1,$nx*$ny*$nz,1
		#
		#
		set EN1tavg=EN1tavg*0
		set LN1tavg=LN1tavg*0
		set eta1tavg=eta1tavg*0
		set D2tavg=D2tavg*0
		set B1bltavg=B1bltavg*0
		set B2bltavg=B2bltavg*0
		set B3bltavg=B3bltavg*0
		set Bd3bltavg=Bd3bltavg*0
		set uu0bltavg=uu0bltavg*0
		set uu1bltavg=uu1bltavg*0
		set uu2bltavg=uu2bltavg*0
		set uu3bltavg=uu3bltavg*0
		set ud0bltavg=ud0bltavg*0
		set ud1bltavg=ud1bltavg*0
		set ud2bltavg=ud2bltavg*0
		set ud3bltavg=ud3bltavg*0
		set accemtavg=accemtavg*0
		set accmatavg=accmatavg*0
		set collmatavg=collmatavg*0
		set collematavg=collematavg*0
		set collembtavg=collembtavg*0
		set gammainftavg=gammainftavg*0
		set acctrueemtavg=acctrueemtavg*0
		set colltrueemtavg=colltrueemtavg*0
		#
		#
		set emefluxalongBtavg=emefluxalongBtavg*0
		set maefluxalongBtavg=maefluxalongBtavg*0
		set emlfluxalongBtavg=emlfluxalongBtavg*0
		set malfluxalongBtavg=malfluxalongBtavg*0
		#
		set emefluxacrossBtavg=emefluxacrossBtavg*0
		set maefluxacrossBtavg=maefluxacrossBtavg*0
		set emlfluxacrossBtavg=emlfluxacrossBtavg*0
		set malfluxacrossBtavg=malfluxacrossBtavg*0
		#
		#
		#
		#
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdpcf $filename
		  #
		  jre levinson.m
		  stresscalc 1
		  faraday
		  jsq
		  #
		  mycons
		  setjet1
		 set EN1tavg=EN1tavg+EN1
		 set LN1tavg=LN1tavg+LN1
		 set eta1tavg=eta1tavg+eta1
		 set D2tavg=D2tavg+D2
		 set B1bltavg=B1bltavg+B1bl
		 set B2bltavg=B2bltavg+B2bl
		 set B3bltavg=B3bltavg+B3bl
		 set Bd3bltavg=Bd3bltavg+Bd3bl
		 set uu0bltavg=uu0bltavg+uu0bl
		 set uu1bltavg=uu1bltavg+uu1bl
		 set uu2bltavg=uu2bltavg+uu2bl
		 set uu3bltavg=uu3bltavg+uu3bl
		 set ud0bltavg=ud0bltavg+ud0bl
		 set ud1bltavg=ud1bltavg+ud1bl
		 set ud2bltavg=ud2bltavg+ud2bl
		 set ud3bltavg=ud3bltavg+ud3bl
		 set accemtavg=accemtavg+accem
		 set accmatavg=accmatavg+accma
		 set gammainftavg=gammainftavg+gammainf
		 set collmatavg=collmatavg+collma
		 set collematavg=collematavg+collema
		 set collembtavg=collembtavg+collemb
		 set acctrueemtavg=acctrueemtavg+acctrueem
		 set colltrueemtavg=colltrueemtavg+colltrueem
		 #
		 #
		set emefluxalongBtavg=emefluxalongBtavg+emefluxalongB
		set maefluxalongBtavg=maefluxalongBtavg+maefluxalongB
		set emlfluxalongBtavg=emlfluxalongBtavg+emlfluxalongB
		set malfluxalongBtavg=malfluxalongBtavg+malfluxalongB
		#
		set emefluxacrossBtavg=emefluxacrossBtavg+emefluxacrossB
		set maefluxacrossBtavg=maefluxacrossBtavg+maefluxacrossB
		set emlfluxacrossBtavg=emlfluxacrossBtavg+emlfluxacrossB
		set malfluxacrossBtavg=malfluxacrossBtavg+malfluxacrossB
		#
		#
		 #
		 #
		}
		#
		 set EN1tavg=EN1tavg/numtotal
		 set LN1tavg=LN1tavg/numtotal
		 set eta1tavg=eta1tavg/numtotal
		 set D2tavg=D2tavg/numtotal
		 set B1bltavg=B1bltavg/numtotal
		 set B2bltavg=B2bltavg/numtotal
		 set B3bltavg=B3bltavg/numtotal
		 set Bd3bltavg=Bd3bltavg/numtotal
		 set uu0bltavg=uu0bltavg/numtotal
		 set uu1bltavg=uu1bltavg/numtotal
		 set uu2bltavg=uu2bltavg/numtotal
		 set uu3bltavg=uu3bltavg/numtotal
		 set ud0bltavg=ud0bltavg/numtotal
		 set ud1bltavg=ud1bltavg/numtotal
		 set ud2bltavg=ud2bltavg/numtotal
		 set ud3bltavg=ud3bltavg/numtotal
		 set accemtavg=accemtavg/numtotal
		 set accmatavg=accmatavg/numtotal
		 set collmatavg=collmatavg/numtotal
		 set collematavg=collematavg/numtotal
		 set collembtavg=collembtavg/numtotal
		 set gammainftavg=gammainftavg/numtotal
		 set acctrueemtavg=acctrueemtavg/numtotal
		 set colltrueemtavg=colltrueemtavg/numtotal
		#
		 #
		set emefluxalongBtavg=emefluxalongBtavg/numtotal
		set maefluxalongBtavg=maefluxalongBtavg/numtotal
		set emlfluxalongBtavg=emlfluxalongBtavg/numtotal
		set malfluxalongBtavg=malfluxalongBtavg/numtotal
		#
		set emefluxacrossBtavg=emefluxacrossBtavg/numtotal
		set maefluxacrossBtavg=maefluxacrossBtavg/numtotal
		set emlfluxacrossBtavg=emlfluxacrossBtavg/numtotal
		set malfluxacrossBtavg=malfluxacrossBtavg/numtotal
		#
		#
		#
		#
		#
readg5      1   # readg5 tavg52040.txt
		da ./dumps/$1
		lines 1 10000000
		#
		# 32 columns
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		{EN1tavg LN1tavg eta1tavg D2tavg \
		       B1bltavg B2bltavg B3bltavg Bd3bltavg uu0bltavg uu1bltavg uu2bltavg uu3bltavg ud0bltavg ud1bltavg ud2bltavg ud3bltavg \
		       accemtavg accmatavg collmatavg collematavg collembtavg gammainftavg acctrueemtavg colltrueemtavg \
		       emefluxalongBtavg maefluxalongBtavg emlfluxalongBtavg malfluxalongBtavg emefluxacrossBtavg maefluxacrossBtavg emlfluxacrossBtavg malfluxacrossBtavg }
		    
		    # 
		    #
printg5     1   # printg5 tavg52040.txt
		#
		define myname $1
		# 32 columns
		print "./dumps/$!myname" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		{EN1tavg LN1tavg eta1tavg D2tavg \
		       B1bltavg B2bltavg B3bltavg Bd3bltavg uu0bltavg uu1bltavg uu2bltavg uu3bltavg ud0bltavg ud1bltavg ud2bltavg ud3bltavg \
		    accemtavg accmatavg collmatavg collematavg collembtavg gammainftavg acctrueemtavg colltrueemtavg \
		       emefluxalongBtavg maefluxalongBtavg emlfluxalongBtavg malfluxalongBtavg emefluxacrossBtavg maefluxacrossBtavg emlfluxacrossBtavg malfluxacrossBtavg }

		#
		#
		#
setTtavg    4   #
		#
		set $1$2$3part0tavg=$4
		set $1$2$3part1tavg=$4
		set $1$2$3part2tavg=$4
		set $1$2$3part3tavg=$4
		set $1$2$3part4tavg=$4
		set $1$2$3part5tavg=$4
		set $1$2$3part6tavg=$4
		#
setTtavg2    3   #
		#
		set $1$2$3part0tavg=$1$2$3part0tavg+$1$2$3part0
		set $1$2$3part1tavg=$1$2$3part1tavg+$1$2$3part1
		set $1$2$3part2tavg=$1$2$3part2tavg+$1$2$3part2
		set $1$2$3part3tavg=$1$2$3part3tavg+$1$2$3part3
		set $1$2$3part4tavg=$1$2$3part4tavg+$1$2$3part4
		set $1$2$3part5tavg=$1$2$3part5tavg+$1$2$3part5
		set $1$2$3part6tavg=$1$2$3part6tavg+$1$2$3part6
		#
setTtavg3    3   #
		#
		set $1$2$3part0tavg=$1$2$3part0tavg/numtotal
		set $1$2$3part1tavg=$1$2$3part1tavg/numtotal
		set $1$2$3part2tavg=$1$2$3part2tavg/numtotal
		set $1$2$3part3tavg=$1$2$3part3tavg/numtotal
		set $1$2$3part4tavg=$1$2$3part4tavg/numtotal
		set $1$2$3part5tavg=$1$2$3part5tavg/numtotal
		set $1$2$3part6tavg=$1$2$3part6tavg/numtotal
		#
avgtimeg4   3	# avgtimeg4 (e.g. avgtimeg 'dump' start end)
		# set it="$!!preg"00
		#
		# have to get grid for this
		#
		#gammiegrid gdump
		#
		#
                set h1=$1
		define DOGCALC (1)
		#
		set EINFtavg=1,$nx*$ny*$nz,1
		#
		set EINFtavg=EINFtavg*0
		set EINFMAtavg=EINFtavg
		set EINFEMtavg=EINFtavg
		#
		# this just zeroes things out
		do ii=0,3 {
		   do jj=0,3 {
		      #setTtavg Tdd $ii $jj EINFtavg
		      setTtavg Tud $ii $jj EINFtavg
		      #setTtavg Tuu $ii $jj EINFtavg
		   }
		}
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
                do ii=numstart,numend,1 {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  #bzeflux
		  #ergocalc1
		  stresscalc 1
		  #
		  #set EINFtavg=EINFtavg+EINF
		  #set EINFMAtavg=EINFMAtavg+EINFMA
		  #set EINFEMtavg=EINFEMtavg+EINFEM
		  #
		  do ii=0,3 {
		     do jj=0,3 {
		        #
		        #setTtavg2 Tdd $ii $jj
		      setTtavg2 Tud $ii $jj
		     # setTtavg2 Tuu $ii $jj
		     }
		  }
		  #
		}
		set EINFtavg=EINFtavg/numtotal
		set EINFMAtavg=EINFMAtavg/numtotal
		set EINFEMtavg=EINFEMtavg/numtotal
		#
		do ii=0,3 {
		   do jj=0,3 {
		      #setTtavg3 Tdd $ii $jj
		      setTtavg3 Tud $ii $jj
		      #setTtavg3 Tuu $ii $jj
		   }
		}
		#
readg4      1   #
		da ./dumps/$1
		lines 1 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {EINFtavg EINFMAtavg EINFEMtavg \
		Tdd00tavg Tdd01tavg Tdd02tavg Tdd03tavg Tdd10tavg Tdd11tavg Tdd12tavg Tdd13tavg Tdd20tavg Tdd21tavg Tdd22tavg Tdd23tavg Tdd30tavg Tdd31tavg Tdd32tavg Tdd33tavg \
		Tud00tavg Tud01tavg Tud02tavg Tud03tavg Tud10tavg Tud11tavg Tud12tavg Tud13tavg Tud20tavg Tud21tavg Tud22tavg Tud23tavg Tud30tavg Tud31tavg Tud32tavg Tud33tavg \
		Tuu00tavg Tuu01tavg Tuu02tavg Tuu03tavg Tuu10tavg Tuu11tavg Tuu12tavg Tuu13tavg Tuu20tavg Tuu21tavg Tuu22tavg Tuu23tavg Tuu30tavg Tuu31tavg Tuu32tavg Tuu33tavg \
		    }
		    # 51
		    #
printg4     1   #
		#
		lines 1 10000000
		#
		define myname $1
		print "./dumps/$!myname" {EINFtavg EINFMAtavg EINFEMtavg \
		Tdd00tavg Tdd01tavg Tdd02tavg Tdd03tavg Tdd10tavg Tdd11tavg Tdd12tavg Tdd13tavg Tdd20tavg \
		    Tdd21tavg Tdd22tavg Tdd23tavg Tdd30tavg Tdd31tavg Tdd32tavg Tdd33tavg \
		Tud00tavg Tud01tavg Tud02tavg Tud03tavg Tud10tavg Tud11tavg Tud12tavg Tud13tavg Tud20tavg \
		    Tud21tavg Tud22tavg Tud23tavg Tud30tavg Tud31tavg Tud32tavg Tud33tavg \
		Tuu00tavg Tuu01tavg Tuu02tavg Tuu03tavg Tuu10tavg Tuu11tavg Tuu12tavg Tuu13tavg Tuu20tavg \
		    Tuu21tavg Tuu22tavg Tuu23tavg Tuu30tavg Tuu31tavg Tuu32tavg Tuu33tavg \
		    }
readg42      1   #
		da ./dumps/$1
		lines 1 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {Tud00part0 Tud00part1  Tud00part2  Tud00part3  Tud00part4  Tud00part5  Tud00part6 \
		     Tud01part0 Tud01part1  Tud01part2  Tud01part3  Tud01part4  Tud01part5  Tud01part6 \
		     Tud02part0 Tud02part1  Tud02part2  Tud02part3  Tud02part4  Tud02part5  Tud02part6 \
		     Tud03part0 Tud03part1  Tud03part2  Tud03part3  Tud03part4  Tud03part5  Tud03part6 \
		    Tud10part0 Tud10part1  Tud10part2  Tud10part3  Tud10part4  Tud10part5  Tud10part6 \
		     Tud11part0 Tud11part1  Tud11part2  Tud11part3  Tud11part4  Tud11part5  Tud11part6 \
		     Tud12part0 Tud12part1  Tud12part2  Tud12part3  Tud12part4  Tud12part5  Tud12part6 \
		     Tud13part0 Tud13part1  Tud13part2  Tud13part3  Tud13part4  Tud13part5  Tud13part6 \
		    Tud20part0 Tud20part1  Tud20part2  Tud20part3  Tud20part4  Tud20part5  Tud20part6 \
		     Tud21part0 Tud21part1  Tud21part2  Tud21part3  Tud21part4  Tud21part5  Tud21part6 \
		     Tud22part0 Tud22part1  Tud22part2  Tud22part3  Tud22part4  Tud22part5  Tud22part6 \
		     Tud23part0 Tud23part1  Tud23part2  Tud23part3  Tud23part4  Tud23part5  Tud23part6 \
		    Tud30part0 Tud30part1  Tud30part2  Tud30part3  Tud30part4  Tud30part5  Tud30part6 \
		     Tud31part0 Tud31part1  Tud31part2  Tud31part3  Tud31part4  Tud31part5  Tud31part6 \
		     Tud32part0 Tud32part1  Tud32part2  Tud32part3  Tud32part4  Tud32part5  Tud32part6 \
		     Tud33part0 Tud33part1  Tud33part2  Tud33part3  Tud33part4  Tud33part5  Tud33part6 }
 	         tudpart2whole 0
		 #
		 # 112
tudpart2whole 1     #
		if($1==1) { define myabs ('a') }
		if($1==0) { define myabs (' ') }
		#
		    set Tud00MA$myabs=Tud00part0$myabs+Tud00part1$myabs+Tud00part2$myabs+Tud00part4$myabs
		    set Tud00EM$myabs=Tud00part3$myabs+Tud00part5$myabs+Tud00part6$myabs
		    set Tud01MA$myabs=Tud01part0$myabs+Tud01part1$myabs+Tud01part2$myabs+Tud01part4$myabs
		    set Tud01EM$myabs=Tud01part3$myabs+Tud01part5$myabs+Tud01part6$myabs
		    set Tud02MA$myabs=Tud02part0$myabs+Tud02part1$myabs+Tud02part2$myabs+Tud02part4$myabs
		    set Tud02EM$myabs=Tud02part3$myabs+Tud02part5$myabs+Tud02part6$myabs
		    set Tud03MA$myabs=Tud03part0$myabs+Tud03part1$myabs+Tud03part2$myabs+Tud03part4$myabs
		    set Tud03EM$myabs=Tud03part3$myabs+Tud03part5$myabs+Tud03part6$myabs
		    #
		    set Tud10MA$myabs=Tud10part0$myabs+Tud10part1$myabs+Tud10part2$myabs+Tud10part4$myabs
		    set Tud10EM$myabs=Tud10part3$myabs+Tud10part5$myabs+Tud10part6$myabs
		    set Tud11MA$myabs=Tud11part0$myabs+Tud11part1$myabs+Tud11part2$myabs+Tud11part4$myabs
		    set Tud11EM$myabs=Tud11part3$myabs+Tud11part5$myabs+Tud11part6$myabs
		    set Tud12MA$myabs=Tud12part0$myabs+Tud12part1$myabs+Tud12part2$myabs+Tud12part4$myabs
		    set Tud12EM$myabs=Tud12part3$myabs+Tud12part5$myabs+Tud12part6$myabs
		    set Tud13MA$myabs=Tud13part0$myabs+Tud13part1$myabs+Tud13part2$myabs+Tud13part4$myabs
		    set Tud13EM$myabs=Tud13part3$myabs+Tud13part5$myabs+Tud13part6$myabs
		    #
		    set Tud20MA$myabs=Tud20part0$myabs+Tud20part1$myabs+Tud20part2$myabs+Tud20part4$myabs
		    set Tud20EM$myabs=Tud20part3$myabs+Tud20part5$myabs+Tud20part6$myabs
		    set Tud21MA$myabs=Tud21part0$myabs+Tud21part1$myabs+Tud21part2$myabs+Tud21part4$myabs
		    set Tud21EM$myabs=Tud21part3$myabs+Tud21part5$myabs+Tud21part6$myabs
		    set Tud22MA$myabs=Tud22part0$myabs+Tud22part1$myabs+Tud22part2$myabs+Tud22part4$myabs
		    set Tud22EM$myabs=Tud22part3$myabs+Tud22part5$myabs+Tud22part6$myabs
		    set Tud23MA$myabs=Tud23part0$myabs+Tud23part1$myabs+Tud23part2$myabs+Tud23part4$myabs
		    set Tud23EM$myabs=Tud23part3$myabs+Tud23part5$myabs+Tud23part6$myabs
		    #
		    set Tud30MA$myabs=Tud30part0$myabs+Tud30part1$myabs+Tud30part2$myabs+Tud30part4$myabs
		    set Tud30EM$myabs=Tud30part3$myabs+Tud30part5$myabs+Tud30part6$myabs
		    set Tud31MA$myabs=Tud31part0$myabs+Tud31part1$myabs+Tud31part2$myabs+Tud31part4$myabs
		    set Tud31EM$myabs=Tud31part3$myabs+Tud31part5$myabs+Tud31part6$myabs
		    set Tud32MA$myabs=Tud32part0$myabs+Tud32part1$myabs+Tud32part2$myabs+Tud32part4$myabs
		    set Tud32EM$myabs=Tud32part3$myabs+Tud32part5$myabs+Tud32part6$myabs
		    set Tud33MA$myabs=Tud33part0$myabs+Tud33part1$myabs+Tud33part2$myabs+Tud33part4$myabs
		    set Tud33EM$myabs=Tud33part3$myabs+Tud33part5$myabs+Tud33part6$myabs
		    #
		    set Tud00$myabs=Tud00MA$myabs+Tud00EM$myabs
		    set Tud01$myabs=Tud01MA$myabs+Tud01EM$myabs
		    set Tud02$myabs=Tud02MA$myabs+Tud02EM$myabs
		    set Tud03$myabs=Tud03MA$myabs+Tud03EM$myabs
		    #
		    set Tud10$myabs=Tud10MA$myabs+Tud10EM$myabs
		    set Tud11$myabs=Tud11MA$myabs+Tud11EM$myabs
		    set Tud12$myabs=Tud12MA$myabs+Tud12EM$myabs
		    set Tud13$myabs=Tud13MA$myabs+Tud13EM$myabs
		    #
		    set Tud20$myabs=Tud20MA$myabs+Tud20EM$myabs
		    set Tud21$myabs=Tud21MA$myabs+Tud21EM$myabs
		    set Tud22$myabs=Tud22MA$myabs+Tud22EM$myabs
		    set Tud23$myabs=Tud23MA$myabs+Tud23EM$myabs
		    #
		    set Tud30$myabs=Tud30MA$myabs+Tud30EM$myabs
		    set Tud31$myabs=Tud31MA$myabs+Tud31EM$myabs
		    set Tud32$myabs=Tud32MA$myabs+Tud32EM$myabs
		    set Tud33$myabs=Tud33MA$myabs+Tud33EM$myabs
		    #
printg42     1   #
		# 112
		lines 1 10000000
		#
		define myname $1
		print "./dumps/$!myname" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {Tud00part0tavg Tud00part1tavg  Tud00part2tavg  Tud00part3tavg  Tud00part4tavg  Tud00part5tavg  Tud00part6tavg \
		     Tud01part0tavg Tud01part1tavg  Tud01part2tavg  Tud01part3tavg  Tud01part4tavg  Tud01part5tavg  Tud01part6tavg \
		     Tud02part0tavg Tud02part1tavg  Tud02part2tavg  Tud02part3tavg  Tud02part4tavg  Tud02part5tavg  Tud02part6tavg \
		     Tud03part0tavg Tud03part1tavg  Tud03part2tavg  Tud03part3tavg  Tud03part4tavg  Tud03part5tavg  Tud03part6tavg \
		    Tud10part0tavg Tud10part1tavg  Tud10part2tavg  Tud10part3tavg  Tud10part4tavg  Tud10part5tavg  Tud10part6tavg \
		     Tud11part0tavg Tud11part1tavg  Tud11part2tavg  Tud11part3tavg  Tud11part4tavg  Tud11part5tavg  Tud11part6tavg \
		     Tud12part0tavg Tud12part1tavg  Tud12part2tavg  Tud12part3tavg  Tud12part4tavg  Tud12part5tavg  Tud12part6tavg \
		     Tud13part0tavg Tud13part1tavg  Tud13part2tavg  Tud13part3tavg  Tud13part4tavg  Tud13part5tavg  Tud13part6tavg \
		    Tud20part0tavg Tud20part1tavg  Tud20part2tavg  Tud20part3tavg  Tud20part4tavg  Tud20part5tavg  Tud20part6tavg \
		     Tud21part0tavg Tud21part1tavg  Tud21part2tavg  Tud21part3tavg  Tud21part4tavg  Tud21part5tavg  Tud21part6tavg \
		     Tud22part0tavg Tud22part1tavg  Tud22part2tavg  Tud22part3tavg  Tud22part4tavg  Tud22part5tavg  Tud22part6tavg \
		     Tud23part0tavg Tud23part1tavg  Tud23part2tavg  Tud23part3tavg  Tud23part4tavg  Tud23part5tavg  Tud23part6tavg \
		    Tud30part0tavg Tud30part1tavg  Tud30part2tavg  Tud30part3tavg  Tud30part4tavg  Tud30part5tavg  Tud30part6tavg \
		     Tud31part0tavg Tud31part1tavg  Tud31part2tavg  Tud31part3tavg  Tud31part4tavg  Tud31part5tavg  Tud31part6tavg \
		     Tud32part0tavg Tud32part1tavg  Tud32part2tavg  Tud32part3tavg  Tud32part4tavg  Tud32part5tavg  Tud32part6tavg \
		     Tud33part0tavg Tud33part1tavg  Tud33part2tavg  Tud33part3tavg  Tud33part4tavg  Tud33part5tavg  Tud33part6tavg }
		     #
		     #
doavgavg 2       # !$!HOME/bin/smcalc 329 3 256 256 ./dumps/avg ./dumps/avg 10 39
		!$!HOME/bin/smcalc 329 3 $nx $ny ./dumps/avg ./dumps/avg $1 $2
		#
		#
