setjetinst 0    #
		define nx 1024
		define ny 1024
		set iii=0,$nx*$ny-1,1
                set ti=INT(iii%$nx)
                set tj=INT(iii/$nx)
		set k=0*iii
		set startx=-5
		define Sx (startx)
		set starty=-5
		define Sy (starty)
		set endx=5
		set endy=5
		define Lx (endx-startx)
		define Ly (endy-starty)
		define dx ($Lx/$nx)
		define dy ($Ly/$ny)
		set x=startx+$dx*ti
		set y=starty+$dy*tj
		set x12=x
		set x1=x
		set x22=y
		set x2=y
		define ncpux1 1
		define ncpux2 1
		define ncpux3 1
		define interp (0)
		define coord (1)
		# switched from mathematica (take SM y->z and take SM z->y)
		set z=0.05+iii*0
		set jz0=1 - x**2 + (-1 + x**2)/(-1 + x**2 - z**2) - 2/(1 - x**2 + z**2)**2
		set jins=(2*(x - z)*(x + z)*(1 - z**2/y**2))/(1 - x**2 + z**2)**2 + (1 - x**2 + (1 + x**2)/(-1 + x**2 - z**2))*(-1 + z/y)**2
		set jgen=(ABS(z)>0) ? jins : jz0
		set god=(jgen>0) ? 1 : -1
		#
plotit 0        #
		define cres 2
		define x1label "R\Omega_F"
		define x2label "|B^{\hat{\phi}}|/B^{\hat{r}}"
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 god
		#define cres 1
		#plc 0 jgen 010
		#set lev={0,1,2,3,4,10,100,1000,10000,1E5,1E6,1E7}
		#levels lev
		#ctype default contour
		#
		set codefit=y-x
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		define cres 1
		plc 0 codefit 010
		set lev={0} levels lev ctype red contour
		#
		set codefit=1-x
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		define cres 1
		plc 0 codefit 010
		set lev={0} levels lev ctype cyan contour
		#
		set kruskal=y-z
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		define cres 1
		plc 0 kruskal 010
		set lev={0} levels lev ctype blue contour
		#
		#
		#
newinst 0       #
		set r=2.8,200,0.1
		#set tj=(r/2.8)**(-1/3)
		#set tj=(r/2.8)**(-5/6)
		set tj=0.3*(r/2.8)**(-2/5)
		#set tj=0.3*(r/2.8)**(-1/2)
		set a=0.9375
		set rp=1+sqrt(1-a**2)
		set omegah=a/(2*rp)
		#
		set omegaf=omegah/2
		set x=r*sin(tj)*omegaf
		set y=x
		set z=tan(tj)/(2.0*pi)
		#
		set jz0=1 - x**2 + (-1 + x**2)/(-1 + x**2 - z**2) - 2/(1 - x**2 + z**2)**2
		set jins=(2*(x - z)*(x + z)*(1 - z**2/y**2))/(1 - x**2 + z**2)**2 + (1 - x**2 + (1 + x**2)/(-1 + x**2 - z**2))*(-1 + z/y)**2
		set jgen=(ABS(z)>0) ? jins : jz0
		set god=(jgen>0) ? 1 : -1
		#
		#
		define x1label "r c^2/GM"
		define x2label "J(r)"
		ctype default pl 0 r god 1000
		ctype red pl 0 r x 1010
		#
