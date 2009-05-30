checkpower1 0   #
		#
		jrdp3du dump0055
                #
                #
		plc 0 lbrel 
		stresscalc 1
		#
		#plc 0 Tud10
                #
		set myuse0=(i==0) ? 1 : 0
		set mflux=-rho*uu1*gdet if(myuse0)
                #
                #set myuse=myuse0
		#set myuse=(i==30) ? 1 : 0
		#set myuse=(i==128) ? 1 : 0
                set myuse=(i==200) ? 1 : 0
		#set myuse=(i==$nx-1) ? 1 : 0
                #
		set emflux=-Tud10EM*gdet if(myuse)
		set totflux=-Tud10*gdet if(myuse)
		set ratem=SUM(emflux)/SUM(mflux)
		set rattot=SUM(totflux)/SUM(mflux)
		# positive is outward
		print {ratem rattot}
		#
		#
		#
		# quad results:
		# i==0:     -0.001944     -0.9309
		# i==30:     0.005527     -0.9603
		# i==$nx-1: -0.001543     -0.9846
		#
		#
		# dipole results:
		# i==0:      0.01941       -0.89
		# i==30:     0.034     -0.7688
                # i=128:     0.029     8.0
                # i=200:     0.01893   0.5
		# i==$nx-1   -0.2228      -1.689
		#
		#
                #
getbrelavg 0    #
		# obtain averaged swath so that \phi integration makes sense for all points (otherwise hits on zeroes)
		#
		set brelavg=brel*0
		do ii=0,$nx-1,1 {
		   do jj=0,$ny-1,1 {
		      set mybrel=(ti==$ii && tj==$jj ? brel : 0)
		      set temp=SUM(mybrel)/$nz
		      do kk=0,$nz-1,1 {
		         set brelavg[$ii+$jj*$nx+$kk*$nx*$ny]=temp
		      }
		   }
		}
		#
checkmmodes 0   #
		#
		set z=r*cos(h)
		#
		#
		# do for each radius
		#
		set powf0=1,$nx,1
		set powf0=powf0*0
		set powf1=powf0*0
		set powf2=powf0*0
		set powf3=powf0*0
		set powf4=powf0*0
		set newr=powf0*0
		#
		#set myuse=(brel>1.0 && z>=30 && z<=50 && h<20/180*pi ? 1 : 0)
		#set myuse=(brel>1.0 && z>=850 && z<=900 && h<20/180*pi ? 1 : 0)
		#
		#set myuse=(brel>1.0 ? 1 : 0)
		#
		#
		set myuse=(brelavg>1.0 ? 1 : 0)
		#
		do ii=0,$nx-1,1 {
		   #
		   echo $ii of $nx
		   #
		   #
		   set myusefinal=(myuse==1 && ti==$ii ? 1 : 0)
		   set myfunc=r*sin(h)*B3
		   #set myfunc=rho
		   #set myfunc=u
		   #set myfunc=uu0
		   #set myfunc=bsq
		   #
		   set f=myfunc*myusefinal
		   #
		   set newr[$ii] = r[$ii+0+0]
		   #
		   set m=0
		   set powf0[$ii]=sqrt(SUM(f*cos(m*ph))**2 + SUM(f*sin(m*ph))**2)
		   set ref0=powf0[$ii]
		   #
		   set m=1
		   set powf1[$ii]=sqrt(SUM(f*cos(m*ph))**2 + SUM(f*sin(m*ph))**2)/ref0
		   #
		   set m=2
		   set powf2[$ii]=sqrt(SUM(f*cos(m*ph))**2 + SUM(f*sin(m*ph))**2)/ref0
		   #
		   set m=3
		   set powf3[$ii]=sqrt(SUM(f*cos(m*ph))**2 + SUM(f*sin(m*ph))**2)/ref0
		   #
		   set m=4
		   set powf4[$ii]=sqrt(SUM(f*cos(m*ph))**2 + SUM(f*sin(m*ph))**2)/ref0
		   #
		   #print {powf1 powf2 powf3 powf4}
		   #
		   # rho large radii: 0.1914       0.02613    0.0114      0.03652
		   # rho small radii: 0.04284      0.1183     0.03451     0.05448
		   #
		}
		#
