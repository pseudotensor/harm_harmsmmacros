mkstoks 2	#
		set "$!2"u0="$!1"u0
		set "$!2"u1="$!1"u1*dxdxp11
		set "$!2"u2="$!1"u2*dxdxp22
		set "$!2"u3="$!1"u3*dxdxp33
		#
		set "$!2"d0="$!1"d0
		set "$!2"d1="$!1"d1/dxdxp11
		set "$!2"d2="$!1"d2/dxdxp22
		set "$!2"d3="$!1"d3/dxdxp33
		#
		#
kstobl 2	#
		#
		set "$!2"u0="$!1"u0-2/(r-2)*"$!1"u1
		set "$!2"u1="$!1"u1
		set "$!2"u2="$!1"u2
		set "$!2"u3="$!1"u3
	        #
		set "$!2"d0="$!1"d0
		set "$!2"d1="$!1"d1+2/(r-2)*"$!1"d0
		set "$!2"d2="$!1"d2
		set "$!2"d3="$!1"d3
		#
		#
mkstobl 2	#
		#
		mkstoks "$!1" ks"$!1"
		kstobl ks"$!1" "$!2"
		#
		#
		#
vecsq 1         #
		set $1sq = "$!1"u0 * "$!1"d0 + "$!1"u1 * "$!1"d1 + "$!1"u2 * "$!1"d2 + "$!1"u3 * "$!1"d3
		#
mkstofluid 2	#
		#
		# Get BL velocity
		#
		mkstobl u boostu
		#
		mkstobl $1 bl$1
		#
		#
		#Schwarzschild BL metric
		set blgv300=-(1-2/r)
		set blgv311=r/(r-2)
		set blgv322=r**2
		set blgv333=r**2*(sin(h))**2
		#
		######### start compute Lorentz factor
 		#
		# velocity of lab frame
		set wu0 = 1/sqrt(-blgv300) 
		set wu1 = 0
		set wu2 = 0
		set wu3 = 0
		#
		# lower components; assuming diagonal metric
		set wd0 = blgv300 * wu0
		set wd1 = blgv311 * wu1
		set wd2 = blgv322 * wu2
		set wd3 = blgv333 * wu3
		#
		#
		dotvector wu boostud boostgamma
		# correct the sign
		set boostgamma = - boostgamma
		#
		######### end compute Lorentz factor
		#
		#
		DO it = 0,3 { \
		   DO jt = 0,3 { \
		      set omegaud"$!it""$!jt"= boostuu"$!it" * wd"$!jt" - wu"$!it" * boostud"$!jt"
		      set omegadu"$!it""$!jt"= boostud"$!it" * wu"$!jt" - wd"$!it" * boostuu"$!jt"
		   }
		}
		#
		dottensor omegaud omegaud omegaudsq
		dottensor omegadu omegadu omegadusq
		#
		DO it = 0,3 { \
		   DO jt = 0,3 { \
		       set lamud"$!it""$!jt" = omegaudsq"$!it""$!jt" / ( boostgamma + 1 ) + omegaud"$!it""$!jt"
		       set lamdu"$!it""$!jt" = omegadusq"$!it""$!jt" / ( boostgamma + 1 ) + omegadu"$!it""$!jt"
		   }
		}
		# add in a delta function
		DO it = 0,3 { \
		   set lamud"$!it""$!it" = lamud"$!it""$!it" + 1
		   set lamdu"$!it""$!it" = lamdu"$!it""$!it" + 1
		}
		#
		#Check if lamud and lamdu inverses of each other
		#
		DO it = 0,3 { \
  	           DO jt = 0,3 { \
		      set mult"$!it""$!jt" = 0
		      DO kt = 0,3 { \
		         set mult"$!it""$!jt" = mult"$!it""$!jt"+lamud"$!it""$!kt" * lamdu"$!jt""$!kt"
		      }
		   }
		}
		#
		# perform a boost
		#
		tensordotvector lamud bl"$!1"u "$!2"u
		tensordotvector lamdu bl"$!1"d "$!2"d
		#
		#
