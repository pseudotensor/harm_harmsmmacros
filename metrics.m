		#
pldiffold       3  #
		define triple (sprintf('%d',$1)+sprintf('%d',$2)+sprintf('%d',$3))
		set cdiff=c$triple-kspc$triple
		set god=SUM(ABS(kspc$triple))
		if(god==0) { set cpd=cdiff }
		if(god>0) { set cpd=cdiff/(1E-30+kspc$triple) }
		plc 0 cpd
		#
		#
pldiff2d     3  #
		define triple (sprintf('%d',$1)+sprintf('%d',$2)+sprintf('%d',$3))
                # cd /data/jon/testnewfloor_energymomcons_limituconslope.duplicate/makedir.test.testnewfloor_energymomcons_limituconslope.duplicate/run
		grid3d gdump
		set crun1=c$triple
		# run from oldcode
		#grid3d ../../../../home_joint2_merged/run/dumps/gdump0000
		#grid3d ../../../home_joint2_merged/run/dumps/gdump0000
                grid3d ../../../../1dmhdwavetests_new2/makedir.test.torus5_toth_limweno5bnd_cuspon/run/dumps/gdump
		set crun2=c$triple
		#
		set cdiff=ABS(crun1-crun2)
		set god=SUM(ABS(crun2))
		if(god==0) { set cpd=cdiff }
		if(god>1E-10) { set cpd=cdiff/abs(1E-30+crun1+crun2) }\
		    else{\
		       set cpd=cdiff
		       }
		#
		#
		#set ix=0,$nx-1,1
		#set iy=ix*0+0
		#set image[ix,iy]=cpd
		#minmax min max
                #
		#
		#
		plc 0 cpd
                #
		#
pldiff1d       3  #
		define triple (sprintf('%d',$1)+sprintf('%d',$2)+sprintf('%d',$3))
                # cd /data/jon/testnewfloor_energymomcons_limituconslope.duplicate/makedir.test.testnewfloor_energymomcons_limituconslope.duplicate/run
		grid3d gdump
		set crun1=c$triple
		# run from oldcode
		#grid3d ../../../../home_joint2_merged/run/dumps/gdump0000
		#grid3d ../../../home_joint2_merged/run/dumps/gdump0000
                grid3d ../../../../1dmhdwavetests_new2/makedir.test.torus5_toth_limweno5bnd_cuspon/run/dumps/gdump
		set crun2=c$triple
		#
		set cdiff=ABS(crun1-crun2)
		set god=SUM(ABS(crun2))
		if(god==0) { set cpd=cdiff }
		if(god>1E-10) { set cpd=cdiff/abs(1E-30+crun1+crun2) }\
		    else{\
		       set cpd=cdiff
		       }
		#
		#
		set ix=0,$nx-1,1
		set iy=ix*0+0
		set image[ix,iy]=cpd
		minmax min max
		#
		#
		pl 0 r cpd 1101 1E-1 Rout 1E-15 10
		#
plconn       3  #
		define triple (sprintf('%d',$1)+sprintf('%d',$2)+sprintf('%d',$3))
		grid3d gdump0000
		set crun1=c$triple
		# run from oldcode
		#grid3d ../../../../home_joint2_merged/run/dumps/gdump0000
		grid3d ../../../home_joint2_merged/run/dumps/gdump0000
		set crun2=c$triple
		#
		set crun=crun1
		#
		#
		set iy=iy*0+0
		set ix=0,$nx-1,1
		set image[ix,iy]=ABS(crun)
		minmax min max
		#
		#
		pl 0 r crun 1101 1E-3 Rout 1E-15 1E5
		#
