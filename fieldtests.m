 0  #
		grid3d gdump  
		set v=sqrt(v1**2*gv311+v2**2*gv322)*1E10
		#
loopenergy 0 #
		#
		jrdp3du dump0000
		stresscalc 1
		set total=SUM( -Tud00EM*gdet*dV*1E20)/SUM(gdet*dV)
		#
		jrdp3du dump0010
		stresscalc 1
		set totalf=SUM( -Tud00EM*gdet*dV*1E20)/SUM(gdet*dV)
		#
		set fracdiff=abs(totalf-total)/abs(total)
		#	
		# Athena: 128 x 64 grid
		set fracdiffathena=(2.83E-8 - 3.35E-8)/(3.35E-8)
                #
                #  128x64 fluxrecon WENO5BND FULL gets 0.1233
                #  256x128 fluxrecon WENO5BND FULL gets 0.06359
                # seems to converge at first order, as required since current loop is infinitely small
		#
		print {total totalf fracdiff fracdiffathena}
		#
		#
circalfcheck1 0 #
		#
		#
		set startanim=0
		set endanim=10
		agplc 'dump' v1 Rin Rout Rin (Rout/2)
		#
		#
		jrdp3du dump0000
		grid3d gdump
		#
		# should be 1 with |sin| variation of 0.1
		set Bp=1E10*sqrt(B1**2*gv311+B2**2*gv322)
		plc 0 Bp
		#
		#
		set Bpar0=1.0
		set alpha0=atan(2.0)
		set Bparx = Bpar0*cos(alpha0)
		set Bxoff = B1*sqrt(gv311)*1E10 - Bparx
		plc 0 Bxoff
		#
		#
		set Bpar0=1.0
		set alpha0=atan(2.0)
		set Bpary = Bpar0*sin(alpha0)
		set Byoff = B2*sqrt(gv322)*1E10 - Bpary
		plc 0 Byoff
		#
		set god=sqrt(Bxoff**2+Byoff**2)
		plc 0 god
		#
		# below correct
		set Bz=1E10*B3*sqrt(gv333)
		plc 0 Bz
		#
		# should be 0 with |sin| variation of 0.1
		# below seems correct
		set Vp=1E10*sqrt(v1**2*gv311+v2**2*gv322)
		plc 0 Vp
		#
		# below seems correct
		set Vz=1E10*v3*sqrt(gv333)
		plc 0 Vz
		#
		#
		#
		jrdp3du dump0000
		grid3d gdump
		jre mode2.m
		trueslowfast
		#
		set myvchar=(v1m*sqrt(gv311)*1E10)
		plc 0 myvchar
		#
		# shows that vchar~1
		#
		set mydx=Rout/$nx
		set mydy=Rout/2/$ny
		#
		print {mydx mydy}
		#
		# implies
		set mydt = mydx/myvchar
		plc 0 mydt
		#
		# which is about .03
		# with courant factor of 0.5 tives .015, as is during simulation
                #
                #
circalfconv 0   #
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		cd ../
		cd run.latestcode.test1102.8x4
		checkstagorder
		#
		cd ..
		cd run.latestcode.test1102.16x8
		checkstagorder
		#
		cd ..
		cd run.latestcode.test1102.32x16
		checkstagorder
		#
		cd ..
		cd run.latestcode.test1102.64x32
		checkstagorder
		#
		cd ..
		cd run.latestcode.test1102.128x64
		checkstagorder
		#
		cd ..
		cd run.latestcode.test1102.256x128
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.8x4
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.16x8
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.32x16
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.64x32
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.128x64
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test1102.256x128
		checkstagorder
		#
		# CIRC POL ALF:
                # FLUXRECON:
		#
		# res     errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		# 8x4     0.0002723     0.06773      0.2828      0.2828      0.7066      0.0316     0.03303     0.07936
		# 16x8    0.002089      0.0595      0.1792      0.1788      0.4679     0.02243     0.02315     0.05676
		# 32x16   0.0001873    0.001303     0.00344    0.003593    0.009314   0.0004236    0.000419    0.001153 # order 5.6 for v3
		# 64x32   0.0002089   0.0003477   0.0002788   0.0007726   0.0005977   2.673e-05   3.301e-05     7.7e-05 # order 4 for v3
		# 64x32   0.0003185   0.0006003   0.0006392    0.001501   0.0007818   4.074e-05   6.764e-05    8.03e-05 # new
		# 128x64  0.0001292   0.0002094    0.000111   0.0004592   0.0001818   7.706e-06    1.97e-05   2.375e-05 # order 0.7 for v2
                # 256x128 5.078e-05   8.354e-05   4.099e-05   0.0001791   7.184e-05   1.897e-06    8.29e-06   8.985e-06 # order 1.4 for v2
		#
		# 8x4 U   0.0005406    0.008304       0.707      0.1768      0.3533      0.0285     0.03334     0.08318
                # 16x8 U  0.007061    0.003357      0.4637      0.1153      0.2368       0.023     0.02301     0.05885
		# 32x16 U 0.0003381   0.0003498     0.01102     0.00312    0.004621   0.0004317   0.0004523    0.001174
		# 32x16 U 0.0007073   0.0005354       0.012     0.00393    0.004769   0.0004117   0.0004585    0.001226 # no divb issue with BOUNDFLUXRECON==1
		# 64x32 U 0.0003185   0.0001656    0.001603   0.0009386   0.0003962   5.434e-05   7.497e-05    7.99e-05 # no divb issue with BOUNDFLUXRECON==1
		#
		# FV:
		# 8x4     6.044e-05     0.06495      0.2827      0.2828      0.7073     0.03076     0.02982     0.07982
		# 16x8    0.0009127     0.06116      0.2178      0.2182      0.5424     0.02597     0.02672     0.06597
                # 32x16   0.0004211    0.002586     0.03309     0.03301     0.09725    0.004067    0.004074     0.01208
                # 64x32   0.0002306   0.0004415    0.007793    0.007853     0.02145   0.0009721   0.0009687     0.00269
		# 128x64  8.866e-05   0.0001537    0.001744    0.001775     0.00431   0.0002297   0.0002291   0.0005675
		#
		#
		# NOENOFLUX TOTH:
		# 32x16   0.001202    0.002758      0.1219      0.1161      0.1108     0.01496     0.01481     0.01341
		#
		# ENOFLUXRECON, FLUXCTHLL:
		# 32x16   0.0002891    0.001367    0.003475    0.003875    0.009532   0.0004252   0.0004288    0.001176
		# 64x32   0.0001036   5.385e-05   0.0001536   0.0003814   0.0003718   1.574e-05   1.574e-05   5.338e-05 #order 4.8 for v3
		# 128x64  2.627e-05   1.439e-05    3.06e-05   9.755e-05   2.632e-05   1.788e-06   1.788e-06   5.035e-06 #order 4 for v3 but order 2 for v2 and v1
		# 128x64  2.627e-05   1.439e-05    3.06e-05   9.755e-05   2.632e-05   1.788e-06   1.788e-06   5.035e-06 #with no limit to change in a2c
		#
		# ENOFINITEVOLUME FLUXCTHLL:
		# 32x16   0.001291     0.00238     0.01799     0.01974     0.04541    0.002242    0.002247    0.005466
		#
		#
		#
		#
		#
		# SMOOTH SOUNDWAVE TEST=33
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		cd ..
		cd run.latestcode.fv.test33.8x4
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test33.16x8
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test33.32x16
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test33.64x32
		checkstagorder
		#
		cd ..
		cd run.latestcode.fv.test33.128x64
		checkstagorder
		#
		#
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		cd ..
		cd run.latestcode.test33.8x4
		checkstagorder
		#
		cd ..
		cd run.latestcode.test33.16x8
		checkstagorder
		#
		cd ..
		cd run.latestcode.test33.32x16
		checkstagorder
		#
		cd ..
		cd run.latestcode.test33.64x32
		checkstagorder
		#
		cd ..
		cd run.latestcode.test33.128x64
		checkstagorder
		#
		#
		#
		#
		# FV:
		# 8x4    1.685e-08   1.004e-15   6.429e-17
		# order 5.2, etc. for higher
		# 16x8   3.618e-09   1.348e-15   2.887e-16
		# 32x16  9.112e-11   1.925e-15   1.746e-16
		# 64x32  2.624e-12   1.467e-15   2.932e-16
		# 128x64 7.931e-14   2.234e-15    3.38e-16   1.579e-15
		#
		# FLUXRECON:
		# 8x4    1.719e-08   6.932e-16           0
		# 16x8   3.056e-09   2.768e-15   1.122e-15   5.041e-15
		# 32x16  9.154e-11   1.082e-15    1.84e-15   3.375e-15
		# 64x32  2.623e-12   9.949e-15   2.322e-15   9.648e-15
		# 128x64 8.171e-14   3.876e-15   3.614e-15   1.407e-14
		#
		# TEST=32 FV: converges fine at order 5.1
		# 32x16  9.191e-11   1.532e-10   0.0007251    0.002885
		# 64x32  2.62e-12   4.365e-12   2.047e-05   8.195e-05
		#
		#
processconserved 0 #
		#
		if(0){\
		set rho=U0
		set u=-U1
		set v1=U2
		set v2=U3
		set v3=U4
		set B1=U5
		set B2=U6
		set B3=U7
		}
		#	
		#
checkstagorder 0 #
		#
		#
		jrdp3du dump0000
                processconserved
                #
		set rhoi=rho
		set ui=u
		set v1i=v1
		set v2i=v2
		set v3i=v3
		set B1i=B1
		set B2i=B2
		set B3i=B3
		#
		ctype default pl 0 r (v1-v1[0])
		#
		set maxv=0.0
		do kk=0,dimen(v1)-1,1{
		  set maxv=(abs(v1[$kk])>maxv) ? abs(v1[$kk]) : maxv
		  set maxv=(abs(v2[$kk])>maxv) ? abs(v2[$kk]) : maxv
		  set maxv=(abs(v3[$kk])>maxv) ? abs(v3[$kk]) : maxv
		}
		#
		set maxb=0.0
		do kk=0,dimen(B1)-1,1{
		  set maxb=(abs(B1[$kk])>maxb) ? abs(B1[$kk]) : maxb
		  set maxb=(abs(B2[$kk])>maxb) ? abs(B2[$kk]) : maxb
		  set maxb=(abs(B3[$kk])>maxb) ? abs(B3[$kk]) : maxb
		}
		#
		set maxrho=0.0
		set maxu=0.0
		do kk=0,dimen(rho)-1,1{
		  set maxrho=(abs(rho[$kk])>maxrho) ? abs(rho[$kk]) : maxrho
		  set maxu=(abs(u[$kk])>maxu) ? abs(u[$kk]) : maxu
		}
		#
		#
		jrdp3du dump0010
                #jrdp3du dump0100
                processconserved
                #
		set rhof=rho
		set uf=u
		set v1f=v1
		set v2f=v2
		set v3f=v3
		set B1f=B1
		set B2f=B2
		set B3f=B3
		#
		ctype red plo 0 r (v1-v1[0])
		#
		set diffv1=abs(v1i-v1f)/maxv
		set errorv1=SUM(diffv1)/dimen(diffv1)
		#
		set diffv2=abs(v2i-v2f)/maxv
		set errorv2=SUM(diffv2)/dimen(diffv2)
		#
		set diffv3=abs(v3i-v3f)/maxv
		set errorv3=SUM(diffv3)/dimen(diffv3)
		#
		#
		set diffB1=abs(B1i-B1f)/maxb
		set errorB1=SUM(diffB1)/dimen(diffB1)
		#
		set diffB2=abs(B2i-B2f)/maxb
		set errorB2=SUM(diffB2)/dimen(diffB2)
		#
		set diffB3=abs(B3i-B3f)/maxb
		set errorB3=SUM(diffB3)/dimen(diffB3)
		#
		set diffrho=abs(rhoi-rhof)/maxrho
		set errorrho=SUM(diffrho)/dimen(diffrho)
		#
		set diffu=abs(ui-uf)/maxu
		set erroru=SUM(diffu)/dimen(diffu)
		#
		print {errorrho erroru errorv1 errorv2 errorv3 errorB1 errorB2 errorB3}
		#
		set maxdiff=diffrho
		set maxdiff=(maxdiff>diffu) ? maxdiff : diffu
		set maxdiff=(maxdiff>diffv1) ? maxdiff : diffv1
		set maxdiff=(maxdiff>diffv2) ? maxdiff : diffv2
		set maxdiff=(maxdiff>diffv3) ? maxdiff : diffv3
		set maxdiff=(maxdiff>diffB1) ? maxdiff : diffB1
		set maxdiff=(maxdiff>diffB2) ? maxdiff : diffB2
		set maxdiff=(maxdiff>diffB3) ? maxdiff : diffB3
		#
		define xinner (r[0])
		define xouter (r[dimen(r)-1])
		define ylower (-maxdiff*2)
		define yupper (maxdiff*2)
		#
		ctype default pl 0 r diffrho 0001 $xinner $xouter $ylower $yupper
		ctype red pl 0 r diffu 0011 $xinner $xouter $ylower $yupper
		ctype cyan pl 0 r diffv1 0011 $xinner $xouter $ylower $yupper
		ctype blue pl 0 r diffv2 0011 $xinner $xouter $ylower $yupper
		ctype green pl 0 r diffv3 0011 $xinner $xouter $ylower $yupper
		ctype yellow pl 0 r diffB1 0011 $xinner $xouter $ylower $yupper
		ctype magenta pl 0 r diffB2 0011 $xinner $xouter $ylower $yupper
		ctype blue pl 0 r diffB3 0011 $xinner $xouter $ylower $yupper
		#
                #
                #
                #
