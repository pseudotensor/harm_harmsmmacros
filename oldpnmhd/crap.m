animpl	18	#
                if($?4 == 0) { define numsend (3) }\
                else{\
                  if($?5 == 1) { define numsend (5) } else { define numsend 4 }
                }
                #defaults
		rdnumd
                set h1=$1
                set h3='.dat'
                do ii=0,$NUMDUMPS-1,$ANIMSKIP {
                  set h2=sprintf('%04d',$ii)
                  set _fname=h1+h2+h3
                  define filename (_fname)
                  if($numsend==3){ pl  $filename $2 $3}\
                  else{\
                   if($numsend==4){  pl  $filename $2 $3 $4}\
                   else{\
                    if($numsend==5){ pl  $filename $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
