		# NOTES:
		# This file, diss.m, contains all dissipation-related SM macros except reading the ener.out files that contain the global volume integrated dissipation
		#
		#
		#
dodissvsr 0     # this shows how to use lumvsr.m for dissipation
		#
		jrdp3duentropy dump0000
		#
		jre lumvsr.m
		#
		# 0,1,2 stands for 2 energy and 1 entropy versions
		rdlumvsr dissvsr0.out $nx
		# for Cartesian (else remove):
		define LOGTYPE 0
		define coord 1
		plc 0 lumvsr
		# as for luminosity, form E(r,t)
		reallumvstvsr
		test1dsod2 0 0010
		#
		# as for luminosity, form dE(r,t)/dr
		doalllumavg 0 ($ny-1)
		# 
		#
		#
jrdpdiss 1	# Latest code, read dissipation dump file
		jrdpheader3d $1
		da dumps/$1
		lines 2 10000000
		#
                readdiss
	        #
		#
jrdpdissold 1	# Older code, read dissipation dump file
		jrdpheader3dold $1
		da dumps/$1
		lines 2 10000000
		#
		#
                readdiss
	        #
		#
readdiss 0      # Read dissipation dump file (all grid points, single time)
		# Contains cumulative dissipation for all time!
		#
                read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {disssimpleinvco dissfullinvco dissentropyco disssimpleinvconomax dissfullinvconomax dissentropyconomax disssimpleinvlab1 dissfullinvlab1 dissentropylab1 disssimpleinvlab1nomax dissfullinvlab1nomax dissentropylab1nomax disssimpleinvlab2 dissfullinvlab2 dissentropylab2 disssimpleinvlab2nomax dissfullinvlab2nomax dissentropylab2nomax dissfailureinv}
                #
                #
		# use jrdp3duentropy to load normal dumps(new variables are entropy and U8)
		#
		# use jrdpdiss to load spatial dependence of dissipation from 2 methods (whether second method failed)
		#
		# through-out below if macro has argument it means:
		# 0 = jon's code
		# 1 = Rebecca's code
		#
		#
examplediss 1  # reads Sod shock test case at t=10
		#
		#
		if($1==0){\
		       jrdp3duentropy dump0010
		}
		if($1==1){\
		       jrdp3duold dump0010
		    }
		    #
		if($1==0){\
		       jrdpdiss dissdump0010
		}
		if($1==1){\
		       jrdpdissold dissdump0010
		    }
		#
		# dissipation is cumulative integral over time per point
		#pl 0 r dissufun1
		#
		#
test1dsod1 0     #
		set startanim=0
		set endanim=10
		agpl 'dump' r rho
		#
		# and note that dissipation dominates at t=0 when shock unresolved and then only in shock that moves to right (rarefaction has little dissipation as required)
		#
		#
