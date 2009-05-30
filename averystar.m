# rm -rf r160 ; mkdir r160 ; cp inits A0* r160 ; cd r160 ; nohup ./inits 1 1 1 160 160 160 r160out &
		
rddata    1             # rddata A0III_1.4
		#
		da $1
		lines 10 100000000
		read '%g %g %g %g %g %g %g %g %g %g' \
		    { r m rho P T gamma1 U V W C}
		    #
		    # other things
		    set cs2=gamma1*P/rho
		    set u=P/(gamma1-1)
		    #
rdgrf     1   # rdgrf grf128.dat
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {nin fin seed EQK kmin kmax nodiv betanormtype betaact helicity betot alphahel divBavg divBavgnorm divBmax divBmaxnorm divBavgnorm2 divAavg divAavgnorm divAmax divAmaxnorm divAavgnorm2}
		    #
		    #
loadbasic 0 #
		#
		rdbasic 0 0 -1
		jre cartonly.m
		cartgrid
		rd dump0000.dat
		newcartgrid
		#
checkinits 0 #
		rdinits foojon32full.txt
		#
		set mygravx=gravx if(i>0)
		set mygravy=gravy if(j>0)
		set mygravz=gravz if(k>0)
		set itx=SUM(mygravx)/SUM(abs(mygravx)) print {itx}
		set ity=SUM(mygravy)/SUM(abs(mygravy)) print {ity}
		set itz=SUM(mygravz)/SUM(abs(mygravz)) print {itz}
		#
		#
		#
rdinits 1           #
		#
		da $1
		lines 1 1000000
		#
		read '%d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {myi myj myk vx vy vz Ax Ay Az myrho myen gravx gravy gravz radius radius1 radius2 radius3 mofr mofr1 mofr2 mofr3}
		#
		#
		#
newcartgrid 0   #
		set iii=0,$nx*$ny*$nz-1
		set i=INT(iii%$nx)
		set j=INT((iii%($nx*$ny))/$nx)
		set k=INT(iii/($nx*$ny))
		#
		set Lx=2.2
		set Ly=2.2
		set Lz=2.2
		#
		set dx=Lx/$nx
		set dy=Ly/$ny
		set dz=Lz/$nz
		set dV=dx*dy*dz
		#
		set myx=-Lx/2 + (i+0.5)*dx
		set myy=-Ly/2 + (j+0.5)*dy
		set myz=-Lz/2 + (k+0.5)*dz
		set myradius=sqrt(myx**2+myy**2+myz**2)
		#
		define WHICHLEV 16
		define PLANE 3
		#
		#
animcent 0	# center of mass vs. time
                set h1='dump'
                set h3='.dat'
		#
		#define NUMDUMPS (52)
		#
		set endanim=$NUMDUMPS-1
		#set endanim=$NUMFLDUMPS-1
		#
		set x0list=0,endanim,1
		set x0list=x0list*0
		set y0list=x0list*0
		set z0list=x0list*0
		set tlist=x0list*0
		#
                do ii=0,endanim,$ANIMSKIP {
		  if($GAMMIE==0){ set h2=sprintf('%04d',$ii) set _fname=h1+h2+h3 }
		  if($GAMMIE==1){ set h2=sprintf('%04d',$ii) set _fname=h1+h2 }
                  
                  define filename (_fname)
		  rd $filename
		  checks
		  #
		  set tlist[$ii]=$time
		  set x0list[$ii]=frx0
		  set y0list[$ii]=fry0
		  set z0list[$ii]=frz0
		  #
		}
		#
		#
		#
checks 0        #
		#
		# run newcartgrid above
		#
		plc 0 myradius
		relocate 0 0
		putlabel 5 x
		#
		set rho=r
		#
		set x0=SUM(myx*rho*dV)
		set y0=SUM(myy*rho*dV)
		set z0=SUM(myz*rho*dV)
		#
		set frx0=x0/SUM(rho*dV)/Lx
		set fry0=y0/SUM(rho*dV)/Ly
		set frz0=z0/SUM(rho*dV)/Lz
		print {frx0 fry0 frz0}
		#
		# ie
		set x0=SUM(myx*en*dV)
		set y0=SUM(myy*en*dV)
		set z0=SUM(myz*en*dV)
		#
		set fx0=x0/SUM(rho*dV)/Lx
		set fy0=y0/SUM(rho*dV)/Ly
		set fz0=z0/SUM(rho*dV)/Lz
		print {fx0 fy0 fz0}
		#
		plc 0 rho
		#
		set rhoppp=rho[$nz/2*$nx*$ny + $ny/2*$nx + $nx/2]
		set rhoppm=rho[$nz/2*$nx*$ny + $ny/2*$nx + $nx/2-1]
		set rhopmp=rho[$nz/2*$nx*$ny + ($ny/2-1)*$nx + $nx/2]
		set rhopmm=rho[$nz/2*$nx*$ny + ($ny/2-1)*$nx + $nx/2-1]
		#
		set rhompp=rho[($nz/2-1)*$nx*$ny + $ny/2*$nx + $nx/2]
		set rhompm=rho[($nz/2-1)*$nx*$ny + $ny/2*$nx + $nx/2-1]
		set rhommp=rho[($nz/2-1)*$nx*$ny + ($ny/2-1)*$nx + $nx/2]
		set rhommm=rho[($nz/2-1)*$nx*$ny + ($ny/2-1)*$nx + $nx/2-1]
		#
		print {rhoppp rhoppm rhopmp rhopmm}
		print {rhompp rhompm rhopmp rhommm}
		#
		set rhoavg=1/8*(rhoppp+rhoppm+rhopmp+rhopmm+ \
		               rhompp+rhompm+rhommp+rhommm)
		    #
		    print '%21.15g\n' {rhoavg}
		    #
		    
		    #
