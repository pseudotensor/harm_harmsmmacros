crapodoink 0		#
		#jre levinson.m
		#mycons
		#setjet1
		#
setdxdxpold 0   #
		# dxdxp[bl-coord in ks][ks']
		set _defcoord=0
		set dxdxp00=dxdxp1*0+1
		set dxdxp01=0
		set dxdxp02=0
		set dxdxp03=0
		#
		set dxdxp10=0
		set dxdxp11=dxdxp1
		set dxdxp12=0
		set dxdxp13=0
		#
		set dxdxp20=0
		set dxdxp21=0
		set dxdxp22=dxdxp2
		set dxdxp23=0
		#
		set dxdxp30=0
		set dxdxp31=0
		set dxdxp32=0
		set dxdxp33=dxdxp1*0+1
		#
generatetavg 0  #
		# for Rout=40 or so
		if(0){\
		       define startdump (20)
		       define enddump (40)
		    }
		#		
		# for Rout=400 or so
		if(0){\
		       define startdump (36)
		       define enddump (40)
		    }
		#
		# for /raid1/jmckinne/exp2grid.floor0dc7/dumps/
		if(0){\
		       define startdump (230)
		       define enddump (243)
		    }
		#
		# for /raid1/jmckinne/exp2grid.floor0/dumps/
		if(0){\
		       define startdump (270)
		       define enddump (280)
		    }
		#
		#/raid1/jmckinne/jetresfl1
		if(1){\
		       define startdump (51)
		       define enddump (56)
		    }
		#
		#/raid1/jmckinne/jetresfl1 (for initial turbulent zoom)
		if(0){\
		       define startdump (4)
		       define enddump (8)
		    }
		#
		#/raid1/jmckinne/jetresfl0
		if(0){\
		       define startdump (38)
		       define enddump (42)
		    }
		#
		#
		# all dxdxp's
		gammiegridnew3 gdump
		jrdp dump0000
		#
		avgtimeg4 'dump' $startdump $enddump
		printg42 tavg4.2.txt
		avgtimeg3 'dump' $startdump $enddump
		printg3 tavg3.2.txt
		avgtimegfull 'dump' $startdump $enddump
		gwritedump dumptavg2
		avgtimeg5 'dump' $startdump $enddump
		printg5 tavg5.2.txt
		#
setupdumpjet1   0        # get time-averaged data
		# old data with pair creation
		# assume data made using generatetavg
		#
		# all dxdxp's
		gammiegridnew3 gdump
		#
		# quantities
		greaddump dumptavg
		# stresses, not needed
		readg42 tavg4.txt
		#
		# magnetic terms, such as omegaf2 in various forms
		readg3 tavg3.txt
		#
		# force and Lorentz factor terms
		readg5 tavg5.txt
		#
setupdumpjet   0        # get time-averaged data
		# assume data made using generatetavg
		# new data with floor model
		#
		# all dxdxp's
		gammiegridnew3 gdump
		set _n3=1
		set _startx3=0
		set _dx3=2*pi
		#
		# quantities
		greaddump dumptavg2
		# stresses, not needed
		readg42 tavg4.2.txt
		#
		# magnetic terms, such as omegaf2 in various forms
		readg3 tavg3.2.txt
		#
		# force and Lorentz factor terms
		readg5 tavg5.2.txt
		#
setupdumpdisk   0        # get time-averaged data
		# assume data made using generatetavg
		#
		# all dxdxp's
		gammiegridnew3 gdump
		#
		# quantities
		greaddump dumptavgi
		# stresses, not needed
		#readg42 tavg4i.txt
		#
		# magnetic terms, such as omegaf2 in various forms
		readg3 tavg3i.txt
		#
		# force and Lorentz factor terms
		readg5 tavg5i.txt
		#
lightcylinders 0 #
		#
		set rergo=1+sqrt(1-a**2*cos(h)**2)
		set myzeroergo=r-rergo
		set myzerohorizon=r-$rhor
		#
		# geometry stuff
		set Delta=(r**2-2*r+a**2)
		set Sigma=(r**2+(a*cos(h))**2)
		set gv333bl=sin(h)**2*((a**2+r**2)**2-a**2*Delta*sin(h)**2)/Sigma
		set gv311bl=Sigma/Delta
		#
		# compute light cylinders
		#
		#set Delta=r**2-2*r+a**2
		#set Sigma=r**2+(a*cos(h))**2
		#set godR=sqrt(Sigma)*sin(h)
		#set godR=sqrt(Delta)*sin(h)
		#set light1=1-1/(wf2tavg*godR)
		#set light2=1-1/(awf2tavg*godR)
		#set light3=1-1/(a2wftavg*godR)
		#
		# ZAMO time (in KS frame coordinates)
		set alpha=sqrt(-gv300)
		set wz=-gv303/gv333
		# cylindrical radial coordinate
		set grR=sqrt(gv333)
		# inner light cylinder as measured in ZAMO frame
		# inner light cylinder not found, must be inside ergosphere?
		# means wf2>wz
		set ilight1=1-alpha/((grR*(wz-wf2tavg)))
		set ilight2=1-alpha/((grR*(wz-awf2tavg)))
		set ilight3=1-alpha/((grR*(wz-a2wftavg)))
		# outer coincides with normal light cylinder since wz~0 out there
		set olight1=1-alpha/((grR*(wf2tavg-wz)))
		set olight2=1-alpha/((grR*(awf2tavg-wz)))
		set olight3=1-alpha/((grR*(a2wftavg-wz)))
		#
		# this basically coindices with olight since wz small at large radii
		# never goes -c?, apparently.  Need counter-rotating flow?
		# inner light cylinder real, goes just before ergosphere but not right on it.  This is why nothing generated in contours right on ergosphere.
		# global coordinate time
		set light1=1-1/((grR*(wf2tavg)))
		set light2=1-1/((grR*(awf2tavg)))
		set light3=1-1/((grR*(a2wftavg)))
		#
		# this is basically where ilight/olight show up since they diverge
		set nulllight1=wf2tavg-wz
		set nulllight2=awf2tavg-wz
		set nulllight3=a2wftavg-wz
		#
		# check agreement with uu1=0 (basically same as when uu1=0, good)
		set nullvel1=wf2tavg-omega3
		set nullvel2=awf2tavg-omega3
		set nullvel3=a2wftavg-omega3
		#
		#
		# if region isn't time-varying much, this is accurate (i.e. instead of time averaging each)
		# below 2 just for reference/comparison of form of equation
		#set RB3=sqrt(ABS(cgv333bl))*cB3bl
		#set RB1=sqrt(ABS(cgv311bl))*cB1bl
		#set alphapitch=1-ABS(RB1/RB3)
		#set alphapitch=1-ABS(B1bltavg/(sqrt(gv333bl)*B3bltavg))
		set alphapitch=1-ABS(sqrt(gv311bl)*B1bltavg/(sqrt(gv333bl)*B3bltavg))
		#set alphapitch=1-ABS(B1bltavg/Bd3bltavg)
		#
		################################################################################
		# char surface plot related stuff
loglogbox 0     #
		set myRin=trueRin*0.5
		set myRout=trueRout
		#
		ctype default
		erase
		define coord (1)
		ticksize -1 0 -1 0
		define x1in (LG(myRin))
		define x1out (LG(myRout))
		define x2in (LG(myRin))
		define x2out (LG(myRout))
		limits $x1in $x1out $x2in $x2out
		box
		xla "R c^2/GM"
		yla "z c^2/GM"
		# screwy limits for plc
		define my2Rout (trueRout*0.999)
		limits 0 $my2Rout 0 $my2Rout
		#
loglogbox2 0     #
		set myRin=trueRin*0.5
		set myRout=trueRout
		#
		ctype default
		erase
		define coord (1)
		ticksize -1 0 -1 0
		define x1in (LG(myRin))
		define x1out (LG(myRout))
		define x2in (LG(myRout))
		define x2out (LG(myRin))
		limits $x1in $x1out $x2in $x2out
		box
		xla "R c^2/GM"
		yla "z c^2/GM"
		# screwy limits for plc
		define my2Rout (trueRout*0.999)
		#limits 0 $my2Rout 0 $my2Rout
		limits 0 $my2Rout -$my2Rout 0
		#
loglogplc  1    # after doing something like:
		# interpsingle aphi 384 768 _Rout _Rout 1
		# do: loglogplc iaphi
		#
		# choose which pole to look at
		if($WHICHPOLE==0){\
		       loglogbox
		    }
		    if($WHICHPOLE==1){\
		           loglogbox2
		        }
		plc 0 $1 010
		#
		#
logloggridplot 0 #
		# after doing:
		#
		interpsingle r 384 768 _Rout _Rout 1
		interpsingle h 384 768 _Rout _Rout 1
		readinterp r
		readinterp h
		#
		loglogbox
		#
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 ih 010
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 ir 010
		#
cartgridplot 0 #
		# after doing:
		#
		interpsingle r 384 768 _Rout _Rout 0
		interpsingle h 384 768 _Rout _Rout 0
		readinterp r
		readinterp h
		#
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 ih 001 0 Rout 0 Rout
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 ir 011 0 Rout 0 Rout
		#
		#
dosurf 0        # uses below, example
		#
		setupdumpjet
		dosurfplot aphi 0
		#
		#
dosurfplot 2    # dosurfplot aphi 1
		# dosurfplot <0=noninterp/1=interp_loglog>
		#
		# presume have done: greaddump dumptavg and whatnot from above (i.e.)
		# setupdumpjet
		#
		define WHICHPOLE 0
		lightcylinders
		#
		surfcut
		setupsurf $1 $2
		#
		# plot interesting background
		preplot $1 $2
		#
		# do the characteristics plots
		setupsurf2 $1 $2
		plotsurf $1 $2
		#
replotsurf 2    # e.g. replotsurf aphi 1
		plotsfirst $1 $2
		plotsurf $1 $2
		#
surfcut 0       #
		# set up cutting function
		#
		set lastaphi=0.11
		#
		set r0=1.0
		set rs=0.9
		set njet=0.4
		set r0j=4
		set rjout=200
		set thjout=0.23
		#
		set myg=(1/2+1/pi*atan(r/r0-rs))
		set myfun2=(r<rjout) ? (r/r0j)**(-njet*myg) : thjout
		#
		# changed this and choose loglogbox(or 2)
		if($WHICHPOLE==0){\
		       # below for around theta=0 pole, happens to be z=-400 in iinterp definition
		       set myuse2=(h<myfun2) ? 1 : 0
		    }
		if($WHICHPOLE==1){\
		             # for around both poles
		             #set myuse2=(ABS(h-pi/2)>pi/2+myfun2) ? 1 : 0
		             set myuse2=(h>pi-myfun2) ? 1 : 0
		           }
		# lastaphi cut gets rid of last bit of junk at edge, only good field lines
		set myuse3=((myuse2==1)&&(aphi<=lastaphi)) ? 1 : 0
		#
surfcutpulsar 0       #
		# set up cutting function
		#
		set myuse3=1*r/r
		#
setupsurf 2      # uses cutting function to grab only part of space we want
		# applied BEFORE interpolation
		#
		# setup background function, no truncation
		#set my$1=$1
		# well, let's cut it, looks ugly
		set my$1=(myuse3==1) ? $1 : 1E-8
		#
		set mytfastv1p=(myuse3==1) ? tfastv1p : 1E-8
		set mytslowv1p=(myuse3==1) ? tslowv1p : 1E-8
		set mysonicv1p=(myuse3==1) ? sonicv1p : 1E-8
		set myalfvenv1p=(myuse3==1) ? alfvenv1p : 1E-8
		#
		set myuu1=(myuse3==1) ? uu1 : 1E-8
		set myalphapitch=(myuse3==1) ? alphapitch : 1E-8
		#
		set mylight1=((myuse3==1)) ? light1 : 1E-8
		set mylight2=((myuse3==1)) ? light2 : 1E-8
		set mylight3=((myuse3==1)) ? light3 : 1E-8
		set mynulllight1=((myuse3==1)) ? nulllight1 : 1E-8
		set mynulllight2=((myuse3==1)) ? nulllight2 : 1E-8
		set mynulllight3=((myuse3==1)) ? nulllight3 : 1E-8
		set mynulllight1=((myuse3==1)) ? nulllight1 : 1E-8
		set mynulllight2=((myuse3==1)) ? nulllight2 : 1E-8
		set mynulllight3=((myuse3==1)) ? nulllight3 : 1E-8
		set myilight1=((myuse3==1)&&(ABS(ilight1<.1))) ? ilight1 : 1E-8
		set myilight2=((myuse3==1)&&(ABS(ilight1<.1))) ? ilight2 : 1E-8
		set myilight3=((myuse3==1)&&(ABS(ilight1<.1))) ? ilight3 : 1E-8
		set myolight1=((myuse3==1)) ? olight1 : 1E-8
		set myolight2=((myuse3==1)) ? olight2 : 1E-8
		set myolight3=((myuse3==1)) ? olight3 : 1E-8
		#
		set mytfastv1m=(myuse3==1) ? tfastv1m : 1E-8
		set mytslowv1m=(myuse3==1) ? tslowv1m : 1E-8
		set mysonicv1m=(myuse3==1) ? sonicv1m : 1E-8
		set myalfvenv1m=(myuse3==1) ? alfvenv1m : 1E-8
		#
		#
