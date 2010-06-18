
checkit 0       #
		#jrdpcf3dudipole dump0000
		jrdpcf3dudipole dump0000.new
		#
		set god=(1/ibeta) if(tj==$ny/2)
		set myr=r if(tj==$ny/2)
		pl 0 myr god 1101 Rin Rout 1E-2 1E5
		print {myr god} 
		#
		set ptemp=p*gdet if(rho>0.25)
		set gdettemp=gdet if(rho>0.25)
		set pavg=SUM(ptemp)/SUM(gdettemp)
		set pbtemp=(bsq/2)*gdet if(rho>0.25)
		set pbavg=SUM(pbtemp)/SUM(gdettemp)
		set betanoble=pavg/pbavg
		print  {betanoble}
		#
		set vk=r/(r**(3/2)+a)
		set hor=sqrt(cs2)/vk
		plc 0 hor
		#
		#
		#