test1dsod2 2    # Using init.sasha.c, TESTNUMBER==51, for example
		# e.g. test1dsod2 0 0010
		#
		#
		# If v=0 at boundaries, then can compare total entropy before and after and compare with dissipated energy
		#
		if($1==0){\
		       jrdp3duentropy dump0000
		    }
		if($1==1){\
		       jrdp3duold dump0000
		    }
		set n=1.0/($gam-1.0)
		# below is same as (U8/gdet)
		set entropy=rho*ln(p**n/rho**(n+1))*uu0
		set Si=SUM(gdet*dV*entropy)
		#
		if($1==0){\
		       jrdp3duentropy dump$2
		}
		if($1==1){\
		       jrdp3duold dump$2
		    }
		set n=1.0/($gam-1.0)
		# below is same as (U8/gdet)
		set entropy=rho*ln(p**n/rho**(n+1))*uu0
		set Sf=SUM(gdet*dV*entropy)
		#
		set Sgen=Sf-Si
		#
		if($1==0){\
		       jrdpdiss dissdump$2
		}
		if($1==1){\
		       jrdpdissold dissdump$2
		    }
		#
		# diss already has gdet*dV in it, so just sum it up
		set Sgendissco=SUM(dissentropyco)
		set Sgendissconomax=SUM(dissentropyconomax)
		set Sgendisslab1=SUM(dissentropylab1)
		set Sgendisslab1nomax=SUM(dissentropylab1nomax)
		set Sgendisslab2=SUM(dissentropylab2)
		set Sgendisslab2nomax=SUM(dissentropylab2nomax)
		#
		print {Si Sf Sgen Sgendissco Sgendissconomax Sgendisslab1  Sgendisslab1nomax Sgendisslab2 Sgendisslab2nomax}
		#
		# for Sod shock (test=51, N1=150) I get:
		# -143.6      -143.2      0.3631      0.3908
		# which is close
		#
		# at N1=300 I get:
		# -134.4        -134      0.3546      0.3789
		#
		# at N1=600 I get:
		# -129.8      -129.4      0.3502      0.3733
		#
		# where totals are changing just because included
		# boundary zones that go out to different distances
		#
		# Seems results converge, but dissipation version
		# doesn't converge to expected value from
		# energy evolution and discrete change in entropy
		#
		# Residual offset is likely due to error
		# in evolving forward with energy but
		# trying to use entropy evolution to estimate entropy
		# generation -- wasn't expected to be exact
		#
		# Residual error may be related to why
		# non-conservative schemes don't obtain entropy
		# jump correctly even with dissipation
		#
		# I noticed that ratio of errors was related to
		# how much shock spreads at head and tail of shock
		# spreads by a couple extra zones, and this leakage
		# seems to account for error in entropy generation
		# Could just be coincidence
		#
		#
test1dsod3 1    #
		#
		# this shows how to use lumvsr.m for dissipation
		#
		if($1==0){\
		       jrdp3duentropy dump0000
		    }
		if($1==1){\
		# Rebecca code uses same jrdp3duold
		       jrdp3duold dump0000
		    }
		#
		jre lumvsr.m
		#
		# never includes boundary zones
		define dissnx (150)
		#
		# 0,1,2 stands for 2 energy and 1 entropy versions
		rdlumvsr dissvsr0.out $dissnx
		# for Cartesian (else remove):
		define coord 1
		plc 0 lumvsr
		#       
		#
		# I noticed that with old code FV full WENO5BND, lots of dissipation in rarefaction!  Also quite off with dissipation amplitude.  PARA or new full FLUXRECON has no problem
		#
test1dsod4 0	#
		#
		jrdpdiss dissdump0010
		#
		# internal energies
		ctype default pl 0 r disssimpleinvco
		ctype default pl 0 r disssimpleinvconomax 0010
		ctype red pl 0 r dissfullinvco 0010
		ctype red pl 0 r dissfullinvconomax 0010
		ctype cyan pl 0 r disssimpleinvlab1 0010
		ctype cyan pl 0 r disssimpleinvlab1nomax 0010
		ctype green pl 0 r dissfullinvlab1 0010
		ctype green pl 0 r dissfullinvlab1nomax 0010
		ctype magenta pl 0 r disssimpleinvlab2 0010
		ctype magenta pl 0 r disssimpleinvlab2nomax 0010
		ctype yellow pl 0 r dissfullinvlab2 0010
		ctype yellow pl 0 r dissfullinvlab2nomax 0010
		#
		# entropies
		ctype default pl 0 r dissentropyco
		ctype red pl 0 r dissentropyconomax 0010
		ctype blue pl 0 r dissentropylab1 0010
		ctype green pl 0 r dissentropylab1nomax 0010
		ctype cyan pl 0 r dissentropylab2 0010
		ctype magenta pl 0 r dissentropylab2nomax 0010
		#
		# failures
		ctype default pl 0 r dissfailureinv
		#
		#
		#
		#