preplot  2      # determines what kind of plot to do
		# 0=normal nonlog noninterpolated (r,theta)
		# 1=loglog interpolation
		#
		if($2==0){\
		       set imy$1=my$1
		set imytfastv1p=mytfastv1p
		set imytslowv1p=mytslowv1p
		set imysonicv1p=mysonicv1p
		set imyalfvenv1p=myalfvenv1p
		#
		set imyuu1=myuu1
		set imyalphapitch=myalphapitch
		#
		set imylight1=mylight1
		set imylight2=mylight2
		set imylight3=mylight3
		set imynulllight1=mynulllight1
		set imynulllight2=mynulllight2
		set imynulllight3=mynulllight3
		set imynulllight1=mynulllight1
		set imynulllight2=mynulllight2
		set imynulllight3=mynulllight3
		set imyilight1=myilight1
		set imyilight2=myilight2
		set imyilight3=myilight3
		set imyolight1=myolight1
		set imyolight2=myolight2
		set imyolight3=myolight3
		#
		set imytfastv1m=mytfastv1m
		set imytslowv1m=mytslowv1m
		set imysonicv1m=mysonicv1m
		set imyalfvenv1m=myalfvenv1m
		#
		# no need to truncate with myiuse3
		set imyzeroergo=myzeroergo
		set imyzerohorizon=myzerohorizon
		 
		}
		#
		if($2==1){\

		 set trueRin=Rin
		 set trueRout=Rout
		 #
		 define newnx (512)
		 define newny (512)
		 define newxmax (_Rout)
		 define newymax (_Rout)
		 define newgridtype (1)
		 #
		 interpsingle my$1 $newnx $newny $newxmax $newymax $newgridtype
		 interpsingle mytfastv1p $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mytslowv1p $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mysonicv1p $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myalfvenv1p $newnx $newny $newxmax $newymax $newgridtype
		#
		interpsingle myuu1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myalphapitch $newnx $newny $newxmax $newymax $newgridtype
		#
		interpsingle mylight1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mylight2 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mylight3 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight2 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight3 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight2 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mynulllight3 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myilight1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myilight2 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myilight3 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myolight1 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myolight2 $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myolight3 $newnx $newny $newxmax $newymax $newgridtype
		#
		interpsingle mytfastv1m $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mytslowv1m $newnx $newny $newxmax $newymax $newgridtype
		interpsingle mysonicv1m $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myalfvenv1m $newnx $newny $newxmax $newymax $newgridtype
		#
		interpsingle myzeroergo $newnx $newny $newxmax $newymax $newgridtype
		interpsingle myzerohorizon $newnx $newny $newxmax $newymax $newgridtype
		#

		 readinterp my$1
		 readinterp mytfastv1p
		readinterp mytslowv1p
		readinterp mysonicv1p
		readinterp myalfvenv1p
		#
		readinterp myuu1
		readinterp myalphapitch
		#
		readinterp mylight1
		readinterp mylight2
		readinterp mylight3
		readinterp mynulllight1
		readinterp mynulllight2
		readinterp mynulllight3
		readinterp mynulllight1
		readinterp mynulllight2
		readinterp mynulllight3
		readinterp myilight1
		readinterp myilight2
		readinterp myilight3
		readinterp myolight1
		readinterp myolight2
		readinterp myolight3
		#
		readinterp mytfastv1m
		readinterp mytslowv1m
		readinterp mysonicv1m
		readinterp myalfvenv1m
		#
		readinterp myzeroergo
		readinterp myzerohorizon
		

		 
		}
		#
		#
plotsfirst 2     #
		#
		ltype 0
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		#
		if($2==0){ defaults lweight 5 plc 0 imy$1 }
		if($2==1){ defaults lweight 5 loglogplc imy$1 }
		#
		#
setupsurf2 2	# cut associated with background function's plot in plc
		# applied AFTER interpolation
		#
		plotsfirst $1 $2
		#
		if(($rnx!=$nx)||($rny!=$ny)){\
		# from shrink3, set same as original plc used for background function
		  set plcuse=( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh)) ? 1 : 0
		}\
		else{\
		         if($2==0){ set plcuse=0*imy$1+1 }
		         if($2==1){ set plcuse=0*imy$1+1 }
		}
		#
		# cut $1 for now
		set god$1=imy$1 if(plcuse)
		set godtfastv1p=imytfastv1p if(plcuse)
		set godtslowv1p=imytslowv1p if(plcuse)
		set godsonicv1p=imysonicv1p if(plcuse)
		set godalfvenv1p=imyalfvenv1p if(plcuse)
		#
		set goduu1=imyuu1 if(plcuse)
		set godalphapitch=imyalphapitch if(plcuse)
		#
		set godlight1=imylight1 if(plcuse)
		set godlight2=imylight2 if(plcuse)
		set godlight3=imylight3 if(plcuse)
		set godnulllight1=imynulllight1 if(plcuse)
		set godnulllight2=imynulllight2 if(plcuse)
		set godnulllight3=imynulllight3 if(plcuse)
		set godnulllight1=imynulllight1 if(plcuse)
		set godnulllight2=imynulllight2 if(plcuse)
		set godnulllight3=imynulllight3 if(plcuse)
		set godilight1=imyilight1 if(plcuse)
		set godilight2=imyilight2 if(plcuse)
		set godilight3=imyilight3 if(plcuse)
		set godolight1=imyolight1 if(plcuse)
		set godolight2=imyolight2 if(plcuse)
		set godolight3=imyolight3 if(plcuse)
		#
		set godtfastv1m=imytfastv1m if(plcuse)
		set godtslowv1m=imytslowv1m if(plcuse)
		set godsonicv1m=imysonicv1m if(plcuse)
		set godalfvenv1m=imyalfvenv1m if(plcuse)
		#
		# no need to truncate with imyuse3
		set godzeroergo=imyzeroergo if(plcuse)
		set godzerohorizon=imyzerohorizon if(plcuse)
		#
		#
		#
		#
		#
		#
		#
plotsurf 2      # actually plot the characteristic surfaces
		# applied AFTER interpolation
		#
		#
		lweight 5
		#
		# plot horizon and ergosphere
                set image[ix,iy] = godzerohorizon
                set lev=1E-10,1E-10,2E-10
                levels lev
		ctype green contour
                #
                set image[ix,iy] = godzeroergo
                set lev=1E-10,1E-10,2E-10
                levels lev
                ctype green contour
                #
		#
		set image[ix,iy]=godtfastv1p
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype blue contour
		set image[ix,iy]=godalfvenv1p
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype cyan contour
		#set image[ix,iy]=godsonicv1p
		#set lev=-1E-15,1E-15,2E-15
		#levels lev
		#ctype green contour
		set image[ix,iy]=godtslowv1p
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype magenta contour
		#
		set image[ix,iy]=goduu1
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ltype 2 ctype default contour
		#
		set image[ix,iy]=godalphapitch
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ltype 0 ctype default contour
		#
		set image[ix,iy]=godlight2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ltype 0 ctype green contour
		ltype 0
		#
		if(0){\
		set image[ix,iy]=godilight2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype blue contour
		}
		if(0){\
		#
		set image[ix,iy]=godolight2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype magenta contour
		}
		#
		if(0){\
		set image[ix,iy]=godnulllight2
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype magenta contour
		}
		#
		#
		set image[ix,iy]=godtslowv1m
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype magenta contour
		#set image[ix,iy]=godsonicv1m
		#set lev=-1E-15,1E-15,2E-15
		#levels lev
		#ctype blue contour
		set image[ix,iy]=godalfvenv1m
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype cyan contour
		set image[ix,iy]=godtfastv1m
		set lev=-1E-15,1E-15,2E-15
		levels lev
		ctype blue contour
		#
		#set image[ix,iy]=godr-399.0
		#set lev=-1E-15,1E-15,2E-15
		#levels lev
		#ctype blue contour
		#
		#
		#
		#
fitsurf1 1       # cylindrical fit
		#
		# fitting of light surface
		set image[ix,iy]=$1-grR
		set lev=-1E-9,1E-9,2E-9
		levels lev
		ctype magenta contour
		#
		#
fitsurf2 1       # spherical fit
		# fitting of light surface
		set image[ix,iy]=$1-r
		set lev=-1E-9,1E-9,2E-9
		levels lev
		ctype magenta contour
		#
		#
		#
		#
dodumpjet 0     # example go function
		#
		# 0=around 0 1=around pi
		define WHICHPOLE 0
		predumpjet
		dumpjet
		# then copy
		!tar cvzf caphidata.tgz caphidata.txt caphidata.head
		#!scp caphidata.tgz jon@bh.astro.uiuc.edu:
		!scp caphidata.tgz jon@relativity.cfa.harvard.edu:/home/jondata/contourdata/
		# then grab from bh onto relativity and use matlab to run joncontournew.m
		# then copy from relativity back to bh and then back to bh02(say)
		#!scp bh:contoursks.txt .
		#or
		!scp jon@relativity:/home/jondata/contourdata/contoursks.txt .
		# then do : 
		readcontours contoursks.txt
		#
		#
		########################################################################
predumpjet 0    # make sure data is truncated in correct way for desired aphi
		# assumes setupdumpjet run already
		#
		#
		# must change dumpjet below as well
		#
		# Rout=400 model
		if(0){\
		 set x2in=0
		 set x2out=0.5
		}
		#
		# fiducial model
		if(0){\
		       # cutting parameters
		 set myhin=1.0
		 set Rtorus=13
		 #
		 set x2in=0
		 set x2out=0.5
		 # for time averaged data from 20..40 dumps, outer jet peak uu0
		 #set aphicontour=0.044
		 # for time averaged data from 20..40 dumps, innermost funnel field line toward disk
		 set aphicontour=0.105
		}
		#
		# grmhd-a.9375-rout400new model
		if(0){\
		 set myhin=1.25
		 set Rtorus=30
		 #
		 set x2in=0
		 set x2out=0.5
		 set aphicontour=0.105
		}
		# grmhd-a.9375-routfloor1 model (works for above model too)
		if(0){\
		 ####
		 # for gaussian fit (not too good)
		 set myhin=1.20
		 set Rtorus=23.0
		 ###########
		 # for power law fit (pretty good!)
		 set r0j=2.9
		 set njet=0.29
		 ######################
		 # super fit
		 set r0=1.0
		 set rs=0.9
		 set njet=0.31
		 set r0j=4
		 #
		 #
		 set x2in=0
		 set x2out=0.5
		 # outermost
		 set aphicontour=0.105
		 # middle
		 # set aphicontour=0.05
		 # inner
		 #set aphicontour=0.01
		}
		# for /raid1/jmckinne/exp2grid.floor0dc7
		if(0){\
		 ####
		 # for gaussian fit (not too good)
		 set myhin=1.20
		 set Rtorus=23.0
		 ###########
		 # for power law fit (pretty good!)
		 set r0j=2.9
		 set njet=0.29
		 ######################
		 # super fit
		 set r0=1.1
		 set rs=-50
		 set njet=0.22
		 set r0j=6
		 #
		 # superfit2
		 #set r0=1.1
		 #set rs=-50
		 #set njet=0.27
		 #set r0j=8
		 #
		 #
		 set x2in=0
		 set x2out=0.5
		 # outermost
		 #set aphicontour=0.105
		 set aphicontour=0.09
		 # middle
		 # set aphicontour=0.05
		 # inner
		 #set aphicontour=0.01
		}
		#
		# for /raid1/jmckinne/exp2grid.floor0
		if(0){\
		 ####
		 # for gaussian fit (not too good)
		 set myhin=1.20
		 set Rtorus=23.0
		 ###########
		 # for power law fit (pretty good!)
		 set r0j=2.9
		 set njet=0.29
		 ######################
		 # super fit
		 set r0=1.1
		 set rs=-50
		 set njet=0.22
		 set r0j=4
		 #
		 # superfit2
		 #set r0=1.1
		 #set rs=-50
		 #set njet=0.27
		 #set r0j=8
		 #
		 #
		 set x2in=0
		 set x2out=0.5
		 # outermost
		 #set aphicontour=0.105
		 set aphicontour=0.09
		 # middle
		 # set aphicontour=0.05
		 # inner
		 #set aphicontour=0.01
		}
		#
		# for /raid1/jmckinne/jetresfl1
		if(1){\
		 ####
		 # for gaussian fit (not too good)
		 set myhin=1.20
		 set Rtorus=23.0
		 ###########
		 # for power law fit (pretty good!)
		 set r0j=2.9
		 set njet=0.29
		 ######################
		 # super fit
		 set r0=1.1
		 set rs=-50
		 set njet=0.25
		 set r0j=4
		 #
		 set x2in=0
		 set x2out=0.5
		 # outermost
		 #set aphicontour=0.09
		 #set rjout=400
		 #set thjout=0.33
		 # middle
		 #set aphicontour=0.05
		 #set rjout=400
		 #set thjout=0.20
		 # inner
		 set aphicontour=0.01
		 set rjout=400
		 set thjout=0.2
		}
		#
		# plot aphi
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		plc 0 aphitavg
		#
		define innercontour (aphicontour)
		define outercontour (aphicontour*1.0001)
		define dcontour ($outercontour-$innercontour)
		set lev=$innercontour,$outercontour,$dcontour
		levels lev
		ctype blue contour
		#
		#
		set myg=(1/2+1/pi*atan(r/r0-rs))
		if($WHICHPOLE==0){\
		       # choose one pole
		       set myfun2=(r<rjout) ? (r/r0j)**(-njet*myg) : thjout
		       set myuse2=(h<myfun2) ? 1 : 0
		    }
		#
		if($WHICHPOLE==1){\
		       # chooser other pole
		       set myfun2=(r<rjout) ? pi-(r/r0j)**(-njet*myg) : pi-thjout
		       set myuse2=(h>myfun2) ? 1 : 0
		    }
		#
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		plc 0 myuse2 010
		#
		set newaphi=(myuse2==1) ? aphitavg : 0
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		plc 0 newaphi 010
		#
		define innercontour (aphicontour)
		define outercontour (aphicontour*1.0001)
		define dcontour ($outercontour-$innercontour)
		set lev=$innercontour,$outercontour,$dcontour
		levels lev
		ctype blue contour
		#
		#
