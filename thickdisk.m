getmacros 0     #
		gogrmhd
		jre mri.m
		jre gtwodmaps2.m
		#
dothick1 0      #
		#
		#
		jrdpcf3duentropy dump0000
		#jrdpcf3duentropy dump0096
		#jrdpcf3duentropy dump0170
		#
		# bin2txt 1 2 0 -1 3 136 64 128 1 gdump.bin gdump d 126
		# 
		#
		#grid3d gdump
                grid3ddxdxp gdump
                set dxdxp1=dxdxp11
                set dxdxp2=dxdxp22
                set dxdxp3=dxdxp33
		#
		mricalc
		fieldcalc 0 aphi
		set H=r*cos(h)
		set R=r*sin(h)
		set HoR=H/R
		#
		plc 0 (rho-1)
		#plc 0 aphi 010
		plc 0 ibeta 010
		plc0 0 (HoR-1) 010
		#
		#
		plc 0 (rho-1)
		plc 0 idx2mri 010
		plc0 0 (HoR-1) 010
		#
                # how many wavelengths inside the disk
                # \gtrsim 1 (was 3 with old omegamax) for thickdisk1
                set hor=cs/(r*uu3*dxdxp33)
                set hdisk=hor*r
		plc 0 (rho-1)
		plc 0 idx2mri 010
		plc0 0 (HoR-1) 010
		plc 0 (hdisk/lambda2max) 010
                #
		plc 0 (rho-1)
		plc 0 (sqrt(cs2)/(R*omegak)) 010
		#
		#
		#
		set cour=0.4999
		set dt1p=(abs($dx1/(v1p/cour)))
		set dt1m=(abs($dx1/(v1m/cour)))
		set dt2p=(abs($dx2/(v2p/cour)))
		set dt2m=(abs($dx2/(v2m/cour)))
		set dt3p=(abs($dx3/(v3p/cour)))
		set dt3m=(abs($dx3/(v3m/cour)))
		#
		plc 0 dt1m
		#
betanoble 0     #
		#
		set rhocut=0.25
		#set rhocut=0.2
		#
		set use=(rho>rhocut && r<100 ? 1 : 0)
		#
		set god1=p*gdet if(use)
		set god2=gdet if(use)
		set pgavg=SUM(god1)/SUM(god2)
		#
		set god1=(bsq/2.0)*gdet if(use)
		set god2=gdet if(use)
		set pbavg=SUM(god1)/SUM(god2)
		#
		set betanoble=pgavg/pbavg
		#
		set god1=gdet*(p/(bsq/2)) if(use)
		set god2=gdet if(use)
		set betaavg=SUM(god1)/SUM(god2)
		#
		set god1=gdet*ibeta if(use)
		set god2=gdet if(use)
		set ibetaavg=SUM(god1)/SUM(god2)
		set betaavg2=1/ibetaavg
		#
		#
		print {betanoble betaavg betaavg2}
		#
		# for current setup, so good!
		# minbeta=10
		# betanoble=46
		# betaavg=180
		# betaavg2=46
		#
		#
myoverlay1 0     #		
		# bin2txt 1 2 0 -1 3 136 64 128 1 dump0000.bin dump0000 d 73
		#
		# jrdpcf3duentropy dump0000
		# jrdpcf3duentropy dump0080
		# jrdpcf3duentropy dump0160
		#
		overlayprobe
		#
probestuff1 0    #
		# use mergeprobe.sh
		#
		jrdpheader3d dumps/dump0000
		#
		#
		rdprobe probe.dat.grmhd.0016
		pickprobe 16 32 0 0
		#
		pl 0 prt pr
		#
		showfft 16 32 0 0  1 0.25 1
		#
		set dimenit=dimen(prt)
		print {dimenit}
		#
		#
		#
		set ratio=dimenit/64
		print {ratio}
		#
		sonogram 64
		showsonogram sonogrampow 64
		#
		#
showfftpr1 1    #		
		pickprobe 16 34 0 $1
		set mypr1=(pr < 0 ? -1 : 1)
		set mypr2=pr**2
		showfftlim mypr2 2100 6513
		#
showfftpr2 4    #		
		pickprobe $1 $2 $3 $4
		showfftlim pr 2100 6513
		#
showfftpr3 4    #		
		pickprobe $1 $2 $3 $4
		set mypr2=pr**2
		showfftlim mypr2 2100 6513
		#
foundqpos0  0   #
		showfftpr2 0 32 0 7
		showfftpr2 0 34 0 7
		showfftpr2 0 36 0 7
		showfftpr2 0 38 0 7
		#
		# matches yellow and green lines:
		showfftpr2 8 36 0 7
		#
		#
		#maybe at risco:
		showfftpr2 24 32 0 0
		#
eners1 0        #
		# use mergeeners.sh
		# clean nan's and inf's out
		#
		jrdp3dener
		#
		#
		jrdp3denergen enerother4.out -1E30 1E30
		#
qpointime1 0     #
		set prt=t
		showfftlim u0dot3 0 6500
		#
		# hard to notice, but there in time plot
		pl 0 t u0dot3
		set god=6810.75-6107.3 print {god}
		set frat=1/god/fradius print {frat}
		set fs=1/god/tlunit print {fs}
		#
		# 21Hz for GRS1915+105
		#
		# but, u0dot3 all screwed up like u0dot1?
		#
		pl 0 t u0dot4
		set prt=t
		showfftlim u0dot4 0 6500
		#
		set god=9756.55-6218.95 print {god}
		set fs=1/god/tlunit print {fs}
		#
		# 4Hz for GRS1915+105
