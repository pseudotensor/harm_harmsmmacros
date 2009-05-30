overlay1      0 # requires godall
		greaddump dumptavg2040v2
		gammienew
		readg42 tavg422040.txt
		#
		interpsingle ud0
		interpsingle aphi
		interpsingle lrho
		readinterp ud0
		readinterp aphi
		readinterp lrho
		#
		define cres 256
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR default
		ctype default plc 0 iud0
		define cres 50
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		ctype red plc 0 ilrho 010
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		ctype blue plc 0 iaphi 010
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		set myv1=uu1/uu0
		plc 0 myv1
		#
		# EM energy
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR blue
		set myeme=Tud01EM*gdet
		plc 0 myeme 010
		# EM flux
		define POSCONTCOLOR green
		define NEGCONTCOLOR cyan
		set myemfl=Tud10EM*gdet
		plc 0 myemfl 010
		#
		#
		# Magnetic field
		define cres 50
		define POSCONTCOLOR blue
		define NEGCONTCOLOR green
		plc 0 aphi
		#
		# radial EM flux
		define cres 50
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		set myemfl=Tud10EM*gdet
		plc 0 myemfl 010
		#
		# theta EM flux
		define cres 100
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR green
		set myemfl=Tud20EM*gdet
		plc 0 myemfl 010
		#	
		#
		#
		#
		set emvx=-gdet*Tud10EM*dx2*dx3
		set emvy=-gdet*Tud20EM*dx1*dx3
		ctype default
		#		vpl 0 emv 50 12
		define SKIPFACTOR 5
		#vpl 0 emv 3000 12 001 Rin Rout 0 1
		# fiducial 456^2 run
		vpl 0 emv 3000 12 001 Rin Rout 0 0.6
		# fiducial 256^2 a=0.5 run
		#vpl 0 emv 30000 12
		#
		# mass flux
		set emvx=-gdet*Tud10MA*dx2*dx3
		set emvy=-gdet*Tud20MA*dx1*dx3
		ctype red
		#		vpl 0 emv 50 12
		define SKIPFACTOR 5
		vpl 0 emv 3000 12 011 Rin Rout 0 0.6
		#
		#
		#
		set emvx=-gdet*Tud10*dx2*dx3
		set emvy=-gdet*Tud20*dx1*dx3
		ctype default
		#		vpl 0 emv 50 12
		define SKIPFACTOR 5
		#vpl 0 emv 3000 12 001 Rin Rout 0 1
		# fiducial 456^2 run
		vpl 0 emv 3000 12 001 Rin Rout 0 0.6
		# fiducial 256^2 a=0.5 run
		#vpl 0 emv 30000 12
		#
		#
		#
		set emv=sqrt(emvx**2+emvy**2)
		plc 0 emv
		#
fluxtest1 0     #
		set rinner=Rin
		set router=Rout
		set hinner=0
		set houter=0.6
		#
		# find the i for a given radius
		define newii (0)
		while { $newii<$nx } {\
		       if(r[0*$nx+$newii]>=rinner) { break }
		       define newii ($newii+1)
		    }
		set iselinner=$newii
		if(iselinner==$nx) { set iselinner=$nx-1 }
		#
		#
		# find the i for a given radius
		define newii (0)
		while { $newii<$nx } {\
		       if(r[0*$nx+$newii]>=router) { break }
		       define newii ($newii+1)
		    }
		set iselouter=$newii
		if(iselouter==$nx) { set iselouter=$nx-1 }
		#
		#
		# find the j for a given theta
		define newjj (0)
		while { $newjj<$ny } {\
		       if(h[$newjj*$nx]>=hinner) { break }
		       define newjj ($newjj+1)
		    }
		set jselinner=$newjj
		if(jselinner==$ny) { set jselinner=$ny-1 }
		#
		#
		# find the j for a given theta
		define newjj (0)
		while { $newjj<$ny } {\
		       if(h[$newjj*$nx]>=houter) { break }
		       define newjj ($newjj+1)
		    }
		set jselouter=$newjj
		if(jselouter==$ny) { set jselouter=$ny-1 }
		#
		print {rinner router hinner houter}
		print {iselinner iselouter jselinner jselouter}
		#
		set fri=gdet*dx2*dx3*Tud10EM
		#
		set use=((ti==iselinner)&&(tj>=jselinner)&&(tj<=jselouter)) ? 1 : 0
		set frinner=SUM(fri*use)
		set use=((ti==iselouter)&&(tj>=jselinner)&&(tj<=jselouter)) ? 1 : 0
		set frouter=SUM(fri*use)
		#
		set fhi=gdet*dx1*dx3*Tud20EM
		#
		set use=((tj==jselinner)&&(ti>=iselinner)&&(ti<=iselouter)) ? 1 : 0
		set fhinner=SUM(fhi*use)
		set use=((tj==jselouter)&&(ti>=iselinner)&&(ti<=iselouter)) ? 1 : 0
		set fhouter=SUM(fhi*use)
		#
		set tot=frouter-frouter+fhouter+fhinner
		#
		print {frinner frouter fhinner fhouter tot}
		#
		#pls 0 fri 001 Rin Rout 0 1.0
