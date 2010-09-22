axistest 0 #
		NOTATION -1 2 -1 2
		window 1 1 1 1
		ticksize 0.2 1 -1 0
		limits 0 10 -2.2 12.2
		box 1 0 0 0
		myyaxis
		#
myyaxis 0       #
		#
		define maxdec (INT($fy2))
		define mindec (INT($fy1))
		set vlab = $mindec,$maxdec,1
		set opbrace='{'
		set clbrace='}'
		define numlabelskip 3
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
