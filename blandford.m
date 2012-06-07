# 
# for making movies of field lines see fieldline.m
#
		# General comments:
		# Ensure all files created are unique!
		# Use > unless really want to append with >>

setupaphi 0   #
		#  
		#!scp jmckinne@ki-rh39:sm/blandford.m ~/sm/ 
		#gogrmhd
		#jre blandford.m
		#
                setupbasicdirs
		#
		# differentiate between these two models
		# then add M!=0 modification
		#
		#
		jrdp3du dump0000
		#
		set rshift=4
                set rpower=3/4
		set myr=(r+rshift)**rpower
		set myz=myr*cos(h)
		set myR=myr*sin(h)
		set myvert = (h>pi/2) ? (myr*sin(h)) : (myr*sin(-h))
		#
		set hother=pi-h
		set mypow=4
		setgpara h mypow myr gparalow
                setgpara hother mypow myr gparahigh
		set mygpara=(h<pi/2) ? gparalow : gparahigh
		#
		# GOOD:
		#set aphi=mygpara
		#set aphi=mygpara*cos(h)*sin(h)**2
		set aphi=mygpara*cos(h)
		#set aphi=myvert*cos(h)
		#set aphi=myR*cos(h)
                #
		# BAD:
		#set aphi=myvert
		#
		#
		define cres 40
		interps3d aphi 64 128 0 5 -5 5
		readinterp3d aphi
		plc 0 iaphi
		#
		if(1){\
                 set Rinold=$rhor*1.00
                 # circle
                 set t=0,2*pi,.01
                 set x=Rinold*sin(t)
                 set y=Rinold*cos(t)
                 set x=x concat $(x[0])
                 set y=y concat $(y[0])
                 shade 0 x y
                 connect x y
                }
                #
		#
		#
		#
setgpara 4      # setgpara h 1 myr gpara
		set fneg=1-cos($1)**($2)
		set fpos=1+cos($1)**($2)
		set $4=0.5*($3*fneg + 2.0*fpos*(1-LN(fpos)))
                set $4=$4 - 2*(1-ln(2))
		#
testswitch 0    #              
                set aphilower=(1-cos(h)**4)
                set aphiupper=(1-cos(pi-h)**4)
                set aphi=(h<pi/2) ? aphilower : aphiupper
                set aphi=aphi*cos(h)
                plc 0 aphi
		#
		#
		#################################################################################
		#
		# below is latest super-viz process macros, above were tests
		#
gofield1 6       #
                #
                load3dmacros
                #
                # dir started in
                !pwd
                #
                #
		define truestart ($1)
		define truefinish ($2)
                define trueskip ($3)
		###################
		# global parms
		define do3dwalltemp ($4)
		set do3dwallvar=$do3dwalltemp
		define do3dwall (do3dwallvar)
		###########################
		# final 2D movie size
		define trueflinx ($5)
		define truefliny ($6)
		#
		echo "gofield1: $!1 $!2 $!3 $!4 $!5 $!6"
		#
		vis5dmakeallgen $truestart $truefinish $trueskip
                #
                #
load3dmacros 0  #
		#
		gogrmhd
		jre fieldline.m
		jre blandford.m
		#
vis5dmakeall 0  #
		#
		define truestart (200)
		define truefinish (200)
                define trueskip (1)
		# global parms
		define do3dwall (0)
		define trueflinx (1024)
		define truefliny (768)
		#
                #
		vis5dmakeallgen $truestart $truefinish $trueskip
                #
                #
                #
		#
		makev5dppmfli 'im0p0s0l'
		#
		#
vis5dmakeallgen 3  # vis5dmakeallgen 0 1 1
		#
		define truefinish (1239)
		#
		# can open 4 SM sessions and run in each the below to get 4 parallel processes going
		# vis5dmakeallgen 0 $truefinish 4
		# vis5dmakeallgen 1 $truefinish 4
 		# vis5dmakeallgen 2 $truefinish 4
		# vis5dmakeallgen 3 $truefinish 4
		# then run on *1* session: makev5dppmfli 'im0p0s0l'
		#
		#
		####################
		# setup
		vis5dpremake
		#
		#####################
		# loop over images
		set start=$1
		set finish=$2
		define ANIMSKIP $3
		#
		do ii=start,finish,$ANIMSKIP {
		   #
                   vis5dmakeallparts 'im0p0s0l' $ii
                }
                #