errors 0        #            
		#
		#
		# SLOW WAVE (errors are smooth):
		#
		# 128 STAG NOENOFLUX: 1.028e-10   1.713e-10    0.001616    0.003047    0.001077           0   6.702e-11   7.897e-12
		# 128 TOTH NOENOFLUX: 1.028e-10   1.713e-10    0.001616    0.003047    0.001077           0   6.702e-11   7.897e-12
		# 128 STAG FULLWENO:  2.619e-13   4.349e-11   4.592e-06   8.451e-06   2.983e-06           0   1.741e-11   6.155e-12
		# 128 STAG FULLWENO:  2.616e-13   4.352e-13   4.592e-06   8.439e-06    2.98e-06   5.483e-18   8.698e-14   3.059e-14 #new
		# 128 TOTH FULLWENO:  2.611e-13   4.349e-11   4.587e-06   8.445e-06    2.98e-06   2.303e-16   1.741e-11   6.155e-12
		# 128 STAG FLUXRECON: 2.63e-13    4.359e-13   4.588e-06   8.435e-06   2.977e-06           0   8.783e-14   3.059e-14 #new
                #
		# ALFVEN WAVE (errors are noisy):
		#
		# 128 STAG NOENOFLUX: 2.826e-11   4.709e-11   1.118e-07    0.001593    0.004505           0   1.272e-13    9.99e-11
		# 128 TOTH NOENOFLUX: 2.826e-11   4.709e-11   1.141e-07    0.001593    0.004505           0   1.266e-13    9.99e-11
		# 128 STAG FULLWENO:  9.294e-15   1.531e-14   4.105e-08   2.616e-07   7.264e-07           0   1.375e-11   3.891e-11
                # 128 TOTH FULLWENO:  1.037e-14   1.505e-14   4.094e-08   7.471e-08   1.108e-07   5.691e-16   1.796e-14   4.796e-14 #new
		# 128 TOTH FULLWENO:  9.525e-15   1.526e-14   4.045e-08   2.625e-07   7.254e-07   2.906e-16   1.375e-11   3.891e-11
                # 128 STAG FULLWENO:  1.077e-14    1.58e-14   4.056e-08   7.246e-08   1.134e-07   1.645e-17   1.796e-14   4.828e-14 #new
		# 128 STAG FLUXRECON: 9.23e-15    1.511e-14   4.227e-08   7.984e-08   1.138e-07           0   1.809e-14   4.806e-14 #new
                #
                # 8 STAG FLUXRECON: 1.595e-09   2.918e-09     0.04161      0.1153      0.4682           0   9.063e-08   2.602e-07 # limiting
                # 8 STAG FLUXRECON: 1.986e-09   7.187e-09     0.05771       0.116      0.4185           0   9.195e-08   2.582e-07 # no limiting
                #
		# pure 1D:
		# 32x1  HLL RECON pointB      1.665e-15   1.467e-15   4.864e-09   7.612e-05   0.0002153           0   1.852e-11   5.238e-11
		# 32x2  HLL RECON pointB      2.905e-15   4.882e-15    2.58e-08   8.191e-05   0.0002317           0   1.836e-11   5.192e-11
		# 32x16 HLL RECON pointB      1.499e-15   1.455e-15   4.826e-09   7.646e-05   0.0002163           0   1.853e-11   5.241e-11
		#
		# pure-1D:
		# 32x2  HLL RECON vpotB         9.309e-13   1.517e-12   6.374e-06    0.002875    0.008132           0   1.576e-10   4.455e-10
		# 32x2  HLL RECON vpotB EXTRA2  3.318e-14   5.399e-14   1.672e-07   8.698e-05    0.000246           0   1.811e-11   5.123e-11
		# 32x16 HLL RECON vpotB EXTRA2  1.284e-10   2.139e-10   0.0007005    0.003502    0.009526   2.915e-11   1.094e-10   2.801e-10
		# 32x16 HLL RECON vpotB EXTRA10 1.284e-10   2.139e-10   0.0007005    0.003502    0.009526   2.915e-11   1.094e-10   2.801e-10
		# 
		# 16x8  HLL RECON vpotB       2.115e-10   3.516e-10    0.001076     0.01985     0.05604    8.99e-11   9.431e-10   2.673e-09
		# 32x16 HLL RECON vpotB       7.495e-11   1.246e-10   0.0005458    0.003532    0.009903   2.656e-11   1.082e-10   2.879e-10 # order 2.5 for v3
		# 64x32 HLL RECON vpotB       3.845e-11    6.39e-11    0.000232   0.0007968    0.002146    7.58e-12   2.867e-11   6.469e-11 # order 2.1 for v3
		#
		# pure-1D:
		# 16x8  HLL FV pointB         2.332e-14    1.35e-14   2.755e-08    0.001609    0.004551           0   8.709e-10   2.463e-09
		#
		#
                # order 5.4
                # 32 STAG FLUXRECON 2D 32x32: 6.365e-12   1.021e-11   3.187e-05   7.835e-05   0.0002942   7.332e-15   3.679e-11   1.032e-10
                # dir flipped                 6.354e-12    1.02e-11   7.837e-05   3.184e-05   0.0002941   3.679e-11   5.094e-15   1.032e-10
		# 32x32 STAG FLUXRECON        1.181e-11   2.446e-11   0.0001688    0.001815    0.005174   1.472e-11   5.587e-11   1.649e-10 # latest stag using vector pot -- WTF!
		# 32x32 HLL FLUXRECON         2.046e-10   3.389e-10    0.002012    0.004413     0.01062   5.738e-11   1.199e-10   2.839e-10 # using vector potential at wrong location
                # 32x32 HLL FLUXRECON         1.998e-15   2.384e-15   8.981e-09   7.706e-05    0.000218           0   1.855e-11   5.247e-11 # using point values, not vector potential
		#
		#
		#
		# 32x32 HLL FLUXRECON FULLROT 3.015e-12   5.021e-12   3.186e-05   3.353e-05   0.0002123   1.742e-11   1.718e-11   1.191e-10 # using point values
		#
		# HLL FLUXRECON FULLROT using point fields: (all order 5 -- good!) # vpot field gives similar answer up to 64x32
		# 8x4     1.259e-08   2.112e-08      0.1188      0.1527      0.8091   9.685e-08   1.024e-07   7.197e-07
		# 16x8    5.482e-09   9.812e-09     0.02886     0.03598      0.2358   2.405e-08   2.398e-08   1.711e-07
		# 32x16   4.414e-10   7.356e-10   0.0003672   0.0008508    0.003141   2.338e-10    2.34e-10   2.051e-09
		# 64x32   7.744e-12    1.29e-11   9.871e-06   2.877e-05   8.106e-05    6.52e-12   6.179e-12   4.273e-11
		# 128x64  1.927e-13   3.142e-13   2.589e-07   8.601e-07    1.92e-06   1.538e-13   1.361e-13   9.154e-13
		# 256x128 9.267e-13    1.53e-12   1.773e-06   6.484e-06   4.268e-06   6.443e-13   2.075e-13   1.715e-13 # all good except this one -- divb?
		#
		# HLL FINITEVOLUME FULLROT using vpot or points are similar (UNSPLIT and QUASISTRANG same): (converges at roughly second order!)
		# 8x4     9.501e-09   1.615e-08      0.1017       0.137      0.7226   8.395e-08   8.802e-08    6.29e-07
		# 16x8    6.526e-09   1.092e-08     0.03931     0.04028       0.262   2.276e-08   2.227e-08   1.585e-07
		# 32x16   6.48e-10   1.081e-09    0.008036    0.008574     0.05611   5.842e-10   5.723e-10   3.511e-09
		# 64x32   1.576e-10   2.625e-10    0.002001    0.001974     0.01324   2.276e-10   1.855e-10   1.227e-09
		# 128x64  6.335e-11   1.055e-10    0.000659    0.000547    0.003294   9.989e-11   5.402e-11   3.437e-10
		#
		# FAST WAVE (errors are smooth):
		#
		# 128 STAG NOENOFLUX: 1.832e-10   3.053e-10    0.003626    0.003419    0.001209           0    1.34e-10   6.318e-11
		# 128 TOTH NOENOFLUX: 1.832e-10   3.053e-10    0.003626    0.003419    0.001209           0    1.34e-10   6.318e-11
		# 128 STAG FULLWENO:  1.431e-12   8.701e-11   1.507e-05   2.681e-05   9.477e-06           0   3.482e-11   1.231e-11
                # 128 STAG FULLLWENO: 1.432e-12   1.495e-12   1.507e-05    2.68e-05   9.474e-06           0   1.825e-13   6.421e-14 #new
		# 128 TOTH FULLWENO:  1.432e-12   8.701e-11   1.507e-05   2.681e-05   9.477e-06   2.029e-16   3.482e-11   1.231e-11
                # 128 STAG FLUXRECON: 1.433e-12   1.494e-12   1.507e-05    2.68e-05   9.476e-06           0    1.82e-13   6.428e-14
		# 128 STAG FLUXRECON: 1.432e-12   1.495e-12   1.507e-05    2.68e-05   9.475e-06           0   1.822e-13   6.424e-14 #new
                #
                #
                #
		# BELOW ARE FOR ALFVEN WAVE:
		#
		# all methods are 4-5th order?
		#
		# below for amplitude=1E-6
		# 0.4335 for NXTEST=8 for STAG FULLWENO
		# 0.2302 for NXTEST=8 for TOTH FULLWENO
		#
		# set god=0.4335*(8/128)**5 print {god}
		# 4.134e-07
		#
		# set god=0.2*(8/16)**5 print {god}
		#0.00625
		#
		# below for amplitude=1E-6
		# 0.007598 for 16 for STAG FULLWENO
		# 0.007598 for 16 for TOTH FULLWENO
		#
		# set god=0.4*(8/32)**5 print {god}
		#0.0003906
		#
		# 0.0004899 for 32 for STAG FULLWENO
		#
		#
		# below for amplitude=1E-6
		# 2.225e-07 for 128 for TOTH FULLWENO
		# 2.258e-07 for 128 for STAG FULLWENO
		#
		# below for amplitude=1E-6
		# 6.151e-07 for 128 for STAG NOENOFLUX
		# 6.277e-07 for 128 for TOTH NOENOFLUX
		#
		# below for amplitude=1E-6
		# 2.131e-07 for 1024 for STAG FULLWENO
		# 2.236e-07 for 1024 for TOTH FULLWENO
		#
		# below for amplitude=3E-8
		# 2.887e-06 for 1024 for STAG FULLWENO
		# 3.144e-06 for 1024 for TOTH FULLWENO
		#
		#1.333e-06 (new stag fullweno 128)
		#1.243e-06 (new toth fullweno 128)
		#
		#
		# FIELDLOOPBOOST==2
		#
		# B3 rises at first and then declines as field loop expands due to DONOR
		#
		# DONOR TO2 TOTH nonlinearcs1=1 and boostvel=1
		# B3: -1.157705177e-16 max:1.157705177e-16 at final time :: B3.donor.to2.boost2.vel1.eps
		#
		# DONOR TO2 TOTH nonlinearcs1=1 and boostvel=1E3
		# B1/B2 are 6E-15/1E-14 at final time
		# B3:  +-5E-13 dump=1 and final: +-1E-13 :: B3.donor.to2.boost2.vel1e3.eps
		#
		# DONOR TO2 TOTH nonlinearcs1=1 and boostvel=1E3
		# B1/B2 are 2E-15/5E-15 at final time
		# B3: -1.821552553e-25 max:1.820839374e-25 :: B3.donor.to2.boost2.vel1e3.eps
		# 
		# WENO5BND TO4 TOTH FVbutavgDONOR vel=1 boost=1E3
		# B1/B2 are 4E-14/6E-14
		# B3: 1E-11 at final time (dominates pressure!!!!)
		#
		# WENO5BND TO4 STAG FVbutavgDONOR vel=1 boost=1E3
		# B1/B2 are 4E-14/6E-14
		# B3: 3E-24 at final time
		#
		#
