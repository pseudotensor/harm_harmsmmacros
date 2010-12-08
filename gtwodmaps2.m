rdmacros 0           #
		jre gtwodmaps2.m
		#
setupareamap   8
                     # original nx,ny given as size parameter, which means
		     # total nx,ny is +1 that since includes fail point too
                     define nx ($1+1+$2)
                     define ny ($3+1+$4)
                     define tnx ($5)
                     define tny ($6)
                     define ifail ($7)
                     define jfail ($8)
		     define nz 1
		     set x12=i
		     set x1=x12
		     set dx1=1,$nx,1
		     set dx1=dx1/dx1
		     set dx12=dx1
		     #
		     set x22=j
		     set x2=x22
                     set dx2=dx1
		     set dx22=dx2
		     #
		     set x3=x1*0
		     set x32=x3
		     set dx3=dx1*0
		     set dx32=dx3
		     #
		     define Sx (-$1+$ifail)
		     define Ex ($ifail+$2)
                     define Sy (-$3+$jfail)
                     define Ey ($jfail+$4)
                     define Sz (1)
                     define dx (1)
                     define dy (1)
                     define dz (1)
                     define Lx ($Ex-$Sx+1)
                     define Ly ($Ey-$Sy+1)
                     define Lz (1)
                     # redefine nx,ny
                     define nx ($Lx)
                     define ny ($Ly)
                     define ncpux1 1
		     define ncpux2 1
		     define ncpux3 1
		     define interp (0)
                     define coord (1)
	             define x1label "i"
	             define x2label "j"
	#       
rdareamap 1 #
     da $1
     lines 1 1
     #read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7 _size1 8 _size2 9 _ifail 10 _jfail 11}
		set _a=0.5
		set _R0=0
		set _Rin=1.96
		set _Rout=80
		set _hslope=0.2
		set _gam=4/3
     #read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7 _size1 8 _size2 9 _ifail 10 _jfail 11}
     #
     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
         {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 \
	    _sizelx1 _sizeux1 _sizelx2 _sizeux2 _ifail _jfail \
	    _gam _a _R0 _Rin _Rout _hslope}
     #
     lines 2 10000000		     
     read {ti 1 tj 2 \
	   x1 3 x2 4 r 5 h 6 rho 7 u 8 v1 9 v2 10 v3 11 \
	   B1 12 B2 13 B3 14 divb 15 \
	   uu0 16 uu1 17 uu2 18 uu3 19 ud0 20 ud1 21 ud2 22 ud3 23 \
	   bu0 24 bu1 25 bu2 26 bu3 27 bd0 28 bd1 29 bd2 30 bd3 31 \
	   v1m 32 v1p 33 v2m 34 v2p 35 gdet 36 \
	   t 37 realnstep 38}
     #
     set urat1=uu1*ud1/(uu0*ud0)
     set urat2=uu2*ud2/(uu0*ud0)
     set urat3=uu3*ud3/(uu0*ud0)
     set rhorat=rho*(r**2)*10**3
     set urat=u*(r**3)*(10**5)
     re "$!HOME/sm/gtwod.m"
     gsetup
     gcalc
     #
     # assumes i,j range all same for all time, else move to pickmap
     set i=ti if(realnstep==realnstep[0])
     set j=tj if(realnstep==realnstep[0])
     set k=i*0
     setupareamap _sizelx1 _sizeux1 _sizelx2 _sizeux2 _n1 _n2 _ifail _jfail
     setanim
     NOTATION -4 4 -4 4
     #
setanim 0 #
     set startanim=realnstep[0]
     set endanim=realnstep[dimen(realnstep)-1]
pickmap 3      #
     set timepre=t if($1==realnstep)
     define time (timepre[0])
     set steppre=realnstep if(($1==realnstep))
     define nstep (steppre[0])
     #
     set $3=$2 if(realnstep==$1)
     #