vis5dpremake 0  #
		# THINGS TO SET:
		# 1) FIDUCIAL
		# 2) DOINTERP, etc.
		# 3) Box size (ixmin, etc.)
		#
		#cd /data/jon/orange3d
		#
                set _MBH=1
                set _QBH=0
		jrdpheader3dold dumps/dump0000.head
                #
		gsetup
		gammienew
		#
		echo "post data header read"
		#
		setupbasicdirs
		#setupresolutions # only for SM renderings!  Overwrites flinx and fliny
		#
                # directories should be consistent with all .sh files
		define iimagesdir "./iimages/"
		define v5ddir "./v5d/"
		define ppmdir "./v5dppm/"
		define ppmrefinedir "./v5dppmrefine/"
		!mkdir -p $iimagesdir
		!mkdir -p $v5ddir
		!mkdir -p $ppmdir
		!mkdir -p $ppmrefinedir
                !mkdir -p $idumpsdir
		#
                ####################
                # specify whether do image (0) or fieldline+position from dumps (1) input/output
                #
		#
                define DOFIELDOUTPUT 1
                echo "DOFIELDOUTPUT: $!DOFIELDOUTPUT"
		#
		##########################
		# interpolated 3D size
		#
		define FIDUCIAL 1
                echo "FIDUCIAL: $!FIDUCIAL"
		#
		if($FIDUCIAL==1){\
		       # 128x128x128 very slow for bicubic and fieldline -- data is also huge
                       # 128^3 ok for bilinear as long as enough data space
		       # caution: vis5d's trajectory can get stuck in long trajectories when resolution too low
		       define inx 128
		       define iny 128
		       define inz 256
		    }
                  #
		if($FIDUCIAL==3){\
                  # for super-high res single frame
		       define inx 256
		       define iny 256
		       define inz 256
		    }
                  #
		if($FIDUCIAL==2){\
                       define inx 256
		       define iny 256
		       define inz 2
		    }
                #
		# for testing:
		if($FIDUCIAL==0){\
		       define inx 32
		       define iny 32
		       define inz 32
		    }
		#
		###########################
		# final 2D movie size (if not already defined)
		if($?trueflinx){\
		   define flinx ($trueflinx)
		}
		#
		if($?truefliny){\
		   define fliny ($truefliny)
		}
		#
                #
		#
                # control each stage in case repeat and don't want to repeat all stages
		#
                define DOINTERPSTAGE 1
                define DOV5DSTAGE 1
		# only need below 2 turned on if just redoing visualization within vis5d scripts
                define DOV5D2PPMSTAGE 1
                define DOREFINESTAGE 1
		#
		echo "DOINTERPSTAGE: $!DOINTERPSTAGE"
		echo "DOV5DSTAGE: $!DOV5DSTAGE"
		echo "DOV5D2PPMSTAGE: $!DOV5D2PPMSTAGE"
		echo "DOREFINESTAGE: $!DOREFINESTAGE"
                #
                #
                #############################
                # specify whether to remove temporary files
		define removetempfiles 1
		echo "removetempfiles: $!removetempfiles"
		#
                #############################
                # whether to remove pre-interpolated things
		define removepreinterp 1
		echo "removepreinterp: $!removepreinterp"
		#
                #############################
                # specify whether to remove final interpolated data dump (can be large, so be careful -- v5d file much smaller)
		define removeinterpolateddump 1
		echo "removeinterpolateddump: $!removeinterpolateddump"
		#
		############################
		# specify if to remove non-refined image
		define removeppm 1
		echo "removeppm: $!removeppm"
		#
                #############################
                # specify whether to remove final v5d file (usually keep!!!)
		define removefinalv5dfile 0
		echo "removefinalv5dfile: $!removefinalv5dfile"
		#
                #
		##############
		# choose final box size
		##############
                # don't choose 1.0 or else will show ragged edges at outer surface of sphere that was interpolated
		#
		#set fracrout=0.95
		# used below to avoid having outer edge on grid at all
                if(1){\
                      # used for quadrapolar model
		 set fracrout=0.57
		 define ixmin (-_Rout*fracrout)
		 define ixmax (_Rout*fracrout)
		 define iymin (-_Rout*fracrout)
		 define iymax (_Rout*fracrout)
		 define izmin (-_Rout*fracrout)
		 define izmax (_Rout*fracrout)
                }
		#
                if(0){\
		 #
                 set myRout=1E3*tan(10*pi/180)
		 #
		 # so changing iymin&iymax changes z-direction
		 define ixmin (-myRout)
		 define ixmax (myRout)
		 define iymin (-myRout)
		 define iymax (myRout)
		 define izmin (-40.0)
		 # avoid going out to boundary to avoid artifacts right at outer boundary
		 define izmax (1E3*0.9)
                }
		#
                if(0){\
                      # used for inner dipolar model
		 #
                 set myRout=100.0
		 define ixmin (-myRout)
		 define ixmax (myRout)
		 define iymin (-myRout)
		 define iymax (myRout)
		 define izmin (-myRout)
		 define izmax (myRout)
                }
		#
                if(0){\
                      # used for large-scale dipolar model
		 #
                 set myRout=1E3*0.9*tan(20*pi/180)
		 #
		 # so changing iymin&iymax changes z-direction
		 define ixmin (-myRout)
		 define ixmax (myRout)
		 define iymin (-myRout)
		 define iymax (myRout)
		 define izmin (5.0)
		 # avoid going out to boundary to avoid artifacts right at outer boundary
		 define izmax (1E3*0.9)
                }
		#
                if(0){\
		 #
                 set myRout=1E3*0.9*tan(20*pi/180)
		 #
		 # so changing iymin&iymax changes z-direction
		 define ixmin (-myRout)
		 define ixmax (myRout)
		 define iymin (-myRout)
		 define iymax (myRout)
		 define izmin (1E3*0.89)
		 define izmax (1E3*0.9)
                }
		#
                # new parameters for new iinterp code, but not important here
                define nt (1)
                define iint ($nt)
                define iitmin (0)
                define iitmax (0)
                define dofull2pi (1)
                define tnrdegrees (0)
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
		################################################
		# stick to fake coords as far as V5D knows
		# rescale by z-extent
		# $v5din? are not used so far since reordering occurs in bin2txt when making v5d
		define v5dinx ($inx)
		define v5diny ($inz)
		define v5dinz ($iny)
		#
		set bottom=(($izmax-$izmin)*0.5)
		#
		set meanx=(($ixmax+$ixmin)*0.5)
		set meany=(($iymax+$iymin)*0.5)
		set meanz=(($izmax+$izmin)*0.5)
		#
                # +\hat{x} = V5D(row) = V5D(x)
                # +\hat{y} = V5D(height) = V5D(z)
                # +\hat{z} = -V5D(col) = -V5D(y)
                #
                #
		# True x is V5D's x and iinterp's x
		set _v5dixmin=($ixmin-meanx)/bottom
		define v5dixmin (_v5dixmin)
		set _v5dixmax=($ixmax-meanx)/bottom
		define v5dixmax (_v5dixmax)
		#
		# True z is V5D's y and iinterp's y
		set _v5diymin=($izmin-meanz)/bottom
		define v5diymin (_v5diymin)
		set _v5diymax=($izmax-meanz)/bottom
		define v5diymax (_v5diymax)
		#
		# True y is V5D's z and iinterp's z
		set _v5dizmin=($iymin-meany)/bottom
		define v5dizmin (_v5dizmin)
		set _v5dizmax=($iymax-meany)/bottom
		define v5dizmax (_v5dizmax)
		#
		echo "begin minmax in x,y,z:"
		echo $ixmin $ixmax $iymin $iymax $izmin $izmax
		echo $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax
		echo $v5dixmin $v5dixmax $v5diymin $v5diymax $v5dizmin $v5dizmax
		echo "end minmax"
		#