2dwaveprob 0    #
		jrdp3du dump0000
		set v1pot=v1
		set v2pot=v2
		set v3pot=v3
		set B1pot=B1
		set B2pot=B2
		set B3pot=B3
		set rhopot=rho
		set upot=u
		#
		#
		jrdp3du dump0000
		set v1nopot=v1
		set v2nopot=v2
		set v3nopot=v3
		set B1nopot=B1
		set B2nopot=B2
		set B3nopot=B3
		set rhonopot=rho
		set unopot=u
		#
compare1d 0    #
		jrdp3du dump0000
		set v1i=v1
		set v2i=v2
		set v3i=v3
		set B1i=B1
		set B2i=B2
		set B3i=B3
		set rhoi=rho
		set ui=u
		#
		#
		jrdp3du dump0001
		set v1f=v1
		set v2f=v2
		set v3f=v3
		set B1f=B1
		set B2f=B2
		set B3f=B3
		set rhof=rho
		set uf=u
		#
                plc 0 (v1f-v1i)
                #
                ctype default pl 0 r (rhoi-1)
                ctype red plo 0 r (rhof-1)
                set diff=(rhof-rhoi)*1E5
                ctype blue plo 0 r diff
		#
                #
new1dtests 0    #
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		#
		#
		cd makedir.test1103.fluxreconfull.fluxcthll.4x1
		cd makedir.test1103.fluxreconfull.fluxcthll.8x1 
		cd makedir.test1103.fluxreconfull.fluxcthll.16x1 
		cd makedir.test1103.fluxreconfull.fluxcthll.32x1 
		cd makedir.test1103.fluxreconfull.fluxcthll.64x1 
		cd makedir.test1103.fluxreconfull.fluxcthll.128x1 
		cd makedir.test1103.fluxreconfull.fluxcthll.256x1
		#
		cd makedir.test1103.fluxreconfull.fluxcthll.8x4slab1d 
		cd makedir.test1103.fluxreconfull.fluxcthll.16x8slab1d 
		cd makedir.test1103.fluxreconfull.fluxcthll.32x16slab1d 
		cd makedir.test1103.fluxreconfull.fluxcthll.64x32slab1d 
		cd makedir.test1103.fluxreconfull.fluxcthll.128x64slab1d 
		cd makedir.test1103.fluxreconfull.fluxcthll.256x128slab1d
		#
		cd makedir.test1103.fluxreconfull.fluxcthll.8x4full2d 
		cd makedir.test1103.fluxreconfull.fluxcthll.16x8full2d 
		cd makedir.test1103.fluxreconfull.fluxcthll.32x16full2d 
		cd makedir.test1103.fluxreconfull.fluxcthll.64x32full2d 
		cd makedir.test1103.fluxreconfull.fluxcthll.128x64full2d 
		cd makedir.test1103.fluxreconfull.fluxcthll.256x128full2d 
		#
		cd run
		checkstagorder
		#
		# 5th order convergence for dominant error
		#makedir.test1103.fluxreconfull.fluxcthll.4x1
		# 0   5.512e-13    9.51e-10      0.3421      0.9675           0   1.617e-07   4.573e-07
		#makedir.test1103.fluxreconfull.fluxcthll.8x1
		# 1.944e-13   4.678e-13    4.93e-08     0.08236      0.2329           0   5.073e-08   1.435e-07
		#makedir.test1103.fluxreconfull.fluxcthll.16x1
		# 2.661e-14   9.017e-14   1.709e-09    0.001958    0.005537           0    1.28e-09   3.621e-09
		#makedir.test1103.fluxreconfull.fluxcthll.32x1
		# 1.628e-15   2.464e-15   7.613e-10   4.839e-05   0.0001369           0   3.211e-11   9.081e-11
		#makedir.test1103.fluxreconfull.fluxcthll.64x1
		# 2.254e-15    2.16e-15    8.83e-10   1.915e-06   5.418e-06           0   1.276e-12   3.608e-12
		#makedir.test1103.fluxreconfull.fluxcthll.128x1
		# 3.157e-15   2.109e-15   7.599e-10    6.45e-08   1.822e-07           0   4.236e-14   1.215e-13
		#makedir.test1103.fluxreconfull.fluxcthll.256x1
		# 8.405e-15   3.871e-15   1.602e-09   3.727e-09   5.983e-09           0   1.912e-15   3.954e-15
		#
		# 2nd order convergence for dominant error till 128x64 when suddenly improves to near what should be
		# instability develops
		#makedir.test1103.fluxreconfull.fluxcthll.8x4slab1d
		# 4.156e-09   6.995e-09    0.008327     0.07077      0.2075    2.11e-09   4.553e-08   1.281e-07
		#makedir.test1103.fluxreconfull.fluxcthll.16x8slab1d
		# 3.699e-10   6.169e-10   0.0005644    0.003545    0.009697   1.572e-10    2.25e-09   6.352e-09
		#makedir.test1103.fluxreconfull.fluxcthll.32x16slab1d
		# 1.475e-10   2.455e-10   0.0001687    0.000765    0.002122   5.129e-11   5.016e-10   1.404e-09
		#makedir.test1103.fluxreconfull.fluxcthll.64x32slab1d
		# 9.594e-11   1.604e-10   9.517e-05   0.0002037    0.000472   1.372e-11   1.162e-10   3.149e-10
		#makedir.test1103.fluxreconfull.fluxcthll.128x64slab1d
		# 8.947e-14   1.201e-13   4.101e-08   1.038e-07   1.899e-07   1.631e-14   6.008e-14   1.254e-13
		#makedir.test1103.fluxreconfull.fluxcthll.256x128slab1d
		#7.35e-12   1.223e-11   7.248e-06    1.16e-05   1.277e-05   1.181e-12    4.58e-12    8.01e-12
                #
		# 5th order for dominant error
		#makedir.test1103.fluxreconfull.fluxcthll.8x4full2d
		# 4.423e-08   7.457e-08     0.07862     0.09822      0.6084   8.852e-08   9.612e-08   7.027e-07
		#makedir.test1103.fluxreconfull.fluxcthll.16x8full2d
		# 2.22e-08   3.702e-08       0.015     0.01813     0.09411   9.213e-09   1.434e-08   1.162e-07
		#makedir.test1103.fluxreconfull.fluxcthll.32x16full2d
		# 2.867e-10   4.793e-10   0.0004024   0.0004415    0.002879   5.107e-10   5.141e-10    3.55e-09
		#makedir.test1103.fluxreconfull.fluxcthll.64x32full2d
		# 5.882e-12   9.789e-12   1.123e-05   1.153e-05   7.978e-05   1.391e-11   1.395e-11   9.833e-11
		#makedir.test1103.fluxreconfull.fluxcthll.128x64full2d # no boundary effects
		# 2.501e-13   3.939e-13   3.652e-07   4.472e-07   2.545e-06   4.731e-13     4.5e-13    3.13e-12
 		#makedir.test1103.fluxreconfull.fluxcthll.256x128full2d # no longer converges and actually diverges
		#8.02e-12   1.333e-11    2.53e-06   9.245e-06    6.07e-06   5.133e-12   1.846e-12   1.602e-12
                #
                #
new1dtests 0    # STAG FLUXRECON ALFVEN
		#
                #
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103.fluxreconfull.fluxctstag.4x1
		cd makedir.test1103.fluxreconfull.fluxctstag.8x1 
		cd makedir.test1103.fluxreconfull.fluxctstag.16x1 
		cd makedir.test1103.fluxreconfull.fluxctstag.32x1 
		cd makedir.test1103.fluxreconfull.fluxctstag.64x1 
		cd makedir.test1103.fluxreconfull.fluxctstag.128x1 
		cd makedir.test1103.fluxreconfull.fluxctstag.256x1
		#
		cd makedir.test1103.fluxreconfull.fluxctstag.8x4slab1d 
		cd makedir.test1103.fluxreconfull.fluxctstag.16x8slab1d 
		cd makedir.test1103.fluxreconfull.fluxctstag.32x16slab1d 
		cd makedir.test1103.fluxreconfull.fluxctstag.64x32slab1d 
		cd makedir.test1103.fluxreconfull.fluxctstag.128x64slab1d 
		cd makedir.test1103.fluxreconfull.fluxctstag.256x128slab1d
		#
		cd makedir.test1103.fluxreconfull.fluxctstag.8x4full2d 
		cd makedir.test1103.fluxreconfull.fluxctstag.16x8full2d 
		cd makedir.test1103.fluxreconfull.fluxctstag.32x16full2d 
		cd makedir.test1103.fluxreconfull.fluxctstag.64x32full2d 
		cd makedir.test1103.fluxreconfull.fluxctstag.128x64full2d 
		cd makedir.test1103.fluxreconfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
		#
                #
		#makedir.test1103.fluxreconfull.fluxctstag.4x1
		# 0   5.521e-13   7.655e-10      0.3423       0.968           0   1.624e-07   4.593e-07
		#makedir.test1103.fluxreconfull.fluxctstag.8x1
		# 2.461e-13    5.56e-13   4.969e-07     0.08334      0.2357           0   4.941e-08   1.398e-07
		#makedir.test1103.fluxreconfull.fluxctstag.16x1
		# 8.751e-14   2.374e-13   9.829e-08    0.001908    0.005397           0   1.313e-09   3.714e-09
		#makedir.test1103.fluxreconfull.fluxctstag.32x1
		# 9.622e-16   2.975e-15   3.418e-10   4.846e-05   0.0001371           0   3.214e-11   9.091e-11
                # SPLITMAEM:
                # 1.453e-15   2.201e-15   2.565e-09   9.699e-06   2.743e-05           0   6.434e-12    1.82e-11
		#makedir.test1103.fluxreconfull.fluxctstag.64x1
		# 1.708e-15   2.208e-15   1.177e-09    1.91e-06   5.402e-06           0   1.276e-12    3.61e-12
                # SPLITMAEM:
                # 4.292e-15   3.654e-15   1.497e-09   3.149e-07   8.914e-07           0   2.099e-13   5.935e-13
		#makedir.test1103.fluxreconfull.fluxctstag.128x1
		# 2.138e-15   2.947e-15   9.486e-10   6.452e-08   1.821e-07           0   4.241e-14   1.215e-13
                # SPLITMAEM:
                # 2.905e-15   2.854e-15   9.213e-10   9.684e-09   2.531e-08           0    6.63e-15   1.695e-14
		#makedir.test1103.fluxreconfull.fluxctstag.256x1
		# 7.179e-15   4.401e-15   1.515e-09   3.683e-09   6.134e-09           0   1.987e-15   3.822e-15
                # SPLITMAEM:
		# 7.806e-15   4.048e-15   1.928e-09   2.122e-09   1.148e-09           0   1.072e-15   8.353e-16
		#
		#
		#makedir.test1103.fluxreconfull.fluxctstag.8x4slab1d
		# 6.842e-10   1.239e-09    0.001074     0.07772      0.2201   4.672e-10   4.997e-08   1.419e-07
		#makedir.test1103.fluxreconfull.fluxctstag.16x8slab1d
		# 3.155e-11   1.081e-10   7.903e-05    0.002197    0.006226   3.879e-11   1.343e-09   3.791e-09
		#makedir.test1103.fluxreconfull.fluxctstag.32x16slab1d
		# 1.156e-11   2.754e-11   2.381e-05   0.0003209   0.0009064    1.48e-11   2.184e-10   6.217e-10
		#makedir.test1103.fluxreconfull.fluxctstag.64x32slab1d
		# 2.702e-12   6.499e-12   7.814e-06   7.063e-05   0.0001985   4.882e-12   5.487e-11   1.543e-10
		#makedir.test1103.fluxreconfull.fluxctstag.128x64slab1d
		# 1.2e-13   1.725e-13   2.562e-08   8.387e-08   1.827e-07   1.473e-14   6.819e-14   1.227e-13
		#makedir.test1103.fluxreconfull.fluxctstag.256x128slab1d
		# 2.862e-13   3.875e-13   5.725e-08   8.298e-08   3.096e-08   3.754e-14   8.642e-14   2.745e-14
		#
		#makedir.test1103.fluxreconfull.fluxctstag.8x4full2d
		# 2.56e-08   4.507e-08     0.08903     0.09363      0.6238   1.059e-07   1.115e-07   7.096e-07
		#makedir.test1103.fluxreconfull.fluxctstag.16x8full2d
		# 3.409e-09   1.191e-08      0.0184     0.01583     0.09794   1.805e-08   2.022e-08   1.199e-07
		#makedir.test1103.fluxreconfull.fluxctstag.32x16full2d
		# 1.308e-10   2.544e-10   0.0004306   0.0004532     0.00302   5.433e-10    5.36e-10   3.702e-09
		#makedir.test1103.fluxreconfull.fluxctstag.64x32full2d
                # 1.481e-12   2.462e-12   1.887e-06   1.994e-06   1.332e-05   2.406e-12   2.406e-12    1.64e-11
		#makedir.test1103.fluxreconfull.fluxctstag.128x64full2d
		# OLD: 1.305e-12   2.095e-12   5.204e-07   8.684e-07   2.756e-06   6.963e-13   5.482e-13   3.278e-12
		# longdouble test shows machine precision issue, not code issue and difficult to remove initial sin() non-periodicity near machine error
                # still effect on density, but minor and at this level can be due to divb and imperfect periodicity of initial wave at machine level
                # 5.234e-14   7.769e-14   5.924e-08   6.152e-08   4.187e-07   7.491e-14   7.538e-14   5.154e-13
 		#makedir.test1103.fluxreconfull.fluxctstag.256x128full2d
                # 3.581e-14   3.779e-14   3.468e-09   7.976e-09   1.409e-08   1.079e-14   2.222e-14   1.656e-14
		#