plotmmodesvsr 0 #		
		#
		fdraft
		define x1label "z c^2/GM"
		define x2label "Power"
		#
		ctype red ltype 0 pl 0 newr powf0 1101 1 1E3 1E-3 1
		ctype default ltype 0 pl 0 newr powf1 1111 1 1E3 1E-3 1
		ctype default ltype 1 pl 0 newr powf2 1111 1 1E3 1E-3 1
		ctype default ltype 2 pl 0 newr powf3 1111 1 1E3 1E-3 1
		ctype default ltype 3 pl 0 newr powf4 1111 1 1E3 1E-3 1
		#
		set myi=$nx-30
		set mypowf0=powf0[myi]
		set mypowf1=powf1[myi]
		set mypowf2=powf2[myi]
		set mypowf3=powf3[myi]
		set mypowf4=powf4[myi]
		print {mypowf0 mypowf1 mypowf2 mypowf3 mypowf4}
		#
		#
		# uu0: 0.03705     0.01825    0.005354    0.002239 ($nx*4/5)
		# uu0  0.05657     0.03612     0.00476    0.002352 ($nx-20)
		# bsq: 7.719e-06     0.07332     0.01335    0.006711    0.005542
		# rho: 1.562e-06      0.3708     0.06813     0.03699     0.04162
		# u:   1.4e-06      0.2011      0.1315     0.07249     0.05755
		#
		#
checkpt 0       # poloidal vs. toroidal fields
		#
		#
		#
		# /u/ki/jmckinne/nfsslac/lonestar.runs/runlocaldipole3dfiducial
		#
		jrdp3du dump0055
		#
		da dumps/gdump
		lines 2 10000000
		read { dxdxp00 111 dxdxp11 116 dxdxp12 117 dxdxp21 120 dxdxp22 121 dxdxp33 126 }
		#
		# inverse of dx^{ks}/dx^{mks}
                set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
                set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
                set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
                set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
		#
		set Bd1=bd1*ud0-bd0*ud1
                set Bd2=bd2*ud0-bd0*ud2
                set Bd3=bd3*ud0-bd0*ud3
                #
		#
		set B1ks=B1*dxdxp11+B2*dxdxp12
                set B2ks=B1*dxdxp21+B2*dxdxp22
                set B3ks=B3*dxdxp33
		#
		#set ud0ks=ud0
                #set ud1ks=ud1*idxdxp11+ud2*idxdxp21
                #set ud2ks=ud1*idxdxp12+ud2*idxdxp22
                #set ud3ks=ud3
                #
                set Bd1ks=Bd1*idxdxp11+Bd2*idxdxp21
                set Bd2ks=Bd1*idxdxp12+Bd2*idxdxp22
                set Bd3ks=Bd3
		#
		set B1hat=sqrt(abs(Bd1ks*B1ks))
		set B2hat=sqrt(abs(Bd2ks*B2ks))
		set B3hat=sqrt(abs(Bd3ks*B3ks))
                #
                #
                set Bphat=sqrt(B1hat**2+B2hat**2)
                set rat=B3hat/Bphat
                #
                #
checkdpdr 0     #
		#
		set lgp=lg(p)
		#
		set myuse=(abs(h-1.0)<0.05 ? 1 : 0)
		set myr=r if(myuse)
		set mylp=lgp if(myuse)
		#
		pl 0 myr mylp 1000
		#
		#
                #
aspectcheck 0   # aspect ratio
		#
		# /u/ki/jmckinne/nfsslac/lonestar.runs/runlocaldipole3dfiducial
		#
		jrdp3du dump0055
		#
		da dumps/gdump
		lines 2 10000000
		read { dxdxp00 111 dxdxp11 116 dxdxp12 117 dxdxp21 120 dxdxp22 121 dxdxp33 126 }
		#
		# approximate, and good enough near BH
		set dr=dxdxp11*$dx1
		set dh=dxdxp22*$dx2
		set dp=dxdxp33*$dx3
		#
