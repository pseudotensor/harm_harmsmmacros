rdmany    1     # read many ener.out files names ener.out.*
		do ii=0,$1,1 {
		   rdener $ii
		}
rdener    1     # read and assign ener vars
		jre gener.m
		rd ener.out.$1
		set t$1=t
		set m$1=mass
		set l$1=angmom
		set e$1=energy
		set dm$1=dm
		set dl$1=dl
		set de$1=de
# 0=528x264 1=1056x528
pleners   2     # plot: pleners <var> <tonum>
		smstart
		ctype default
		define ii (0)
		pl 0 t$ii $1$ii
		do ii=1,$2,1 {
		   ctype red
		   plo 0 t$ii $1$ii
		}
