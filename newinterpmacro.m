dipolecheck 1   #
		#
		define LOGTYPE 0
		fdraft
		#jrdp3duold dump$1
                jrdpcf3duold dump$1
		#
                fieldcalc 0 aphi
		#
                set quickmyuse=(tk==$WHICHLEV && $PLANE==3 ? 1 : 0)
		#
		quickinterp tx2
		quickinterp tj
                quickinterp aphi
                quickinterp bsq
		quickinterp uu0
		#
		readinterp3d tx2
		readinterp3d tj
                readinterp3d aphi
                readinterp3d bsq
		readinterp3d uu0
		#
                plc 0 iaphi
                set godaphi=newfun
                #
                define cres 20
		define missing_data (1E35)
                set goodiaphi = (abs(ibsq)<1E-15) ? $missing_data : iaphi
		erase
                box
                set image[ix,iy] = goodiaphi
                set lev=$min,$max,$delta
                levels lev
                ctype red contour
                #
		plc 0 (-iuu0) 010
                #
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
		#define program "iinterp"
                define program "iinterp.sasha"
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
                if(1){\
		define iixmin -20
		define iixmax 20
		define iiymin -20
		define iiymax 20
		define iizmin 0
		define iizmax 0
                }
		#
                if(0){\
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
		#
myvpl     1 #
		#
		#jrdp3duold dump$1
                jrdpcf3duold dump$1
		grid3d gdump
		#
		set godvx=uu1*sqrt(gv311)/uu0/sqrt(-gv300)
		set godvy=uu2*sqrt(gv322)/uu0/sqrt(-gv300)
		#
		define lengthofvector 6
		vpl 0 godv $lengthofvector 12 100
		#
		fieldcalc 0 aphi
		plc 0 aphi 010
		#
		#
agmyvpl 0       #
		#
                do ii=startanim,endanim,$ANIMSKIP {
		  set h2=sprintf('%04d',$ii)
                  define h2ext (h2)
                  myvpl $h2ext
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
		#
