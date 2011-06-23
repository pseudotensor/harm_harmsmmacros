loadhair 0      #
		gogrmhd
		jre lyutikov_hair.m
		#
hair1 1         #
		set h1='dump'
		set h2=sprintf('%04d',$1) set _fname=h1+h2
		define filename (_fname)
		#
		jrdpcf3duentropy dump0000
		stresscalc 1
		faraday
		#
		computethings
		#
		set bsqenergy0=bsqenergy
		set trueenergy0=trueenergy
		set absflux0=absflux
		#
		jrdpcf3duentropy $filename
		stresscalc 1
		faraday
		#
		computethings
		#
		set bsqenergyrat=bsqenergy/bsqenergy0
		set trueenergyrat=trueenergy/trueenergy0
		set absfluxrat=absflux/absflux0
		#
		# print out results for ratios
 		print {bsqenergyrat trueenergyrat absfluxrat}
		#
		#
computethings 0 #		
		set bsqenergy=SUM(bsq*gdet)
		set trueenergy=-SUM(Tud00)
		#
		# approximate
		set myti=3
		set myflux=abs(B1)*gdet*$dx2*$dx3 if(ti==myti)
		set absflux=SUM(myflux)
		#
		set omegarat=(omegaf2*2*pi/(0.5*_a/(2*$rhor)))
		#
fullhair1 0     #
		set startanim=0
		set endanim=40
		#
		!rm -rf data.txt
		#
		do ii=startanim,endanim,$ANIMSKIP {
		  #
		  #
		  hair1 $ii
		  #
		  print + data.txt {_t bsqenergyrat trueenergyrat absfluxrat}
		  #
		}
		#
		#
showfullhair 0  # get figure for ATP proposal
		#
		#cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0
		cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0_128sq_sigmafix/
		#cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0_64sq_sigmafix/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t1 1 bsqenergyrat1 2 trueenergyrat1 3 absfluxrat1 4}
		#
		#
		#cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0
		cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_128sq_sigmafix/
		#cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_64sq_sigmafix/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t2 1 bsqenergyrat2 2 trueenergyrat2 3 absfluxrat2 4}
		#
		#
		#
		# below one is 64^2
		#cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0_ffde
		cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0_128sq_ffde/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t3 1 bsqenergyrat3 2 trueenergyrat3 3 absfluxrat3 4}
		#
		#
		#cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_ffde
		cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_128sq_ffde/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t4 1 bsqenergyrat4 2 trueenergyrat4 3 absfluxrat4 4}
		#
		if(0){\
		 #
		 cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_128sq/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t5 1 bsqenergyrat5 2 trueenergyrat5 3 absfluxrat5 4}
		 #
		 cd /data/jon/lyutikov_nohair/spin0_nodisk_Rout40_coord0_128sq/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t6 1 bsqenergyrat6 2 trueenergyrat6 3 absfluxrat6 4}
		}
		#
		##########
		#
		plotfullhair
		#
		#
plotfullhair 1  #
		define DOPRINTEPS ($1)
		#
		cd /data/jon/lyutikov_nohair/atp
		#
		fdraft
		define x1label "t c^3/GM"
		define x2label "\Phi_{\rm EM}"
		#
		if($DOPRINTEPS){\
		 device postencap phivst.eps
		}
		#
		ctype default
		#
		ltype 1 pl 0 t1 absfluxrat1 0101 0 2000 1E-16 1E2
		ltype 2 pl 0 t2 absfluxrat2 0111 0 2000 1E-16 1E2
		ltype 3 pl 0 t3 absfluxrat3 0111 0 2000 1E-16 1E2
		ltype 4 pl 0 t4 absfluxrat4 0111 0 2000 1E-16 1E2
		#
		if(0){\
		 set decayt1=100.0
		 set myfit1=5*exp(-(t1-500)/decayt1)
		 ltype 0 pl 0 t1 myfit1 0111 0 2000 1E-16 1E2
		 #
		 set decayt2=200.0
		 set myfit2=5*exp(-(t2-500)/decayt2)
		 ltype 0 pl 0 t2 myfit2 0111 0 2000 1E-16 1E2
		 #
		 set decayt3=20.0
		 set myfit3=1*exp(-(t3+0)/decayt3)
		 ltype 0 pl 0 t3 myfit3 0111 0 2000 1E-16 1E2
		 #
		}
		#
		ltype 0 pl 0 t1 ((t1-1)**(-4)) 0111 0 2000 1E-16 1E2
		#
		if(0){\
		 ltype 5 pl 0 t5 absfluxrat5 0111 0 2000 1E-16 1E2
		 ltype 6 pl 0 t6 absfluxrat6 0111 0 2000 1E-16 1E2
		}
		#
		if($DOPRINTEPS){\
		 device X11
		 !cp phivst.eps /data/jon/lyutikov_nohair/atp/
		}
		#
		#
		#
