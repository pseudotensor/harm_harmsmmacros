animpl	4	# animpl start stop
                set h1=dump
                do ii=start,end,1 {
                  set h2=sprintf('%03d',$ii)
                  set _fname=h1+h2
                  define filename (_fname)
		  pla ???
		}