flenerplots1 0   # some plots of interest
		#
		# electromagnetic energy flux from horizon and outbound/unbound at outer edge.
		define x1label "t c^3/(GM)"
		define x2label "F^{(EM)}_E"
		ctype default pl 0 t ((u1dotj1part3+u1dotj1part5+u1dotj1part6))
		ctype red plo 0 t ((u1dotj0part3+u1dotj0part5+u1dotj0part6))
		# a=0.9375 late time value for torus model
		set it=t*0+(-4E-3)
		ctype blue plo 0 t it
		#
		#
checkcons     0 #
		# run jrdpener0/1/2 first
		#
		# check if fails or floors or limitgamma or inflowcheck causes loss in conservation
		#
		# u1 subtracts out rest mass energy (see phys.c in HARM)
		# i.e. flux[UU]=mhd[0]+flux[RHO] (no rest mass energy)
		#
		ctype default pl 0 t u0
		ctype red plo 0 t (u0-u0fl)
		#
		ctype default pl 0 t u1
		ctype red plo 0 t (u1-u1fl)
		#
		ctype default pl 0 t u2
		ctype red plo 0 t (u2-u2fl)
		#
		ctype default pl 0 t u3
		ctype red plo 0 t (u3-u3fl)
		#
		ctype default pl 0 t u4
		ctype red plo 0 t (u4-u4fl)
		#
		ctype default pl 0 t u5
		ctype red plo 0 t (u5-u5fl)
		#
		ctype default pl 0 t u6
		ctype red plo 0 t (u6-u6fl)
		#
		ctype default pl 0 t u7
		ctype red plo 0 t (u7-u7fl)
		#
failtest 0      #
		#
		 !ls dumps/
		 jrdp dump0028
		 gammienew
		 jrdpdebug debug0140
		 help defaults
		 #
		 device postencap ud0_fail_floor.eps
		 define POSCONTCOLOR default
		 define NEGCONTCOLOR default
		 plc 0 ud0
		 define POSCONTCOLOR red
		 define NEGCONTCOLOR red
		 plc 0 lg1fail 010
		 define POSCONTCOLOR blue
		 define NEGCONTCOLOR blue
		 plc 0 lg1flooract 010
		 device X11
		 !scp ud0_fail_floor.eps metric:ud0_fail_floor_new.eps
		# !scp ud0_fail_floor.eps metric:ud0_fail_floor_5d.eps
		 
calcjetenergy 0 #
		jrdp dump0030
		gammienew
		#
		gammiegrid gdump
		stresscalc 1
		#
		set alpha=1/sqrt(-gn300)
		#
		#
		# determine jet region
		set myud0=(ud0+1<0) ? ud0 : 0
		# DeVilliers form
		#set enth=1+u/rho+p/rho
		#set myud0=(ud0*enth+1<0) ? enth*ud0 : 0
		set myuu1=(uu1>0) ? uu1 : 0
		set my2ud0=(myuu1>0&&myud0<0) ? myud0 : 0
		# now my2ud0<0 is unbound, outbound, jet
		#
		set tote=(my2ud0<0) ? Tud00*gdet*dx1*dx2*dx3*alpha : 0
		set totmage=(my2ud0<0) ? Tud00EM*gdet*dx1*dx2*dx3*alpha : 0
		set totmate=(my2ud0<0) ? Tud00MA*gdet*dx1*dx2*dx3*alpha : 0
		set totesum=SUM(tote)
		set totmagesum=SUM(totmage)
		set totmatesum=SUM(totmate)
		print {totesum totmagesum totmatesum}
		#
		set metrich1=sqrt(gv311)
		#
		#set totrf=(my2ud0<0) ? Tud10*gdet*metrich1*dx1*dx2*dx3*alpha : 0
		#set totmagrf=(my2ud0<0) ? Tud10EM*gdet*metrich1*dx1*dx2*dx3*alpha : 0
		#set totmatrf=(my2ud0<0) ? Tud10MA*gdet*metrich1*dx1*dx2*dx3*alpha : 0
		set totrf=(my2ud0<0) ? Tud10*gdet**dx1*dx2*dx3 : 0
		set totmagrf=(my2ud0<0) ? Tud10EM*gdet**dx1*dx2*dx3 : 0
		set totmatrf=(my2ud0<0) ? Tud10MA*gdet**dx1*dx2*dx3 : 0
		set totrfsum=SUM(totrf)
		set totmagrfsum=SUM(totmagrf)
		set totmatrfsum=SUM(totmatrf)
		print {totrfsum totmagrfsum totmatrfsum}
		#
		#
		set myeflem=(my2ud0<0) ? (gdet*eflem) : 0
		set myeflma=(my2ud0<0) ? (gdet*eflma) : 0
		set my3ud0=(my2ud0==0) ? -1 : my2ud0
		set my4ud0=(my3ud0<-1.5) ? my3ud0 : -1
		set myud3=(my3ud0<-1.0) ? ud3 : 0
		set my2ud3=(my3ud0<-1.5) ? ud3 : 0
		set myh=h if((my4ud0<-1.5)&&(h>pi/2))
		set myhavg=SUM(myh)/dimen(myh)
		print {myhavg}
		#
		#
		jrdp dump0030
		gammienew
		interpsingle myeflem
		jrdp dump0030
		gammienew
		interpsingle myeflma
		jrdp dump0030
		gammienew
		interpsingle my3ud0		
		#
		define cres 20
		#device postencap erfluxbig.eps
		define x1label "R GM/c^2"
		define x2label "z GM/c^2"
		plc 0 imyeflem
		ctype red plc 0 imyeflma 010
		ctype blue plc 0 imy3ud0 010
		#device X11
		#!scp erfluxbig.eps metric:research/papers/bz/
		#