computevaflu 0 #
		#
		mkstofluid b flub
		set EF1 = rho + u + p + bsq
		set fluvar = (flubu1 * flubd1 / EF1)**0.5
		set fluvath = (flubu2 * flubd2 / EF1)**0.5
		set fluvaphi = (flubu3 * flubd3 / EF1)**0.5
		set fluvasq = fluvar**2 + fluvath**2 + fluvaphi**2
		set fluvasqcode = bsq / EF1
		#
testomegadef 0  #
		#
		tensordotvector omegaud boostuu test
		DO i = 0,3 { set shouldbezero$i = test$i - wu$i + boostgamma * bluu$i }
		#
testomegadef 0  #
		#
		tensordotvector omegaud boostuu test
		DO i = 0,3 { \
		   set test$i = 0
		   DO j = 0,3 { \
		      set myomud"$!i""$!j" = wd$j
		      set test$i = test$i + myomud"$!i""$!j" * boostuu$j
		   }
		   set test$i = test$i  - ( - boostgamma )
		}
		#
testomegadef 0  #
		#
		tensordotvector omegaud boostuu test
		DO i = 0,3 { \
		   set test$i = 0
		   DO j = 0,3 { \
		      set myomud"$!i""$!j" = boostuu$i * wd$j - wu$i * boostud$j * 0
		      set test$i = test$i + myomud"$!i""$!j" * boostuu$j
		   }
		   set test$i = test$i  - ( - boostgamma * boostuu$i + wu$i * 0 )
		}
		#
tensordotvector 3	# contract {A^\mu}_\nu B^\nu result^\mu
		#
		set "$!3" = 0
		DO it = 0,3 { \
		    set "$!3""$!it" = 0
		    DO jt = 0,3 { \
		       set "$!3""$!it" = "$!3""$!it" + "$!1""$!it""$!jt" * "$!2""$!jt"
		    }
		}
		#
		#
dotvector 3     # contract A^\sigma B_\sigma result
		#
		set "$!3" = 0
		DO kt = 0,3 { \
		       set "$!3" = "$!3" + "$!1""$!kt" * "$!2""$!kt"
		}
		#
		#
sumtensor 3	#  sum {A^\mu}_\nu {B^\mu}_\nu {result^\mu}_\nu
		#
		DO it = 0,3 { \
		   DO jt = 0,3 { \
		       set "$!3""$!it""$!jt" = "$!1""$!it""$!jt" + "$!2""$!it""$!jt"
		   }
		}
		#
deftensor 3     #
		DO it = 0,3 { \
		   DO jt = 0,3 { \
		      set "$!3""$!it""$!jt" = "$!1""$!it" * "$!2""$!jt"
		   }
		}
		#
dottensor 3     #  contract {A^\nu}_\sigma {B^\sigma}_\nu {result^\nu}_\mu
		#
		DO it = 0,3 { \
		   DO jt = 0,3 { \
		       set "$!3""$!it""$!jt" = 0 
		       DO kt = 0,3 { \
		              set "$!3""$!it""$!jt" = "$!3""$!it""$!jt" + "$!1""$!it""$!kt" * "$!2""$!kt""$!jt"
		       }
		   }
		}
		#
crapxx 0	#
		set bbld0 = blgv300 * bluu0
		set bbld1 = blgv311 * bluu1
		set bbld2 = blgv322 * bluu2
		set bbld3 = blgv333 * bluu3
		set blusq1 = blgv300 * bluu0**2 + blgv311 * bluu1**2 + blgv322 * bluu2**2 + blgv333 * bluu3**2
		#set blusq1 = bluu0 * blud0 + bluu1 * blud1 + bluu2 * blud2 + bluu3 * blud3
		#set blusq1 = bluu0 * blud0 + bluu1 * blud1 + bluu2 * blud2 + bluu3 * blud3