#       FINALPLOTS
velvsrad 0 #
        velvsradrd
        velvsradpl
        #
velvsradrd 0 #
        # datavsr1.txt: rho,u over non-jet, v,B over whole flow
        # datavsr2.txt: rho,u,v,B at equator no matter disk or jet
        # datavsr3.txt: rho,u over 2.5*hoverr3d non-jet and v,B over 2.5*hoverr3d
        # datavsr4.txt: rho,u,v,B over 2.0*hoverr3d non-jet
        #
        ################################################
        da datavsr1.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosq_vsr ugsrhosq_vsr uu0rhosq_vsr vus1rhosq_vsr vuas1rhosq_vsr vus3rhosq_vsr vuas3rhosq_vsr Bs1rhosq_vsr Bas1rhosq_vsr Bs2rhosq_vsr Bas2rhosq_vsr Bs3rhosq_vsr Bas3rhosq_vsr bs1rhosq_vsr bas1rhosq_vsr bs2rhosq_vsr bas2rhosq_vsr bs3rhosq_vsr bas3rhosq_vsr bsqrhosq_vsr}
        #
        da datavsr2.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqeq_vsr ugsrhosqeq_vsr uu0rhosqeq_vsr vus1rhosqeq_vsr vuas1rhosqeq_vsr vus3rhosqeq_vsr vuas3rhosqeq_vsr Bs1rhosqeq_vsr Bas1rhosqeq_vsr Bs2rhosqeq_vsr Bas2rhosqeq_vsr Bs3rhosqeq_vsr Bas3rhosqeq_vsr bs1rhosqeq_vsr bas1rhosqeq_vsr bs2rhosqeq_vsr bas2rhosqeq_vsr bs3rhosqeq_vsr bas3rhosqeq_vsr bsqrhosqeq_vsr}
        #
        da datavsr3.txt
        lines 1 0000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqhorpick_vsr ugsrhosqhorpick_vsr uu0rhosqhorpick_vsr vus1rhosqhorpick_vsr vuas1rhosqhorpick_vsr vus3rhosqhorpick_vsr vuas3rhosqhorpick_vsr Bs1rhosqhorpick_vsr Bas1rhosqhorpick_vsr Bs2rhosqhorpick_vsr Bas2rhosqhorpick_vsr Bs3rhosqhorpick_vsr Bas3rhosqhorpick_vsr bs1rhosqhorpick_vsr bas1rhosqhorpick_vsr bs2rhosqhorpick_vsr bas2rhosqhorpick_vsr bs3rhosqhorpick_vsr bas3rhosqhorpick_vsr bsqrhosqhorpick_vsr}
        #
        da datavsr4.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhoshorvsr ugshor_vsr bsqshor_vsr bsqorhoshor_vsr bsqougshor_vsr uu0hor_vsr vus1hor_vsr vuas1hor_vsr vus3hor_vsr vuas3hor_vsr Bs1hor_vsr Bas1hor_vsr Bs2hor_vsr Bas2hor_vsr Bs3hor_vsr Bas3hor_vsr bs1hor_vsr bas1hor_vsr bs2hor_vsr bas2hor_vsr bs3hor_vsr bas3hor_vsr bsqhor_vsr}
        set gam=4.0/3.0
        set pg=(gam-1.0)*ugshor_vsr
        set beta=pg/bsqshor_vsr
        #
        da datavsr5.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r mdotfinavgvsr mdotfinavgvsr5 mdotfinavgvsr10 mdotfinavgvsr30 edemvsr edmavsr edmvsr ldemvsr ldmavsr ldmvsr phiabsj_mu1vsr pjemfinavgvsr pjmakefinavgvsr pjkefinavgvsr ljemfinavgvsr ljmakefinavgvsr ljkefinavgvsr mdin_vsr mdjet_vsr mdmwind_vsr mdwind_vsr alphamag1_vsr alphamag2_vsr alphamag3_vsr fstot_vsr fsin_vsr feqtot_vsr fsmaxtot_vsr}
        #
        set edottotvsr=edemvsr+edmavsr
        set ldottotvsr=ldemvsr+ldmavsr
        set eomdot=edottotvsr/mdotfinavgvsr30
        set lomdot=ldottotvsr/mdotfinavgvsr30
        #
        da datavsr6.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii rnyO2 dtheta dphi drvsr dHvsr dPvsr hoverr_vsr hoverrcorona_vsr hoverr_jet_vsr thetaalongfield qmridisk_vsr iq2mridisk_vsr qmridiskweak_vsr iq2mridiskweak_vsr}
        # iq2 comes without H/R
        set q2mridisk_vsr=hoverr_vsr/iq2mridisk_vsr
        #
        ################################################
        da datavsh1.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii hinnx4 rhosrhosqrad4_vsh ugsrhosqrad4_vsh uu0rhosqrad4_vsh vus1rhosqrad4_vsh vuas1rhosqrad4_vsh vus3rhosqrad4_vsh vuas3rhosqrad4_vsh Bs1rhosqrad4_vsh Bas1rhosqrad4_vsh Bs2rhosqrad4_vsh Bas2rhosqrad4_vsh Bs3rhosqrad4_vsh Bas3rhosqrad4_vsh bs1rhosqrad4_vsh bas1rhosqrad4_vsh bs2rhosqrad4_vsh bas2rhosqrad4_vsh bs3rhosqrad4_vsh bas3rhosqrad4_vsh bsqrhosqrad4_vsh}
        #
        da datavsh2.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii hinnx8 rhosrhosqrad8_vsh ugsrhosqrad8_vsh uu0rhosqrad8_vsh vus1rhosqrad8_vsh vuas1rhosqrad8_vsh vus3rhosqrad8_vsh vuas3rhosqrad8_vsh Bs1rhosqrad8_vsh Bas1rhosqrad8_vsh Bs2rhosqrad8_vsh Bas2rhosqrad8_vsh Bs3rhosqrad8_vsh Bas3rhosqrad8_vsh bs1rhosqrad8_vsh bas1rhosqrad8_vsh bs2rhosqrad8_vsh bas2rhosqrad8_vsh bs3rhosqrad8_vsh bas3rhosqrad8_vsh bsqrhosqrad8_vsh}
        #
        da datavsh3.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii hinnx30 rhosrhosqrad30_vsh ugsrhosqrad30_vsh uu0rhosqrad30_vsh vus1rhosqrad30_vsh vuas1rhosqrad30_vsh vus3rhosqrad30_vsh vuas3rhosqrad30_vsh Bs1rhosqrad30_vsh Bas1rhosqrad30_vsh Bs2rhosqrad30_vsh Bas2rhosqrad30_vsh Bs3rhosqrad30_vsh Bas3rhosqrad30_vsh bs1rhosqrad30_vsh bas1rhosqrad30_vsh bs2rhosqrad30_vsh bas2rhosqrad30_vsh bs3rhosqrad30_vsh bas3rhosqrad30_vsh bsqrhosqrad30_vsh}
        #
        ################################################
        da datavst1.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g' {tici ts mdtotihor md10ihor md30ihor mdinrdiskin mdinrdiskout mdjetrjetout mdmwindrjetin mdmwindrjetout mdwindrdiskin mdwindrdiskout}
        set mdothor=mdtotihor-md30ihor
        #
        da datavst2.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  etabhEM etabhMAKE etabh etajEM etajMAKE etaj etamwinEM etamwinMAKE etamwin etamwoutEM etamwoutMAKE etamwout etawinEM etawinMAKE etawin etawoutEM etawoutMAKE etawout}
        #
        da datavst3.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  letabhEM letabhMAKE letabh letajEM letajMAKE letaj letamwinEM letamwinMAKE letamwin letamwoutEM letamwoutMAKE letamwout letawinEM letawinMAKE letawin letawoutEM letawoutMAKE letawout}
        #
        da datavst4.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  hoverrhor hoverr2 hoverr5 hoverr10 hoverr20 hoverr100 hoverrcoronahor hoverrcorona2 hoverrcorona5 hoverrcorona10 hoverrcorona20 hoverrcorona100 hoverr_jethor hoverr_jet2 hoverr_jet5 hoverr_jet10 hoverr_jet20 hoverr_jet100}
        #
        !sed 's/nan/0/g' datavst5.txt > datavst5n.txt
        da datavst5n.txt
        lines 1 1000000
        read '%d %g %g %g %g %g  %g %g %g' {tici ts  betamin0 betaavg0 betaratofavg0 betaratofmax0 alphamag1_10 alphamag2_10 alphamag3_10}
        #
        !sed 's/nan/0/g' datavst6.txt > datavst6n.txt
        da datavst6n.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  qmridisk10 qmridisk20 qmridisk100 iq2mridisk10 iq2mridisk20 iq2mridisk100 qmridiskweak10 qmridiskweak20 qmridiskweak100 iq2mridiskweak10 iq2mridiskweak20 iq2mridiskweak100}
        #
        !sed 's/nan/0/g' datavst7.txt > datavst7n.txt
        da datavst7n.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  phibh phirdiskin phirdiskout phij phimwin phimwout phiwin phiwout phijn phijs fstotihor fsmaxtotihor fmaxvst rifmaxvst reqstagvst feqstag feqstagnearfin fstotnormA0 fstotnormA1 fstotnormA2 fstotnormC fstotnormBwhichfirstlimited fstotnormD}
        #
        # only read some of the data that's required for the plot
        da dataavgvsh0.txt
        lines 1 2
        read {avg_ts 1 avg_te 2 avg_nitems 3 a 4 rhor 5 ihor 6 dx1 7 dx2 8 dx3 9 wedgef 10 n1 11 n2 12 n3 13}
        da dataavgvsh1.txt
        lines 2 1000000
        read {avgjj 1 avgh 2 avgrho 3 avgug 4 avgbsq 5 avgunb 6}
        read {avgB1 23 avggdetB1 26 avgrhouu1 34 avgomegaf2 29 avgomegaf2b 30 avgomegaf1 31 avgomegaf1b 32}
        read {avgTud10 58 avgTud13 70 avgTudEM10 170 avgTudEM13 182 avgTudMA10 186 avgTudMA13 198 avgTudPA10 202 avgTudPA13 214 avgTudIE10 218 avgTudIE13 230}
        set avgTudMAKE10=-avgTudMA10-avgrhouu1
        # print {avgh avgbsqorho avgTudEM10 avgTudMA10 avgrhouu1 avgTudPA10 avgTudIE10}
        read {avgmu 233 avgsigma 234 avgbsqorho 235 avgabsB1 236 avgabsgdetB1 239 avggamma 243}
        read {avggdet 244 dxdxp11 245 dtheta 246}
        #
        set omegah=a/(2*rhor)
        set fakegdet=avgabsgdetB1/avgabsB1
        #
        # mathematica:
        # a = 0.9375
        # rhor = 1 + Sqrt[1 - a^2]
        # r = rhor
        # fofr = (PolyLog[2, 2/r] - Log[1 - 2/r]*Log[r/2])*(r^2*(2*r - 3)/8) + (1 + 3*r - 6*r^2)/12*Log[r/2] + 11/72 + 1/(3*r) + r/2 - r^2/2
        # for a=0.9375:
        set fofr=0.214494
        set avgabsgdetB1bz0=(avgabsgdetB1/avgabsB1)*avgabsB1[0]
        set avgabsgdetB1bz=(avgabsgdetB1/avgabsB1)*avgabsB1[0]*(1+(a/rhor)**2 * (-2*cos(avgh)+rhor**2*(1+3*cos(2*avgh))*fofr))
        set hbz=(avgh<=pi/2) ? avgh : (pi-avgh)
        set faker=rhor
        set avgabsgdetB1bz2=avgabsgdetB1bz*(faker+2*ln(1+cos(hbz)))
        #
        set omegafpara=(1/4*sin(hbz)**2*(1+ln(1+cos(hbz))))/(4*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz)))
        set omegafohpara=omegafpara/(1.0/(2*2))
        #
        if(1==0){\
        #
        set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
        set fakeomegah=a/4
        #
        set fakehor=2
        set Bparahor=Brpara[ihor+0*$nx]
        set efluxdenpara=2*Brpara**2*parabz*fakehor*(fakeomegah-parabz)*sin(hbz)**2/Bparahor**2
        #
        set fakegdetks=fakehor**2*sin(hbz)
        set efluxpara=2*pi*efluxdenpara*fakegdetks
        }
        #
        #
        #
        set cleanatbsqorho=45
        #        set cleanattheta=0.5834
        # print {avgh avgjj}
        set cleanatthetal=1.2
        set cleanatthetah=pi-1.2
        set cleanjj=16
        #        set cleanvalue=0.5
        set cleanavgomegaf2=(avgomegaf2*2*pi/omegah)
        set cleanvalue=cleanavgomegaf2[cleanjj]
        set myusel=abs(avgh-0.5*pi)<=abs(cleanatthetal-0.5*pi)
        set myuseh=abs(avgh-0.5*pi)<=abs(cleanatthetah-0.5*pi)
        set n=2
        set cleanfuncl=cleanvalue + (0.5-cleanvalue)*(abs(avgh**n-(0.5*pi)**n)-abs(cleanatthetal**n-(0.5*pi)**n)) / ( abs( 0**n-(0.5*pi)**n) - abs(cleanatthetal**n-(0.5*pi)**n))
        set cleanfunch=cleanvalue + (0.5-cleanvalue)*(abs((pi-avgh)**n-(pi-0.5*pi)**n)-abs((pi-cleanatthetah)**n-(pi-0.5*pi)**n)) / ( abs((pi-pi)**n-(pi-0.5*pi)**n) - abs((pi-cleanatthetah)**n-(pi-0.5*pi)**n))
        set cleanavgomegaf2l=(myusel==1 ? cleanavgomegaf2 : cleanfuncl  )
        set cleanavgomegaf2h=(myuseh==1 ? cleanavgomegaf2 : cleanfunch  )
        set cleanavgomegaf2=(avgh<0.5*pi ? cleanavgomegaf2l : cleanavgomegaf2h)
        #
        # FULL bz formula using code B1 and omegaf, not as in his paper's mono or paraboloidal models.
        set sigma=rhor**2+a**2*cos(avgh)**2
        set gdetbz=sigma*abs(sin(avgh))
        # add our gdet and remove their gdet
        set avgabsBr=dxdxp11*avgabsB1
        set avggdetTudEM10bz=-2*(avgabsBr)**2*(cleanavgomegaf2*omegah)*rhor*(omegah-cleanavgomegaf2*omegah)*sin(avgh)**2*(2*pi*gdetbz*dtheta)
        #*(fakegdet/(gdetbz*2*pi*dtheta))
        set omegah1=(1/2)
        #        set LdotEMvshbz=4*EdotEMvshbz*(omegah/omegah1)**(-1)
        #set LdotEMvshbz=8*EdotEMvshbz/(a)
        set avggdetTudEM13bz=avggdetTudEM10bz/(cleanavgomegaf2*omegah)
        # (omegah/omegah1)^{-1}=omegah1/omegah=(1/2)/(a/(2*rp)) = rp/a \sim 2/a for small a. 
        # omega=a/8 for small a
        #
        # integrate in theta around equator
        set intavgabsgdetB1=avgabsgdetB1*0
        set intavgabsgdetB1bz0=avgabsgdetB1*0
        set intavgabsgdetB1bz=avgabsgdetB1*0
        set intavgabsgdetB1bz2=avgabsgdetB1*0
        set intavgTudEM10=avgabsgdetB1*0
        set intavggdetTudEM10bz=avgabsgdetB1*0
        set intavggdetTudEM13bz=avgabsgdetB1*0
        set intavgTudMA10=avgabsgdetB1*0
        set intavgrhouu1=avgabsgdetB1*0
        set intavgTudEM13=avgabsgdetB1*0
        set intavgTudMA13=avgabsgdetB1*0
        #
        set maxbsqorho=30.0
        #
        set SAH=avgabsgdetB1*0
        # dx3/n3 takes care of fact that only 1 phi slice (that was averaged over all phi) is summed below
        #
        do jj=0,dimen(avgabsgdetB1)-1,1 {
          set myuse=(abs(avgh-pi*0.5)<=abs(avgh[$jj]-pi*0.5) ? 1 : 0)
          #set myuse=((avgh[$jj]-pi*0.5)<0 ? myuse*((avgh-pi*0.5)<0) : myuse*((avgh-pi*0.5)>0))
          #
          set preSAH=(1/rhor**2)*(fakegdet*dx2*(dx3*n3)*wedgef) if(myuse)
          set SAH[$jj]=SUM(preSAH)
          #
          set preintavgabsgdetB1=avgabsgdetB1*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgabsgdetB1[$jj]=SUM(preintavgabsgdetB1)
          #
          set preintavgabsgdetB1bz0=avgabsgdetB1bz0*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgabsgdetB1bz0[$jj]=SUM(preintavgabsgdetB1bz0)
          #
          set preintavgabsgdetB1bz=avgabsgdetB1bz*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgabsgdetB1bz[$jj]=SUM(preintavgabsgdetB1bz)
          #
          set preintavgabsgdetB1bz2=avgabsgdetB1bz2*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgabsgdetB1bz2[$jj]=SUM(preintavgabsgdetB1bz2)
          #
          set preintavgTudEM10=fakegdet*(-avgTudEM10)*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgTudEM10[$jj]=SUM(preintavgTudEM10)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz=(-avggdetTudEM10bz) if(myuse)
          set intavggdetTudEM10bz[$jj]=SUM(preintavggdetTudEM10bz)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz=(-avggdetTudEM13bz) if(myuse)
          set intavggdetTudEM13bz[$jj]=SUM(preintavggdetTudEM13bz)
          #
          set preintavgTudMA10=fakegdet*(-avgTudMA10)*dx2*(dx3*n3)*wedgef if(myuse && avgbsqorho<maxbsqorho)
          set intavgTudMA10[$jj]=SUM(preintavgTudMA10)
          #
          set preintavgrhouu1=fakegdet*(-avgrhouu1)*dx2*(dx3*n3)*wedgef if(myuse && avgbsqorho<maxbsqorho)
          set intavgrhouu1[$jj]=SUM(preintavgrhouu1)
          #
          set preintavgTudEM13=fakegdet*avgTudEM13*dx2*(dx3*n3)*wedgef if(myuse)
          set intavgTudEM13[$jj]=SUM(preintavgTudEM13)
          #
          set preintavgTudMA13=fakegdet*avgTudMA13*dx2*(dx3*n3)*wedgef if(myuse && avgbsqorho<maxbsqorho)
          set intavgTudMA13[$jj]=SUM(preintavgTudMA13)
        }
        #
        set Mdotvsh=intavgrhouu1*(abs(mdotfinavgvsr30[ihor]/(intavgrhouu1[0])))
        set EdotEMvsh=intavgTudEM10/abs(mdotfinavgvsr30[ihor])
        set EdotEMvshbz=intavggdetTudEM10bz/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz=intavggdetTudEM13bz/abs(mdotfinavgvsr30[ihor])
        set EdotMAvsh=(intavgTudMA10+intavgrhouu1)/abs(mdotfinavgvsr30[ihor])
        set LdotEMvsh=intavgTudEM13/(2*pi)/abs(mdotfinavgvsr30[ihor])
        set LdotMAvsh=intavgTudMA13/(2*pi)/abs(mdotfinavgvsr30[ihor])
        set preupsilon=(sqrt(2)*(1.0/abs(mdotfinavgvsr30[ihor]))*sqrt(abs(mdotfinavgvsr30[ihor])/SAH))
        set upsilon=intavgabsgdetB1*preupsilon
        set upsilonbz0=intavgabsgdetB1bz0*preupsilon
        set upsilonbz=intavgabsgdetB1bz*preupsilon
        set upsilonbz2=intavgabsgdetB1bz2*preupsilon
        # normalize so total flux same, not field at pole
        set upsilonbz0=upsilonbz0*(upsilon[0]/upsilonbz0[0])
        set upsilonbz=upsilonbz*(upsilon[0]/upsilonbz[0])
        set upsilonbz2=upsilonbz2*(upsilon[0]/upsilonbz2[0])
        #
        #
        #
