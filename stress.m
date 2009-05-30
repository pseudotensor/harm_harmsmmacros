setforce 3      #
		set $1$2$3=$1
		#
		#
godall 0        #
		avgtimeg4 'dump' 20 40 printg42 tavg422040.txt avgtimeg3 'dump' 20 40 printg3 tavg32040.txt  gammiegrid gdump avgtimegfull 'dump' 20 40 gwritedump dumptavg2040v2

		#
bzplot100pre    0 #
		#		for gammie (hoop stress?)
                #
		#
		#
		jrdp dump0000
		gammienew
                readg42 tavg42.txt # to get T's
		#greaddump dumptavg2040equalize
		greaddump dumptavg2040
		#jrdp dumptavg1040       # to get ud0
		#
		# real time average data
		jrdptavg avgavg1040 1
		jrdptavg avg3039avg 1
		#
		# can also do one dump:
		# jrdp dump0040
		# leads to correlated dominated results
		# stresscalc 1
		#
		# for a=0.5 bh15
		jrdp dump0000
		gammienew
		readg42 tavg421040.txt
		readg3 tavg31040.txt
		jrdp dumptavg1040
		#jrdp dumptavg2040equalize
		gammiegrid gdump
		#
		# for a=0.5 bh15
		jrdp dump0000
		gammienew
		readg42 tavg422040.txt
		readg3 tavg32040.txt
		jrdp dumptavg2040v2
		gammiegrid gdump
		#
		#
		# for a=0.5 tavg
		jrdp dump0000
		gammienew
		readg3 tavg32040.txt
                readg42 tavg422040.txt # to get T's
		greaddump dumptavg2040v2
                gammiegrid gdump # to get connection
                #
		# for a=0.5 super tavg
		#
		jrdp dump0000
		gammienew
		#jrdptavg avgavg1040 1
		jrdptavg avg3039avg 1
		gammiegrid gdump        # to get connection
		#
		#
		# for /home/jondata/ramt23/run_r0_b
		#
		jrdpcf2d dump0000
		#jrdpcf2d dump0100
		gammiegridnew3 gdump
		stresscalc 0
		stresscalc 1
		stresscalc 2
		stresscalc 3
		#
		bzplot100doloop 1 3
		bzplot100doloop 2 3
		#
		#
		#
		#
bzplot100doall 0 # uses above
		#
		stresspick
		#
		bzplot100doloop 1 0
		bzplot100doloop 2 0
		# best is 2 below (uniform average)
		bzplot100doloop 1 1
		bzplot100doloop 2 1
		bzplot100doloop 1 2
		bzplot100doloop 2 2
bzplot100doloop 2 # uses above
		#
		#		 !scp -rp metric:sm ~/
		# 1,2 = r,h
		set theequation=$1
		set theaverage=$2
		#
		bzplot100do ' ' theequation theaverage
		bzplot100do 'part0' theequation theaverage
		bzplot100do 'part1' theequation theaverage
		bzplot100do 'part2' theequation theaverage
		bzplot100do 'part3' theequation theaverage
		bzplot100do 'part4' theequation theaverage
		bzplot100do 'part5' theequation theaverage
		bzplot100do 'part6' theequation theaverage
		bzplot100print0
		#
stresspick 0    #
		# for plotting:
		define xlow ($rhor)
		define xhigh (_Rout)
		define ylow (0.0)
		define yhigh (0.8)
		#
                # a=0.9375 456^2
		# time average outer
		#define picki (430)
		#define pickj (36)
		# time average inner
		#define picki (260)
		#define pickj (73)
		# t=2000 location where u_2 is collimating
		#define picki (335)
		#define pickj (62)
		#
		# a=0.5 256^2 outer edge of outflow
		#define picki (250)
		#define pickj (16)
		#define picki (244)      # 243-245
		#define pickj (17) # 17-18
		#
		# /home/jondata/ramt23/run_r0_b
		define picki (3)
		define pickj (12)
		#
		define mydelay (0)
		define doplot (0)
		# 0 = normal w/ gdet
		# 1 = without gdet
		define mygdettype (1)
		#
