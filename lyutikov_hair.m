loadhair 0      #
		gogrmhd
		jre lyutikov_hair.m
		#
hair1 1         #
		set h1='dump'
		set h2=sprintf('%04d',$1) set _fname=h1+h2
		define filename (_fname)
		#
		grid3d gdump
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
        fieldcalc 0 aphi
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
		#
		effonetime
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
		  print + data.txt {_t bsqenergyrat trueenergyrat absfluxrat eta}
		  #
		}
		#
		#
showfullhair2 1  # get figure for no hair paper
		#
		#
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout40_coord0_128sq_sigmafix_nsfield/
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout40_coord0_128sq_sigmafix1E2higher_nsfield/
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg3_nsfield/
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg4_nsfield/
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg5.5_nsfield/
		#cd /data1/jmckinne/
		#cd spin0_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		# below not quite done yet:
		cd /data1/jmckinne/
		cd spin0_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t1 1 bsqenergyrat1 2 trueenergyrat1 3 absfluxrat1 4 eta1 5}
		#
		#
		#cd /data1/jmckinne/
		#cd spin0.99_nodisk_Rout40_coord0_128sq_sigmafix_nsfield/
		#cd /data1/jmckinne/
		#cd spin0.99_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg3_nsfield/
		#cd /data1/jmckinne/
		#cd spin0.99_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		# not quite done yet
		cd /data1/jmckinne/
		cd spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t2 1 bsqenergyrat2 2 trueenergyrat2 3 absfluxrat2 4 eta2 5}
		#
		#
		cd /data1/jmckinne/
		cd spin0_nodisk_Rout40_coord0_128sq_sigmafix_nsfield_ffde/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t3 1 bsqenergyrat3 2 trueenergyrat3 3 absfluxrat3 4 eta3 5}
		#
		#
		cd /data1/jmckinne/
		cd spin0.99_nodisk_Rout40_coord0_128sq_sigmafix_nsfield_ffde/
		#
		fullhair1
		da data.txt
		lines 1 10000000
		read {t4 1 bsqenergyrat4 2 trueenergyrat4 3 absfluxrat4 4 eta4 5}
		#
		#
		if(1){\
		 #
		 #cd /data1/jmckinne/
		 #cd spin0.1_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg5.5_nsfield/
		 #cd /data1/jmckinne/
		 #cd spin0.1_nodisk_Rout1e4_coord0_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield
		 # below not quite done yet
		 cd /data1/jmckinne/
		 cd spin0.1_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t5 1 bsqenergyrat5 2 trueenergyrat5 3 absfluxrat5 4 eta5 5}
		 #
		 #
		 # below not quite done yet
		 cd /data1/jmckinne/
		 cd spin0.99_nodisk_Rout40_coord0_1286416sq_sigmafix_nsfield/
		 fullhair1
		 #
		 da data.txt
		 lines 1 10000000
		 read {t6 1 bsqenergyrat6 2 trueenergyrat6 3 absfluxrat6 4 eta6 5}
		}
		#
		if(1){\
		 #
		 cd /data1/jmckinne/
		 cd spin0.5_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t7 1 bsqenergyrat7 2 trueenergyrat7 3 absfluxrat7 4 eta7 5}
		 #
		 #
		 cd /data1/jmckinne/
		 cd spin0.9_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t8 1 bsqenergyrat8 2 trueenergyrat8 3 absfluxrat8 4 eta8 5}
		 #
		 #
		 cd /data1/jmckinne/
		 cd spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128x16_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		 fullhair1
		 da data.txt
		 lines 1 10000000
		 read {t9 1 bsqenergyrat9 2 trueenergyrat9 3 absfluxrat9 4 eta9 5}
		 #
		 #
		}
		##########
		# spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128x16_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		# spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		# spin0.9_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
		#
		#
		plotfullhair2 $1
		#
