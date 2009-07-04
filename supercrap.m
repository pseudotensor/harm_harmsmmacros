eatme 0     #
		#
		#
		jrdp3duold dump0000
		#
		set oldU0ogdet=U0/gdet
		set oldU1ogdet=U1/gdet
		set oldU2ogdet=U2/gdet
		#
		jrdp3du ../../../latestcode/test_premerged2/run/dumps/dump0000
		#
		set newU0ogdet=U0/gdet
		set newU1ogdet=U1/gdet
		set newU2ogdet=U2/gdet
		pl 0 r (newU1ogdet-oldU1ogdet)
		#pl 0 r (newU2ogdet-oldU2ogdet)  
		#
		#
