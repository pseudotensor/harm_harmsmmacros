tst	0	#
		rd 0
		set rho0 = rho
		set u10 = u1
		set u30 = u3
		set b10 = b1
		set b30 = b3
		#
		rd 10
		set drho = sum(abs(rho - rho0))/dimen(rho)
		set du1 = sum(abs(u1 - u10))/dimen(rho)
		set du3 = sum(abs(u3 - u30))/dimen(rho)
		set db1 = sum(abs(b1 - b10))/dimen(rho)
		set db3 = sum(abs(b3 - b30))/dimen(rho)
		#
		print {drho du1 du3 db1 db3}
rd      1       #
                if($1 < 10) {define num <00$1>} \
                else {if($1 < 100) {define num <0$1>} \
                else {define num <$1>}}
                echo $num
                rdp dump$num
rdp     1       #
                #
                da dumps/$1
                lines 1 1
                read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
                define n1 (_n1)
                define n2 (_n2)
                define startx1 (_startx1)
                define startx2 (_startx2)
                define dx1 (_dx1)
                define dx2 (_dx2)
                define stopx1 ($startx1 + $n1*$dx1)
                define stopx2 ($startx2 + $n2*$dx2)
                lines 2 1000000
                #
                #
                read {x1 1 x2 2 r 3 h 4 rho 5 u 6 u1 7 u2 8 u3 9}
                read {b1 10 b2 11 b3 12}
                read {divb 13}
                read {bsq 14}
                read {t00ma 15 t00em 16}
                read {t03ma 17 t03em 18}
                read {t10ma 19 t10em 20}
                read {t13ma 21 t13em 22}
                read {t20ma 23 t20em 24}
                read {t23ma 25 t23em 26}
                read {gdet 27}
