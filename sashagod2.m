doit 0 
		jrdp dump0000
		gammiegridnew3 gdump
		#
		jrdp dump0000
		#
		#
		set vanal=1E-4*r/(1+1E-4*_t)
		set uanal=1E-13/(1+1E-4*_t)**($gam)
		set rhoanal=1/(1+1E-4*_t)
		set vtrue=v1/uu0*sqrt(gv311)
		set vrat=vtrue/vanal
		set urat=u/uanal
		set rhorat=rho/rhoanal
		set vdiff=(vtrue-vanal)/vanal
		set udiff=(u-uanal)/uanal
		set rhodiff=(rho-rhoanal)/rhoanal
		set ludiff=LG(ABS(udiff))
		set lrhodiff=LG(ABS(rhodiff))
		set lvdiff=LG(ABS(vdiff))
		#
		set myrhodiff=rhodiff+4.99954601046005e-06
		#set myrhodiff=rhodiff+4.99954641837581e-06
		ctype default pl 0 r myrhodiff 0001 -.5 .5 6E-14 1E-13
		ctype cyan points r myrhodiff
		ctype red vertline 0

mirroritdel 1	# CENTER or FACE1 across equator
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
                ctype default pl 0 r $1diff
                ctype red points r $1diff
                #
                errorsym $1
                #
