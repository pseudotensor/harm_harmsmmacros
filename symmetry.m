mirrordiag 1     # CENTER or FACE1 across equator
                set $1diff=$1*0
                set $1num=($1>1E30) ? 1E30 : $1
                set $1sum=$1diff
                set $1asum=$1diff
                set $1partner=$1diff
                #
                set $1diffpeak=0
                set $1peak=0
                #
                #
                do ii=0,$nx*$ny-1,1 {
                   set indexi=INT($ii%$nx)
                   set indexj=INT(($ii%($nx*$ny))/$nx)
                   #
                   set newi=indexj
                   set newj=indexi
                   set newii=$nx*newj+newi
                  set $1diff[$ii]=ABS($1num[newii]-$1num[$ii])*0.5
                  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
                  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
                  set $1partner[$ii]=$1num[newii]
                  #
                  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) }
                  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] }
                  #
                }
                plc0 0 ($1diff/$1)
                #ctype default pl 0 r $1diff
                #ctype red points r $1diff
                #
                errorsym $1
                #
mirrordel 1     # CENTER or FACE1 across equator
		set $1diff=$1*0
		set $1num=($1>1E30) ? 1E30 : $1
		set $1sum=$1diff
		set $1asum=$1diff
		set $1partner=$1diff
		#
		set $1diffpeak=0
		set $1peak=0
		#
		#
		do ii=0,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-1-indexj
		   set newii=$nx*newj+newi
		  set $1diff[$ii]=ABS($1num[newii]-$1num[$ii])*0.5
		  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
		  set $1partner[$ii]=$1num[newii]
		  #
		  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) } 
		  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] } 
		  #
		}
		ctype default pl 0 r $1diff
		ctype red points r $1diff
		#
		errorsym $1
		#
errorsym1 1      #
 		#
		set rat=$1diff/$1asum
		set avgrat=SUM(rat)
		set ratsigma=sqrt(SUM(avgrat**2-rat**2))
		set error=avgrat+ratsigma
		print {avgrat ratsigma error}
		#
errorsym 1      #
 		#
		set avgrat=SUM(ABS($1diff))/SUM($1asum)
		set peakrat=$1diffpeak/$1peak
		set peak2rat=$1diffpeak/SUM($1asum)/dimen($1asum)
		print {avgrat peakrat peak2rat}
		#
mirrordel2 1    # FACE2 or CORN across equator
		set $1diff=$1*0
		set $1num=($1>1E30) ? 1E30 : $1
		set $1sum=$1diff
		set $1asum=$1diff
		set $1partner=$1diff
		#
		set $1diffpeak=0
		set $1peak=0
		#
		do ii=$nx,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-indexj
		   set newii=$nx*newj+newi
		  set $1diff[$ii]=ABS($1num[newii]-$1num[$ii])*0.5
		  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
		  set $1partner[$ii]=$1num[newii]
		  #
		  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) } 
		  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] } 
		  #
		}
		ctype default pl 0 r $1diff
		ctype red points r $1diff
		#
		errorsym $1
		#
mirroradel 1    #
		set $1diff=$1*0
		set $1num=($1>1E30) ? 1E30 : $1
		set $1sum=$1diff
		set $1asum=$1diff
		set $1partner=$1diff
		#
		set $1diffpeak=0
		set $1peak=0
		#
		do ii=0,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-1-indexj
		   set newii=$nx*newj+newi
		  set $1diff[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
		  set $1partner[$ii]=$1num[newii]
		  #
		  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) } 
		  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] } 
		  #
		}
		ctype default pl 0 r $1diff
		ctype red points r $1diff
		#
		errorsym $1
		#
mirroradel2 1   # FACE2 or CORN across equator
		set $1diff=$1*0
		set $1num=($1>1E30) ? 1E30 : $1
		set $1sum=$1diff
		set $1asum=$1diff
		set $1partner=$1diff
		#
		set $1diffpeak=0
		set $1peak=0
		#
		do ii=$nx,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-indexj
		   set newii=$nx*newj+newi
		  set $1diff[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
		  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
		  set $1partner[$ii]=$1num[newii]
		  #
		  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) } 
		  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] } 
		  #
		}
		ctype default pl 0 r $1diff
		ctype red points r $1diff
		#
		#
		errorsym $1
		#
		# e.g.