dumpjet  0      # dump data for matlab to generate contours along field lines
		#
		# uses predumpjet first
		#
		if($WHICHPOLE==0){\
		       set myuse=((tx2>=x2in)&&(tx2<=x2out)) ? 1 : 0
		    }
		if($WHICHPOLE==1){\
		           set myuse=((tx2<=1-x2in)&&(tx2>=1-x2out)) ? 1 : 0
		        }
		#
		#
		# # of terms
		set numterms1=25
		#
		set myr=r if(myuse)
		set myh=h if(myuse)
		set myti=ti if(myuse)
		set mytj=tj if(myuse)
		set myx1=tx1 if(myuse)
		set myx2=tx2 if(myuse)
		set myaphi=aphi if(myuse)
		set myw1=wf2tavg if(myuse)
		set myw2=awf2tavg if(myuse)
		set myw3=a2wftavg if(myuse)
		set myuu1=uu1 if(myuse)
		#
		set mytfastv1p=tfastv1p if(myuse)
		set mytfastv1m=tfastv1m if(myuse)
		set mytslowv1p=tslowv1p if(myuse)
		set mytslowv1m=tslowv1m if(myuse)
		set mysonicv1p=sonicv1p if(myuse)
		set mysonicv1m=sonicv1m if(myuse)
		set myalfvenv1p=alfvenv1p if(myuse)
		set myalfvenv1m=alfvenv1m if(myuse)
		#
		set mybsq=bsq if(myuse)
		set myB1=B1 if(myuse)
		set myB3=B3 if(myuse)
		set mylbrel=lbrel if(myuse)
		set myrho=rho if(myuse)
		set myu=u if(myuse)
		#
		# # of terms
		set numterms2=26+8
		#
		set myEN1=EN1tavg if(myuse)
		set myLN1=LN1tavg if(myuse)
		set myeta1=eta1tavg if(myuse)
		set myD2=D2tavg if(myuse)
		set myB1bl=B1bltavg if(myuse)
		set myB2bl=B2bltavg if(myuse)
		set myB3bl=B3bltavg if(myuse)
		set myBd3bl=Bd3bltavg if(myuse)
		set myuu0bl=uu0bltavg if(myuse)
		set myuu1bl=uu1bltavg if(myuse)
		set myuu2bl=uu2bltavg if(myuse)
		set myuu3bl=uu3bltavg if(myuse)
		set myud0bl=ud0bltavg if(myuse)
		set myud1bl=ud1bltavg if(myuse)
		set myud2bl=ud2bltavg if(myuse)
		set myud3bl=ud3bltavg if(myuse)
		set myaccem=accemtavg if(myuse)
		set myaccma=accmatavg if(myuse)
		set mycollma=collmatavg if(myuse)
		set mycollema=collematavg if(myuse)
		set mycollemb=collembtavg if(myuse)
		set mygammainf=gammainftavg if(myuse)
		#
		set myacctem=acctrueemtavg-accemtavg if(myuse)
		set mycolltem=colltrueemtavg-collematavg-collembtavg if(myuse)
		set myacctrueem=acctrueemtavg if(myuse)
		set mycolltrueem=colltrueemtavg if(myuse)
		#
		#
		set myemefluxalongB=emefluxalongBtavg if(myuse)
		set mymaefluxalongB=maefluxalongBtavg if(myuse)
		set myemlfluxalongB=emlfluxalongBtavg if(myuse)
		set mymalfluxalongB=malfluxalongBtavg if(myuse)
		#
		set myemefluxacrossB=emefluxacrossBtavg if(myuse)
		set mymaefluxacrossB=maefluxacrossBtavg if(myuse)
		set myemlfluxacrossB=emlfluxacrossBtavg if(myuse)
		set mymalfluxacrossB=malfluxacrossBtavg if(myuse)
		#
		#
		#
		if(0){\
		 set slope=(0.3-1.0)/(_Rout-_Rin)
		 set myuse2=(myh<1.0+slope*(myr-_Rin)) ? 1 : 0
		}
		#
		if(0){\
		 set mysig=LG(Rtorus)
		 set myfunin=gauss(LG(Rin),0,mysig)
 		 set myfun2=(myhin/myfunin)*(gauss(LG(myr),0,mysig))
		 set myuse2=(myh<myfun2) ? 1 : 0
		}
		if($WHICHPOLE==0){\
		 set myg=(1/2+1/pi*atan(myr/r0-rs))
		 set myfun2=(myr<rjout) ? (myr/r0j)**(-njet*myg) : thjout
		 set myuse2=(myh<myfun2) ? 1 : 0
		}
		if($WHICHPOLE==1){\
		 # for other pole
		 set myg=(1/2+1/pi*atan(myr/r0-rs))
		 set myfun2=(myr<rjout) ? pi-(myr/r0j)**(-njet*myg) : pi-thjout
		 set myuse2=(myh>myfun2) ? 1 : 0
		}
		#
		#
		set myaphi2=(myuse2==1) ? myaphi : 1E30
		#
		#
		#
		#
		define print_noheader (1)
		print "caphidata.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {myr myh myti mytj myx1 myx2 \
		       myaphi2 myw1 myw2 myw3 \
		       myuu1 mytfastv1p mytfastv1m mytslowv1p mytslowv1m mysonicv1p mysonicv1m myalfvenv1p myalfvenv1m mybsq myB1 myB3 mylbrel myrho myu \
		    myEN1 myLN1 myeta1 myD2 \
		    myB1bl myB2bl myB3bl myBd3bl \
		    myuu0bl myuu1bl myuu2bl myuu3bl myud0bl myud1bl myud2bl myud3bl \
		    myaccem myaccma mycollma mycollema mycollemb mygammainf \
		    myacctem mycolltem myacctrueem mycolltrueem \
		    myemefluxalongB mymaefluxalongB myemlfluxalongB mymalfluxalongB \
		    myemefluxacrossB mymaefluxacrossB myemlfluxacrossB mymalfluxacrossB }
		#
		#
		set is=myti[0]
		set ie=myti[dimen(myti)-1]
		set newnx=ie-is+1
		set js=mytj[0]
		set je=mytj[dimen(myti)-1]
		set newny=je-js+1
		#
		set numcolumns=numterms1+numterms2
		#
		set count=numcolumns*newnx*newny
		print "caphidata.head" '%21.15g %d %d %d %d\n' {aphicontour numcolumns newnx newny count}
		#
		#
		#
		#
		#
		#
		#
		#
		#
readcontours 1  # read in contours generated by matlab after processed using joncontoursnew.m and above dumpjet and setupdumpjet
		#
		# readcontours contours.txt
		# readcontours contoursks.txt
		#
		define x1label "r c^2/GM"
		define x2label "Value"
		#
		da $1
		lines 1 10000000
		# cfastv1p turns negative near horizon
		# cfastv1m turns positive if outflow is superfast (radially)
		#
		# matlab starts with second column here to fill contourdata multidimensional array
		# 1 new radius coordinate + numcolumns1+numcolumns2 other contours from matlab
		# 1,6,4,15,4,4,8,6,4,8 = 60
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {cc \
		       cr ch cti ctj cx1 cx2 \
		       caphi cw1 cw2 cw3 \
		       cuu1 ctfastv1p ctfastv1m ctslowv1p ctslowv1m csonicv1p csonicv1m calfvenv1p calfvenv1m cbsq cB1 cB3 clbrel crho cu \
		    cEN1 cLN1 ceta1 cD2 \
		    cB1bl cB2bl cB3bl cBd3bl \
		    cuu0bl cuu1bl cuu2bl cuu3bl cud0bl cud1bl cud2bl cud3bl \
		    caccem caccma ccollma ccollema ccollemb cgammainf \
		    cacctem ccolltem cacctrueem ccolltrueem \
		    cemefluxalongB cmaefluxalongB cemlfluxalongB cmalfluxalongB \
		    cemefluxacrossB cmaefluxacrossB cemlfluxacrossB cmalfluxacrossB }
		#
		##########
		# some geometry stuff that is not time-dependent so can be done here
		set cDelta=(cr**2-2*cr+a**2)
		set cSigma=(cr**2+(a*cos(ch)))
		set csinsq=sin(ch)**2
		set cgeofact=-cDelta*csinsq
		set cgv300bl=-1+2*cr/(cr**2+a**2*cos(ch)**2)
		set cgv333bl=sin(ch)**2*((a**2+cr**2)**2-a**2*cDelta*sin(ch)**2)/cSigma
		set cgv322bl=cSigma
		set cgv311bl=cSigma/cDelta
		set cgrR=sqrt(cgv333bl)
		#
		#
		set coB1=cB1bl*sqrt(cgv311bl)
		set coB2=cB2bl*sqrt(cgv322bl)
		set coB3=cB3bl*sqrt(cgv333bl)
		#
		set couu0=cuu0bl*sqrt(cgv300bl) # Lorentz factor (W)
		set couu1=cuu1bl*sqrt(cgv311bl)
		set couu2=cuu2bl*sqrt(cgv322bl)
		set couu3=cuu3bl*sqrt(cgv333bl)
		#
		############
		# some non-multiplicative stuff, so can go here
		#
		set ccollem=ccollema+ccollemb
		# below 2 now really right since ignoring time-dependent pressure force in (ma) part
		set ccolltot=ccollma+ccolltrueem
		set cacctot=caccma+cacctrueem
		#
truncall 0      # (regexp'ed list in readcontours)
		#
		truncate cc
		truncate cr
		truncate ch
		truncate cti
		truncate ctj
		truncate cx1
		truncate cx2
		truncate caphi
		truncate cw1
		truncate cw2
		truncate cw3
		truncate cuu1
		truncate ctfastv1p
		truncate ctfastv1m
		truncate ctslowv1p
		truncate ctslowv1m
		truncate csonicv1p
		truncate csonicv1m
		truncate calfvenv1p
		truncate calfvenv1m
		truncate cbsq
		truncate cB1
		truncate cB3
		truncate clbrel
		truncate crho
		truncate cu
		truncate cEN1
		truncate cLN1
		truncate ceta1
		truncate cD2
		truncate cB1bl
		truncate cB2bl
		truncate cB3bl
		truncate cBd3bl
		truncate cuu0bl
		truncate cuu1bl
		truncate cuu2bl
		truncate cuu3bl
		truncate cud0bl
		truncate cud1bl
		truncate cud2bl
		truncate cud3bl
		truncate caccem
		truncate caccma
		truncate ccollma
		truncate ccollema
		truncate ccollemb
		truncate cgammainf
		truncate cacctem
		truncate ccolltem
		truncate cacctrueem
		truncate ccolltrueem
		truncate cemefluxalongB
		truncate cmaefluxalongB
		truncate cemlfluxalongB
		truncate cmalfluxalongB
		truncate cemefluxacrossB
		truncate cmaefluxacrossB
		truncate cemlfluxacrossB
		truncate cmalfluxacrossB
		#
		# post-readcontours
		truncate cgrR
		truncate coB1
		truncate coB2
		truncate coB3
		truncate couu1
		truncate couu2
		truncate couu3
		truncate ccollem
		truncate ccolltot
		truncate cacctot
		#
		#
		#
		#
truncate 1       #
		# For large Rout models, field can wind back around, hard to truncate in SM, so truncate afterwards
		set i=1,dimen(cr),1
		# exp2grid.floor0dc7 up to point ch curves back
		#set tcr=cr if(i<547)
		#set t$1=$1 if(i<547)
		# exp2grid.floor0dc7 up to point curving likely influences flow
		#
		# works for outer field line in jetresfl1 currently
		if(trunctype==-1){\
		       set iouter=570
		       set use=((i<iouter)&&(i>1)) ? 1 : 0
		    }
		if(trunctype==0){\
		       set iouter=530
		       set use=((i<iouter)&&(i>1)) ? 1 : 0
		    }
		if(trunctype==1){\
		           # other pole
		           #set use=((i<=603)) ? 1 : 0
		           set use=((i<=603)&&(cr<5E3)) ? 1 : 0
		        }
		if(trunctype==2){\
		           # inner
		           set use=((i<=572)) ? 1 : 0
		        }
		if(trunctype==3){\
		       set iouter=530
		       set use=((i<iouter)&&(i>1)&&(i>21)) ? 1 : 0
		    }
		#
		set tcr=cr if(use)
		set t$1=$1 if(use)
		#
		#
