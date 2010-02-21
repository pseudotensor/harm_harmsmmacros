checkcurrent0   0
		#
		#
		stresscalc 1
		faraday
		#
		plc 0 Tud10
		#
		#
		set Ed2=fdd20/gdet
		set Ed3=fdd30/gdet
		#set Bd2=gv321*B1+gv322*B2+gv323*B3
		#set Bd3=gv331*B1+gv332*B2+gv333*B3
		#
		dualb Bd2 0 2
		dualb Bd3 0 3
		#
		set myTud10=-Ed2*Bd3+Ed3*Bd2
		#
