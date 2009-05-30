codebeta        3
		# codebeta hor rin rout
		# codebeta .05 6 20
		set mybsq=0.5*bsq if((r>$2)&&(r<$3)&&(abs(h-pi/2)<=$1))
		set myp=p  if((r>$2)&&(r<$3)&&(abs(h-pi/2)<=$1))
		set myti=ti  if((r>$2)&&(r<$3)&&(abs(h-pi/2)<=$1))
		set mytj=tj  if((r>$2)&&(r<$3)&&(abs(h-pi/2)<=$1))
		set smybsq=SUM(mybsq)
		set smyp=SUM(myp)
		set myibeta=smybsq/smyp
		#minmaxs myti mybsq
		#minmaxs myti myp
		print {myibeta}
		#
		