new1dtestssmono 0    # STAG FLUXRECON SMONO ALFVEN
		#
                #
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.4x1
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.8x1 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.16x1 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.32x1 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.64x1 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.128x1 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.256x1
		#
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.8x4slab1d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.16x8slab1d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.32x16slab1d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.64x32slab1d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.128x64slab1d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.256x128slab1d
		#
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.8x4full2d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.16x8full2d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.32x16full2d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.64x32full2d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.128x64full2d 
		cd makedir.test1103.fluxreconfullsmono.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
		#
                #
		#makedir.test1103.fluxreconfullsmono.fluxctstag.4x1
		# 0   5.554e-13    2.41e-10      0.3464      0.9798           0   1.633e-07    4.62e-07
		#makedir.test1103.fluxreconfullsmono.fluxctstag.8x1
		# 9.29e-13   1.624e-12   7.378e-07     0.06703      0.1896           0   4.258e-08   1.204e-07
		#makedir.test1103.fluxreconfullsmono.fluxctstag.16x1
		# 1.531e-14   8.623e-14   3.298e-09    0.000471    0.001332           0    3.08e-10   8.711e-10
		#makedir.test1103.fluxreconfullsmono.fluxctstag.32x1
		# 6.964e-16   1.702e-15   5.861e-10   9.702e-06   2.744e-05           0   6.438e-12   1.821e-11
		#makedir.test1103.fluxreconfullsmono.fluxctstag.64x1
		# 1.448e-15   1.274e-15    7.45e-10   3.148e-07   8.915e-07           0   2.103e-13   5.935e-13
		#makedir.test1103.fluxreconfullsmono.fluxctstag.128x1
		# 2.708e-15   2.954e-15   1.079e-09   8.901e-09    2.55e-08           0   6.459e-15   1.686e-14
		#makedir.test1103.fluxreconfullsmono.fluxctstag.256x1
		# 8.442e-15   4.291e-15   1.747e-09   2.631e-09   1.261e-09           0   9.032e-16   7.516e-16
		#
		#
		#
		#makedir.test1103.fluxreconfullsmono.fluxctstag.8x4slab1d
		# 1.039e-10   2.019e-10   0.0008869     0.06252       0.177   1.057e-12   3.856e-08   1.091e-07
		#makedir.test1103.fluxreconfullsmono.fluxctstag.16x8slab1d
		# 3.745e-13   6.392e-13   4.275e-09   0.0004701     0.00133   2.974e-16   3.073e-10   8.695e-10
		#makedir.test1103.fluxreconfullsmono.fluxctstag.32x16slab1d
		# 9.247e-15   1.456e-14    3.18e-09     9.7e-06   2.744e-05   4.216e-16   6.433e-12    1.82e-11
		#makedir.test1103.fluxreconfullsmono.fluxctstag.64x32slab1d
		# 3.003e-14   4.522e-14    9.45e-09   3.153e-07   8.913e-07    2.39e-15   2.101e-13   5.935e-13
		#makedir.test1103.fluxreconfullsmono.fluxctstag.128x64slab1d
		# 1.185e-13   1.699e-13   2.459e-08   3.754e-08    2.73e-08   1.309e-14   3.823e-14   1.974e-14
		#makedir.test1103.fluxreconfullsmono.fluxctstag.256x128slab1d
		# 2.667e-13   3.663e-13   4.115e-08   5.986e-08   2.125e-08   3.295e-14   7.836e-14   2.494e-14
		#
		#makedir.test1103.fluxreconfullsmono.fluxctstag.8x4full2d
		# 2.786e-08   3.736e-08     0.08429     0.09165      0.6278   1.047e-07   1.083e-07   7.092e-07
		#makedir.test1103.fluxreconfullsmono.fluxctstag.16x8full2d
		# 3.685e-09   1.376e-08     0.01798     0.01129     0.08658   1.551e-08    1.82e-08    1.04e-07
		#makedir.test1103.fluxreconfullsmono.fluxctstag.32x16full2d
		# 5.464e-11   9.774e-11   9.247e-05   0.0001011   0.0006487   1.193e-10   1.188e-10   7.964e-10
		#makedir.test1103.fluxreconfullsmono.fluxctstag.64x32full2d
                # 1.481e-12   2.462e-12   1.887e-06   1.994e-06   1.332e-05   2.406e-12   2.406e-12    1.64e-11
		#makedir.test1103.fluxreconfullsmono.fluxctstag.128x64full2d
		# 5.205e-14   7.704e-14   5.926e-08   6.152e-08   4.186e-07   7.484e-14   7.515e-14   5.153e-13
 		#makedir.test1103.fluxreconfullsmono.fluxctstag.256x128full2d
                #
		#
new1dtestssmono 0    # STAG FLUXRECON SPLITMAEM ALFVEN
		#
                #
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.4x1
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x1 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x1 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x1 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x1 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x1 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x1
		#
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x4slab1d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x8slab1d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x16slab1d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x32slab1d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x64slab1d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x128slab1d
		#
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x4full2d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x8full2d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x16full2d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x32full2d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x64full2d 
		cd makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
		#
                #
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.4x1
		# 0   5.545e-13   4.735e-10      0.3453      0.9767           0   1.622e-07   4.587e-07
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x1
		# 6.01e-12       1e-11   5.347e-06     0.06867      0.1942           0    4.26e-08   1.205e-07
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x1
		# 1.249e-14   8.466e-14   4.764e-09   0.0004701     0.00133           0   3.074e-10   8.696e-10
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x1
		# 1.151e-15   1.652e-15   4.648e-10   9.701e-06   2.744e-05           0   6.437e-12   1.821e-11
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x1
		# 1.693e-15   1.999e-15   7.374e-10   3.148e-07   8.913e-07           0   2.099e-13   5.934e-13
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x1
		# 2.208e-15   2.729e-15   9.903e-10    9.28e-09   2.557e-08           0   6.499e-15   1.695e-14
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x1
		# 7.806e-15   4.048e-15   1.928e-09   2.122e-09   1.148e-09           0   1.072e-15   8.353e-16
		#
		#
		#
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x4slab1d
		# 1.503e-10   2.375e-10   0.0001657     0.07453      0.2107   4.508e-11   4.546e-08   1.286e-07
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x8slab1d
		# 3.736e-13   6.351e-13   5.603e-09   0.0004693    0.001327   2.034e-15   3.068e-10   8.681e-10
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x16slab1d
		# 8.379e-15    1.33e-14   2.301e-09     9.7e-06   2.744e-05   4.083e-16   6.433e-12    1.82e-11
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x32slab1d
		# 3.021e-14   4.413e-14   8.896e-09   3.154e-07   8.912e-07   2.417e-15     2.1e-13   5.934e-13
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x64slab1d
		# 1.04e-13   1.429e-13   2.001e-08   3.067e-08   2.692e-08   1.117e-14   3.283e-14   1.894e-14
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x128slab1d
		# 2.514e-13   3.373e-13   3.867e-08   5.638e-08   2.004e-08    3.01e-14   7.263e-14   2.295e-14
		#
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.8x4full2d
		# 2.718e-08   3.358e-08     0.08092     0.08486      0.6135    1.02e-07   1.047e-07   6.916e-07
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.16x8full2d
		# 6.338e-09   2.252e-08     0.02189     0.01834      0.1159   1.966e-08   2.299e-08   1.303e-07
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.32x16full2d
		# 3.789e-10   6.472e-10   9.725e-05   0.0001912   0.0005985   1.975e-10   1.964e-10   7.286e-10
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.64x32full2d
                # 9.184e-11    1.53e-10   1.803e-05   3.228e-05   2.086e-05   2.737e-11   2.436e-11   1.349e-11
		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.128x64full2d
		# 2.454e-11   4.099e-11   5.431e-06   1.075e-05   7.486e-06   6.624e-12   5.984e-12   5.553e-12
 		#makedir.test1103.fluxreconfullssplitmaem.fluxctstag.256x128full2d
                # 7.593e-12    1.27e-11    1.74e-06    3.56e-06   2.598e-06   2.155e-12   1.651e-12   1.804e-12
		#
		#
