loadrmac 0      #
                gogrmhd
                jre kaz.m
                jre grbmodel.m
                jre reconnection_switch.m
                jre axisstuff.m
		jre zakamska.m
                #
writeheader 2   # writeheader <numcolumns> <filename with path>
		#
		# should be as needed by jon_interp, not as read-in by files
		#
		set MBH=1
		set QBH=0
		set is=0
		set ie=_n1
		set js=0
		set je=_n2
		set ks=0
		set ke=_n3
		set whichdump=0
		set whichdumpversion=1
		set numcolumns=$1
		#
		print $2 {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord MBH QBH is ie js je ks ke whichdump whichdumpversion numcolumns}
		#
		#
		#
		#
		#
doall  4        # doall <animskip> <startanim> <endanim> <whichmachine 0=ki-rh42 1=orange 2 =ki-rh39>
		#doall 20 0 1660 0
		#
		# doall 20 1200 1660 1
		# doall 20 800 1200 1
		# doall 20 400 800 1
		#
		define DOREADS 1
		define DOINTERPS 1
		#
		if($DOREADS){\
		 jrdpheader3dold dumps/dump0000.head
		 grid3d gdump
		 jrdpcf3dudipole dump0000
		}
		#
		# normal x,y,z
		define inx 32
		define iny 32
		define inz 128
		#
		##############
                # choose final box size
                ##############
                # don't choose 1.0 or else will show ragged edges at outer surface of sphere that was interpolated
                #
		#need to capture full jet in Cartesian space
		set zin=-40
		set zout=Rout*0.9
		set myangledeg=40
		set myRout=zout*tan(myangledeg*pi/180)
		#
		# normal x,y,z
		define ixmin (-myRout)
		define ixmax (myRout)
		define iymin (-myRout)
		define iymax (myRout)
		define izmin (zin)
		# avoid going out to boundary to avoid artifacts right at outer boundary
		define izmax (zout)
		#
		######################################
                # startxc,endxc, etc. for iinterp
                # iinterp has x->xc y->zc z->yc since originally was doing 2D in x-z
		define iinx ($inx)
                define iiny ($inz)
                define iinz ($iny)
                #
                define iixmin ($ixmin)
                define iixmax ($ixmax)
                define iiymin ($izmin)
                define iiymax ($izmax)
                define iizmin ($iymin)
                define iizmax ($iymax)
                #
		#
		if($4==0){\
		 define program "./iinterp"
		}
		if($4==1){\
		 define program "/u/ki/jmckinne/bin/iinterp.orange"
		}
		if($4==2){\
		 define program "/u/ki/jmckinne/bin/iinterp.rh39"
		}
		#
		define DATATYPE 1
		define EXTRAPOLATE 0
		define interptype 1
		define READHEADERDATA 1
		define WRITEHEADERDATA 1
		define refinement 1.0
		define dofull2pi 1
		define igrid 0
		define iRin (_Rin)
                define iRout (_Rout)
                define ihslope (_hslope)
                define idt (_dt)
                define iR0 (_R0)
		#
		define idefcoord (_defcoord)
                define oldgrid (1)
                define doing3d ($nz>1)
                define doing2d (!$doing3d)
                #
		#
		# 31 args to iinterp
		#
		!mkdir -p pdumps/
		!mkdir -p idumps/
		#
		define print_noheader (1)
		#
		# 20 0 1660
		define ANIMSKIP ($1)
		set startanim=$2
		set endanim=$3
		#
		# normal run:
		#define ANIMSKIP 20
		#set startanim=0
		#set endanim=1660
		#
		# test:
		#set startanim=1500
		#set endanim=1500
		#
		echo "before do"
		print {startanim endanim}
		echo $ANIMSKIP
		#
		echo "very before do"
		#
		do ii=startanim,endanim,$ANIMSKIP {
		   echo "just inside do"
		   #
                   set h1='dumps/fieldline'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define filename (_fname)
		   #
                   #
		   #
		   if ($DOREADS){\
		    echo "before da"
		    da $filename
		    jrdpheader3dold $filename
		    lines 2 10000000
		    read {rho0 1 u 2 negud0 3 mu 4 uu0 5 vu1 6 vu2 7 vu3 8 Bu1 9 Bu2 10 Bu3 11}
		    #
		    #
		    set Bu0=0*Bu1
		    #
		    # limit gamma
		    set maxgam=4.5
		    set uu0=(uu0>maxgam && r>10 ? maxgam : uu0)
		    set uu1=vu1*uu0
		    set uu2=vu2*uu0
		    set uu3=vu3*uu0
		    #
		    #
		    set ud0=gv300*uu0+gv310*uu1+gv320*uu2+gv330*uu3
		    set ud1=gv301*uu0+gv311*uu1+gv321*uu2+gv331*uu3
		    set ud2=gv302*uu0+gv312*uu1+gv322*uu2+gv332*uu3
		    set ud3=gv303*uu0+gv313*uu1+gv323*uu2+gv333*uu3
		    #
		    set udotB=ud0*Bu0 + ud1*Bu1 + ud2*Bu2 + ud3*Bu3
		    #
		    set bu0=(Bu0 + udotB*uu0)/uu0
		    set bu1=(Bu1 + udotB*uu1)/uu0
		    set bu2=(Bu2 + udotB*uu2)/uu0
		    set bu3=(Bu3 + udotB*uu3)/uu0
		    #
		    set bd0=gv300*bu0+gv310*bu1+gv320*bu2+gv330*bu3
		    set bd1=gv301*bu0+gv311*bu1+gv321*bu2+gv331*bu3
		    set bd2=gv302*bu0+gv312*bu1+gv322*bu2+gv332*bu3
		    set bd3=gv303*bu0+gv313*bu1+gv323*bu2+gv333*bu3
		   }
		   #
		   writeinterp
		   #
		}
		#