planimdiff   0  #
		#
		#
		#
		set minlist=1,4*4*4,1
		set minlist=minlist*0
		set maxlist=minlist*0
		set myii=minlist*0
		set myjj=minlist*0
		set mykk=minlist*0
		#
		do ii=0,3,1{
		   do jj=0,3,1{
		      do kk=0,3,1{
		         echo "doing" $ii $jj $kk
		         #pldiff $ii $jj $kk
                          pldiff2d $ii $jj $kk
		         echo "done" $ii $jj $kk
		         set minlist[$ii*4*4+$jj*4+$kk]=$min
		         set maxlist[$ii*4*4+$jj*4+$kk]=$max
		         set myii[$ii*4*4+$jj*4+$kk]=$ii
		         set myjj[$ii*4*4+$jj*4+$kk]=$jj
		         set mykk[$ii*4*4+$jj*4+$kk]=$kk
		         !sleep 0.5
		      }
		   }
		}
planimconn   0  #
		#
		#
		#
		set cminlist=1,4*4*4,1
		set cminlist=minlist*0
		set cmaxlist=minlist*0
		set cmyii=minlist*0
		set cmyjj=minlist*0
		set cmykk=minlist*0
		#
		do ii=0,3,1{
		   do jj=0,3,1{
		      do kk=0,3,1{
		         echo "doing" $ii $jj $kk
		         plconn $ii $jj $kk
		         echo "done" $ii $jj $kk
		         set cminlist[$ii*4*4+$jj*4+$kk]=$min
		         set cmaxlist[$ii*4*4+$jj*4+$kk]=$max
		         set cmyii[$ii*4*4+$jj*4+$kk]=$ii
		         set cmyjj[$ii*4*4+$jj*4+$kk]=$jj
		         set cmykk[$ii*4*4+$jj*4+$kk]=$kk
		         !sleep 1
		      }
		   }
		}
printdiff    0  #
		print conndiff.txt {myii myjj mykk minlist maxlist}
		#
		#
		#
		#
printconn    0  #
		print conn.txt {myii myjj mykk cminlist cmaxlist}
		#
		#
		#
		#
		# MKS or KSP (R0 and hslope)
