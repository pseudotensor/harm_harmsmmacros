doit1 0 #
		cd /data/jon/radruns/radm2a0.8
		grid3d gdump
		#jrdprad2 dump0999
		#jrdprad2 dump0492
		#jrdprad2 dump0400
		jrdprad2 dump0311
		#
doit2 0 #
		cd /data/jon/radruns/radma0.8
		grid3d gdump
		jrdprad2 dump0960

		#
		plc0 0 (tautotmax-1)
		plc 0 lg1fstot 010

doit3 0 #
		set mydeath=(bsq/rho>5 ? 1 : 1)
		set fun=rho*uu1*mydeath
		define angle (pi/2)
		gcalc2 3 0 $angle fun Mdotvsr
		ctype default pl 0 newr Mdotvsr 1100
		#
		set mydeath=(bsq/rho>5 ? 0 : 1)
		set fund=rho*uu1*mydeath
		define angle (pi/2)
		gcalc2 3 0 $angle fund Mdotvsrd
		ctype red pl 0 newr Mdotvsrd 1110
        #
		set mydeath=(bsq/rho>20 ? 0 : 1)
		set fund2=rho*uu1*mydeath
		define angle (pi/2)
		gcalc2 3 0 $angle fund2 Mdotvsrd2
		ctype yellow pl 0 newr Mdotvsrd2 1110


		
doit4 0 #
		defaults
		set myuse=(ti==55 ? 1 : 0)
		set myTgas=Tgas if(myuse)
		set myh=h if(myuse)
		pl 0 myh myTgas 0100

doit5 0 # sigma = rho * H \sim \int rho dz
		#
		define angle (pi/2)
		set mydeath=(bsq/rho>5 ? 0 : 1)
		set mydh = rho*rho*(r*cos(h))*mydeath
		gcalc2 3 0 $angle mydh myhnum
		set mydhden = rho*mydeath
		gcalc2 3 0 $angle mydhden myhden
		set mySigma=myhnum/myhden
		pl 0 newr mySigma 1100


		ctype default pl 0 newr mySigmalater 1110
		#
doit6 0 #
        #
        plc 0 dUint0
        #
        plc 0 (U0*gdet*dV)
        #
		set myuse=(bsq/rho<5 && r<30 ? 1 : 0)
        set dmydUint0tot=myuse*dUint0
        set mydUint0tot=SUM(dmydUint0tot)
        #
        # U0 already includes gdet
        set dmyint0tot=myuse*U0*dV
        set myint0tot=SUM(dmyint0tot)
        #
        print {mydUint0tot myint0tot}
        #
doit7 0 #
        if(0){\
         set tlast=913*4.0
         set tnow=999*4.0
        }\
        else{\
         set tlast=916*4.0
         set tnow=960*4.0
		}
        print {tlast tnow}
        # dUint0 = Sum(rho uu0 * gdet * dV) over time
        set dmydUdt=dUint0/(tnow-tlast)/($dx2*$dx3*gdet)
		define angle (pi/2)
		gcalc2 3 0 $angle dmydUdt mydUdt
        #
        # doit3
        ctype default pl 0 newr Mdotvsr 1100
        ctype red pl 0 newr Mdotvsrd 1110
		ctype yellow pl 0 newr Mdotvsrd2 1110
        ctype green pl 0 newr mydUdt 1110
        #
        #
        #