truncate2 1       #
		# For large Rout models, field can wind back around, hard to truncate in SM, so truncate afterwards
		# exp2grid.floor0 up to bad cut
		set i=1,dimen(cr),1
		set tcr=cr if(i<513)
		set t$1=$1 if(i<513)
		#
selfsim1 0      #
		fdraft
		define PLOTLWEIGHT (7)
                define NORMLWEIGHT (5)
		set RB3=sqrt(ABS(cgv333bl))*cB3bl
		set RB1=sqrt(ABS(cgv311bl))*cB1bl
		#
		define x1label "r c^2/GM"
		define x2label "B^\phi , |b| , B^r"
		ctype default pl 0 cr RB3 1101 1.6 Rout 1E-5 1
		#ctype green pl 0 cr cB3bl 1111 1.6 Rout 1E-6 10
		#
		lweight 3
		#ctype default pl 0 cr cB1bl 1111 1.6 Rout 1E-6 10
		#ctype red pl 0 cr cB1bl 1111 1.6 Rout 1E-6 10
		ctype red pl 0 cr RB1 1111 1.6 Rout 1E-6 10
		set cabsb=sqrt(cbsq)
		ctype blue pl 0 cr cabsb 1110
		#
		#
selfsim22 0     #
		readcontours contoursks.txt
		selfsim2
		readcontours contoursinner.txt
		ctype default pl 0 cr ch 1110
		#
selfsim2 0      #
		fdraft
		define PLOTLWEIGHT (7)
                define NORMLWEIGHT (5)
		#
		define x1label "r c^2/GM"
		define x2label "\theta_j"
		#
		ctype default pl 0 cr ch 1101 Rin Rout 2E-2 2
		set chooseaphi=0.98
		set parabz=acos((4-2*chooseaphi+cr-4*LN(2))/cr)
		#
		ctype red pl 0 cr parabz 1110
		#
		set monobz=1.2*cr/cr
		ctype blue pl 0 cr monobz 1110
		#
		set cyl=0.42*asin(12/cr)
		set mycyl=cyl if(cr>12)
		set mycr=cr if(cr>12)
		ctype green pl 0 mycr mycyl 1110
		#
begelmanli 0    # 1994
		set cBp=sqrt(cgv311bl*cB1bl**2+cgv322bl*cB2bl**2)
		set cbp=cBp/ceta1
		set caa=cbp*cr**2
		#
		pl 0 cr caa 1101 Rin Rout 1E-9 1E-2
		#
		#
collfit 0       # try to fit to
		#
		# rout400new
		#set myhin=1.2
		#set Rtorus=10
		# rout400floor1
		#set myhin=1.05
		#set Rtorus=15
		#
		#  pl 0 cr ch
		# for h(r) grid
		ctype default pl 0 cr ch 1101 Rin Rout 1E-1 myhin
		#set myhin=ch[0]
		set myhout=ch[dimen(ch)-1]
		print {myhin myhout}
		#
		#set myfun=0.4*myhin*ASIN(30/cr)
		#ctype red plo 0 cr myfun
		#
		set mysig=LG(Rtorus)
		set myfunin=gauss(LG(Rin),0,mysig)
		#
		set myfun2=(myhin/myfunin)*(gauss(LG(cr),0,mysig))
		ctype blue pl 0 cr myfun2 1110
		#
		# below is good for up to r=40
		#set myfun3=(cr/2.8)**(-.35)
		# below is good up to r=40 and good very close to BH
		#set myfun3=(cr/2.8)**(-.35+0.35*exp(1)/exp(cr+0.7))
		# new attempt, works!
		#set r0=1
		#set rs=0.9
		#set myg=(1/2+1/pi*atan(cr/r0-rs))
		#set myfun3=(cr/2.8)**(-.35*myg)
		###################
		# full enclosure
		set r0=1.0
		set rs=0.9
		set myg=(1/2+1/pi*atan(cr/r0-rs))
		set myfun3=(cr/4)**(-.31*myg)
		# grid test with new attempt, not bad
		#set Q=1.7
		#set r0=7
		#set rs=3
		#set myg=(1/2+1/pi*atan(cr/r0-rs))
		#set myfun3=Q*(cr/2.8)**(-.3*myg)
		# semi-enclosing, good for h(r) in theta grid
 		#set myfun3=(cr/2.9)**(-.3+0.3*exp(1)/exp(cr+0.9))
		# grid test
		#set myfun3=(cr/12)**(-.3+0.3*exp(1)/exp(cr+0.9))
		# a completely enclosing function (good for cookie cut)
		#set myfun3=(cr/2.9)**(-.29+0.29*exp(1)/exp(cr+1.5))
		#set myfun3=(sqrt(cSigma)/2.9)**(-.29)
		ctype red pl 0 cr myfun3 1110		
		#
		#
collfit2 0      #
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 aphitavg
		#define POSCONTCOLOR cyan
		#define NEGCONTCOLOR cyan
		#plc 0 h 010
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		#set superhofr=(r/2.9)**(-.29)
		#set superhofr=(r/2.8)**(-.35)
		set superhofr=(r/2.8)**(-.5)
		set superh=pi*tx2+(1-superhofr)/2*sin(2*pi*tx2)
		plc 0 superh 010
		
		#
collfit3 0      #
		interpsingle aphitavg
		interpsingle superh
		readinterp aphitavg
		readinterp superh
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 iaphitavg
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		#
		plc 0 isuperh 010
		#
		#
plsplit 18      #
		# plsplit 0 cr cacctrueem 1101 Rin Rout 1E-7 1E4
		# plsplit 0 cr ccolltrueem 1101 Rin Rout 1E-7 1E4
		#
		set god=$3 if($3<0)
		set godr=$2 if($3<0)
		set god2=$3 if($3>0)
		set godr2=$2 if($3>0)
		#
		# default=negative
		ctype default pl $1 godr god $4 $5 $6 $7 $8
		# red=positive
		ctype red pl $1 godr2 god2 1111 $5 $6 $7 $8
		#
collsplit 0     #
		define flow (1E-7)
		define fhigh (1E4)
		#
		#set myfun=ccolltrueem
		#set myfun=cacctrueem
		#set myfun=caccem
		#set myfun=ccollema
		set myfun=ccollemb
		#
		set god=myfun if(myfun>0)
		set godr=cr if(myfun>0)
		set god2=myfun if(myfun<0)
		set godr2=cr if(myfun<0)
		# default=negative coll, so toward axis of theta<pi/2
		ctype default pl 0 godr2 god2 1101 Rin Rout $flow $fhigh
		ctype red pl 0 godr god 1110
		erase
		ctype default box
		ctype default points (LG(ABS(godr2))) (LG(ABS(god2)))
		# back to disk if theta<pi/2
		ctype red points (LG(ABS(godr))) (LG(ABS(god)))
		#
		#
findrh0       6 # findrh0 cr ch ctfastv1p r0 h0 myii
		#
		# find location of f=0 assuming switches sign only once (i.e. monotonic function) and switches inside grid somewhere (i.e. outer-most points are opposite signs)
		set myr=$1
		set myh=$2
		set myfun=$3
		#
		set n=dimen(myfun)
		#
		set fin=myfun[0]
		set fout=myfun[n-1]
		set signin=fin/ABS(fin)
		set signout=fout/ABS(fout)
		#
		define iii (0)
		while { $iii<n } {
		   #echo $iii
		   if(myfun[$iii]*signin<0) {\
		          set fplus=myfun[$iii] 
		          set fminus=myfun[$iii-1] 
	 	          set rplus=myr[$iii] 
		          set hplus=myh[$iii]
		          set rminus=myr[$iii-1]
		          set hminus=myh[$iii-1]
		          echo "done at $!iii"
		          set $6=$iii
		          BREAK
		   }
		   define iii ($iii+1)
		}
		#
		set slope=(fplus-fminus)/(rplus-rminus)
		set $4=fplus/slope+rplus
		#
		set slope=(fplus-fminus)/(hplus-hminus)
		set $5=fplus/slope+hplus
		#
getchars  0    #
		findrh0 cr ch ctfastv1p fastv1pr0 fastv1ph0 fastv1piii
		findrh0 cr ch calfvenv1p alfvenv1pr0 alfvenv1ph0 alfvenv1piii
		findrh0 cr ch csonicv1p sonicv1pr0 sonicv1ph0 sonicv1piii
		findrh0 cr ch ctslowv1p slowv1pr0 slowv1ph0 slowv1piii
		#
		findrh0 cr ch cuu1 uu1r0 uu1h0 uu1iii
		#
		findrh0 cr ch ctslowv1m slowv1mr0 slowv1mh0 slowv1miii
		findrh0 cr ch csonicv1m sonicv1mr0 sonicv1mh0 sonicv1miii
		findrh0 cr ch calfvenv1m alfvenv1mr0 alfvenv1mh0 alfvenv1miii
		findrh0 cr ch ctfastv1m fastv1mr0 fastv1mh0 fastv1miii
		#
showchars 1     # assumes in log radial plot, function can be either
		#
		#
                # showcars fun
		# uses background function to plot chars onto for given radii
		#
		ptype 6 3
		ctype red points (LG(fastv1pr0)) ($1[fastv1piii])
		ctype blue points (LG(alfvenv1pr0)) ($1[alfvenv1piii])
		ctype green points (LG(slowv1pr0)) ($1[slowv1piii])
		#
		ctype yellow points (LG(uu1r0)) ($1[uu1iii])
		#
		ctype green points (LG(slowv1mr0)) ($1[slowv1miii])
		ctype blue points (LG(alfvenv1mr0)) ($1[alfvenv1miii])
		ctype red points (LG(fastv1mr0)) ($1[fastv1miii])
		ptype 4 1
		#
charssplit0  0   #
		#
		define flow (1E-5)
		define fhigh (1E5)
		#
		set god=ctfastv1m if(ctfastv1m>0)
		set godr=cr if(ctfastv1m>0)
		set god2=ctfastv1m if(ctfastv1m<0)
		set godr2=cr if(ctfastv1m<0)
		ctype default pl 0 godr2 god2 1101 Rin Rout $flow $fhigh
		ctype red pl 0 godr god 1110
		#
		ctype blue pl 0 cr cuu1bl 1110
		#
		set god=ctslowv1m if(ctslowv1m>0)
		set godr=cr if(ctslowv1m>0)
		set god2=ctslowv1m if(ctslowv1m<0)
		set godr2=cr if(ctslowv1m<0)
		ctype default pl 0 godr2 god2 1101 Rin Rout $flow $fhigh
		ctype red pl 0 godr god 1110
		#
		set god=cfastv1p if(cfastv1p>0)
		set godr=cr if(cfastv1p>0)
		set god2=cfastv1p if(cfastv1p<0)
		set godr2=cr if(cfastv1p<0)
		ctype red pl 0 godr2 god2 1110
		ctype green pl 0 godr god 1110
		#
		set god=cslowv1p if(cslowv1p>0)
		set godr=cr if(cslowv1p>0)
		set god2=cslowv1p if(cslowv1p<0)
		set godr2=cr if(cslowv1p<0)
		ctype red pl 0 godr2 god2 1110
		ctype green pl 0 godr god 1110
		#
		set god=cEN1 if(cEN1>0)
		set godr=cr if(cEN1>0)
		set god2=cEN1 if(cEN1<0)
		set godr2=cr if(cEN1<0)
		ctype cyan pl 0 godr2 god2 1110
		ctype magenta pl 0 godr god 1110
		#
		#
dercollfit 0    #
		der cr ch dcr dch
		ctype default pl 0 dcr dch
		#
		#
		#
lgaccplot1 0   #
		#
		ctype default pl 0 cr caccma 1101 Rin Rout 1E-5 1E5
		ctype red pl 0 cr caccem 1111 Rin Rout 1E-5 1E5
		#
lgcollplot1 0   #
		#
		ctype default pl 0 cr ccollma 1101 Rin Rout 1E-5 1E5
		ctype red pl 0 cr ccollema 1111 Rin Rout 1E-5 1E5
		ctype blue pl 0 cr ccollemb 1111 Rin Rout 1E-5 1E5
		#
		#
it      0       # Rout=400 model
		#
		jrdp dump0040
		faraday
		bzeflux
		fieldcalc 40 aphi
		#
		plc 0 aphi 001 Rin (1.1*Rin) 2.78 2.81
		#
		plc 0 omegaf2 001 Rin (1.1*Rin) 2.78 2.81
		#
		#
		#
it2   0         # interpolated field line plot
		interpsingle 40 aphi
		readinterp aphi
		ctype default
		define x1label "r c^2/GM"
		define x2label "z c^2/GM"
		device postencap iaphi.eps
		fdraft
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		#
		plc 0 iaphi 001 0 Rout 0 Rout
		device X11
		#
		!scp iaphi.eps metric.physics.uiuc.edu:
		#
bzwhowhaphipre  0 # read in what matlab gave us
		da C1.txt
		read {rnew 1 wvsr 2}
		da C3.txt
		read {rnew 1 bsqvsr 2}
		da C4.txt
		read {rnew 1 B1vsr 2}
		da C5.txt
		read {rnew 1 B3vsr 2}
		da C6.txt
		read {rnew 1 v1mvsr 2}
		da C2.txt
		read {rnew 1 uu1vsr 2}
		da C7.txt
		read {rnew 1 hvsr 2}
		#