bzplot100do  3  #
		# which Tud
		#
		set mypar=$1
		define mypart (mypar)
		set myequation=$2
		define myeqn (myequation)
		#
		# average type (0=surface term calculation (real way, but not best), 1=uniform average, 2=gdet volume average 3=single point)
		# 1 is the best average
		set myaverage=$3
		define avgtype (myaverage)
		#
		#stresspick
		#
		if($avgtype!=3){\
		set pickr=r[$picki]
		set pickh=h[$nx*$pickj]
		#
		set spreadfact=0.1
		define pickrin (r[$picki]*(1-spreadfact))
		define pickrout (r[$picki]*(1+spreadfact))
		define pickhin (h[$nx*$pickj]*(1-spreadfact))
		define pickhout (h[$nx*$pickj]*(1+spreadfact))
		set prin=$pickrin
		if(prin<_Rin){ set prin=_Rin }
		set prout=$pickrout
		if(prout>_Rout){ set prout=_Rout }
		set phin=$pickhin
		if(phin<0){ set phin=0 }
		set phout=$pickhout
		if(phout>pi){ set phout=pi }
		#
		}
		if($avgtype==3){\
		set spreadfact=0.1
		set setpicki=$picki
		set setpickj=$pickj
		#
		define pickiin (INT($picki*(1-spreadfact)))
		define pickiout (INT($picki*(1+spreadfact)))
		define pickjin (INT($pickj*(1-spreadfact)))
		define pickjout (INT($pickj*(1+spreadfact)))
		set prin=$pickiin
		if(prin<0){ set prin=0 }
		set prout=$pickiout
		if(prout>$nx){ set prout=$nx }
		set phin=$pickjin
		if(phin<0){ set phin=0 }
		set phout=$pickjout
		if(phout>$ny){ set pjout=$ny }
		}
		#
		#
		if($doplot) {\
		 plc 0 ud0 001 $xlow $xhigh $ylow $yhigh
		 set myud0=newfun
		}
		#
		 #################################
		 # SETUP MEMORY FOR FORCES
		 #
		set totalforce=0,$nx*$ny-1,1
		set totalforce=totalforce*0
		set totalforceavg=0
		#
		# 1 total, 2 for dx,dy 4*4 for connection1 and 2 for connection2
		define numforces (3+4*4+2)
		#
		set gammieforce=0,$numforces-1,1
		set gammieavgforce=0,$numforces-1,1
		#
		if($1 == ' ') {\
		       define Tterm (sprintf('%d',$myeqn))
		    }\
		    else{\
		       define Tterm (sprintf('%d',$myeqn)+'$!mypart')
		    }
		 #################################
		 # SETUP things to difference
		 #
		    if($mygdettype==0){\
		set gt0=gdet*Tud0$Tterm
		set gt1=gdet*Tud1$Tterm
		set gt2=gdet*Tud2$Tterm
		set gt3=gdet*Tud3$Tterm
		}
		    if($mygdettype==1){\
		set gt0=Tud0$Tterm
		set gt1=Tud1$Tterm
		set gt2=Tud2$Tterm
		set gt3=Tud3$Tterm
		}
		#
		 #
		 #################################
		 # BEGIN OVER dx terms
		 #
		dercalc 0 gt1 dgt1
		set thisforce=-dgt1x
		setforce thisforce 8 8
		set gammieforce[1]=thisforce[$nx*$pickj+$picki]
		if($avgtype==0){\
		       gcalc63 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavgvsr
		       # this difference is the surface term that results from taking a volume and time average
		       set thisforceavg=thisforceavgvsr[dimen(thisforceavgvsr)-1]-thisforceavgvsr[0]
		    }
		if($avgtype==1){\
		           gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		if($avgtype==3){\
		           gcalc5ij $pickiin $pickiout $pickjin $pickjout thisforce thisforceavg
		        }
		if($avgtype==2){\
		           gcalc52 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		setforce thisforceavg 8 8
		set gammieavgforce[1]=thisforceavg88
		set totalforce=totalforce+thisforce
		set totalforceavg=totalforceavg+thisforceavg
		#
		if($doplot) {\
		define cres 256
		       plc 0 thisforce 001  $xlow $xhigh $ylow $yhigh
		       set image[ix,iy]=myud0
		       set lev=-2,-1,.01
		       levels lev		       
		       ctype blue contour
		       set jjjj=0  while {jjjj<$mydelay} {set jjjj=jjjj+1}
		    }
		#
		 #
		 # END OVER dx terms
		 #################################
		 #
		 #################################
		 # BEGIN OVER dy terms
		 #
		dercalc 0 gt2 dgt2
		set thisforce=-dgt2y
		setforce thisforce 9 9
		if($avgtype==0){\
		       gcalc63 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavgvsth
		       # this difference is the surface term that results from taking a volume and time average
		       set thisforceavg=thisforceavgvsth[dimen(thisforceavgvsth)-1]-thisforceavgvsth[0]
		    }
		if($avgtype==1){\
		           gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		if($avgtype==3){\
		           gcalc5ij $pickiin $pickiout $pickjin $pickjout thisforce thisforceavg
		        }
		if($avgtype==2){\
		           gcalc52 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		setforce thisforceavg 9 9
		set gammieavgforce[2]=thisforceavg99
		set gammieforce[2]=thisforce[$nx*$pickj+$picki]
		set totalforce=totalforce+thisforce
		set totalforceavg=totalforceavg+thisforceavg
		#
		#
		if($doplot) {\
		       plc 0 thisforce 001 $xlow $xhigh $ylow $yhigh
		       set image[ix,iy]=myud0
		       set lev=-2,-1,.01
		       levels lev		       
		       ctype blue contour
		       set jjjj=0  while {jjjj<$mydelay} {set jjjj=jjjj+1}
		    }
		 #
		 # END OVER dy terms
		 #################################
		 #
		 #
		 #################################
		 # BEGIN OVER ii,jj for Connection1 coefficients
		 #
		do ii=0,3,1 {\
		       do jj=0,3,1 {\
		       set test1 = sprintf('%d',$ii)
		       set test2 = sprintf('%d',$jj)
		       set test4 = sprintf('%d',$myeqn)
		       set test3 = test1+test2+mypar
		       set test5 = test2+test4+test1
		       define godtest (test3)
		       define deviltest (test5)
		       if($mygdettype==0){\
		              set thisforce=gdet*Tud$godtest * c$deviltest
		           }
		       if($mygdettype==1){\
		              set thisforce=Tud$godtest * c$deviltest
		           }
		           #
		       setforce thisforce $ii $jj
		if($avgtype==0){\
		       # the below is just a pure volume/time average as required
		       gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		    }
		if($avgtype==1){\
		           gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		if($avgtype==3){\
		           gcalc5ij $pickiin $pickiout $pickjin $pickjout thisforce thisforceavg
		        }
		if($avgtype==2){\
		           gcalc52 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		       setforce thisforceavg $ii $jj
		       set gammieavgforce[3+$ii*4+$jj]=thisforceavg
		       set totalforce=totalforce+thisforce
		       set totalforceavg=totalforceavg+thisforceavg
		       set gammieforce[3+$ii*4+$jj]=thisforce[$nx*$pickj+$picki]
		       echo doing $ii $jj
		       #
		       if($doplot) {\
		       define cres 256
		              plc 0 thisforce 001  $xlow $xhigh $ylow $yhigh
		       set image[ix,iy]=myud0
		       set lev=-2,-1,.01
		       levels lev		       
		       ctype blue contour
		           }
		       #
		       echo done $ii $jj
		       #delay loop
		       set jjjj=0  while {jjjj<$mydelay} {set jjjj=jjjj+1}
		    }
		 }
		 #
		 # END OVER ii,jj for Connection1 coefficients
		 #################################
		 #
		 #################################
		 # BEGIN OVER ii for Connection2 coefficients
		 #
		do ii=1,2,1 {\
		       set test1 = sprintf('%d',$ii)
		       set test4 = sprintf('%d',$myeqn)
		       # T^t1_t4
		       set test3 = test1+test4+mypar
		       # \Gamma2_{t1}
		       set test5 = test1
		       define godtest (test3)
		       define deviltest (test5)
		       if($mygdettype==0){\
		              set thisforce=Tud$godtest*0
		           }
		       if($mygdettype==1){\
		                  # ck includes sign
		              set thisforce=Tud$godtest * ck$deviltest
		           }
		           #
		           define oi (4+$ii-1)
		       setforce thisforce $oi $oi
		if($avgtype==0){\
		       # the below is just a pure volume/time average as required
		       gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		    }
		if($avgtype==1){\
		           gcalc5 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		if($avgtype==3){\
		           gcalc5ij $pickiin $pickiout $pickjin $pickjout thisforce thisforceavg
		        }
		if($avgtype==2){\
		           gcalc52 $pickrin $pickrout $pickhin $pickhout thisforce thisforceavg
		        }
		       setforce thisforceavg $oi $oi
		       set gammieavgforce[3+4*4+$ii-1]=thisforceavg
		       set totalforce=totalforce+thisforce
		       set totalforceavg=totalforceavg+thisforceavg
		       set gammieforce[3+4*4+$ii-1]=thisforce[$nx*$pickj+$picki]
		       echo doing  $oi $oi
		       #
		       if($doplot) {\
		       define cres 256
		              plc 0 thisforce 001  $xlow $xhigh $ylow $yhigh
		       set image[ix,iy]=myud0
		       set lev=-2,-1,.01
		       levels lev		       
		       ctype blue contour
		           }
		       #
		       echo done $oi $oi
		       #delay loop
		       set jjjj=0  while {jjjj<$mydelay} {set jjjj=jjjj+1}
		 }
		 #
		 # END OVER ii for Connection2 coefficients
		 #################################
		 #
		if($doplot) {\
		       plc 0 totalforce 001   $xlow $xhigh $ylow $yhigh
		       set image[ix,iy]=myud0
		       set lev=-2,-.9,.01
		       levels lev		       
		       ctype blue contour
		       #
		    }
		#
		#################################
		# Compute TOTAL force
		#
		set gammieforce[0]=totalforce[$nx*$pickj+$picki]
		set thisforce=gammieforce[0]
		setforce thisforce 0 9
		set thisforceavg=totalforceavg
		setforce thisforceavg 0 9
		set gammieavgforce[0]=totalforceavg
		#
		#################################
		# Compute Normalization for force
		#
		# only do if doing reference (non-part) analysis so can compare against main total for each part too rather than part total
		if($1==' '){\
		       set truesum=gammieforce[0]
		       set trueavgsum=gammieavgforce[0]
		    }
		#
		#
		set gammierat$mypart=gammieforce/truesum
		set temptemp=gammierat$mypart
		#print '%21.15g %21.15g %21.15g\n' {gammieforce truesum temptemp}
		#
		set gammieratavg$mypart=gammieavgforce/trueavgsum
		set temptemp=gammieratavg$mypart
		#print '%21.15g %21.15g %21.15g\n' {gammieavgforce trueavgsum temptemp}
		#
		#
bzplot100print0 #
		#
		set labels={allparts puuud rhouuud uuuud bsquuud pgasdelta pbdelta -bubd}
		set lnull=' '
		set l0=labels[0]
		set l1=labels[1]
		set l2=labels[2]
		set l3=labels[3]
		set l4=labels[4]
		set l5=labels[5]
		set l6=labels[6]
		set l7=labels[7]
		#
		define dfirst ('-DgT1' + sprintf('%d',$myeqn) + 'Dr')
		define dsecond ('-DgT2' + sprintf('%d',$myeqn) + 'Dh')
		set rowlabels={allterms $!!dfirst $!!dsecond \
		       gT00c0x0 gT01c1x0 gT02c2x0 gT03c3x0 \
		       gT10c0x1 gT11c1x1 gT12c2x1 gT13c3x1 \
		       gT20c0x2 gT21c1x2 gT22c2x2 gT23c3x2 \
		       gT30c0x3 gT31c1x3 gT32c2x3 gT33c3x3 \
		       T1x      T2x
		    }
		#
		#
		define stressfname ('stress' + sprintf('eq%d',$myeqn) + sprintf('avg%d',$avgtype) + '.txt')
		echo 'AVGTYPE'
		echo $avgtype
		#
		if($avgtype!=3){\
		 print $stressfname 'stress list for a=%g r=%g h=%g eqn(x below)=%d\n' {a pickr pickh myequation}
		}
		#
		if($avgtype==3){\
		 print $stressfname 'stress list for a=%g i=%g j=%g eqn(x below)=%d\n' {a setpicki setpickj myequation}
		}
		define print_noheader (1)
		print + $stressfname '%15s %15s %15s %15s %15s %15s %15s %15s %15s\n' \
		    {lnull l0 l1 l2 l3 l4 l5 l6 l7}
		print + $stressfname '%15s %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' \
		    {rowlabels \
		       gammierat \
		    gammieratpart0 gammieratpart1 gammieratpart2 gammieratpart3 \
		    gammieratpart4 gammieratpart5 gammieratpart6}
		#
		set itnull=(SUM(gammierat)-gammierat[0])/gammierat[0]
		set it0=(SUM(gammieratpart0)-gammieratpart0[0])/gammieratpart0[0] 
		set it1=(SUM(gammieratpart1)-gammieratpart1[0])/gammieratpart1[0] 
		set it2=(SUM(gammieratpart2)-gammieratpart2[0])/gammieratpart2[0] 
		set it3=(SUM(gammieratpart3)-gammieratpart3[0])/gammieratpart3[0] 
		set it4=(SUM(gammieratpart4)-gammieratpart4[0])/gammieratpart4[0] 
		set it5=(SUM(gammieratpart5)-gammieratpart5[0])/gammieratpart5[0] 
		set it6=(SUM(gammieratpart6)-gammieratpart6[0])/gammieratpart6[0]
		set itall=gammieratpart0[0]+gammieratpart1[0]+gammieratpart2[0] \
		    +gammieratpart3[0]+gammieratpart4[0]+gammieratpart5[0] \
		    +gammieratpart6[0]
		print + $stressfname {itnull it0 it1 it2 it3 it4 it5 it6 itall}
		#
		#
		if($avgtype!=3){\
		 print + $stressfname 'average stress between r=%g to %g and h=%g to %g\n' {prin prout phin phout}
		}
		#
		if($avgtype==3){\
		 print + $stressfname 'average stress between i=%g to %g and j=%g to %g\n' {prin prout phin phout}
		}
		#
		print + $stressfname '%15s %15s %15s %15s %15s %15s %15s %15s %15s\n' \
		    {lnull l0 l1 l2 l3 l4 l5 l6 l7}
		print + $stressfname '%15s %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' \
		    {rowlabels \
		       gammieratavg \
		    gammieratavgpart0 gammieratavgpart1 gammieratavgpart2 gammieratavgpart3 \
		    gammieratavgpart4 gammieratavgpart5 gammieratavgpart6}

		    #print {gammieratavg gammieratavgpart0 gammieratavgpart1 gammieratavgpart2 gammieratavgpart3 gammieratavgpart4 gammieratavgpart5 gammieratavgpart6}
		#
		set itnull=(SUM(gammieratavg)-gammieratavg[0])/gammieratavg[0]
		set it0=(SUM(gammieratavgpart0)-gammieratavgpart0[0])/gammieratavgpart0[0] 
		set it1=(SUM(gammieratavgpart1)-gammieratavgpart1[0])/gammieratavgpart1[0] 
		set it2=(SUM(gammieratavgpart2)-gammieratavgpart2[0])/gammieratavgpart2[0] 
		set it3=(SUM(gammieratavgpart3)-gammieratavgpart3[0])/gammieratavgpart3[0] 
		set it4=(SUM(gammieratavgpart4)-gammieratavgpart4[0])/gammieratavgpart4[0] 
		set it5=(SUM(gammieratavgpart5)-gammieratavgpart5[0])/gammieratavgpart5[0] 
		set it6=(SUM(gammieratavgpart6)-gammieratavgpart6[0])/gammieratavgpart6[0]
		set itall=gammieratavgpart0[0]+gammieratavgpart1[0]+gammieratavgpart2[0] \
		    +gammieratavgpart3[0]+gammieratavgpart4[0]+gammieratavgpart5[0] \
		    +gammieratavgpart6[0]
		print + $stressfname {itnull it0 it1 it2 it3 it4 it5 it6 itall}
		#!scp $stressfname metric:research/papers/bz/
		!cp $stressfname /home/jondata/
		#
		#
		#     0.10739627050729 d/dr(\detg T^r_\this)
		#   -0.782555426137685 d/dh(\detg T^h_\this)
		#  0.00218577738164992 T^t_t \Gamma^t_{\this t}
		#  3.5310934328003e-09 T^t_r \Gamma^r_{\this t}
		#                   -0 T^t_h \Gamma^h_{\this t}
		#  -0.0399823643432649 T^t_p \Gamma^p_{\this t}
		# 0.000585291433623242 T^r_t \Gamma^t_{\this r}
		# 0.000592495824605409 T^r_r \Gamma^r_{\this r}
		#    0.142809050116347 T^r_h \Gamma^h_{\this r}
		#   -0.140382128537898 T^r_p \Gamma^p_{\this r}
		#  -0.0205268989840369 T^h_t \Gamma^t_{\this h}
		#   -0.129407402356466 T^h_r \Gamma^r_{\this h}
		#   -0.260995880515051 T^h_h \Gamma^h_{\this h}
		#  0.00711251635163703 T^h_p \Gamma^p_{\this h}
		#-4.95791588258578e-05 T^p_t \Gamma^t_{\this p}
		# -6.0118657454924e-09 T^p_r \Gamma^r_{\this p}
		#                   -0 T^p_h \Gamma^h_{\this p}
		#     2.11321828089885 T^p_p \Gamma^p_{\this p}
		#
bzplotkink      0 #
		# kink instability
		# Shafranov criterion (Kadomtsev 96; Bateman 78, Freidberg 87)
		set kinkR=r*sin(0.8)
		set kinkr=2*pi*kinkR*sin(h)*B1/(r*B3)
		set kinkr=(kinkr<1) ? 1 : 0
		plc 0 kinkr 001 0 _Rout 0 0.8
		set kinkh=2*pi*kindR*sin(h)*B2/(r*B3)
		plc 0 kinkh
		# B3>B1 unstable in large limit
		set kinklimit=(ABS(B3)>ABS(B1)) ? 0 : 1
		plc 0 kinklimit
		#
		set B3sq=B3**2*gdet
		gcalc2 4 2 0.8 B3sq B3sqvsr
		gcalc2 4 2 0.8 gdet gdetvsr
		der newr it newrd B3sqvsrd
		set hoopstressnorm=-(1/(2))*B3sqvsrd
		pl 0 newrd hoopstressnorm
		#
		define cres 256
		set hoop=B3**2/(rho*r)
		#set hoop=gdet*B3**2/r
		#set hoop=gdet*Tud33EM
		rdraft
		plc 0 hoop
                plc 0 ud0 010
		set lev=-2,-1,.1
		levels lev
                ctype blue contour
		#
		
		plc 0 ud0   # 0 _Rout 0 0.6
		set newfun=ud0
                set myud0=newfun
                #
		define cres 256
		set it=gdet*Tud22EM
		plc 0 it
                set image[ix,iy] = myud0
		set lev=-1.5,-1,0.5
                levels lev
                ctype blue contour
		#
		define cres 20
		set hoop2=lg(B3**2)
		#set hoop2=lg(bu3**2)
		plc 0 hoop2
		#
bzplotfeofm    0 #
		# <fe>/<fm> for gammie
		#
		greaddump dumptavg2040equalize
		#
		# time average of Tud components
		readg42
		#
		# for uncorrelated variables this should be the same
		#stresscalc 1
		#
		gammienew		
		#
		define dh (pi/2)
		define dhname "full"
		define loc (risco)
		#
		# full components
		#gcalc2 3 0 $dh Tud10EM Tud10EMvsrfull
		#gcalc2 3 0 $dh Tud10MA Tud10MAvsrfull
		#
		set mflogdet=mfl/gdet
		gcalc3 $loc $dh mflogdet mflavg 
		print '%21.15g\n' {mflavg}
		gcalc3 $loc $dh Tud10 Tud10avg
		gcalc3 $loc $dh Tud13 Tud13avg
		set demtot=Tud10avg/mflavg
		set dlmtot=Tud13avg/mflavg
		print {mflavg demtot dlmtot}
		#
		gcalc3 $loc $dh Tud10part0 Tud10part0avg
		set dempart0=Tud10part0avg/mflavg
		gcalc3 $loc $dh Tud10part1 Tud10part1avg
		set dempart1=Tud10part1avg/mflavg
		gcalc3 $loc $dh Tud10part2 Tud10part2avg
		set dempart2=Tud10part2avg/mflavg
		gcalc3 $loc $dh Tud10part3 Tud10part3avg
		set dempart3=Tud10part3avg/mflavg
		gcalc3 $loc $dh Tud10part4 Tud10part4avg
		set dempart4=Tud10part4avg/mflavg
		gcalc3 $loc $dh Tud10part5 Tud10part5avg
		set dempart5=Tud10part5avg/mflavg
		gcalc3 $loc $dh Tud10part6 Tud10part6avg
		set dempart6=Tud10part6avg/mflavg
		print {dempart0 dempart1 dempart2 dempart3 dempart4 dempart5 dempart6}
		#
		gammieenerold2
		avglim t dm dmavg 1000 2000
		avglim t de deavg 1000 2000
		set deavgodmavg=deavg/dmavg
		avglim t dl dlavg 1000 2000
		set dlavgodmavg=dlavg/dmavg
		avglim t dem demavg 1000 2000
		avglim t dlm dlmavg 1000 2000
		print {dmavg deavgodmavg dlavgodmavg demavg dlmavg}
		#
		#
		#gcalc2 3 0 pi/2 Tud10part1 Tud10MAvsrfull
		#gcalc2 3 1 pi/2 mfl mflvsrfull
		#
		define x2label "\bar{T^r_t (em)}/\bar{T^r_t (ma)}"
		define x1label "r c^2/(GM)"
		# for dh=pi/2
		#device postencap tud10emmatavgrats.eps
		#device postencap tud10emmatavgrat_dhfull.eps
		#device postencap tud10emmatavgrat_dhfull.eps
		#set ratdhfull=Tud10EMvsrfull/Tud10MAvsrfull
		#ctype default pl 0 newr ratdhfull 0001 (0.98*$rhor) risco -0.3 0
		#
		set ratdhfull=Tud10MAvsrfull/mflvsrfull
		ctype default pl 0 newr ratdhfull 0001 (0.98*$rhor) risco -0.3 0
		#device X11
		# for dh=0.3
		#device postencap tud10emmatavgrat_dh0.3.eps
		#set ratdh3=Tud10EMvsr3/Tud10MAvsr3
		#ctype red pl 0 newr ratdh3 0011 (0.98*$rhor) risco -0.1 0
		#device X11
		# for dh=0.1
		#set ratdh1=Tud10EMvsr1/Tud10MAvsr1
		#device postencap tud10emmatavgrat_dh0.1.eps
		#ctype blue pl 0 newr ratdh1 0011 (0.98*$rhor) risco -0.3 .1
		#device X11
		#device X11
		#
		#
		#
		#
bzplothawleycomp 0 # De Villiers and Hawley comparisons
		gammieenerold2
		jrdp dump0000
		set mass0=SUM(dV*gdet*rho)
		jrdp dump0040
		set mass40=SUM(dV*gdet*rho)
		#
		set omegaorbit=1/(12**(3/2)+a)
		set torbit=2*pi/omegaorbit
		set tnew=t/torbit
		set dmnew=dm/mass0*torbit
		pl 0 tnew dmnew
		avglim tnew dmnew dmnewavg 500 2000
		# -3.52\times 10^{-5} for not per unit orbit
		# -9.41\times 10^{-3} for per unit orbit
		#
		gcalc2 3 2 pi/2 rho rhovsr
		pl 0 newr rhovsr
		#
		# fig 10
		greaddump dumptavg2040equalize
		gammienew
		gcalc2 3 2 pi/2 p pvsr
		set pmag=bsq/2 # uses dump read bsq
		gcalc2 3 2 pi/2 pmag pmagvsr
		ctype default
		ltype 1 pl 0 newr pvsr 0101 $rhor 10 1E-4 1E-2
		ltype 0 pl 0 newr pmagvsr 0110
		#