new1dtestsfrfast 0    #
		# FAST FLUXRECON CTHLL
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fluxreconfull.fluxcthll.4x1
		cd makedir.test1103fast.fluxreconfull.fluxcthll.8x1 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.16x1 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.32x1 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.64x1 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.128x1 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.256x1
		#
		cd makedir.test1103fast.fluxreconfull.fluxcthll.8x4slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.16x8slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.32x16slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.64x32slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.128x64slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.256x128slab1d
		#
		cd makedir.test1103fast.fluxreconfull.fluxcthll.8x4full2d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.16x8full2d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.32x16full2d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.64x32full2d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.128x64full2d 
		cd makedir.test1103fast.fluxreconfull.fluxcthll.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# 5th order up to some point where error is order amplitude so probably non-linear steepening
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fluxreconfull.fluxcthll.4x1
                # 2.737e-07   4.561e-07      0.8654      0.4079      0.1442           0   3.649e-07    1.29e-07
		#makedir.test1103fast.fluxreconfull.fluxcthll.8x1
		# 6.654e-08   1.109e-07      0.1611     0.07592     0.02684           0   8.873e-08   3.137e-08
		#makedir.test1103fast.fluxreconfull.fluxcthll.16x1
		# 1.497e-09   2.494e-09    0.003413    0.001609   0.0005688           0   1.996e-09   7.057e-10
		#makedir.test1103fast.fluxreconfull.fluxcthll.32x1
		# 3.775e-11   6.291e-11   8.558e-05   4.069e-05   1.439e-05           0   5.108e-11   1.806e-11
		#makedir.test1103fast.fluxreconfull.fluxcthll.64x1
		# 2.074e-12   3.458e-12   3.614e-06   2.095e-06   7.408e-07           0   2.234e-12   7.895e-13
		#makedir.test1103fast.fluxreconfull.fluxcthll.128x1
		# 1.191e-12   1.987e-12    1.38e-06   1.305e-06   4.614e-07           0   7.992e-13   2.824e-13
		#makedir.test1103fast.fluxreconfull.fluxcthll.256x1
		# 1.183e-12    1.97e-12   1.362e-06   1.272e-06   4.497e-07           0   7.928e-13   2.804e-13
		#
		#makedir.test1103fast.fluxreconfull.fluxcthll.8x4slab1d
		# 6.203e-08   1.034e-07        0.15     0.07069     0.02499   6.943e-15   8.267e-08   2.926e-08
		#makedir.test1103fast.fluxreconfull.fluxcthll.16x8slab1d
		# 1.497e-09   2.494e-09    0.003413    0.001609   0.0005689   5.928e-16   1.996e-09   7.062e-10
		#makedir.test1103fast.fluxreconfull.fluxcthll.32x16slab1d
		# 2.08e-12   3.469e-12   3.614e-06   2.136e-06    7.55e-07   1.584e-15   2.235e-12   7.902e-13
		#makedir.test1103fast.fluxreconfull.fluxcthll.64x32slab1d
		# 1.194e-12   1.989e-12   1.378e-06    1.31e-06   4.631e-07   9.369e-15   7.999e-13   2.827e-13
		#makedir.test1103fast.fluxreconfull.fluxcthll.128x64slab1d
		# 1.188e-12   1.979e-12   1.363e-06   1.275e-06    4.51e-07   4.184e-14   7.938e-13   2.805e-13
		#makedir.test1103fast.fluxreconfull.fluxcthll.256x128slab1d
		# 1.188e-12   1.979e-12   1.363e-06   1.275e-06    4.51e-07   4.184e-14   7.938e-13   2.805e-13
		#
		#makedir.test1103fast.fluxreconfull.fluxcthll.8x4full2d
		# 1.57e-07   2.607e-07         0.3     0.03176     0.07885   1.244e-07   1.194e-07   1.073e-07
		#makedir.test1103fast.fluxreconfull.fluxcthll.16x8full2d
		# 1.281e-08   2.155e-08     0.02897    0.005105    0.008625   1.654e-08   1.655e-08    1.38e-08
		#makedir.test1103fast.fluxreconfull.fluxcthll.32x16full2d
		# 6.154e-10   1.026e-09    0.001169   0.0001076    0.000237   4.992e-10   4.924e-10   4.384e-10
		#makedir.test1103fast.fluxreconfull.fluxcthll.64x32full2d
		# 1.618e-11   2.697e-11   3.391e-05   2.172e-06   6.904e-06   1.493e-11   1.486e-11   1.331e-11
		#makedir.test1103fast.fluxreconfull.fluxcthll.128x64full2d
		# 1.439e-12   2.398e-12   2.013e-06   6.196e-07   4.939e-07   9.468e-13   9.465e-13    8.39e-13
 		#makedir.test1103fast.fluxreconfull.fluxcthll.256x128full2d 
		# 3.107e-12   5.178e-12   1.344e-06   1.727e-06   1.206e-06   1.595e-12   9.724e-13   8.003e-13
		#
                #
new1dtestsfrstagfast 0    #
		# FAST WAVES STAG FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fluxreconfull.fluxctstag.4x1
		cd makedir.test1103fast.fluxreconfull.fluxctstag.8x1 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.16x1 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.32x1 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.64x1 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.128x1 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.256x1
		#
		cd makedir.test1103fast.fluxreconfull.fluxctstag.8x4slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.16x8slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.32x16slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.64x32slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.128x64slab1d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.256x128slab1d
		#
		cd makedir.test1103fast.fluxreconfull.fluxctstag.8x4full2d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.16x8full2d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.32x16full2d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.64x32full2d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.128x64full2d 
		cd makedir.test1103fast.fluxreconfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fluxreconfull.fluxctstag.4x1
                # 2.739e-07   4.562e-07      0.8657       0.407      0.1439           0   3.648e-07    1.29e-07
		#makedir.test1103fast.fluxreconfull.fluxctstag.8x1
		# 6.396e-08   1.078e-07      0.1556     0.07346     0.02597           0   8.562e-08   3.027e-08
		#makedir.test1103fast.fluxreconfull.fluxctstag.16x1
		# 1.496e-09   2.494e-09    0.003413    0.001609   0.0005688           0   1.996e-09   7.058e-10
		#makedir.test1103fast.fluxreconfull.fluxctstag.32x1
		# 3.775e-11   6.291e-11   8.558e-05   4.069e-05   1.439e-05           0   5.108e-11   1.806e-11
		#makedir.test1103fast.fluxreconfull.fluxctstag.64x1
		# 2.075e-12   3.458e-12   3.614e-06   2.095e-06   7.408e-07           0   2.233e-12   7.894e-13
		#makedir.test1103fast.fluxreconfull.fluxctstag.128x1
		# 1.191e-12   1.986e-12    1.38e-06   1.305e-06   4.615e-07           0   7.987e-13   2.823e-13
		#makedir.test1103fast.fluxreconfull.fluxctstag.256x1
		# 1.182e-12    1.97e-12   1.362e-06   1.272e-06   4.497e-07           0   7.926e-13   2.803e-13
		#
		#makedir.test1103fast.fluxreconfull.fluxctstag.8x4slab1d
		#  6.3e-08    1.06e-07      0.1485     0.06822     0.02411   1.003e-14   8.375e-08   2.963e-08
		#makedir.test1103fast.fluxreconfull.fluxctstag.16x8slab1d
		# 1.497e-09   2.494e-09    0.003413    0.001609   0.0005689   7.886e-16   1.996e-09   7.062e-10
		#makedir.test1103fast.fluxreconfull.fluxctstag.32x16slab1d
		# 3.792e-11   6.321e-11   8.593e-05   4.088e-05   1.445e-05   1.619e-15   5.122e-11   1.811e-11
		#makedir.test1103fast.fluxreconfull.fluxctstag.64x32slab1d
		# 1.192e-12   1.987e-12   1.378e-06   1.309e-06   4.629e-07   6.772e-15       8e-13   2.825e-13
		#makedir.test1103fast.fluxreconfull.fluxctstag.128x64slab1d
		# 1.183e-12   1.972e-12   1.363e-06   1.273e-06   4.501e-07   1.746e-14   7.939e-13   2.804e-13
		#makedir.test1103fast.fluxreconfull.fluxctstag.256x128slab1d
		# 1.183e-12   1.972e-12   1.363e-06   1.273e-06   4.501e-07   1.746e-14   7.939e-13   2.804e-13
		#
		#makedir.test1103fast.fluxreconfull.fluxctstag.8x4full2d
		# 1.196e-07   2.683e-07         0.4      0.0584     0.07052   1.701e-07   1.934e-07   1.154e-07
		#makedir.test1103fast.fluxreconfull.fluxctstag.16x8full2d
		# 4.939e-10   8.305e-10    0.001386   0.0001057   0.0002566   6.489e-10   6.424e-10    5.05e-10
		#makedir.test1103fast.fluxreconfull.fluxctstag.32x16full2d
		# 3.354e-11   5.494e-11   4.175e-05    1.26e-05   1.395e-05    2.11e-11   1.866e-11   1.844e-11
		#makedir.test1103fast.fluxreconfull.fluxctstag.64x32full2d
		# 4.932e-12   8.048e-12   2.345e-06   2.265e-06   1.873e-06   1.582e-12    1.15e-12   1.488e-12
		#makedir.test1103fast.fluxreconfull.fluxctstag.128x64full2d
                # 1.464e-12   2.415e-12    1.32e-06    6.71e-07   4.993e-07   6.317e-13   6.301e-13   5.673e-13
 		#makedir.test1103fast.fluxreconfull.fluxctstag.256x128full2d 
		# 1.464e-12   2.415e-12    1.32e-06    6.71e-07   4.993e-07   6.317e-13   6.301e-13   5.673e-13
		#
new1dtestsfrstagfast 0    #
		# FAST WAVES STAG SPLITMAEM FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.4x1
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x1 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x1 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x1 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x1 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x1 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x1
		#
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x4slab1d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x8slab1d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x16slab1d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x32slab1d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x64slab1d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x128slab1d
		#
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x4full2d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x8full2d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x16full2d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x32full2d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x64full2d 
		cd makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.4x1
                # 2.728e-07   4.547e-07      0.8624      0.4029      0.1424           0     3.6e-07   1.273e-07
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x1
		# 4.708e-08   8.673e-08      0.1185     0.05083     0.01797           0   6.109e-08    2.16e-08
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x1
		# 3.077e-10   5.129e-10   0.0007053   0.0003329   0.0001177           0   4.131e-10   1.461e-10
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x1
		# 5.452e-12   9.087e-12    1.48e-05    6.58e-06   2.327e-06           0   9.004e-12   3.184e-12
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x1
		# 1.217e-12   2.027e-12   1.356e-06   1.142e-06   4.035e-07           0   7.649e-13   2.703e-13
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x1
		# 1.251e-12   2.085e-12   1.418e-06   1.316e-06   4.654e-07           0   7.838e-13   2.772e-13
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x1
		# 1.183e-12    1.97e-12    1.36e-06   1.296e-06   4.583e-07           0   7.837e-13   2.771e-13
		#
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x4slab1d
		# 4.512e-08   7.521e-08      0.1044     0.05102     0.01804   7.783e-13   5.852e-08   2.073e-08
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x8slab1d
		# 3.054e-10    5.09e-10    0.000699     0.00033   0.0001167     1.2e-16   4.091e-10   1.453e-10
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x16slab1d
		# 5.092e-12   8.487e-12     1.4e-05   6.486e-06   2.293e-06   3.754e-16   8.579e-12   3.043e-12
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x32slab1d
		# 1.223e-12   2.039e-12   1.311e-06   1.198e-06   4.235e-07   7.916e-16   7.603e-13   2.688e-13
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x64slab1d
		# 1.252e-12   2.086e-12   1.416e-06   1.321e-06   4.671e-07    4.25e-15   7.845e-13   2.772e-13
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x128slab1d
		# 1.186e-12   1.976e-12    1.36e-06   1.297e-06   4.585e-07   1.519e-14   7.846e-13   2.772e-13
		#
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.8x4full2d
		# 1.528e-07   2.655e-07      0.4419      0.0344     0.07521   1.864e-07   1.942e-07   1.462e-07
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.16x8full2d
		# 4.34e-08   5.779e-08     0.08077     0.01075     0.02088    3.55e-08   4.152e-08   3.314e-08
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.32x16full2d
		# 1.044e-10   1.771e-10   0.0002781   2.708e-05   3.363e-05    1.28e-10   1.272e-10   9.889e-11
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.64x32full2d
		# 1.678e-12   2.796e-12   5.541e-06   9.841e-07   8.513e-07   2.745e-12   2.745e-12   2.287e-12
		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.128x64full2d
                # 1.183e-12   1.971e-12   1.311e-06   6.215e-07   4.322e-07   6.251e-13   6.252e-13   5.518e-13
 		#makedir.test1103fast.fluxreconfullssplitmaem.fluxctstag.256x128full2d 
		# 1.231e-12   2.052e-12   1.313e-06   6.217e-07   4.378e-07   6.138e-13    6.14e-13   5.424e-13
		#
                #
