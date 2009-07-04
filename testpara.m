testpara1 0     #
		#
		cd /data/jon/newparatest/run.newpara
		#
		jrdp3du dump0001
		jrdpflux fluxdump0001
		#
		#set jonuse=(ti>2) ? 1 : 0
		set jonuse=1+ti*0		
		set myti=ti if(jonuse)
		#
		set myp1l4=p1l4 if(jonuse)
		set myp1r4=p1r4 if(jonuse)
		set myv3=v3 if(jonuse)
		#
		#
		cd /data/jon/newparatest/run.oldpara
		#
		jrdp3du dump0001
		jrdpflux fluxdump0001
		#
		#
		#set jonuse=(ti>2) ? 1 : 0
		set jonuse=1+ti*0		
		set myti=ti if(jonuse)
		#
		set myoldp1l4=p1l4 if(jonuse)
		set myoldp1r4=p1r4 if(jonuse)
		set myoldv3=v3 if(jonuse)
		#
		#
		#
		ctype default pl 0 myti myv3
		ctype blue pl 0 (myti-0.5) myp1l4 0010
		ctype red pl 0 (myti-0.5) myp1r4 0010
		#
		ctype default pl 0 myti myoldv3
		ctype blue pl 0 (myti-0.5) myoldp1l4 0010
		ctype red pl 0 (myti-0.5) myoldp1r4 0010
		#
		#
		set diffitl=myp1l4-myoldp1l4
		set diffitr=myp1r4-myoldp1r4		
		#
		ctype default pl 0 myti diffitl 0101 -1 ($nx+1) 1E-20 1E-3
		ctype red pl 0 myti diffitr 0110
		#
		#
