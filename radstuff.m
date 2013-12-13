test1 0 #
 
 jrdprad dump0000
 set prad0t0=prad0[799]
 set prad1t0=prad1[799]
 jrdprad dump0001
 set prad1t1=prad1[799]
 set prad0t1=prad0[799]
 #
 set rat0=prad0t1/prad0t0
 set rat1=prad1t1/prad1t0
 #
 print {rat0 rat1}
 
 set uu0ortho=uu0*sqrt(abs(gv300))
 set uu1ortho=uu1*sqrt(abs(gv311))
 set uu2ortho=uu2*sqrt(abs(gv322))
 set uu3ortho=uu3*sqrt(abs(gv333))
 
 set uur1ortho=prad1*sqrt(abs(gv311))
 set uur2ortho=prad2*sqrt(abs(gv322))
 set uur3ortho=prad3*sqrt(abs(gv333))
 set ursq=uur1ortho*uur1ortho+uur2ortho*uur2ortho+uur3ortho*uur3ortho
 set uur0ortho=sqrt(1.0+ursq)
 
 set Rtt=(-U8/gdet*sqrt(abs(gv300)))
 set Rtx=(U9/gdet*sqrt(abs(gn311)))
 set Rty=(U10/gdet*sqrt(abs(gn322)))
 set Rtz=(U11/gdet*sqrt(abs(gn333)))
 #
 set myRtt=(prad0/3)*(4*uur0ortho*uur0ortho-1)
 set myRtx=(prad0/3)*(4*uur0ortho*uur1ortho-0)
 set myRty=(prad0/3)*(4*uur0ortho*uur2ortho-0)
 set myRtz=(prad0/3)*(4*uur0ortho*uur3ortho-0)
 #
 pl 0 r (Rtt/myRtt)

 pl 0 r (Rtx/myRtx)

 

  stresscalc 1
  set indexn=1/($gam-1)
  set entropy=rho*ln(p**indexn/rho**(indexn+1))
  set myU12pergdet=entropy*uu0
  #
  plc 0 (U0/gdet/(rho*uu0))
  plc 0 (U1/gdet/(Tud00+rho*uu0))
  plc 0 (U2/gdet/(Tud01))
  plc 0 (U3/gdet/(Tud02))
  plc 0 (U4/gdet/(Tud03))
  plc 0 (U12/gdet/(myU12pergdet))

  
doallrad 0 #
       #
       cd /data/jon/harmgit/torusradchecklongdouble/runnorada9375/
       grid3d gdump
       jrdprad dump2000
       radcomp1
       !cp rad.txt ~/runnorada9375.txt
       #
       #
       cd /data/jon/harmgit/torusradchecklongdouble/runnorada0/
       grid3d gdump
       jrdprad dump2000
       radcomp1
       !cp rad.txt ~/runnorada0.txt
       #
       #
       cd /data/jon/harmgit/torusradchecklongdouble/runrada9375/
       grid3d gdump
       jrdprad dump1875
       radcomp1
       !cp rad.txt ~/runrada9375.txt
       #
       #
       cd /data/jon/harmgit/torusradchecklongdouble/runrada0/
       grid3d gdump
       jrdprad dump2000
       radcomp1
       !cp rad.txt ~/runrada0.txt
       #
  
