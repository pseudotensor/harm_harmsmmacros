scalingdata 0   #
		# macro read "scalingdata.m"
		#
		#
		set cores={1 2 4 8 16 32 64 128 256 512 1024 2048}
		set bluegeneeff={1.0 0.99 0.99 0.99 0.99 0.98 0.98 0.97 0.96 0.94 0.92 0.9}
		set bluegenespeedup=cores*bluegeneeff
		#
		set coresstrong={32 64 128 256 512 1024 2048}
		set bluegeneeffstrong={0.98 0.98 0.97 0.95 0.91 0.84 0.8}
		set bluegenespeedupstrong=coresstrong*bluegeneeffstrong
		#
		set coresstrongfrank ={32   64    128  256  512  1024 2048 4096 8192}
		set franklineffstrong={0.98 0.98  0.93 0.94 0.93 0.92 0.91 0.90 0.80}
		set franklinspeedupstrong=coresstrongfrank*franklineffstrong
		#
		set coreslone={1   2     4     8   16   32   64   128  256  512 1024 2048 4096}
		set loneeff  ={1.0 0.99 0.99 0.99 0.99 0.95 0.93 0.92 0.90 0.89 0.85 0.80 0.7}
		set lonespeedup=coreslone*loneeff
		#
		#
		erase
		#
		fdraft
		#
		ctype default
		ticksize -1 0 -1 0
		#
		set lgcores=LG(cores)
		set lgbluegenespeedup=LG(bluegenespeedup)
		#
		set lgcoreslone=LG(coreslone)
		set lglonespeedup=LG(lonespeedup)
		#
		set lgcoresstrong=LG(coresstrong)
		set lgbluegenespeedupstrong=LG(bluegenespeedupstrong)
		#
		set lgcoresstrongfrank=LG(coresstrongfrank)
		set lgfranklinspeedupstrong=LG(franklinspeedupstrong)
		#
		limits lgcoresstrongfrank lgcoresstrongfrank
		box
		#
		xla "Number of Cores"
		yla "Speedup"
		#
		connect lgcoresstrongfrank lgcoresstrongfrank
		#
		ptype 3 3
		points lgcores lgbluegenespeedup
		#addlegend 2 'BlueGene/L Weak'
		#
		ptype 6 3
		points lgcoreslone lglonespeedup
		#addlegend 2 'Lonestar Weak'
		#
		ptype 4 3
		points lgcoresstrong lgbluegenespeedupstrong
		#addlegend 2 'BlueGene/L Strong'
		#
		ptype 5 3
		points lgcoresstrongfrank lgfranklinspeedupstrong
		#addlegend 2 'Kraken Weak'
		#
		#define startx (LG(2))
		#define endy (LG(1E3))
		#drawlegend $startx $endy 1.5
		#
		#
		set vptype1={3 4 5 6}
		set vptype2={3 3 3 3}
		set vltype={-1 -1 -1 -1}
		set vlweight={3 3 3 3}
		set vtext={'BlueGene/L Weak' 'BlueGene/L Strong' 'Kraken Weak' 'TACC Lonestar Weak'}
		#
		define startx (LG(30))
		define endy (LG(4E3))
		legend $startx $endy 0.9 vptype1 vptype2 vltype vlweight vtext
		#
scalingdatacosmos 0   #
		# macro read "scalingdata.m"
		#
		#
		set cores={4 32 256 2048}
		set atlaseff0={2.88 2.74 2.39 2.27}
                set atlaseff=atlaseff0/3.0
		set atlasspeedup=cores*atlaseff
		#
		erase
		#
		fdraft
		#
		ctype default
		ticksize -1 0 -1 0
		#
		set lgcores=LG(cores)
		set lgatlasspeedup=LG(atlasspeedup)
		#
		limits lgcores lgcores
		box
		#
		xla "Number of Cores"
		yla "Speedup"
		#
		connect lgcores lgcores
		#
		ptype 3 3
		points lgcores lgatlasspeedup
		#addlegend 2 'Atlas/L Weak'
		#
		#define startx (LG(10))
		#define endy (LG(1E3))
		#drawlegend $startx $endy 1.5
		#
		#
		set vptype1={ 3 }
		set vptype2={ 3 }
		set vltype={ -1 }
		set vlweight={ 3 }
		set vtext={'Atlas/L Weak'}
		#
		define startx (LG(4))
		define endy (LG(1E3))
		legend $startx $endy 0.9 vptype1 vptype2 vltype vlweight vtext
		#