new1dtestsfrstagfast 0    #
		# ALFVEN WAVES STAG SPLITMAEM pointfield FLUXRECON
		#
                # EVEN THOUGH test1103fast below, really Alfven wave test!!
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.4x1
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x1 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x1 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x1 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x1 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x1 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x1
		#
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4slab1d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8slab1d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16slab1d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32slab1d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64slab1d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128slab1d
		#
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d 
		cd makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.4x1
                # 0   5.557e-13   5.136e-10      0.3453      0.9767           0   1.621e-07   4.586e-07
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x1
		# 3.373e-13   4.845e-13   9.697e-07      0.0714       0.202           0   4.342e-08   1.228e-07
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x1
		# 1.767e-14   8.544e-14   4.923e-09   0.0004693    0.001327           0   3.068e-10   8.678e-10
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x1
		# 8.175e-16   1.495e-15   1.038e-09   9.702e-06   2.744e-05           0   6.437e-12   1.821e-11
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x1
		# 2.233e-15   2.271e-15   5.383e-10   3.149e-07   8.914e-07           0   2.103e-13   5.936e-13
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x1
		# 3.183e-15   3.332e-15   1.151e-09   9.345e-09   2.553e-08           0   6.639e-15   1.686e-14
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x1
		# 7.342e-15    3.92e-15   1.562e-09   2.148e-09   1.359e-09           0   7.822e-16    7.34e-16
		#
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4slab1d
		# 1.383e-09   2.303e-09    0.004384     0.06211      0.1754   8.458e-14   3.876e-08   1.083e-07
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8slab1d
		# 7.603e-13   4.842e-13   1.242e-08   0.0004684    0.001325   2.947e-16   3.065e-10   8.672e-10
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16slab1d
		# 1.375e-14    1.31e-14   3.328e-09     9.7e-06   2.744e-05   4.149e-16    6.44e-12   1.822e-11
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32slab1d
		# 2.289e-14   3.415e-14   8.774e-09   3.155e-07   8.911e-07   1.769e-15   2.099e-13   5.937e-13
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64slab1d
		# 8.67e-14   1.222e-13   1.987e-08   3.039e-08   2.668e-08   9.316e-15   2.818e-14   1.819e-14
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128slab1d
		# 1.869e-13   2.458e-13   3.227e-08   4.694e-08   1.698e-08   2.209e-14    5.38e-14   1.738e-14
		#
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d
		# 2.784e-08   3.423e-08      0.0798     0.08435      0.6142   1.019e-07   1.053e-07   6.951e-07
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d
		# 7.873e-09   2.315e-08     0.02204     0.01875      0.1182   2.033e-08   2.349e-08   1.305e-07
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d
		# 5.431e-11   9.716e-11   9.225e-05   0.0001001   0.0006468   1.189e-10   1.183e-10   7.955e-10
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d
		# 1.483e-12   2.463e-12   1.888e-06   1.988e-06   1.333e-05   2.408e-12   2.408e-12   1.643e-11
		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d
                # 5.252e-14    7.81e-14   5.926e-08   6.146e-08   4.187e-07   7.488e-14   7.514e-14   5.161e-13
 		#makedir.test1103fast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d 
		# 3.89e-14   3.639e-14   4.025e-09   1.088e-08   1.482e-08   8.102e-15   1.774e-14   1.797e-14
		#
docheckstaginit 0  #
		define print_noheader 1
		set start='\#'
		cd /data/jon/1dmhdwavetests_new2/
		print "myerrorlist.txt" {start}
		#
docheckstag 1   #
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd $1
		cd run
		checkstagorder
		#
		set mydir='             \# $1'
		print + "../../myerrorlist.txt" '%s\n' {mydir}
		set start='             \#'
		print + "../../myerrorlist.txt" '%2s %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g\n' {start errorrho erroru errorv1 errorv2 errorv3 errorB1 errorB2 errorB3}
		#
		#
getdataruns 0   #
		#
		docheckstaginit
                #
		# FAST WAVES STAG SPLITMAEM pointfield FLUXRECON
		#
		#
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.4x1
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x1 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x1 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x1 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x1 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x1 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x1
		#
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4slab1d
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8slab1d
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16slab1d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32slab1d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64slab1d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128slab1d
		#
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d 
		docheckstag makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d 
		#
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
           #
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.4x1
             #  2.733e-07  4.555e-07      0.864     0.4042     0.1429          0  3.607e-07  1.275e-07
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x1
             #  4.569e-08  7.992e-08     0.1196    0.05039    0.01781          0  6.186e-08  2.187e-08
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x1
             #  3.074e-10  5.124e-10   0.000705  0.0003328  0.0001177          0   4.13e-10   1.46e-10
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x1
             #  5.452e-12  9.087e-12   1.48e-05   6.58e-06  2.327e-06          0  9.004e-12  3.184e-12
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x1
             #  1.216e-12  2.027e-12  1.356e-06  1.141e-06  4.035e-07          0   7.65e-13  2.702e-13
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x1
             #   1.25e-12  2.084e-12  1.418e-06  1.316e-06  4.654e-07          0  7.836e-13  2.771e-13
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x1
             #  1.182e-12   1.97e-12   1.36e-06  1.296e-06   4.58e-07          0  7.834e-13   2.77e-13
		#
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4slab1d
             #  4.432e-08  7.384e-08    0.09476    0.04555    0.01611  1.042e-14  5.703e-08  2.018e-08
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8slab1d
             #  3.053e-10  5.086e-10  0.0006986  0.0003299  0.0001166  7.659e-17  4.091e-10   1.45e-10
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16slab1d
             #  5.095e-12  8.488e-12    1.4e-05  6.486e-06  2.293e-06  1.987e-16  8.581e-12  3.039e-12
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32slab1d
             #  1.223e-12  2.039e-12  1.311e-06  1.198e-06  4.235e-07  6.893e-16  7.604e-13  2.687e-13
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64slab1d
             #  1.252e-12  2.087e-12  1.416e-06  1.321e-06   4.67e-07  4.513e-15  7.847e-13  2.772e-13
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128slab1d
             #  1.185e-12  1.974e-12   1.36e-06  1.297e-06  4.585e-07  1.448e-14  7.845e-13  2.772e-13
		#
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d
             #   1.51e-07  2.659e-07     0.4447    0.03249    0.07631   1.85e-07  1.945e-07  1.433e-07
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d
             #  4.277e-08  5.573e-08    0.07816    0.01177    0.02023  3.597e-08  4.162e-08  3.311e-08
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d
             #  1.047e-10  1.774e-10  0.0002775  2.678e-05  3.356e-05  1.276e-10  1.268e-10  9.812e-11
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d
             #  1.682e-12  2.807e-12  5.539e-06  9.795e-07  8.498e-07  2.744e-12  2.744e-12   2.28e-12
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d
             #  1.183e-12  1.968e-12  1.311e-06  6.214e-07  4.321e-07  6.251e-13  6.252e-13  5.519e-13
             # makedir.test1103truefast.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d
             #  1.231e-12  2.053e-12  1.313e-06  6.218e-07  4.379e-07  6.138e-13   6.14e-13  5.425e-13
		#
                #
new1dtestsfv 0    #
		# Alven FV CTHLL
                #
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		#
		#
		cd makedir.test1103.fvfull.fluxcthll.4x1
		cd makedir.test1103.fvfull.fluxcthll.8x1 
		cd makedir.test1103.fvfull.fluxcthll.16x1 
		cd makedir.test1103.fvfull.fluxcthll.32x1 
		cd makedir.test1103.fvfull.fluxcthll.64x1 
		cd makedir.test1103.fvfull.fluxcthll.128x1 
		cd makedir.test1103.fvfull.fluxcthll.256x1
		#
		cd makedir.test1103.fvfull.fluxcthll.8x4slab1d 
		cd makedir.test1103.fvfull.fluxcthll.16x8slab1d 
		cd makedir.test1103.fvfull.fluxcthll.32x16slab1d 
		cd makedir.test1103.fvfull.fluxcthll.64x32slab1d 
		cd makedir.test1103.fvfull.fluxcthll.128x64slab1d 
		cd makedir.test1103.fvfull.fluxcthll.256x128slab1d
		#
		cd makedir.test1103.fvfull.fluxcthll.8x4full2d 
		cd makedir.test1103.fvfull.fluxcthll.16x8full2d 
		cd makedir.test1103.fvfull.fluxcthll.32x16full2d 
		cd makedir.test1103.fvfull.fluxcthll.64x32full2d 
		cd makedir.test1103.fvfull.fluxcthll.128x64full2d 
		cd makedir.test1103.fvfull.fluxcthll.256x128full2d 
		#
		cd run
		checkstagorder
		#
		#
		# 5th order convergence for dominant error (v3)
		#makedir.test1103.fvfull.fluxcthll.4x1
		# 9.992e-16   5.516e-13   1.309e-09      0.3399      0.9615   8.225e-16   1.603e-07   4.533e-07
		#makedir.test1103.fvfull.fluxcthll.8x1
		# 5.115e-13   7.655e-13   1.552e-07     0.08262      0.2337   5.209e-16   5.089e-08   1.439e-07
		#makedir.test1103.fvfull.fluxcthll.16x1
		# 2.698e-14   9.022e-14    3.92e-09    0.001973     0.00558   4.978e-16    1.29e-09   3.649e-09
		#makedir.test1103.fvfull.fluxcthll.32x1
		# 9.437e-16   3.015e-15   5.309e-10   4.848e-05   0.0001371   1.676e-16   3.216e-11   9.097e-11
		#makedir.test1103.fvfull.fluxcthll.64x1
		# 1.325e-15   1.958e-15   1.044e-09   1.908e-06   5.397e-06   4.952e-16    1.27e-12   3.594e-12
		#makedir.test1103.fvfull.fluxcthll.128x1
		# 2.052e-15    2.67e-15   1.128e-09   6.452e-08   1.822e-07   5.514e-16   4.255e-14   1.214e-13
		#makedir.test1103.fvfull.fluxcthll.256x1
		# 8.608e-15   4.149e-15   1.451e-09   3.495e-09   6.319e-09   5.056e-16   2.235e-15    3.95e-15
		#
		#
		# converges at second order!
		#makedir.test1103.fvfull.fluxcthll.8x4slab1d
		# 4.876e-09   3.471e-09    0.002206     0.08639      0.2451   6.575e-10   5.157e-08   1.502e-07
		#makedir.test1103.fvfull.fluxcthll.16x8slab1d
		# 1.843e-09   1.156e-09   0.0004577    0.003733     0.01052   2.171e-10   2.413e-09   6.857e-09
		#makedir.test1103.fvfull.fluxcthll.32x16slab1d
		# 5.002e-10   3.318e-10   0.0001807   0.0007831    0.002122   7.396e-11   5.042e-10   1.389e-09
		#makedir.test1103.fvfull.fluxcthll.64x32slab1d
		# 1.143e-10   8.309e-11   5.283e-05   0.0001793   0.0004996   1.692e-11   1.179e-10   3.308e-10
		#makedir.test1103.fvfull.fluxcthll.128x64slab1d
		# 3.196e-11   3.183e-11   2.291e-05   4.556e-05   0.0001144   4.609e-12    2.78e-11   7.578e-11
		#makedir.test1103.fvfull.fluxcthll.256x128slab1d
		#
		#
		#makedir.test1103.fvfull.fluxcthll.8x4full2d
		# 3.352e-08   5.524e-08     0.08018     0.09784      0.6072   8.208e-08   8.729e-08   7.019e-07
		#makedir.test1103.fvfull.fluxcthll.16x8full2d
		# 2.669e-08   4.206e-08     0.01566     0.02132      0.1076   2.218e-08   2.028e-08   1.297e-07
		#makedir.test1103.fvfull.fluxcthll.32x16full2d # 5th order here
		# 5.002e-10   3.318e-10   0.0001807   0.0007831    0.002122   7.396e-11   5.042e-10   1.389e-09
		#makedir.test1103.fvfull.fluxcthll.64x32full2d # stops converging!
		# 5.693e-10   4.929e-10   0.0004678   0.0003774    0.002672   4.893e-10   4.453e-10   3.247e-09
		#makedir.test1103.fvfull.fluxcthll.128x64full2d # then continues slightly
		1.801e-10   2.166e-10   0.0002352   0.0001308   0.0006588   2.616e-10   1.213e-10   8.061e-10
		#makedir.test1103.fvfull.fluxcthll.256x128full2d 
		#
                #