velvsradpl 0 #
        #########################################
        # jet included:
        #pl 0 r vus1rhosq_vsr 1101 2.1 1E4 1E-3 1
        # jet not included, but still not over full disk+corona (i.e. non-jet)
        #pl 0 r vus1hor_vsr 1101 2.1 1E4 1E-4 1
        #pl 0 r vus3hor_vsr 1101 2.1 1E4 1E-4 1
        #pl 0 r beta 1101 (r[0]) 100 1E-3 1E3
        #
        # bounding box:
        #http://amath.colorado.edu/documentation/LaTeX/reference/bbox.html
        #
        #
        # these postencap's are setup on ki-jmck:
        # FINALPLOTS:
        device postencap3 rhovelvsr.eps
        panelplot1
        device X11
        !scp rhovelvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
        device postencap3 fluxvsr.eps
        panelplot2
        device X11
        !scp fluxvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
        device postencap4 othersvsr.eps
        panelplot3
        device X11
        !scp othersvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
        device postencap3 rhovelvsh.eps
        panelplot4
        device X11
        !scp rhovelvsh.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
        device postencap4 fluxvst.eps
        panelplot5
        device X11
        !scp fluxvst.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
        device postencap5 horizonflux.eps
        panelplot6
        device X11
        !scp horizonflux.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        #