kspmetric 0    #
		set sigma=r**2+a**2*cos(h)**2
		set dxdxp1=r-R0
		set dxdxp2=pi+(1-hslope)*pi*cos(2*pi*tx2)
		#
		set kspc000=(4.*r**3 - 2.*r*sigma)/sigma**3
		set kspc001=(dxdxp1*(2.*r**2 - 1.*sigma)*(2.*r + sigma))/sigma**3
		set kspc002=(-1.*a**2*dxdxp2*r*sin(2.*h))/sigma**2
		set kspc003=(-2.*a*r*(2.*r**2 - 1.*sigma)*sin(h)**2)/sigma**3
		set kspc010=(dxdxp1*(2.*r**2 - 1.*sigma)*(2.*r + sigma))/sigma**3
		set kspc011=(2.*dxdxp1**2*(2.*r**2 - 1.*sigma)*(r + sigma))/sigma**3
		set kspc012=(-1.*a**2*dxdxp1*dxdxp2*r*sin(2.*h))/sigma**2
		set kspc013=(a*dxdxp1*(2.*r + sigma)*(-2.*r**2 + sigma)*sin(h)**2)/sigma**3
		set kspc020=(-1.*a**2*dxdxp2*r*sin(2.*h))/sigma**2
		set kspc021=(-1.*a**2*dxdxp1*dxdxp2*r*sin(2.*h))/sigma**2
		set kspc022=(-2.*dxdxp2**2*r**2)/sigma
		set kspc023=(2.*a**3*dxdxp2*r*cos(h)*sin(h)**3)/sigma**2
		set kspc030=(-2.*a*r*(2.*r**2 - 1.*sigma)*sin(h)**2)/sigma**3
		set kspc031=(a*dxdxp1*(2.*r + sigma)*(-2.*r**2 + sigma)*sin(h)**2)/sigma**3
		set kspc032=(2.*a**3*dxdxp2*r*cos(h)*sin(h)**3)/sigma**2
		set kspc033=(2.*r*sin(h)**2*(-1.*r*sigma**2 + a**2*(2.*r**2 - 1.*sigma)*sin(h)**2))/sigma**3
		set kspc100=((2.*r**2 - 1.*sigma)*(-2.*r + sigma + a**2*sin(h)**2))/(dxdxp1*sigma**3)
		set kspc101=(0.5*(-2.*r**2 + sigma)*(-1.*a**2 + 4.*r + a**2*cos(2.*h)))/sigma**3
		set kspc102=0.
		set kspc103=(0.5*a*(2.*r**2 - 1.*sigma)*(-1.*a**2 + 4.*r - 2.*sigma + a**2*cos(2.*h))*sin(h)**2)/(dxdxp1*sigma**3)
		set kspc110=(0.5*(-2.*r**2 + sigma)*(-1.*a**2 + 4.*r + a**2*cos(2.*h)))/sigma**3
		set kspc111=(sigma**3 - 1.*dxdxp1*(2.*r**2 - 1.*sigma)*(2.*r + sigma) + a**2*dxdxp1*(2.*r**2 - 1.*sigma)*sin(h)**2)/sigma**3
		set kspc112=(-1.*a**2*dxdxp2*cos(h)*sin(h))/sigma
		set kspc113=(0.5*a*(a**2*(-2.*r**2 + sigma) + 2.*r*(4.*r**2 + (-2. + sigma)*sigma) + a**2*(2.*r**2 - 1.*sigma)*cos(2.*h))*sin(h)**2)/sigma**3
		set kspc120=0.
		set kspc121=(-1.*a**2*dxdxp2*cos(h)*sin(h))/sigma
		set kspc122=(-1.*dxdxp2**2*r*(-2.*r + sigma + a**2*sin(h)**2))/(dxdxp1*sigma)
		set kspc123=0.
		set kspc130=(0.5*a*(2.*r**2 - 1.*sigma)*(-1.*a**2 + 4.*r - 2.*sigma + a**2*cos(2.*h))*sin(h)**2)/(dxdxp1*sigma**3)
		set kspc131=(0.5*a*(a**2*(-2.*r**2 + sigma) + 2.*r*(4.*r**2 + (-2. + sigma)*sigma) + a**2*(2.*r**2 - 1.*sigma)*cos(2.*h))*sin(h)**2)/sigma**3
		set kspc132=0.
		set kspc133=(-1.*sin(h)**2*(-2.*r + sigma + a**2*sin(h)**2)*(r*sigma**2 + a**2*(-2.*r**2 + sigma)*sin(h)**2))/(dxdxp1*sigma**3)
		set kspc200=(-1.*a**2*r*sin(2.*h))/(dxdxp2*sigma**3)
		set kspc201=(-1.*a**2*dxdxp1*r*sin(2.*h))/(dxdxp2*sigma**3)
		set kspc202=0.
		set kspc203=(2.*a*r*cos(h)*sin(h)*(sigma + a**2*sin(h)**2))/(dxdxp2*sigma**3)
		set kspc210=(-1.*a**2*dxdxp1*r*sin(2.*h))/(dxdxp2*sigma**3)
		set kspc211=(-1.*a**2*dxdxp1**2*r*sin(2.*h))/(dxdxp2*sigma**3)
		set kspc212=(dxdxp1*r)/sigma
		set kspc213=(a*dxdxp1*sin(h)*(sigma*(2.*r + sigma)*cos(h) + a**2*r*sin(h)*sin(2.*h)))/(dxdxp2*sigma**3)
		set kspc220=0.
		set kspc221=(dxdxp1*r)/sigma
		set kspc222=(4.*pi**2*(-1.*h + pi*tx2))/dxdxp2 - (1.*a**2*dxdxp2*cos(h)*sin(h))/sigma
		set kspc223=0.
		set kspc230=(2.*a*r*cos(h)*sin(h)*(sigma + a**2*sin(h)**2))/(dxdxp2*sigma**3)
		set kspc231=(a*dxdxp1*sin(h)*(sigma*(2.*r + sigma)*cos(h) + a**2*r*sin(h)*sin(2.*h)))/(dxdxp2*sigma**3)
		set kspc232=0.
		set kspc233=(-1.*cos(h)*sin(h)*(sigma**3 + a**2*sigma*(4.*r + sigma)*sin(h)**2 + 2.*a**4*r*sin(h)**4))/(dxdxp2*sigma**3)
		set kspc300=(a*(2.*r**2 - 1.*sigma))/sigma**3
		set kspc301=(a*dxdxp1*(2.*r**2 - 1.*sigma))/sigma**3
		set kspc302=(-2.*a*dxdxp2*r*cot(h))/sigma**2
		set kspc303=(-1.*a**2*(2.*r**2 - 1.*sigma)*sin(h)**2)/sigma**3
		set kspc310=(a*dxdxp1*(2.*r**2 - 1.*sigma))/sigma**3
		set kspc311=(a*dxdxp1**2*(2.*r**2 - 1.*sigma))/sigma**3
		set kspc312=(-1.*a*dxdxp1*dxdxp2*(2.*r + sigma)*cot(h))/sigma**2
		set kspc313=(dxdxp1*(r*sigma**2 + a**2*(-2.*r**2 + sigma)*sin(h)**2))/sigma**3
		set kspc320=(-2.*a*dxdxp2*r*cot(h))/sigma**2
		set kspc321=(-1.*a*dxdxp1*dxdxp2*(2.*r + sigma)*cot(h))/sigma**2
		set kspc322=(-1.*a*dxdxp2**2*r)/sigma
		set kspc323=dxdxp2*(cot(h) + (a**2*r*sin(2.*h))/sigma**2)
		set kspc330=(-1.*a**2*(2.*r**2 - 1.*sigma)*sin(h)**2)/sigma**3
		set kspc331=(dxdxp1*(r*sigma**2 + a**2*(-2.*r**2 + sigma)*sin(h)**2))/sigma**3
		set kspc332=dxdxp2*(cot(h) + (a**2*r*sin(2.*h))/sigma**2)
		set kspc333=(-1.*a*r*sigma**2*sin(h)**2 + a**3*(2.*r**2 - 1.*sigma)*sin(h)**4)/sigma**3
		set kspck0=0.
		set kspck1=(-1.*(2.*dxdxp1*r + r**2 + a**2*cos(h)**2))/sigma
		set kspck2=(4.*pi**2*(h - 1.*pi*tx2))/dxdxp2 - 1.*dxdxp2*cot(h) + (a**2*dxdxp2*sin(2.*h))/sigma
		set kspck3=0.
		set kspgv00=-1. + (2.*r)/sigma
		set kspgv01=(2.*dxdxp1*r)/sigma
		set kspgv02=0.
		set kspgv03=(-2.*a*r*sin(h)**2)/sigma
		set kspgv10=(2.*dxdxp1*r)/sigma
		set kspgv11=(dxdxp1**2*(2.*r + sigma))/sigma
		set kspgv12=0.
		set kspgv13=(-1.*a*dxdxp1*(2.*r + sigma)*sin(h)**2)/sigma
		set kspgv20=0.
		set kspgv21=0.
		set kspgv22=dxdxp2**2*sigma
		set kspgv23=0.
		set kspgv30=(-2.*a*r*sin(h)**2)/sigma
		set kspgv31=(-1.*a*dxdxp1*(2.*r + sigma)*sin(h)**2)/sigma
		set kspgv32=0.
		set kspgv33=sigma*sin(h)**2 + (a**2*(2.*r + sigma)*sin(h)**4)/sigma
		set kspgn00=-1. - (2.*r)/sigma
		set kspgn01=(2.*r)/(dxdxp1*sigma)
		set kspgn02=0.
		set kspgn03=0.
		set kspgn10=(2.*r)/(dxdxp1*sigma)
		set kspgn11=(-2.*r + sigma + a**2*sin(h)**2)/(dxdxp1**2*sigma)
		set kspgn12=0.
		set kspgn13=a/(dxdxp1*sigma)
		set kspgn20=0.
		set kspgn21=0.
		set kspgn22=1/(dxdxp2**2*sigma)
		set kspgn23=0.
		set kspgn30=0.
		set kspgn31=a/(dxdxp1*sigma)
		set kspgn32=0.
		set kspgn33=csc(h)**2/sigma
		#
		#
		#
		#
