courantharm 0   #
		set godv1c=(ABS(v1m)>ABS(v1p)) ? ABS(v1m) : ABS(v1p)
		set idtx1=godv1c/$dx1
		set godv2c=(ABS(v2m)>ABS(v2p)) ? ABS(v2m) : ABS(v2p)
		set idtx2=godv2c/$dx2
		set godv3c=(ABS(v3m)>ABS(v3p)) ? ABS(v3m) : ABS(v3p)
		set idtx3=godv3c/$dx3
		#
                #
		# dt affected by:
		# 1) Rin
		# 2) N1
		# 3) Rout
		# 4) coords
		# 5) N1 vs. N3 issue with polar sing
		#
		set ihoradjust=4
		set totalsize=256
                #
		set ftemp=ihoradjust/totalsize
		set newRin=R0+((Rhor-R0)/(Rout-R0)**(ftemp))**(1.0/(1.0-ftemp))
		#
		print {newRin}
		#
		#
		#
sourcedt 0      #
		gogrmhd
		jrdp3du dump0000
		stresscalc 1
		grid3d gdump
		jre metrics.m
		kspsource
		#
		set dUd0=dU0/gdet
		set dUd1=dU1/gdet
		set dUd2=dU2/gdet
		set dUd3=dU3/gdet
		#
		#
		set dU0u=dUd0*gn300+dUd1*gn301+dUd2*gn302+dUd3*gn303
		set dU1u=dUd0*gn310+dUd1*gn311+dUd2*gn312+dUd3*gn313
		set dU2u=dUd0*gn320+dUd1*gn321+dUd2*gn322+dUd3*gn323
		set dU3u=dUd0*gn330+dUd1*gn331+dUd2*gn332+dUd3*gn333
		#
		#
		set rhoprime=abs(rho+u+p+bsq)
		#
		# a velocity would be vg * dt
		#set vg0=sqrt(abs(dU0u*dU0))/rhoprime
		#set vg1=sqrt(abs(dU1u*dU1))/rhoprime
		#set vg2=sqrt(abs(dU2u*dU2))/rhoprime
		#set vg3=sqrt(abs(dU3u*dU3))/rhoprime
		#
		# below is update to 3-velocity v^i
		#
		set vg0=sqrt(abs(dU0u))/rhoprime
		set vg1=sqrt(abs(dU1u))/rhoprime
		set vg2=sqrt(abs(dU2u))/rhoprime
		set vg3=sqrt(abs(dU3u))/rhoprime
		#
		#
		set idt0=sqrt(vg0/_dt)
		set idt1=sqrt(vg1/$dx1)
		set idt2=sqrt(vg2/$dx2)
		set idt3=sqrt(vg3/$dx3)
		#
		#
		