rreduce 0       #
		set wvsr=wvsr if(rnew<=100)
		set bsqvsr=bsqvsr if(rnew<=100)
		set B1vsr=B1vsr if(rnew<=100)
		set B3vsr=B3vsr if(rnew<=100)
		set v1mvsr=v1mvsr if(rnew<=100)
		set uu1vsr=uu1vsr if(rnew<=100)
		set hvsr=hvsr if(rnew<=100)
		set rnew=rnew if(rnew<=100)
		#
rsort 0         #
		sort {rnew wvsr bsqvsr B1vsr B3vsr v1mvsr uu1vsr hvsr}
		#
plots 0                # omega along aphi from matlab
		#
		set _Rin=1.34
		set myRout=400
		#
		device postencap w.eps
		fdraft
		set rat=wvsr/omegah
		define x1label "r c^2/(GM)"
		define x2label "\omega/\Omega_H"
		ctype default ltype 0 pl 0 rnew rat 0001 _Rin myRout 0 1.0
		device X11
		!scp w.eps metric.physics.uiuc.edu:
		#
		# wtf is the field rotational velocity or frequency?
		device postencap vf.eps
		fdraft
		set vf=wvsr*rnew*sin(hvsr)
		define x1label "r c^2/(GM)"
		define x2label "v_f"
		ctype default ltype 0 pl 0 rnew vf 0001 _Rin myRout 0 3.0
		device X11
		!scp w.eps metric.physics.uiuc.edu:
		#
		device postencap th.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "\theta"
		ctype default ltype 0 pl 0 rnew hvsr 1000
		device X11
		!scp th.eps metric.physics.uiuc.edu:
		#
		#
		device postencap coll.eps
		#
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "\theta[r=0]/\theta[r]
		set coll=(pi-hvsr[0])/(pi-hvsr)
		ctype default ltype 0 pl 0 rnew coll 1000
		set r0=11
		set colltest=0.448+ASIN(1.0)/ASIN(r0/rnew) if(rnew>=r0)
		set rnew2=rnew if(rnew>=r0)
		ctype red ltype 0 pl 0 rnew2 colltest 1010
		set rexp=r0*4
		set colltest2=exp(rnew/rexp)/exp(1.629/rexp)
		ctype blue ltype 0 pl 0 rnew colltest2 1010
		#set colltest3=(rnew/1.629)**(1.2)
		#ctype cyan ltype 0 pl 0 rnew colltest3 1010
		#
		device X11
		!scp coll.eps metric.physics.uiuc.edu:
		#
		device postencap dcoll.eps
		#
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "d/dr(\theta[r=0]/\theta[r])"
		der rnew coll drnew dcoll
		set it=(pi-hvsr[dimen(hvsr)-1])/(pi-hvsr)
		ctype default ltype 0 pl 0 drnew dcoll 1000
		#
		device X11
		!scp dcoll.eps metric.physics.uiuc.edu:
		#
		device postencap uu1.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "u^r[KS,BL]"
		set it=uu1vsr*rnew
		# in BL
		ctype default ltype 0 pl 0 rnew it 1000
		device X11
		!scp uu1.eps metric.physics.uiuc.edu:
		#
		device postencap bsq.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "b^2"
		ctype default ltype 0 pl 0 rnew bsqvsr 1101 _Rin myRout 1E-6 6E-3
		device X11
		!scp bsq.eps metric.physics.uiuc.edu:
		#
		#
		device postencap B1.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "B^r"
		set it=B1vsr*rnew
		ctype default ltype 0 pl 0 rnew it  1101 _Rin myRout 1E-4 1E-1
		#ctype red ltype 0 pl 0 rnew (.0051*(rnew/10)**(-1.4)) 1110
		device X11
		!scp B1.eps metric.physics.uiuc.edu:
		#
		device postencap B3.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "B^\phi"
		ctype default ltype 0 pl 0 rnew B3vsr  1101 _Rin myRout 1E-5 1E-1
		device X11
		!scp B3.eps metric.physics.uiuc.edu:
		#
		device postencap B3bl.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "B^\phi[BL]"
		set delta=rnew**2-2*rnew+a**2
		set B1ks=B1vsr*rnew
		set B3ks=B3vsr
		set B3bl=B3ks-B1ks*(a-2*rnew*wvsr)/delta
		ctype default ltype 0 pl 0 rnew B3bl  1101 _Rin myRout 1E-5 1E-1
		device X11
		!scp B3.eps metric.physics.uiuc.edu:
		#
		#
		device postencap v1m.eps
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "v^r_m"
		set it=v1mvsr*rnew
		ctype default ltype 0 pl 0 rnew it 1100
		device X11
		!scp v1m.eps metric.physics.uiuc.edu:
		#
		
it2         0   #
		jrdp dump0040
		stresscalc 1
		set cmin=(-v1m>0) ? -v1m : 0
		set cmax=(v1p>0) ? v1p : 0
		set ctop=(cmax>cmin) ? cmax : cmin
		#
it3        0    #
		jrdp dump0040 # to get raw paramters
		gammiegrid # to read in metric.physics.uiuc.edu
		jrdp dump0040 # to compuate things dependent on metric
		plc 0 Machva
		set it=LG(Machva)
		plc 0 it 001 Rin Rout 2.8 pi
#
fieldplot 0     #
		jrdp dump0056
		fieldcalc 0 aphi
		fdraft
		interpsingle aphi
		readinterp aphi
		plc 0 iaphi
		#
		#
		fdraft
		device postencap3 finalfieldzoom.eps
		LOCATION 5000 19000 3500 31000
		plc 0 iaphi
		device X11
		#
		!scp finalfield.eps jon@relativity.cfa:/home/jondata/
		#
hutplot 0       #
		truncall
		truncate cgv333bl
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#
		#
		ticksize -1 0 -1 0
		define god1 (LG(0.08))
		limits 0 4 $god1 0
		ctype default window 2 2 1 2 box 1 2 0 0
		#
		define x2label "\Gamma\ \ \Gamma^{(MA)}_\infty\ \   \Gamma^{(EM)}_\infty"
		ctype default pl 0 tcr tcuu0bl 1101 Rin Rout 1E-1 1E5
		#
		#
		set god=tcBd3bl*tcw3*tceta1
		ctype blue pl 0 tcr god 1111 Rin Rout 1E-1 1E5
		#
		set god=tcu/tcrho
		set crap=-god*tcud0bl		
		ctype red pl 0 tcr crap 1111 Rin Rout 1E-1 1E5
		#
		#
		#
		#
		#		device postencap fluxes.eps
hutplotnew 0 #
		#
		device postencap fluxesotherpole.eps
		# readcontours contoursksmiddle.txt
		truncall
		truncate cgv333bl
		truncate cgv311bl
		truncate cgv300bl
		#
		#
		#
		defaults
		fdraft
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#
		#
		ticksize -1 0 -1 0
		limits 0 4 0 5
		ctype default window 1 -3 1 3 box 0 2 0 0
		#
		define x2label "\Gamma\ \ \Gamma^{(MA)}_\infty\ \   \Gamma^{(EM)}_\infty"
		define x1label "r c^2/GM"
		#xla $x1label
		yla $x2label
		#
		set god=tcuu0bl*sqrt(-cgv300bl)
		ltype 2 ctype default pl 0 tcr god 1111 Rin Rout 1E-1 1E5		
		set gaminfemold=tcBd3bl*tcw3*tceta1
		if(0){\
		set gaminfem=(tcr<10) ? gaminfemold/(tcr/10)**(2.7-1.0) : gaminfemold
		}
		if(1){\
		set gaminfem=gaminfemold

		}
		ltype 0 ctype default pl 0 tcr gaminfem 1111 Rin Rout 0.08 1.0
		set god=tcu/tcrho
		set gaminfma=-god*tcud0bl		
		ltype 1 ctype default pl 0 tcr gaminfma 1111 Rin Rout 1E-1 1E5
		#
		ticksize -1 0 -1 0
		limits 0 4 0 5.7
		ctype default window 1 -3 1 2 box 0 2 0 0
		#
		#define x2label "u^{\hat{\phi}}\ \ {u_\phi,}^{(MA)}_\infty\ \   {u_\phi,}^{(EM)}_\infty"
		define x2label "u_{\phi}\ \ {u_\phi,}^{(MA)}_\infty\ \   {u_\phi,}^{(EM)}_\infty"
		define x1label "r c^2/GM"
		#xla $x1label
		yla $x2label
		set gamrotlocal=tcgv333bl*tcuu3bl
		ltype 2 ctype default pl 0 tcr tcud3bl 1111 Rin Rout 1E-1 1E5
		set gaminfemold=tcBd3bl*tceta1
		if(0){\
		set gaminfem=(tcr<10) ? gaminfemold/(tcr/10)**(2.7-1.0) : gaminfemold
		}
		if(1){\
		set gaminfem=gaminfemold
		}
		ltype 0 ctype default pl 0 tcr gaminfem 1111 Rin Rout 0.08 1.0
		set god=tcu/tcrho
		set gaminfma=god*tcud3bl		
		ltype 1 ctype default pl 0 tcr gaminfma 1111 Rin Rout 1E-1 1E5
		#
		ticksize -1 0 -1 0
		limits 0 4 -2 1.5
		ctype default window 1 -3 1 1 box 1 2 0 0
		#
		define x2label "u^{\hat{\phi}}\ \ |u^{\hat{r}}|"
		define x1label "r c^2/GM"
		xla $x1label
		yla $x2label
		set god1=sqrt(tcgv311bl)*tcuu1bl
		ltype 0 ctype default pl 0 tcr god1 1111 Rin Rout 1E-1 1E5
		set god2=sqrt(tcgv333bl)*tcuu3bl
		ltype 1 ctype default pl 0 tcr god2 1111 Rin Rout 1E-1 1E5
		#
		#
		device X11
		!scp fluxesotherpole.eps jon@relativity:/home/jondata/
		#
		#