kspsource 0   #
		set dU0= gdet*( \
		Tud00*c000+Tud01*c100+Tud02*c200+Tud03*c300+ \
		Tud10*c001+Tud11*c101+Tud12*c201+Tud13*c301+ \
		Tud20*c002+Tud21*c102+Tud22*c202+Tud23*c302+ \
		Tud30*c003+Tud31*c103+Tud32*c203+Tud33*c303)
		#
		set dU1= gdet*( \
		Tud00*c010+Tud01*c110+Tud02*c210+Tud03*c310+ \
		Tud10*c011+Tud11*c111+Tud12*c211+Tud13*c311+ \
		Tud20*c012+Tud21*c112+Tud22*c212+Tud23*c312+ \
		Tud30*c013+Tud31*c113+Tud32*c213+Tud33*c313)
		#
		set dU2= gdet*( \
		Tud00*c020+Tud01*c120+Tud02*c220+Tud03*c320+ \
		Tud10*c021+Tud11*c121+Tud12*c221+Tud13*c321+ \
		Tud20*c022+Tud21*c122+Tud22*c222+Tud23*c322+ \
		Tud30*c023+Tud31*c123+Tud32*c223+Tud33*c323)
		# 
		set dU3= gdet*( \
		Tud00*c030+Tud01*c130+Tud02*c230+Tud03*c330+ \
		Tud10*c031+Tud11*c131+Tud12*c231+Tud13*c331+ \
		Tud20*c032+Tud21*c132+Tud22*c232+Tud23*c332+ \
		Tud30*c033+Tud31*c133+Tud32*c233+Tud33*c333)
		#
		set rat0=dU0/(gdet*Tud00)
		set rat1=dU1/(gdet*Tud01)
		set rat2=dU2/(gdet*Tud02)
		set rat3=dU3/(gdet*Tud03)
		#
		set dU0conn2=Tud00*ck0+Tud10*ck1+Tud20*ck2+Tud30*ck3
		set dU1conn2=Tud01*ck0+Tud11*ck1+Tud21*ck2+Tud31*ck3
		set dU2conn2=Tud02*ck0+Tud12*ck1+Tud22*ck2+Tud32*ck3
		set dU3conn2=Tud03*ck0+Tud13*ck1+Tud23*ck2+Tud33*ck3
		#
		set reducedconn1=(1+4*r**2/(a**2+2*r**2+a**2*cos(2*h)))
		set reducedconn2=(4*pi**2*(-h+pi*tx2)/dxdxp2+dxdxp2/tan(h)-2*a**2*dxdxp2*sin(2*h)/(a**2+2*r**2+a**2*cos(2*h)))
		set cancel1=ck1+reducedconn1
		set cancel2=ck2+reducedconn2
		#
		set dU0new=dU0/gdet+dU0conn2
		set dU1new=dU1/gdet+dU1conn2
		set dU2new=dU2/gdet+dU2conn2
		set dU3new=dU3/gdet+dU3conn2
		#
		# correct comparison -- fractional change in stress-energy tensor component
		set ratnew0=dU0new/Tud00
		set ratnew1=dU1new/Tud01
		set ratnew2=dU2new/Tud02
		set ratnew3=dU3new/Tud03
		#
		# just compare dU1/gdet with dU1/gdet+dU1conn2
		#
		set sigma=r**2+a**2*cos(h)**2
		set realdU0=0*dU0
		set realdU1=(sigma*(4*Tud01 + 2*sigma*Tud11 - a*Tud31) + r*sigma*(-2*Tud00 + 6*Tud11 + a*Tud31) + 4*r**3*(Tud00 - Tud11 + Tud22 + Tud33) +  \
		    2*r**2*(-4*Tud01 + 2*a*Tud31 + sigma*(Tud22 + Tud33)) + a*(sigma - r*(4*r + sigma))*Tud31*cos(2*h))/(2.*sigma*(2*r + sigma))

		    set realdU1=gdet*realdU1
		set realdU2=(64*pi**2*r*sigma*(2*r + sigma)*Tud22*(-h + pi*tx2) + \
		        2*dxdxp2**2*(8*r*sigma*(2*r + sigma)*Tud33/tan(h) - \
		        2*a*(2*sigma*(2*r + sigma)*Tud31 + a**2*(4*r + sigma)*Tud31 + \
		        2*a*r*(-4*Tud01 + sigma*(Tud22 + Tud33) + 2*r*(Tud00 - Tud11 + Tud22 + Tud33)))*sin(2*h) + a**3*(4*r + sigma)*Tud31*sin(4*h)))/ \
		        (16.*dxdxp2*r*sigma*(2*r + sigma))
		    set realdU2=gdet*realdU2
		set realdU3=0*dU3
		#
