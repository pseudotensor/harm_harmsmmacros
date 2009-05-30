check0  0       #
		#
		#
		#
		#cd /data/jon/sinwavetestweno/run.weno5bnd
		cd /data/jon/sinwavetestweno/run.mc
		da 0_fail.out
		read '%d %g %g' {which v1 pr}
		#
		set prcent=pr if(which==0)
		set v1cent=v1 if(which==0)
		#
		set prl=pr if(which==1)
		set v1l=v1 if(which==1)
		#
		set prr=pr if(which==2)
		set v1r=v1 if(which==2)
		#
		set exactl = sin(2*pi*v1l)
		set exactr = sin(2*pi*v1r)
		#
		set diffl=exactl-prl
		set diffr=exactr-prr
		#
plotcheck0 0    #
		ctype default pl 0 v1cent prcent 0001 .14 0.36 0.7 1.0
		points v1cent prcent
		#
		ctype default pl 0 v1l exactl 0010
		points v1l exactl
		ctype default pl 0 v1r exactr 0010
		points v1r exactr
		#
		ctype red pl 0 v1l prl 0010
		points v1l prl
		#
		ctype cyan pl 0 v1r prr 0010
		points v1r prr
		#
plotdiff0  0    #
		#
		ctype red pl 0 v1l diffl
		points v1l diffl
		#
		ctype cyan pl 0 v1r diffr 0010
		points v1r diffr
		#
plotdiff1  0    #
		#
		ctype blue pl 0 v1l diffl
		points v1l diffl
		#
		ctype magenta pl 0 v1r diffr 0010
		points v1r diffr
		#
		#
		#
		#
		#
		#
		#
		#

		