radcomp1 0 #  
   #
   define print_noheader (0)
   #
   stresscalc 1
   #
   set MSUN=1.9891E33
   set sigmaT=0.665E-24
   set mproton=1.673E-24
   set Ledd=4*pi*GGG*(MPERSUN*MSUN)*mproton*CCCTRUE/sigmaT
   print {Ledd}
   #
   set dMdot=(rho*uu1*gdet*$dx2*$dx3)
   set dMdothor=dMdot if(ti==4)
   set Mdothor=abs(SUM(dMdothor))*MBAR/TBAR print {Mdothor}
   set Mdothormsun=Mdothor/MSUN*(3.14E7) print {Mdothormsun}
   set Edothor=Mdothor*CCCTRUE**2 print {Edothor}
   #
   set R10=-(prad0/3.0)*(4.0*uru1*urd0)
   set R20=-(prad0/3.0)*(4.0*uru2*urd0)
   set R30=-(prad0/3.0)*(4.0*uru3*urd0)
   #
   set dRdot=((-R20*gdet*$dx1*$dx3)) if(ti<=50 && tj==7)
   set Rdot=SUM(dRdot)*ENBAR/TBAR print {Rdot}
   #
   # for 128x64 models, below chooses r\sim 81M as in python stripct at r=80M
   #set whichti=int($nx*4.0/5.0)
   # below is like r\sim 97M
   set whichti=int($nx*5.0/6.0)
   set myuse=(ti==whichti && tautotmax<=1.0)
   #set myuse=(ti==50)
   set dh=$dx2*dxdxp22
   set dphi=$dx3*dxdxp33
   set ddRdot2=(R10*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dRdot2=ddRdot2 if(myuse)
   set Rdot2=SUM(dRdot2)
   set area=(sin(h)*dh*dphi)
   set myarea=area if(myuse)
   set totalarea=SUM(myarea)
   set dRdot2iso=(ddRdot2)*(totalarea/area) if(myuse)
   set dRdot2iso2=(ddRdot2)*(4.0*pi/area) if(myuse)
   set ddEMdot2=(-Tud10EM*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dEMdot2=(ddEMdot2) if(myuse)
   set EMdot2=SUM(dEMdot2)
   set dEMdot2iso=(ddEMdot2)*(totalarea/area) if(myuse)
   set dEMdot2iso2=(ddEMdot2)*(4.0*pi/area) if(myuse)
   set ddMAdot2=(-Tud10MA*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dMAdot2=(ddMAdot2) if(myuse)
   set MAdot2=SUM(dMAdot2)
   set dMAdot2iso=(ddMAdot2)*(totalarea/area) if(myuse)
   set dMAdot2iso2=(ddMAdot2)*(4.0*pi/area) if(myuse)
   set ddMdot2=((rho*uu1)*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dMdot2=(ddMdot2) if(myuse)
   set Mdot2=SUM(dMdot2)
   set dMdot2iso=(ddMdot2)*(totalarea/area) if(myuse)
   set dMdot2iso2=(ddMdot2)*(4.0*pi/area) if(myuse)
   #
   set gamma2=uu0 if(myuse)
   set dtheta=h  if(myuse)
   #
   print rad.txt {_t _a}
   #
   print + rad.txt '\n' {}
   print + rad.txt  '%14g %14g %14g\n' {Ledd Mdothor Mdothormsun}
   #
   set Edothor=Edothor/Ledd
   set Rdot2=Rdot2/Ledd
   set EMdot2=EMdot2/Ledd
   set MAdot2=MAdot2/Ledd
   set Mdot2=Mdot2/Ledd
   print + rad.txt '\n' {}
   print + rad.txt  '%14g %14g %14g %14g %14g\n' {Edothor Rdot2 EMdot2 MAdot2 Mdot2}
   #
   set Rdot2iso=dRdot2iso/Ledd
   set dRdot2=dRdot2/Ledd
   set dEMdot2=dEMdot2/Ledd
   set dMAdot2=dMAdot2/Ledd
   set dMdot2=dMdot2/Ledd
   set bsqorho=bsq/rho if(myuse)
   print + rad.txt '\n' {}
   print + rad.txt '%14g %14g %14g %14g %14g %14g %14g %14g\n'{dtheta Rdot2iso dRdot2 dEMdot2 dMAdot2 dMdot2 gamma2 bsqorho}
   #
   set Rdot2iso2=dRdot2iso2/Ledd
   set EMdot2iso2=dEMdot2iso2/Ledd
   set MAdot2iso2=dMAdot2iso2/Ledd
   set Mdot2iso2=dMdot2iso2/Ledd
   print + rad.txt '\n' {}
   print + rad.txt '%14g %14g %14g %14g %14g\n' {dtheta Rdot2iso2 EMdot2iso2 MAdot2iso2 Mdot2iso2}
   #
   #
radcomp2 0 #
   set Rcyl=abs(r*sin(h))
   set phi=-1/(r-2)
   set phieq=-1/(Rcyl-2)
   set rs=2
   set r0=40*rs
   set l0=r0**1.5/(r0-rs)
   set aa=0.46
   set ll=l0*(Rcyl/r0)**aa
   set rhoc=1.0
   set nn=1/(4/3-1)
   set phir0=-1/(r0-rs)
   set phieff=phi+0.5*(ll/Rcyl)**2/(1-aa)
   set phieffr0=phir0+0.5*(l0/r0)**2/(1-aa)
   set phieffeq=phieq+0.5*(ll/Rcyl)**2/(1-aa)
radcomp3 0 #
   set kappatot = kappa+kappaes
   set H = r*cos(h)
   set lambdatot=1/kappatot
   # diffusion time at a given height
   set Td=3.0*H*H/lambdatot
   set Tds=3.0*H*H*kappaes
   set Tda=3.0*H*H*kappa
testkom1 3 #
   jrdp3duentropy dump0000
   ctype default pl 0 r $1  0001 -0.6 1.6 $2 $3
   jrdp3duentropy dump0001
   ctype red pl 0 r $1 0011 -0.6 1.6 $2 $3
   #
   #
   #
   #
   ##########################################
   #
   #
   #
   #
   #
   #
velvsrad2 1 # velvsradpl <doscp=0,1>
        #########################################
        #
        set doscp=$1
        #
        # bounding box:
        #http://amath.colorado.edu/documentation/LaTeX/reference/bbox.html
        #
        #
        # FINALPLOTS:
        #
        #
        #
        plotradpulse3da 1
        device X11
        if(doscp==1){\
         !epstopdf testradpulse3da.eps 
         !scp testradpulse3da.eps testradpulse3da.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
velvsrad1 1
        #
        set doscp=$1
        #
        if(1){\
        device postencap5 test23.eps
        panelplot1
        device X11
        if(doscp==1){\
         !epstopdf test23.eps 
         !scp test23.eps test23.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap5 test22.eps
        panelplot2
        device X11
        if(doscp==1){\
         !epstopdf test22.eps 
         !scp test22.eps test22.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap5 test21.eps
        panelplot3
        device X11
        if(doscp==1){\
         !epstopdf test21.eps 
         !scp test21.eps test21.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        #
        device postencap5 test24.eps
        panelplot4
        device X11
        if(doscp==1){\
         !epstopdf test24.eps 
         !scp test24.eps test24.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap5 test25.eps
        panelplot5
        device X11
        if(doscp==1){\
         !epstopdf test25.eps 
         !scp test25.eps test25.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        }
        if(1){\
        device postencap testradpulse3db.eps
        plotradpulse3db
        device X11
        if(doscp==1){\
         !epstopdf testradpulse3db.eps 
         !scp testradpulse3db.eps testradpulse3db.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        }
   #
        device postencap plot_p1d_0.eps
        plotradpulseplanar
        device X11
        if(doscp==1){\
         !epstopdf plot_p1d_0.eps 
         !scp plot_p1d_0.eps plot_p1d_0.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
   #
   
panelplot1   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin ((-6))
        define myrout ((6))
        #define xin (LG($myrin))
        #define xout (LG($myrout))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 5
        #
		panelplot1replot
		#
        #
panelplot1replot 0 #		
		###################################
        ticksize 0 0 0 0
        define lminy (-0.1)
        define lmaxy (10)
        limits $myrin $myrout $lminy $lmaxy
        #ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube.pickbestnew/
        grid3d gdump
        jrdprad dump0150
        ltype 2 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube3
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (-300)
        define lmaxy (2499)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u_g"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube.pickbestnew/
        grid3d gdump
        jrdprad dump0150
        ltype 2 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube3
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0.7)
        define lmaxy (1.02)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u^x_{\rm gas}/u^t_{\rm gas}"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube.pickbestnew/
        grid3d gdump
        jrdprad dump0150
        ltype 2 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube3
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-100)
        define lmaxy (3999)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        #yla "\hat{E}"
        #yla "E"
        yla "-R^t_t"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube.pickbestnew/
        grid3d gdump
        jrdprad dump0150
        ltype 2 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube3
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
		###################################
        #
        ticksize 0 0 0 0
        #define lminy (-40)
        #define lmaxy (10)
        define lminy (0.7)
        define lmaxy (1.02)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        #yla "\hat{F}^{\hat{x}}"
        yla "u^x_{\rm rad}/u^t_{\rm rad}"
        xla "x"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube.pickbestnew/
        grid3d gdump
        jrdprad dump0150
        #ltype 2 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube3
        grid3d gdump
        jrdprad2 dump0150
        #ltype 0 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        #



panelplot2   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin ((-15))
        define myrout ((15))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 5
        #
		panelplot2replot
		#
        #
panelplot2replot 0 #		
		###################################
        ticksize 0 0 0 0
        define lminy (0.9)
        define lmaxy (3.5)
        limits $myrin $myrout $lminy $lmaxy
        #ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube2
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0.002)
        define lmaxy (0.07)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u_g"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube2
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0.01)
        define lmaxy (0.3)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u^x_{\rm gas}/u^t_{\rm gas}"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube2
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (4E-3)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        #yla "\hat{E}"
        #yla "E"
        yla "-R^t_t"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube2
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.7)
        define lmaxy (0.1)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        #yla "\hat{F}^{\hat{x}}"
        yla "u^x_{\rm rad}/u^t_{\rm rad}"
        xla "x"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube2
        grid3d gdump
        jrdprad2 dump0150
        #ltype 0 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        #

#############################
panelplot3   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin ((-10))
        define myrout ((10))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -3 3 -3 3
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -3 3 -3 3
		erase
		#
        define numpanels 5
        #
		panelplot3replot
		#
        #
panelplot3replot 0 #		
		###################################
        ticksize 0 0 0 0
        define lminy (0.9)
        define lmaxy (2.7)
        limits $myrin $myrout $lminy $lmaxy
        #ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube1
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (4E-5*1E4)
        define lmaxy (2.9E-4*1E4)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "10^{4} u_g"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube1
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (1E4*u) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (4E-3)
        define lmaxy (0.017)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u^x_{\rm gas}/u^t_{\rm gas}"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube1
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (1E-9)
        define lmaxy (3.5E-7)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        #yla "\hat{E}"
        yla "-R^t_t"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube1
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.7)
        define lmaxy (0.1)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        #yla "\hat{F}^{\hat{x}}"
        yla "u^x_{\rm rad}/u^t_{\rm rad}"
        xla "x"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube1
        grid3d gdump
        jrdprad2 dump0150
        #ltype 0 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        #

   #
panelplot4   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin ((-15))
        define myrout ((15))
        #define xin (LG($myrin))
        #define xout (LG($myrout))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 5
        #
		panelplot4replot
		#
        #
panelplot4replot 0 #		
		###################################
        ticksize 0 0 0 0
        define lminy (0.1)
        define lmaxy (4.2)
        limits $myrin $myrout $lminy $lmaxy
        #ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube41
        grid3d gdump
        jrdprad2 dump0150
        ltype 2 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube4
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.01)
        define lmaxy (0.06)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u_g"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube41
        grid3d gdump
        jrdprad2 dump0150
        ltype 2 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube4
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0.1)
        define lmaxy (0.7)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u^x_{\rm gas}/u^t_{\rm gas}"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube41
        grid3d gdump
        jrdprad2 dump0150
        ltype 2 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube4
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0.05)
        define lmaxy (1.4)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        #yla "\hat{E}"
        yla "-R^t_t"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube41
        grid3d gdump
        jrdprad2 dump0150
        ltype 2 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube4
        grid3d gdump
        jrdprad2 dump0150
        ltype 0 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0.1)
        define lmaxy (0.65)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        #yla "\hat{F}^{\hat{x}}"
        yla "u^x_{\rm rad}/u^t_{\rm rad}"
        xla "x"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube41
        grid3d gdump
        jrdprad2 dump0150
        #ltype 2 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube4
        grid3d gdump
        jrdprad2 dump0150
        #ltype 0 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
#############################
panelplot5   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin ((-20))
        define myrout ((20))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -3 3 -3 3
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -3 3 -3 3
		erase
		#
        define numpanels 5
        #
		panelplot5replot
		#
        #
panelplot5replot 0 #		
		###################################
        ticksize 0 0 0 0
        define lminy (0.9)
        define lmaxy (1.06)
        limits $myrin $myrout $lminy $lmaxy
        #ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube5
        grid3d gdump
        jrdprad2 dump0013
        ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (59)
        define lmaxy (67)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u_g"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube5
        grid3d gdump
        jrdprad2 dump0013
        ltype 0 pl 0 r (u) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0.73)
        define lmaxy (0.79)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "u^x_{\rm gas}/u^t_{\rm gas}"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube5
        grid3d gdump
        jrdprad2 dump0013
        ltype 0 pl 0 r (uu1*sqrt(gv311)/uu0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (5.0)
        define lmaxy (7.0)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        #yla "\hat{E}"
        yla "-R^t_t"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube5
        grid3d gdump
        jrdprad2 dump0013
        ltype 0 pl 0 r (-U8/gdet) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0.73)
        define lmaxy (0.79)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        #ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        #yla "\hat{F}^{\hat{x}}"
        yla "u^x_{\rm rad}/u^t_{\rm rad}"
        xla "x"
        #
        cd /data/jon/harmgit/koraltestcompare/run.radtube5
        grid3d gdump
        jrdprad2 dump0013
        #ltype 0 pl 0 r (prad1ff) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 r (uru1*sqrt(gv311)/uru0/sqrt(abs(gv300))) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
plotradpulse3da 1 #
        #
        #
        #set filetype=1
        #set skiptype=2
        #cd /data/jon/harmgit/koraltestcompare/run.radpulse3d/
        set filetype=2
        set skiptype=4
        cd /data/jon/harmgit/koraltestcompare/run.radpulse3d.50.50.50/
        #
        defaults
        defaults
        erase
        define WHICHLEV ($nz/2)
        define coord 1
        define LOGTYPE 0
        define UNITVECTOR 0
        fdraft
        ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -4 4 -4 4
        #
        grid3d gdump
        if(filetype==1){ jrdprad dump0000 }
        if(filetype==2){ jrdprad2 dump0000 }
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        if($1==1){\
          device postencap testradpulse3da.eps
        }
        # 
        #
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        if(filetype==1){ jrdprad dump0000 }
        if(filetype==2){ jrdprad2 dump0000 }
        define x2label "y"
        define x1label "x"
        limits x12 x22
        define SKIPFACTOR 1
        echo "before 1"
        define cres 15
        ctype default plc 0 (-U8/gdet) 010
        box
        labelaxes 0
        echo "after 1"
        print {lev}
        #
        #
        define POSCONTCOLOR cyan
        define NEGCONTCOLOR default
        if(filetype==1){ jrdprad dump0041 }
        if(filetype==2){ jrdprad2 dump0064 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 15
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(1E32*U9/gdet)*sqrt(gv311)
        set ury=(1E32*U10/gdet)*sqrt(gv322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur .01 12 010
        set time3=_t
        if(1){\
        set myr=sqrt(x12**2+x22**2) if(tk==$WHICHLEV)
        set image[ix,iy]=myr
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        #
        define POSCONTCOLOR blue
        define NEGCONTCOLOR default
        if(filetype==1){ jrdprad dump0017 }
        if(filetype==2){ jrdprad2 dump0027 }
        define SKIPFACTOR 1
        echo "before 3"
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        echo "after 3"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(1E32*U9/gdet)*sqrt(gv311)
        set ury=(1E32*U10/gdet)*sqrt(gv322)
        define SKIPFACTOR (skiptype)
        ctype green vpl 0 ur .01 12 010
        set time2=_t
        if(1){\
        set myr=sqrt(x12**2+x22**2) if(tk==$WHICHLEV)
        set image[ix,iy]=myr
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        define SKIPFACTOR 1
        #
        print {time1 time2 time3}
        #
        #
plotradpulse3db 0 #
        #
        #
        #set filetype=1
        #set skiptype=2
        #cd /data/jon/harmgit/koraltestcompare/run.radpulse3d/
        set filetype=2
        set skiptype=4
        cd /data/jon/harmgit/koraltestcompare/run.radpulse3d.50.50.50/
        #
        #
        erase
        defaults
        defaults
        define WHICHLEV ($nz/2)
        define coord 1
        define LOGTYPE 0
        define UNITVECTOR 0
        fdraft
        ticksize 0 0 -1 0
		ctype default window 1 1 1 1
		notation -4 4 -4 4
        # 
        grid3d gdump
        #
        #
        ctype default
        if(filetype==1){ jrdprad dump0000 }
        if(filetype==2){ jrdprad2 dump0000 }
        define x2label "-R^t_t"
        define x1label "x"
        set blobuse=(tk==$nz/2 && tj==$ny/2 ? 1 : 0)
        set myprad0=(-U8/gdet) if(blobuse)
        set myr=r if(blobuse)
        limits myr (LG(myprad0))
        box
        labelaxes 0
        ltype 0 pl 0 myr myprad0 0110
        #
        if(filetype==1){ jrdprad dump0017 }
        if(filetype==2){ jrdprad2 dump0027 }
        set myprad0=-U8/gdet if(blobuse)
        ltype 2 pl 0 myr myprad0 0110
        #
        if(filetype==1){ jrdprad dump0041 }
        if(filetype==2){ jrdprad2 dump0064 }
        set myprad0=-U8/gdet if(blobuse)
        ltype 3 pl 0 myr myprad0 0110
        #
        set blobuseana=(myr<-0.5 || myr>0.5 ? 1 : 0)
        if(filetype==1){\
         set drop=2.039E-32/(myr/1)**2
        }
        if(filetype==2){\
         set drop=13.5E-32/(myr/1)**2
        }
        set drop=(blobuseana==1 ? drop : 1E30)
        define missing_data (1E30)
        ctype orange ltype 0 pl 0 myr drop 0110
        #
plotradpulseplanar 0 #
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radpulseplanar.pickbestnew/
        #
        erase
        defaults
        defaults
        define WHICHLEV ($nz/2)
        define coord 1
        define LOGTYPE 0
        define UNITVECTOR 0
        fdraft
        #ticksize 0 0 -1 0
        ticksize 0 0 0 0
		ctype default window 1 1 1 1
		notation -4 4 -4 4
        # 
        grid3d gdump
        #
        #
        ctype default
        jrdprad dump0000
        define x2label "-R^t_t"
        define x1label "x"
        set blobuse=(U8*0+1)
        set myprad0=(-U8/gdet) if(blobuse)
        set myr=r if(blobuse)
        #limits myr ((myprad0))
        limits -20 20 -0.5E-32 6.5E-32
        box
        labelaxes 0
        #
        if(1){\
        set dc=4.0
        set t0=4800.0
        set amp=6.49E-32
        set ndim=1
        }
        #
        if(0){\
        set dc=1.0
        set t0=10000.0
        set amp=6.49E-32
        set ndim=1
        }
        #
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr+offset)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype green ltype 0 pl 0 myr myprad0 0010
        set time1=_t
        #
        jrdprad dump0007
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr+offset)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype orange ltype 0 pl 0 myr myprad0 0010
        set time2=_t
        #
        jrdprad dump0023
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr+offset)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype blue ltype 0 pl 0 myr myprad0 0010
        set time3=_t
        #
        jrdprad dump0065
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr+offset)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype purple ltype 0 pl 0 myr myprad0 0010
        set time4=_t
        #
        jrdprad dump0200
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr+offset)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype red ltype 0 pl 0 myr myprad0 0010
        set time5=_t
        #
        print '%g %g %g %g %g\n' {time1 time2 time3 time4 time5}
        #
        #
