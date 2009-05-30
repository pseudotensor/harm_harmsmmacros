tests1 0       #
		jrdp dump0001
		faraday
		#
		# hmm, like machine precision
		set freeze1=uu1/B1-(uu3-uu0*omegaf2)/B3
		set freeze1n=(uu1/B1-(uu3-uu0*omegaf2)/B3)/(abs(uu1/B1)+abs((uu3-uu0*omegaf2)/B3))
		set freeze2=(uu1/B1-uu2/B2)
		set freeze2n=(uu1/B1-uu2/B2)/(abs(uu1/B1)+abs(uu2/B2))
		set freeze3=uu2/B2-(uu3-uu0*omegaf2)/B3
		set freeze3n=(uu2/B2-(uu3-uu0*omegaf2)/B3)/(abs(uu2/B2)+abs((uu3-uu0*omegaf2)/B3))
		#
		plc0 0 freeze2
