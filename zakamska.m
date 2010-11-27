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
setupreads 0    #		
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
		#
doall  9        # doall <animskip> <startanim> <endanim> <whichmachine 0=ki-rh42 1=orange 2 =ki-rh39> <myangledeg> <tnrdegrees> <pdumpsdir> <idumpsdir> <res mult>
		#doall 20 0 1660 0 14 7.5 pdumps idumps 1
		#
		#
		# production:
		#
		# doall 20 0 380 0  14 7.5 pdumps idumps 1
		#
		# doall 20 400 780 1 14 7.5 pdumps idumps 1
		# doall 20 800 1180 1 14 7.5 pdumps idumps 1
		# doall 20 1200 1660 1 14 7.5 pdumps idumps 1
		#
                # production new:
                #
                # one-time in rundipole??? dir:
                # !ln -s /u/ki/jmckinne/superdrive/nobackup/zakamska/theta2.5 theta2.5
                # !ln -s /u/ki/jmckinne/superdrive/nobackup/zakamska/theta5.0 theta5.0
                # !ln -s /u/ki/jmckinne/superdrive/nobackup/zakamska/theta10.0 theta10.0
                # !ln -s /u/ki/jmckinne/superdrive/nobackup/zakamska/theta7.5 theta7.5
                #
                #
                # doall 20 0 1660 0 14 7.5 pdumps idumps 1
                #
                # doall 20 0 1660 1 14 2.5 theta2.5/pdumps theta2.5/idumps 1
		# doall 20 0 1660 1 14 5.0 theta5.0/pdumps theta5.0/idumps 1
                # doall 20 0 1660 1 14 10.0 theta10.0/pdumps theta10.0/idumps 1
                # doall 20 0 1660 1 14 0.0 theta0.0/pdumps theta0.0/idumps 1
                #
		#
		# useful for testing (can set createtest below)
                # doall 20 1660 1660 0 14 0 pdumpstest idumpstest 1
		# doall 20 1660 1660 0 45 45 pdumpstest idumpstest 1
		#
                # higher resolution
                # doall 20 0 400 1 14 5.0 theta5.0f2/pdumps theta5.0f2/idumps 2
                # doall 20 420 800 1 14 5.0 theta5.0f2/pdumps theta5.0f2/idumps 2
                # doall 20 820 1200 1 14 5.0 theta5.0f2/pdumps theta5.0f2/idumps 2
                # doall 20 1220 1660 1 14 5.0 theta5.0f2/pdumps theta5.0f2/idumps 2
                #
		setupreads
		#
		# normal x,y,z
		define inx (32*$9)
		define iny (32*$9)
		define inz (128*$9)
		#
		##############
                # choose final box size
                ##############
                # don't choose 1.0 or else will show ragged edges at outer surface of sphere that was interpolated
                #
		#need to capture full jet in Cartesian space
		set zin=-40
		set zout=Rout*0.9
		#set myangledeg=40
		# opening half-angle to show (twice nominal to capture sheath)
		#set myangledeg=10
                #set myangledeg=20
                #set myangledeg=14
                set myangledeg=$5
                #
                # 10 degrees ok for non-rotated case, but need 20 degrees if rotate 7.5-10 if don't change ixmin and ixmax, but now do change it so about 12 degrees is good
		#
                # myangledeg=\pi/4*180/pi=45deg gives myRout=zout
		#
		set myRout=zout*tan(myangledeg*pi/180)
		#
                #define tnrdegrees (2.5)
                #define tnrdegrees (7.5)
                define tnrdegrees ($6)
                #
		# normal x,y,z
		define ixmin (-40*sin($tnrdegrees/myangledeg*pi/2) - (myRout)*cos($tnrdegrees/myangledeg*pi/2))
		define ixmax (2*myRout+$ixmin)
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
                echo $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax
		#
		if($4==0){\
		 define program "iinterp"
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
                define pdumpsdir "$!7/"
                define idumpsdir "$!8/"
		#
		!mkdir -p $pdumpsdir
		!mkdir -p $idumpsdir
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
		   #
		   echo "just inside do"
		   #
		   readonefieldline $ii $DOREADS
		   #
		   writeinterp $ii
		   #
		}
		#
		#
