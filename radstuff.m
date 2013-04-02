 
 
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
  