plotfullhair2 1 #
		define DOPRINTEPS ($1)
		#
		cd /data/jon/lyutikov_nohair/paper/
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
		################# t1: a=0  t2: a=0.99  t3: ff_0   t4: ff_0.99  t5: a=0.1  t7: a=0.5  t8: a=0.9
		# so order for ltype=1 2 3 4 5  1 5  0
                # for models:      t=1 5 7 8 2  3 4  fit
		#
		ltype 1 pl 0 t1 absfluxrat1 0101 0 2000 1E-12 1E2
		ltype 2 pl 0 t2 absfluxrat2 0111 0 2000 1E-12 1E2
		ltype 3 pl 0 t3 absfluxrat3 0111 0 2000 1E-12 1E2
		ltype 4 pl 0 t4 absfluxrat4 0111 0 2000 1E-12 1E2
		#
		#http://adsabs.harvard.edu/abs/2003ApJ...585..930B
                # for r=20M (well, 24.7M is wavelength of mode)
		#set tswitch=24.7 
                # for r=1M (roughly accounting for wavelength of mode)
                set tswitch=20
		#
		set vacdipole=( (t1<tswitch) ? 1 : ((t1-tswitch+1)**(-4)) )
		#
		ltype 0 pl 0 t1 vacdipole 0111 0 2000 1E-12 1E2
		#
		if(1){\
		 ltype 5 pl 0 t5 absfluxrat5 0111 0 2000 1E-12 1E2
		 ltype 6 pl 0 t6 absfluxrat6 0111 0 2000 1E-12 1E2
		 ctype blue ltype 0 pl 0 t7 absfluxrat7 0111 0 2000 1E-12 1E2
		 ctype red  ltype 0 pl 0 t8 absfluxrat8 0111 0 2000 1E-12 1E2
		 ctype cyan ltype 0 pl 0 t9 absfluxrat9 0111 0 2000 1E-12 1E2
		}
		#
		if($DOPRINTEPS){\
		 device X11
		 !cp phivst.eps /data/jon/lyutikov_nohair/paper/
		}
		#