panelplot1   0 #
		#
		#
        define myrin ((2.2))
		define myrout ((1E2))
        define xin (LG($myrin))
        define xout (LG($myrout))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 7
        #
		panelplot1replot
		#
panelplot1replot 0 #		
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-0.9)
        define lmaxy (2)
        limits $xin $xout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        pl 0 (LG(r)) (LG(rhoshorvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-0.9)
        define lmaxy (1.9)
        limits $xin $xout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "u_g"
        #
        pl 0 (LG(r)) (LG(ugshor_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize -1 0 -1 0
        define lminy (-3.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "-v_r"
        #
        pl 0 (LG(r)) (LG(-vus1hor_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "v_\phi"
        #
        pl 0 (LG(r)) (LG(vus3hor_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $xin $xout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "|b_r|"
        #
        pl 0 (LG(r)) (LG(bas1hor_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "|b_\theta|"
        #
        pl 0 (LG(r)) (LG(bas2hor_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $xin $xout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 1 2 0 0
        yla "|b|"
		xla "r/r_g"
        #
        pl 0 (LG(r)) (LG(sqrt(bsqhor_vsr))) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
		#
        #
panelplot2   0 #
		#
		#
        define myrin ((2.2))
		define myrout ((1E2))
        define xin (LG($myrin))
        define xout (LG($myrout))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 7
        #
		panelplot2replot
		#
panelplot2replot 0 #		
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0)
        define lmaxy (100)
        limits $xin $xout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\dot{M}"
        #
        pl 0 (LG(r)) ((mdotfinavgvsr30)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0)
        define lmaxy (130)
        #define lmaxy (3)
        limits $xin $xout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\dot{E}"
        #yla "\dot{E}/\dot{M}"
        #
        #pl 0 (LG(r)) ((eomdot)) 0011 $myrin $myrout $lminy $lmaxy
        pl 0 (LG(r)) ((edottotvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize -1 0 0 0
        define lminy (0)
        define lmaxy (1999)
        #define lmaxy (30)
        limits $xin $xout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "\dot{L}"
        #yla "\dot{L}/\dot{M}"
        #
        #pl 0 (LG(r)) ((lomdot)) 0011 $myrin $myrout $lminy $lmaxy
        pl 0 (LG(r)) ((ldottotvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.05))
        define lmaxy (LG(8100))
        limits $xin $xout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "\dot{M}_{\rm in}"
        #
        pl 0 (LG(r)) (LG(mdin_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.05))
        define lmaxy (LG(50))
        limits $xin $xout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "\dot{M}_{\rm j}"
        #
        pl 0 (LG(r)) (LG(mdjet_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.05))
        define lmaxy (LG(50))
        limits $xin $xout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "\dot{M}_{\rm mw}"
        #
        pl 0 (LG(r)) (LG(mdmwind_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.05))
        define lmaxy (LG(5000))
        limits $xin $xout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 1 2 0 0
        yla "\dot{M}_{\rm w}"
		xla "r/r_g"
        #
        pl 0 (LG(r)) (LG(mdwind_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
		#
        #
panelplot3   0 #
		#
		#
        define myrin ((2.2))
		define myrout ((1E2))
        define xin (LG($myrin))
        define xout (LG($myrout))
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 8
        #
		panelplot3replot
		#
panelplot3replot 0 #		
		###################################
        #
        ticksize -1 0 0 0
        define lminy (-0.2)
        define lmaxy (1.0)
        limits $xin $xout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\theta^d"
        #
        pl 0 (LG(r)) ((hoverr_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (-0.2)
        define lmaxy (pi/2)
        limits $xin $xout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\theta^{dc}"
        #
        pl 0 (LG(r)) ((hoverrcorona_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize -1 0 0 0
        define lminy (-0.2)
        define lmaxy (pi/2)
        limits $xin $xout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "\theta^{cj}"
        #
        pl 0 (LG(r)) ((hoverr_jet_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.1)
        define lmaxy (59)
        limits $xin $xout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "Q_1"
        #
        pl 0 (LG(r)) ((qmridisk_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2
        pl 0 (LG(r)) ((6+0*qmridisk_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.1)
        define lmaxy (4.5)
        limits $xin $xout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "Q_2"
        #
        pl 0 (LG(r)) ((q2mridisk_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2
        pl 0 (LG(r)) ((1.0+0*q2mridisk_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.01)
        define lmaxy (0.29)
        limits $xin $xout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "\alpha"
        #
        pl 0 (LG(r)) ((alphamag2_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (1.9)
        define lmaxy (3.9)
        limits $xin $xout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 0 2 0 0
        yla "\Phi"
        #
        pl 0 (LG(r)) (LG(fstot_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (0)
        define lmaxy (2.5)
        limits $xin $xout $lminy $lmaxy
        define nm7 ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm7 box 1 2 0 0
        yla "\Phi_{\rm eq}"
		xla "r/r_g"
        #
        pl 0 (LG(r)) (LG(feqtot_vsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
		#
panelplot4   0 #
		#
		#
        define myhin 0
		define myhout (pi)
        # 
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 7
        #
		panelplot4replot
		#
panelplot4replot 0 #		
		###################################
        #
        #
        ticksize 0 0 -1 0
        define lminy (-0.9)
        define lmaxy (2)
        limits $myhin $myhout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0"
        #
        set rhosrhosqrad4_vshclean=(bsqrhosqrad4_vsh/rhosrhosqrad4_vsh<maxbsqorho ? rhosrhosqrad4_vsh : 0)
        set rhosrhosqrad8_vshclean=(bsqrhosqrad8_vsh/rhosrhosqrad8_vsh<maxbsqorho ? rhosrhosqrad8_vsh : 0)
        set rhosrhosqrad30_vshclean=(bsqrhosqrad30_vsh/rhosrhosqrad30_vsh<maxbsqorho ? rhosrhosqrad30_vsh : 0)
        #
        ltype 0 pl 0 ((hinnx4)) (LG(rhosrhosqrad4_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(rhosrhosqrad8_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(rhosrhosqrad30_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-0.9)
        define lmaxy (1.9)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "u_g"
        #
        set ugsrhosqrad4_vshclean=(bsqrhosqrad4_vsh/rhosrhosqrad4_vsh<maxbsqorho ? ugsrhosqrad4_vsh : 0)
        set ugsrhosqrad8_vshclean=(bsqrhosqrad8_vsh/rhosrhosqrad8_vsh<maxbsqorho ? ugsrhosqrad8_vsh : 0)
        set ugsrhosqrad30_vshclean=(bsqrhosqrad30_vsh/rhosrhosqrad30_vsh<maxbsqorho ? ugsrhosqrad30_vsh : 0)
        #
        ltype 0 pl 0 ((hinnx4)) (LG(ugsrhosqrad4_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(ugsrhosqrad8_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(ugsrhosqrad30_vshclean)) 0011 $myhin $myhout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 -1 0
        define lminy (-3.9)
        define lmaxy (0.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "|v_r|"
        #
        ltype 0 pl 0 ((hinnx4)) (LG(vuas1rhosqrad4_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(vuas1rhosqrad8_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(vuas1rhosqrad30_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "v_\phi"
        #
        ltype 0 pl 0 ((hinnx4)) (LG(vuas3rhosqrad4_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(vuas3rhosqrad8_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(vuas3rhosqrad30_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "|b_r|"
        #
        ltype 0 pl 0 ((hinnx4)) (LG(bas1rhosqrad4_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(bas1rhosqrad8_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(bas1rhosqrad30_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "|b_\theta|"
        #
        ltype 0 pl 0 ((hinnx4)) (LG(bas2rhosqrad4_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(bas2rhosqrad8_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(bas2rhosqrad30_vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 1 2 0 0
        yla "|b|"
		xla "\theta"
        #
        ltype 0 pl 0 ((hinnx4)) (LG(sqrt(bsqrhosqrad4_vsh))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx8)) (LG(sqrt(bsqrhosqrad8_vsh))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx30)) (LG(sqrt(bsqrhosqrad30_vsh))) 0011 $myhin $myhout $lminy $lmaxy
        #
		##########################
		#
        #
panelplot5   0 #
		#
		#
        define mytin (ts[0])
		define mytout (ts[dimen(ts)-1])
        # 
		#
		fdraft
		ctype default window 8 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 8 1 1 1
		notation -4 4 -4 4
		erase
		#
        define numpanels 8
        #
		panelplot5replot
		#
panelplot5replot 0 #		
		###################################
        #
        #
        ticksize 0 0 -1 0
        define lminy (-0.9)
        define lmaxy (3)
        limits $mytin $mytout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\dot{M}"
        #
        ltype 0 pl 0 ((ts)) (LG(mdothor)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) (LG(mdinrdiskout)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 1 pl 0 ((ts)) (LG(mdjetrjetout)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) (LG(mdmwindrjetout)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 1 pl 0 ((ts)) (LG(mdwindrdiskout)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-1)
        define lmaxy (4.5)
        limits $mytin $mytout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\eta_{\rm BH}"
        #
        ltype 0 pl 0 ((ts)) ((etabhEM/100)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((etabhMAKE/100)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-4)
        define lmaxy (39.5)
        limits $mytin $mytout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "\dot{L}/\dot{M}"
        #
        ltype 0 pl 0 ((ts)) ((letabhEM/100)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((letabhMAKE/100)) 0011 $mytin $mytout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.2)
        define lmaxy (pi/4)
        limits $mytin $mytout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "|\frac{h}{r}|"
        #
        ltype 0 pl 0 ((ts)) ((hoverrhor)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((hoverr2)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((hoverr5)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 1 pl 0 ((ts)) ((hoverr20)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 3 pl 0 ((ts)) ((hoverr100)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (49)
        limits $mytin $mytout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "\Upsilon"
        #
        ltype 0 pl 0 ((ts)) ((phibh)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((phij)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 1 pl 0 ((ts)) ((phirdiskin)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((phirdiskout)) 0011 $mytin $mytout $lminy $lmaxy
        #
        #  phimwin phimwout phiwin phiwout 
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (LG(r[0]))
        define lmaxy (LG(5.3*r[dimen(r)-1]))
        #define lmaxy (3)
        limits $mytin $mytout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "r_{\rm flux,stag}"
        #
        ltype 0 pl 0 ((ts)) (LG(rifmaxvst)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) (LG(reqstagvst)) 0011 $mytin $mytout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 0 0
        define lminy (-0.02)
        define lmaxy (0.11)
        limits $mytin $mytout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 0 2 0 0
        #yla "\frac{\Phi_{\rm BH}}{\Phi_{\rm BH}}"
        yla "\Phi/\Phi_{as}"
        #
        #ltype 0 pl 0 ((ts)) ((fstotnormA0)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 0 pl 0 ((ts)) ((fstotnormA1)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((fstotnormA2)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 0 pl 0 ((ts)) ((fstotnormC)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((fstotnormBwhichfirstlimited)) 0011 $mytin $mytout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 0 0
        define lminy (-9)
        define lmaxy (9)
        limits $mytin $mytout $lminy $lmaxy
        define nm7 ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm7 box 1 2 0 0
        #yla "\frac{\Phi_{\rm BH}}{\Psi_{\rm BH}}"
        yla "\Phi/\Psi"
		xla "tc/r_g"
        #
        ltype 0 pl 0 ((ts)) ((fstotnormD)) 0011 $mytin $mytout $lminy $lmaxy
        #
		##########################
		#
        #
panelplot6   0 #
		#
		#
        #define myhin (pi/4)
		#define myhout (pi-pi/4)
        define myhin (0)
		define myhout (pi)
        # 
		#
		fdraft
		ctype default window 8 1 1 1
		notation -4 4 -4 4
		erase
		#
		fdraft
		ctype default window 8 1 1 1
		notation -4 4 -4 4
		erase
		#
        #        define numpanels 5
        define numpanels 5
        #
		panelplot6replot
		#
panelplot6replot 0 #		
        #
        #
        #
        ticksize 0 0 0 0
        define lminy (-.5)
        define lmaxy (0.6)
        limits $myhin $myhout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\Omega_F/\Omega_H"
        #
		###################################
        # omegaf/omegah\sim 0.33 in most of magnetosphere
        # But drifts down to omegaf/omegah\sim 0.25 near disk
        # Within disk it's noisy and has an average value of omegaf/omegah\sim 0.1
        ltype 0 pl 0 avgh cleanavgomegaf2 0011 $myhin $myhout  $lminy $lmaxy
        ltype 2 pl 0 avgh (0.5+cleanavgomegaf2*0) 0011 $myhin $myhout $lminy $lmaxy
        #ltype 1 pl 0 avgh (0.33+cleanavgomegaf2*0) 0011 $myhin $myhout $lminy $lmaxy
        #ltype 2 pl 0 avgh (0.25+cleanavgomegaf2*0) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh (omegafohpara) 0011 $myhin $myhout $lminy $lmaxy
        #
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (55)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\dot{M}"
        #
        ltype 0 pl 0 avgh ((Mdotvsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-1)
        define lmaxy (3.8)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        #yla "\dot{E}/\dot{M}"
        yla "\eta_{\rm BH}"
        #
        ltype 0 pl 0 avgh ((EdotEMvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 avgh ((EdotMAvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh ((EdotEMvshbz)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-20)
        define lmaxy (50)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\dot{L}/\dot{M}"
        #
        ltype 0 pl 0 avgh ((LdotEMvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 avgh ((LdotMAvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh ((LdotEMvshbz)) 0011 $myhin $myhout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (24)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm1 box 1 2 0 0
        yla "\Upsilon"
        xla "\theta"
        #
        #
        #
        ltype 0 pl 0 avgh (upsilon) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 avgh (upsilonbz) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh (upsilonbz2) 0011 $myhin $myhout $lminy $lmaxy
        #ctype blue pl 0 avgh (upsilonbz0) 0011 $myhin $myhout $lminy $lmaxy
        #ctype default
        #
		###################################
        if(1==0){
        #
        ticksize 0 0 0 0
        define lminy (-4)
        define lmaxy (5)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm1 box 1 2 0 0
        yla "-\mu  \sigma  b^2/\rho_0  \gamma"
        #
        ltype 0 pl 0 avgh ((-avgmu)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 avgh ((avgsigma)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh ((avgbsqorho)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 avgh ((avggamma)) 0011 $myhin $myhout $lminy $lmaxy
        #
        }
		###################################