new1dtestsfastfv 0    #
		# FAST WAVES CTHLL FV
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fvfull.fluxcthll.4x1
		cd makedir.test1103fast.fvfull.fluxcthll.8x1 
		cd makedir.test1103fast.fvfull.fluxcthll.16x1 
		cd makedir.test1103fast.fvfull.fluxcthll.32x1 
		cd makedir.test1103fast.fvfull.fluxcthll.64x1 
		cd makedir.test1103fast.fvfull.fluxcthll.128x1 
		cd makedir.test1103fast.fvfull.fluxcthll.256x1
		#
		cd makedir.test1103fast.fvfull.fluxcthll.8x4slab1d 
		cd makedir.test1103fast.fvfull.fluxcthll.16x8slab1d 
		cd makedir.test1103fast.fvfull.fluxcthll.32x16slab1d 
		cd makedir.test1103fast.fvfull.fluxcthll.64x32slab1d 
		cd makedir.test1103fast.fvfull.fluxcthll.128x64slab1d 
		cd makedir.test1103fast.fvfull.fluxcthll.256x128slab1d
		#
		cd makedir.test1103fast.fvfull.fluxcthll.8x4full2d 
		cd makedir.test1103fast.fvfull.fluxcthll.16x8full2d 
		cd makedir.test1103fast.fvfull.fluxcthll.32x16full2d 
		cd makedir.test1103fast.fvfull.fluxcthll.64x32full2d 
		cd makedir.test1103fast.fvfull.fluxcthll.128x64full2d 
		cd makedir.test1103fast.fvfull.fluxcthll.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# 5th order up to some point where error is order amplitude so probably non-linear steepening
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fvfull.fluxcthll.4x1
                # 2.79e-07   4.651e-07      0.8824       0.416      0.1471   4.113e-16   3.721e-07   1.315e-07
		#makedir.test1103fast.fvfull.fluxcthll.8x1
		# 6.599e-08     1.1e-07      0.1597     0.07529     0.02662   3.838e-16   8.799e-08   3.111e-08
		#makedir.test1103fast.fvfull.fluxcthll.16x1
		# 1.495e-09   2.492e-09    0.003409    0.001607   0.0005682   5.315e-16   1.994e-09    7.05e-10
		#makedir.test1103fast.fvfull.fluxcthll.32x1
		# 3.769e-11   6.281e-11   8.546e-05   4.063e-05   1.437e-05   6.634e-16   5.101e-11   1.803e-11
		#makedir.test1103fast.fvfull.fluxcthll.64x1
		# 2.075e-12   3.461e-12   3.614e-06   2.095e-06   7.406e-07    4.57e-16   2.232e-12   7.894e-13
		#makedir.test1103fast.fvfull.fluxcthll.128x1
		# 1.191e-12   1.986e-12    1.38e-06   1.305e-06   4.613e-07   4.746e-16   7.987e-13   2.824e-13
		#makedir.test1103fast.fvfull.fluxcthll.256x1
		# 1.183e-12   1.971e-12   1.362e-06   1.272e-06   4.497e-07   4.662e-16   7.927e-13   2.802e-13
		#
                # worse than fluxrecon method
		#makedir.test1103fast.fvfull.fluxcthll.8x4slab1d
		# 5.695e-08   1.106e-07      0.1446     0.08077     0.02861   2.581e-14   7.916e-08   3.062e-08
		#makedir.test1103fast.fvfull.fluxcthll.16x8slab1d
		# 1.775e-09    3.22e-09    0.003575    0.003046    0.001061   9.023e-16   1.825e-09   8.966e-10
		#makedir.test1103fast.fvfull.fluxcthll.32x16slab1d
		# 6.521e-10    3.44e-10   0.0003494   0.0006471   0.0002271   7.506e-16   3.795e-10   9.632e-11
		#makedir.test1103fast.fvfull.fluxcthll.64x32slab1d
		# 1.528e-10   6.416e-11   9.882e-05   0.0001852   6.524e-05   1.493e-15   9.087e-11    1.86e-11
		#makedir.test1103fast.fvfull.fluxcthll.128x64slab1d
		# 3.819e-11   1.377e-11   2.514e-05   4.726e-05   1.668e-05   7.997e-15   2.215e-11   4.485e-12
		#makedir.test1103fast.fvfull.fluxcthll.256x128slab1d
		#
		#
                # worse than fluxrecon method
		#makedir.test1103fast.fvfull.fluxcthll.8x4full2d
		# 1.72e-07    3.07e-07      0.2922     0.04399     0.08214    8.83e-08   9.107e-08   1.291e-07
		#makedir.test1103fast.fvfull.fluxcthll.16x8full2d
		# 1.203e-08   2.632e-08     0.03037    0.009812     0.01278   1.185e-08   1.154e-08   1.716e-08
		#makedir.test1103fast.fvfull.fluxcthll.32x16full2d
		# 2.807e-09   2.149e-09    0.001144    0.001707    0.001229   1.131e-09   1.133e-09   1.076e-09
		#makedir.test1103fast.fvfull.fluxcthll.64x32full2d
		# 8.035e-10   3.648e-10   3.975e-05   0.0004368    0.000304   3.522e-10   3.523e-10   1.894e-10
		#makedir.test1103fast.fvfull.fluxcthll.128x64full2d
		# 2.022e-10   8.325e-11   5.711e-06   0.0001113   7.749e-05   8.945e-11   8.945e-11   4.444e-11
 		#makedir.test1103fast.fvfull.fluxcthll.256x128full2d 
		#
		#
                #
                #
new1dtestsfastfv 0    #
		# FAST WAVES CTSTAG FV
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103fast.fvfull.fluxctstag.4x1
		cd makedir.test1103fast.fvfull.fluxctstag.8x1 
		cd makedir.test1103fast.fvfull.fluxctstag.16x1 
		cd makedir.test1103fast.fvfull.fluxctstag.32x1 
		cd makedir.test1103fast.fvfull.fluxctstag.64x1 
		cd makedir.test1103fast.fvfull.fluxctstag.128x1 
		cd makedir.test1103fast.fvfull.fluxctstag.256x1
		#
		cd makedir.test1103fast.fvfull.fluxctstag.8x4slab1d 
		cd makedir.test1103fast.fvfull.fluxctstag.16x8slab1d 
		cd makedir.test1103fast.fvfull.fluxctstag.32x16slab1d 
		cd makedir.test1103fast.fvfull.fluxctstag.64x32slab1d 
		cd makedir.test1103fast.fvfull.fluxctstag.128x64slab1d 
		cd makedir.test1103fast.fvfull.fluxctstag.256x128slab1d
		#
		cd makedir.test1103fast.fvfull.fluxctstag.8x4full2d 
		cd makedir.test1103fast.fvfull.fluxctstag.16x8full2d 
		cd makedir.test1103fast.fvfull.fluxctstag.32x16full2d 
		cd makedir.test1103fast.fvfull.fluxctstag.64x32full2d 
		cd makedir.test1103fast.fvfull.fluxctstag.128x64full2d 
		cd makedir.test1103fast.fvfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# 
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103fast.fvfull.fluxctstag.4x1
                # REDO
		#makedir.test1103fast.fvfull.fluxctstag.8x1
		# 6.579e-08   1.096e-07      0.1592     0.07509     0.02655   2.193e-16   8.774e-08   3.102e-08
		#makedir.test1103fast.fvfull.fluxctstag.16x1
		# 1.495e-09   2.492e-09    0.003409    0.001607   0.0005682   1.082e-16   1.994e-09    7.05e-10
		#makedir.test1103fast.fvfull.fluxctstag.32x1
		# 3.769e-11   6.281e-11   8.546e-05   4.063e-05   1.437e-05   3.046e-17   5.101e-11   1.803e-11
		#makedir.test1103fast.fvfull.fluxctstag.64x1
		# 2.075e-12    3.46e-12   3.614e-06   2.094e-06   7.404e-07   3.826e-17   2.232e-12   7.893e-13
		#makedir.test1103fast.fvfull.fluxctstag.128x1
		# 1.191e-12   1.986e-12   1.379e-06   1.304e-06   4.612e-07   2.742e-17   7.986e-13   2.824e-13
		#makedir.test1103fast.fvfull.fluxctstag.256x1
		# 1.182e-12    1.97e-12   1.362e-06   1.272e-06   4.497e-07   2.663e-17   7.928e-13   2.803e-13
		#
                #
		#makedir.test1103fast.fvfull.fluxctstag.8x4slab1d
		# 5.883e-08   9.609e-08      0.1453     0.06917     0.02463   1.377e-15   7.857e-08   2.739e-08
		#makedir.test1103fast.fvfull.fluxctstag.16x8slab1d
		# 1.492e-09   2.481e-09    0.003401    0.001603   0.0005668   4.214e-16   1.995e-09   7.007e-10
		#makedir.test1103fast.fvfull.fluxctstag.32x16slab1d
		# 3.788e-11   6.299e-11   8.581e-05   4.081e-05   1.443e-05   2.789e-16   5.126e-11   1.802e-11
		#makedir.test1103fast.fvfull.fluxctstag.64x32slab1d
		# 2.082e-12   3.476e-12   3.615e-06   2.134e-06   7.545e-07   5.023e-16   2.235e-12   7.893e-13
		#makedir.test1103fast.fvfull.fluxctstag.128x64slab1d
		# 1.193e-12   1.989e-12   1.378e-06   1.309e-06    4.63e-07   4.011e-15   7.998e-13   2.826e-13
		#makedir.test1103fast.fvfull.fluxctstag.256x128slab1d
		#
		#
                #
		#makedir.test1103fast.fvfull.fluxctstag.8x4full2d
		# 1.247e-07   2.529e-07       0.353     0.04256     0.06124   1.691e-07   1.709e-07   1.325e-07
		#makedir.test1103fast.fvfull.fluxctstag.16x8full2d
		# 3.926e-08   2.957e-08     0.04837     0.01111     0.01351   2.049e-08   2.744e-08   2.253e-08
		#makedir.test1103fast.fvfull.fluxctstag.32x16full2d
		# 4.6e-10   7.487e-10    0.001356   9.911e-05   0.0002543    6.51e-10   6.456e-10   4.914e-10
		#makedir.test1103fast.fvfull.fluxctstag.64x32full2d
		# 1.619e-11   2.679e-11   4.062e-05   2.177e-06    6.93e-06   1.874e-11   1.849e-11   1.552e-11
		#makedir.test1103fast.fvfull.fluxctstag.128x64full2d
		# 1.434e-12   2.391e-12   2.136e-06    6.44e-07   5.081e-07   1.009e-12   1.006e-12    8.77e-13
 		#makedir.test1103fast.fvfull.fluxctstag.256x128full2d 
		#
