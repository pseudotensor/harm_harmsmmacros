readgrif 1      #
		da $1
		lines 1 1
		read '%g %g %g %g %g %g %g %g' \
		    {_t _n1 _n2 ihor _startx1 _startx2 _dx1 _dx2}
		lines 2 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj x1 x2 r h B1 B2 B3 E1 E2 E3 divb gdet eflux bsqmesq}
		    #
		    set dr = r*_dx1
		    set dh = h*_dx2
		    set tx1=x1
		    set tx2=x2
		    gsetup
		    gammienew