markfail 0
     relocate $ifail $jfail
     ctype cyan
     label "X"
     ctype red
     set failboxx=0,4,1
     set failboxy=0,4,1
     #
     set failboxx[0]=$ifail-0.5
     set failboxy[0]=$jfail-0.5
     # 
     #
     set failboxx[1]=$ifail+0.5
     set failboxy[1]=$jfail-0.5
     # 
     #
     set failboxx[2]=$ifail+0.5
     set failboxy[2]=$jfail+0.5
     # 
     #
     set failboxx[3]=$ifail-0.5
     set failboxy[3]=$jfail+0.5
     # 
     set failboxx[4]=$ifail-0.5
     set failboxy[4]=$jfail-0.5
     # 
     connect failboxx failboxy
     #
marktime 0
     relocate (15000 31500)
     label time=$time nstep=$nstep
     #
animmapc 16      # animmap <variablename> 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
                define PLANE (3)
                define WHICHLEV (0)
                do ii=startanim,endanim,$ANIMSKIP {
                  pickmap $ii $1 new$1
		  ctype default
                  if($numsend==2){ plc  0 new$1}\
                  else{\
                   if($numsend==3){  plc  0 new$1 $2}\
                   else{\
                    if($numsend==4){ plc  0 new$1 $2 $3 $4 $5 $6}
                   }
                  }
		  marktime
		  markfail
                  #delay loop
                  set jj=0
                  while {jj<100} {set jj=jj+1}
                }
animmaps 16      # animmap <variablename> 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
                define PLANE (3)
                define WHICHLEV (0)
                do ii=startanim,endanim,$ANIMSKIP {
                  pickmap $ii $1 new$1
		  ctype default
                  if($numsend==2){ pls  0 new$1}\
                  else{\
                   if($numsend==3){  pls  0 new$1 $2}\
                   else{\
                    if($numsend==4){ pls  0 new$1 $2 $3 $4 $5 $6}
                   }
                  }
		  marktime
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
                }
setupfrdot   1
                     # original nx,ny given as size parameter, which means
		     # total nx,ny is +1 that since includes fail point too
                     define nx ($1)
                     define ny (1)
                     define tnx ($1)
                     define tny (1)
		     define nz 1
		     set x12=i
		     set x1=x12
		     set dx1=1,$nx,1
		     set dx1=dx1/dx1
		     set dx12=dx1
		     #
		     set x22=x1*0
		     set x2=x22
                     set dx2=dx1*0
		     set dx22=dx2
		     #
		     set x3=x1*0
		     set x32=x3
		     set dx3=dx1*0
		     set dx32=dx3
		     #
                     define Sx (0)
		     define Sy (1)
                     define Sz (1)
                     define dx (1)
                     define dy (1)
                     define dz (1)
                     define Lx ($nx)
                     define Ly (1)
                     define Lz (1)
                     # redefine nx,ny
                     define nx ($Lx)
                     define ny ($Ly)
                     define ncpux1 1
		     define ncpux2 1
		     define ncpux3 1
		     define interp (0)
                     define coord (1)
	             define x1label "i"
	             define x2label "flux"
	#       
rdfrdot 1 #
     da $1
     lines 1 1
     read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
     lines 2 10000000
     read '%g %d %g %g %g %g %g %g %g %g' {t ti \
		u0dot u1dot u2dot u3dot u4dot u5dot u6dot u7dot}
     #
     # assumes i,j range all same for all time, else move to pickmap
     set i=ti if(t==t[0])
     set j=i*0
     set k=i*0
     # approx
     set treal=t if(ti==0)
     set ireal=ti if(t==t[0])
     # only works if dt0>1
     define dt0 (INT(treal[1]-treal[0]))
     set tfake=INT(t)
     set realnstep=INT(tfake/$dt0)
     setupfrdot _n1
     setanim
     NOTATION -4 4 -4 4
     #
