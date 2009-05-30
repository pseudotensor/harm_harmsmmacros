turbcalc    0           #
		set wavee=(ke+ie+be-be[0])
		#
rmsvstime   0   #
		set trms=0,10,1
		set rmsrhovst=0,10,1
		set rmsvvst=0,10,1
		set rmsvxvst=0,10,1
		set rmsvyvst=0,10,1
		set rmsvzvst=0,10,1
		set rmsbvst=0,10,1
		set rmsbxvst=0,10,1
		set rmsbyvst=0,10,1
		set rmsbzvst=0,10,1
		set h1='dump'
		set h3='.dat.txt'
		do ii=0,10,1 {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2+h3
		   define filename (_fname)
		   #
		   rdturb $filename
		   turbrms
		   set rmsrhovst[$ii]=rmsrho
		   set rmsvvst[$ii]=rmsv
		   set rmsvxvst[$ii]=rmsvx
		   set rmsvyvst[$ii]=rmsvy
		   set rmsvzvst[$ii]=rmsvz
		   set rmsbvst[$ii]=rmsb
		   set rmsbxvst[$ii]=rmsbx
		   set rmsbyvst[$ii]=rmsby
		   set rmsbzvst[$ii]=rmsbz
		}
		#
plotrms     0   #
		ctype default
		erase
		limits 0 10 0 4.0
		box
		ltype 0 ctype cyan pl 0 trms rmsrhovst 0010
		ltype 1 ctype red pl 0 trms rmsvvst 0010
		ltype 2 ctype green pl 0 trms rmsvxvst 0010
		ltype 3 ctype default pl 0 trms rmsvyvst 0010
		ltype 4 ctype default pl 0 trms rmsvzvst 0010
		ltype 2 ctype red pl 0 trms rmsbvst 0010
		ltype 2 ctype blue pl 0 trms rmsbxvst 0010
		ltype 3 ctype blue pl 0 trms rmsbyvst 0010
		ltype 4 ctype blue pl 0 trms rmsbzvst 0010
turbrms     0   #
		set size=$nx*$ny*$nz
                set rhoa=SUM(rho)/size
                set vxa=SUM(vx)/size
                set vya=SUM(vy)/size
                set vza=SUM(vz)/size
                set bxa=SUM(bx)/size
                set bya=SUM(by)/size
                set bza=SUM(bz)/size
		print {rhoa vxa vya vza bxa bya bza}
		#
		set rmsrho=SUM((rho-rhoa)*(rho-rhoa))/size
		set rmsvx=SUM((vx-vxa)*(vx-vxa))/size
		set rmsvy=SUM((vy-vya)*(vy-vya))/size
		set rmsvz=SUM((vz-vza)*(vz-vza))/size
		set rmsbx=SUM((bx-bxa)*(bx-bxa))/size
		set rmsby=SUM((by-bya)*(by-bya))/size
		set rmsbz=SUM((bz-bza)*(bz-bza))/size
		set rmsv=sqrt(rmsvx+rmsvy+rmsvz)
		set rmsb=sqrt(rmsbx+rmsby+rmsbz)
		set rmsvx=sqrt(rmsvx)
		set rmsvy=sqrt(rmsvy)
		set rmsvz=sqrt(rmsvz)
		set rmsbx=sqrt(rmsbx)
		set rmsby=sqrt(rmsby)
		set rmsbz=sqrt(rmsbz)
		print {rmsv rmsvx rmsvy rmsvz}
		print {rmsb rmsbx rmsby rmsbz}
		#
                #
turbbasic   0
		rdbasic1 0 0 -1
		rdbasic2 0 0 -1
		rdbasic4 0 0 -1
rdturb      1           #
		da $1
		#lines 7 10000000
		lines 1 10000000
		read {vx 1 vy 2 vz 3 bx 4 by 5 bz 6 rho 7}
		#
rdcolumn      1   #
		da $1
		lines 1 10000000
		read {cvx 1 cvy 2 cvz 3 cbx 4 cby 5 cbz 6 crho 7}
		#
cartgrid    0
	    set ii=0,$nx*$ny*$nz-1,1
            set i=INT(ii%$nx)
            set j=INT((ii%($nx*$ny))/$nx)
            set k=INT(ii/($nx*$ny))
	    #
	    define dx (($Lx-$Sx)/$nx)
	    define dy (($Ly-$Sy)/$ny)
	    define dz (($Lz-$Sz)/$nz)
            set x12=i*$dx
            set x22=j*$dy
            set x32=k*$dz
            set x11=x12
	    set x21=x22
	    set x31=x32
            set x1=x12
	    set x2=x22
	    set x3=x32
column    1 #
	    if($PLANE==3) { set one=$nx set two=$ny }
	    if($PLANE==2) { set one=$nz set two=$nx }
	    if($PLANE==1) { set one=$ny set two=$nz }
	    set size=one*two
	    set c$1=0,size,1
	    set c$1=c$1*0
	    set ii=0,$nx*$ny*$nz-1,1
	    set indexi=INT(ii%$nx)
            set indexj=INT((ii%($nx*$ny))/$nx)
	    set indexk=INT(ii/($nx*$ny))
	    do ii=0,$nx*$ny*$nz-1,1 {
		   if($PLANE==3) { define lii (indexi[$ii]+indexj[$ii]*$nx) set c$1[$lii]=$1[$ii]+c$1[$lii] }
		   if($PLANE==2) { set c$1[indexk[$ii]+indexi[$ii]*$nz]=$1[$ii]+c$1[indexk[$ii]+indexi[$ii]*$nz] }
		   if($PLANE==1) { set c$1[indexj[$ii]+indexk[$ii]*$ny]=$1[$ii]+c$1[indexj[$ii]+indexk[$ii]*$ny] }
		if((indexi[$ii]==0)&&(indexj[$ii]==0)) { set god=indexk[$ii] set god2=$ii print '%d %d\n' {god god2} }
            }
	    if($PLANE==3) { set c$1=c$1/$nz }
	    if($PLANE==2) { set c$1=c$1/$ny }
	    if($PLANE==1) { set c$1=c$1/$nx }
	    #
column2    1 #
	    if($PLANE==3) { set one=$nx set two=$ny }
	    if($PLANE==2) { set one=$nx set two=$ny }
	    if($PLANE==1) { set one=$nx set two=$ny }
            set size=one*two
	    set ii=0,size-1,1
            set lindex1=(INT(ii%one))
	    set lindex2=(INT(ii/two))
	    set c$1 = 0,size-1,1
	    set c$1=c$1*0
	    set ii=0,$nx*$ny*$nz-1,1
	    set indexi=INT(ii%$nx)
	    set indexj=INT((ii%($nx*$ny))/$nx)
	    set indexk=INT(ii/($nx*$ny))
	    #
	    do ii=0,size-1,1 {
		   if($PLANE==3) {\
		    set temp=$1 if((indexi==lindex1[$ii])&&(indexj==lindex2[$ii]))
		    set c$1[$ii]=SUM(temp)
		   }
		   #if($PLANE==2) { set c$1[indexk+indexi*$nz]=$1[$ii]+c$1[indexk+indexi*$nz] }
		   #if($PLANE==1) { set c$1[indexj+indexk*$ny]=$1[$ii]+c$1[indexj+indexk*$ny] }
		   echo $ii
            }
	    if($PLANE==3) { set c$1=c$1/$nz }
	    if($PLANE==2) { set c$1=c$1/$ny }
	    if($PLANE==1) { set c$1=c$1/$nx }
	    #