readonefieldline 2 # readonefieldline <dump#> <DOREADSornot>
		   #
		   #
		   # whether to create test data
		   # 0 = no test
		   # 1 = Br only
		   # 2 = Bphi only
		   define createtest 0
		   #
		   #
		   #
                   set h1='dumps/fieldline'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h1+h2+h3
                   define filename (_fname)
		   #
		   echo $filename
                   #
		   #
		   if($2==1){\
		    echo "before da"
		    da $filename
		    jrdpheader3dold $filename
		    lines 2 10000000
		    read {rho0 1 u 2 negud0 3 mu 4 uu0 5 vu1 6 vu2 7 vu3 8 Bu1 9 Bu2 10 Bu3 11}
		    #
		    if($createtest==2){\
		           set Bu1=0*Bu1
		           set Bu2=0*Bu1
		           set Bu3=(1/(r*sin(h)))/sqrt(gv333)*sin(h)**2
		           #
		           #
		    }
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
		    #
		    #
		   }
		   #
		   #
		   #
		   #
otherdiags 0    # can run after doing readonefieldline if checking on things
		#
		# other diagnostic things
		#
		jrdpheader3dold dumps/dump0000.head
		#
		setupplc $nx $ny $nz r h ph
		define LOGTYPE 0
		define x1label "r c^2/GM"
		define x2label "h c^2/GM"
		define PLANE 3
		define WHICHLEV 0
		#
		set bsq=bd0*bu0+bd1*bu1+bd2*bu2+bd3*bu3
		set bsqorho0=bsq/(rho0)
		set lbsqorho0=lg(bsqorho0)
		#
