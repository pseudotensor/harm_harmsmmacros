#
#jrdp dump0000
#gammienew
#gammiegrid gdump
#
# Remember v_HARM = gamma v 
#  

set alpha = sqrt( - 1.0/gn300)
set betaoalphasq = gn301 * gv301 + gn302 * gv302 + gn303 * gv303
set alpha2 =  sqrt( gv300 / ( betaoalphasq - 1 ) )
set alphadiff = alpha - alpha2
set Bd1 = bd1 * uu0 - bu0 * ud1
set Bd2 = bd2 * uu0 - bu0 * ud2
set Bd3 = bd3 * uu0 - bu0 * ud3
set Bd21 = B1*gv311 + B2*gv312 + B3*gv313
set Bd22 = B1*gv321 + B2*gv322 + B3*gv323
set Bd23 = B1*gv331 + B2*gv332 + B3*gv333
set Bdcheck1 = Bd1 - Bd21
set Bdcheck2 = Bd2 - Bd22
set Bdcheck3 = Bd3 - Bd23
set Bsq = Bd1*B1 + Bd2*B2 + Bd3*B3
set Bsq2 = Bd21*B1 + Bd22*B2 + Bd23*B3
set Bdotv = Bd1*v1 + Bd2*v2 + Bd3*v3
set Bdotv2 = Bd21*v1 + Bd22*v2 + Bd23*v3
set Bdotv3 = B1 * ud1 + B2*ud2 + B3*ud3
set cosphi = Bdotv / (sqrt(vsq*Bsq))
set Bdotvsq = Bdotv**2
set Bdotvd12 = Bdotv - Bdotv2
set Bdotvd13 = Bdotv - Bdotv3
set Bdotvd23 = Bdotv2 - Bdotv3
set vd1 = v1*gv311 + v2*gv312 + v3*gv313
set vd2 = v1*gv321 + v2*gv322 + v3*gv323
set vd3 = v1*gv331 + v2*gv332 + v3*gv333
set vsq = vd1*v1 + vd2*v2 + vd3*v3
set gammasq = ( 1.0 + vsq )
set Bsq3 =  gammasq * bsq / alpha**2 - Bdotv**2
set Bsqd13 = Bsq - Bsq3
set Bsqd12 = Bsq - Bsq2
set Bsqd23 = Bsq2 - Bsq3
set Bsqdbsq = Bsq - bsq
set bsqt123 = 2*bsq - Bsq
set Aconst = Bsq * vsq - Bdotv**2
set Aconst2 = Bsq2 * vsq - Bdotv2**2
set Aconst3 = Bsq2 * vsq - Bdotv3**2
set Ad12 = Aconst - Aconst2
set Ad13 = Aconst - Aconst3
set Ad23 = Aconst2 - Aconst3
set bsq2 = - ( Bsq + Bdotv**2 ) / ( gn300 * gammasq )
set bsq3 = - ( Bsq2 + Bdotv2**2 ) / ( gn300 * gammasq )
set bsq4 = - ( Bsq2 + Bdotv3**2 ) / ( gn300 * gammasq )
set bsqdiff12 = bsq - bsq2
set bsqdiff13 = bsq - bsq3
set bsqdiff14 = bsq - bsq4
set mybsq = bu0 * bd0 +  bu1 * bd1 +  bu2 * bd2 +  bu3 * bd3 
set mybsqdiff = mybsq - bsq
set vdiff1 = ud1 - vd1
set vdiff2 = ud2 - vd2
set vdiff3 = ud3 - vd3

# Cubic specific:  remember we're using harm's v and B
set W = gammasq * ( rho + u + p )
set z2 = ( 1.0 + vsq*($gam-1.0)/gammasq ) / $gam
set z1  =  -0.5*Aconst - W*z2
set a2 = 2*Bsq*alpha**2 + z1 / z2
set a1 = Bsq*(Bsq*alpha**2 + 2*z1 / z2)*alpha**2
set Ec = W - p + 0.5*Bsq*alpha**2 + 0.5*Aconst
set gamma1 = sqrt(gammasq)
set Dc = gamma1*rho
set z12 = Dc * ($gam - 1.0)/( $gam*gamma1) + 0.5*Bsq*alpha**2 - Ec
set z1d = z1 - z12
set Tsq = ( W + Bsq*alpha**2)**2 * Aconst
set dc = (Bsq*alpha**2 - z1/z2)/3.0
set Discrim = Tsq * ( Tsq/(8.0*z2) - dc**3 ) / ( 2*z2)
set lDisc = lg ( abs(Discrim) )
set a0 = 0.5*Tsq / z2 + Bsq**2*alpha**4 * z1 / z2
set Q1 = (3.0*a1 - a2**2)/9.0
set R1 = ( 9.0*a1*a2 - 27.0*a0 - 2*a2**3)/54.0
set Discrim2 = Q1**3 + R1**2
set lDisc2 = lg ( abs( Discrim2 ) )
set Discrimd = Discrim - Discrim2
set Discrimrd = (Discrim - Discrim2) / Discrim
set W1 = gammasq*( P + rho + uu )
#set W1sol = ( Discrim < 0 ? (2*dc*cos( acos(R1/d**3)/3.0 ) - a2/3.0) : ( (R1 + sqrt(Discrim))**(1.0/3.0) + (R1 - sqrt(Discrim))**(1.0/3.0) - a2/3.0 ) )
set Discrimsign = Discrim / abs(Discrim)
set Discrim2sign = Discrim2 / abs(Discrim2)
set Discrimdsign = Discrimd / abs(Discrimd)
set Tsqsign = Tsq / abs(Tsq)
set W1sign = W1/abs(W1)
set W1solsign = W1/abs(W1sol)
set a2sign = a2 / abs(a2)
set a1sign = a1 / abs(a1)
set z1sign = z1 / abs(z1)
set z2sign = z2 / abs(z2)
set z12sign = z12 / abs(z12)
set Wsign = W / abs(W)
set dcsign = dc / abs(dc)

