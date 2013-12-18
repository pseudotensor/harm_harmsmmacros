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
velvsrad3 1        
        #
        set doscp=$1
        #
        device X11
        device X11
        plotradbeamflata 1
        device X11
        if(doscp==1){\
         !epstopdf testradbeamflata.eps 
         !scp testradbeamflata.eps testradbeamflata.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        #
velvsrad4 1        
        #
        set doscp=$1
        #
        plotradbeamflatb 1
        device X11
        if(doscp==1){\
         !epstopdf testradbeamflatb.eps 
         !scp testradbeamflatb.eps testradbeamflatb.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        #
velvsrad5 1        
        #
        set doscp=$1
        #
        plotradshadowa 1
        device X11
        if(doscp==1){\
         !epstopdf testradshadowa.eps 
         !scp testradshadowa.eps testradshadowa.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        plotradshadowb 1
        device X11
        if(doscp==1){\
         !epstopdf testradshadowb.eps 
         !scp testradshadowb.eps testradshadowb.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        #
        #
velvsrad6 1        # done in python now as harmradplot5()
        #
        if(1==0){\
        set doscp=$1
        #
        plotraddblshadowa 1
        device X11
        if(doscp==1){\
         !epstopdf testraddblshadowa.eps 
         !scp testraddblshadowa.eps testraddblshadowa.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        plotraddblshadowb 1
        device X11
        if(doscp==1){\
         !epstopdf testraddblshadowb.eps 
         !scp testraddblshadowb.eps testraddblshadowb.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        }
        #
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
        #
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
        #
velvsrad7 1 #
        #
        set doscp=$1
        #
        #device postencap5 test84.eps
        device postencap5 test84.eps
        #device postencap4 test84.eps
        panelplotradatm
        device X11
        if(doscp==1){\
         !epstopdf test84.eps 
         !scp test84.eps test84.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
velvsrad8 1 #
        #
        set doscp=$1
        #
        device postencap5 test60.eps
        panelplotradbondi
        device X11
        if(doscp==1){\
         !epstopdf test60.eps 
         !scp test60.eps test60.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        if(0==1){\
        device postencap5 test60conv.eps
        panelplotradbondiconv
        device X11
        if(doscp==1){\
         !epstopdf test60conv.eps 
         !scp test60conv.eps test60conv.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        }
        if(1==1){\
        device postencap5 test60conv.eps
        panelplotradbondiconv2
        device X11
        if(doscp==1){\
         !epstopdf test60conv.eps 
         !scp test60conv.eps test60conv.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        }
        #
velvsrad9 1 #
        #
        set doscp=$1
        #
        device postencap5 test60mag.eps
        panelplotradmagbondi
        device X11
        if(doscp==1){\
         !epstopdf test60mag.eps 
         !scp test60mag.eps test60mag.pdf jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
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
        # run.radtube1.hll
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
        set skiptype=2
        cd /data/jon/harmgit/koraltestcompare/run.radpulse3d.50.50.50/
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
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
        set time1=_t
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
        set urx=(1E32*U9/gdet)*sqrt(gn311)
        set ury=(1E32*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur .01 12 010
        set time3=_t
        if(1){\
        set myr=sqrt(x12**2+x22**2) if(tk==$WHICHLEV)
        set image[ix,iy]=myr-0.0
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
        set urx=(1E32*U9/gdet)*sqrt(gn311)
        set ury=(1E32*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype green vpl 0 ur .01 12 010
        set time2=_t
        if(1){\
        set myr=sqrt(x12**2+x22**2) if(tk==$WHICHLEV)
        set image[ix,iy]=myr-0.0
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
        #set skiptype=1
        #cd /data/jon/harmgit/koraltestcompare/run.radpulse3d/
        set filetype=2
        set skiptype=1
        cd /data/jon/harmgit/koraltestcompare/run.radpulse3d.50.50.50/
        #
        #
        erase
        defaults
        defaults
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
        define WHICHLEV (INT($nz/2))
        define x2label "-R^t_t"
        define x1label "x"
        set blobuse=(tk==INT($nz/2) && tj==$ny/2 ? 1 : 0)
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
        define WHICHLEV (INT($nz/2))
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
        set ana=amp*exp(-(myr)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype green ltype 0 pl 0 myr myprad0 0010
        set time1=_t
        #
        jrdprad dump0007
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype orange ltype 0 pl 0 myr myprad0 0010
        set time2=_t
        #
        jrdprad dump0023
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype blue ltype 0 pl 0 myr myprad0 0010
        set time3=_t
        #
        jrdprad dump0065
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype purple ltype 0 pl 0 myr myprad0 0010
        set time4=_t
        #
        jrdprad dump0200
        set myprad0=-U8/gdet if(blobuse)
        set Diff=rho/3/(kappa+kappaes)
        set ana=amp*exp(-(myr)**2/(dc*Diff*(_t+t0)))*((_t+t0)/t0)**(-ndim/2)
        ctype default ltype 0 pl 0 myr ana 0010
        ctype red ltype 0 pl 0 myr myprad0 0010
        set time5=_t
        #
        print '%g %g %g %g %g\n' {time1 time2 time3 time4 time5}
        #
        #
plotradbeamflata 1 #
        #
        #
        #set filetype=1
        #set skiptype=1
        #cd /data/jon/harmgit/koraltestcompare/run.radbeamflat
        set filetype=2
        set skiptype=2
        cd /data/jon/harmgit/koraltestcompare/run.radbeamflat0.999998.goodlimit
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencap testradbeamflata.eps
        }
        # 
        #
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        labelaxes 0
        if(filetype==1){ jrdprad dump0005 }
        if(filetype==2){ jrdprad2 dump0005 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 15
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(1*U9/gdet)*sqrt(gn311)
        set ury=(1*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 5E-8 12 010
        set time3=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-0.0
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        define SKIPFACTOR 1
        #
        #
plotradbeamflatb 1 #
        #
        #
        #set filetype=1
        #set skiptype=1
        #cd /data/jon/harmgit/koraltestcompare/run.radbeamflat
        set filetype=2
        set skiptype=2
        cd /data/jon/harmgit/koraltestcompare/run.radbeamflat0.999998.goodlimit
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencap testradbeamflatb.eps
        }
        # 
        #
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        labelaxes 0
        if(filetype==1){ jrdprad dump0100 }
        if(filetype==2){ jrdprad2 dump0100 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 15
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(1*U9/gdet)*sqrt(gn311)
        set ury=(1*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 5E-8 12 010
        set time3=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-0.0
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        define SKIPFACTOR 1
        #
        #
plotradshadowa 1 #
        #
        #
        set filetype=1
        set skiptype=4
        cd /data/jon/harmgit/koraltestcompare/run.radshadow
        #set filetype=2
        #set skiptype=1
        #cd /data/jon/harmgit/koraltestcompare/run.radshadow
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencapwide testradshadowa.eps
        }
        # 
        #
        ctype default window 1 2 1:2 1
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        labelaxes 0
        if(filetype==1){ jrdprad dump0005 }
        if(filetype==2){ jrdprad2 dump0005 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 15
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        define POSCONTCOLOR cyan
        define NEGCONTCOLOR cyan
        ctype cyan plc 0 (rho) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(2E12*U9/gdet)*sqrt(gn311)
        set ury=(2E12*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 1 12 010
        set time1=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-(-1.0)
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        print {time1}
        define SKIPFACTOR 1
        #
        #
plotradshadowb 1 #
        #
        #
        set filetype=1
        set skiptype=4
        cd /data/jon/harmgit/koraltestcompare/run.radshadow
        #set filetype=2
        #set skiptype=1
        #cd /data/jon/harmgit/koraltestcompare/run.radshadow
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencapwide testradshadowb.eps
        }
        # 
        #
        ctype default window 1 2 1:2 1
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        labelaxes 0
        if(filetype==1){ jrdprad dump0020 }
        if(filetype==2){ jrdprad2 dump0020 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 15
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        define POSCONTCOLOR cyan
        define NEGCONTCOLOR default
        ctype cyan plc 0 (rho) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(2E12*U9/gdet)*sqrt(gn311)
        set ury=(2E12*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 1 12 010
        set time2=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-(-1.0)
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        print {time2}
        define SKIPFACTOR 1
        #
        #
plotraddblshadowa 1 #
        #
        #
        #set filetype=1
        #set skiptype=4
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999
        set filetype=2
        set skiptype=4
        # these have injection in fluid frame
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999.correctgammmaxrad
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.9999.correctgammmaxrad
        cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.999.correctgammmaxrad
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999.correctgammmaxrad.hll
        #
        # injection in lab-frame
        cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.labframe.0.999
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencapwider testraddblshadowa.eps
        }
        # 
        #
        #ctype default window 1 2 1:2 1
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        #labelaxes 0
        aspect 1
        relocate -1 -0.1
        aspect (1/6)
        putlabel 5 "x"
        relocate -6.5 0.5
        aspect (.2)
        putlabel 5 "y"
        aspect 1
        if(filetype==1){ jrdprad dump0005 }
        if(filetype==2){ jrdprad2 dump0005 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 10
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        define POSCONTCOLOR cyan
        define NEGCONTCOLOR cyan
        ctype cyan plc 0 (rho) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(2E5*U9/gdet)*sqrt(gn311)
        set ury=(2E5*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 1 12 010
        set time1=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-(-1.0)
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        print {time1}
        define SKIPFACTOR 1
        #
        #
plotraddblshadowb 1 #
        #
        # # these have injection in fluid-frame
        #set filetype=1
        #set skiptype=4
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999
        set filetype=2
        set skiptype=4
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999.correctgammmaxrad
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.9999.correctgammmaxrad
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.999.correctgammmaxrad
        #cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.redo.0.99999.correctgammmaxrad.hll
        #
        # injection in lab-frame
        cd /data/jon/harmgit/koraltestcompare/run.raddblshadow.labframe.0.999
        #
        defaults
        defaults
        erase
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
        define WHICHLEV (INT($nz/2))
        define SKIPFACTOR 1
        define PLOTERASE 1
        plc 0 (-U8/gdet)
        erase
        #defaults
        #defaults
        #defaults
        if($1==1){\
          device postencapwider testraddblshadowb.eps
        }
        # 
        #
        #ctype default window 1 2 1:2 1
        define PLOTERASE 0
        define POSCONTCOLOR red
        define NEGCONTCOLOR default
        define x2label "y"
        define x1label "x"
        box
        #labelaxes 0
        aspect 1
        relocate -1 -0.1
        aspect (1/6)
        putlabel 5 "x"
        relocate -6.5 0.5
        aspect (.2)
        putlabel 5 "y"
        aspect 1
        if(filetype==1){ jrdprad dump0100 }
        if(filetype==2){ jrdprad2 dump0100 }
        define SKIPFACTOR 1
        echo "before 2"
        define cres 10
        ctype black plc 0 (-U8/gdet) 010
        print {lev}
        define POSCONTCOLOR cyan
        define NEGCONTCOLOR default
        ctype cyan plc 0 (rho) 010
        print {lev}
        echo "after 2"
        #set urx=prad1*sqrt(gv311)
        #set ury=prad2*sqrt(gv322)
        set urx=(2E5*U9/gdet)*sqrt(gn311)
        set ury=(2E5*U10/gdet)*sqrt(gn322)
        define SKIPFACTOR (skiptype)
        ctype magenta vpl 0 ur 1 12 010
        set time2=_t
        if(1){\
        set myr=r if(tk==$WHICHLEV)
        set image[ix,iy]=myr-(-1.0)
        set lev=_t,_t+1E-9,2E-9
        levels lev
        ctype orange contour
        }
        #
        print {time2}
        define SKIPFACTOR 1
        #
        #
panelplotradatm   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        define myrin (1E6)
        define myrout (1.4E6)
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
		panelplotradatmreplot
		#
        #
panelplotradatmreplot 0 #		
		###################################
        define coord 3
        #
        #######################################################################
        ticksize 0 0 0 0
        define lminy (-2E-16)
        define lmaxy (1.1E-15)
        limits $myrin $myrout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        expand 1.3
        yla "\rho_0"
        expand 1.5
        #
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.0.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.0.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype red ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype red ptype 4 0
        points ((r)) ((rho))
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.1.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.1.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype orange ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype orange ptype 4 0
        points ((r)) ((rho))
        #
        ##cd /data/jon/harmgit/koraltestcompare/run.radatm.2.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.2.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype magenta ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype magenta ptype 4 0
        points ((r)) ((rho))
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.3.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.3.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype green ltype 0 pl 0 r rho 0011 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype green ptype 4 0
        points ((r)) ((rho))
        #
        ########################################################################
        ticksize 0 0 0 0
        define lminy (-2E-2)
        define lmaxy (2E-2)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand 1.3
        yla "(\rho_0-\rho_{\rm a})/\rho_{\rm a}"
        expand 1.5
        #
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.0.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.0.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myrho=rho
        jrdprad2 dump0000
        set myrho0=rho
        ctype red ltype 0 pl 0 r ((myrho-myrho0)/myrho0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.1.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.1.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myrho=rho
        jrdprad2 dump0000
        set myrho0=rho
        ctype orange ltype 0 pl 0 r ((myrho-myrho0)/myrho0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.2.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.2.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myrho=rho
        jrdprad2 dump0000
        set myrho0=rho
        ctype magenta ltype 0 pl 0 r ((myrho-myrho0)/myrho0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.3.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.3.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myrho=rho
        jrdprad2 dump0000
        set myrho0=rho
        ctype green ltype 0 pl 0 r ((myrho-myrho0)/myrho0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        #######################################################################
        ticksize 0 0 -1 0
        define lminy (LG(1.1E13))
        define lmaxy (LG(0.9E15))
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand 1.3
        yla "F"
        expand 1.5
        #
        # # this one won't show up because very small flux
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.0.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.0.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype red ltype 0 pl 0 r (U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR) 0111 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype red ptype 4 0
        points ((r)) (LG(U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR))
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.1.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.1.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype orange ltype 0 pl 0 r (U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR) 0111 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype orange ptype 4 0
        points ((r)) (LG(U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR))
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.2.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.2.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype magenta ltype 0 pl 0 r (U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR) 0111 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype magenta ptype 4 0
        points ((r)) (LG(U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR))
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.3.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.3.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        ctype green ltype 0 pl 0 r (U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR) 0111 $myrin $myrout $lminy $lmaxy
        #
        jrdprad2 dump0000
        ctype green ptype 4 0
        points ((r)) (LG(U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR))
        #
        ########################################################################
        ticksize 0 0 0 0
        define lminy (-2E-2)
        define lmaxy (2E-2)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand 1.3
        yla "(F-F_{\rm a})/F_{\rm a}"
        expand 1.5
        #
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.0.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.0.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        jrdprad2 dump0000
        set myflux0=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        ctype red ltype 0 pl 0 r ((myflux-myflux0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.1.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.1.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        jrdprad2 dump0000
        set myflux0=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        ctype orange ltype 0 pl 0 r ((myflux-myflux0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.2.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.2.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        jrdprad2 dump0000
        set myflux0=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        ctype magenta ltype 0 pl 0 r ((myflux-myflux0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.3.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.3.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        jrdprad2 dump0000
        set myflux0=U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR
        ctype green ltype 0 pl 0 r ((myflux-myflux0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        #
        #
        #
        ########################################################################
        ticksize 0 0 0 0
        define lminy (-0.9E-5*1E3)
        define lmaxy (0.9E-5*1E3)
        limits $myrin $myrout $lminy $lmaxy
        define nm ($numpanels-4)
        expand 1.5
        ctype default window 8 -$numpanels 2:8 $nm
        box 1 2 0 0
        expand 1.3
        yla "r^{1/2} v_r/c"
        xla "r/r_g"
        expand 1.5
        #
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.0.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.0.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=uu1*sqrt(gv311)
        jrdprad2 dump0000
        set myflux0=1
        ctype red ltype 0 pl 0 r (r**0.5*(myflux-0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.1.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.1.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=uu1*sqrt(gv311)
        jrdprad2 dump0000
        set myflux0=1
        ctype orange ltype 0 pl 0 r (r**0.5*(myflux-0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.2.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.2.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=uu1*sqrt(gv311)
        jrdprad2 dump0000
        set myflux0=1
        ctype magenta ltype 0 pl 0 r (r**0.5*(myflux-0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        #cd /data/jon/harmgit/koraltestcompare/run.radatm.3.0.99999
        cd /data/jon/harmgit/koraltestcompare/run.radatm.3.labfixbothboundaries.fixed/
        grid3d gdump
        jrdprad2 dump2000
        set myflux=uu1*sqrt(gv311)
        jrdprad2 dump0000
        set myflux0=1
        ctype green ltype 0 pl 0 r (r**0.5*(myflux-0)/myflux0) 0011 $myrin $myrout $lminy $lmaxy
        #
        ## stupid SM -- axes show up in SM window, but not eps file.
        expand 1.3
        ctype default
        relocate 1.39E6 -0.012
        putlabel 5 "1.4\times 10^6"
        expand 1.5
        #
        #
        #
panelplotradbondi   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        defaults
        defaults
        define myrin ((2))
        #define myrout ((2E4))
        define myrout ((1E4))
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
        define numpanels 4
        # 
		panelplotradbondireplot
		#
        #
panelplotradbondireplot 0 #		
		###################################
        define coord 3
        #
        #######################################################################
        ticksize -1 0 -1 0
        define lminy ((1E-12*RHOBAR))
        define lmaxy ((1E-3*RHOBAR))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        ctype default window 8 -$numpanels 2:8 $numpanels
        expand 1.1
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "\rho_0[{\rm g}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test0/
        grid3d gdump
        jrdprad2 dump3130
        ctype red ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set time0=_t
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test1.redo.evencloserR0_linearextrapforpradi/
        grid3d gdump
        jrdprad2 dump1674
        ctype orange ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set time1=_t
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test2/
        grid3d gdump
        jrdprad2 dump12101
        ctype magenta ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set time2=_t
        #
        #jrdprad2 dump0000
        #ctype magenta ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14853
        ctype green ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set time3=_t
        #
        #jrdprad2 dump0000
        #ctype green ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test4/
        grid3d gdump
        jrdprad2 dump13509
        ctype blue ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set time4=_t
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        print {time0 time1 time2 time3 time4}
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1E5))
        define lmaxy ((0.9E11))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 1.1
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "T_{\rm gas}[{\rm K}]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test0/
        grid3d gdump
        jrdprad2 dump3130
        ctype red ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test1.redo.evencloserR0_linearextrapforpradi/
        grid3d gdump
        jrdprad2 dump1674
        ctype orange ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test2/
        grid3d gdump
        jrdprad2 dump12101
        ctype magenta ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype magenta ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14853
        ctype green ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype green ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test4/
        grid3d gdump
        jrdprad2 dump13509
        ctype blue ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1))
        define lmaxy ((0.9E14))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 1.1
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "\hat{E} [{\rm erg}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test0/
        grid3d gdump
        jrdprad2 dump3130
        ctype red ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test1.redo.evencloserR0_linearextrapforpradi/
        grid3d gdump
        jrdprad2 dump1674
        ctype orange ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test2/
        grid3d gdump
        jrdprad2 dump12101
        ctype magenta ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype magenta ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14853
        ctype green ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype green ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test4/
        grid3d gdump
        jrdprad2 dump13509
        ctype blue ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #points (LG(r)) (LG((-U8/gdet*UBAR)))
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1E10))
        define lmaxy ((0.9E22))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 1.1
        box 1 2 0 0
        expand 1.5
        expand 1.1
        yla "\hat{R}^r_t [{\rm erg}/{\rm cm}^2/{\rm s}]"
        xla "r/r_g"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test0/
        grid3d gdump
        jrdprad2 dump3130
        ctype red ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        # U9/gdet = R^t_r not R^r_t
        set myRrt=(prad0/3)*(4*uru1*urd0)
        # U9*gn311*gv300
        set preint0=(1.0/Ledd)*myRrt*gdet*$dx2*$dx3*ENBAR/TBAR if(ti==INT($nx*10/11))
        set int0=SUM(preint0)
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test1.redo.evencloserR0_linearextrapforpradi/
        grid3d gdump
        jrdprad2 dump1674
        ctype orange ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        # U9/gdet = R^t_r not R^r_t
        set myRrt=(prad0/3)*(4*uru1*urd0)
        # U9*gn311*gv300
        set preint1=(1.0/Ledd)*myRrt*gdet*$dx2*$dx3*ENBAR/TBAR if(ti==INT($nx*10/11))
        set int1=SUM(preint1)
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test2/
        grid3d gdump
        jrdprad2 dump12101
        ctype magenta ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        # U9/gdet = R^t_r not R^r_t
        set myRrt=(prad0/3)*(4*uru1*urd0)
        # U9*gn311*gv300
        set preint2=(1.0/Ledd)*myRrt*gdet*$dx2*$dx3*ENBAR/TBAR if(ti==INT($nx*10/11))
        set int2=SUM(preint2)
        #
        #jrdprad2 dump0000
        #ctype magenta ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14853
        ctype green ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #
        # U9/gdet = R^t_r not R^r_t
        set myRrt=(prad0/3)*(4*uru1*urd0)
        # U9*gn311*gv300
        set preint3=(1.0/Ledd)*myRrt*gdet*$dx2*$dx3*ENBAR/TBAR if(ti==INT($nx*10/11))
        set int3=SUM(preint3)
        #
        #jrdprad2 dump0000
        #ctype green ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test4/
        grid3d gdump
        jrdprad2 dump13509
        ctype blue ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        # U9/gdet = R^t_r not R^r_t
        set myRrt=(prad0/3)*(4*uru1*urd0)
        # U9*gn311*gv300
        set preint4=(1.0/Ledd)*myRrt*gdet*$dx2*$dx3*ENBAR/TBAR if(ti==INT($nx*10/11))
        set int4=SUM(preint4)
        #
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        ########################################################################
        #points (LG(r)) (LG((U9/gdet*sqrt(gn311)*ENBAR/LBAR/LBAR/TBAR)))
        #
        #
        print {int0 int1 int2 int3 int4}
        #
        #
        #
        #
panelplotradbondiconv   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        defaults
        defaults
        define myrin ((2))
        #define myrout ((2E4))
        define myrout ((1E4))
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
        define numpanels 4
        # 
		panelplotradbondiconvreplot
		#
        #
panelplotradbondiconvreplot 0 #		
		###################################
        define coord 3
        #
        #######################################################################
        ticksize -1 0 -1 0
        define lminy ((1E-12*RHOBAR))
        define lmaxy ((1E-3*RHOBAR))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        ctype default window 8 -$numpanels 2:8 $numpanels
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "\rho_0[{\rm g}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        #
        #
        ctype blue ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype orange ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype cyan ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype red ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1E5))
        define lmaxy ((0.9E11))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "T_{\rm gas}[{\rm K}]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        #
        #
        ctype blue ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype orange ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype cyan ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype red ltype 0 pl 0 r (Tgas*TEMPBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1))
        define lmaxy ((0.9E14))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{E} [{\rm erg}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        #
        #
        ctype blue ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype orange ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype cyan ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype red ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #
        #points (LG(r)) (LG((-U8/gdet*UBAR)))
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1E10))
        define lmaxy ((0.9E22))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 1 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{R}^r_t [{\rm erg}/{\rm cm}^2/{\rm s}]"
        xla "r/r_g"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        #
        #
        ctype blue ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype orange ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype cyan ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        ctype red ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        #
        #
panelplotradbondiconv2   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        defaults
        defaults
        define myrin ((2))
        #define myrout ((2E4))
        define myrout ((1E4))
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
        define numpanels 4
        # 
		panelplotradbondiconv2replot
		#
        #
panelplotradbondiconv2replot 0 #		
		###################################
        define coord 3
        define smoothsize 1
        #
        #######################################################################
        ticksize -1 0 -1 0
        define lminy ((1E-12*RHOBAR))
        define lmaxy ((1E-3*RHOBAR))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        ctype default window 8 -$numpanels 2:8 $numpanels
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "\rho_0[{\rm g}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        set rhoref=rho
        set tiref=ti
        #
        #
        ctype blue ltype 0 pl 0 r (RHOBAR*(rho-0)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((RHOBAR*(rho-rhoref))))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth rhoref rhoref0 2
        set rhoref1=rhoref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r (RHOBAR*(rho-rhoref1)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((RHOBAR*(rho-rhoref))))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth rhoref rhoref0 4
        set rhoref2=rhoref0 if(tiref%4==1)
        ctype cyan ltype 0 pl 0 r (RHOBAR*(rho-rhoref2)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((RHOBAR*(rho-rhoref))))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth rhoref rhoref0 8
        set rhoref3=rhoref0 if(tiref%8==1)
        ctype red ltype 0 pl 0 r (RHOBAR*(rho-rhoref3)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((RHOBAR*(rho-rhoref))))
        #
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1E5))
        define lmaxy ((0.9E11))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "T_{\rm gas}[{\rm K}]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        set Tgasref=Tgas
        set tiref=ti
        #
        #
        set fun0=(Tgas*TEMPBAR)
        ctype blue ltype 0 pl 0 r fun0 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth Tgasref Tgasref0 2
        set Tgasref1=Tgasref0 if(tiref%2==1)
        set fun1=(Tgas-Tgasref1)*TEMPBAR
        ctype orange ltype 0 pl 0 r fun1 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth Tgasref Tgasref0 4
        set Tgasref2=Tgasref0 if(tiref%4==1)
        set fun2=(Tgas-Tgasref2)*TEMPBAR
        ctype cyan ltype 0 pl 0 r fun2 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth Tgasref Tgasref0 8
        set Tgasref3=Tgasref if(tiref%8==1)
        set fun3=(Tgas-Tgasref3)*TEMPBAR
        ctype red ltype 0 pl 0 r fun3 1111 $myrin $myrout $lminy $lmaxy
        #
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        set rat1=fun1/fun0
        set rat2=fun2/fun0
        set rat3=fun3/fun0
        set rat1a=rat1[0]
        set rat2a=rat2[0]
        set rat3a=rat3[0]
        print {rat1a rat2a rat3a}
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1))
        define lmaxy ((0.9E14))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{E} [{\rm erg}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        set prad0ffref=prad0ff
        set tiref=ti
        #
        #
        ctype blue ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad0ffref prad0ffref0 2
        set prad0ffref1=prad0ffref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r ((prad0ff-prad0ffref1)*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad0ffref prad0ffref0 4
        set prad0ffref2=prad0ffref0 if(tiref%4==1)
        ctype cyan ltype 0 pl 0 r ((prad0ff-prad0ffref2)*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad0ffref prad0ffref0 8
        set prad0ffref3=prad0ffref0 if(tiref%8==1)
        ctype red ltype 0 pl 0 r ((prad0ff-prad0ffref3)*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #
        #points (LG(r)) (LG((-U8/gdet*UBAR)))
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1E10))
        define lmaxy ((0.9E22))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 1 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{R}^r_t [{\rm erg}/{\rm cm}^2/{\rm s}]"
        xla "r/r_g"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3/
        grid3d gdump
        jrdprad2 dump14903
        set prad1ffref=prad1ff
        set tiref=ti
        #
        #
        ctype blue ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.256x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad1ffref prad1ffref0 2
        set prad1ffref1=prad1ffref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r ((prad1ff-prad1ffref1)*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.128x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad1ffref prad1ffref0 4
        set prad1ffref2=prad1ffref0 if(tiref%4==1)
        ctype cyan ltype 0 pl 0 r ((prad1ff-prad1ffref2)*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype cyan ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbondi.2000dumps.test3.64x1.forconv/
        grid3d gdump
        jrdprad2 dump135994
        #
        #
        smooth prad1ffref prad1ffref0 8
        set prad1ffref3=prad1ffref0 if(tiref%8==1)
        ctype red ltype 0 pl 0 r ((prad1ff-prad1ffref3)*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        #
        #
        #
        #
panelplotradmagbondi   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        defaults
        defaults
        define myrin ((2))
        #define myrout ((2E4))
        #define myrout ((1E4))
        define myrout ((300))
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
		panelplotradmagbondireplot
		#
        #
panelplotradmagbondireplot 0 #		
		###################################
        define coord 3
        #
        #######################################################################
        ticksize -1 0 -1 0
        define lminy ((1E-12*RHOBAR))
        define lmaxy ((1E-3*RHOBAR))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        ctype default window 8 -$numpanels 2:8 $numpanels
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.1
        yla "\rho_0[{\rm g}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good/
        grid3d gdump
        jrdprad2 dump1936
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        ctype blue ltype 0 pl 0 r (RHOBAR*rho) 1111 $myrin $myrout $lminy $lmaxy
        set rhoref=rho
        set tiref=ti
        #
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.256x16_forconv/
        grid3d gdump
        jrdprad2 dump2064
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth rhoref rhoref0 2
        set rhoref1=rhoref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r (RHOBAR*(rho-rhoref1)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.128x16_forconv/
        grid3d gdump
        jrdprad2 dump3031
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth rhoref rhoref0 4
        set rhoref2=rhoref0 if(tiref%4==1)
        ctype red ltype 0 pl 0 r (RHOBAR*(rho-rhoref2)) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((RHOBAR*rho)))
        #
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1E5))
        define lmaxy ((0.9E11))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "T_{\rm gas}[{\rm K}]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good/
        grid3d gdump
        jrdprad2 dump1936
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        set fun0=(Tgas*TEMPBAR)
        ctype blue ltype 0 pl 0 r fun0 1111 $myrin $myrout $lminy $lmaxy
        set Tgasref=Tgas
        set tiref=ti
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.256x16_forconv/
        grid3d gdump
        jrdprad2 dump2064
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth Tgasref Tgasref0 2
        set Tgasref1=Tgasref0 if(tiref%2==1)
        set fun1=((Tgas-Tgasref1)*TEMPBAR)
        ctype orange ltype 0 pl 0 r fun1 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.128x16_forconv/
        grid3d gdump
        jrdprad2 dump3031
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth Tgasref Tgasref0 4
        set Tgasref2=Tgasref0 if(tiref%4==1)
        set fun2=((Tgas-Tgasref2)*TEMPBAR)
        ctype red ltype 0 pl 0 r fun2 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((Tgas*TEMPBAR)))
        #
        set rat1=fun1/fun0
        set rat2=fun2/fun0
        set rat1a=rat1[1]
        set rat2a=rat2[1]
        print {rat1a rat2a}
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1.1))
        define lmaxy ((0.9E14))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{E} [{\rm erg}/{\rm cm}^3]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good/
        grid3d gdump
        jrdprad2 dump1936
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        ctype blue ltype 0 pl 0 r (prad0ff*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        set prad0ffref=prad0ff
        set tiref=ti
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.256x16_forconv/
        grid3d gdump
        jrdprad2 dump2064
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth prad0ffref prad0ffref0 2
        set prad0ffref1=prad0ffref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r ((prad0ff-prad0ffref1)*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.128x16_forconv/
        grid3d gdump
        jrdprad2 dump3031
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth prad0ffref prad0ffref0 4
        set prad0ffref2=prad0ffref0 if(tiref%4==1)
        ctype red ltype 0 pl 0 r ((prad0ff-prad0ffref2)*UBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad0ff*UBAR)))
        #
        #
        #points (LG(r)) (LG((-U8/gdet*UBAR)))
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1E10))
        define lmaxy ((0.9E22))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 0 2 0 0
        expand 1.5
        expand 1.01
        yla "\hat{R}^r_t [{\rm erg}/{\rm cm}^2/{\rm s}]"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good/
        grid3d gdump
        jrdprad2 dump1936
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        ctype blue ltype 0 pl 0 r (prad1ff*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        set prad1ffref=prad1ff
        set tiref=ti
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.256x16_forconv/
        grid3d gdump
        jrdprad2 dump2064
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth prad1ffref prad1ffref0 2
        set prad1ffref1=prad1ffref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r ((prad1ff-prad1ffref1)*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.128x16_forconv/
        grid3d gdump
        jrdprad2 dump3031
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth prad1ffref prad1ffref0 4
        set prad1ffref2=prad1ffref0 if(tiref%4==1)
        ctype red ltype 0 pl 0 r ((prad1ff-prad1ffref2)*ENBAR/LBAR/LBAR/TBAR) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((prad1ff*ENBAR/LBAR/LBAR/TBAR)))
        #
        ########################################################################
        ticksize -1 0 -1 0
        define lminy ((1E-10))
        define lmaxy ((0.9E2))
        define blob1 (LG($myrin))
        define blob2 (LG($myrout))
        define blob3 (LG($lminy))
        define blob4 (LG($lmaxy))
        limits $blob1 $blob2 $blob3 $blob4
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm
        expand 0.85
        box 1 2 0 0
        expand 1.5
        expand 1.01
        yla "b^2/(\rho_0 c^2)"
        expand 1.5
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good/
        grid3d gdump
        jrdprad2 dump1936
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        ctype blue ltype 0 pl 0 r (bsq/rho) 1111 $myrin $myrout $lminy $lmaxy
        set bsqorhoref=bsq/rho
        set tiref=ti
        #
        #jrdprad2 dump0000
        #ctype blue ptype 4 0
        #points (LG(r)) (LG((bsq/rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.256x16_forconv/
        grid3d gdump
        jrdprad2 dump2064
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth bsqorhoref bsqorhoref0 2
        set bsqorhoref1=bsqorhoref0 if(tiref%2==1)
        ctype orange ltype 0 pl 0 r (bsq/rho-bsqorhoref1) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype orange ptype 4 0
        #points (LG(r)) (LG((bsq/rho)))
        #
        cd /data/jon/harmgit/koraltestcompare/run.radmagbondi.good.128x16_forconv/
        grid3d gdump
        jrdprad2 dump3031
        define DOCONNECT 0
        set condconnect=(r<1E4 ? 1 : 0)
        smooth bsqorhoref bsqorhoref0 4
        set bsqorhoref2=bsqorhoref0 if(tiref%4==1)
        ctype red ltype 0 pl 0 r (bsq/rho-bsqorhoref2) 1111 $myrin $myrout $lminy $lmaxy
        #
        #jrdprad2 dump0000
        #ctype red ptype 4 0
        #points (LG(r)) (LG((bsq/rho)))
        #
        ########################################################################
        define DOCONNECT 1
        ctype default
        xla "r/r_g"
        #
        #
        #
        #
panelplotradbeam2d   0 #
		#
        #
   # gormhd
   #
   # physics-179.umd.edu:
   #
   #
   #
		#
        defaults
        defaults
        define myrin ((2))
        #define myrout ((2E4))
        define myrout ((1E4))
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
		panelplotradbeam2dreplot
		#
        #
panelplotradbeam2dreplot 0 #		
		###################################
        define coord 3
        define PLANE 2
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbeam2d.blcoords
        #
        grid3d gdump
        jrdprad dump0200
        #
        plc 0 (-U8/gdet)
        #
        # cd /data/jon/harmgit/koraltestcompare/
        # make superclean ;make prepiinterp ; make iinterp
        # !cp /data/jon/harmgit/koraltestcompare/iinterp .
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbeam2d.kscoords.1.30x60
        #
        #!cp /data/jon/harmgit/koraltestcompare/iinterp .
        #jrdprad2 dump0200
        #plc 0 (-U8/gdet)
        #
        # use python:
        #  run ~/py/mread/__init__.py
        #  harmradplot1()
        #
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbeam2d.kscoords.2.30x60
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbeam2d.kscoords.3.30x60
        #
        cd /data/jon/harmgit/koraltestcompare/run.radbeam2d.kscoords.4.30x60
        #
        #
        #
        #
        #
