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
getvalue 0
		# problem: gv311, gv310,gv310, gv313, etc.
		# diagonals are fine, gv330 fine.  gdet fine
		# all dxdxp's fine.
	# gogrmhd
	#jrdpcf3duentropystag dump5000
	jrdpcf3duentropystag dump0035
	grid3d gdump
	#	
	set nztrue=8
	#
        set ii=-2
        set jj=-3
        set kk=0
	#
	#
	#set var=dxdxp11*uu1 + dxdxp12*uu2
	#set var=v3
	set var=uu1
	#set var=uu2
	#set var=dxdxp22
	#set var=gdet
	#set var=gv323
        #
        set god=var if(ii==ti && jj==tj && kk==tk)
        print '%21.15g\n' {god}
        #
        set ri=ii
        set rj=-jj-1
	set rk=(kk+int(nztrue/2)) % nztrue
	print {ri rj rk}
	#
        set god2=var if(ri==ti && rj==tj && rk==tk)
        print '%21.15g\n' {god2}
	#
