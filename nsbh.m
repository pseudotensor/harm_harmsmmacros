loadrmac 0      #
                gogrmhd
                jre kaz.m
                jre grbmodel.m
                jre reconnection_switch.m
                jre axisstuff.m
		jre jetforavery.m
		jre nsbh.m
                #
donsbh1 0       #
		jrdpcf3duentropy dump0000
		fieldcalc 0 aphi
		plc 0 aphi
		#
		jrdpvpot vpotdump0000
		plc 0 Ad3 010
		#
		#
		plc 0 Ad3
		#
		#
		set R=r*sin(h)
		set z=r*cos(h)
		set absrdiff=sqrt( (6-R)**2 + (0-z)**2 )
		set myaphi=(6-R)**2/absrdiff**3
		plc 0 myaphi
		#
		#
		setupdoall 1 1 1 1
		#
		#
setupdoall 4    # setupdoall 1 1 1 1
		#		
		define DOREADS $1
		define DOINTERPS $2
                define DOWRITEPFILES $3
                define DOWRITEALL $4
                #
                !pwd > mydir.txt
                da mydir.txt
                lines 1 1
                read '%s' {mydir}
                define dirprefix (mydir)
                set dumpsdirset = mydir + '/dumps/'
                set idumpsdirset = mydir + '/idumps/'
		#
                define pdumpsdir (dumpsdirset)
                define idumpsdir (idumpsdirset)
                #
                #define pdumpsdir "/data/jon/testnsbh/dumps/"
                #define idumpsdir "/data/jon/testnsbh/idumps/"
                #
		set h0p='$pdumpsdir'
		set h0i='$idumpsdir'
		#		
setupreads 0    #
		if($?DOREADS==0){\
		 define DOREADS 1
		}
		if($?DOINTERPS==0){\
		 define DOINTERPS 1
		}
		if($?DOWRITEPFILES==0){\
		 define DOWRITEPFILES 1
		}
		if($?DOWRITEALL==0){\
		 define DOWRITEALL 1
		}
		#
		# always read header for basic info
		jrdpheader3d dumps/dump0000
		gsetupfromheader
		#
		if($DOREADS){\
		 grid3d gdump
		 jrdpcf3duentropy dump0000
		 readnsin
		}
		#
                set Rinold=Rin
		#
readnsin 0      #
		 #
		 da nscheck.dat
		 lines 1 100000000
		 read {ci 1 cj 2 ck 3 nsin 4 nsshell 5 nsmindist 6 nsmindistc1 7 nsmindistc2 8 nsmindistc3 9 \
		        nsclosei 10 nsclosej 11 nsclosek 12 \
		        nsclosec1i 13 nsclosec1j 14 nsclosec1k 15 \
		        nsclosec2i 16 nsclosec2j 17 nsclosec2k 18 \
		        nsclosec3i 19 nsclosec3j 20 nsclosec3k 21 \
		        }
		 #
actualreads 0   #
		#
		set h1='dump'
		set h3=''
		set h2=sprintf('%04d',$number) set _fname=h1+h2+h3
		define foutr (_fname)
		define filein "$!foutr"
		#
		jrdpcf3duentropy $filein
		#
		#
		#choose A_\phi
		# 1)
		fieldcalc 0 aphi
		# 2)
		set h1='vpotdump'
		set h3=''
		set h2=sprintf('%04d',$number) set _fname=h1+h2+h3
		define foutr (_fname)
		define filein "$!foutr"
		jrdpvpot $filein
		#
		# note Ad3 is at CORN3, so offset from CENT in plot.  But much smoother result than from fieldcalc
		set aphi = Ad3
		#
domany 3        # domany <skip> <start> <end>
		# e.g. domany 1 0 1240
		#
		define ANIMSKIP ($1)
                set startanim=$2
                set endanim=$3
                #
                #
                echo "before do"
                print {startanim endanim}
                echo $ANIMSKIP
                #
                do ii=startanim,endanim,$ANIMSKIP {
                   #
                   echo "just inside do"
                   #
		   doone $ii
		   #
                   #
                }
                #
		#
