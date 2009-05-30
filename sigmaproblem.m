		#
		# To be used with Sasha's code
		#
		# Consider:
		# 1) all invariants
		# a) differential rotation if particle loading high at poles
		# 2) \sigma_0~0 near pole and equator
		# 3) \sigma_0\propto 1/sinh and 1/sin(h/2) from maximum so efficient conversion for all angles -- no sigma<1 core only
		# 4) Will lowering or raising \gamma_0 help?
		# 5) dipolar field vs. monopolar?
		#
		# \sigma = T^p_t[EM]/T^p_t[MA]
                # \mu = T^p_t/(\rho_0 u^p) = (\sigma+1) h \gamma (energy flux per unit rest-mass flux)
                # h = (\rho_0 + u + p)/\rho_0 (specific enthalpy)
		# \Psi = -mu + \Omega_F angmu = conserved = h (u_t + \Omega_F u_\phi) = h (-\gamma + R\Omega_F R\Omega)
		#
		#
invariants 1    #
		#jrdpcf3duold dump$1
		jrdp3duold dump$1
		#
		grid3d gdump
		#
		stresscalc 1
		faraday
		#
		# flow assumed to be mostly radial
		#
		# now obtain poloidal field-directed fluxes
		#
		set Bd1=B1*gv311+B2*gv312+B3*gv313
		set Bd2=B1*gv322+B2*gv322+B3*gv323
		set absBp = sqrt(B1*Bd1 + B2*Bd2)
		#
		set TudB0EM=(Tud10EM*Bd1+Tud20EM*Bd2)/absBp
		set TudB0MA=(Tud10MA*Bd1+Tud20MA*Bd2)/absBp
		set TudB0=(Tud10*Bd1+Tud20*Bd2)/absBp
		#
		set TudB3EM=(Tud13EM*Bd1+Tud23EM*Bd2)/absBp
		set TudB3MA=(Tud13MA*Bd1+Tud23MA*Bd2)/absBp
		set TudB3=(Tud13*Bd1+Tud23*Bd2)/absBp
		#
		set uuB=(uu1*Bd1+uu2*Bd2)/absBp
		#
		set sigma=TudB0EM/TudB0MA
		set muB=-TudB0/(rho*uuB)
		# efficiency
		set eff=uu0/muB
		#
		set mu1=-Tud10/(rho*uu1)
		set mu2=-Tud20/(rho*uu2)
		#
		# flux conservation
		set ietaB=absBp/(rho*uuB)
		set ieta1=B1/(rho*uu1)
		set ieta2=B2/(rho*uu2)
		#
		set sigmaangB=TudB3EM/TudB3MA
		set muangB=TudB3/(rho*uuB)
		set muang1=Tud13/(rho*uu1)
		set muang2=Tud23/(rho*uu2)
		#
                set omegafB = uu3/uu0 - B3/(rho*uu0*ietaB)
		set ibeta1=B3/(rho*(uu3-omegaf2*uu0))
		set ibeta2=B3/(rho*(uu3-omegaf1*uu0))
		set ibetaB=B3/(rho*(uu3-omegafB*uu0))
		#
		#
		# measures of stationarity
		#
		# check magnetic fluxes per unit particle fluxes
		# below apparently to machine precision (terms cancel?)
		set stateta1 = abs(ieta1-ibeta1)/(abs(ieta1)+abs(ibeta1))
		# below apparently to machine precision (terms cancel?)
		set stateta2 = abs(ieta2-ibeta2)/(abs(ieta2)+abs(ibeta2))
		# below good test
		set stateta12 = abs(ieta1-ieta2)/(abs(ieta1)+abs(ieta2))
		#
		set statmu12 = abs(mu1-mu2)/(abs(mu1)+abs(mu2))
		set statmuang12 = abs(muang1-muang2)/(abs(muang1)+abs(muang2))
		#
		fieldcalc 0 aphi
		plc 0 aphi
		plc0 0 (sigma-1.0) 010
		#
		# plc 0 v1m
		#
		#
		#
		#
oldinvariants 1 #
		set sigma=Tud10EM/Tud10MA
		set mu=Tud10/(rho*uu1)
		#
		# flux conservation
		set ieta=B1/(rho*uu1)
		#
		set sigmal=Tud13EM/Tud13MA
		set mul=Tud13/(rho*uu1)
		#
		set ibeta=B3/(rho*(uu3-omegaf2*uu0))
		#
		#
		fieldcalc 0 aphi
		plc 0 aphi
		plc0 0 (sigma-1.0) 010
		#
		# plc 0 v1m
		#
otherplots1 0   #
		jrdp3duold dump0021
		#
		defaults
		ctype default
		setlimits Rin Rout (pi/2) (pi/2+0.05) 0 1
		plflim 0 x1 r h bsq 0 110
		defaults
		#
		ctype cyan
		setlimits Rin Rout (pi-pi/8) (pi-pi/8+0.05) 0 1
		plflim 0 x1 r h bsq 0 111
		defaults
		#
		ctype red
		set myfit1=1E-4*(newx/6)**(-2.0)
		pl 0 newx myfit1 1110
		#
		ctype blue
		set myfit1=1E-0*(newx/1)**(-4.0)
		pl 0 newx myfit1 1110
		#
		print {_t}
		#
		#
otherplots2 0   # check \mu(\theta)
		#
		invariants 0011
		#
		defaults
		ctype default
		setlimits Rin (1.1*Rin) (pi/2) (pi) 0 1
		plflim 0 x2 r h mu 0
		defaults
		#
		ctype red
		set myfit1=50*sin(newx)**2
		pl 0 newx myfit1 0010
		#
		#
		#
		#
