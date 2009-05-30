plblast 0 #
		define x1label "x"
		define x2label "\rho"
		#
		lines 1 100000
		da /home/jon/research/blastwave.txt
		read {tx 1 trho 2}
		set trho=trho+0.182
		#
		#set mytx=0,dimen(tx)-1,1
		#set mytx=mytx*0
		#set mytrho=mytx*0
		#
		# clean data
		#define iii 0
		#do ii=1,dimen(tx)-2,1 {
		#   #echo $ii
		#   if( (tx[$ii]>tx[$ii-1])&&(tx[$ii]<tx[$ii+1]) ){\
		#          set mytx[$iii]=tx[$ii]
		#          set mytrho[$iii]=trho[$ii]
		#          define iii (($iii)+1)
		#       }
		#}
		#
		# clean data
		#do ii=1,dimen(tx)-2,1 {
		#   echo $ii
		#   if( (tx[$ii]<tx[$ii-1])||(tx[$ii]>tx[$ii+1]) ){\
		#          set tx[$ii]=0.5*(tx[$ii-1]+tx[$ii+1])
		#          set trho[$ii]=0.5*(trho[$ii-1]+trho[$ii+1])
		#          echo crap $ii
		#       }
		#}
		#
		# clean data
		#do ii=1,dimen(tx)-2,1 {
		#   #echo $ii
		#   set tx[$ii]=0.5*(tx[$ii-1]+tx[$ii+1])
		#}
		#
		# clean data
		#sort {tx trho}
		#
		#ctype default pl 0 tx trho
		#ctype red plo 0 mytx mytrho
		#limits tx trho
		#ctype default box
		lweight 5 ptype 4 3 ctype default points tx trho
		#
		#
pltest2uorho 0 #
		#
		define x1label "x"
		define x2label "u/\rho"
		set fun=u/rho*tsf*tsf
		ctype default pl 0 r fun 0001 0 1 0.2 1.01
		lweight 3 ptype 3 3 ctype default points r fun
		#
		lines 1 100000
		#
		da /home/jon/research/test2_uorho.txt
		read {tx 1 tuorho 2}
		#
		lweight 5 ptype 4 3 ctype cyan points tx tuorho
		#
		da /home/jon/research/test2_uorho_vh1.txt
		read {tx 1 tuorhovh1 2}
		set tx=tx*0.98
		#
		lweight 3 ptype 4 3 ctype red points tx tuorhovh1
		#
pltest2v 0 #
		#
		define x1label "x"
		define x2label "v"
		ctype default pl 0 r (v1*tsf)
		lines 1 100000
		da /home/jon/research/test2_v.txt
		read {tx 1 tv 2}
		set tx=tx*0.995
		set tv=(tv-0.4)*5-1
		#
		lweight 3 ptype 4 3 ctype cyan points tx tv
		#
		#
pltest3 0  #
		define x1label "x"
		define x2label "\rho"
		#
		ctype default pl 0 r rho
		points r rho
		#
		set myfun=(r<0.16666) ? 1.0 : ((r>1.0-0.16666) ? 1.0 : 4.0)
		lweight 3 ptype 4 3 ctype cyan points r myfun
		#
settsf 0         #
		set tsf=1E5
		#set tsf=1E10
		#
