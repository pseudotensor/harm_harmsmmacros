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

radcomp1 0 #  
   #
   stresscalc 1
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
   set area=(sin(h)*dh*dphi)
   set myarea=area if(myuse)
   set totalarea=SUM(myarea)
   set dRdot2iso=(ddRdot2)*(totalarea/area) if(myuse)
   set dRdot2iso2=(ddRdot2)*(4.0*pi/area) if(myuse)
   set ddEMdot2=(-Tud10EM*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dEMdot2=(ddEMdot2) if(myuse)
   set dEMdot2iso=(ddEMdot2)*(totalarea/area) if(myuse)
   set dEMdot2iso2=(ddEMdot2)*(4.0*pi/area) if(myuse)
   set ddMAdot2=(-Tud10MA*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dMAdot2=(ddMAdot2) if(myuse)
   set dMAdot2iso=(ddMAdot2)*(totalarea/area) if(myuse)
   set dMAdot2iso2=(ddMAdot2)*(4.0*pi/area) if(myuse)
   set ddMdot2=((rho*uu1)*gdet*$dx2*$dx3*ENBAR/TBAR)
   set dMdot2=(ddMdot2) if(myuse)
   set dMdot2iso=(ddMdot2)*(totalarea/area) if(myuse)
   set dMdot2iso2=(ddMdot2)*(4.0*pi/area) if(myuse)
   #
   set gamma2=uu0 if(myuse)
   set dtheta=h  if(myuse)
   set Rdot2=SUM(dRdot2) print {Rdot2}
   #
   #
   set MSUN=1.9891E33
   set sigmaT=0.665E-24
   set mproton=1.673E-24
   set Ledd=4*pi*GGG*(MPERSUN*MSUN)*mproton*CCCTRUE/sigmaT
   print {Ledd}
   #
   set Rdot2iso=dRdot2iso/Ledd
   # print {dtheta dRdot2 Rdot2iso dEMdot2 dMAdot2 dMdot2 gamma2}
   #
   set Rdot2iso2=dRdot2iso2/Ledd
   set EMdot2iso2=dEMdot2iso2/Ledd
   set MAdot2iso2=dMAdot2iso2/Ledd
   set Mdot2iso2=dMdot2iso2/Ledd
   # print {dtheta Rdot2iso2 EMdot2iso2 MAdot2iso2 Mdot2iso2 gamma2}
   #
   set EdothoroLedd=Edothor/Ledd
   set RdotoLedd=Rdot/Ledd
   set RdotoEdothor=Rdot/Edothor
   set Rdot2oLedd=Rdot2/Ledd
   set Rdot2oEdothor=Rdot2/Edothor
   print {EdothoroLedd RdotoLedd RdotoEdothor Rdot2oLedd Rdot2oEdothor}
   #
