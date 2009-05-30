# macro read "/home/jon/research/pnmhd/bin/myplots2.m"
stressdoall 3          #
		     rdr
		     rdbasic 0 0 -1
		     #rdbasic 0 1 -1
		     #smstart
		     ctype default
		     rdnumd
  		   #set start=2*$NUMDUMPS/3
		     #set end=$NUMDUMPS-1
		     #set start=40
		     #set end=60
		     set start=$1
		     set end=$2
		     avgtime 'dump' start end
		     echo doing fl
		     thetaphiavg $3 Flatime avgfl newx1
		     echo doing flr
		     thetaphiavg $3 Flartime avgflr newx1
		     echo doing flm
		     thetaphiavg $3 Flamtime avgflm newx1
		     echo doing en
		     thetaphiavg $3 entime avgen newx1
		     echo doing b2
		     thetaphiavg $3 b2time avgb2 newx1
		     echo doing plot
		     #smstart
		     set intratio=avgflm/avgflr
		     pl 0 newx1 intratio 1100
		     #stressplotnewg
                     #
                     # thindisk H/R study
stresstime 5          # stresstime 'dump' start end radius thetarange
		     ctype default
                     define gammie2 (0)
		     if($gammie==1){\
		      re twod.m
		      rdp dump000
                      macro read "/home/jon/research/pnmhd/bin/gammie.m"
		      gammienew
		     }
		     if($gammie==0){\
		      rdr
		      rdbasic 0 0 -1
		      #rdbasic 0 1 -1
		      #smstart
		      #rdnumd
                      set h3='.dat'
		     }
		     set h1=$1
		     set numstart=$2
		     set numend=$3
                     # override
		     #set numstart=0
		     #set numend=$NUMDUMPS-1
		     #
		     set numtotal=numend-numstart+1		     
		     set intratio1vst=0,numtotal-1,1
		     set intratio1vst=intratio1vst*0
		     set intratio2vst=0,numtotal-1,1
		     set intratio2vst=intratio2vst*0
		     set avgflmvst=0,numtotal-1,1
		     set avgflmvst=avgflmvst*0
		     set avgflrvst=0,numtotal-1,1
		     set avglfrvst=avgflrvst*0
		     set mdotfullvst=0,numtotal-1,1
		     set mdotfullvst=mdotfullvst*0
		     set mytime=0,numtotal-1,1
		     set mytime=mytime*0
		     #
		     set ii=0
		     ## just use inner edge for now
		     while {x12[ii]<$4} { set ii=ii+1 }
		     set pickradius=ii
		     set ii=0
 		     while {x12[ii]<$4} { set ii=ii+1 }
		     set pickradius2=ii
                     # lisco is always at 6.0 for now
		     set myomegak= sqrt(1.0/(6.0**3 * (1.0-2/6.0)**2 ) )
		     set myliscovar=6.0**2.0*myomegak
		     define mylisco (myliscovar)
                 #
                if(($gammie==1)&&($gammie2==0)){\
                 set ii=0
	     	 do iiii=numstart,numend,1 {
		   if($gammie==1){\
		      set h2=sprintf('%03d',$iiii)
		      set _fname=h1+h2
		      define filename (_fname)
                      re twod.m                      
		      rdp $filename
                      macro read "/home/jon/research/pnmhd/bin/gammie.m"
                      gammienew
		      gammiestress temp1 temp2 temp3 $4 $5
		      set intratio1vst[ii]=temp1/temp3/($mylisco)
		      set intratio2vst[ii]=temp2/temp3/($mylisco)
		      set avgflmvst[ii]=temp1
		      set avgflrvst[ii]=temp2
		      set mdotfullvst[ii]=temp3
		   }
		   if($gammie==0){\
		      set h2=sprintf('%04d',$iiii)
		      set _fname=h1+h2+h3
		      define filename (_fname)
                      rd $filename
		      #
		      #echo doing lspec
		      #set lspec=x12*x12*omega3
		      #set lspec=x12*x12*omegak
		      #thetaphiavg $5 lspec lspecavg newx1 0
                      #define lisco (lspecavg[pickradius2])
		      echo doing mdot
		      set mdot=r*vx*x12*x12
		      thetaphiavg $5 mdot mdotfull newx1 1
		      echo doing flr		      
		      set Flartime=(x12*x12*x12*g42*r*vx*vz)
		      thetaphiavg $5 Flartime avgflr newx1 1
		      echo doing flm
		      set Flamtime=(x12*x12*x12*g42*(-bz*bx))
		      thetaphiavg $5 Flamtime avgflm newx1 1
		      echo doing plot
		      set intratio1vst[ii]=avgflm[pickradius]/mdotfull[pickradius]/($mylisco)
		      set intratio2vst[ii]=avgflr[pickradius]/mdotfull[pickradius]/($mylisco)
		      set avgflmvst[ii]=avgflm[pickradius]
		      set avgflrvst[ii]=avgflr[pickradius]
		      set mdotfullvst[ii]=mdotfull[pickradius]
		   }
		   if($gammie==0) { set mytime[ii]=$time }
		   if($gammie==1) { set mytime[ii]=_t }
		      set ii=ii+1
		     }
		}
                if(($gammie==1)&&($gammie2==1)){\
						  re ener.m
						  rd ener.out
                                                  set mytime=t
						  set intratio1vst=0
						  set intratio2vst=rat
						  set mdotfullvst=dm
						  set avgflmvst=dl
						  set avgflrvst=dl
						  }

                     write standard hello1
                     smstart
                     write standard hello2
		     set ram=(ABS(intratio1vst))
		     set rar=(ABS(intratio2vst))
                     set rra=ram/rar
		     avg mytime rra arra
		     # time average all quantities
		     avg mytime ram aram
		     avg mytime rar arar
                     set rara=aram/arar
                     avg mytime mdotfullvst mdottavg
                     avg mytime avgflmvst avgflmtavg
                     avg mytime avgflrvst avgflrtavg
		     set raam=avgflmtavg/mdottavg/($mylisco)
		     set raar=avgflrtavg/mdottavg/($mylisco)
		     set rraa=avgflmtavg/avgflrtavg
                     #
                     # magnetic term
                     #
		     device postencap ram-vst.eps
		     pl 0 mytime ram
		     device X11
                     #
                     # reynolds term
		     #
		     device postencap rar-vst.eps
		     pl 0 mytime rar
		     device X11
                     #
                     # mag/ry
		     #
		     device postencap rra-vst.eps
		     pl 0 mytime rra
		     device X11
                     # print all quantities vs time
		     print emryvst.dat '%21.15g %21.15g %21.15g %21.15g\n' {mytime ram rar rra}
		     #
                     print ryemratio.dat '%d %d\n' {numstart numend}
 		     set myrms1=sqrt(SUM(ram**2)/dimen(ram))
 		     print + ryemratio.dat 'em/l/mdot: %21.15g %21.15g\n' {aram myrms1}
 		     set myrms2=sqrt(SUM(rar**2)/dimen(rar))
 		     print + ryemratio.dat 'ry/l/mdot: %21.15g %21.15g\n' {arar myrms2}
		     set myrms3=sqrt(SUM(rra**2)/dimen(rra))
 		     print + ryemratio.dat 'em/ry: %21.15g %21.15g\n' {arra myrms3}
 		     print + ryemratio.dat 'em ry em/ry: %21.15g %21.15g %21.15g\n' {raam raar rraa}
		     #
