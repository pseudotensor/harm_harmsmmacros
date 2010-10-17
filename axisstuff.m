		############
                #
exampleaxis 0   #
		#
                #
		box 0 0 0 0
		myxaxis 2
		myyaxis 2
		xla $x1label
		yla $x2label
                #
                #
notworkingaxis 0 #
		#
		erase
		SET s=1,25,.5 SET b=1,25,2
		#set vlab={'1' '10^{3}' '10^{5}' '10^{7}' '10^{9}' '10^{11}' '10^{13}' '10^{15}' '10^{17}' '10^{19}' '10^{21}' '10^{23}' '10^{25}'}
		#set vlab={1 10^{3} 10^{5} 10^{7} 10^{9} 10^{11} 10^{13} 10^{15} 10^{17} 10^{19} 10^{21} 10^{23} 10^{25}}
		set vlab={10^1 10^3 10^5 10^7 10^9 10^11 10^13 10^15 10^17 10^19 10^21 10^23 10^25}
		angle 0
		AXIS $fx1 $fx2 s b vlab $gx1 $gy1 $($gx2-$gx1) 1 0
		#
		SET s=-10,15,.5 SET b=-10,15,2
		set vlab={10^-10 10^-8 10^-6 10^-4 10^-2 10^0 10^2 10^4 10^6 10^8 10^10 10^12 10^14}
		angle 90
		AXIS $fy1 $fy2 s b vlab $gx1 $gy1 $($gy2-$gy1) 2 3
		angle 0
		#
myxaxis 1       #
		#
		define maxdec (INT($fx2))
		define mindec (INT($fx1))
		set vlab = $mindec,$maxdec,1
		set opbrace='{'
		set clbrace='}'
		define numlabelskip $1
		do i=0,dimen(vlab)-1 {
		   if( vlab[$i]>=-1 && vlab[$i]<=1 ) {
		      set newlab = sprintf('%g',10**vlab[$i])
		   } else {
		      set newlab='10^'+opbrace
		      if( vlab[$i]<0){
		         set newlab=newlab+'-'
		         set newlab=newlab+sprintf('%g',ABS(vlab[$i]))
		      } else {
		         set newlab=newlab+sprintf('%g',vlab[$i])
		      }
  		      set newlab=newlab+clbrace
		   }
		   #skip numbers by deleting the label
		   if( $i%$numlabelskip!=0 ) {
		      set newlab = ' '
		   }
		   if( $i==0 ) {
		      set xlab = newlab
		   } else {
		      set xlab = xlab concat newlab
		   }
		}
		set s = vlab
		set b = s
		#box 0 0 0 0
		#
		ANGLE 0
		AXIS $fx1 $fx2 s b xlab $gx1 $gy1 $($gx2-$gx1) 1 0
		#AXIS $fy1 $fy2 0 0 $gx2 $gy1 $($gy2-$gy1) 0 $(0|8)
		ANGLE 0
		#
myyaxis 1       # myyaxis 2
		#
		define maxdec (INT($fy2))
		define mindec (INT($fy1))
		set vlab = $mindec,$maxdec,1
		set opbrace='{'
		set clbrace='}'
		define numlabelskip $1
		do i=0,dimen(vlab)-1 {
		   if( vlab[$i]>=-1 && vlab[$i]<=1 ) {
		      set newlab = sprintf('%g',10**vlab[$i])
		   } else {
		      set newlab='10^'+opbrace
		      if( vlab[$i]<0){
		         set newlab=newlab+'-'
		         set newlab=newlab+sprintf('%g',ABS(vlab[$i]))
		      } else {
		         set newlab=newlab+sprintf('%g',vlab[$i])
		      }
  		      set newlab=newlab+clbrace
		   }
		   #skip numbers by deleting the label
		   if( $i%$numlabelskip!=0 ) {
		      set newlab = ' '
		   }
		   if( $i==0 ) {
		      set ylab = newlab
		   } else {
		      set ylab = ylab concat newlab
		   }
		}
		set s = vlab
		set b = s
		#box 0 0 0 0
		#
		ANGLE 90
		AXIS $fy1 $fy2 s b ylab $gx1 $gy1 $($gy2-$gy1) 2 3
		#AXIS $fy1 $fy2 0 0 $gx2 $gy1 $($gy2-$gy1) 0 $(0|8)
		ANGLE 0
		#
axistest 0 #
		NOTATION -1 2 -1 2
		window 1 1 1 1
		ticksize 0.2 1 -1 0
		limits 0 10 -2.2 12.2
		box 1 0 0 0
		myyaxis 3
		#
axistest2 0 #
		NOTATION -1 2 -1 2
		window 1 1 1 1
		ticksize -1 0 -1 0
		limits -2.2 12.2 -2.2 12.2
		box 0 0 0 0
		myxaxis 2
		myyaxis 2
		#
		#