fieldplot  1    #
		set h1='dump'
		set h2=sprintf('%04d',$1) set _fname=h1+h2
		define filename (_fname)
		#
		#
                define print_noheader (1)
		#
		jrdpcf3duentropy $filename
		#
		fieldcalc 0 aphi
		#
		writeheader 1 aphi.txt
		print + aphi.txt {aphi}
		#
		#
		# normal x,y,z
                define inx (256) # Cart x
                define iny (1) # Cart y
                define inz (256)   # Cart z
                #
		#
                set myangledeg=90
                define tnrdegrees (0)
                set mytnrdegrees=$tnrdegrees
                #
		############ axisymmetry (half-plane)
                if(1){\
                define ixmin (0) # Cart x
                define ixmax (10)
                define iymin (-1E-15) # Cart y
                define iymax (1E-15)
                define izmin (-5) # Cart z
                define izmax (5)
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
		#define program "/data/jon/iinterp"
		define program "/home/jon/bin/iinterp"
                #
		#
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
                #
                #
		#
                #define DEFAULTVALUETYPE 4
                define DEFAULTVALUETYPE 0
                #
		! $program -oldargs $DATATYPE $interptype $READHEADERDATA $WRITEHEADERDATA \
                    1 $nx $ny $nz $refinement 0 0  $oldgrid $igrid \
                    1 $iinx $iiny $iinz 0 0 $iixmin $iixmax $iiymin $iiymax $iizmin $iizmax \
                    $iRin $iRout $iR0 $ihslope $idefcoord $dofull2pi \
                               $tnrdegrees $EXTRAPOLATE $DEFAULTVALUETYPE < aphi.txt > iaphi.txt
                #
                #
		jrdpheader3d iaphi.txt
                da iaphi.txt
                lines 2 100000000
                read {iaphi 1}
                #
		#
		#
		#
                gsetup
		define LOGTYPE (0)
                define coord (1)
                define nx (_n1)
                define ny (_n2)
                define nz (_n3)
                echo $nx $ny $nz
                define dx (_dx1)
                define dy (_dx2)
                define dz (_dx3)
                set iii=0,$nx*$ny*$nz-1,1
                set ti=INT(iii%$nx)
                set tj=INT(iii/$nx)
                set tk=INT(iii/($nx*$ny))
                set i=ti
                set j=tj
                set k=tk
                #set k=iii/($nx*$ny)
                set x1=_startx1+_dx1*ti
                set x2=_startx2+_dx2*tj
                set x3=_startx3+_dx3*tk
                set x12=_startx1+_dx1*(ti+0.5)
                set x22=_startx2+_dx2*(tj+0.5)
                set x32=_startx3+_dx3*(tk+0.5)
                set r=x1
                set h=x2
                set p=x3
                set tx1=x1
                set tx2=x2
                set tx3=x3
                set gdet=gdet*0+1.0
                define interp (0)
                define Sx (x1[0])
                define Sy (x2[0])
                define Sz (x3[0])
                # x1[dimen(x1)-1] is not outer edge of box!
                #define Lx (x1[dimen(x1)-1]-x1[0])
                #define Ly (x2[dimen(x2)-1]-x2[0])
                #
                define Lx ($dx*$nx)
                define Ly ($dy*$ny)
                define Lz ($dz*$nz)
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
showfieldplot 0 # get figure for ATP proposal
		#
		#cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0/
		cd /data/jon/lyutikov_nohair/spin0.99_nodisk_Rout40_coord0_128sq_sigmafix/
		#
		###############################################
		fieldplot 40
		#
		plc 0 iaphi
		set newiaphi=iaphi-$min
		#
		#
		device postencap iaphi_nohairt2000.eps
		fdraft
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		plc 0 newiaphi
		showbh
		#
		device X11
		#
		!cp iaphi_nohairt2000.eps /data/jon/lyutikov_nohair/atp/
		#
		###############################################
		fieldplot 0
		#
		plc 0 iaphi
		set newiaphi=iaphi-$min
		#
		#
		device postencap iaphi_nohairt0.eps
		fdraft
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		#
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		plc 0 newiaphi
		showbh
		#
		device X11
		#
		!cp iaphi_nohairt0.eps /data/jon/lyutikov_nohair/atp/
		#
showbh 0        #
                # circle
                set rns=$rhor
                set xns=0
                set yns=0
                #set Rns=Rinold
                set Rns=$rhor
                #
                set t=0,2*pi,.01
                set x=xns+Rns*sin(t)
                set y=yns+Rns*cos(t)
                set x=x concat $(x[0])
                set y=y concat $(y[0])
		#
                shade 0 x y
                #
                lweight 5
                connect x y
                lweight 1
                #