gammieflux 4  # gammieflux radius thetarange flux sum
	      #
	      grabrth $1 $2 radindex thinindex thoutindex
	      set $4=0
	      do asdf=thinindex,thoutindex,1 {
		set $4=$4+gdet[radindex+$nx*$asdf]*($3[radindex+$nx*$asdf])*2*PI*$dx2
	      }
              #
grabrth    5       # grabrth radius thetarange radindex thinindex thoutindex
		     set asdf=0
 		     while {(x12[asdf]<$1)&&(asdf<$nx)} { set asdf=asdf+1 }
		     if(asdf>$nx-1) { set asdf=$nx-1 }
		     set $3=asdf
                     #
		     set asdf=0
 		     while {(x22[$nx*asdf]<PI/2-$2)&&(asdf<$ny)} { set asdf=asdf+1 }
		     if(asdf>$ny-1) { set asdf=$ny-1 }
		     set $4=asdf
                     #
		     set asdf=$ny-1
 		     while {(x22[$nx*asdf]>PI/2+$2)&&(asdf>=0)} { set asdf=asdf-1 }
		     if(asdf<0) { set asdf=0 }
		     set $5=asdf
		     #
stressplot           #
		     erase
                     #device postencap stressnew.eps
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
		     set realx1=newx1 if((newx1>=innerr)&&(newx1<=outerr))
		     set lgnewx1=LG(realx1)
		     limits lgnewx1 -8 -2
                     #limits x1 -8 -3
                     ticksize -1 0 -1 0
		     fdraft
		     box
		     xla R c^2/GM
		     ltype 0
		     #set max=avgflm
		     #set press=avgen*($gam-1)
		     connect lgnewx1 (LG(ABS(max)))
		     ltype 3
		     connect lgnewx1 (LG(ABS(press)))
		     #device X11
		     #ctype red connect lgnewx1 (-2.45-2*lgnewx1)		     
stressplotg           #
		     erase
                     device postencap plotall.eps
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
stressplot2           #
                     #device postencap stressnew.eps
                     limits x1 -8 -2
                     ticksize 0 0 -1 0
		     lweight 3
		     box
		     xla R c^2/GM
		     ltype 0
		     set max=avgmaxm if((x1>=2.4)&&(x1<=22.68))
		     set rey=avgmaxr if((x1>=2.4)&&(x1<=22.68))
		     set newx1=x1 if((x1>=2.4)&&(x1<=22.68))
		     connect newx1 (LG(ABS(max)))
		     ltype 3
		     connect newx1 (LG(ABS(rey)))
		     #device X11
stressplot3           #
                     #device postencap stressnew.eps
                     limits x1 -3 1
                     ticksize 0 0 -1 0
		     lweight 3
		     box
		     xla R c^2/GM
		     ltype 0
		     set max=avgmaxm if((x1>=2.4)&&(x1<=22.68))
		     set rey=avgmaxr if((x1>=2.4)&&(x1<=22.68))
		     set newx1=x1 if((x1>=2.4)&&(x1<=22.68))
		     connect newx1 (LG(ABS(max/rey)))
		     #device X11