animfrpl	17	#
                if($?3 == 0) { define numsend (3) }\
                else{\
                  if($?4 == 1) { define numsend (5) } else { define numsend 4 }
                }
                do ii=startanim,endanim,$ANIMSKIP {
		  pickmap $ii $2 new$2
                  if($numsend==3){ pl 0 $1 new$2}\
                  else{\
                   if($numsend==4){  pl  0 $1 new$2 $3}\
                   else{\
                    if($numsend==5){ pl  0 $1 new$2 $3 $4 $5 $6 $7}
                   }
                  }
		  marktime
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
rdprobe 1 #
		da $1
		lines 1 100000000
		read {pii 1 pjj 2 pkk 3 ppr 4 pstep 5 pt 6 pp 7}
		set piilist=pii if((pjj==pjj[0])&&(pkk==pkk[0])&&(ppr==ppr[0])&&(pstep==pstep[0]))
		set pjjlist=pjj if((pii==pii[0])&&(pkk==pkk[0])&&(ppr==ppr[0])&&(pstep==pstep[0]))
		set pkklist=pkk if((pii==pii[0])&&(pjj==pjj[0])&&(ppr==ppr[0])&&(pstep==pstep[0]))
		set pprlist=ppr if((pii==pii[0])&&(pjj==pjj[0])&&(pkk==pkk[0])&&(pstep==pstep[0]))
		set numperlist=((pii==pii[0])&&(pjj==pjj[0])&&(ppr==ppr[0])) ? 1 : 0
		set numper=SUM(numperlist)
		printprobe
printprobe 0 # 
		print {piilist pjjlist pkklist pprlist}
pickprobe 4     #
		# pickprobe <i> <j> <k> <prim>
		# 
		set use=((pii==$1)&&(pjj==$2)&&(pkk==$3)&&(ppr==$4)) ? 1 : 0
		set pri=pii if(use)
		set prj=pjj if(use)
		set prk=pkk if(use)
		set prpr=ppr if(use)
		set prstep=pstep if(use)
		set prt=pt if(use)
		set pr=pp if(use)
		#
		if(dimen(r)>1){\
		       echo "Setting pickr"
		       set pickindex=pri[0]+prj[0]*$nx+prk[0]*$nx*$ny
		       set pickr=r[pickindex]
		       set pickh=h[pickindex]
		       set pickph=ph[pickindex]
		}
		#
overlayprobe 0  #
		plc 0 lrho
		#
		#
		do iii=0,dimen(piilist)-1,1 {\
		 do jjj=0,dimen(pjjlist)-1,1 {\
		       set xpos=$txl+($txh-$txl)/$nx*piilist[$iii]
		       set ypos=$tyl+($tyh-$tyl)/$ny*pjjlist[$jjj]
		       define myxpos (xpos)
		       define myypos (ypos)
		       relocate $myxpos $myypos
		       #define mylabel (sprintf('%d',$iii)+'x'+sprintf('%d',$jjj))
 		       define mypii (piilist[$iii])
 		       define mypjj (pjjlist[$jjj])
		       define mylabel (sprintf('%d',$mypii)+'x'+sprintf('%d',$mypjj))
		       expand 0.4 ctype cyan putlabel 5 $mylabel
		       expand 1.01
		 }
		}
		#
showallfft 13   #
		if($?1 == 1) {\
		 define startiii ($1)
		 define startjjj ($2)
		 define startkkk ($3)
		}\
		     else {\
		        define startiii (0)
		        define startjjj (0)
		        define startkkk (0)
		     }
		     #
		do kkk=$startkkk,dimen(pklist)-1 {\
		            set avgfft$kkk=0,numper/2,1
		            set avgfft$kkk=avgfft$kkk*0
		         }
		         #
		do iii=$startiii,dimen(pilist)-1 {\
		   do jjj=$startjjj,dimen(pjlist)-1 {\
		      do kkk=$startkkk,dimen(pklist)-1 {\
		        #if($kkk==0){\
		         echo doing $iii $jjj $kkk
		         define temp1 (pilist[$iii])
		         define temp2 (pjlist[$jjj])
		         define temp3 (pklist[$kkk])
		         echo $iii $jjj $kkk
		         echo pi $temp1 pj $temp2 pk $temp3
		         showfft  $temp1 $temp2 $temp3
		         set avgfft$kkk=avgfft$kkk+rpow/(SUM(rpow))
		         # delay loop
		         #set jj=0
		         #while {jj<=100000} { set jj=jj+1 }
		         #
		      #}
		      }
		   }
		}
		#
calcfreqs1    0 #
		set omegakrisco=1/(risco**(3/2)+a)
		set frisco=omegakrisco/(2*pi)
		#
		set omegakrisco2=1/(risco2**(3/2)+a)
		set frisco2=omegakrisco2/(2*pi)
		#
		set omegak6=1/(6**(3/2)+a)
		set f6=omegak6/(2*pi)
		#
		set omegakr=1/(pickr**(3/2)+a)
		set fradius=omegakr/(2*pi)
		#
		set Gconst=6.670E-8
		set Cconst=2.99792458E10
		set msun=1.989E33
		set Mass=14*msun
		set tlunit=Gconst*Mass/Cconst**3
		# 113 and 168 Hz in GM=c=1 units:
		set lllowernu=41*tlunit
		set llowernu=67*tlunit
		set lowernu=113*tlunit
		set uppernu=168*tlunit
		#
		set fupper=uppernu
		set flower=lowernu
		set fllower=llowernu
		set flllower=lllowernu
		#
		#
		#
showlinfreqs1 0 #
		#
		calcfreqs1
		#
		ctype red vertline (frisco/fradius)
		ctype blue vertline (frisco2/fradius)
		ctype yellow vertline (fupper/fradius)
		ctype green vertline (flower/fradius)
		ctype yellow red (fllower/fradius)
		ctype green red (flllower/fradius)
		ctype cyan vertline (f6/fradius)
		ctype default
		#
showlogfreqs1 0 #
		#
		set lfrisco=lg(frisco/fradius)
		set lfrisco2=lg(frisco2/fradius)
		set lfupper=lg(fupper/fradius)
		set lflower=lg(flower/fradius)
		set lfllower=lg(fllower/fradius)
		set lflllower=lg(flllower/fradius)
		set lf6=lg(f6/fradius)
		set lfradius=lg(fradius/fradius)
		#
		ctype red vertline lfrisco
		ctype blue vertline lfrisco2
		ctype yellow vertline lfupper
		ctype green vertline lflower
		ctype red vertline lfllower
		ctype red vertline lflllower
		ctype cyan vertline lf6
		ctype default
		#
showfftlim 3      #
		#
		calcfreqs1
		#
		#
		fftreallim 1 prt $1 freq pow $2 $3
		set rfreq=freq/fradius if(freq>0)
		set rpow=pow if(freq>0)
		smooth rpow rpows50 50
		smooth rpow rpows10 10
		smooth rpow rpows5 5
		#
		define x1label "f/f_r"
		define x2label "Power"
		#
		ctype default pl 0 rfreq rpow 1100
		#ctype red pl 0 rfreq rpows10 1100
		ctype red pl 0 rfreq rpows10 1110
		ctype blue pl 0 rfreq rpows5 1110
		ctype cyan pl 0 rfreq rpows50 1110
		showlogfreqs1
		#
		#set pickpoint=dimen(rpow)-1
		set pickpoint=0
		ctype yellow pl 0 rfreq (rpows10[pickpoint]*(rfreq/rfreq[pickpoint])**(-2)) 1110
		#
		#
showfft 7       # showfft <pickprobe args> <reducfactor> <startfactor> <endfactor>
		#
		pickprobe $1 $2 $3 $4
		#
		set reducef=$5
		define totalreduce (reducef-1)
		set size=dimen(prt)
		set start=size*$6
		set end=size*$7
		#
		set newsize=(size-start)/reducef
		#
		set rpowsum=0,newsize/2-1,1
		set rpowsum=rpowsum*0
		#
		set indext=0,size-1,1
		#
		#
		do iiii=0,reducef-1,1 {
		   echo reducing $iiii out of $totalreduce
		   set result=((indext-start>$iiii)&&(indext-end<0)&&((indext-start)%reducef==$iiii)) ? 1 : 0
		   set prt$iiii=prt if(result)
		   set pr$iiii=pr if(result)
		   set newsizetemp=dimen(prt$iiii)
		   set indextnew=0,newsizetemp-1,1
		   set prt$iiii=prt$iiii if(indextnew<newsize)
		   set pr$iiii=pr$iiii if(indextnew<newsize)
		   #
		   # now it's chopped and reduced, let's fft it
		   #
		   set trueend=dimen(prt$iiii)-1
		   fftreallim 1 prt$iiii pr$iiii freqtemp powtemp 0 trueend
		   set rfreqtemp=freqtemp/fradius if(freqtemp>0)
		   set rpowtemp=powtemp if(freqtemp>0)
		   set rpowsum=rpowsum+rpowtemp
		   set dimen1=dimen(rpowtemp)
		   set dimen2=dimen(rpowsum)
		   print {dimen1 dimen2}
		   ctype default pl 0 rfreqtemp rpowtemp 1100
		}
		set rpow=rpowsum/reducef
		set rfreq=rfreqtemp
		#
		plotshowfft
		#
plotshowfft     0 #
		#
		calcfreqs1
		#
		define x1label "f/f_r"
		define x2label "Power"
		#
		ctype default pl 0 rfreq rpow 1100
		smooth rpow rpows 10
		ctype red pl 0 rfreq rpows 1110
		#ctype cyan pl 0 rfreq rpows 1100
		ctype default
		showlogfreqs1
		#showlinfreqs1
		#
		#
		# a full sweep sonogram
sonogramc 1     # sonogramc 50
		# continuous sonogram
		#
		set size=dimen(pr)-1
		set sonogrampow=1,(size-$1)*($1/2),1
		set sonogrampow=sonogrampow*0
		#
		do iii=0,size-$1-1,1 {\
		       set start=$iii
		       set end=start+$1
		       fftreallim 1 prt pr freq pow start end
		       set rfreq=freq/fradius if(freq>0)
		       set rpow=pow if(freq>0)
		       #
		       do jjj=0,$1/2-1,1 {\
		        set sonogrampow[$iii*$1/2+$jjj]=rpow[$jjj]
		       }
		       echo $iii
		}
		#
sonogram 1      # sonogram 50
		# chopped sonogram
		#
		set size=dimen(pr)-1
		set sonogrampow=1,(size/$1)*($1/2),1
		set sonogrampow=sonogrampow*0
		#
		do iii=0,size/$1-1,1 {\
		       set start=$iii*$1
		       set end=start+$1
		       fftreallim 1 prt pr freq pow start end
		       set rfreq=freq/fradius if(freq>0)
		       set rpow=pow if(freq>0)
		       #
		       do jjj=0,$1/2-1,1 {\
		        set sonogrampow[$iii*$1/2+$jjj]=rpow[$jjj]
		       }
		       echo $iii
		}
		#
printsonogram 0 #
		define print_noheader (1)
		print sonogram.dat {sonogrampow}
		set sonogramlogpow=lg(sonogrampow)
		print sonogramlog.dat {sonogramlogpow}
		#
showsonogram 2  # showsonogram sonogrampow 50
		define snx ($2/2)
		define sny (INT(dimen(sonogrampow)/$snx))
		set ii=0,$snx*$sny-1
		set ix = ii%$snx
		set iy = int(ii/$snx)
		define txl (rfreq[0])
		define txh (rfreq[$2/2-1])
		define tyl (prt[0])
		define tyh (prt[dimen(prt)-1])
		image ($snx,$sny) $txl $txh $tyl $tyh
		set image[ix,iy] = LG($1)
		#
		erase
		minmax min max
		echo "min:"$min "max:"$max
		limits $txl $txh $tyl $tyh
		if($cres>0) { set lev=$min,$max,($max-$min)/$cres }
		if($cres<0) { set lev=$min,$max,-$cres }
		levels lev
		ltype 0
		ctype default
		contour
		box
		#
		#
lastgtwodmaps 0 #
		#
		#