field2singlecol 1  # field2singlecol 0
		#
		if($DOINTERPSTAGE){\
		 #
		 #########################
		 # convert fieldline binary to text
		 #
		 convertsingle 'fieldline' $1
		 #
		 set h2=sprintf('%04d',$1)
		 define numext (h2)
		 #
		 # now data is readable using readfline in fieldline.m that has data as:
		 # {rho u negud0 gammainf uu0 vu1 vu2 vu3 B1 B2 B3}
		 # data in $idumpsdir/fieldline????
		 #
		 # just use awk to parse fieldline data directly as required
		 # $fnamefcs is from convertsingle
		 !sh breakfieldline.sh $fnamefcs "$!idumpsdir/rho$!numext" \
		     "$!idumpsdir/u$!numext" "$!idumpsdir/negud0$!numext" \
		     "$!idumpsdir/gammainf$!numext" "$!idumpsdir/uu0$!numext" "$!idumpsdir/vu1$!numext" \
		     "$!idumpsdir/vu2$!numext" "$!idumpsdir/vu3$!numext" "$!idumpsdir/B1$!numext" \
		     "$!idumpsdir/B2$!numext" "$!idumpsdir/B3$!numext" \
		     "$!idumpsdir/dpdw$!numext" "$!idumpsdir/Bd3$!numext" 
		 #
		 #
		 if($removepreinterp==1){\
		 !rm -rf $fnamefcs
		 }
		 # 
		 #  DON'T USE BELOW LINE
		 #  oldfieldwrite
		 #
		}
		#
		# still must set below
		define DIDFIELDLINESPLIT (1)
		#
		#
dump2singlecol 1  # dump2singlecol 0
		#
		set h2=sprintf('%04d',$1)
		define numext (h2)
		#
		if($DOINTERPSTAGE){\
		 #
                 echo "GODMARK: should create appropriate link from dumps to origdumpsused"
                 echo "e.g. ln -s dumps origdumpsused"
		 # avoid slow system's drive 
		 #set h1old='$dumpsdir'
		 set h1old='origdumpsused/'
		 #
		 set h2old='dump'
		 set h3old=''
		 #set hnum=sprintf('%04d',$1)
		 # use below for static r,h,ph
		 set hnum=sprintf('%04d',0)
		 #
		 #setup read filename
		 set _fname=h1old+h2old+hnum+h3old
		 define filenameold (_fname)
		 #
		 # just use awk to parse fieldline data directly as required
		 !sh breakdump.sh $!numext $filenameold "$!idumpsdir/posr$!numext" \
		     "$!idumpsdir/posh$!numext" "$!idumpsdir/posph$!numext"
		 #      
		 #
		 #
		}
		#
		# still must set below
		define DIDDUMPSPLIT (1)
		#
		#
oldfieldwrite 0 #
		# AVOIDED NOW
		#
		readfline fieldline$numext
		#
		#
		# get gdet from gdump file
		#da $dumpsdir/gdump
		# skip header
		#lines 2 100000000
		# 74 is gn300
		# 106 is gdet
		#read gdet 106
		#
		# compute things used to form trajectories (i.e. thing that is integrated)
		#set gdetvu1=gdet*$dx1*vu1
		#set gdetvu2=gdet*$dx2*vu2
		#set gdetvu3=gdet*$dx3*vu3
		# 
		# compute things used to form trajectories (i.e. thing that is integrated)
		#set gdetB1=gdet*$dx1*B1
		#set gdetB2=gdet*$dx2*B2
		#set gdetB3=gdet*$dx3*B3
		#
		# create a single file per quantity so can interpolate to Cartesian grid
		#
		define print_noheader (1)
		#
		print "$!idumpsdir/rho$!numext" '%21.15g\n' {rho}
		print "$!idumpsdir/u$!numext" '%21.15g\n' {u}
		print "$!idumpsdir/negud0$!numext" '%21.15g\n' {negud0}
		print "$!idumpsdir/hud0$!numext" '%21.15g\n' {hud0}
		print "$!idumpsdir/gammainf$!numext" '%21.15g\n' {gammainf}
		print "$!idumpsdir/uu0$!numext" '%21.15g\n' {uu0}
		print "$!idumpsdir/vu1$!numext" '%21.15g %21.15g %21.15g\n' {vu1 vu2 vu3}
		print "$!idumpsdir/vu2$!numext" '%21.15g %21.15g %21.15g\n' {vu1 vu2 vu3}
		print "$!idumpsdir/vu3$!numext" '%21.15g %21.15g %21.15g\n' {vu1 vu2 vu3}
		print "$!idumpsdir/B1$!numext" '%21.15g %21.15g %21.15g\n' {B1 B2 B3}
		print "$!idumpsdir/B2$!numext" '%21.15g %21.15g %21.15g\n' {B1 B2 B3}
		print "$!idumpsdir/B3$!numext" '%21.15g %21.15g %21.15g\n' {B1 B2 B3}
		print "$!idumpsdir/dpdw$!numext"\
                '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' {uu0 vu1 vu2 vu3 B1 B2 B3}
		print "$!idumpsdir/Bd3$!numext" '%21.15g %21.15g %21.15g\n' {B1 B2 B3}
		#
		#
vis5dmakeallparts 2 # vis5dmakeallparts 'im0p0s0l' 0
		#
		vis5dmakepart1 $1 $2
		vis5dmakepart2 $1 $2
		vis5dmakepart3 $1 $2
		vis5dmakepart4 $1 $2
		vis5dmakepart5 $1 $2
		vis5dmakepart6 $1 $2
		#
