interpmovie 0 #
		jrdpcf2d dump0072
		interpsingle lrho 256 256 -1E3 1E3 -1E3 1E3
		interpsingle uu0 256 256 -1E3 1E3 -1E3 1E3
		#
		readinterp lrho
		readinterp uu0
		#
		plc 0 ilrho
		plc 0 iuu0 010
		#