animatepic 0    # to animate .eps from domany:
		#
		# just for help on command-line, not SM command
		#
		# see /data/jon/latestcode/harmgit/batches
		#
		for fil in `ls pic*.eps`; do echo $fil ; convert -flatten -density 200 -geometry 742x734 -background \#FFFFFF -dispose Background $fil $fil.png ; done
		convert *.png pic.gif
		#
		#
		#
doone 1         # doone <dump number>
		# e.g. doone 0
		#
		#
		setupdo $1
		writeinterpaphi
		#
		interpposes
		interpother
		#
		readiaphi
		#
		setupnewgrid
		#
		define DOPRINT 0
		#
		#reone
		reonemore $1
		#
reonemore 1     #
		#
		if($DOPRINT==1){\
		 set h0='picnew'
		 set h1=sprintf('%04d',$1)
		 set h2='.eps'
		 set _fname=h0+h1+h2
		 define imagename (_fname)
		 device postencap $imagename
		}
		#
		reone
                #
		showns
                #
		if($DOPRINT==1){\
		 device X11
		}
		#
reone 0         # just replot for doone	
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		#
		if(0){\
		 define cres 50
		 plc 0 (abs(iaphi)**0.5)
		}
		#
		if(1){\
		#
		# like checkaphi
		#
		define CONSTLEVELS 1
		set constlevelshit=1
		#define min (-1832.531494)
		#define max (474.8926086)
		define min (0.1)
		define max (abs(474.8926086)**0.5)
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		define cres 64
		plc0 0 (abs(iaphi)**0.5)
		#
		define cres 15
		define CONSTLEVELS 0
		set constlevelshit=0
		#
		}
		#
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "green"
		define cres 15
		plc 0 ilrho 010
		#
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "cyan"
		plc 0 iuu0 010
		#
		define POSCONTCOLOR "magenta"
		define NEGCONTCOLOR "green"
		plc0 0 iomegaf 010
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		#
                #
		showns
                #
		#
showns 0        #
                # circle
                set rns=6.0
                set xns=xpos[0]+rns
                set yns=0
		#set Rns=Rinold
		set Rns=2.0
                #
                set t=0,2*pi,.01
                set x=xns+Rns*sin(t)
                set y=yns+Rns*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
                #
                #shade 0 x y
                #
                lweight 5
                connect x y
                lweight 1
                #
othercomputes 0 #
		#
		set dfdd03=-ud0*bd3 + ud3*bd0
		set Bd3=dfdd03
		#
		faraday
		#
		set omegaf=omegaf2*dxdxp33
		#
		# below for (e.g.) uu3bl, etc.
		processdump
		#
		#
		#
setupdo 1       #		
		define number ($1)
		#
		setupdoall 1 1 1 1
		setupreads
		#
		actualreads
		#
		othercomputes
		#
		# normal x,y,z
		define inx (128) # Cart x
		define iny (1) # Cart y
		define inz (128)   # Cart z
		#
                set myangledeg=90
                define tnrdegrees (0)
		set mytnrdegrees=$tnrdegrees
                #
		if(0){\
		define ixmin (-Rout) # Cart x
		define ixmax (Rout)
		define iymin (-1E-15) # Cart y
		define iymax (1E-15)
		define izmin (-Rout) # Cart z
		define izmax (Rout)
		}
                #
		############ axisymmetry (half-plane)
		if(1){\
		define ixmin (0) # Cart x
		define ixmax (10)
		define iymin (-1E-15) # Cart y
		define iymax (1E-15)
		define izmin (-10) # Cart z
		define izmax (10)
		}
		#
		if(0){\
		define ixmin (0) # Cart x
		define ixmax (22)
		define iymin (-1E-15) # Cart y
		define iymax (1E-15)
		define izmin (-22) # Cart z
		define izmax (22)
		}
		#
		############ FULL 3D
		if(0){\
		define ixmin (-10) # Cart x
		define ixmax (10)
		define iymin (-10) # Cart y
		define iymax (10)
		define izmin (-10) # Cart z
		define izmax (10)
		}
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
		set myiixmin=$iixmin
		set myiixmax=$iixmax
		set myiiymin=$iiymin
		set myiiymax=$iiymax
		set myiizmin=$iizmin
		set myiizmax=$iizmax
		#
		# 
		#
		#define program "/data/jon/latestcode/harmgit/iinterp"
		define program "/data/jon/iinterp"
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
		#
		!mkdir -p $pdumpsdir
		!mkdir -p $idumpsdir
		#
		define print_noheader (1)
		#
		#