vis5dmakepart1  2  # vis5dmakepart1 'im0p0s0l' 0
		#
		echo "vis5dmakepart1"
		#
		# must use $!! or else in macro call leaves as $1 and $2 explicitly and need to use later as fully resolved value
		define arg1 "$!!1"
		define arg2 "$!!2"
		#
		# define arg1 "'im0p0s0l'"
		# define arg2 "0"
		#
		# default:
		define DIDFIELDLINESPLIT (0)
		define DIDDUMPSPLIT (0)
		#
		#
		#########################
		# convert fieldline binary to several single column text files
		#
		# GODMARK: comment below line to do image version
		if($DOFIELDOUTPUT==1){\
		  field2singlecol $arg2
		  dump2singlecol $arg2
	        }
		#
		#
		##############################
		# Setup for rest of conversions
		#
		set h1=$arg1
		set h12='$imagespreappend'
                set h3='.r8'
		set h32='.v5d'
                set h33='.ppm'
                #
		set h2=sprintf('%04d',$arg2)
		#
		# HARM .r8
		set _fname1=h1+h2+h3
		define filenamer8 (_fname1)
		#
		#
		#
		if($DIDFIELDLINESPLIT==0){\
		 # interpolated .r8
		 set _fname1=h12+h1+h2+h3
		 define filenameinterp (_fname1)
		 #
		 define trueinterp "$iimagesdir/$filenameinterp"
		 # v5d file
		 set _fname1=h12+h1+h2+h32
		 define filenamev5d (_fname1)
		 #
		 # ppm file
		 set _fname1=h12+h1+h2+h33
		 define filenameppm (_fname1)
		 #
		}
		#
		if($DIDFIELDLINESPLIT==1){\
		 # interpolated fieldline data
		 set field0='$dumpspreappend'
		 set field1='fieldline'
		 set _fname1=field0+field1+h2
		 define filenameinterp (_fname1)
		 #
		 define trueinterp "$idumpsdir/$filenameinterp"
		 # v5d file
		 set _fname1=field0+field1+h2+h32
		 define filenamev5d (_fname1)
		 #
		 # ppm file
		 set _fname1=field0+field1+h2+h33
		 define filenameppm (_fname1)
		 #
		 #
		}
		########################
		#
		define truer8 "$imagesdir/$filenamer8"
		define truev5d "$v5ddir/$filenamev5d"
		define trueppm "$ppmdir/$filenameppm"
		define trueppmrefine "$ppmrefinedir/$filenameppm"
		#
		#
