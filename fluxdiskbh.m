     #
     gogrmhd
     #
fluxdisk 0
     # cd /data2/jmckinne/thickdisk7_2d/run.liker2butbeta40
     # jrdpcf3duentropy dump0000
     # jrdpcf3duentropy dump0260
     # /data2/jmckinne/thickdisk13cd
     # jrdpcf3duentropy dump0000
     # jrdpcf3duentropy dump0241 or 244
     #
     set iinner=0
     set iouter=$nx-1
     set fluxvsr=0,$nx-1,1
     set fluxvsr[0]=0
     set myr=0*fluxvsr
     set myr[0]=r[0]
     set iinner=1
     #
     do ii=iinner,iouter,1{\
      echo $ii
      # assume i iterates fastest
      set myr[$ii]=r[$ii]
      set fluxvsr[$ii]=0
      do jj=0,$ii-1,1{\
       #echo $jj
       set dflux=U6*$dx1*$dx3 if(ti==$jj && tj==$ny/2)
       # add-up over \phi
       set sumflux=SUM(dflux)
       set fluxvsr[$ii]=fluxvsr[$ii-1]+sumflux
      }
     #
     }
     #
     ctype default
     pl 0 myr fluxvsr 1001 $rhor 1E2 -2E2 2E2
     pl 0 myr fluxvsr 1001 $rhor 1E2 -2E3 2E3
     pl 0 myr fluxvsr 1001 $rhor 1E3 -2E4 2E4
     # at t=0:
     # flux = 6 at r=10**1.4
     # flux = -149 at r=10**1.7
     # flux = +1009 at r=10**2.1
     # flux = +5313 at r=10**2.5
     #
     # at t=dump 260
     # flux = -153111 at r=10**3.25
     # flux = +486170 at r=10**3.7
     # flux = +28130 at r=10**2.9
     # flux = +474 at r=10**1.9
     # flux smoothly to +110 at r=10**1
     # then flux\sim 0 down to BH
     #
     # thickdisk13cd:
     # at t=0:
     # flux = 5.3 at r=10**1.4
     # flux = -100 at r=10**1.7
     # flux = +645 at r=10**2.1
     # flux = -3524 at r=10**2.5    # appears to be accreting this one at late time
     # flux = +19472 at r=10**2.9
     # flux = -109120 at r=10**3.3
     # flux = +588945 at r=10**3.7
     #
     # at t=dump 241
     # flux = +19591 at r=10**2.9
     # flux = -3405 at r=10**2.5
     # flux = -578 at r=10**2.0 and smoothly down to zero by r=10**1.5
     # then flux\sim 0 down to BH from r=10**1.5
     #
fluxbh 0 #	
     #
     set jinner=0
     set jouter=$ny-1
     set fluxvsh=0,$ny-1,1
     set fluxvsh[0]=0
     set myh=0*fluxvsh
     set myh[0]=h[0]
     set jinner=1
     #
     set hori=5
     #
     do ii=jinner,jouter,1{\
      echo $ii
      # assume j iterates 2nd fastest
      set myh[$ii]=h[$ii*$nx]
      set fluxvsh[$ii]=0
      do jj=0,$ii-1,1{\
       #echo $jj
       set dflux=U5*$dx2*$dx3 if(tj==$jj && ti==hori)
       # add-up over \phi
       set sumflux=SUM(dflux)
       set fluxvsh[$ii]=fluxvsh[$ii-1]+sumflux
      }
     #
     }
     # positive fluxvsr means flux points towards \theta=\pi pole, so points in -z direction.
     # positive fluxvsh starting at \theta=0 would come from negative fluxvsr, so flip sign for comparison of origin of field on BH
     set fluxvsh=-fluxvsh
     #
     ctype default
     pl 0 myh fluxvsh 0001 0 pi -2E2 2E2
     #
     # cd /data2/jmckinne/thickdisk7_2d/run.liker2butbeta40
     # flux at dump 0260:
     # max = -117 at eq.
     # /data2/jmckinne/thickdisk13cd
     # flux at dump 0241:
     # max = -156 at eq.
     #
vphivsr 0
     #
     #cd /data2/jmckinne/sasha0/moviefinal15noavg/
     cd /data2/jmckinne/thickdisk7/moviefinal15noavg/
     #gogrmhd
     #
     set which=1
     #
     if(which==1){\
      da datavsr1.txt
      #da datavsr2.txt
      #da datavsr3.txt
      lines 1 100000
      read '%g %g %g %g %g %g %g %g %g' {i r a b c d e f vphi}
     }
     #
     if(which==2){\
      da datavsr4.txt
      lines 1 100000
      read '%g %g %g %g %g %g %g %g %g %g %g' {i r a b c d e f g h vphi}
     }
     #
     ctype default pl 0 r vphi 1101 3 200 1E-2 1
     ctype red pl 0 r (r**(-1/2)) 1111 3 200 1E-2 1
     #set n=(-1.03324+0.270618)/(1.26421-0.476911) print {n}
     #
mdinvsr 0
     #
     cd /data2/jmckinne/sasha99/moviefinal15noavg/
     #cd /data2/jmckinne/thickdisk7/moviefinal15noavg/
     #cd /data2/jmckinne/thickdisk11/moviefinal15noavg/
     #cd /data2/jmckinne/thickdisk9/moviefinal15noavg/
     #cd /data2/jmckinne/thickdiskr2/moviefinal15noavg/
     #gogrmhd
     #
     da datavsr5.txt
     lines 1 100000
     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r mdotfinavgvsr mdotfinavgvsr5 edemvsr edmavsr edmvsr ldemvsr ldmavsr ldmvsr phiabsj_mu1vsr pjemfinavgvsr pjmakefinavgvsr pjkefinavgvsr ljemfinavgvsr ljmakefinavgvsr ljkefinavgvsr mdin_vsr mdjet_vsr mdmwind_vsr mdwind_vsr alphamag1_vsr alphamag2_vsr alphamag3_vsr fstot_vsr fsin_vsr feqtot_vsr fsmaxtot_vsr}
     #
     ctype default pl 0 r mdin_vsr 1101 3 300 1 1E4
     points (LG(r)) (LG(mdin_vsr))
     set pic=60
     ctype red pl 0 r (mdin_vsr[pic]*(r/r[pic])**(1)) 1111 3 300 1 1E4
     set pic=120
     ctype yellow pl 0 r (mdin_vsr[pic]*(r/r[pic])**(1.5)) 1111 3 300 1 1E4
     ctype blue pl 0 r mdmwind_vsr 1111 3 300 1 1E4
     points (LG(r)) (LG(mdmwind_vsr))
     ctype cyan pl 0 r mdwind_vsr 1111 3 300 1 1E4
     points (LG(r)) (LG(mdwind_vsr))
     #