writeinterpaphi 0       #		
		#
		#####################################
		#
		set h1='aphi' 
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutrho0 (_fname)
		define fileout "$!foutrho0"
		if($DOWRITEPFILES==1){\
		       writeheader 1 "$!fileout"
		       # from fieldcalc 0 aphi
		       print + "$!fileout" '%g\n' {aphi}
		}
		#
		#
		#
		#####################################
		# now interpolate scalar (aphi)
		set h1='iaphi'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutrho0 (_fname)
		#
		define filein "$!foutrho0"
		define fileout "$!ifoutrho0"
		doscalar $filein $fileout
		#
		define fileiaphi "$!fileout"
		#
		#
		#
readiaphi 0     #
		#
		#####################################
		# read
		jrdpheader3d $fileiaphi
		da $fileiaphi
		lines 2 100000000
		read {iaphi 1}
		#
		#
interpother 0   #
		#
		###############################################################
		set h1='lrho'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
		  print + "$!fileout" '%g\n' {lrho}
		}
		#
		# now interpolate scalar
		set h1='ilrho'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# ####################################
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {ilrho 1}
		#
		#############################################################
		#
		set h1='Bd3'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
                  #                    
		  print + "$!fileout" '%g\n' {Bd3}
		}
		#
		# now interpolate scalar
		set h1='iBd3'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {iBd3 1}
		#
		#############################################################
		#
		set h1='omegaf'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  #
		  print + "$!fileout" '%g\n' {omegaf}
		}
		#
		# now interpolate scalar
		set h1='iomegaf'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {iomegaf 1}
		#
		#############################################################
		#
		set h1='lbrel'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  faraday
		  #
		  print + "$!fileout" '%g\n' {lbrel}
		}
		#
		# now interpolate scalar
		set h1='ilbrel'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {ilbrel 1}
		#
		#######################################################################
		#
		set h1='uu0'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  faraday
		  #
		  print + "$!fileout" '%g\n' {uu0}
		}
		#
		# now interpolate scalar
		set h1='iuu0'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {iuu0 1}
		#
		#######################################################################
		#
		set h1='uu3'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  faraday
		  #
		  print + "$!fileout" '%g\n' {uu3}
		}
		#
		# now interpolate scalar
		set h1='iuu3'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {iuu3 1}
		#
		#######################################################################
		#
		set h1='nsin'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  faraday
		  #
		  print + "$!fileout" '%g\n' {nsin}
		}
		#
		# now interpolate scalar
		set h1='insin'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {insin 1}
		#
		#######################################################################
		#
		set h1='nsshell'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
                  #
		  faraday
		  #
		  print + "$!fileout" '%g\n' {nsshell}
		}
		#
		# now interpolate scalar
		set h1='insshell'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {insshell 1}
		#
		#######################################################################
		#
