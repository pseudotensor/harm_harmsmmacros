diffthem 0      #
		#/data/jon/grmhd_sashamonopole_fornewpara/jonversion/run.parajon.minm.monosuper
		#
		jrdp3duold dump0777
		set rhoanal=rho
		set v1anal=v1
		set v2anal=v2
		set v3anal=v3
 		set B1anal=B1
 		set B2anal=B2
 		set B3anal=B3
		#
		jrdp3duold dump0100
		set rhofinal=rho
		set v1final=v1
		set v2final=v2
		set v3final=v3
 		set B1final=B1
 		set B2final=B2
 		set B3final=B3
		#
		jrdp3duold dump0000
		set rhoinitial=rho
		set v1initial=v1
		set v2initial=v2
		set v3initial=v3
 		set B1initial=B1
 		set B2initial=B2
 		set B3initial=B3
		#
 		#
		set diffrho=(rhofinal-rhoanal)/rhoanal
		set diffv1=(v1final-v1anal)/v1anal
		set diffv2=(v2final-v2anal)/v2anal
		set diffv3=(v3final-v3anal)/v3anal
		set diffB1=(B1final-B1anal)/B1anal
		set diffB2=(B2final-B2anal)/B2anal
		set diffB3=(B3final-B3anal)/B3anal
		#
		#
		#plc 0 diffrho 001 1 39 0 pi
		plc 0 diffB1 001 1 39 0 pi
		#
		#pls 0 diffrho 101 1 39 0 pi
		#
		#
anims 0         #
		#
		set startanim=0
		set endanim=100
		agplc 'dump' rho
		#
		#
diffit 0        #
		jrdp3duold dump0000
		grid3d gdump
		#
		set myuse=(tj==0 ? 1 : 0)
		#
		set mytx1=ti if(myuse)
		set myr=r if(myuse)
		#
		der mytx1 myr dmytx1 dmyr
		der dmytx1 dmyr ddmytx1 ddmyr
		#
		#pl 0 dmytx1 dmyr 0100
		pl 0 myr (dmyr/myr) 1000
		#
omegaplot 1     #
		#
		#jrdp3duold dump0100
		jrdp3duold dump$1
		faraday
		grid3d gdump
		set omegaf=omegaf2*dxdxp33
		plc 0 omegaf
		#
		#
		set lightcyl0=gv300+omegaf2**2*gv333+gv303*omegaf2
		plc0 0 lightcyl0
		set lightcyl0image=newfun
		#
		plc0 0 v1m
		set v1mimage=newfun
		#
		jre mode2.m
		alfvenvp
		plc 0 alfvenv1m
		set alfvenv1mimage=newfun
		#
		#
		#
		plc 0 uu0
		#
		set lev=-1E-15,1E-15,1
                set image[ix,iy]=lightcyl0image
                levels lev ctype cyan contour
                #
		set lev=-1E-15,1E-15,1
                set image[ix,iy]=v1mimage
                levels lev ctype blue contour
                #
		set lev=-1E-15,1E-15,1
                set image[ix,iy]=alfvenv1mimage
                levels lev ctype yellow contour
                #
		plc 0 uu0 010
		#
		#
currentplot 1   #
		#
		jrdp3duold dump$1
		grid3d gdump
		set Bphihat=B3*sqrt(gv333)
		set Bd3=B3*gv333
		#
		plc 0 Bd3
		#
pickline     0  #
		#
		jrdp3duold dump0001
		grid3d gdump
		#
		set myuse=(tj==$ny/2)
		#
		set myr=r if(myuse)
		set myti=ti if(myuse)
		set myrho=rho if(myuse)
		set myuu0=uu0 if(myuse)
		set myuu1=uu1 if(myuse)
		set myuu2=uu2 if(myuse)
		set myuu3=uu3 if(myuse)
		set myB1=B1 if(myuse)
		set myB2=B2 if(myuse)
		set myB3=B3 if(myuse)
		#
		print {myr myti myrho myuu0 myuu1 myuu2 myuu3 myB1 myB2 myB3}
		#
		#
		#
checktrans 0    #		
		set t=0,100,0.1
		set tt=40
		set sin1st=sin( (t/tt-1)*(pi/2))
		set sin2nd = sin1st**2
		set sin4th = sin2nd**2
		#
		#
		ctype default pl 0 t (1-sin4th)
		ctype red pl 0 t (0.1+t*0) 0010
		#
		ctype default pl 0 t (sin4th)
		ctype blue pl 0 t (0.1+t*0) 0010
		#