#
sourcecheck  0  #
		#
		jrdp dump0000 # peak time of failures
		gammiegridnew3 gdump
		stresscalc 1
		kspsource
		#
		# r-momentum
		set gTud11=Tud11*gdet
		set gTud21=Tud21*gdet
		dercalc 0 gTud11 dgTud11
		dercalc 0 gTud21 dgTud21
		#
		set part1top=dU1
		set part1bottom=-(dgTud11x/$dx1+dgTud21y/$dx2)
		set rat1=part1top/part1bottom
		set irat1=1/rat1
		set lrat1=LG(ABS(rat1))
		set myrat1=(lrat1>-2) ? lrat1 : -1
		#
		# x2-momentum
		set gTud12=Tud12*gdet
		set gTud22=Tud22*gdet
		dercalc 0 gTud12 dgTud12
		dercalc 0 gTud22 dgTud22
		#
		set part2top=dU2
		set part2bottom=-(dgTud12x/$dx1+dgTud22y/$dx2)
		set rat2=part2top/part2bottom
		set irat2=1/rat2
		set lrat2=LG(ABS(rat2))
		set myrat2=(lrat2>-1) ? lrat2 : -1
		#
		#
		define cres 15
		jrdpdebug debug0115
		#
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		plc 0 myrat1
		#
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		plc 0 myrat2 010
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		plc 0 lg1fail 010
		#
		#
		#
