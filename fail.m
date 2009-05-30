failgrab 0      #
		define myi (100)
		define myj (400)
		define loc ($nx*$myj+$myi)
		set pr=r[$loc]
		set ph=h[$loc]
		set pti=ti[$loc]
		set ptj=tj[$loc]
		print {pti pr}
		print {ptj ph}
		#
		set pksbu1=ksbu1[$loc]
		set pksuu1=ksuu1[$loc]
		set pksbu1=ksbu1[$loc]
		set pbsq=bsq[$loc]
		set prho=rho[$loc]
		set pu=u[$loc]
		set pbu0=bu0[$loc]
		set puu0=uu0[$loc]
		#
		set pCC=pksbu1**2/(pbsq + prho + $gam*pu) - pksuu1**2
		set pBB=(-2*pbu0*pksbu1)/(pbsq + prho + $gam*pu) + 2*puu0*pksuu1
		set pAA=pbu0**2/(pbsq + prho + $gam*pu) - puu0**2
		#
		set p1p=-(pBB + sqrt(pBB**2 - 4*pAA*pCC))/(2.*pAA)
		set p1m=(-pBB + sqrt(pBB**2 - 4*pAA*pCC))/(2.*pAA)
		#
		 set p1p2=(-(pbu0*pksbu1) + pksbu1*sqrt(pbsq + prho + $gam*pu)*puu0 - pbu0*sqrt(pbsq + prho + $gam*pu)*pksuu1 + pbsq*puu0*pksuu1 + prho*puu0*pksuu1 + $gam*pu*puu0*pksuu1)/(-pbu0**2 + pbsq*puu0**2 + prho*puu0**2 + $gam*pu*puu0**2)
                set p1m2=(-(pbu0*pksbu1) - pksbu1*sqrt(pbsq + prho + $gam*pu)*puu0 + pbu0*sqrt(pbsq + prho + $gam*pu)*pksuu1 + pbsq*puu0*pksuu1 + prho*puu0*pksuu1 + $gam*pu*puu0*pksuu1)/(-pbu0**2 + pbsq*puu0**2 + prho*puu0**2 + $gam*pu*puu0**2)
                #
		
		print {p1p p1p2}
		print {p1m p1m2}