vis5dmakepart2  2  # vis5dmakepart2 'im0p0s0l' 0
		#
		echo "vis5dmakepart2"
		#
		#########################
		# INTERPOLATION
		#
		define filein "$truer8"
		define fileout "$trueinterp"
		#
		#
                # bicubic: works but very slow
		#define interptype (3)
                # planar (doesn't work for 3D properly)
                #define interptype (2)
		# bi-linear (works for 3D and very fast)
                define interptype (1)
		# nearest neighbor
		#define interptype (0)
                #
                #
		define refinement (1.0)
                #
		#define program "iinterp.orange -oldargs "
                define program "iinterp -oldargs "
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
		define doing3d ($nz>1)
		define doing2d (!$doing3d)
		#
		#
          	if($DIDFIELDLINESPLIT==0){\
		 if($DOINTERPSTAGE){\
		  # then use image
		  blandinterpsingle $filein $fileout
		 }
		}
		#
		if($DIDFIELDLINESPLIT==1){\
		# then use fieldline data
		 #
		 # interpolate fieldline data as well
		 set field1='$idumpsdir'
		 set field21='$dumpspreappend'
		 set field3=sprintf('%04d',$arg2)
		 #
		 if($DOINTERPSTAGE){\
 		  # create variables that aren't properly resolved by vis5d (such as log(rho))
		  # Done before interpolation since near-0 values are similar to small log values that want!
		  #
		  ! head -1 "$!idumpsdir/rho$!numext" > "$!idumpsdir/rho$!numext.head"
		  ! tail -n +2 "$!idumpsdir/rho$!numext" > "$!idumpsdir/rho$!numext.temp"
		  ! ./makelog 1E-30 < "$!idumpsdir/rho$!numext.temp" > "$!idumpsdir/logrho$!numext.temp"
		  ! cat "$!idumpsdir/rho$!numext.head" "$!idumpsdir/logrho$!numext.temp" > "$!idumpsdir/logrho$!numext"
		  if($removeinterpolateddump){\
		   ! rm -rf "$!idumpsdir/rho$!numext.head" "$!idumpsdir/rho$!numext.temp" "$!idumpsdir/logrho$!numext.temp"
		  }
		  #
		  ! head -1 "$!idumpsdir/u$!numext" > "$!idumpsdir/u$!numext.head"
		  ! tail -n +2 "$!idumpsdir/u$!numext" > "$!idumpsdir/u$!numext.temp"
		  ! ./makelog 1E-30 < "$!idumpsdir/u$!numext.temp" > "$!idumpsdir/logu$!numext.temp"
		  ! cat "$!idumpsdir/u$!numext.head" "$!idumpsdir/logu$!numext.temp" > "$!idumpsdir/logu$!numext"
		  if($removeinterpolateddump){\
		   !rm -rf "$!idumpsdir/u$!numext.head" "$!idumpsdir/u$!numext.temp" "$!idumpsdir/logu$!numext.temp"
		  }
		  #
		  #
		 #
		 #
		 #
		 # these output $fileout that can be used next
		 # $!! needed so immediately defines rather than delayed assignment
		 set var='"nothing"'
		 #
                 define DOTEST 0
                 #
                 if($DOTEST==0){\
                  echo "interp rho"
		  subblandinterpdata 'rho' var
		  define fileirho (var)
		  #
                  echo "interp u"
		  subblandinterpdata 'u' var
		  define fileiu (var)
		  #
                  echo "interp logrho"
		  subblandinterpdata 'logrho' var
		  define fileilogrho (var)
		  #
                  echo "interp logu"
		  subblandinterpdata 'logu' var
		  define fileilogu (var)
		  #
                  echo "interp negud0"
		  subblandinterpdata 'negud0' var
		  define fileinegud0 (var)
		  #
                  echo "interp gammainf"
		  subblandinterpdata 'gammainf' var
		  define fileigammainf (var)
		  #
                  echo "interp uu0"
		  subblandinterpdata 'uu0' var
		  define fileiuu0 (var)
		  #
                  echo "interp vu1"
		  subblandinterpvec 'vu1' var 1
		  define fileivu1 (var)
		  #
                  echo "interp vu2"
		  subblandinterpvec 'vu2' var 2
		  define fileivu2 (var)
		  #
                  echo "interp vu3"
		  subblandinterpvec 'vu3' var 3
		  define fileivu3 (var)
		  #
                  echo "interp B1"
		  subblandinterpvec 'B1' var 1
		  define fileiB1 (var)
		  #
		}
                  echo "interp B2"
		  subblandinterpvec 'B2' var 2
		  define fileiB2 (var)
		  #
		  #
                  #
                 if($DOTEST==0){\
                  echo "interp B3"
		  subblandinterpvec 'B3' var 3
		  define fileiB3 (var)
                  #
                  #
		  #
                  echo "interp posr"
		  subblandinterpdata 'posr' var
		  define fileiposr (var)
		  #
                  echo "interp posh"
		  subblandinterpdata 'posh' var
		  define fileiposh (var)
		  #
                  echo "interp posph"
		  subblandinterpdata 'posph' var
		  define fileiposph (var)
		  #
                  #
                  # newly generated quantities
                  #
		  subblandinterpdpdw 'dpdw' var
		  define fileidpdw (var)
		  #
		  subblandinterpBd3 'Bd3' var
		  define fileiBd3 (var)
		  #
                 }       
                  #
                 if($DOTEST==1){\
                                laskdjfla;skdjfasldkfj;;
                                }
		  #
		  #
		  # pull off header temporarily
		  ! tail -n +2 $fileirho > $fileirho.temp
		  ! tail -n +2 $fileiu > $fileiu.temp
		  ! tail -n +2 $fileilogrho > $fileilogrho.temp
		  ! tail -n +2 $fileilogu > $fileilogu.temp
		  ! tail -n +2 $fileinegud0 > $fileinegud0.temp
		  ! tail -n +2 $fileigammainf > $fileigammainf.temp
		  ! tail -n +2 $fileiuu0 > $fileiuu0.temp
		  ! tail -n +2 $fileivu1 > $fileivu1.temp
		  ! tail -n +2 $fileivu2 > $fileivu2.temp
		  ! tail -n +2 $fileivu3 > $fileivu3.temp
		  ! tail -n +2 $fileiB1 > $fileiB1.temp
		  ! tail -n +2 $fileiB2 > $fileiB2.temp
		  ! tail -n +2 $fileiB3 > $fileiB3.temp
		  ! tail -n +2 $fileiposr > $fileiposr.temp
		  ! tail -n +2 $fileiposh > $fileiposh.temp
		  ! tail -n +2 $fileiposph > $fileiposph.temp
		  ! tail -n +2 $fileidpdw > $fileidpdw.temp
		  ! tail -n +2 $fileiBd3 > $fileiBd3.temp
		  #
		  #
		  #
		 }
		 #
		 # combine data back into single data file with multiple columns
		 #
		 set field22='fieldline'
		 set _fname=field1+field21+field22+field3
		 define finalifieldline (_fname)
		 #
		 #
		 if($DOINTERPSTAGE){\
		  #
		  ! paste -d ' ' $fileirho.temp $fileiu.temp \
		      $fileilogrho.temp $fileilogu.temp \
		      $fileinegud0.temp \
		      $fileigammainf.temp $fileiuu0.temp \
		      $fileivu1.temp $fileivu2.temp $fileivu3.temp \
		      $fileiB1.temp $fileiB2.temp $fileiB3.temp \
		      $fileiposr.temp $fileiposh.temp $fileiposph.temp \
		      $fileidpdw.temp $fileiBd3.temp \
		      > $finalifieldline.temp
		  #
		  # remove temp files
		  if($removeinterpolateddump){\
		  !rm -rf $fileirho.temp $fileiu.temp
		  !rm -rf $fileilogrho.temp $fileilogu.temp
		  !rm -rf $fileinegud0.temp $fileigammainf.temp $fileiuu0.temp
		  !rm -rf $fileiuu0.temp $fileivu1.temp $fileivu2.temp $fileivu3.temp
		  !rm -rf $fileiB1.temp $fileiB2.temp $fileiB3.temp
		  !rm -rf $fileiposr.temp $fileiposh.temp $fileiposph.temp
                  !rm -rf $fileidpdw.temp $fileiBd3.temp
		  }
		  #
		  # assume all headers are the same for all data (required for this paste to make sense)
		  #
		  ! head -1 $fileirho > $fileirho.head
		  ! cat $fileirho.head $finalifieldline.temp > $finalifieldline
		  ! rm -rf $fileirho.head $finalifieldline.temp
		  #
		  # now $finalfieldline contains data ready for processing to V5D file
		  #
		  if($removeinterpolateddump){\
		  # remove per-file interpolations
		  !rm -rf $fileirho $fileiu
		  !rm -rf $fileilogrho $fileilogu
		  !rm -rf $fileinegud0 $fileigammainf $fileiuu0
		  !rm -rf $fileiuu0 $fileivu1 $fileivu2 $fileivu3
		  !rm -rf $fileiB1 $fileiB2 $fileiB3
		  !rm -rf $fileiposr $fileiposh $fileiposph
                  !rm -rf $fileidpdw $fileiBd3
		  }
		  #
		 }
		 #
		 #
		 if($DIDFIELDLINESPLIT){\
		  # remove breakfieldline versions
		  #
		  if($removeinterpolateddump){\
		  #
		  !rm -rf "$!idumpsdir/rho$!numext" "$!idumpsdir/u$!numext" \
		     "$!idumpsdir/logrho$!numext" "$!idumpsdir/logu$!numext" \
		     "$!idumpsdir/negud0$!numext" \
		     "$!idumpsdir/gammainf$!numext" "$!idumpsdir/uu0$!numext" \
		     "$!idumpsdir/vu1$!numext" "$!idumpsdir/vu2$!numext" "$!idumpsdir/vu3$!numext" \
		     "$!idumpsdir/B1$!numext" "$!idumpsdir/B2$!numext" "$!idumpsdir/B3$!numext" \
		     "$!idumpsdir/posr$!numext" "$!idumpsdir/posh$!numext" "$!idumpsdir/posph$!numext" \
		     "$!idumpsdir/dpdw$!numext" "$!idumpsdir/Bd3$!numext"
		  }
		 }
		 #
		 #
		}
		#
		#
		#
		#
		#