jetstructplot0 0 # radial jet structure
		#
		## load at least dump0000
		#
		device postencap jetstruct2bothpolesnew.eps
		#
		defaults
		fdraft
		#
		#
		#readcontours contoursksmiddle.txt
		readcontours contoursnewgod.txt
		set i=1,dimen(cr),1
		#define termit (621)
		define termit (570)
		set crapcr=cr if(i<=$termit)
		set crapch=ch if(i<=$termit)
		set crapcDelta=cDelta if(i<=$termit)
		set crapcSigma=cSigma if(i<=$termit)
		set cDelta=(cr**2-2*cr+a**2)
		set cSigma=(cr**2+(a*cos(ch)))
		set craprho=crho/0.26 if(i<=$termit)
		set crapu=cu/0.26 if(i<=$termit)
		set craplbrel=clbrel if(i<=$termit)
		set crapcoB1=coB1/sqrt(0.26) if(i<=$termit)
		set crapcoB3=coB3/sqrt(0.26) if(i<=$termit)
		set crapcw2=cw2 if(i<=$termit)
		set crapcgrR=cgrR if(i<=$termit)
		#readcontours contoursksmiddleotherpole.txt
		readcontours contoursgodotherpole.txt
		set trunctype=1
		truncall
		#
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#
		#
		ticksize -1 0 -1 0
		set thin=0.08*180/pi
		set thout=1.0*180/pi
		#
		define god1 (LG(thin))
		define god2 (LG(thout))
		limits 0 4 $god1 $god2
		#limits 0 4 
		ctype default window 2 -3 1 3 box 0 2 0 0
		#
		set mytch=(pi-tch)*180/pi
		set mycrapch=crapch*180/pi
		define x2label "\theta_j [^\circ]"
		#define x1label "r c^2/GM"
		#set myfit=0.9*(tcr)**(-0.3)
		ltype 0 ctype default pl 0 tcr mytch 1111 Rin Rout thin thout
		ltype 1 ctype default pl 0 crapcr mycrapch 1111 Rin Rout thin thout
		#ltype 2 ctype default pl 0 tcr myfit 1110
		ltype 0
		#xla $x1label
		yla $x2label
		#
		#
		ticksize -1 0 -1 0
		limits 0 4 -13.7 -6
		ctype default window 2 -3 2 3 box 0 2 0 0
		define x2label "\rho_0/\rho_{0,disk}"
		define x1label "r c^2/GM"
		#set myrho=tcrho/0.26
		# fudgeing fudge
		if(0){\
		set myrho=(tcr<10) ? tcrho/0.26*(tcr/10)**(2.7-1.0) : tcrho/0.26
		set crapmyrho=(crapcr<10) ? craprho*(crapcr/10)**(2.7-1.0) : craprho
		}
		if(1){\
		       set myrho=tcrho/0.26
		       set crapmyrho=craprho
		}
		set myfit=1.5E-9*(tcr/120)**(-0.9)
		set myfit2=1.5E-9*(tcr/120)**(-2.2)
		ltype 0 ctype default pl 0 tcr myrho 1110
		ltype 1 ctype default pl 0 crapcr crapmyrho 1110
		ltype 2 ctype default pl 0 tcr myfit 1110
		ltype 2 ctype default pl 0 tcr myfit2 1110
		ltype 0
		#xla $x1label
		yla $x2label
		set myrhofloor=1E-7*tcr**(-2.7)/0.26
		#ctype red pl 0 tcr myrhofloor 1110
		#
		ticksize -1 0 -1 0
		limits 0 4 0.5 5.7
		ctype default window 2 -3 1 2 box 0 2 0 0
		#
		define x2label "b^2/(\rho_0 c^2)"
		define x1label "r c^2/GM"
		if(0){\
		set it=(tcr<10) ? 10**(tclbrel)/(tcr/10)**(2.7-1.0) : 10**(tclbrel)
		set itcrap=(crapcr<10) ? 10**(craplbrel)/(crapcr/10)**(2.7-1.0) : 10**(craplbrel)
		}
		if(1){\
		       set it= 10**(tclbrel)
		       set itcrap= 10**(craplbrel)
		}
		#set itcrap=10**(craplbrel)
		ltype 0 ctype default pl 0 tcr it 1110
		ltype 1 ctype default pl 0 crapcr itcrap 1110
		ltype 0
		#xla $x1label
		yla $x2label
		#
		ticksize -1 0 -1 0
		limits 0 4 0 2.5
		ctype default window 2 -3 2 2 box 0 2 0 0
		#
		define x2label "u/(\rho_0 c^2)"
		define x1label "r c^2/GM"
		set myrat=tcu/tcrho
		set crapmyrat=crapu/craprho
		if(0){\
		set myrat=(tcr<10) ? tcu/tcrho/((tcr/10)**(2.7-1.0)) : tcu/tcrho
		set crapmyrat=(crapcr<10) ? crapu/craprho/((crapcr/10)**(2.7-1.0)) : crapu/craprho
		}
		set myfit=3*(tcr/120)**(-0.9)
		set myfit2=3*(tcr/120)**(0.9)
		ltype 0 ctype default pl 0 tcr myrat 1110		
		ltype 1 ctype default pl 0 crapcr crapmyrat 1110
		ltype 2 ctype default pl 0 tcr myfit 1110
		ltype 2 ctype default pl 0 tcr myfit2 1110
		ltype 0
		#xla $x1label
		yla $x2label
		set myufloor=1E-8*tcr**(-2.7)/0.26
		set myratfloor=myufloor/myrhofloor
		#ctype red pl 0 tcr myratfloor 1110
		#
		#
		ticksize -1 0 -1 0
		limits 0 4 -5 1
		ctype default window 2 -3 1 1 box 1 2 0 0
		#
		define x2label "B^{\hat{\phi}}/\sqrt{\rho_{0,disk}c^2}"
		# in Gauss
		set RB3=tcoB3/sqrt(0.26)*sqrt(4.0*pi)
		set crapRB3=crapcoB3*sqrt(4.0*pi)
		define x1label "r c^2/GM"
		set myfit=0.15*tcr**(-0.7)
		set myfit2=20*tcr**(-1.5)
		ltype 0 ctype default pl 0 tcr RB3 1110		
		ltype 1 ctype default pl 0 crapcr crapRB3 1110
		ltype 2 ctype default pl 0 tcr myfit 1110
		ltype 2 ctype default pl 0 tcr myfit2 1110
		ltype 0
		xla $x1label
		yla $x2label
		#
		ticksize -1 0 -1 0
		limits 0 4 -3 0.5
		ctype default window 2 -3 2 1 box 1 2 0 0
		#
		#define x2label "(B^{\hat{r}})^2/\rho_{0,disk}"
		define x2label "tan^{-1}(|B^{\hat{r}}|/|B^{\hat{\phi}}|)"
		set RB1=tcoB1/sqrt(0.26)*sqrt(4.0*pi)
		set crapRB1=crapcoB1*sqrt(4.0*pi)
		set pitchangle=atan2(ABS(RB1),ABS(RB3))
		set crappitchangle=atan2(ABS(crapRB1),ABS(crapRB3))
		#set myfit=0.5*exp(-(tcr-4)**(1/4)/2)
		set mykink=atan((1.0/(tcw2*tcgrR)))
		set crapmykink=atan((1.0/(crapcw2*crapcgrR)))
		set crapmykink[515]=0.5*(crapmykink[514]+crapmykink[516])
		define x1label "r c^2/GM"
		ltype 0 ctype default pl 0 tcr pitchangle 1110		
		ltype 1 ctype default pl 0 crapcr crappitchangle 1110
		#ltype 2 ctype default pl 0 tcr myfit 1110
		ltype 3 ctype default pl 0 tcr mykink 1110
		ltype 3 ctype default pl 0 crapcr crapmykink 1110
		ctype default ltype 0
		xla $x1label
		yla $x2label
		#
		device X11
		!scp jetstruct2bothpolesnew.eps jon@relativity:/home/jondata/
		#
collplot     0  #
		defaults
		fdraft
		define x2label "\theta_j"
		#
jetstructplot 0 #
		# setupdumpjet
		#
		defaults
		fdraft
		#
		define hin (0)
		define hout (1.0)
		define myvert (0.12)
		define myvert2 (0.28)
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		#
		ticksize 0 0 -1 0
		limits 0 0.4 0 5
		ctype default window 2 2 1 2 box 1 2 0 0
		#
		define x2label "\Gamma_\infty"
		define x1label "\theta"
		ctype default setlimits 5.6E3 5.7E3 0 1.0 0 1 plflim 0 x2 r h EN1tavg 0 011
		xla $x1label
		yla $x2label
		ctype red vertline $myvert
		ctype blue vertline $myvert2
		#
		#
		ticksize 0 0 -1 0
		limits 0 0.4 -14 -9
		ctype default window 2 2 2 2 box 1 2 0 0
		define x2label "\rho_0/\rho_{0,disk}"
		define x1label "\theta"
		set myrho=rho/0.26
		ctype default setlimits 5.6E3 5.7E3 0 1.0 0 1 plflim 0 x2 r h myrho 0 011
		xla $x1label
		yla $x2label
		ctype red vertline $myvert
		ctype blue vertline $myvert2
		#
		ticksize 0 0 -1 0
		limits 0 0.4 0 1.4
		ctype default window 2 2 1 1 box 1 2 0 0
		#
		define x2label "\Gamma"
		define x1label "\theta"
		ctype default setlimits 5.6E3 5.7E3 0 1.0 0 1 plflim 0 x2 r h uu0bltavg 0 011
		xla $x1label
		yla $x2label
		ctype red vertline $myvert
		ctype blue vertline $myvert2
		#
		ticksize 0 0 -1 0
		limits 0 0.4 -12 -9
		ctype default window 2 2 2 1 box 1 2 0 0
		#
		define x2label "u/\rho_{0,disk}"
		define x1label "\theta"
		set myu=u/0.26
		ctype default setlimits 5.6E3 5.7E3 0 1.0 0 1 plflim 0 x2 r h myu 0 011
		xla $x1label
		yla $x2label
		ctype red vertline $myvert
		ctype blue vertline $myvert2
		#
		#
		#
jetsplot2 0     # theta jet structure
		#
		#
		# setupdumpjet
		#
		# precalculation
		#
		#ltype 0 ctype default setlimits 5.6E3 5.7E3 0 pi 0 1 plflim 0 x2 r h ud3 0 010
		#set mygodgodh=pi-newx
		#set mynewud3=newfun
		#ltype 0 ctype default pl 0 mygodh mynewud3 0101 0 0.62 1E-1 1E2
		#
		#
		#
		device postencap jetstructnew.eps
		#device postencap4 jetstructnew.eps
		#device postencap4 jetstructnew.eps
		#device postlandfile jetstructnew.eps
		#device ppm3 jetstructnew.ppm
		#
		defaults
		fdraft
		#
		lightcylinders
		#
		set cf=180/pi
		define myvert ((pi-3.06)*cf)
		define myvert2 ((pi-2.69)*cf)
		#
		define limitout ((pi-2.5)*cf)
		define limitin ((pi-pi)*cf)
		#
		set mygodh=(pi-h)*cf
		set myh=h*cf
		#
		define cpi (pi*cf)
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		#location 3500 31000 0 31000
		notation -2 2 -2 2
		#define x_gutter 1
		define y_gutter 0.3
		#aspect 3
		erase
		#
		#
		ticksize 0 0 -1 0
		#limits $limitin $limitout -.01 4
		limits $limitin $limitout -.2 4
		ctype default window 2 -3 1 3 box 0 2 0 0
		#
		#
		define x2label "\Gamma\ \ \Gamma_\infty"
		define x1label "\theta[^\circ]"
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh EN1tavg 0 011
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh uu0bltavg 0 011
		ltype 0
		#
		set theta0=0.15/2*cf
		set modelcrap=3*10**3*exp(-(myh-$cpi)**2/(2*theta0**2))
		set modelcrapnew=(modelcrap>=1.0) ? modelcrap : 1.0
		ltype 2 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh modelcrapnew 0 011
		#
		# uniform with exponential wings
		set thetae0=$myvert*1.25
		set modelcrap=(mygodh<thetae0) ? 3E3 : 3E3*exp(-(mygodh-thetae0)/(thetae0/4))
		set modelcrapnew=(modelcrap>=1.0) ? modelcrap : 1.0
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh modelcrapnew 0 011
		#
		#
		set theta0=0.2*cf
		set modelcrap=5*exp(-(myh-$cpi)**2/(2*theta0**2))
		set modelcrapnew=(modelcrap>=1.0) ? modelcrap : 1.0
		ltype 3 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh modelcrapnew 0 011
		ltype 0
		#xla $x1label
		yla $x2label
		ltype 2 ctype default vertline $myvert
		ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		#
		ticksize 0 0 -1 0
		limits $limitin $limitout -.5 5
		ctype default window 2 -3 2 3 box 0 2 0 0
		#
		#
		define x2label "u_\phi \ \ u_{\phi,\infty}"
		define x1label "\theta[^\circ]"
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh LN1tavg 0 011
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh ud3bltavg 0 011
		#xla $x1label
		yla $x2label
		ltype 2 ctype default vertline $myvert
		ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		ticksize 0 0 -1 0
		limits $limitin $limitout -15.5 -8.3
		ctype default window 2 -3 1 2 box 0 2 0 0
		define x2label "\rho_0/\rho_{0,disk} \ u/\rho_{0,disk}c^2"
		define x1label "\theta[^\circ]"
		set myrho=rho/0.26
		set myu=u/0.26
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh myrho 0 011
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh myu 0 011
		ltype 0
		#xla $x1label
		yla $x2label
		ltype 2 ctype default vertline $myvert
		ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		#
		#
		ticksize 0 0 -1 0
		limits $limitin $limitout -4 0.3
		ctype default window 2 -3 1 1 box 1 2 0 0
		#
		define x2label "\epsilon(\theta)/\dot{M}c^2"
		define x1label "\theta[^\circ]"
		set crapper=(uu1bltavg<0.0) ? 0.0 : r**2*EN1tavg*myrho*uu1bltavg
		#
		# set godh=pi/2
		#set godh=pi-8.0*pi/180.0
		set godh=3.05
		set craptoint=crapper*dxdxp22*$dx2*sin(h)*2*pi if((ti==493)&&(h>godh))
		set integratedcrap=SUM(craptoint)
		print {integratedcrap}
		#
		#set crapper=-r**2*Tud10tavg
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh crapper 0 011
		#
		# Gaussian model
		set modelcrap=0.18*exp(-(myh-$cpi)**2/(2*(cf*0.15)**2))
		ltype 2 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh modelcrap 0 011
		#
		# uniform with exponential wings
		set thetae0=$myvert*2.5
		set modelcrap=(mygodh<thetae0) ? 0.1 : 0.1*exp(-(mygodh-thetae0)/(thetae0/3))
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh modelcrap 0 011
		#
		#
		ltype 0
		xla $x1label
		yla $x2label
		ltype 2 ctype default vertline $myvert
		ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		#
		#
		ticksize 0 0 -1 0
		limits $limitin $limitout -9 -3.3
		ctype default window 2 -3 2 2 box 1 2 0 0
		#
		#define x2label "(B^{\hat{r}})^2/\rho_{0,disk} \ (B^{\hat{\phi}})^2/\rho_{0,disk}"
		#set RB3=(sqrt(gv333bl)*B3bltavg/sqrt(0.26))**2
		#set RB1=(sqrt(gv311bl)*B1bltavg/sqrt(0.26))**2
		define x2label "\frac{B^{\hat{r}}}{\sqrt{\rho_{0,disk}c^2}}\ \ \ \ \ \ \ \frac{B^{\hat{\phi}}}{\sqrt{\rho_{0,disk}c^2}}"
		#define x2label "\frac{B^{\hat{r}}}{\sqrt{\rho_{0,disk}c^2}} \frac{B^{\hat{\phi}}}{\sqrt{\rho_{0,disk}c^2}}"
		#define x2label "B^{\hat{r}} B^{\hat{\phi}}"
		define x1label "\theta[^\circ]"
		# In Gaussian units
		set RB3=sqrt(gv333bl)*B3bltavg/sqrt(0.26)*sqrt(4.0*pi)
		set RB1=sqrt(gv311bl)*B1bltavg/sqrt(0.26)*sqrt(4.0*pi)
		#
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh RB3 0 011
		ltype 1 ctype default setlimits 5.6E3 5.7E3 0 $cpi 0 1 plflim 0 x2 r mygodh RB1 0 011
		ltype 0
		xla $x1label
		#yla $x2label
		#
		define labellocx ($limitin-.3*cf)
		relocate $labellocx -7.5
		angle 90
		putlabel 5 $x2label
		angle 0
		#
		ltype 2 ctype default vertline $myvert
		ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		# E(\Gamma_\infty)
		#
		ticksize -1 0 -1 0
		#limits $limitin $limitout -4 0.3
		limits 0 3.5 -3 -0.7
		ctype default window 2 20 2 1:5 box 1 2 0 0
		#
		#
		#
		define x2label "\epsilon/\dot{M}c^2"
		define x1label "\Gamma_\infty"
		set energy=(uu1bltavg<0.0) ? 0.0 : r**2*EN1tavg*myrho*uu1bltavg
		set energyuse=((r>5.55E3)&&(r<5.7E3)&&(mygodh<0.6*cf)&&(energy<0.11)) ? 1 : 0
		#set energyuse=((r>5.55E3)&&(r<5.7E3)&&(mygodh<0.6*cf)) ? 1 : 0
		set energy=energy if(energyuse)
		set myEN1=EN1tavg if(energyuse)
		set myh=mygodh if(energyuse)
		ltype 0 ctype default pl 0 myEN1 energy 1111 1 1E4 1E-3 1
		#set modelcrap=0.09*(myEN1/1E3)**(0.25)
		#set modelcrap=(myEN1>5E1) ? 0.09*(myEN1/1E3)**(0.25) : 0.18*(myEN1/1E3)**(0.25)
		set modelcrap=0.08*(myEN1/1E3)**(0.2)
		ltype 2 ctype default pl 0 myEN1 modelcrap 1110
		#
		#
		ltype 0
		xla $x1label
		yla $x2label
		#ltype 2 ctype default vertline $myvert
		#ltype 2 ctype default vertline $myvert2
		ltype 0
		#
		#
		device X11
		!scp jetstructnew.eps jon@relativity:/home/jondata/
		#
		#
		# angular structure of phi velocity
