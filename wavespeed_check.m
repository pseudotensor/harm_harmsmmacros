check1 0        #
		#
		define angle (.03)
		#
		# old dxdxp to new form
		if(0){\
		jre punsly.m
		setdxdxpold
		}
		#
		set uu0ks=uu0
                set uu1ks=uu1*dxdxp11+uu2*dxdxp12
                set uu2ks=uu1*dxdxp21+uu2*dxdxp22
                set uu3ks=uu3
                #
		#
		set Delta=(r**2-2*r+a**2)
                set Sigma=(r**2+(a*cos(h)))
                set sinsq=sin(h)**2
                set geofact=-Delta*sinsq
                set gv300bl=-1+2*r/(r**2+a**2*cos(h)**2)
                set gv333bl=sin(h)**2*((a**2+r**2)**2-a**2*Delta*sin(h)**2)/Sigma
                set gv322bl=Sigma
                set gv311bl=Sigma/Delta
		#
		#
		set uu0bl=uu0ks-2*r/Delta*uu1ks
                set uu1bl=uu1ks
                set uu2bl=uu2ks
                set uu3bl=-a/Delta*uu1ks+uu3ks
                #
		#
		set v1hatks=uu1/uu0*sqrt(gv311)/sqrt(-gv300)
		set v1hatbl=uu1bl/uu0bl*sqrt(gv311bl)/sqrt(-gv300bl)
		#
		if(0){\
		define dx3 (1.0)
		set dV=$dx1*$dx2*$dx3
		}
		gcalc2 3 2 $angle v1hatks v1hatksvsr
		gcalc2 3 2 $angle v1hatbl v1hatblvsr
		#
		#
		#trueslowfast
		set v1phat=v1p*sqrt(gv311)/sqrt(-gv300)
		gcalc2 3 2 $angle v1phat v1phatvsr
		#
		#
		gcalc2 3 2 $angle cs csvsr
		gcalc2 3 2 $angle va vavsr
		set cms=sqrt(cms2)
		gcalc2 3 2 $angle cms cmsvsr
		#
		#
		define x1label "radius"
		define x2label "3-velocities"
		#
		ctype default
		pl 0 newr (-v1hatblvsr) 1001 Rin 10 -.1 1
		pl 0 newr (-v1hatksvsr) 1011 Rin 10 -.1 1
		#
		ctype red
		pl 0 newr (-v1phatvsr) 1011 Rin 10 -.1 1
		#
		ctype blue
		pl 0 newr (0*newr) 1011 Rin 10 -.1 1
		#
		#
		ctype cyan
		pl 0 newr csvsr 1011 Rin 10 -.1 1
		#
		ctype yellow
		pl 0 newr vavsr 1011 Rin 10 -.1 1
		#
		ctype magenta
		pl 0 newr cmsvsr 1011 Rin 10 -.1 1
		#
		#
checkcons1 0    #		
		#
                plc0 0 (1+v1hatks/sqrt(cms2)) 001 Rin 10 (pi/2-0.03) (pi/2+0.03)
		set rat1=newfun
		#
		plc0 0 v1phat 011 Rin 10 (pi/2-0.03) (pi/2+0.03)
		set rat2=newfun
		#
		#
		set fastv1phat=fastv1p*sqrt(gv311)/sqrt(-gv300)
		set tfastv1phat=tfastv1p*sqrt(gv311)/sqrt(-gv300)
		plc0 0 fastv1phat 011 Rin 10 (pi/2-0.03) (pi/2+0.03)
		set rat3=newfun
		#
		plc0 0 tfastv1phat 011 Rin 10 (pi/2-0.03) (pi/2+0.03)
		set rat4=newfun
		#
		#
		erase
		ctype default
		box
		prepaxes x1 x2 inputfun
		labelaxes 0
		#
		set lev=-1E-15,1E-15,1
		set image[ix,iy]=rat1
		levels lev ctype red contour
		#
		#
		set lev=-1E-15,1E-15,1
		set image[ix,iy]=rat2
		levels lev ctype blue contour
		#
		#
		set lev=-1E-15,1E-15,1
		set image[ix,iy]=rat3
		levels lev ctype cyan contour
		#
		set lev=-1E-15,1E-15,1
		set image[ix,iy]=rat4
		levels lev ctype yellow contour
		#
		#
		
