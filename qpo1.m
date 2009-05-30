myffts 0 #
		set mydlm=dlm if(t>500)
		set mydem=dem if(t>500)
		set mydm=dm if(t>500)
		set myt=t if(t>500)
		#
		#
		fftavgwindow 3 myt mydm dmfreq dmpow
		smooth dmpow dmpows 7
		fftavgwindow 3 myt mydlm dlmfreq dlmpow
		smooth dlmpow dlmpows 7
		fftavgwindow 3 myt mydem demfreq dempow
		smooth dempow dempows 7
		#

readmydm 0 #
		da myt.txt
		lines 1 10000
		read {t 1}
		da mydm.txt
		lines 1 10000
		read {dm 1}
		#
plotffts 0 #
		define x2label "power"
		define x1label "f (GM)/c^3"
		device postencap pow.eps
		set myfreq=dmfreq if(dmfreq>0)
		set mypow=dmpow if(dmfreq>0)
		ctype default pl 0 myfreq mypow 0101 0 0.25 5E-6 0.003
		set lmypow=LG(mypow)
		ctype cyan points myfreq lmypow
		smooth mypow mypows 7
		ctype red pl 0 myfreq mypows 0111 0 0.25 5E-6 0.003
		smooth mypow mypowss 20
		ctype blue pl 0 myfreq mypowss 0111 0 0.25 5E-6 0.003
		relocate  0.238635  -4.37192
		ctype cyan label X11
		relocate  0.226817  -4.28089
		ctype cyan label X10
		relocate 0.208702  -4.13188
		ctype cyan label X9
		relocate   0.178769  -3.90013		
		ctype cyan label X8
		relocate  0.156721  -3.99944
		ctype cyan label X7
		relocate 0.137817  -3.9167
		ctype cyan label X6
		relocate   0.100788  -3.70981
		ctype cyan label X5
		relocate  0.07716  -3.69334
		ctype cyan label X4
		relocate  0.0472308   -3.3043
		ctype cyan label X3
		relocate 0.0291154  -3.27126
		ctype cyan label X2
		relocate  0.0196635  -2.85747
		ctype cyan label X1
		device X11
		!scp pow.eps metric:
		#
plotffts2 0 #
		#
		ctype default pl 0 dmfreq dmpow 0001 0 0.3 0 0.002
		ctype default pl 0 dlmfreq dlmpow 0001 0 0.3 0 0.005
		ctype default pl 0 demfreq dempow 0001 0 0.3 0 0.0002
		#
fftavgwindow 5      #
		#
		#
		set numwindows=$1
		set sizewindows=INT(dimen($2)/numwindows)-1
		set start=1
		set finish=sizewindows
		set $4=1,sizewindows,1
		set $4=$4*0
		set $5=$4*0
		#
		do ii=1,numwindows,1 {\
		       fftreallim 1 $2 $3 freq pow start finish
		       set start=start+sizewindows
		       set finish=finish+sizewindows
		       set $4=$4+freq
		       set $5=$5+pow
		 }
		 set $4=$4/numwindows
		 set $5=$5/numwindows
		 #
		#
		
