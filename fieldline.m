# Overall:
#
# Purpose:
# 1) Converts frequent fieldline dumps to text, makes Cartesian interpolated field line images and fli movie (./aphi/*)
# 2) Interpolates images to Cartesian and makes fli movie (./iimages/*)
# 3) Combines interpolated field line SM plot with interpolated color image and makes movie (./composeaphi/*)
# 4) Does this for a non-zoomed and zoomed-in case
#
# Before being in SM:
# 1) Make sure to have the latest gammie.m
# 2) Have latest bin2txt compiled and in path
# 3) Have latest jon_interp compiled as iinterpextrap and iinterpnoextrap put into ~/sm/ where those iinterp codes are only different by EXTRAPOLATE 1 or 0 defined in global.jon_interp.h
# 4) Have ppm2fli in path
# 5) Have Imagemagik installed (normally is on linux/unix)
#
# Then in SM do:
# 1) removeoldfiles (if files already exist from previous try)
# 2) dozoomall
#
#
# Commonly changed things:
# 1) whichdevice chosen as ppm2 or ppm3 (ppm3 required to resolve axis labels)
# 2) start and finish ranges
# 3) range plotted for zoomed-in case
# 4) Rinbad and Routbad or similar modifications to truncate contour line plot
# 5) ANIMSKIP to define stepping through dumps to be used
#		
# Assumptions:
# 1) DTi=DTfieldline or else need to be more careful
# 2) 2D axisymmetry or 3D with default slice done (untested -- may be issue with generating aphi from fieldcalc)
#
removeoldfiles 0        #
		# should probably do before  running dozoomall:
                #
		# ensure no spaces between slash (/) and star (*) !!!
		#
		!ls aphi/* aphizoom/* iimages/* iimageszoom/* composaphi/* composaphizoom/* | xargs rm -rf
		#
                #
dozoomall 0     #
                # Recommended to do below command but not done by default to avoid removing wrong files
		#
		# removeoldfiles
		#
                ##########################
                # Setup start and finish dump file number and whether to remove temporary files
                #
		# CHOOSE dump range:
		set start=0
		set finish=1000
		#
		#
		# whether to remove temp files (if don't remove then movies may not work right since temp versions in .ppm format can be picked up)
		define removetempfiles 1
		#
                #
                ############################
                # Basic setup
		#
		setupbasicdirs
		#
		setupgrid
		#
		setupresolutions
		#
		#
		#########################
		# Convert binary (fieldline????.bin) dumps to text (fieldline????) for SM
		#
		# don't have to repeat conversion every time change parts of makeflmovie
		# puts files in dumps directory
		#
		convertall start finish
		#
		##########################
		#
		#
		#
		#########################
		# do BOTH zoom levels
		#
		# GODMARK: default is full radial range with correct aspect ratio in axisymmetry
		define zoom (0)
		doaphiall
		#
		# GODMARK: Can choose what it means to zoom by finding interps3d* and changing range from 0 10 -10 10 to something else
		#
		define zoom (1)
		doaphiall
		#
		#########################
		#
setupresolutions 0	#
		#
		# define stepping for dump numbers
		define ANIMSKIP 1
		#
		# for jon_interp interpolations:
		define iinx $nx
		define iiny ($ny*2)
		#
		# CHOOSE PPM DEVICE RESOLUTION (linked to other resolutions)
		if(0){\
                      # can be too low res for plot labels
		       define whichdevice ppm2
		       define ppmdevicenx 256
		       define ppmdeviceny 512
		    }\
		    else{\
		              # seems high resolution best after all
		              define whichdevice ppm3
		              define ppmdevicenx 512
		              define ppmdeviceny 1024
		           }
		#
		#
		# desired final resolution
		#define finalnx 512
		#define finalny 1024
		# best to have same resolution as ppm device to avoid aliasing of field lines
		define finalnx $ppmdevicenx
		define finalny $ppmdeviceny
		#
		# fli movie sizes
		define flinx $finalnx
		define fliny $finalny
		#
		#
		set h1=sprintf('%dx',$finalnx)
		set h2=sprintf('%d',$finalny)
		set _finaln=h1+h2
		define finalncommand (_finaln)
		#
doaphiall 0     #
		# Generally do:
		# 1) setupgrid
		# 2) convertall
		# 3) makeflmovie
		# and then use ppm2fli to make .fli
		#
		# must load before running macros:
		#gogrmhd
		#jre fieldline.m
		#
		#
		setupgrid
		setupzoomdirs
		#
		#
		#
		#
		# make PPM contour plot of field line using SM
		makeflmovie
		#
		#  make field line fli
		makeflfli 'fieldline'
		#
		# make corresponding set of interpolated images of density
		animr8interp 'im0p0s0l'
		#
		# make color fli of density
		makeimagefli 'im0p0s0l'
		#
		# make composite image
		mkcomposite 'fieldline' 'im0p0s0l'
		#
		# make composite fli
		makecompositefli 'fieldline' 'im0p0s0l'
		#
setupgrid 0      #
		# setup some default directories in global defines
		#
		define LOGTYPE (0)
		defaults
		#
		# below flinedumptype==2 is for 3D code using jrdp3du for dumps and version=2 for fieldline dumps
		# easy to add another type
		#
		set flinedumptype=2
		#
		# get nx,ny,nz
		if(flinedumptype==2){\
		       jrdp3du dump0000
		    }\
		    else{\
		              jrdp dump0000
		    }
		set Rinold=Rin
		set Routold=Rout
                define offset (0)
                set Rinbad=r[$offset]
                set Routbad=r[$nx-1-$offset]
		#
convertall 2    # convertall 0 204
		#
		#
		set start=$1
		set finish=$2
		flinebin2txt 'fieldline'
		#
flinebin2txt 1  #
		#
		#
                do ii=start,finish,$ANIMSKIP {
		   #
		   convertsingle $1 $ii
		  #
		}
		#
		#
convertsingle 2 #
		#
		set h1old='$dumpsdir'
		set h1new='$idumpsdir'
                set h2old=$1
                set h2new=$1
                set h3old='.bin'
		set h3new=''
                set hnum=sprintf('%04d',$2)
		  #
		  #setup read filename
                  set _fname=h1old+h2old+hnum+h3old
                  define filenameold (_fname)
		  #
		  # setup write filename
                  set _fname=h1new+h2new+hnum+h3new
		  define filenamenew (_fname)
		  #
		  define SOURCE 1
		  define DEST 2
		  define BLE 0
		  define HEADERLINESTOSKIP 1
                  define NDIM 3 # only for HDF, but can always just use 3D
		  #
  		  !bin2txt $SOURCE $DEST $BLE $HEADERLINESTOSKIP $NDIM $nx $ny $nz 1 $filenameold $filenamenew.temp f 11
                  # put the header into the text file
                  !head -1 $filenameold > $filenamenew.head
                  !cat $filenamenew.head $filenamenew.temp > $filenamenew
                  if($removetempfiles){\
                   !rm -rf $filenamenew.head $filenamenew.temp
                  }
		  #
                  #
                  define fnamefcs "$!filenamenew"
                  #
		  #
		#
readfline 1             # assume normal dump at some time is read in for coordinate dependent stuff
		da $idumpsdir/$1
		lines 2 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g' \
		    {rho u negud0 gammainf uu0 vu1 vu2 vu3 B1 B2 B3}
	        #
		set flinedumptype=2
		flinecalcs
 		#
readflineo2 1             # assume normal dump at some time is read in for coordinate dependent stuff
		da $idumpsdir/$1
		lines 2 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g' \
		    {rho u ud0 Tudtt vu1 vu2 vu3 B1 B2 B3}
	        #
		set flinedumptype=1
		flinecalcs
 		#
readflineo 1	# assume normal dump at some time is read in for coordinate dependent stuff
		da $idumpsdir/$1
		lines 2 10000000
		#
		read '%g %g %g %g %g %g %g %g %g' \
		    {ud0 hud0 Tudtt vu1 vu2 vu3 B1 B2 B3}
	        #
		set flinedumptype=0
		flinecalcs
		#
flinecalcs 0    #		
		if(flinedumptype==1 || flinedumptype==2) {\
                                      gcalcbasic
                                      set enthalpy=(rho+p+u)/rho
                                      set hud0=-negud0*enthalpy
                   }
		# no way to get p or u from flinedumptype==0
		if(flinedumptype==0) { set enthalpy=hud0/ud0 }
		set omegaf1=vu3-B3*vu2/(B2+1E-30)
		set omegaf2=vu3-B3*vu1/(B1+1E-30)
 		#
		#
computeanimpc 0	#
		#
		# make iaphi : interpolated aphi
		makeaphi
		#
		# compute something
		#  fieldcalc 0 aphi
		  #set ud0shift=-ud0-1
		  #set outud0=(uu1>0.0) ? -ud0-1 : 0
		  #interpsingle outud0
		  #interpsingle ud0shift
		  ##
		  plotparms
		#
plotparms 0 #
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		#
		lweight 3
		notation -4 4 -4 4
		define coord 1
		#
makeaphi 0     #		
		fieldcalc 0 aphi
		#
		# 2D code:
		if(flinedumptype==0 || flinedumptype==1){\
		       if($zoom==0) { interpsingle aphi 512 1024 }
		       if($zoom==1) { interpsingle aphi 512 1024 40 40 }
		       readinterp aphi
		       #
		       define missing_data (1E30)
		       set radius=sqrt(x12**2+x22**2)
		       set newiaphi=(radius<380.0) ? iaphi : $missing_data
		       set iaphi=newiaphi
		#
		}
		#
		# 3D code:
                # use interps3dextrap for nearest neighbor extrapolation of aphi so at boundaries no new contours
		if(flinedumptype==2){\
		       if($zoom==0) { interps3dextrap aphi $iinx $iiny }
		       if($zoom==1) { interps3dextrap aphi $iinx $iiny 0 10 -10 10 }
		       readinterp3d aphi
		       #
                       # whether to remove contours from some region
                       #useful even with interps3dextrap!
                       if(1){\
		        define missing_data (1E30)
		        set radius=sqrt(x12**2+x22**2)
		        set newiaphi=(radius<Routbad) ? iaphi : $missing_data
		        set iaphi=newiaphi
		        #
		        set newiaphi=(radius>Rinbad) ? iaphi : $missing_data
		        set iaphi=newiaphi
                       }
		#
		}
		#
		#
		#
readanimpc 2    #
		#
		# reset grid in case previously interpolated
		readgrid
		#
		if(flinedumptype==0 || flinedumptype==1){\
		       if($2==0) { jrdp dump0000 }
		       if(($2>0)&&($2<=707)) { readflineo $1 }
		       if($2>707) { readflineo2 $1 }
		}
		#
		if(flinedumptype==2){\
		       #if($2==0) { jrdp3du dump0000 }
		       readfline $1
		}
		#
		# reset grid in case previously interpolated
		readgrid
		#
setupanimpc 0   #
		define PLOTERASE 0
		define CONSTLEVELS 1
		define SKIPFACTOR $ANIMSKIP
		define cres 10
		define coord 1
		# constlevelshit=0 uses first plc contour limits
		#set constlevelshit=0
		# always constant
		set constlevelshit=1
		define max $mymax
		define min $mymin
		define NUMDUMPS (1001)
                #defaults
		#rdnumd
		# assume below globally set
		#set start=0             # don't restart unless min/max are actually the same(or set the same)
		#set finish=$NUMFLDUMPS-1
		#set finish=$NUMDUMPS-1
		#
		#
finishanimpc 0  #
		define PLOTERASE 1
		set constlevelshit=0
		define CONSTLEVELS 0
		#
printgrid 0     #
		#
		if(flinedumptype==0 || flinedumptype==1){\
		  jrdp dump0000
		  # extract the grid
		  define print_noheader (1)
		  print "$!idumpsdir/grid.dat" {ti tj x1 x2 r h gdet}
		  #
		}
		#
		#
		if(flinedumptype==2){\
		  jrdp3du dump0000
		  # extract the grid
		  define print_noheader (1)
		  print "$!idumpsdir/grid.dat" {ti tj tk x1 x2 x3 r h ph gdet}
		  #
		}
		#
		# get aphi range (for field lines to be tracked in time properly)
		fieldcalc 0 aphi
		plc 0 aphi
		define mymax ($max)
		define mymin ($min)
		#
readgrid 0      #
		#
		if(flinedumptype==0 || flinedumptype==1){\
		       jrdpheader dump0000
		       da $idumpsdir/grid.dat
		       read '%d %d %g %g %g %g %g'  {ti tj x1 x2 r h gdet}
		       set tx1=x1
		       set tx2=x2
		       gsetup
		       gammienew
		}
		#
		#
		if(flinedumptype==2){\
		       jrdpheader3d dump0000
		       da $idumpsdir/grid.dat
		       read '%d %d %d %g %g %g %g %g %g %g'  {ti tj tk x1 x2 x3 r h ph gdet}
		       set tx1=x1
		       set tx2=x2
		       set tx3=x3
		       gsetup
		       gammienew
		}
		#
		#
		#
		#
makeflmovie 0   #
		# get grid data needed and used for t=0 fieldline
		printgrid
		#
		#
		# use first t=0 dump since currently fieldline starts at t=2
		#
		!mkdir -p $aphidir
		#
		# now do rest of fieldline dump files
		#
		if($zoom==1){\
		       LOCATION 3500 31000 3500 31000
		       LOCATION $($gx1) $($gx2-500) $gy1 $gy2
		    }
		if($zoom==0){\
		       LOCATION 3500 31000 3500 31000
		       #LOCATION $($gx1+500) $($gx2-500) $gy1 $gy2
		       LOCATION $($gx1) $($gx2-500) $gy1 $gy2
		    }
		animpc 'fieldline' iaphi
		#
		#
		#
		# animate some interpolated thing or something
animpc 2	# animpc 'dump' ud0 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
		}
		#
		setupanimpc
		#
                do ii=start,finish,$ANIMSKIP {
		   #
		   set h1=$1
		   set h3=''
		   set h32='.ppm'
		   #
		   #setup read filename
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2+h3
                  define filename (_fname)
		  #
		  # setup write filename
		  set _fname2=h1+h2+h32
		  define filename2 (_fname2)
		  #
		  device $whichdevice $aphidir/$filename2.temp.ppm
		  #
		  #
		  # read the data
		  readanimpc $filename $ii
		  # compute something
		  computeanimpc
		  #
		  if(1){\
                  if($numsend==2){ plc  0 $2}\
                  else{\
                   if($numsend==3){  plc  0 $2 $3}\
                   else{\
                    if($numsend==4){ plc  0 $2 $3 $4 $5 $6 $7}
                   }
                  }
		  } else{\
		         echo pl
                  if($numsend==2){ pl  0 x1 $2}\
                  else{\
                   if($numsend==3){  pl  0 x1 $2 $3}\
                   else{\
                    if($numsend==4){ pl  0 x1 $2 $3 $4 $5 $6 $7}
                   }
                  }
                  }
		  #
		  radialedge
		  #
		  device X11
		  #
		  setupzoomdirs
		  #
                  # GODMARK: So far stays at 255 colors as required for ppm2fli
		  ! convert -depth 8 -colors 256 -antialias $aphidir/$filename2.temp.ppm -resize $finalncommand! $aphidir/$filename2
		  if($removetempfiles){\
		         ! rm -rf $aphidir/$filename2.temp.ppm
		  }
		  #
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
		#
		finishanimpc
		#
		#
		#
animr8interp 1	# animr8interp 'im0p0s0l'
		#
		setupzoomdirs
		#
		!mkdir -p $iimagesdir
		#
		#
                do ii=start,finish,$ANIMSKIP {
		   #
		  #
		  r8toppmsingle $1 $ii
		  #
		}
		#
		#
r8toppmsingle 2 #  r8toppmsingle 'im0p0s0l' 135
		#
                set h1=$1
                set h3='.r8'
                set h32='.ras'
                set h33='.ppm'
                #setup read filename
                set h2=sprintf('%04d',$2)
                #
                set _fname=h1+h2+h3
                define filenamer8 (_fname)
                #
                # setup write filename
                set _fname2=h1+h2+h32
                define filenameras (_fname2)
                #
                # setup write filename
                set _fname3=h1+h2+h33
                define filenameppm (_fname3)
                #
                # $filenamer8 $filenameras $filenameppm
                #
                #
		setupzoomdirs
		#
		# reset grid in case previously interpolated
		readgrid
		#
		# interpolate
		if($zoom==0) { interps3dr8 $filenamer8 $iinx $iiny }
		if($zoom==1) { interps3dr8 $filenamer8 $iinx $iiny 0 10 -10 10 }
		#
		# now convert from r8 to ras
		!r8torasjon 0 /home/jon/research/current/bin/i/john.pal $iimagesdir/i$filenamer8 $inx $iny
		#
		# resize ras to final size
		!convert -size '$iinx'x'$iiny' ./$iimagesdir/i$filenameras -resize $finalncommand ./$iimagesdir/i$filenameras.temp.ras
		# convert from final sized ras to ppm (have to do this separately or else ppm becomes 65536 colors sometimes)
		!convert -colors 256 -depth 8 ./$iimagesdir/i$filenameras.temp.ras -colors 256 ./$iimagesdir/i$filenameppm
		if($removetempfiles){\
		       !rm -rf ./$iimagesdir/i$filenameras
                       !rm -rf ./$iimagesdir/i$filenameras.temp.ras
		}
		#
		#
mkcomposite 2	# mkcomposite 'fieldline' 'im0p0s0l'
		#
		#
		#
		#
                do ii=start,finish,$ANIMSKIP {
		  #
		  singlecomp $1 $2 $ii
		}
		#
setupbasicdirs 0 #
		# # imagesdir, dumpsdir, idumpsdir, iimagesdir used by interps3ddump and interps3dimage
		# non-interpolated images and dumps
		define imagesdir "./images/"
		define dumpsdir "./dumps/"
		#
		# thing to preappend to file name for interpolated things
		define dumpspreappend "i"
		define imagespreappend "i"
		#
		# interpolated dumps (same location for idumps for now)
		define idumpsdir "./idumps/" 
		#
setupzoomdirs 0     #
		#
		# in case not already called:
		setupbasicdirs
		#
		# more particular outputs
		if($zoom==1) {\
		       define aphidir "./aphizoom/"
		       define composdir "./composaphizoom/"
		       define iimagesdir "./iimageszoom/"
		}
		#
		if($zoom==0) {\
		       define aphidir "./aphi/"
		       define composdir "./composaphi/"
		       define iimagesdir "./iimages/"
		}
		#
		#
singlecomp 3   #
		#
		setupzoomdirs
		#
		# ok to repeat this over and over:
		!mkdir -p $composdir
		#
		#
                set h1=$1
		set h12=$2
                set h3='.r8'
		set h32='.ras'
		set h33='.ppm'
		#
                  set h2=sprintf('%04d',$3)
		  #
		  # fieldline file
		  set _fname3=h1+h2+h33
		  define filenamefield (_fname3)
		  #
		  # setup write filename
		  set _fname4=h12+h2+h33
		  define filenamecolor (_fname4)
		  #
		  # setup write filename
		  set _fname5=h1+h12+h2+h33
		  define filenamecomposite (_fname5)
		  #
		  define truefieldname "$aphidir/$filenamefield"
		  define truecolorname "$iimagesdir/i$filenamecolor"
		  define truecomposname "$composdir/$filenamecomposite"
		  #
		  echo "got here1"
		  #
		  # test case:
		  # truefieldname=fieldline0000.ppm
		  # truecolorname=../$iimagesdir/iim0p0s0l0000.ppm
		  # composdir=./
		  # filenamecomposite=composite.ppm
		  #
		  define origsizex $ppmdevicenx
		  define origsizey $ppmdeviceny
		  #
		  if(0){\
		   define borderx 40
		   define bordery 50
		   define cropborderx $borderx
		   define cropbordery $bordery
		   define cropsizex ($origsizex+2*$borderx)
		   define cropsizey ($origsizey+2*$bordery)
		   #
		   set h1=sprintf('%dx',$cropsizex)
		   set h2=sprintf('%d',$cropsizey)
		   set _cropsize=h1+h2
		   define cropsizecommand (_cropsize)
		   #
		   #
		  }
		  define finalsizex ($origsizex)
		  define finalsizey ($origsizey)
		  define finalfieldsizex ($origsizex)
		  define finalfieldsizey ($origsizey)
		  #
		  echo "got here2"
		  #
		  set h1=sprintf('%dx',$origsizex)
		  set h2=sprintf('%d',$origsizey)
		  set _origsize=h1+h2
		  define origsizecommand (_origsize)
		  #
		  set h1=sprintf('%dx',$finalsizex)
		  set h2=sprintf('%d',$finalsizey)
		  set _finalsize=h1+h2
		  define finalsizecommand (_finalsize)
		  #
		  set h1=sprintf('%dx',$finalfieldsizex)
		  set h2=sprintf('%d',$finalfieldsizey)
		  set _finalfieldsize=h1+h2
		  define finalfieldsizecommand (_finalfieldsize)
		  #
		  #
		  if(0){\
		   set h1=sprintf('%dx',$borderx)
		   set h2=sprintf('%d',$bordery)
		   set _border=h1+h2
		   define bordercommand (_border)
		   #
		   set h1=sprintf('%d+',$cropborderx)
		   set h2=sprintf('%d',$cropbordery)
		   set _cropborder=h1+h2
		   define cropbordercommand (_cropborder)
		  }
		  #
		  #
		  # ONLY USE BELOW NOW:
		  # 512x1090
		  define nx1 ($ppmdevicenx)
		  define ny1 ($ppmdeviceny+66/1024*$ppmdeviceny)
		  set h1=sprintf('%dx',$nx1)
		  set h2=sprintf('%d',$ny1)
		  set _crap=h1+h2
		  define rescommand1 (_crap)
		  #
		  # 512x1220
		  define nx1 $ppmdevicenx
		  define ny1 ($ppmdeviceny+196/1024*$ppmdeviceny)
		  set h1=sprintf('%dx',$nx1)
		  set h2=sprintf('%d',$ny1)
		  set _crap=h1+h2
		  define rescommand2 (_crap)
		  #
		  # 578x1220
		  define nx1 ($ppmdevicenx+66/512*$ppmdevicenx)
		  define ny1 ($ppmdeviceny+196/1024*$ppmdeviceny)
		  set h1=sprintf('%dx',$nx1)
		  set h2=sprintf('%d',$ny1)
		  set _crap=h1+h2
		  define rescommand3 (_crap)
		  #
		  # 620x1220
		  define nx1 ($ppmdevicenx+108/512*$ppmdevicenx)
		  define ny1 ($ppmdeviceny+196/1024*$ppmdeviceny)
		  set h1=sprintf('%dx',$nx1)
		  set h2=sprintf('%d',$ny1)
		  set _crap=h1+h2
		  define rescommand4 (_crap)
		  #
		  # COLOR IMAGE RESIZE OF CANVAS
		  # TOP
		  ! montage $truecolorname        -gravity South -background black -geometry $rescommand1  -colors 256 $truecolorname.c.ppm
		  # Don't delete original interpolated image
		  # BOTTOM
		  ! montage $truecolorname.c.ppm  -gravity North -background black -geometry $rescommand2 $truecolorname.d.ppm
		  # LEFT
		  ! montage $truecolorname.d.ppm  -gravity East -background black -geometry $rescommand3 $truecolorname.e.ppm
		  # RIGHT
		  ! montage $truecolorname.e.ppm  -gravity West -background black -geometry $rescommand4 $truecolorname.f.ppm
		  # RESIZE to original size to fit back
		  ! convert $truecolorname.f.ppm  -resize $finalsizecommand! $truecolorname.final.png
		  #
		  # make black region transparent for field line PPM (has to become png to keep transparency setting)
		  # also resize
		  ! convert $truefieldname $truefieldname.png
		  ! convert $truefieldname.png -colors 2 -negate -transparent black -resize $finalfieldsizecommand! $truefieldname.final.png
		  #
		  # COMPOSITE (output can be ppm)
		  ! composite $truefieldname.final.png $truecolorname.final.png $truecomposname.final.ppm
		  #
		  # force back to 256 colors
		  ! convert -colorspace RGB -colors 256 -resize $finalncommand! $truecomposname.final.ppm $truecomposname.final.ras
		  # convert back to 256 color PPM
		  ! convert $truecomposname.final.ras  -colorspace RGB -depth 8 -colors 256  $truecomposname
		  #
		  # remove temporary files
		  if($removetempfiles){\
		  ! rm -rf $truecolorname.c.ppm
		  ! rm -rf $truecolorname.d.ppm
		  ! rm -rf $truecolorname.e.ppm
		  ! rm -rf $truecolorname.f.ppm
		  ! rm -rf $truecolorname.final.png
		  #
		  ! rm -rf $truecomposname.final.ppm
		  ! rm -rf $truecomposname.final.ras
		  #
		  ! rm -rf $truefieldname.final.ppm $truecolorname.final.ppm
		  ! rm -rf $truefieldname.trans.ppm
		  ! rm -rf $truefieldname.final.png
		  #
		  }
		  #
		  #
oldmontagetests 0         #
		  ! convert $truefieldname -negate -transparent black $truefieldname.png
		  # create 712x1224 region with black border
		  #! montage $truecolorname -geometry $origsizecommand -gravity NorthWest -bordercolor black -borderwidth $bordercommand $truecolorname.c.ppm
		  #! montage $truecolorname -geometry $origsizecommand+0+50 -gravity North -bordercolor black -borderwidth 0x50 $truecolorname.c.ppm
		  #! montage $truecolorname -geometry $origsizecommand -gravity North -bordercolor black -borderwidth 50x50 -background black $truecolorname.c.ppm
		  ! montage $truecolorname  -gravity North -background black -geometry $origsizecommand+0+50 -bordercolor black -borderwidth 0x50 $truecolorname.c.ppm
		  ! montage $truecolorname.c.ppm  -gravity West -background black -geometry $origsizecommand+40+0 -bordercolor black -borderwidth 40x0 $truecolorname.cc.ppm
		  # crop off the stupid white border it places on also
		  #! convert $truecolorname.cc.ppm -crop $cropsizecommand+$cropbordercommand $truecolorname.d.ppm
		  ! convert $truecolorname.cc.ppm -resize $finalsizecommand! $truecolorname.png
		  ! convert $truefieldname.png -resize $finalfieldsizecommand! $truefieldname.2.png
		  ! composite $truefieldname.2.png $truecolorname.png $truecomposname
		  #
avery 0               #
		readanimpc fieldline0550 550
		computeanimpc
		#
		define PLOTERASE 1
averyplot 0     #
		avery
		boxcutters
		plc 0 newiaphi
		erase
		box
		set lev=-.0015,0.1938,$(.2/10)
		lweight 3
		levels lev    
		contour
radialedge 0    #
		#                       #
		set tt=0,pi,.001
		set myx=Routold*sin(tt)
		set myz=Routold*cos(tt)
		connect myx myz
		#
		set myx=$rhor*sin(tt)
		set myz=$rhor*cos(tt)
		connect myx myz
		#
makeflfli 1       # make ppm2fli movie
		#
		#
		#
		setupzoomdirs
		#
		#
		#
		!ls $aphidir/$1*.ppm > $aphidir/tmp.lis
		!rm -rf $aphidir/$1.fli
		!ppm2fli -p/home/jon/research/current/bin/i/john.pal -N -g $flinx'x'$fliny  -s 0 $aphidir/tmp.lis $aphidir/$1.fli
		if($removetempfiles){\
		       !rm -rf $aphidir/tmp.lis
		}
		#
		#
		#
makeimagefli 1  #
		#
		#
		setupzoomdirs
		#
		#
		#
		!ls $iimagesdir/i$1*.ppm > $iimagesdir/tmp.lis
		!rm -rf $iimagesdir/i$1.fli
		!ppm2fli -p/home/jon/research/current/bin/i/john.pal -N -g $flinx'x'$fliny  -s 0 $iimagesdir/tmp.lis $iimagesdir/i$1.fli
		if($removetempfiles){\
		       !rm -rf $iimagesdir/tmp.lis
		}
		#
		#
makecompositefli 2 #
		#
		setupzoomdirs
		#
		#
		#
		!ls $composdir/$1$2*.ppm > $composdir/tmp.lis
		!rm -rf $composdir/$1$2.fli
		!ppm2fli -N -g $flinx'x'$fliny  -s 0 $composdir/tmp.lis $composdir/$1$2.fli
		if($removetempfiles){\
		       !rm -rf $composdir/tmp.lis
		}
		#
		#
		#
		#
		#