interpposes 0   #
		#
		set h1='rpos'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutr (_fname)
		define fileout "$!foutr"
		if($DOWRITEPFILES==1){\
		  writeheader 1 "$!fileout"
		  print + "$!fileout" '%g\n' {r}
		}
		#
		# now interpolate scalar
		set h1='ir'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutr (_fname)
		#
		define filein "$!foutr"
		define fileout "$!ifoutr"
		doscalar $filein $fileout
		#
		#
		# ####################################
		# read
		# (only use da instead of jrdpheader3d since don't want to change header info yet!)
		da $fileout
		lines 2 100000000
		read {rpos 1}
		#
		set h1='hpos'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define fouth (_fname)
		define fileout "$!fouth"
		if($DOWRITEPFILES==1){\
		       writeheader 1 "$!fileout"
		       print + "$!fileout" '%g\n' {h}
		    }
		#
		# now interpolate scalar
		set h1='ih'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifouth (_fname)
		#
		define filein "$!fouth"
		define fileout "$!ifouth"
		doscalar $filein $fileout
		#
		# ####################################
		# read
		da $fileout
		lines 2 100000000
		read {hpos 1}
		#
		#
		set h1='phpos'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0p+h1+h2+h3
		define foutph (_fname)
		define fileout "$!foutph"
		if($DOWRITEPFILES==1){\
		       writeheader 1 "$!fileout"
		       print + "$!fileout" '%g\n' {ph}
		}
		#
		# now interpolate scalar
		set h1='iph'
		set h3='.txt'
		set h2=sprintf('%04d',$number) set _fname=h0i+h1+h2+h3
		define ifoutph (_fname)
		#
		define filein "$!foutph"
		define fileout "$!ifoutph"
		doscalar $filein $fileout
		#
		# ####################################
		# read
		da $fileout
		lines 2 100000000
		read {phpos 1}
		#
		#
		#
		#
setupnewgrid 0              #
		#
		#
		#####################################
		# setup contour plotting capability with new grid
		define inx (_n1)
		define iny (_n2)
		define inz (_n3)
		#
		#
		set xpos=rpos*sin(hpos)*cos(phpos)
		set ypos=rpos*sin(hpos)*sin(phpos)
		set zpos=rpos*cos(hpos)
		#
		set Rpos=rpos*sin(hpos)	
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
                define x2label "z c^2/GM"
                define PLANE 3
                define WHICHLEV 0
                #
		#		
		#
doscalar 2              # doscalar $foutrho0 $ifoutrho0
		#
		#define DEFAULTVALUETYPE 4
		define DEFAULTVALUETYPE 0
                #
		if($DOINTERPS){\
		 ! $program -oldargs $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
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
		 ! $program -oldargs $1 $interptype $READHEADERDATA $WRITEHEADERDATA \
                    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi $tnrdegrees \
                               $EXTRAPOLATE $DEFAULTVALUETYPE dumps/gdump < $2 > $3
		 }
		#
		#
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
		# adds to normal dump file: myangledeg mytnrdegrees myiixmin myiixmax myiiymin myiiymax myiizmin myiizmax
		#
		print $2 {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord MBH QBH is ie js je ks ke whichdump whichdumpversion numcolumns myangledeg mytnrdegrees myiixmin myiixmax myiiymin myiiymax myiizmin myiizmax}
		#
		#
checkdiff 0     #
		#
		jrdpcf3duentropy dump0000
		jrdpvpot vpotdump0000
		set rhot0=rho
		set ut0=u
		set uu0t0=uu0
		set uu1t0=uu1
		set uu2t0=uu2
		set uu3t0=uu3
		set B1t0=B1
		set B2t0=B2
		set B3t0=B3
		set Ad1t0=Ad1
		set Ad2t0=Ad2
		set Ad3t0=Ad3
		#
		#
		jrdpcf3duentropy dump0001
		jrdpvpot vpotdump0001
		set rhot1=rho
		set ut1=u
		set uu0t1=uu0
		set uu1t1=uu1
		set uu2t1=uu2
		set uu3t1=uu3
		set B1t1=B1
		set B2t1=B2
		set B3t1=B3
		set Ad1t1=Ad1
		set Ad2t1=Ad2
		set Ad3t1=Ad3
		#
		#
		#plc 0 (rhot0-rho)
		#plc 0 (Ad3t0-Ad3t1)
		plc 0 (B1t0-B1t1)
		#