new1dtestsfv 0    #
		#  ALFVEN WAVES CTSTAG FV
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1103.fvfull.fluxctstag.4x1
		cd makedir.test1103.fvfull.fluxctstag.8x1 
		cd makedir.test1103.fvfull.fluxctstag.16x1 
		cd makedir.test1103.fvfull.fluxctstag.32x1 
		cd makedir.test1103.fvfull.fluxctstag.64x1 
		cd makedir.test1103.fvfull.fluxctstag.128x1 
		cd makedir.test1103.fvfull.fluxctstag.256x1
		#
		cd makedir.test1103.fvfull.fluxctstag.8x4slab1d 
		cd makedir.test1103.fvfull.fluxctstag.16x8slab1d 
		cd makedir.test1103.fvfull.fluxctstag.32x16slab1d 
		cd makedir.test1103.fvfull.fluxctstag.64x32slab1d 
		cd makedir.test1103.fvfull.fluxctstag.128x64slab1d 
		cd makedir.test1103.fvfull.fluxctstag.256x128slab1d
		#
		cd makedir.test1103.fvfull.fluxctstag.8x4full2d 
		cd makedir.test1103.fvfull.fluxctstag.16x8full2d 
		cd makedir.test1103.fvfull.fluxctstag.32x16full2d 
		cd makedir.test1103.fvfull.fluxctstag.64x32full2d 
		cd makedir.test1103.fvfull.fluxctstag.128x64full2d 
		cd makedir.test1103.fvfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		# 
		# errorrho      erroru     errorv1     errorv2     errorv3     errorB1     errorB2     errorB3
		#makedir.test1103.fvfull.fluxctstag.4x1
                # 9.992e-16   5.503e-13   1.031e-09      0.3398       0.961           0   1.602e-07    4.53e-07
		#makedir.test1103.fvfull.fluxctstag.8x1
		# 1.623e-12   2.842e-12   4.716e-06     0.07656      0.2165           0    4.71e-08   1.332e-07
		#makedir.test1103.fvfull.fluxctstag.16x1
		# 2.023e-14   9.132e-14   2.184e-09    0.001963    0.005551           0   1.283e-09    3.63e-09
		#makedir.test1103.fvfull.fluxctstag.32x1
		# 1.258e-15   2.885e-15   5.165e-10   4.843e-05    0.000137           0   3.213e-11   9.089e-11
		#makedir.test1103.fvfull.fluxctstag.64x1
		# 1.534e-15   2.144e-15   6.557e-10   1.908e-06   5.397e-06   1.913e-17    1.27e-12   3.593e-12
		#makedir.test1103.fvfull.fluxctstag.128x1
		# 2.511e-15   2.806e-15   9.205e-10   6.412e-08   1.824e-07   5.483e-18   4.283e-14   1.214e-13
		#makedir.test1103.fvfull.fluxctstag.256x1
		# 6.17e-15    3.63e-15   1.322e-09   3.297e-09   6.209e-09   8.876e-18   2.264e-15   4.056e-15
		#
                #
		#makedir.test1103.fvfull.fluxctstag.8x4slab1d
		# 1.052e-09   1.808e-09    0.001322     0.09114      0.2555   2.828e-10   5.627e-08   1.591e-07
		#makedir.test1103.fvfull.fluxctstag.16x8slab1d
		# 1.123e-10   4.986e-10   0.0001787    0.003995     0.01133   7.471e-11   2.594e-09   7.407e-09
		#makedir.test1103.fvfull.fluxctstag.32x16slab1d
                # GODMARK: divb large on one boundary 3E-10 level
		# 5.759e-11   1.513e-10   9.595e-05   0.0007069    0.001989    3.98e-11   4.553e-10   1.321e-09
		#makedir.test1103.fvfull.fluxctstag.64x32slab1d
                # GODMARK: BUT HERE NO FEATURE!! ????
		# 1.21e-11   3.141e-11   1.798e-05   0.0001519   0.0004277   7.675e-12   1.004e-10   2.847e-10
		#makedir.test1103.fvfull.fluxctstag.128x64slab1d
		# 3.644e-14   4.849e-14   9.513e-09   7.146e-08   1.913e-07   4.978e-15   4.989e-14   1.277e-13
		#makedir.test1103.fvfull.fluxctstag.256x128slab1d
		#
		#
                #
		#makedir.test1103.fvfull.fluxctstag.8x4full2d
		# 2.598e-08    3.85e-08     0.08464      0.0923      0.6268   1.045e-07   1.002e-07   7.119e-07
		#makedir.test1103.fvfull.fluxctstag.16x8full2d
		# 6.795e-09   1.587e-08     0.02179     0.01751      0.1211   2.094e-08   2.276e-08   1.492e-07
		#makedir.test1103.fvfull.fluxctstag.32x16full2d
                # GODMARK: divb problem at up/down boundaries
		# 5.982e-10    1.47e-09    0.001824    0.001576     0.01259   2.096e-09   2.021e-09   1.536e-08
		#makedir.test1103.fvfull.fluxctstag.64x32full2d
                # GODMARK: no-barely a feature in divb
		# 1.57e-10   3.999e-10   0.0004169   0.0003835    0.002867   4.883e-10   4.716e-10   3.512e-09
		#makedir.test1103.fvfull.fluxctstag.128x64full2d
		# 5.488e-11   1.172e-10   0.0001312   9.485e-05   0.0006494   1.445e-10   1.113e-10   7.985e-10
 		#makedir.test1103.fvfull.fluxctstag.256x128full2d 
		#
		#
                #
new1dtests 0    #
		#  CIRC POL ALFVEN WAVES CTSTAG FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1102.fluxreconfull.fluxctstag.8x4full2d 
		cd makedir.test1102.fluxreconfull.fluxctstag.16x8full2d 
		cd makedir.test1102.fluxreconfull.fluxctstag.32x16full2d 
                cd makedir.test1102.fluxreconfull.fluxctstag.64x32full2d_nobound
		cd makedir.test1102.fluxreconfull.fluxctstag.64x32full2d 
		cd makedir.test1102.fluxreconfull.fluxctstag.128x64full2d 
		cd makedir.test1102.fluxreconfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
		# divb large only at outer ghost boundary so ok and goes away when included debug bound()
                #
		#makedir.test1102.fluxreconfull.fluxctstag.8x4full2d
		# 9.546e-05     0.06873      0.2828      0.2829       0.707     0.03135     0.03303     0.07939
		#makedir.test1102.fluxreconfull.fluxctstag.16x8full2d
		# 0.0008314     0.06049      0.1836      0.1838      0.4453      0.0234     0.02425     0.05449
		#makedir.test1102.fluxreconfull.fluxctstag.32x16full2d
                # 6.991e-05    0.001449    0.003792     0.00385    0.009303   0.0004687   0.0004668    0.001147
                #makedir.test1102.fluxreconfull.fluxctstag.64x32full2d_nobound
                # 4.778e-06   3.515e-05   0.0001297   0.0001346   0.0003401   1.624e-05   1.624e-05    4.26e-05
		#makedir.test1102.fluxreconfull.fluxctstag.64x32full2d
                # 2.75e-08   1.404e-05   2.713e-05   2.703e-05   6.717e-05   3.226e-06   3.226e-06   7.989e-06 # new with no feature at boundary
		#makedir.test1102.fluxreconfull.fluxctstag.128x64full2d
                # 7.954e-10   4.407e-07   8.486e-07   8.456e-07   2.101e-06   1.096e-07   1.096e-07   2.714e-07
 		#makedir.test1102.fluxreconfull.fluxctstag.256x128full2d 
		# 2.388e-11   1.378e-08   2.627e-08   2.618e-08   6.645e-08   3.443e-09   3.443e-09   8.712e-09
                #
new1dtests 0    #
		#  CIRC POL ALFVEN WAVES CTSTAG SPLITMAEM FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.8x4full2d 
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.16x8full2d 
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.32x16full2d 
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.64x32full2d 
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.128x64full2d 
		cd makedir.test1102.fluxreconfullssplitmaem.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.8x4full2d
		# 0.006963     0.06091       0.191      0.1938      0.4626     0.02499     0.02566     0.05511
		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.16x8full2d
		# 0.006963     0.06091       0.191      0.1938      0.4626     0.02499     0.02566     0.05511
		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.32x16full2d
                # 8.367e-06    0.000558    0.001189    0.001211    0.003007   0.0001463   0.0001461   0.0003689
		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.64x32full2d
                # 4.095e-07     1.4e-05   4.068e-05   3.977e-05   6.712e-05   4.805e-06   4.799e-06   7.984e-06
		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.128x64full2d
                # 4.817e-08   4.446e-07   5.444e-06   5.351e-06   2.303e-06   6.992e-07   6.987e-07   2.969e-07
 		#makedir.test1102.fluxreconfullssplitmaem.fluxctstag.256x128full2d 
		# 6.242e-09   2.028e-08   1.138e-06   1.128e-06   3.669e-07   1.488e-07   1.487e-07   4.783e-08
                #
                #
                # NOSPLITA2C: 0.0002541    0.001765      0.1361      0.1352      0.3432    0.008689    0.008689     0.02146
                # CONSTANT: 8.369e-06   0.0005615    0.001208    0.001224    0.002977   0.0001483   0.0001481   0.0003652
                # DO_SPLITA2C: 0.0002554    0.001766      0.1362      0.1352      0.3432    0.008688    0.008688     0.02146
                # DO_SPLITA2C (no EM for MA fluxstencil): 9.356e-06   0.0005617    0.001207    0.001228    0.003009   0.0001482    0.000148   0.0003695
                #
                #
new1dtests 0    #
		#  CIRC POL ALFVEN WAVES CTSTAG SPLITMAEM pointfield FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d 
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d 
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d 
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d 
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d 
		cd makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.8x4full2d
		# 5.329e-05     0.06587      0.2828      0.2829      0.7075     0.03346     0.03351     0.08488
		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.16x8full2d
		# 0.007644     0.06063      0.1926      0.1926      0.4658     0.02476      0.0253     0.05434
		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.32x16full2d
                # 8.358e-06   0.0005616    0.001208    0.001222    0.002988   0.0001483   0.0001481   0.0003667
		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.64x32full2d
                # 3.752e-08   1.404e-05   2.711e-05   2.701e-05   6.717e-05   3.224e-06   3.224e-06   7.992e-06
		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.128x64full2d
                # 7.88e-10   4.407e-07   8.486e-07   8.456e-07   2.101e-06   1.096e-07   1.096e-07   2.714e-07
 		#makedir.test1102.fluxreconpointfieldfullssplitmaem.fluxctstag.256x128full2d 
		# 2.377e-11   1.378e-08   2.627e-08   2.618e-08   6.645e-08   3.443e-09   3.443e-09   8.713e-09
                #
                #
new1dtests 0    #
		#  CIRC POL ALFVEN WAVES CTHLL FLUXRECON
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1102.fluxreconfull.fluxcthll.8x4full2d 
		cd makedir.test1102.fluxreconfull.fluxcthll.16x8full2d 
		cd makedir.test1102.fluxreconfull.fluxcthll.32x16full2d 
		cd makedir.test1102.fluxreconfull.fluxcthll.64x32full2d 
		cd makedir.test1102.fluxreconfull.fluxcthll.128x64full2d 
		cd makedir.test1102.fluxreconfull.fluxcthll.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		#makedir.test1102.fluxreconfull.fluxcthll.8x4full2d
		# 0.005204     0.06641      0.2833      0.2824      0.7072     0.03172     0.03237     0.08014
		#makedir.test1102.fluxreconfull.fluxcthll.16x8full2d
		# 0.007976     0.05846      0.1707      0.1676       0.448     0.02152     0.02096     0.05441
		#makedir.test1102.fluxreconfull.fluxcthll.32x16full2d
                # 8.165e-05    0.001365    0.003475    0.003652    0.009476   0.0004312   0.0004357    0.001173
                # 1.185e-05   0.0005325    0.001078    0.001128    0.002991   0.0001337   0.0001338   0.0003661 (new)
		#makedir.test1102.fluxreconfull.fluxcthll.64x32full2d
		# 1.615e-06   3.326e-05   0.0001173   0.0001203   0.0003596   1.474e-05   1.476e-05   4.501e-05
		#makedir.test1102.fluxreconfull.fluxcthll.128x64full2d
		# 6.067e-08   7.521e-07   3.909e-06   3.987e-06   1.146e-05   5.161e-07   5.167e-07   1.507e-06
 		#makedir.test1102.fluxreconfull.fluxcthll.256x128full2d 
		# 2.59e-09   1.847e-08   1.205e-07   1.238e-07   3.449e-07   1.564e-08   1.565e-08   4.464e-08
		#
                #
new1dtests 0    #
		#  CIRC POL ALFVEN WAVES CTSTAG FV
		#
		#
		cd /data/jon/1dmhdwavetests_new2/
		#
		#
		cd makedir.test1102.fvfull.fluxctstag.8x4full2d 

+		cd makedir.test1102.fvfull.fluxctstag.16x8full2d 
		cd makedir.test1102.fvfull.fluxctstag.32x16full2d 
		cd makedir.test1102.fvfull.fluxctstag.64x32full2d 
		cd makedir.test1102.fvfull.fluxctstag.128x64full2d 
		cd makedir.test1102.fvfull.fluxctstag.256x128full2d 
		#
		cd run
		checkstagorder
                #
                #
		#makedir.test1102.fvfull.fluxctstag.8x4full2d
		# 8.218e-05     0.06495      0.2827      0.2828      0.7076     0.03076     0.02983     0.07987
		#makedir.test1102.fvfull.fluxctstag.16x8full2d
		# 0.001123     0.06102       0.198      0.1973      0.5038     0.02412     0.02493     0.06064
		#makedir.test1102.fvfull.fluxctstag.32x16full2d
                # 0.0004188    0.002233     0.01718     0.01713     0.04783    0.002116    0.002133     0.00592
		#makedir.test1102.fvfull.fluxctstag.64x32full2d
		# 0.0001244   0.0002485     0.00419    0.004166    0.009896   0.0005233   0.0005264     0.00124
		#makedir.test1102.fvfull.fluxctstag.128x64full2d
		# 4.861e-05    8.51e-05   0.0009567   0.0009657    0.002089   0.0001257   0.0001262   0.0002747
 		#makedir.test1102.fvfull.fluxctstag.256x128full2d 
		# 2.289e-05   3.858e-05   0.0002286   0.0002321   0.0004752   2.944e-05   2.972e-05   6.171e-05
		#
                #