vis5dmakepart3  2 #   vis5dmakepart3 'im0p0s0l' 0
		#
		echo "vis5dmakepart3"
		#
		# !dr82 iim0p0s0l0880.r8 64 4096
                #
                #######################
		# Now get vis5d+ version
		#
		if($DIDFIELDLINESPLIT==0){\
		 #
		 # special image scaling of data
		 da imagesfinal.txt
		 lines 1 100000000
		 read '%d %d %d %d %d %d %d %g %g %g' {inum it1 it2 it3 it4 it5 it6 v5dmin v5dmax v5davg}
		 #
		 # for density, assume took C-log (LN) for image data
		 set temp=v5dmin if(inum==$arg2)
		 define mymin (LN(abs(temp)))
		 set temp=v5dmax if(inum==$arg2)
		 define mymax (LN(abs(temp)))
		 #
		 define headfile "headv5d"
		 !echo "density $!mymin $!mymax" > $headfile.$arg2.txt
		 #
                 #!echo "-1 1 -1 1 -1 1" >> $headfile.$arg2.txt
		 # below is -1..1 in all directions if cubical
		 !echo "$!!v5dixmin $!!v5dixmax $!!v5diymin $!!v5diymax $!!v5dizmin $!!v5dizmax" >> $headfile.$arg2.txt
		 #
		 #
		}
		#
		#
		# GODMARK: these should be chosen appropriately
		define numv5dquants (13+3+2)
		define bhspin (a)
		define startsimtime (0)
		set DTfl=(2.0)
		define simtime ($2*DTfl)
		#
		echo "vis5dmakepart3_2"
		#
		if($DIDFIELDLINESPLIT==1){\
		 #
		 # With Nr=N3, Nc=N2 and Nl[i]=N1 in bin2txt: (note pnmhd output same as grmhd output)
		 # +U = +\vec{E} = +\vec{z}
		 # +V = +\vec{N} = +\vec{x}
		 # +W = +\vec{N}\times\vec{W} = +\vec{y}
		 #
		 # Avery has us use W U V for PNMHD?
		 #
		 #
		 #
		 #
		 # just create dummy header since data is not rescaled
		 define headfile "headv5d"
		 !echo "density 0 1"  > $headfile.$arg2.txt
		 !echo "ie 0 1"       >> $headfile.$arg2.txt
		 !echo "logdensity 0 1"  >> $headfile.$arg2.txt
		 !echo "logie 0 1"       >> $headfile.$arg2.txt
		 !echo "negud0 0 1"   >> $headfile.$arg2.txt
		 !echo "gammainf 0 1" >> $headfile.$arg2.txt
		 !echo "uu0 0 1"      >> $headfile.$arg2.txt
		 !echo "V 0 1"      >> $headfile.$arg2.txt
		 !echo "W 0 1"      >> $headfile.$arg2.txt
		 !echo "U 0 1"      >> $headfile.$arg2.txt
		 !echo "V2 0 1"      >> $headfile.$arg2.txt
		 !echo "W2 0 1"      >> $headfile.$arg2.txt
		 !echo "U2 0 1"      >> $headfile.$arg2.txt
		 !echo "posr 0 1"      >> $headfile.$arg2.txt
		 !echo "posh 0 1"      >> $headfile.$arg2.txt
		 !echo "posph 0 1"      >> $headfile.$arg2.txt
		 !echo "dpdw 0 1"      >> $headfile.$arg2.txt
		 !echo "Bd3 0 1"      >> $headfile.$arg2.txt
		 #!echo "$!!v5dixmin $!!v5dixmax $!!v5diymin $!!v5diymax $!!v5dizmin $!!v5dizmax" $!!bhspin $!!startsimtime $!!simtime  >> $headfile.$arg2.txt
		 # stick to fake v5d coords as far as V5D knows
		 !echo "$!!v5dixmin $!!v5dixmax $!!v5diymin $!!v5diymax $!!v5dizmin $!!v5dizmax" >> $headfile.$arg2.txt
		 ! cat $headfile.$arg2.txt
		 #
		 #!echo "-1 1 -1 1 -1 1"  >> $headfile.$arg2.txt
		 #
		}
		#
		define filein "$trueinterp"
		define fileout "$truev5d"
		#
		if($DOV5DSTAGE){\
		 #
		 if($DIDFIELDLINESPLIT==0){\
		  # then use image data
		  # feed $iinx,$iiny,$iinz since bin2txt assumes sizes are input (not output) order
		  #
		  echo "bin2txt 0 5 0 0 3 $!!iinx $!!iiny $!!iinz 1 $!!headfile.$!!arg2.txt $!!filein $!!fileout b 1"
                  !bin2txt 0 5 0 0 3 $iinx $iiny $iinz 1 $headfile.$arg2.txt $filein $fileout b 1
		  #
		 }
		 #
		 if($DIDFIELDLINESPLIT==1){\
		  # use data
		  # feed $iinx,$iiny,$iinz since bin2txt assumes sizes are input (not output) order
		  #
		  echo "bin2txt 2 5 0 1 3 $!!iinx $!!iiny $!!iinz 1 $!!headfile.$!!arg2.txt $!!finalifieldline $!!fileout d $!!numv5dquants"
                  !bin2txt 2 5 0 1 3 $iinx $iiny $iinz 1 $headfile.$arg2.txt \
		      $finalifieldline $fileout d $!!numv5dquants
		  #
		 }
                }
		#
		if($removeinterpolateddump){\
	         # remove temp files
		 ! rm -rf  $headfile.$arg2.txt
		}
                #
                if($removeinterpolateddump){\
                 # then remove interpolated data dump since probably very large when multiplied by number of such dumps
		 if($DIDFIELDLINESPLIT==0){\
		  !rm -rf $filein
		 }
		 if($DIDFIELDLINESPLIT==1){\
                  !rm -rf $finalifieldline
		 }                     
		}
                #
		#
		#
                #