phivel 0   #    #
		# setupdumpjet
		#
		ltype 0 ctype default setlimits 5.6E3 5.7E3 0 pi 0 1 plflim 0 x2 r h ud3 0 010
		set mygodh=pi-newx
		ltype 0 ctype default pl 0 mygodh newfun 0101 0 0.62 1E-12 1E2
		
		#
		
		#
		#
plot1fl 0  #    #
		defaults
		jre fieldline.m
		plotparms
		greaddump dumptavg
		plc 0 aphi
		define mymax ($max)
                define mymin ($min)
		define max $mymax
                define min $mymin
		lweight 3
		define PLOTERASE 0
                define CONSTLEVELS 1
		set constlevelshit=1
		#
		set r0=1.0
                set rs=0.9
                set njet=0.31
                set r0j=4
                #
                set myg=(1/2+1/pi*atan(r/r0-rs))
                set myfun2=(r/r0j)**(-njet*myg)
		set myuse=((h>pi-myfun2)&&(aphi<0.12)) ? 1 : 0
		set partaphi=(myuse==1) ? aphi : 100
		#
		interpsingle aphi
		interpsingle partaphi
		readinterp aphi
		readinterp partaphi
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
                set iaphi2=(radius<380.0) ? iaphi : $missing_data
		#
		define missing_data (1E30)
                set radius=sqrt(x12**2+x22**2)
                set ipartaphi2=((radius<380.0)||(ipartaphi>0.11)) ? ipartaphi : $missing_data
		#
		#
		erase
		plotparms
		LOCATION 3500 31000 3500 31000
		#LOCATION $($gx1+500) $($gx2-500) $gy1 $gy2
		LOCATION $($gx1) $($gx2-500) $gy1 $gy2
		#
		# plot with removed outer-radial crap
		plc 0 iaphi2 001 0 Rout 0 Rout
		#
		plc 0 ipartaphi2 001 0 Rout 0 Rout
		set godaphi=newfun
		#
		#
		# actual plot
		erase
		#
		plc 0 iaphi2 001 0 Rout 0 Rout
		#set image[ix,iy]=godaphi
		#define uaphi (0.1001)
		#define daphi (0.100)
		#define delta (($uaphi-$daphi)/1)
		#set lev=$daphi,$uaphi,$delta
		#levels lev
		#ctype red contour
		ctype default radialedge
		#
		#finishanimpc
crapper 0       #
		set it=gv300+2.0*v1m*g
		#	
		#
punball 0       #
		!scp jon@relativity:/home/jon/sm/punsly.m ~/sm/
		#
		define MYFILE linesi40.eps
		punbeta 0005 40
		#
		#
		define MYFILE  linesi1000.eps
		punbeta 0005 1000
		#
		#
		define MYFILE  linesi10000.eps
		punbeta 0005 10000
		#
		!scp linesi*.eps jon@relativity:/home/jondata/
		#
punbeta 2       #
		#
		if($1>=0){ jrdp dump$1 }
		if($1==-1) { greaddump dumptavg }
		if($1==-2) { greaddump dumptavgi }
		    #
		define MYROUT ($2)
		#define MYFILE {'$3'}
		#
		echo $1 $MYROUT $MYFILE
		#
                interpsingle2 libeta 512 512 $MYROUT $MYROUT
		interpsingle2 uu1 512 512 $MYROUT $MYROUT
		interpsingle2 lbrel 512 512 $MYROUT $MYROUT
		set outud0=(uu1>0.0) ? ud0 : 1
                interpsingle2 outud0 512 512 $MYROUT $MYROUT
		interpsingle2 ud0 512 512 $MYROUT $MYROUT
		interpsingle2 aphi 512 512 $MYROUT $MYROUT
		interpsingle2 r 512 512 $MYROUT $MYROUT
                #
		readinterp libeta
		readinterp uu1
		readinterp lbrel
		readinterp outud0
		readinterp ud0
		readinterp aphi
		readinterp r
		#
		jre bzplots.m
		# now we have libeta and lbrel and ud0
                define cres 20
                plc 0 ioutud0 001 0 $MYROUT 0 $MYROUT
                set myoutud0$2=newfun
                #
                plc 0 iud0 001 0 $MYROUT 0 $MYROUT
                set myud0$2=newfun
                #
                plc 0 ilbrel 001 0 $MYROUT 0 $MYROUT
                set mylbrel$2=newfun
                #
                plc 0 ilibeta 001 0 $MYROUT 0 $MYROUT
                set mylibeta$2=newfun
		#
                plc 0 ir 001 0 $MYROUT 0 $MYROUT
                set myir$2=newfun
                #
                set myoutud0=myoutud0$2
                set myud0=myud0$2
                set mylbrel=mylbrel$2
                set mylibeta=mylibeta$2
                set myir=myir$2
		#
		#bzplot97pre2
		define fname (('$!!MYFILE'))
		device postencap $fname
		bzplot97do
		set image[ix,iy]=myir
		set lev=$rhor,$rhor+1E-9,1E-9
		ctype default contour
		#
		device X11
		#
		#
mybeta 0        #
		fdraft
		define MYFILE linesinner.eps
		punbeta -2 100
		!scp linesinner.eps jon@relativity:/home/jondata/
		#
		define MYFILE linesouter.eps
		punbeta -1 1E3
		!scp linesouter.eps jon@relativity:/home/jondata/
		#
myaphiit 0      #
		window 1 1 1 1
		greaddump dumptavgi
		interpsingle2 aphi 512 512 100 100
		!~/sm/iinterpnoextrap 1 2 1 1 $nx $ny $nz  1.0 0.0 0.5 $igrid \
		    $inx $iny $inz  -$ixmax $ixmax -$iymax $iymax 0 0  $iRin \
		    $iRout $iR0 $ihslope $idefcoord < ./dumps/aphi > ./dumps/iaphi
		    #
		    #
		define MYFILE crap.eps
		punbeta -2 100
		#		
		window 2 1 1 2
		fdraft
		define MYFILE crap.eps
		punbeta -2 1000
		#
		#
		# start actual plot
		device postencap lines.eps
		window 1 2 2 2
		notation -3 3 -3 3
		readinterp aphi
		plc 0 iaphi 001 -99 100 0 100
		#
		window 2 1 1 2
		fdraft
                set myoutud0=myoutud0100
                set myud0=myud0100
                set mylbrel=mylbrel100
                set mylibeta=mylibeta100
                set myir=myir100
		bzplot97do
		set image[ix,iy]=myir
		set lev=$rhor,$rhor+1E-9,1E-9
		ctype default contour
		#
		window 2 1 2 2
		fdraft
                set myoutud0=myoutud01000
                set myud0=myud01000
                set mylbrel=mylbrel1000
                set mylibeta=mylibeta1000
                set myir=myir1000
		bzplot97do
		set image[ix,iy]=myir
		set lev=$rhor,$rhor+1E-9,1E-9
		ctype default contour
		#
		#
		device X11
ergosphere1 0   #
		#
		# jrdp dump0040
		#
		# gammiegrid gdump
		# stresscalc 1
		#
		#
		#
		#
		set Rinold=Rin
		#set _defcoord=0
		#set myRout=40
		#set myZout=20
		set myRout=4
		set myZout=2
		ksp2bl
		#
		plcergo 0 einfblpb 001 $rhor myRout 0 pi
		#
		interpsingle einfblpb 256 256 myRout myZout
		interpsingle einfMAblpb 256 256 myRout myZout
		interpsingle einfEMblpb 256 256 myRout myZout
		interpsingle r 256 256 myRout myZout
		interpsingle zeroergo 256 256 myRout myZout
		interpsingle zerohorizon 256 256 myRout myZout
		interpsingle Tudbl10EM 256 256 myRout myZout
		interpsingle Tudbl10EMcons 256 256 myRout myZout
		interpsingle aphi 256 256 myRout myZout
		#set outflow=((ud0<-1)&&(uu1>0)) ? 1 : 0
		set unbound=(ud0<-1) ? 1 : 0
		interpsingle unbound 256 256 myRout myZout
		set outflow=(uu1>0) ? 1 : 0
		interpsingle outflow 256 256 myRout myZout
		#
		#
		readinterp Tudbl10EM		
		readinterp Tudbl10EMcons		
		readinterp einfblpb
		readinterp einfMAblpb
		readinterp einfEMblpb
		readinterp r
		readinterp zeroergo
		readinterp zerohorizon
		readinterp aphi
		readinterp unbound
		readinterp outflow
		#
		# choose 1 of 3
		plc 0 ieinfMAblpb 001 0 myRout -myZout myZout
		#plc 0 ieinfEMblpb 001 0 myRout -myZout myZout
		#plc 0 ieinfblpb 001 0 myRout -myZout myZout
		#plc 0 iTudbl10EM 001 0 myRout -myZout myZout
		#plc 0 iTudbl10EMcons 001 0 myRout -myZout myZout
		#plc 0 iaphi 001 0 myRout -myZout myZout
		set funnewfun=newfun
		define mymin ($min)
		define mymax ($max)
		#
		# for ieinfMAblpb
		define mymin -1
		define mymax 10
		# for iTudbl10EMcons
		#define mymin -1E-2
		#define mymax .02
		#
		#
		plc 0 ir 001 0 myRout -myZout myZout
		set rnewfun=newfun
		plc 0 izerohorizon 001 0 myRout -myZout myZout
		set hornewfun=newfun
		plc 0 izeroergo 001 0 myRout -myZout myZout
		set ergonewfun=newfun
		plc 0 iunbound 001 0 myRout -myZout myZout
		set unboundnewfun=newfun
		plc 0 ioutflow 001 0 myRout -myZout myZout
		set outflownewfun=newfun
		#
		define missing_data (1E30)
		set radius=sqrt(x12**2+x22**2)
		set funnewfun=(radius<Rinold) ? $missing_data : funnewfun
		set ergonewfun=(radius<Rinold) ? $missing_data : ergonewfun
		set unboundnewfun=(radius<Rinold) ? $missing_data : unboundnewfun
		set outflownewfun=(radius<Rinold) ? $missing_data : outflownewfun
		#
		#
		#
		#
		plcergopun
		#
		#
plcergopun      0
		#
		define x2label "z c^2/GM"
		define x1label "R c^2/GM"
		ctype default
		erase
		#
		box
		#
		limits $txl $txh $tyl $tyh
		image ($rnx,$rny) $txl $txh $tyl $tyh
		set image[ix,iy] = funnewfun
		set lev=-1E-25,1E-25,2E-25
		levels lev
		ctype blue contour
		#
		set image[ix,iy] = funnewfun
		set lev=0,$mymax,($mymax-$mymin)/$cres
		levels lev
		ctype red contour
		#
		#
		set image[ix,iy] = funnewfun
		set lev=$mymin,0,($mymax-$mymin)/$cres
		levels lev
		ctype default contour
		#
		set image[ix,iy] = rnewfun
		set lev=-2E-25,0,2E-25
		levels lev
		ctype cyan contour		
		#
		set image[ix,iy] = hornewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype yellow contour		
		#
		set image[ix,iy] = ergonewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype green contour		
		#		
		set image[ix,iy] = unboundnewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		lweight 3 ctype magenta contour		
		#		
		set image[ix,iy] = outflownewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		lweight 3 ctype blue contour
		lweight 1
		#		