writeinterp 0   #
		#
		   #########
		   # write files and interpolate each file
		   #
		   #
                   set h1='pdumps/rho0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutrho0 (_fname)
		   define fileout "$!foutrho0"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {rho0}
		   #
		   # now interpolate scalar
                   set h1='idumps/irho0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutrho0 (_fname)
		   #
		   define filein "$!foutrho0"
		   define fileout "$!ifoutrho0"
		   doscalar $filein $fileout
		   #
		   echo "after rho0"
		   #
                   set h1='pdumps/u'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutu (_fname)
		   define fileout "$!foutu"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {u}
		   #
		   # now interpolate scalar
                   set h1='idumps/iu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutu (_fname)
		   #
		   define filein "$!foutu"
		   define fileout "$!ifoutu"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='pdumps/uu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutuu (_fname)
		   define fileout "$!foutuu"
		   writeheader 4 "$!fileout"
		   print + "$!fileout" '%g %g %g %g\n' {uu0 uu1 uu2 uu3}
		   #
		   # now interpolate vector
                   set h1='idumps/iuu0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutuu0 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu0"
		   dovector 2 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/iuu1'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutuu1 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu1"
		   dovector 3 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/iuu2'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutuu2 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu2"
		   dovector 4 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/iuu3'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutuu3 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu3"
		   dovector 5 $filein $fileout
		   #
		   #
                   set h1='pdumps/bu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutbu (_fname)
		   define fileout "$!foutbu"
		   writeheader 4 "$!fileout"
		   print + "$!fileout" '%g %g %g %g\n' {bu0 bu1 bu2 bu3}
		   #
		   # now interpolate vector
                   set h1='idumps/ibu0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutbu0 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu0"
		   dovector 2 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/ibu1'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutbu1 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu1"
		   dovector 3 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/ibu2'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutbu2 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu2"
		   dovector 4 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='idumps/ibu3'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutbu3 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu3"
		   dovector 5 $filein $fileout
		   #
		   #
		   #
                   set h1='pdumps/rpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutr (_fname)
		   define fileout "$!foutr"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {r}
		   #
		   # now interpolate scalar
                   set h1='idumps/ir'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutr (_fname)
		   #
		   define filein "$!foutr"
		   define fileout "$!ifoutr"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='pdumps/hpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define fouth (_fname)
		   define fileout "$!fouth"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {h}
		   #
		   # now interpolate scalar
                   set h1='idumps/ih'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifouth (_fname)
		   #
		   define filein "$!fouth"
		   define fileout "$!ifouth"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='pdumps/phpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define foutph (_fname)
		   define fileout "$!foutph"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {ph}
		   #
		   # now interpolate scalar
                   set h1='idumps/iph'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutph (_fname)
		   #
		   define filein "$!foutph"
		   define fileout "$!ifoutph"
		   doscalar $filein $fileout
		   #
		   #
		   # now collect all interpolated results into a single file
		   #
                   set h1='idumps/iall'
		   set h3='.txt'
                   set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
                   define ifoutall (_fname)
		   #
		   ! head -1 "$!ifoutrho0" > headtemp.$ii.txt
		   ! tail -n +2 "$!ifoutrho0" > temp1.$ii.txt
		   ! tail -n +2 "$!ifoutu" > temp2.$ii.txt
		   ! tail -n +2 "$!ifoutuu0" > temp3.$ii.txt
		   ! tail -n +2 "$!ifoutuu1" > temp4.$ii.txt
		   ! tail -n +2 "$!ifoutuu2" > temp5.$ii.txt
		   ! tail -n +2 "$!ifoutuu3" > temp6.$ii.txt
		   ! tail -n +2 "$!ifoutbu0" > temp7.$ii.txt
		   ! tail -n +2 "$!ifoutbu1" > temp8.$ii.txt
		   ! tail -n +2 "$!ifoutbu2" > temp9.$ii.txt
		   ! tail -n +2 "$!ifoutbu3" > temp10.$ii.txt
		   ! tail -n +2 "$!ifoutr" > temp11.$ii.txt
		   ! tail -n +2 "$!ifouth" > temp12.$ii.txt
		   ! tail -n +2 "$!ifoutph" > temp13.$ii.txt
		   #
		   ! cat headtemp.$ii.txt > "$!ifoutall"
		   ! paste temp1.$ii.txt temp2.$ii.txt temp3.$ii.txt temp4.$ii.txt temp5.$ii.txt temp6.$ii.txt temp7.$ii.txt temp8.$ii.txt temp9.$ii.txt temp10.$ii.txt temp11.$ii.txt temp12.$ii.txt temp13.$ii.txt > tempall.$ii.txt
		   ! cat tempall.$ii.txt >> "$!ifoutall"
		   #
		   # remove temp files
		   ##! rm -rf headtemp.$ii.txt temp1.$ii.txt temp2.$ii.txt temp3.$ii.txt temp4.$ii.txt temp5.$ii.txt temp6.$ii.txt temp7.$ii.txt temp8.$ii.txt temp9.$ii.txt temp10.$ii.txt temp11.$ii.txt temp12.$ii.txt temp13.$ii.txt
		   #
		   #
		   #
		#