plotfullhair2simple 1 # for paper
                #
		define DOPRINTEPS ($1)
		#
		#
		fdraft
		define x1label "t c^3/GM"
		define x2label "\Phi_{\rm EM}"
		#
		if($DOPRINTEPS){\
		 device postencap phivst.eps
		}
		#
		#http://adsabs.harvard.edu/abs/2003ApJ...585..930B
                # for r=20M (well, 24.7M is wavelength of mode)
		#set tswitch=24.7 
                # for r=1M (roughly accounting for wavelength of mode)
                set tswitch=20
		#
		set vacdipole=( (t1<tswitch) ? 1 : ((t1-tswitch+1)**(-4)) )
		#
		#
		#
		################# t1: a=0  t2: a=0.99  t3: ff_0   t4: ff_0.99  t5: a=0.1  t7: a=0.5  t8: a=0.9
		# so order for ltype=1 2 3 4 5  1 5  0
                # for models:      t=1 5 7 8 2  3 4  fit
		#  
                # print {absfluxrat1 absfluxrat5 absfluxrat7 absfluxrat8 absfluxrat2 absfluxrat3 absfluxrat4}
		# remove returns to original point for missing dumps
		# print {t1 t5 t7 t8 t2 t3 t4 t1}
		#
                set t8[39]=2050
                set t8[40]=2100
                set t2[37]=2050
                set t2[38]=2100
                set t2[39]=2150
                set t2[40]=2200
		#
		#
		ctype default
		ltype 1 pl 0 t1 absfluxrat1 0101 0 1000 1E-12 1E2
		ltype 2 pl 0 t5 absfluxrat5 0111 0 1000 1E-12 1E2
		ltype 3 pl 0 t7 absfluxrat7 0111 0 1000 1E-12 1E2
		ltype 4 pl 0 t8 absfluxrat8 0111 0 1000 1E-12 1E2
		ltype 5 pl 0 t2 absfluxrat2 0111 0 1000 1E-12 1E2
		ltype 1 pl 0 t3 absfluxrat3 0111 0 1000 1E-12 1E2
		ltype 5 pl 0 t4 absfluxrat4 0111 0 1000 1E-12 1E2
		ltype 0 pl 0 t1 vacdipole 0111 0 1000 1E-12 1E2
		#
		#
		#
		if(0){\
		 set decayt1=500.0
		 set myfit1=5*exp(-(t1-500)/decayt1)
		 ltype 0 pl 0 t1 myfit1 0111 0 2000 1E-16 1E2
		 #
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
		if($DOPRINTEPS){\
		 device X11
		 !scp phivst.eps jon@ki-rh42.slac.stanford.edu:/data/jon/lyutikov_nohair/paper/
		}
		#
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
                ###########################################################################################
                ###########################################################################################
iffieldplot 2   # for initial and final A_\phi plot
                # iffieldplot  <last dump> <0 = aphi 1 = Ad3>
                #
                # choose model
                #
		# cd /data1/jmckinne/
                # cd spin0.1_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
                # iffieldplot 40 0
		# cd /data1/jmckinne/
                # cd spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
                # iffieldplot 37 0
                #
                # Currently high-res 3D.  This model has vpot in restart, so use vpotdump!
		#cd /data1/jmckinne/
		#cd spin0.99_nodisk_Rout1e4_coordjet6npow2_256x128x16_sigmafixrhoatmneg6.0_sigmar1e2_nsfield/
                # iffieldplot 14 1
                #
		# choose dump
		fieldplot 0 $2
		plot2a
                #
		# choose dump
		fieldplot $1 $2
		plot2b
                #
                #
		#
plot2a 0        #
		plc 0 iaphi
		set newiaphi=iaphi-$min
		fdraft
		device postencap iaphiti.eps
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		define cres 50
		plc 0 newiaphi
		showbh
		device X11
		!scp iaphiti.eps jon@ki-rh42.slac.stanford.edu:/data/jon/lyutikov_nohair/paper/
                #
plot2b 0        #
		plc 0 iaphi
		set newiaphi=iaphi-$min
		fdraft
		device postencap iaphitf.eps
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		define cres 50
		plc 0 newiaphi
		showbh
		device X11
		!scp iaphitf.eps jon@ki-rh42.slac.stanford.edu:/data/jon/lyutikov_nohair/paper/
                #
fieldplotread  2    # for interpolated A_\phi plot
                # fieldplotread <dump#>
		#
		set h1='dump'
		set h2=sprintf('%04d',$1) set _fname=h1+h2
		define filename (_fname)
		jrdpcf3duentropy $filename
		fieldcalc 0 aphi
		#
  	        if($2==1){\
	 	 set h1='vpotdump'
		 set h2=sprintf('%04d',$1) set _fname=h1+h2
		 define filename (_fname)
		 jrdpvpot $filename
		}
                #
                #
fieldplotwrite  1    # for interpolated A_\phi plot
                #
                # choose if from vpot or aphi calculation (vpotdump best if exists and correct -- i.e. restarted process correctly saved vpot in restart file and reloaded it correctly)
		writeheader 1 aphi.txt
                #
                # fieldplot <aphi or Ad3>
                #
		if($1==0){\
		 set Ad3avg=aphi
		 #
		}
	        #
		if($1==1){\
		 set Ad3avg=Ad3
		 #
		}
	        #
		if($nz>1){\
		 # then average in phi
		 do ii=0,$nx-1,1 {\
		  do jj=0,$ny-1,1 {\
                   echo Doing $ii $jj
		   set Ad3avg[$ii + $jj*$nx + 0] = Ad3avg[$ii + $jj*$nx + 0]/$nz
		   do kk=1,$nz-1,1 {\
		    set Ad3avg[$ii + $jj*$nx + 0] = Ad3avg[$ii + $jj*$nx + 0] + Ad3avg[$ii + $jj*$nx + $kk*$nx*$ny]/$nz
		   }
		  }
		 }
		}
                #
                print + aphi.txt {Ad3avg}
		#
		#
fieldplotredo  0 #interp+replot only (used when changing interp parameters while file will be same)
                #
                # get back to normal data setup
                jrdpcf3duentropy dump0000
                #
                # now can redo plot from same existing file
                fieldplotsetup
                fieldplotinterp
                #
fieldplot  2    # for interpolated A_\phi plot
                # fieldplot <dump#> <0=aphi 1=Ad3>
                #
                define print_noheader (1)
		#
                #
                fieldplotread $1 $2
                #
                fieldplotsetup
                #
                fieldplotwrite $2
		#
                fieldplotinterp
                #
		#
fieldplotsetup 0 #
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
fieldplotinterp 0 #
                #
		#
                #
                #
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
		fieldplot 40 0
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
		fieldplot 0 0
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
chargehair 0    #
		#
 		jrdpcf3duentropy dump0040
		grid3d gdump
		#
		# value of |b| at "infinity" or some other reasonable reference location to normalize everything
		set Bnorm=sqrt(4.022990227)*sqrt(4.0*pi)
		set Bnorm=sqrt(0.00338138)*sqrt(4.0*pi)
		#
		faraday
		# Q = 1/(4\pi) \int F^{tr}\detg d\theta d\phi
                # F^{tr} = fuu01
		# 4*pi accounts for definition of Q
                # sqrt(4\pi) accounts for Gaussian->HL for Gaussian Q
		set dQ=sqrt(4*pi)*fuu01/(4*pi)
		#
		# commented out below to test Wald charge
                #gcalc2 3 0 pi/2 dQ Qvsr
                gcalc2 6 0 0.955 dQ Qvsr
                #
		#       
		# strength at infinity (sqrt(bsq) at large radius)
                #set Bnorm=2.0
                set Qnorm=Qvsr/(a*2.0*Bnorm)
                set komQnorm=Qvsr/(a*Bnorm)#
		#
		location 6000 31000 6000 31000
                #
                define x1label "r c^2/GM"
                define x2label "Q/(2B_0 J)"
                #
		ctype default pl 0 newr Qnorm 1001 Rin 10 -5 5
		#
		define myrhor (lg($rhor))
                ctype red vertline $myrhor
                #
		#
                set myr=r if(tj==0)
                define iii (0)
                while {$iii<$nx} {
                   if(myr[$iii]>$rhor) {\
                       define myiii ($iii)
                       BREAK
                    }
                    define iii ($iii+1)
                }
                #
                set myQrat=Qnorm[$myiii]
                print {myQrat}
                #
		#
		#
efficiencies 0  #
		#
 		jrdpcf3duentropy dump0040
		grid3d gdump
		#
		set myuse=(r>5 && r<20 ? 1 : 0)
		#
		set gridcheck=gdet*$dx1*$dx2*$dx3 if(myuse)
		#
		set totalgridcheck=SUM(gridcheck)
		#
		set totalgridcorrect=4/3*pi*20**3 - 4/3*pi*5**3
		#
		print {totalgridcheck totalgridcorrect}
		#
		faraday
		stresscalc 1
		#
		effonetime
		#
		#################
		set god= (gdet*$dx2*$dx3*rho*uu1*(-1)) if(ti==2)
		set myh=h if(ti==2)
		#
		pl 0 myh god
		#
		###############
		#
		plc0 0 lbrel
		plc0 0 uu1 010
		#
effonetimepre 0 #
	        #
		gogrmhd
		define DOGCALC 0
		jrdpcf3duentropy dump0252
		#
		# 272x128x256 simulation eats 10GB by this point
		#
		set bsq = bu0*bd0 + bu1*bd1 + bu2*bd2 + bu3*bd3
 		define gam (_gam)
 		set p = ($gam - 1.)*u
 		set ptot = p + 0.5*bsq
		#
		stresscalc 1
		# 272x128x256 simulation eats 21GB by this point
		#
effonetime 0  #
		set myuse=(r>10 && r<12)
		set myti=ti if(myuse)
		set mytrueti=myti[0]
		#
		set Mdotinr10grid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti && uu1<0.0 && bsq/rho<10)
		set Mdotinr10=SUM(Mdotinr10grid)
		#
		set myuse=(r>90 && r<110)
		set myti=ti if(myuse)
		set mytrueti=myti[0]
		#
		set Mdotinr100grid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti && uu1<0.0 && bsq/rho<10)
		set Mdotinr100=SUM(Mdotinr100grid)
		#
		set myuse=(r>90 && r<110)
		set myti=ti if(myuse)
		set mytrueti=myti[0]
		#
		set v4asq=bsq/(rho+u+($gam-1)*u)
		set mum1fake=uu0*(1.0+v4asq)-1.0
		set Mdotjetr100grid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti && uu1>0.0 && mum1fake>1.0 && (rho+u+($gam-1)*u)/rho*(-ud0)>1 && bsq/rho<10)
		set Mdotjetr100=SUM(Mdotinr100grid)
		#
		print {Mdotinr10 Mdotinr100}
		#
		#
		set myuse=(r>0.98*$rhor && r<1.2*$rhor)
		set myti=ti if(myuse)
		set mytrueti=myti[0]
		#
		# Edot>0 means energy out of BH
		set EdotEMgrid=(gdet*$dx2*$dx3)*(-Tud10EM) if(ti==mytrueti)
		# don't want to include mass injected into jet that falls into BH, which usually has bsq/rho>30
		set EdotMAgrid=(gdet*$dx2*$dx3)*(-Tud10MA) if(ti==mytrueti)
		set EdotMAtruegrid=(gdet*$dx2*$dx3)*(-Tud10MA) if(ti==mytrueti && bsq/rho<30)
		set Edotgrid=(gdet*$dx2*$dx3)*(-Tud10) if(ti==mytrueti)
		# Mdot<0 means mass flows into BH
		set Mdotgrid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti)
		set Mdotgridi50=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==50)
		set Mdot30grid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti && bsq/rho>30)
		set Mdot40grid=(gdet*$dx2*$dx3)*(rho*uu1) if(ti==mytrueti && bsq/rho>40)
		set tigrid=ti if(ti==mytrueti)
		#
		set EdotEM=SUM(EdotEMgrid)
		set EdotMAtrue=SUM(EdotMAtruegrid)
		set EdotMA=SUM(EdotMAgrid)
		set Edot=SUM(Edotgrid)
		set Edottrue=EdotEM+EdotMAtrue
		#
		set Mdot=SUM(Mdotgrid)
		set Mdot30=SUM(Mdot30grid)
		set Mdot40=SUM(Mdot40grid)
		set Mdoti50=SUM(Mdotgridi50)
		#
		set trueMdot=Mdot-Mdot30
		#
		print {EdotEM EdotMA EdotMAtrue Edot Edottrue}
		print {Mdot Mdot30 Mdot40 Mdoti50 trueMdot}
		#
                # eta =  (Mdot - Edot)/Mdot = (-Mdot -Edot)/(-Mdot) for Mdot>0
                # so (Mdot + Edot)/Mdot for Mdot>0
		# (Edot - Mdot)/Mdot for Mdot>0 (correct)
		set eta=1-Edot/Mdot
		# eta = 1 - EdotMA/Mdot - EdotEM/Mdot
		set etaEM=-EdotEM/Mdot
		set etaMA=1-EdotMA/Mdot
		#
		set etatrue=1-Edottrue/Mdot
		set etaMAtrue=1-EdotMAtrue/Mdot
		#
		print {eta etaEM etaMA etatrue etaMAtrue}
		#
		# Edot/Mdot=0.95 means eff=1-Edot/Mdot = 5%
		# Edot/Mdot smaller means higher efficiency
		# eff =  1 - Edot/Mdot
                # Edot = KEdot + Mdot
                # eff = 1 - (Kedot + Mdot)/Mdot = (Mdot - (Kedot + Mdot))/Mdot = -Kedot/Mdot for Mdot<0 meaning normal ingoing mass.  So then eff = Kedot/(-Mdot)>0 is + efficiency.  eff>1 means |Mdot|/(-Mdot)>1 means Ke out is as much as mass in.
		# Kedot = Edot - Mdot
		set etatrue2 = 1-Edottrue/trueMdot
		set etatrue2EM=-EdotEM/trueMdot
		set etatrue2MA=1-EdotMAtrue/trueMdot
		print {etatrue2 etatrue2EM etatrue2MA}
	        #
mricheck 0      #
 		# in the end: idx2mri = lambda2max/mydH = valh*2*pi/omegarot
		#
		dercalc 0 h hd
		# if doesn't work, have to do on commandline: ~/bin/smcalc 1 2 0 272 128 256 dumps/forder dumps/hd
		da dumps/hd
 		lines 2 100000000
  		read {dhdx2 2}
		set dH=r*(dhdx2*_dx2)
		#
		set omegarot=(2*pi)*uu3/uu0+1E-15
		set omegarot=r**(-3/2)
		#
 		set omegarat=(((2*pi)*uu3/uu0+1E-15)/r**(-3/2))
		#
 		set vua2 = sqrt(abs(bu2*bd2)/(rho + u + p + bsq))
	 	set res=abs(2.0*pi*vua2/omegarot/dH)
		#
		set vua2alt = abs(sqrt(bsq/(rho + u + p + bsq)))
	 	set res3=abs(2.0*pi*vua2alt/omegarot/dH)
		#
		set vua2less = abs(bu2/_dx2)/sqrt(rho + u + p + bsq)
	 	set res2=abs(2.0*pi*vua2less/omegarot)
		#
		#
		set resdisk = (r*2*0.6)/abs(2.0*pi*vua2/omegarot)
		#