histo 3        #
                define x2label "Number per bin"
		set godvarit=$1
                sort { godvarit }
                set mybins=$2,$3,($3-$2)/30
                set it=HISTOGRAM(godvarit:mybins)
                set avg=SUM(godvarit)/dimen(godvarit)
                ctype default pl 0 mybins it
		#ctype red vertline avg
                #
histolog 3        #
                define x2label "log10 of Number+1 per bin"
		set godvarit=$1
                sort { godvarit }
                set mybins=$2,$3,($3-$2)/30
                set it=HISTOGRAM(godvarit:mybins)+1
                set avg=SUM(godvarit)/dimen(godvarit)
                ctype default pl 0 mybins it 1101 1E-2 1E2 1E-1 1E3
		#ctype red vertline avg
                #
ploth1 0        #
		fdraft
		device postencap helicityhistogram.eps
		#
		define x1label "Helicity"
		#histo helicity -1E-3 1E-3
		histolog helicity -1E-3 1E-3
		#
		device X11
		#
ploth2 0        #
		fdraft
		device postencap alphaRhistogram.eps
		#
		define x1label "R\alpha"
		#histo alphahel -5 5
		histolog alphahel -1E2 1E2
		#
		device X11
ploth3 0        #
		#
		set hel0=helicity if(nin==0) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(nin==0) histolog alpha0 -5 5
		#
		set hel0=helicity if(EQK==1) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(EQK==0) histolog alpha0 -5 5
		#
		set hel0=helicity if(seed==1) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(seed==1) histolog alpha0 -5 5
		#
		set betot0=betot if(betanormtype==0) histolog betot0 1E-4 2E-3
		set hel0=helicity if(betanormtype==1) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(betanormtype==1) histolog alpha0 -5 5
		#
		set hel0=helicity if(kmin==1) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(kmin==1) histolog alpha0 -5 5
		#
		set hel0=helicity if(kmax==4) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(kmax==4) histolog alpha0 -5 5
		#
		set hel0=helicity if(nodiv==0) histolog hel0 -1E-3 1E-3
		set alpha0=alphahel if(nodiv==0) histolog alpha0 -5 5
		#
		
ploth4 0        # what realizations had smallest alphahel
		#
		ctype default pl 0 alphahel kmin 0001 -3 3 0 3
		ctype red points alphahel kmin
		#
		ctype default pl 0 alphahel EQK 0001 -3 3 0 3
		ctype red points alphahel EQK
		#
		ctype default pl 0 alphahel kmax 0001 -3 3 0 16
		ctype red points alphahel kmax
		#
		ctype default pl 0 alphahel fin 0001 -3 3 -11 11
		ctype red points alphahel fin
		#
		ctype default pl 0 alphahel nodiv 0001 -3 3 0 1
		ctype red points alphahel nodiv
		#
		ctype default pl 0 alphahel betanormtype 0001 -3 3 0 1
		ctype red points alphahel betanormtype
		#
		ctype default pl 0 alphahel betot 0001 -3 3 0 1E-3
		ctype red points alphahel betot
		#
		ctype default pl 0 alphahel divAavg 0001 -3 3 -1E-3 1E-3
		ctype red points alphahel divAavg
		#
		#
plotf1 0        #
		pl 0 xx fdiffx 0101 -1.1 1.1 1E-15 10
		#
plotf2 0        #
		#
		define WHICHLEV 16
		define PLANE 3
		plc 0 fdiff
		#
getforce100  0  #
		#
		forcex forcex0100
		forcey forcey0100
		forcez forcez0100
		#
forcex 1        #
		da $1
		lines 1 1000000
		read {i 1 j 2 k 3 fdiff1 4 press1 5 grav1 6 lrho 7 lu 8}
		set xx=myx if(i>1)
		set yx=myy if(i>1)
		set zx=myz if(i>1)
		set fdiffx=fdiff1 if(i>1)
		set px=press1 if(i>1)
		set gx=grav1 if(i>1)
		#
forcey 1        #
		da $1
		lines 1 1000000
		read {i 1 j 2 k 3 fdiff2 4 press2 5 grav2 6 lrho 7 lu 8}
		set xy=myx if(j>1)
		set yy=myy if(j>1)
		set zy=myz if(j>1)
		set fdiffy=fdiff2 if(i>1)
		set py=press2 if(i>1)
		set gy=grav2 if(i>1)
		#
forcez 1        #
		da $1
		lines 1 1000000
		read {i 1 j 2 k 3 fdiff3 4 press3 5 grav3 6 lrho 7 lu 8}
		set xz=myx if(k>1)
		set yz=myy if(k>1)
		set zz=myz if(k>1)
		set fdiffz=fdiff3 if(i>1)
		set pz=press3 if(i>1)
		set gz=grav3 if(i>1)
		#
rdemf 1         #
		da $1
		lines 1 1000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g'\
		    {i2 j2 k2 rho2 en2 lrho2 len2 vx2 vy2 vz2 bx2 by2 bz2 emfx2 emfy2 emfz2 jx2 jy2 jz2}
