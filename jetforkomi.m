godit0 0
        jrdpcf3dudipole dump0067
        grid3d gdump
godit 0
        ctype default
        set beta=p/(bsq/2)
        #
        set goduser=(h<1.5 && beta<3 && bsq/rho<.5 && uu1>0 && -ud0*(rho+$gam*u+bsq)/rho>1)
        plc 0 lrho
        plc 0 goduser 010
        #
        #
        set myrho=rho if(goduser)
        set myr=r if(goduser)
        ctype default
        pl 0 myr myrho 1100
        #
        set myfit=1E-2*(myr/1)**(-2.7)
        ctype red pl 0 myr myfit 1110

godit2 0
        ctype default
        set beta=p/(bsq/2)
        #
        set goduser=(h<1.5 && beta<1 && bsq/rho>2 && uu1>0 && -ud0*(rho+$gam*u+bsq)/rho>1)
        plc 0 lrho
        plc 0 goduser 010
        #
        #
        set myrho=rho if(goduser)
        set myr=r if(goduser)
        ctype default
        pl 0 myr myrho 1100
        erase
        box
        points (LG(myr)) (LG(myrho))
        #
        set myfit=1E-4*(myr/1)**(-2.0)
        ctype red
        #pl 0 myr myfit 1110
        points (LG(myr)) (LG(myfit))
        #
        set myfit=1E-3*(myr/1)**(-1.0)
        ctype blue
        #pl 0 myr myfit 1110
        points (LG(myr)) (LG(myfit))
        #
        ctype yellow
        pl 0 r rho 1110
        points (LG(r)) (LG(rho))
        #