doscalar 2	# doscalar $foutrho0 $ifoutrho0
		#
		#define DEFAULTVALUETYPE 4
		define DEFAULTVALUETYPE 0
		if($DOINTERPS){\
		 ! $program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
		    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi $EXTRAPOLATE $DEFAULTVALUETYPE < $1 > $2
		}    
		#    
		#
dovector 3      # dovector <2,3,4,5> $foutbu $ifoutbu3
		#
		#define DEFAULTVALUETYPE 4
		if($1==0){\
	         define DEFAULTVALUETYPE 1
		}
		#
		if($1>0){\
		 define DEFAULTVALUETYPE 0
		}
		#
		if($DOINTERPS){\
		 ! $program $1 $interptype $READHEADERDATA $WRITEHEADERDATA \
                    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi $EXTRAPOLATE $DEFAULTVALUETYPE dumps/gdump < $2 > $3
		 }
		#
		#
checkresult 1   # checkresult <dump number>
		#
		define ii ($1)
		#
		set h1='idumps/iall'
		set h3='.txt'
		set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3
		define filename (_fname)
		#
		jrdpheader3dold $filename
		da $filename
		lines 2 100000000
		read {irho0 1 iu 2 iuu0 3 iuu1 4 iuu2 5 iuu3 6 ibu0 7 ibu1 8 ibu2 9 ibu3 10 rpos 11 hpos 12 phpos 13}
		#
		#
		define inx (_n1)
		define iny (_n2)
		define inz (_n3)
		#
		set xpos=rpos*sin(hpos)*cos(phpos)
		set ypos=rpos*sin(hpos)*sin(phpos)
		set zpos=rpos*cos(hpos)
		#
		trueminmax xpos xpos
		set xpos[0]=truemin
		set xpos[dimen(xpos)-1]=truemax
		#
		#
		trueminmax ypos ypos
		set ypos[0]=truemin
		set ypos[dimen(ypos)-1]=truemax
		#
		#
		trueminmax zpos zpos
		set zpos[0]=truemin
		set zpos[dimen(zpos)-1]=truemax
		#
		setupplc $inx $iny $inz xpos zpos ypos
		define LOGTYPE 0
		define x1label "x c^2/GM"
                define x2label "z c^2/GM"
                define PLANE 2
                define WHICHLEV 0
                #
		#
plotscheck 0    #
		plc 0 irho0
		#
		agzplc 0 irho0
		#
		#