checkfield 0    #
		#
		set Bx=B1
		set By=B2
		#
		vpl 0 B 1 12 100
		#
compareprob1 0  #
		#
		jrdpcf3duentropy dump0001
		jrdpvpot vpotdump0001
		#
		define cres 20
		plc 0 ((abs(Ad3)**0.5))
		#
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "green"
		define cres 15
		plc 0 lrho 010
		#
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "cyan"
		define cres 15
		plc 0 uu1 010
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
                #
		#
animaphi1 0     #
		set startanim=0
		set endanim=56
		define ANIMSKIP 1
		#
		define cres 50
		#agplc 'dump' (abs(Ad3)**0.5)  001 3 10 0.8 2.3
		#agplc 'dump' uu0  001 3 10 0.8 2.3
		#
		#plc 0 Ad3 001 3 10 0.8 2.3
		#
		#agplc 'dump' (abs(Ad3)**0.5)  001 3 10 0.8 2.3
		#
		#
animaphi2 0     #
		erase
		#
		jrdpvpot vpotdump0000
		set Ad3t0=Ad3
		jrdpvpot vpotdump0001
		define test (1)
		plotnsborder $test
		#
		define CONSTLEVELS 1
		set constlevelshit=1
		define min (-1832.531494)
		define max (474.8926086)
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		define cres 128
		#
		set startanim=0
		set endanim=75
		define ANIMSKIP 1
		agplc 'dump' Ad3  011 3 10 0.8 2.3
		#
		#
checkaphi 1     #
		#
		define PLANE (3)
		define WHICHLEV (0)
		#
		define ii (0)
		#
		set h1='dump'
		set h2=sprintf('%04d',$ii) set _fname=h1+h2
		define filename (_fname)
		#
		set h1='fluxdump' set _fname=h1+h2
		define filenameflux (_fname)
		#
		set h1='debug' set _fname=h1+h2
		define filenamedebug (_fname)
		#
		set h1='vpotdump' set _fname=h1+h2
		define filenamevpot (_fname)
		#
		jrdpcf3duentropy $filename
		#jrdpflux $filenameflux
		jrdpdebug $filenamedebug
		jrdpvpot $filenamevpot
		#
		set Ad3t0=Ad3
		#
		#
		define ii ($1)
		#
		set h1='dump'
		set h2=sprintf('%04d',$ii) set _fname=h1+h2
		define filename (_fname)
		#
		set h1='fluxdump' set _fname=h1+h2
		define filenameflux (_fname)
		#
		set h1='debug' set _fname=h1+h2
		define filenamedebug (_fname)
		#
		set h1='vpotdump' set _fname=h1+h2
		define filenamevpot (_fname)
		#
		grid3d gdump
		#
		jrdpcf3duentropy $filename
		#jrdpflux $filenameflux
		# below used with jrdpcf3duentropy (i.e. NPR==9)
		jrdpfluxfull $filenameflux
		jrdpdebug $filenamedebug
		jrdpvpot $filenamevpot
		#
		#
		othercomputes
		#
		readnsin
		#
		recheckaphiplot $1
		#
plotnsborder 1  #
		#
		define cres 1
		define POSCONTCOLOR "cyan"
		define NEGCONTCOLOR "cyan"
		set Ad3diff=Ad3-Ad3t0
		set god=(abs(Ad3diff)<1E-12 ? 1 : 0)
		#
		plc 0 god 001 3 10 0.8 2.3
		#
		if($1==0){
		   plc 0 nsin 001 3 10 0.8 2.3
		}
		#
		#
		#