writeinterp 1   #
		#
		   #########
		   # write files and interpolate each file
		   #
		   #
                   set h0p='$pdumpsdir'
                   set h0i='$idumpsdir'
                   #
                   #
                   set h1='rho0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutrho0 (_fname)
		   define fileout "$!foutrho0"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {rho0}
		   #
		   # now interpolate scalar
                   set h1='irho0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutrho0 (_fname)
		   #
		   define filein "$!foutrho0"
		   define fileout "$!ifoutrho0"
		   doscalar $filein $fileout
		   #
		   echo "after rho0"
		   #
                   set h1='u'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutu (_fname)
		   define fileout "$!foutu"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {u}
		   #
		   # now interpolate scalar
                   set h1='iu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutu (_fname)
		   #
		   define filein "$!foutu"
		   define fileout "$!ifoutu"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='uu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutuu (_fname)
		   define fileout "$!foutuu"
		   writeheader 4 "$!fileout"
		   print + "$!fileout" '%g %g %g %g\n' {uu0 uu1 uu2 uu3}
		   #
		   # now interpolate vector
                   set h1='iuu0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutuu0 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu0"
		   dovector 2 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='iuu1'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutuu1 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu1"
		   dovector 3 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='iuu2'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutuu2 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu2"
		   dovector 4 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='iuu3'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutuu3 (_fname)
		   #
		   define filein "$!foutuu"
		   define fileout "$!ifoutuu3"
		   dovector 5 $filein $fileout
		   #
		   #
                   set h1='bu'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutbu (_fname)
		   define fileout "$!foutbu"
		   writeheader 4 "$!fileout"
		   #
		   if($createtest==0){\
		          print + "$!fileout" '%g %g %g %g\n' {bu0 bu1 bu2 bu3}
		       }
                   #
		   if($createtest==2){\
		          print + "$!fileout" '%g %g %g %g\n' {Bu0 Bu1 Bu2 Bu3}
		       }
		   #
		   # now interpolate vector
                   set h1='ibu0'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutbu0 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu0"
		   dovector 2 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='ibu1'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutbu1 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu1"
		   dovector 3 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='ibu2'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutbu2 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu2"
		   dovector 4 $filein $fileout
		   #
		   # now interpolate vector
                   set h1='ibu3'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutbu3 (_fname)
		   #
		   define filein "$!foutbu"
		   define fileout "$!ifoutbu3"
		   dovector 5 $filein $fileout
		   #
		   #
		   #
                   set h1='rpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutr (_fname)
		   define fileout "$!foutr"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {r}
		   #
		   # now interpolate scalar
                   set h1='ir'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutr (_fname)
		   #
		   define filein "$!foutr"
		   define fileout "$!ifoutr"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='hpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define fouth (_fname)
		   define fileout "$!fouth"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {h}
		   #
		   # now interpolate scalar
                   set h1='ih'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifouth (_fname)
		   #
		   define filein "$!fouth"
		   define fileout "$!ifouth"
		   doscalar $filein $fileout
		   #
		   #
                   set h1='phpos'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0p+h1+h2+h3
                   define foutph (_fname)
		   define fileout "$!foutph"
		   writeheader 1 "$!fileout"
		   print + "$!fileout" '%g\n' {ph}
		   #
		   # now interpolate scalar
                   set h1='iph'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutph (_fname)
		   #
		   define filein "$!foutph"
		   define fileout "$!ifoutph"
		   doscalar $filein $fileout
		   #
		   #
		   # now collect all interpolated results into a single file
		   #
                   set h1='iall'
		   set h3='.txt'
                   set h2=sprintf('%04d',$1) set _fname=h0i+h1+h2+h3
                   define ifoutall (_fname)
		   #
                   define tempdir "temp.$!1/"
                   #
                   mkdir $tempdir
                   #
		   ! head -1 "$!ifoutrho0" > $tempdir/headtemp.$1.txt
		   ! tail -n +2 "$!ifoutrho0" > $tempdir/temp1.$1.txt
		   ! tail -n +2 "$!ifoutu" > $tempdir/temp2.$1.txt
		   ! tail -n +2 "$!ifoutuu0" > $tempdir/temp3.$1.txt
		   ! tail -n +2 "$!ifoutuu1" > $tempdir/temp4.$1.txt
		   ! tail -n +2 "$!ifoutuu2" > $tempdir/temp5.$1.txt
		   ! tail -n +2 "$!ifoutuu3" > $tempdir/temp6.$1.txt
		   ! tail -n +2 "$!ifoutbu0" > $tempdir/temp7.$1.txt
		   ! tail -n +2 "$!ifoutbu1" > $tempdir/temp8.$1.txt
		   ! tail -n +2 "$!ifoutbu2" > $tempdir/temp9.$1.txt
		   ! tail -n +2 "$!ifoutbu3" > $tempdir/temp10.$1.txt
		   ! tail -n +2 "$!ifoutr" > $tempdir/temp11.$1.txt
		   ! tail -n +2 "$!ifouth" > $tempdir/temp12.$1.txt
		   ! tail -n +2 "$!ifoutph" > $tempdir/temp13.$1.txt
		   #
		   ! cat $tempdir/headtemp.$1.txt > "$!ifoutall"
		   ! paste $tempdir/temp1.$1.txt $tempdir/temp2.$1.txt $tempdir/temp3.$1.txt $tempdir/temp4.$1.txt $tempdir/temp5.$1.txt $tempdir/temp6.$1.txt $tempdir/temp7.$1.txt $tempdir/temp8.$1.txt $tempdir/temp9.$1.txt $tempdir/temp10.$1.txt $tempdir/temp11.$1.txt $tempdir/temp12.$1.txt $tempdir/temp13.$1.txt > $tempdir/tempall.$1.txt
		   ! cat $tempdir/tempall.$1.txt >> "$!ifoutall"
		   #
		   # remove temp files
		   ##! rm -rf headtemp.$1.txt temp1.$1.txt temp2.$1.txt temp3.$1.txt temp4.$1.txt temp5.$1.txt temp6.$1.txt temp7.$1.txt temp8.$1.txt temp9.$1.txt temp10.$1.txt temp11.$1.txt temp12.$1.txt temp13.$1.txt
                   #
                   rm -rf $tempdir
		   #
		   #
		   #
		#