bzcheck 0       #
		#
		define LOGTYPE 0
		fdraft
		jrdp3du dump0113
		#
		#
		set quickmyuse=(tk==$WHICHLEV && $PLANE==3 ? 1 : 0)
		#
		set rho1=rho
		quickinterp rho1
		#
		quickinterp lbrel
		#
		set B1=B1 if(quickmyuse)
		set B2=B2 if(quickmyuse)
		set B3=B3 if(quickmyuse)
		set B3=B3 if(quickmyuse)
		set gdet=gdet if(quickmyuse)
		# data is in "2D" form
		fieldcalc 0 aphi
		quickinterp aphi
		#
		# read data and change data format
		readinterp3d rho1
		readinterp3d lbrel
		readinterp3d aphi
		#
		# PLOTS:
		device postencap rho_aphi.eps
		# plot 1:
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 irho1
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 iaphi 010
		#
		# circle
		set t=0,2*pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#
		device X11
		#
		#
		device postencap lbrel_aphi.eps
		# plot 2:
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 ilbrel
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 iaphi 010
		#
		# circle
		set t=0,2*pi,.01
		set x=$rhor*sin(t)
		set y=$rhor*cos(t)
		set x=x concat $(x[0])
		set y=y concat $(y[0])
		shade 0 x y
		connect x y
		#
		device X11
		#
		!scp lbrel_aphi.eps rho_aphi.eps jon@ki-rh42:
		#
		#
quickinterp 1
		define missing_data (1E35)
		#
		define DATATYPE 1
                define interptype (1)
		define program "iinterp"
		define EXTRAPOLATE 1
		define DEFAULTVALUETYPE 0
		define refinement (1.0)
                #
		define program "iinterp"
		define iRin (_Rin)
                define iRout (_Rout)
                define ihslope (_hslope)
                define idt (_dt)
                define iR0 (_R0)
                #
		define READHEADERDATA 1
		define WRITEHEADERDATA 1
		#
		define WRITEHEADER 0
		define igrid (0)
		#
		define idefcoord (_defcoord)
		define oldgrid (1)
		#
		define inx ($nx)
		define iny ($ny)
		define inz 1
		#
		define nx ($nx)
		define ny ($ny)
		define nz 1
		#
		define iinx (256)
		define iiny (256)
		define iinz 1
		#
                if(0){\
		define iixmin -20
		define iixmax 20
		define iiymin -20
		define iiymax 20
		define iizmin 0
		define iizmax 0
                }
		#
                if(1){\
		define iixmin -2
		define iixmax 2
		define iiymin -2
		define iiymax 2
		define iizmin 0
		define iizmax 0
                }
		#
		set myn1=_n1
		set myn2=_n2
		set myn3=1
		#
		define print_noheader (1)
		print "dumps/$!!1" {_t myn1 myn2 myn3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH}
		#
		# pluck out a single slice
		set todump = $1 if(quickmyuse)
		#
		print + "dumps/$!!1" '%21.15g\n' {todump}
                !~/sm/$program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
		    $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
		    $iinx $iiny $iinz  $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope  $idefcoord $EXTRAPOLATE $DEFAULTVALUETYPE < dumps/$1 > dumps/i$1
		    #
	        #
checkgrid 0     #
		#
		define LOGTYPE 0
		fdraft
		jrdp3du dump0066
		#
		#
		set quickmyuse=(tk==$WHICHLEV && $PLANE==3 ? 1 : 0)
		#
		jre courant.m
		courantharm
		#
		quickinterp tx2
		quickinterp tj
		quickinterp idtx1
		quickinterp idtx2
		quickinterp idtx3
		#
		readinterp3d tx2
		readinterp3d tj
		readinterp3d idtx1
		readinterp3d idtx2
		readinterp3d idtx3
		#
		plc 0 iidtx3
		#
		#
		