vis5dmakepart4  2  # vis5dmakepart4 'im0p0s0l' 0
		#
		echo "vis5dmakepart4"
		##########################
                # Render vis5d image
                #
		define filein "$truev5d"
		define fileout "$trueppm"
		#
		# below line doesn't work, SM interprets " always literally?
		#! echo "set outputfilename" \'$trueppm\' | sed 's/\'/"/' > filename.tcl
		# makefilename.sh  has:
		# echo "set outputfilename" \"$arg1\" > $arg2
		#
                #
vis5dmakepart5  2 #   vis5dmakepart5 'im0p0s0l' 0
                ######### make script use unique filename so can do process in parallel in same directory
		 #
		 # below didn't work to set dostereo for some reason when inside the following conditional
		 # -- odd out-of-order error message
		 if($do3dwall==1){\
		        #
		        echo "got here1wall"
		        set tempvar=2
		        define dostereo (tempvar)
		        #
		 }
		 #
		 if($do3dwall==0){\
		        #
		        echo "got here0wall"
		        set tempvar=0
		        define dostereo (tempvar)
		        #
		 }
		 #
		#
		echo "vis5dmakepart5 $!!DOV5D2PPMSTAGE"
		#
                if($DOV5D2PPMSTAGE){\
		 #
		 echo $trueppm filename$arg2.tcl
		 echo "do3dwall dostereo"
		 echo "$!!do3dwall $!!dostereo"
		 # use true coords for V5D script so can easily set "user" coordinates
		 # below ixmin/ixmax, etc. should be in original and true x,y,z coordinates
		 ! sh makefilename.sh $trueppm $!!ixmin $!!ixmax $!!iymin $!!iymax $!!izmin $!!izmax $!!bhspin \
		     $!!startsimtime $!!simtime $!!dostereo filename$arg2.tcl 
		 #
		 #
                 # fieldline source
                 if($DIDFIELDLINESPLIT==1){\
                  #
                  echo 3dmovie.$arg2.tcl
                  ! cat filename$arg2.tcl 3dmovie.tcl > 3dmovie.$arg2.tcl
		  #
		  echo doing v5d at resolution of:
		  echo $flinx'x'$fliny
		  #
		  # now using remote framebuffer if no X server exists
		  # -alpha only works between iso's not between iso's and volume rendering due to back-to-front issue
		  #! vis5d $truev5d -alpha -geometry  $flinx'x'$fliny
                  #
		  #! vis5d $truev5d -mbs 1400 -geometry  $flinx'x'$fliny \
		  #    -framebuffer ki-rh42.slac.stanford.edu:2 -offscreen -script 3dmovie.$arg2.tcl
                  #
		  ! vis5d $truev5d -mbs 1000 -geometry  $flinx'x'$fliny \
		      -offscreen -script 3dmovie.$arg2.tcl
		  #
		  #
		  if($removeinterpolateddump){\
		   # remove temp files
		   ! rm -rf  3dmovie.$arg2.tcl filename$arg2.tcl
		  }
		  #
                 }
                 #  
                 #
                 # image source
                 if($DIDFIELDLINESPLIT==0){\
                  #
                  echo 3dmovie.$arg2.tcl
                  ! cat filename$arg2.tcl 3dmovie.fromimage.tcl > 3dmovie.$arg2.tcl
		  #
		  #! vis5d $truev5d -mbs 1000 -alpha -geometry $flinx'x'$fliny
		  ! vis5d $truev5d -geometry $flinx'x'$fliny \
		      -framebuffer ki-rh42.slac.stanford.edu:2 -offscreen -script 3dmovie.$arg2.tcl
		  #
		  #! vis5dalt $truev5d -geometry $flinx'x'$fliny \
		  #    -framebuffer ki-rh42.slac.stanford.edu:2 -offscreen -script 3dmovie.$arg2.tcl
		  #
		  if($removeinterpolateddump){\
		   # remove temp files
                   ! rm -rf  3dmovie.$arg2.tcl filename$arg2.tcl
		  }
		  #
                 }
                 #
		 #
		 if($removefinalv5dfile){\
		 !rm -rf $truev5d
		 }
		 #
		 #
		}
                #