doscalar 2	# doscalar $foutrho0 $ifoutrho0
		#
		#define DEFAULTVALUETYPE 4
		define DEFAULTVALUETYPE 0
                #
		if($DOINTERPS){\
		 ! $program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
		    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi \
                               $tnrdegrees $EXTRAPOLATE $DEFAULTVALUETYPE < $1 > $2
		}    
		#    
		#
dovector 3      # dovector <2,3,4,5> $foutbu $ifoutbu3
		#
		#define DEFAULTVALUETYPE 4
		if($1==2){\
	         define DEFAULTVALUETYPE 1
		}
		#
		if($1>2){\
		 define DEFAULTVALUETYPE 0
		}
		#
		if($DOINTERPS){\
		 ! $program $1 $interptype $READHEADERDATA $WRITEHEADERDATA \
                    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi $tnrdegrees \
                               $EXTRAPOLATE $DEFAULTVALUETYPE dumps/gdump < $2 > $3
		 }
		#
		#
		#
		#
		#
		#
checkresult 2   # checkresult <dump number> <idumpsdir>
		#
		define ii ($1)
		#
                define idumpsdir "$!2/"
                set h0i='$idumpsdir'
                #
		set h1='iall'
		set h3='.txt'
		set h2=sprintf('%04d',$ii) set _fname=h0i+h1+h2+h3
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
                # Notice the order is Cartesian x z y (inx/y/z just SM labels for grid cell numbers in x/z/y directions -- respectively in order)
		setupplc $inx $iny $inz xpos zpos ypos
		define LOGTYPE 0
		define x1label "x c^2/GM"
                define x2label "y c^2/GM"
                define PLANE 2
                define WHICHLEV 0
                #
		# ihat = sin(h)*cos(ph)*rhat + cos(h)*cos(ph)*hhat - sin(ph)*phhat
		# jhat = sin(h)*sin(ph)*rhat + cos(h)*sin(ph)*hhat + cos(ph)*phhat
		# khat = cos(h)        *rhat - sin(h)        *hhat
		#
		# rhat = sin(h)*cos(ph)*ihat + sin(h)*sin(ph)*jhat + cos(h)*khat
		# hhat = cos(h)*cos(ph)*ihat + cos(h)*sin(ph)*jhat - sin(h)*khat
		# phhat= -sin(h)*ihat + cos(ph)*jhat
		#
		set ibrhat =ibu1*(sin(hpos)*cos(phpos))+ibu2*(sin(hpos)*sin(phpos))+ibu3*(cos(hpos))
		set ibhhat =ibu1*(cos(hpos)*cos(phpos))+ibu2*(cos(hpos)*sin(phpos))-ibu3*(sin(hpos))
		set ibphhat=ibu1*(-sin(phpos))         +ibu2*(cos(phpos))
		#
		set ibsq=-ibu0**2+ibu1**2+ibu2**2+ibu3**2
		set ibsqorho0=ibsq/irho0
		set ilbsqorho0=lg(ibsqorho0)
		#
		set iurhat =iuu1*(sin(hpos)*cos(phpos))+iuu2*(sin(hpos)*sin(phpos))+iuu3*(cos(hpos))
		set iuhhat =iuu1*(cos(hpos)*cos(phpos))+iuu2*(cos(hpos)*sin(phpos))-iuu3*(sin(hpos))
		set iuphhat=iuu1*(-sin(phpos))         +iuu2*(cos(phpos))
		#
		set udotb=-iuu0*ibu0 + iuu1*ibu1 + iuu2*ibu2 + iuu3*ibu3
		set udotu=-iuu0*iuu0 + iuu1*iuu1 + iuu2*iuu2 + iuu3*iuu3
		#
plotscheck 0    #
		plc 0 irho0
		#
		agzplc 0 irho0
		#
		#
                agzplc 0 ibsqorho0
                #
                agzplc 0 ilbsqorho0
                #
                #
		set vecx=ibu1
		set vecy=ibu2
		set vecz=ibu3
		#
		#define UNITVECTOR 1
		#define SKIPFACTOR 1
		vpl 0 vec 1 12 100
		#
		#