recheckaphiplot 1 #
		#
		plotnsborder $1
		#
		if(1){\
		 define cres 15
		 define POSCONTCOLOR "yellow"
		 define CONSTLEVELS 1
		 set constlevelshit=1
		 define min (1)
		 define max (300)
		 define NEGCONTCOLOR "green"
		 plc 0 uu0 011 3 10 0.8 2.3
		 define POSCONTCOLOR "red"
		 define NEGCONTCOLOR "default"
		}
		#
		define CONSTLEVELS 1
		set constlevelshit=1
		define min (-1832.531494)
		define max (474.8926086)
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		define cres 512
		plc0 0 Ad3 011 3 10 0.8 2.3
		#
		define cres 15
		define CONSTLEVELS 0
		set constlevelshit=0
		#
		# 27 24
		#
		#
checksym0       #
		readnsin
		checkaphi 0
		#
		mirrordel2 Ad3
		#
		mirrordel nsin
		#
		mirrordel nssshell
		#
		mirrordel nsmindist
		#
		mirrordel2 nsmindistc3
		#
		mirrordel nsclosei
		#
		mirroradel nsclosej
		#
		mirrordel2 nsclosec1i
		#
		mirrordel2 nsclosec3i
		#
		mirroradel2 nsclosec3j
		#
		#
checks0         #
		#
		checkaphi 3  plc 0 nsin 001 3 10 0.8 2.3 plc0 0 ((dUr27+dUr17)/gdet) 011 3 10 0.8 2.3
		#
		#
		checkaphi 4  plc 0 nsin 001 3 10 0.8 2.3 plc0 0 (B3) 011 3 10 0.8 2.3
		#
		set god1=(nsin==0 ? dUr17/gdet : 0)
		set god2=(nsin==0 ? dUr27/gdet : 0)
		#
		checkaphi 2 set B3diffext=(nsin==0 ? B3-U7/gdet : 0) plc0 0 B3diffext 011 3 10 0.8 2.3
		#
		checkaphi 4  plc 0 nsin 001 3 10 0.8 2.3 plc0 0 ((B1-U5/gdet)/(abs(B1)+abs(U5/gdet))) 011 3 10 0.8 2.3
		#
		#
checkspec 2     # checkspec <dump number> <which thing to plot>
		#
		checkaphi $1
		#
		plc 0 nsin 001 3 10 0.8 2.3
		#
		if($2==0){\
		   set specpr=(nsin==0 ? uu3bl : 0)
		}
		#
		if($2==1){\
		   set specpr=(nsin==0 ? B3 : 0)
		}
		if($2==2){\
		   set specpr=(nsin==0 ? omegaf : 0)
		}
		#
		plc0 0 specpr 011 3 10 0.8 2.3
		#
		#
		# dA_i/dt = EMF_i:
		#
		# dA_2/dt = EMF_2 = v3 B1 - v1 B3
		#
		# dA_1/dt = EMF_1 = v3 B2 - v2 B3 
		#
		#
checkA1 0       #
		checkaphi 2  plc 0 nsin 001 3 10 0.8 2.3 define cres 50 plc0 0 (Ad1) 011 3 10 0.8 2.3
		# too neg
		plc0 0 ((ti-35)*(tj-23)) 011 3 10 0.8 2.3
		# too pos
		plc0 0 ((ti-36)*(tj-25)) 011 3 10 0.8 2.3
		print {_realnstep}
		print {ti tj Ad1 nsin nsshell nsclosec1i nsclosec1j nsclosec1k}
		#
		#
		checkaphi 3  plc 0 nsin 001 3 10 0.8 2.3 define cres 50 plc0 0 (Ad3) 011 3 10 0.8 2.3
		# new kink
		#plc0 0 ((ti-36)*(tj-23)) 011 3 10 0.8 2.3
		#plc0 0 ((ti-36)*(tj-24)) 011 3 10 0.8 2.3
		plc0 0 ((ti-36)*(tj-25)) 011 3 10 0.8 2.3
		print {_realnstep}
		set onboundary=(abs(Ad3-Ad3t0)>1E-12 ? 0 : 1)
		print {ti tj Ad3 onboundary nsin nsshell nsclosec3i nsclosec3j nsclosec3k}
		#
		#
