plots 0         #
		#
		#
		# HLL MC TIMEORDER=4 128
		jrdp /../../run/dumps/dump0112
		set it=u/rho*1E8 ctype default pl 0 r it 0001 0 1 -.1 1.1
		set crap=0.2+r*0 ctype red plo 0 r crap
		#
		# HLL MC TIMEORDER=4 2048
		# flat at center
		jrdp /../../run2/dumps/dump0981
		set it=u/rho*1E8 ctype blue plo 0 r it
		#
		#
		# LAXF MC TIMEORDER=4 2048
		# kink at center
		jrdp /../../run3/dumps/dump0006
		set it=u/rho*1E8 ctype cyan plo 0 r it
		#
		# HLL PARA(6) TIMEORDER=4 2048
		# larger spike at center
		jrdp /../../run4/dumps/dump0006
		set it=u/rho*1E8 ctype green plo 0 r it
		#
		# HLL PARA(8)
		jrdp /../../run5/dumps/dump0006
		set it=u/rho*1E8 ctype magenta plo 0 r it
		#
		# HLL PARA(4)
		#jrdp /../../run6/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(5)
		#jrdp /../../run7/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(5) 128
		#jrdp /../../run8/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(6) 128
		#jrdp /../../run9/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(8) 128
		#jrdp /../../run10/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(4.5) 128
		#jrdp /../../run11/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA(6)/MINM 128 (NLIM is best)
		#jrdp /../../run12/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL NLIM
		#jrdp /../../run13/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL VANL
		#jrdp /../../run14/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL MINM
		#jrdp /../../run15/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA/NLIM 128
		#jrdp /../../run16/dumps/dump0006
		#set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL MC 4096
		jrdp /../../run17/dumps/dump0006
		set it=u/rho*1E8 ctype yellow plo 0 r it
		#
		# HLL PARA 10000
		jrdp /../../run18/dumps/dump0006
		set it=u/rho*1E8 ctype default plo 0 r it
		#