vis5dmakepart6  2 #  vis5dmakepart6 'im0p0s0l' 0
		##########################
                # Refine image
                #
		# below 2 lines don't give right string result when echo
		#define filein "$trueppm"
		#define fileout "$trueppmrefine"
		#
		echo "refine: in: $!!trueppm  out: $!!trueppmrefine"
		#
                if($DOREFINESTAGE){\
		 # before when not setting geometry:
		 # original is 3420x3420+0+0
		 #! convert $trueppm -resize 3420x3420+0+0 $trueppm.temp
		 #! convert $trueppm.temp -crop 1884x1884+768+768 -depth 8 -colors 256 -antialias -resize $flinx'x'$fliny $trueppmrefine
		 #
		 # assume input size is already $flinx'x'$fliny
		 #! convert $trueppm -resize 3420x3420+0+0 $trueppm.temp
		 #! convert $trueppm.temp -crop 1884x1884+768+768 -depth 8 -colors 256 -antialias -resize $flinx'x'$fliny $trueppmrefine
		 #
		 if($do3dwall==0){\
		       # assume zoom and scaled already using vis5d_set_camera function, so just copy over file
		       ! cp -a $trueppm $trueppmrefine
		       #
		       if($removeppm){\
		              # remove temp files
		              ! rm -rf $trueppm
		       }
		 }
		 #
		 if($do3dwall==1){\
		  # names are special in this case
                  ! cp -a $trueppm.left.ppm $trueppmrefine.left.ppm
                  ! cp -a $trueppm.right.ppm $trueppmrefine.right.ppm
                  #
		  if($removeppm){\
		   # remove temp files
		   ! rm -rf $trueppm.left.ppm $trueppm.right.ppm
		  }
		  # get each CPU to do montage since takes a while to do afterwards if on one CPU
		  ! sh montageleftright.one.sh $trueppmrefine $trueppmrefine $flinx $fliny
		 }
		 #
                }
		#
		#
		#
blandinterpsingle 2
		#
		define DATATYPE 0
		# want extrapolation so smoothly connects at outer edges
		define EXTRAPOLATE 0
		define DEFAULTVALUETYPE 4
		#
                !~/bin/$program $DATATYPE $interptype $doing2d $WRITEHEADER \
		    $nt $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
		    $iint $iinx $iiny $iinz  $iitmin $iitmax $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope  $idefcoord $dofull2pi $tnrdegrees $EXTRAPOLATE $DEFAULTVALUETYPE < $1 > $2
		#
                #
blandinterpsingledata 2
		#
		define DATATYPE 1
		# want extrapolation so smoothly connects at outer edges
		# GODMARK: sets to 0 otherwise, and should really choose (maybe) min for scalars and 0 for vectors
		define EXTRAPOLATE 0
		define DEFAULTVALUETYPE 4
		#
                !~/bin/$program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
		    $nt $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
		    $iint $iinx $iiny $iinz  $iitmin $iitmax  $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope  $idefcoord $dofull2pi $tnrdegrees $EXTRAPOLATE $DEFAULTVALUETYPE < $1 > $2
		#                
blandinterpwithgdump 2
                #
                !~/bin/$program $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
		    $nt $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
		    $iint $iinx $iiny $iinz  $iitmin $iitmax  $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
		    $iRin $iRout $iR0 $ihslope  $idefcoord $dofull2pi $tnrdegrees $EXTRAPOLATE $DEFAULTVALUETYPE $dumpsdir/gdump < $1 > $2
                #
blandinterpsinglevec 3
		#
		define DATATYPE ($3+2)
		define EXTRAPOLATE 0
		define DEFAULTVALUETYPE 4
		#
		# for vectors need to transform, so need also gdump info
		#
                blandinterpwithgdump $1 $2
		#
		#
blandinterpsingledpdw 2
		#
		define DATATYPE (11)
		define EXTRAPOLATE 0
		define DEFAULTVALUETYPE 4
		#
		# for vectors need to transform, so need also gdump info
		#
                blandinterpwithgdump $1 $2
		#
		#
blandinterpsingleBd3 2
		#
		define DATATYPE (12)
		define EXTRAPOLATE 0
		define DEFAULTVALUETYPE 4
		#
		# for vectors need to transform, so need also gdump info
                blandinterpwithgdump $1 $2
		#
		#
subblandinterpdata 2 # subblandinterpdata 'rho' var
		# uses global vars
		set field22=$1
		set _fname=field1+field22+field3
		define filein (_fname)
		set _fname=field1+field21+field22+field3
		define fileout (_fname)
		blandinterpsingledata $filein $fileout
		set $2='$!!fileout'
		#
		#
subblandinterpvec 3 # subblandinterpvec 'vu1' var 1
		# uses global vars
		set field22=$1
		set _fname=field1+field22+field3
		define filein (_fname)
		set _fname=field1+field21+field22+field3
		define fileout (_fname)
		blandinterpsinglevec $filein $fileout $3
		set $2='$!!fileout'
		#
		#
subblandinterpdpdw 2 # subblandinterpdpdw 'dpdw' var
		# uses global vars
		set field22=$1
		set _fname=field1+field22+field3
		define filein (_fname)
		set _fname=field1+field21+field22+field3
		define fileout (_fname)
		blandinterpsingledpdw $filein $fileout
		set $2='$!!fileout'
		#
		#
subblandinterpBd3 2 # subblandinterpBd3 'Bd3' var
		# uses global vars
		set field22=$1
		set _fname=field1+field22+field3
		define filein (_fname)
		set _fname=field1+field21+field22+field3
		define fileout (_fname)
		blandinterpsingleBd3 $filein $fileout
		set $2='$!!fileout'
		#
		#
makev5dppmfli 1 # makev5dppmfli 'im0p0s0l'
                #
		define removetempfiles 1
		#
		set h0='$ppmrefinedir'
		set h1=$1
		set h2='/'
		set h3='$imagespreappend'
                set h4='.ppm'
		set h5='*'
		set h6='tmp.lis'
		set h7='.fli'
		#
		#
		set _fname=h0+h3+h1+h5+h4
		define filename (_fname)
		#
		#
		set _fname=h0+h2+h6
		define listname (_fname)
		#
		set _fname=h0+h2+h3+h1+h7
		define fliname (_fname)
                #
                !ls $filename > $listname
                !rm -rf $fliname
                !ppm2fli -p/home/jon/research/current/bin/i/john.pal -N -g $flinx'x'$fliny  -s 0 $listname $fliname
                if($removetempfiles){\
                       !rm -rf $listname
                }
                #
