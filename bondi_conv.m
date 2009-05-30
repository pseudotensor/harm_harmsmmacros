pl	0	#
		da bondi_conv.dat
		read {N 1 r 2 u 3 v1 4 v2 5}
		set lN = lg(N)
		set lr = lg(r)
		set lu = lg(u)
		set lv1 = lg(v1)
		set lv2 = lg(v2)
		#
		era
		pla 1 2 lr
		pla 2 2 lu
		pla 1 1 lv1
		pla 2 1 lv2
		#
pla	3	#
		window 2 2 $1 $2
		ticksize -1 0 -1 0
		limits lN $3
		box
		yla $3
		xla N
		connect lN $3
		points lN $3
		stats lN me si ku
		define a $me
		stats $3 me si ku
		define b $me
		set y = (lN - $a)*(-2.) + $b + 0.2
		ltype 3
		connect lN y
		ltype 0
