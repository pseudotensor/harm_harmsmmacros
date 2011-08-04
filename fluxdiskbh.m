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
