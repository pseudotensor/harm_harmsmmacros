        #
        jrdpcf3duentropystag dump0001
        jrdpdebug debug0001
        jrdpfluxfull fluxdump0001
        #
        define WHICHLEV 4
        #
        set B2scut=B2s if(ti==0 && tk==0)
        set U6cut=U6 if(ti==0 && tk==0)
        set B1scut=B1s if(ti==0 && tk==0)
        set tjcut=tj if(ti==0 && tk==0)
        #
        pl 0 tjcut B2scut 0100
        pl 0 tjcut U6cut 0100
        pl 0 tjcut B1scut 0100
        #
        #
        #
        #
        plc 0 lg1fstot
        #
        plc 0 fsfail0
        plc 0 fsfailrho0
        plc 0 fsfailu0
        plc 0 fsfailrhou0
        #
        plc 0 fsfloor0
        #
        #
        plc 0 fslimitgamma0
        #
        #
        agzplc 'dump' fslimitgamma0
other1 0 #
        #
        #
        #jrdpcf3duentropystag dump0100
        jrdpcf3duentropystag dump0090
        #jrdpdebug debug0100
        #jrdpfluxfull fluxdump0100
        #
        define WHICHLEV 4
        #
        set myuse=(ti==0 && tk==6)
        #
        set tjcut=tj if(myuse)
        set B2scut=B2s if(myuse)
        set B2cut=B2 if(myuse)
        set U6cut=U6 if(myuse)
        set B1scut=B1s if(myuse)
        set B1cut=B1 if(myuse)
        set bsqcut=bsq if(myuse)
        #
        #pl 0 tjcut B2scut 0100
        #pl 0 tjcut U6cut 0100
        pl 0 tjcut B1cut 0100
        pl 0 tjcut B1scut 0110
        #
        pl 0 tjcut bsqcut 0100
        #
        #