dommetric   0   #
		#
		mirrordel gn300
		mirrordel gn301
		mirrordel gn302
		mirrordel gn303
		mirrordel gn310
		mirrordel gn311
		mirrordel gn312
		mirrordel gn313
		mirrordel gn320
		mirrordel gn321
		mirrordel gn322
		mirrordel gn323
		mirrordel gn330
		mirrordel gn331
		mirrordel gn332
		mirrordel gn333
		#
		mirrordel gn000
		mirrordel gn001
		mirrordel gn002
		mirrordel gn003
		mirrordel gn010
		mirrordel gn011
		mirrordel gn012
		mirrordel gn013
		mirrordel gn020
		mirrordel gn021
		mirrordel gn022
		mirrordel gn023
		mirrordel gn030
		mirrordel gn031
		mirrordel gn032
		mirrordel gn033
		#
		mirrordel2 gn100
		mirrordel2 gn101
		mirrordel2 gn102
		mirrordel2 gn103
		mirrordel2 gn110
		mirrordel2 gn111
		mirrordel2 gn112
		mirrordel2 gn113
		mirrordel2 gn120
		mirrordel2 gn121
		mirrordel2 gn122
		mirrordel2 gn123
		mirrordel2 gn130
		mirrordel2 gn131
		mirrordel2 gn132
		mirrordel2 gn133
		#
		#
		mirrordel2 gn200
		mirrordel2 gn201
		mirrordel2 gn202
		mirrordel2 gn203
		mirrordel2 gn210
		mirrordel2 gn211
		mirrordel2 gn212
		mirrordel2 gn213
		mirrordel2 gn220
		mirrordel2 gn221
		mirrordel2 gn222
		mirrordel2 gn223
		mirrordel2 gn230
		mirrordel2 gn231
		mirrordel2 gn232
		mirrordel2 gn233
		#
		#
		mirrordel gv300
		mirrordel gv301
		mirrordel gv302
		mirrordel gv303
		mirrordel gv310
		mirrordel gv311
		mirrordel gv312
		mirrordel gv313
		mirrordel gv320
		mirrordel gv321
		mirrordel gv322
		mirrordel gv323
		mirrordel gv330
		mirrordel gv331
		mirrordel gv332
		mirrordel gv333
		#
		mirrordel gv000
		mirrordel gv001
		mirrordel gv002
		mirrordel gv003
		mirrordel gv010
		mirrordel gv011
		mirrordel gv012
		mirrordel gv013
		mirrordel gv020
		mirrordel gv021
		mirrordel gv022
		mirrordel gv023
		mirrordel gv030
		mirrordel gv031
		mirrordel gv032
		mirrordel gv033
		#
		mirrordel2 gv100
		mirrordel2 gv101
		mirrordel2 gv102
		mirrordel2 gv103
		mirrordel2 gv110
		mirrordel2 gv111
		mirrordel2 gv112
		mirrordel2 gv113
		mirrordel2 gv120
		mirrordel2 gv121
		mirrordel2 gv122
		mirrordel2 gv123
		mirrordel2 gv130
		mirrordel2 gv131
		mirrordel2 gv132
		mirrordel2 gv133
		#
		#
		mirrordel2 gv200
		mirrordel2 gv201
		mirrordel2 gv202
		mirrordel2 gv203
		mirrordel2 gv210
		mirrordel2 gv211
		mirrordel2 gv212
		mirrordel2 gv213
		mirrordel2 gv220
		mirrordel2 gv221
		mirrordel2 gv222
		mirrordel2 gv223
		mirrordel2 gv230
		mirrordel2 gv231
		mirrordel2 gv232
		mirrordel2 gv233
		#
		mirrordel r
		mirroradel h
		mirrordel rho
		mirrordel u
		mirrordel v1
		mirroradel v2
		mirrordel v3
		mirrordel B1
		mirroradel B2
		mirrordel B3
		mirrordel divb
		#
		mirrordel uu0
		mirrordel uu1
		mirroradel uu2
		mirrordel uu3
		mirrordel ud0
		mirrordel ud1
		mirroradel ud2
		mirrordel ud3
		mirrordel bu0
		mirrordel bu1
		mirroradel bu2
		mirrordel bu3
		mirrordel bd0
		mirrordel bd1
		mirroradel bd2
		mirrordel bd3
		#mirrordel v1m
		#mirrordel v1p
		#mirroradel v2m
		#mirroradel v2p
		#
		#