fixolddxdxps 0  #		
		set drdx1=dxdxp1
		set dhdx2=dxdxp2
		set drdx2=r*0
		set dhdx1=r*0
		#
		set dxdxp11=drdx1
		set dxdxp22=dhdx2
		set dxdxp12=drdx2
		set dxdxp21=0*r
		#
ksp2bl 0        # converts T^t_t from KSP -> BL using dxdxp and idxdxp
		#
		set delta=r**2-2*r+a**2
		set Sigma=r**2+(a*cos(h))**2
		set Tudbl00=Tud00-2*r*(drdx1*Tud10+drdx2*Tud20)/delta
		set Tudbl00EM=Tud00EM-2*r*(drdx1*Tud10EM+drdx2*Tud20EM)/delta
		set Tudbl00MA=Tud00MA-2*r*(drdx1*Tud10MA+drdx2*Tud20MA)/delta
		set einf=-Tud00
		set einfEM=-Tud00EM
		set einfbl=-Tudbl00
		set einfEMbl=-Tudbl00EM
		set einfMAbl=-Tudbl00MA
		#
		# fluxes
		#
		set Tudbl10=drdx1*Tud10+drdx2*Tud20
		set Tudbl10EM=drdx1*Tud10EM+drdx2*Tud20EM
		set Tudbl10MA=drdx1*Tud10MA+drdx2*Tud20MA
		#
		set gdetbl=sqrt(Sigma)*sin(h)
		#
		set Tudbl10EMcons=Tudbl10EM*gdetbl
		#
		# from levinson.m
		jre levinson.m
		setjetpart1
		set einfblpb=einfbl/(rho*uu0bl)
		#
		set einfEMblpb=einfEMbl/(rho*uu0bl)
		set einfMAblpb=einfMAbl/(rho*uu0bl)
		#
		# then do something like:
		# plcergo 0 einfEMbl
		# and note that KSP won't show negative einf in ergo since physical observer
		#
fluxpun 0       #
		jrdp dump0040
		ksp2bl
		interpsingle Tudbl10EM 256 256 4 4
		readinterp Tudbl10EM
		plc 0 iTudbl10EM
		#
jetcoll 0       # plot field collimation angle along with other representative models of collimation
		# f10 in paper
		#
		#
		#readcontours contoursksmiddleotherpole.txt
		#readcontours contoursksmiddle.txt
		readcontours contoursnewgod.txt
		set trunctype=1
		truncall
		set middler=tcr
		# normal pole
		#set middleh=(pi-tch)
		set middleh=tch
		#
		#readcontours contoursksouter.txt
		#set trunctype=0
		readcontours contoursnewgodouter.txt
		set trunctype=3
		truncall
		set outerr=tcr
		set outerh=tch
		#
		#readcontours contoursksinner.txt
		readcontours contoursnewgodinner.txt
		#readcontours contoursksinnerotherpole.txt
		set trunctype=2
		truncall
		set innerr=tcr
		#set innerh=(pi-tch)
		# normal pole
		set innerh=tch
		#
		#
		pointsmiddle
		pointsouter
		#pointsinnerpoleother
		pointsinnerpole
		#
		# ergosphere
		set newh=0,pi,pi/500
		set ergor=1+sqrt(1-(a*cos(newh))**2)
		ctype default ltype 1 pl 0 ergor newh 1110
		#
		# horizon
		set rhor=newh*0+$rhor
		ctype default ltype 1 pl 0 rhor newh 1110
		#
		#
		#
pointplots 0    #
		defaults
		pl 0 tcr tctfastv1m 1100
		pl 0 tcr tctfastv1p 1100
		pl 0 tcr tcalfvenv1m 1100
		pl 0 tcr tcalfvenv1p 1100
		plpitchratio
		pllight
		pl 0 tcr tcuu1 1100
		#
plpitchratio 0 #
		# set pitchangle=atan2(ABS(tcoB1),ABS(tcoB3))
		# pl 0 tcr pitchangle 1001 2 1E4 -1 2
		set pitchratio=ABS(tcoB1)/ABS(tcoB3)
		ctype default pl 0 tcr pitchratio 1001 2 1E4 -1 2
		set pitch1=tcoB1*0+1.0
		ctype red pl 0 tcr pitch1 1010
		#
pllight      0  #
		set light1=1-1/((tcgrR*tcw2))
		ctype default pl 0 tcr light1 1001 2 1E4 -10 10
		set lightit=tcgrR*0
		ctype red pl 0 tcr lightit 1010
		#
		# Newtonian para
		#set parah=acos(1-VEC/middler)
		#ctype default ltype 2 pl 0 middler parah 1110
		#
		#
pointsmiddle 0  #
		# middle pole
		fdraft
		ltype 0
		define x2label "\theta_j [^\circ]"
		set mymiddleh=middleh*180/pi
		set mythin=0.01*180/pi
		set mythout=pi/2*180/pi
		ctype default ltype 0 pl 0 middler mymiddleh 1101 (0.8*Rin) 1E4 mythin mythout
		#
		# change limits so don't have to change everything to degrees
		define xin1 (LG(0.8*Rin))
		define xout1 (LG(1E4))
		define thin1 (LG(0.01))
		define thout1 (LG(pi/2))
		limits $xin1 $xout1 $thin1 $thout1
		#
		# BZ para
		set newh=0.06,pi,(pi-.06)/500
		set VEC=1.2
		set parabzr=(VEC*2-2*(1+cos(newh))*(1-LN(1+cos(newh))))/(1-cos(newh))
		ctype default ltype 2 pl 0 parabzr newh 1110
		#
		#
		#
		# outgoing fast point
		set myx=2.26533
		set myy=-0.786464
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# ingoing fast point
		set myx=0.134511
		set myy=-0.1099
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# outgoing aflven point
		set myx=1.20734
		set myy=-0.42095
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# ingoing aflven point
		set myx=0.171425
		set myy=-.117885
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# pitchangle=45deg point
		set myx=1.18451
		set myy=-.405378
		ltype 0 ctype default expand 4 ptype 4 0 points myx myy
		#
		# light cylinder
		set myx=1.24583
		set myy=-0.440436
		ltype 0 ctype default expand 4 ptype 20 0 points myx myy
		#
		# stagnation point
		set myx=0.556166
		set myy=-0.198463
		ltype 0 ctype default expand 4 ptype 2 3 angle 90 points myx myy
		ltype 0 ctype default expand 4 ptype 2 3 angle 0 points myx myy
		#
pointsinnerpoleother 0 
		# inner pole
		ctype default ltype 0 pl 0 innerr innerh 1110
		# BZ para
		set newh=0,pi,pi/500
		set VEC=0.73
		set parabzr=(VEC*2-2*(1+cos(newh))*(1-LN(1+cos(newh))))/(1-cos(newh))
		ctype default ltype 2 pl 0 parabzr newh 1110
		#
		# outgoing fast point
		set myx=2.65627
		set myy=-1.3585
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# ingoing fast point
		set myx=0.126174
		set myy=-.532353
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# outgoing aflven point
		set myx=1.75796
		set myy=-1.03834
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# ingoing aflven point
		set myx=0.134357
		set myy=-.536346
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# pitchangle=45deg point
		set myx=1.76611
		set myy=-1.03834
		ltype 0 ctype default expand 4 ptype 4 0 points myx myy
		#
		# light cylinder
		set myx=1.8573
		set myy=-1.09759
		ltype 0 ctype default expand 4 ptype 20 0 points myx myy
		#
		# stagnation point
		set myx=0.876183
		set myy=-0.662843
		ltype 0 ctype default expand 4 ptype 2 3 angle 90 points myx myy
		ltype 0 ctype default expand 4 ptype 2 3 angle 0 points myx myy
		#
pointsinnerpole 0 
		# inner pole
		ctype default ltype 0 pl 0 innerr innerh 1110
		# BZ para
		set newh=0,pi,pi/500
		set VEC=0.75
		set parabzr=(VEC*2-2*(1+cos(newh))*(1-LN(1+cos(newh))))/(1-cos(newh))
		ctype default ltype 2 pl 0 parabzr newh 1110
		#
		# outgoing fast point
		set myx=2.40493
		set myy=-1.2082
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# ingoing fast point
		set myx=0.131344
		set myy=-.510392
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# outgoing aflven point
		set myx=1.59517
		set myy=-.938
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# ingoing aflven point
		set myx=0.139146
		set myy=-.510392
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# pitchangle=45deg point
		set myx=1.66837
		set myy=-.97589
		ltype 0 ctype default expand 4 ptype 4 0 points myx myy
		#
		# light cylinder
		set myx=1.68203
		set myy=-.97589
		ltype 0 ctype default expand 4 ptype 20 0 points myx myy
		#
		# stagnation point
		set myx=0.793202
		#set myy=-.603667
		set myy=-.625069
		ltype 0 ctype default expand 4 ptype 2 3 angle 90 points myx myy
		ltype 0 ctype default expand 4 ptype 2 3 angle 0 points myx myy
		#
pointsouter 0   #
		#
		# outer pole
		ctype default ltype 0 pl 0 outerr outerh 1110
		# BZ para
		set newh=0.15,pi,(pi-0.15)/500
		set VEC=1.6
		set parabzr=(VEC*2-2*(1+cos(newh))*(1-LN(1+cos(newh))))/(1-cos(newh))
		ctype default ltype 2 pl 0 parabzr newh 1110
		#
		# outgoing fast point
		set myx=1.99175
		set myy=-0.587136
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# ingoing fast point
		set myx=0.130411
		set myy=0.0955
		ctype default expand 4 ptype 4 3 points myx myy
		#
		# outgoing aflven point
		set myx=1.13801
		#set myy=-0.267541
		set myy=-0.255323
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# ingoing aflven point
		set myx=0.200905
		set myy=0.0684253
		ctype default expand 4 ptype 3 3 points myx myy
		#
		# pitchangle=45deg point
		set myx=1.10613
		set myy=-0.231605
		ltype 0 ctype default expand 4 ptype 4 0 points myx myy
		#
		# light cylinder
		set myx=1.21852
		set myy=-0.295252
		ltype 0 ctype default expand 4 ptype 20 0 points myx myy
		#
		# stagnation point
		set myx=0.534779
		#set myy=-0.0540782
		set myy=-0.0420195
		ltype 0 ctype default expand 4 ptype 2 3 angle 90 points myx myy
		ltype 0 ctype default expand 4 ptype 2 3 angle 0 points myx myy
		#
patchyplot1 0   #
		# energy per solid angle
		#
		# jrdp dump0057
		# setupdumpjet # to get averages
		#
		set energy=r**2*EN1tavg*rho*uu1bltavg
		set god=LG(ABS(it))
		plc 0 energy 001 2E3 5E3 2.5 3.0
		#
		#plc 0 god 001 2E3 5E3 2.5 pi
		#
		#pls 0 god 001 2E3 5E3 2.5 3.0
		#
		#
		#
		pls 0 energy 001 4E3 5E3 2.5 3.0
		set avg=SUM(newfun)/dimen(newfun)
		print {avg}
		set diff=ABS(avg-energy)/avg
		pls 0 diff 001 4E3 5E3 2.5 3.0
		jre averystar.m
		#
patchyplot2 0   #
		# could to normal pole
		readcontours contoursksmiddleotherpole.txt
		set trunctype=0
		truncall
		#
		#set myvar=cw1
		#set myvar=tcw2
		#set myvar=tcw3 
		#set myvar=tcuu1
		#set myvar=tctfastv1p
		#set myvar=tctfastv1m
		#set myvar=tctslowv1p
		#set myvar=tctslowv1m
		#set myvar=tcsonicv1p
		#set myvar=tcsonicv1m
		#set myvar=tcalfvenv1p
		#set myvar=tcalfvenv1m
		#set myvar=tcbsq
		#set myvar=tcB1
		#set myvar=tcB3
		#set myvar=tclbrel
		set myvar=tcrho
		#set myvar=tcu
		#set myvar=tcEN1
		#set myvar=tcLN1
		#set myvar=tceta1
		#set myvar=tcD2
		#set myvar=tcB1bl
		#set myvar=tcB2bl
		#set myvar=tcB3bl
		#set myvar=tcBd3bl
		#set myvar=tcuu0bl
		#set myvar=tcuu1bl
		#set myvar=tcuu2bl
		#set myvar=tcuu3bl
		#set myvar=tcud0bl
		#set myvar=tcud1bl
		#set myvar=tcud2bl
		#set myvar=tcud3bl
		#set myvar=tcaccem
		#set myvar=tcaccma
		#set myvar=tccollma
		#set myvar=tccollema
		#set myvar=tccollemb
		#set myvar=tcgammainf
		#set myvar=tcacctem
		#set myvar=tccolltem
		#set myvar=tcacctrueem
		#set myvar=tccolltrueem
		#set myvar=tcemefluxalongB
		#set myvar=tcmaefluxalongB
		#set myvar=tcemlfluxalongB
		#set myvar=tcmalfluxalongB
		#set myvar=tcemefluxacrossB
		#set myvar=tcmaefluxacrossB
		#set myvar=tcemlfluxacrossB
		#set myvar=tcmalfluxacrossB
		#
		#
		ctype default pl 0 tcr myvar 1100
		smooth myvar smyvar 30
		ctype red pl 0 tcr smyvar 1110
		#
		set diff=ABS(myvar-smyvar)/smyvar
		pl 0 tcr diff 1101 1E3 5E3 1E-3 10
		