jetvstpre    0          #
		jrdp dump0000
		gammienew
		gammiegrid gdump
		#
		set alpha=1/sqrt(-gn300)
		#
jetvst        3         # jetvst 'dump' 0 40
		#
		set h1=$1
		set numstart=$2
		set numend=$3
		set numtotal=numend-numstart+1
		#
		set sumevst=0,numtotal-1,1
		set sumevst=sumevst*0
		set summagevst=sumevst*0
		set summatevst=sumevst*0
		set sumevsti=sumevst*0
		set summagevsti=sumevst*0
		set summatevsti=sumevst*0
		set sumt=sumevst*0
		#
		do iii=numstart,numend,1 {
		   set h2=sprintf('%04d',$iii)
		   set _fname=h1+h2
		   define filename (_fname)
		   jrdp $filename
		   #
		   stresscalc 1
		   # determine jet region
		   set myud0=(ud0+1<0) ? ud0 : 0
		   # DeVilliers form
		   #set enth=1+u/rho+p/rho
		   #set myud0=(ud0*enth+1<0) ? enth*ud0 : 0
		   set myuu1=(uu1>0) ? uu1 : 0
		   set my2ud0=(myuu1>0&&myud0<0) ? myud0 : 0
		   # now my2ud0<0 is unbound, outbound, jet
		   #
		   set Startr=38
		   set Deltar=2
		   set tote=(my2ud0<0) ? Tud10 : 0
		   set totmage=(my2ud0<0) ? Tud10EM : 0
		   set totmate=(my2ud0<0) ? Tud10MA : 0
		   joncalc3 1 1 Startr (Startr+Deltar) pi/2 tote totesum
		   joncalc3 1 1 Startr (Startr+Deltar) pi/2 totmage totmagesum
		   joncalc3 1 1 Startr (Startr+Deltar) pi/2 totmate totmatesum
		   #
		   # get field-line region that goes into wind
		   #
		   fieldcalc 0 aphi
		   plc 0 my2ud0
		   set minud0=$min
		   #
		   set myfield=(my2ud0<minud0*0.9) ? aphi : 0
		   set myfield2=(r>0.95*Rout) ? myfield : 0
		   plc 0 myfield2
		   set myfield3=$max
		   plc 0 aphi
		   set lev=myfield3,myfield3*1.01,0.01
		   levels lev ctype blue contour
		   #
		   define iiii (0)
		   while { $iiii<$ny/2-1 } {\
		      if(aphi[0+$iiii*$nx]>myfield3){ break }
		      define iiii ($iiii+1)
		   }
		   set innerfieldh=h[$nx*$iiii] print{innerfieldh}
		   #
		   joncalc3 1 1 $rhor (1.1*$rhor) innerfieldh Tud10 totesumi
		   joncalc3 1 1 $rhor (1.1*$rhor) innerfieldh Tud10EM totmagesumi
		   joncalc3 1 1 $rhor (1.1*$rhor) innerfieldh Tud10MA totmatesumi
		   #
		   set sumevst[$iii-numstart]=-totesum
		   set summagevst[$iii-numstart]=-totmagesum
		   set summatevst[$iii-numstart]=-totmatesum
		   #
		   set sumevsti[$iii-numstart]=-totesumi
		   set summagevsti[$iii-numstart]=-totmagesumi
		   set summatevsti[$iii-numstart]=-totmatesumi
		   #
		   set sumt[$iii-numstart]=_t
		}
		print jetvst.txt {sumt sumevsti sumevst summagevsti summagevst summatevsti summatevst}
		#