torus1loop 0    #
		#
		mirrordel rho
		mirrordel lrho
		mirrordel u
		mirrordel lu
		mirrordel v1
		mirroradel v2
		mirrordel v3
		#mirroradel B1
		#mirrordel B2
		#mirroradel B3
		mirrordel uu1
		#
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 rho
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 rhodiff 010
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 lrho
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 lrhodiff 010
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 lu
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 ludiff 010
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 v1
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 v1diff 010
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 v2
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 v2diff 010
		#
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 v3
		define POSCONTCOLOR blue define NEGCONTCOLOR blue plc 0 v3diff 010
		#
		define cres 1024
		define POSCONTCOLOR red define NEGCONTCOLOR red plc 0 uu1
		set lev=-1E-10,1E-10,2E-10
		levels lev
		ctype blue contour
		#
		define POSCONTCOLOR cyan define NEGCONTCOLOR cyan plc 0 uu1diff 010
		#
vchar1test 0    #
		# fluid part from vchar.c
		#
		set Ad0=0*rho
		set Ad1=1*rho/rho
		set Ad2=0*rho
		set Ad3=0*rho
		raise Ad Au
		set Asq=Ad0*Au0+Ad1*Au1+Ad2*Au2+Ad3*Au3
		set Au=Ad0*uu0+Ad1*uu1+Ad2*uu2+Ad3*uu3
		#
		# B-field part from vchar.c
		set Bd0=1*rho/rho
		set Bd1=0*rho
		set Bd2=0*rho
		set Bd3=0*rho
		raise Bd Bu
		set Bsq=Bd0*Bu0+Bd1*Bu1+Bd2*Bu2+Bd3*Bu3
		set Bu=Bd0*uu0+Bd1*uu1+Bd2*uu2+Bd3*uu3
		#
		set AB=Ad0*Bu0+Ad1*Bu1+Ad2*Bu2+Ad3*Bu3
		set Au2=Au*Au
		set Bu2=Bu*Bu
		set AuBu=Au*Bu
		#
		set A = Bu2 - (Bsq + Bu2) * cms2
		set B = 2. * (AuBu - (AB + AuBu) * cms2)
		set C = Au2 - (Asq + Au2) * cms2
		#
		set discr = B * B - 4. * A * C
		set discr=sqrt(discr)
		#
		set gv1m = -(-B + discr) / (2. * A)
		set gv1p = -(-B - discr) / (2. * A)
		#
		# order
		set tv1m=(gv1p<gv1m) ? gv1p : gv1m
		set tv1p=(gv1p<gv1m) ? gv1m : gv1p
		#
		set diffv1m=v1m-tv1m
		pls 0 diffv1m
		set diffv1p=v1p-tv1p
		pls 0 diffv1p
		#
		#
vchar2test 0    #
		# fluid part from vchar.c
		#
		set Ad0=0*rho
		set Ad1=0*rho
		set Ad2=1*rho/rho
		set Ad3=0*rho
		raise Ad Au
		set Asq=Ad0*Au0+Ad1*Au1+Ad2*Au2+Ad3*Au3
		set Au=Ad0*uu0+Ad1*uu1+Ad2*uu2+Ad3*uu3
		#
		# B-field part from vchar.c
		set Bd0=1*rho/rho
		set Bd1=0*rho
		set Bd2=0*rho
		set Bd3=0*rho
		raise Bd Bu
		set Bsq=Bd0*Bu0+Bd1*Bu1+Bd2*Bu2+Bd3*Bu3
		set Bu=Bd0*uu0+Bd1*uu1+Bd2*uu2+Bd3*uu3
		#
		set AB=Ad0*Bu0+Ad1*Bu1+Ad2*Bu2+Ad3*Bu3
		set Au2=Au*Au
		set Bu2=Bu*Bu
		# AuBu is ASYM
		set AuBu=Au*Bu
		#
		# A is SYM about equator
		set A = Bu2 - (Bsq + Bu2) * cms2
		# mirroradel B is small, B is ASYM about equator
		set B = 2. * (AuBu - (AB + AuBu) * cms2)
		# C is SYM about equator
		set C = Au2 - (Asq + Au2) * cms2
		#
		set discr = B * B - 4. * A * C
		set discr=sqrt(discr)
		#
		set gv2m = -(-B + discr) / (2. * A)
		set gv2p = -(-B - discr) / (2. * A)
		#
		# order
		set tv2m=(gv2p<gv2m) ? gv2p : gv2m
		set tv2p=(gv2p<gv2m) ? gv2m : gv2p
		#
		set diffv2m=v2m-tv2m
		pls 0 diffv2m
		set diffv2p=v2p-tv2p
		pls 0 diffv2p
		#