set Bdotvsqsign = Bdotvsq / abs(Bdotvsq)
set Bsqsign = Bsq / abs(Bsq)
set Bsq2sign = Bsq2 / abs(Bsq2)
set Bsq3sign = Bsq3 / abs(Bsq3)
set vsqsign = vsq / abs(vsq)
set bsq2sign = bsq2 / abs( bsq2 )
set bsq3sign = bsq3 / abs( bsq3 )
set Bdotvsign = Bdotv / abs(Bdotv)
set bsqdiff12sign = bsqdiff12 / abs( bsqdiff12 )
set bsqdiff13sign = bsqdiff13 / abs( bsqdiff13 )
set bsqdiff14sign = bsqdiff14 / abs( bsqdiff14 )
set Aconstsign = Aconst / abs(Aconst)
set Aconst2sign = Aconst2 / abs(Aconst2)
set Aconst3sign = Aconst3 / abs(Aconst3)
set gammasqsign = gammasq / abs(gammasq)
set bsqsign = bsq/abs(bsq)
set alphasign = alpha / abs(alpha)
set gv300sign = gv300 / abs(gv300)

set gt1 = gv312**2 - gv311*gv322
set gt2 = gv323**2 - gv333*gv322
set gt3 = gv312*gv323 - gv313*gv322
set ac1 = gv311*0 + .03
set cc1 = gv311*0 + .02
set gtf = ac1**2 * gt1 + cc1**2*gt2 + 2.*ac1*cc1*gt3 + gv322
set gtfsign = gtf / abs(gtf)

set vm1 = v1 / gamma1
set vm2 = v2 / gamma1
set vm3 = v3 / gamma1

set betasq = gv311 *  gn301 * gn301 + gv312 *  gn301 * gn302 + gv313 *  gn301 * gn303 + gv321 *  gn302 * gn301 + gv322 *  gn302 * gn302 + gv323 *  gn302 * gn303 + gv331 *  gn303 * gn301 + gv332 *  gn303 * gn302 + gv333 *  gn303 * gn303 

set betasqsign = betasq / abs(betasq)
set delta00 = gv300 * gn300 + gv301 * gn310 + gv302 * gn320 + gv303 * gn330 
set delta01 = gv300 * gn301 + gv301 * gn311 + gv302 * gn321 + gv303 * gn331 
set delta02 = gv300 * gn302 + gv301 * gn312 + gv302 * gn322 + gv303 * gn332 
set delta03 = gv300 * gn303 + gv301 * gn313 + gv302 * gn323 + gv303 * gn333 
set delta10 = gv310 * gn300 + gv311 * gn310 + gv312 * gn320 + gv313 * gn330 
set delta11 = gv310 * gn301 + gv311 * gn311 + gv312 * gn321 + gv313 * gn331 
set delta12 = gv310 * gn302 + gv311 * gn312 + gv312 * gn322 + gv313 * gn332 
set delta13 = gv310 * gn303 + gv311 * gn313 + gv312 * gn323 + gv313 * gn333 
set delta20 = gv320 * gn300 + gv321 * gn310 + gv322 * gn320 + gv323 * gn330 
set delta21 = gv320 * gn301 + gv321 * gn311 + gv322 * gn321 + gv323 * gn331 
set delta22 = gv320 * gn302 + gv321 * gn312 + gv322 * gn322 + gv323 * gn332 
set delta23 = gv320 * gn303 + gv321 * gn313 + gv322 * gn323 + gv323 * gn333 
set delta30 = gv330 * gn300 + gv331 * gn310 + gv332 * gn320 + gv333 * gn330 
set delta31 = gv330 * gn301 + gv331 * gn311 + gv332 * gn321 + gv333 * gn331 
set delta32 = gv330 * gn302 + gv331 * gn312 + gv332 * gn322 + gv333 * gn332 
set delta33 = gv330 * gn303 + gv331 * gn313 + gv332 * gn323 + gv333 * gn333 
