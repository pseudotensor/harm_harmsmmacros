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
     re "/home/jon/sm/gtwod.m"
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