smirrordel 0   # special CENTER or FACE1 across equator
		# v2m and v2p are related in symmetry
		set vp2diff=rho*0
		do ii=$nx,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-1-indexj
		   set newii=$nx*newj+newi
		  set vp2diff[$ii]=ABS(v2p[newii]+v2m[$ii])
		}
		ctype default pl 0 r vp2diff
		ctype red points r vp2diff
		#
sym1d 1	# 1-D across middle for symmetric things
		set $1diff=$1*0
                set $1num=($1>1E30) ? 1E30 : $1
                set $1sum=$1diff
                set $1asum=$1diff
                set $1partner=$1diff
                #
                set $1diffpeak=0
                set $1peak=0
                #
                #
                do ii=0,$nx*$ny-1,1 {
                   set indexi=INT($ii%$nx)
                   set indexj=INT(($ii%($nx*$ny))/$nx)
                   #
                   set newi=$nx-1-indexi
                   set newj=indexj
		   set newii=newi+newj*$nx
                  set $1diff[$ii]=ABS($1num[newii]-$1num[$ii])*0.5
                  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
                  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
                  set $1partner[$ii]=$1num[newii]
                  #
                  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) }
                  if(ABS($1diff[$ii])>$1diffpeak) { set  $1diffpeak = $1diff[$ii] set  $1peak = $1asum[$ii] }
                  #
                }
                #ctype default pl 0 r ($1diff/$1asum) 0101 -0.5 0.5 1E-30 1
                #ctype red points r (LG($1diff/$1asum))
		#ctype blue pl 0 r $1 0111 -0.5 0.5 1E-30 1
		ctype default pl 0 r ($1diff/$1asum)
                ctype red points r (($1diff/$1asum))
                #
                errorsym $1
                #
                #
asym1d 1	# 1-D across middle for anti-symmetric things
		set $1diff=$1*0
                set $1num=($1>1E30) ? 1E30 : $1
                set $1sum=$1diff
                set $1asum=$1diff
                set $1partner=$1diff
                #
                set $1diffpeak=0
                set $1peak=0
                #
                #
                do ii=0,$nx*$ny-1,1 {
                   set indexi=INT($ii%$nx)
                   set indexj=INT(($ii%($nx*$ny))/$nx)
                   #
                   set newi=$nx-1-indexi
                   set newj=indexj
		   set newii=newi+newj*$nx
                  set $1diff[$ii]=ABS($1num[newii]-$1num[$ii])*0.5
                  set $1sum[$ii]=ABS($1num[newii]+$1num[$ii])*0.5
                  set $1asum[$ii]=(ABS($1num[newii])+ABS($1num[$ii]))*0.5
                  set $1partner[$ii]=$1num[newii]
                  #
                  #if(ABS($1[$ii])>$1peak) { set  $1peak = ABS($1[$ii]) }
                  if(ABS($1sum[$ii])>$1diffpeak) { set  $1diffpeak = $1sum[$ii] set  $1peak = $1asum[$ii] }
                  #
                }
                ctype default pl 0 r ($1sum/$1asum)
                ctype red points r ($1sum/$1asum)
                #
                errorsym $1
                #
agplsym  2	# agpl 'dump' rho
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  #
		  set godrho=rho-1.0
		  #
		  sym1d $2
		  #
		  #
		  !sleep .05s
		}
		#
agplasym  2	# agpl 'dump' rho
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  #
		  asym1d $2
		  #
		  #
		  !sleep .05s
		}
		#
eqsym 2     # CENTER or FACE1 across equator
                set $2 = $1*0
		do ii=0,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-1-indexj
		   set newii=$nx*newj+newi
		   set $2[$ii]=$1[newii]
		  #
		}
		#
eqasym 2     # CENTER or FACE1 across equator
                set $2 = $1*0
		do ii=0,$nx*$ny-1,1 {
		   set indexi=INT($ii%$nx)
		   set indexj=INT(($ii%($nx*$ny))/$nx)
		   #
		   set newi=indexi
		   set newj=$ny-1-indexj
		   set newii=$nx*newj+newi
		   set $2[$ii]=-$1[newii]
		  #
		}
		#