convmetric 0    #
		set ogv311=gv311*idxdxp11**2+gv322*idxdxp21**2
		set ogv322=gv311*idxdxp12**2+gv322*idxdxp11**2
connplots 0     #
		#
		da 0_fail.out
		read {delta 1 conn 2}
		smooth conn sconn 5
		der delta conn ddelta dconn
		der delta sconn ddelta dsconn
		ctype default pl 0 delta dconn 1101 1E-15 1E3 1E-15 1E5
		ctype cyan pl 0 delta dsconn 1110
		# c002 for 64^2 at i=62 j=32
		#set it=2.49152497548212e-07
		#
		# c023 for 64^2 at i=32 j=0
		set it=2.44713048253735e-06
		#
		# get "it" from analytic run
		#print '%d %d %21.15g\n' {ti tj c023}
		#
		set conndiff=conn-it
		set connpdiff=(conn-it)/it
		ctype red pl 0 delta conndiff 1110
		ctype blue pl 0 delta connpdiff 1110
		# 2nd der
		der delta dconn ddelta ddconn
		#ctype magenta pl 0 delta ddconn 1101 1E-15 1E3 1E-10 1E10
		ctype magenta pl 0 delta ddconn 1110
		#
		#
conncheck1    0 #
		jrdp dump0000
		gammiegridnew3 gdump
		jre metrics.m
		kspmetric
		planimdiff
		printdiff
		!less -S conndiff.txt
dxdxpcheck1   0 #
		# do conncheck1 first
		set diffdxdxp11=(dxdxp1-dxdxp11)/dxdxp1
		set diffdxdxp22=(dxdxp2-dxdxp22)/dxdxp2
		#
