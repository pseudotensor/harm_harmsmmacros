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
#
#
#
#
#
#
#####################################################
######################################################
#       FINALPLOTS : run: velvsrad <0/1>
velvsrad 1 #
        #
        set doscp=$1
        #
        velvsradrd
        velvsradpl $1
        #
velvsradrd 0 #
        # datavsr1.txt: rho,u over non-jet, v,B over whole flow
        # datavsr1b.txt : all only over bsq/rho<=1
        # datavsr1c.txt : all only in non-jet and density weighted to focus on disky part
        # datavsr2.txt: rho,u,v,B at equator no matter disk or jet
        # datavsr3.txt: rho,u over 2.5*hoverr3d non-jet and v,B over 2.5*hoverr3d
        # datavsr4.txt: rho,u,v,B over 2.0*hoverr3d non-jet
        #
        ################################################
        da datavsr1.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosq_vsr ugsrhosq_vsr uu0rhosq_vsr vus1rhosq_vsr vuas1rhosq_vsr vus3rhosq_vsr vuas3rhosq_vsr Bs1rhosq_vsr Bas1rhosq_vsr Bs2rhosq_vsr Bas2rhosq_vsr Bs3rhosq_vsr Bas3rhosq_vsr bs1rhosq_vsr bas1rhosq_vsr bs2rhosq_vsr bas2rhosq_vsr bs3rhosq_vsr bas3rhosq_vsr bsqrhosq_vsr}
        #
        da datavsr1b.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqdc_vsr ugsrhosqdc_vsr uu0rhosqdc_vsr vus1rhosqdc_vsr vuas1rhosqdc_vsr vus3rhosqdc_vsr vuas3rhosqdc_vsr Bs1rhosqdc_vsr Bas1rhosqdc_vsr Bs2rhosqdc_vsr Bas2rhosqdc_vsr Bs3rhosqdc_vsr Bas3rhosqdc_vsr bs1rhosqdc_vsr bas1rhosqdc_vsr bs2rhosqdc_vsr bas2rhosqdc_vsr bs3rhosqdc_vsr bas3rhosqdc_vsr bsqrhosqdc_vsr}
        #
        da datavsr1c.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqdcden_vsr ugsrhosqdcden_vsr uu0rhosqdcden_vsr vus1rhosqdcden_vsr vuas1rhosqdcden_vsr vus3rhosqdcden_vsr vuas3rhosqdcden_vsr Bs1rhosqdcden_vsr Bas1rhosqdcden_vsr Bs2rhosqdcden_vsr Bas2rhosqdcden_vsr Bs3rhosqdcden_vsr Bas3rhosqdcden_vsr bs1rhosqdcden_vsr bas1rhosqdcden_vsr bs2rhosqdcden_vsr bas2rhosqdcden_vsr bs3rhosqdcden_vsr bas3rhosqdcden_vsr bsqrhosqdcden_vsr}
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
        ################################################################
        # only read some of the data that's required for the BZ comparison plot
        da dataavgvsh0.txt
        lines 1 2
        read {avg_ts 1 avg_te 2 avg_nitems 3 a 4 rhor 5 ihor 6 dx1 7 dx2 8 dx3 9 wedgef 10 n1 11 n2 12 n3 13}
        da dataavgvsh1.txt
        lines 2 1000000
        read {avgjj 1 avgh 2 avgrho 3 avgug 4 avgbsq 5 avgunb 6}
        read {avguu0 7 avguu1 8 avguu2 9 avguu3 10}
        read {avgud0 15 avgud1 16 avgud2 17 avgud3 18}
        read {avgB1 23 avgB2 24 avgB3 25}
        read {avggdetB1 26 avggdetB2 27 avggdetB3 28}
        read {avgrhouu1 34}
        read {avgomegaf2 29 avgomegaf2b 30 avgomegaf1 31 avgomegaf1b 32}
        read {avgTud10 58 avgTud13 70 avgTudEM10 170 avgTudEM13 182 avgTudMA10 186 avgTudMA13 198 avgTudPA10 202 avgTudPA13 214 avgTudIE10 218 avgTudIE13 230}
        set avgTudMAKE10=-avgTudMA10-avgrhouu1
        # print {avgh avgbsqorho avgTudEM10 avgTudMA10 avgrhouu1 avgTudPA10 avgTudIE10}
        read {avgmu 233 avgsigma 234 avgbsqorho 235 avgabsB1 236 avgabsgdetB1 239 avggamma 243}
        read {avggdet 244 avgdxdxp11 245 avgdtheta 246}
        #
        bzcomparisonsetup
        #
        ########################################################
        # avg1.write("#avg_rho avg_ug avg_bsq avg_unb avg_uu avg_bu avg_ud avg_bd avg_B avg_gdetB avg_omegaf2 avg_omegaf2b avg_omegaf1 avg_omegaf1b avg_rhouu avg_rhobu avg_rhoud avg_rhobd avg_uguu avg_ugud avg_Tud avg_fdd avg_rhouuud avg_uguuud avg_bsquuud avg_bubd avg_uuud avg_TudEM  avg_TudMA  avg_TudPA  avg_TudIE  avg_mu  avg_sigma  avg_bsqorho  avg_absB  avg_absgdetB  avg_psisq avg_gamma avggdet dxdxp11 dxdxp22dx2 rhosqint")
        #set omegaf1=fdd01/fdd13 # = ftr/frp
        #set omegaf2=fdd02/fdd23 # = fth/fhp
        #set aomegaf1=afdd01/afdd13 # = ftr/frp
        #set aomegaf2=afdd02/afdd23 # = fth/fhp
        ################################################################
        # only read some of the data that's required for the Gammie plot
        da dataavgvsr0.txt
        lines 1 2
        read {avgvsr_ts 1 avgvsr_te 2 avgvsr_nitems 3 a 4 rhor 5 ihor 6 dx1 7 dx2 8 dx3 9 wedgef 10 n1 11 n2 12 n3 13}
        !sed 's/nan/0/g' dataavgvsr1.txt > dataavgvsr1n.txt
        !sed 's/inf/0/g' dataavgvsr1n.txt > dataavgvsr1nn.txt
        da dataavgvsr1nn.txt
        lines 2 1000000
        read {avgvsrii 1 avgvsrr 2 avgvsrrho 3 avgvsrug 4 avgvsrbsq 5 avgvsrunb 6}
        read {avgvsruu0 7 avgvsruu1 8 avgvsruu2 9 avgvsruu3 10}
        read {avgvsrud0 15 avgvsrud1 16 avgvsrud2 17 avgvsrud3 18}
        read {avgvsrB1 23 avgvsrgdetB1 26 avgvsrrhouu1 34 avgvsromegaf2 29 avgvsromegaf2b 30 avgvsromegaf1 31 avgvsromegaf1b 32}
        read {avgvsrTud10 58 avgvsrTud13 70 avgvsrTudEM10 170 avgvsrTudEM13 182 avgvsrTudMA10 186 avgvsrTudMA13 198 avgvsrTudPA10 202 avgvsrTudPA13 214 avgvsrTudIE10 218 avgvsrTudIE13 230}
        read {fdd00 73 fdd10 74 fdd20 75 fdd30 76 fdd01 77 fdd11 78 fdd21 79 fdd31 80 fdd02 81 fdd12 82 fdd22 83 fdd32 84 fdd03 85 fdd13 86 fdd23 87 fdd33 88}
        set avgvsrTudMAKE10=-avgvsrTudMA10-avgvsrrhouu1
        # print {avgvsrh avgvsrbsqorho avgvsrTudEM10 avgvsrTudMA10 avgvsrrhouu1 avgvsrTudPA10 avgvsrTudIE10}
        read {avgvsrmu 233 avgvsrsigma 234 avgvsrbsqorho 235 avgvsrabsB1 236 avgvsrabsgdetB1 239 avgvsrabsgdetB2 240 avgvsrabsgdetB3 241 avgvsrgamma 243}
        read {avgvsrgdet 244 avgvsrdxdxp11 245 avgvsrdxdxp22 246 avgvsrdxdxp12 247 avgvsrdxdxp21 248 avgvsrdxdxp33 249}
        read {avgvsrhor 250 avgvsrrhosqint 251 avgvsrrhosqint2 252}
        # omegaf2b=np.fabs(vphi) + (vpol/Bpol)*np.fabs(B[3])
        set omegaalt1=avgvsruu3/avgvsruu0 - (avgvsruu1/avgvsruu0/avgvsrabsgdetB1)*avgvsrabsgdetB3
        set omegaalt2=fdd02/fdd23
        set omegaalt3=fdd01/fdd13
        #
        4panelinflowsetup
        #
        defaults
        ltype 0 pl 0 avgvsrr avgvsromegaf2 1000
        ltype 2 pl 0 avgvsrr omegaalt1 1010
        ltype 1 pl 0 avgvsrr omegaalt2 1010
        ltype 3 pl 0 avgvsrr omegaalt3 1010
        #
        ################################################################
        #
        ################
        # powervsm
        #
        # powervsm%d%s_%s.txt" % (filenum,fileletter,pllabel)
        #(_dx1,_dx2,_dx3))
        #("ii","xtoplot","ytoplot"))
        #(normpowersumnotm0a,normpowersumnotm0b,np.fabs(qty[0]),(1.0/_dx1)*np.fabs(qty[0])))
        #
        #
        #
        define filename powervsm7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1radhor}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1radhor}
        #
        define filename powervsm9vsma_FMrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad4}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad4}
        #
        define filename powervsm9vsmb_FMrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad8}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad8}
        #
        define filename powervsm9vsmc_FMrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad30}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad30}
        #
        ###########################
        define filename powervsm1vsmz_rhosrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2radhor}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2radhor}
        #
        #
        define filename powervsm1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad4}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad4}
        #
        define filename powervsm1vsmb_rhosrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad8}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad8}
        #
        define filename powervsm1vsmc_rhosrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad30}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad30}
        #
        ##############################
        #
        define filename powervsm2vsmz_ugsrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3radhor}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3radhor}
        #
        define filename powervsm2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad4}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad4}
        #
        define filename powervsm2vsmb_ugsrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad8}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad8}
        #
        define filename powervsm2vsmc_ugsrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad30}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad30}
        #
        ##############################
  
        define filename powervsm6vsmz_bsqrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4radhor}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4radhor}
        #
        define filename powervsm8vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad4}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad4}
        #
        define filename powervsm8vsmb_bsqrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad8}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad8}
        #
        define filename powervsm8vsmc_bsqrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad30}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad30}
        #
        ##############################
        define filename powervsm9vsmz_FEEMrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5radhor}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5radhor}
        #
        define filename powervsm11vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad4}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad4}
        #
        define filename powervsm11vsmb_FEEMrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad8}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad8}
        #
        define filename powervsm11vsmc_FEEMrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad30}
        !head -3 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad30}
        #
        #
        #
        #
velvsradpl 1 # velvsradpl <doscp=0,1>
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
        if(doscp==1){\
         !scp rhovelvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap3 fluxvsr.eps
        panelplot2
        device X11
        if(doscp==1){\
        !scp fluxvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap4 othersvsr.eps
        panelplot3
        device X11
        if(doscp==1){\
        !scp othersvsr.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap3 rhovelvsh.eps
        panelplot4
        device X11
        if(doscp==1){\
        !scp rhovelvsh.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap4 fluxvst.eps
        panelplot5
        device X11
        if(doscp==1){\
        !scp fluxvst.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap5 horizonflux.eps
        panelplot6
        device X11
        if(doscp==1){\
        !scp horizonflux.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap5 powervsm.eps
        panelplot7
        device X11
        if(doscp==1){\
        !scp powervsm.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        device postencap gammieplot.eps
        gammieplot
        device X11
        if(doscp==1){\
        !scp gammieplot.eps jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
        }
        #
        #
        #
        # T^r_t[EM] = b^2 u^r u_t - b^r b_t = (B^2 + (u.b)^2) u^r u_t / (u_t u^t) - (B^r + u^r (u.B))/u^t (B_t + u_t (u.b))/u_t
        #
        #
bzcomparisonsetup 0 #
        ###########################
        # PROCESS/SETUP vs. theta stuff for BZ comparison
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
        set corr=(a/rhor)**2 * (-2*cos(avgh)+rhor**2*(1+3*cos(2*avgh))*fofr)
        #set corr=0.0
        set avgabsgdetB1bz=(avgabsgdetB1/avgabsB1)*avgabsB1[0]*(1+corr)
        set hbz=(avgh<=pi/2) ? avgh : (pi-avgh)
        set faker=2  #rhor
        # gdet B^1 dx2 dx3 = r**2 sin(hbz) B^r dh dphi = dtheta A_\phi,\theta
        set avgabsgdetB1bz2=( (faker+2.0*ln(1+cos(hbz)))*sin(hbz) )*avgdtheta
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
        set cleanavgomegaf2=(avgomegaf2*2*pi/omegah)
        #
        # floor correction to sensitive quantity:
        set docleanomegaf=0
        #
        #
        if(docleanomegaf==1){\
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
        }
        #
        #
        #
        # FULL bz formula using code B1 and omegaf, not as in his paper's mono or paraboloidal models.
        #set chooseomegaf=cleanavgomegaf2*omegah
        set chooseomegaf=avgomegaf2*2*pi
        #
        set sigma=rhor**2+a**2*cos(avgh)**2
        set gdetbz=sigma*abs(sin(avgh))
        # add our gdet and remove their gdet
        set avgabsBr=avgdxdxp11*avgabsB1
        set avggdetTudEM10bz=-2*(avgabsBr)**2*(chooseomegaf)*rhor*(omegah-chooseomegaf)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        #*(fakegdet/(gdetbz*2*pi*avgdtheta))
        set omegah1=(1/2)
        #        set LdotEMvshbz=4*EdotEMvshbz*(omegah/omegah1)**(-1)
        #set LdotEMvshbz=8*EdotEMvshbz/(a)
        set avggdetTudEM13bz=avggdetTudEM10bz/(chooseomegaf)
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
        set tickjj=0,dimen(avgabsgdetB1)-1,1
        #
        set intfromeq=0
        #
        do jj=0,dimen(avgabsgdetB1)-1,1 {
          #
          #set myuse=(abs(avgh-pi*0.5)<=abs(avgh[$jj]-pi*0.5) ? 1 : 0)
          #set myuse=((avgh[$jj]-pi*0.5)<0 ? myuse*((avgh-pi*0.5)<0) : myuse*((avgh-pi*0.5)>0))
          #
          if(intfromeq==1){\
           set rhs=(abs($jj-dimen(avgabsgdetB1)/2))
           set myuse=(abs(tickjj-dimen(avgabsgdetB1)/2))<rhs
          }\
          else{\
           set rhs=(abs($jj+0.5-dimen(avgabsgdetB1)/2))
           set myuse=(abs(tickjj+0.5-dimen(avgabsgdetB1)/2))>=rhs
          }
          #
          # debug:
          #set summyuse=SUM(myuse)
          #set setjj=$jj
          #print{setjj summyuse rhs}
          #
          #
          #
          set preSAH=(1/rhor**2)*(fakegdet*dx2*(dx3*n3)*wedgef/avgdxdxp11) if(myuse)
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
        if(intfromeq==1){\
          set chosencum=0
        }\
        else{\
          set chosencum=dimen(intavgrhouu1)/2 # 2 positions in reality, but both same value
        }
        #
        set Mdotvsh=intavgrhouu1*(abs(mdotfinavgvsr30[ihor]/(intavgrhouu1[chosencum])))
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
        set upsilonbz0=upsilonbz0*(upsilon[chosencum]/upsilonbz0[chosencum])
        set upsilonbz=upsilonbz*(upsilon[chosencum]/upsilonbz[chosencum])
        set upsilonbz2=upsilonbz2*(upsilon[chosencum]/upsilonbz2[chosencum])
        #
        # DONE PROCESS/SETUP for BZ COMPARISON
        #
        #
trygammies 0 #
        do iijj=5,20,1 {\
          4panelinflowsetup2 upsilongammie 1000 $iijj
          set printiijj=$iijj
          print {printiijj}
        }
        #
        #
4panelinflowsetup 0 # Gammie plot setup all parts
        4panelinflowsetup1
        #
        # get Gammie solution
        #        set upsilongammie=upsilonH*1.5
        set upsilongammie=upsilonH*1.7 # matches F_L better even though bsq a bit worse still looks good in log
        #4panelinflowsetup2 upsilongammie 1000 43
        #4panelinflowsetup2 upsilongammie 1000 7000
        4panelinflowsetup2 upsilongammie 1000 5
        #
        #      gfl  tdlinfisco         gfe  tdeinfisco
        #       1.017        1.95    -0.05233      0.8209
        #
        4panelinflowsetup3
        #
        # for plots
        #define rinner $grin
        #define router $grout
        define rinner (rhor)
        #define rinner (1)
        define router (10)
        #
        #
4panelinflowsetup1 0 # Gammie plot setup
        #
        # need uurvsr, bsqvsr, rhovsr, uvsr, hor, gdetvsr, uu0vsr, ud0vsr, uuphivsr, udphivsr, ud0vsr, Tud10Bvsr, Tud10PAvsr, Tud10IEvsr, Tud13Bvsr, Tud13PAvsr, Tud13IEvsr
        set dxdxp11=avgvsrdxdxp11
        set dxdxp12=avgvsrdxdxp12
        set dxdxp21=avgvsrdxdxp21
        set dxdxp22=avgvsrdxdxp22
        set dxdxp33=avgvsrdxdxp33
        #
        # inverse of dx^{ks}/dx^{mks}
        set idxdxp11=dxdxp22/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
        set idxdxp12=dxdxp12/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
        set idxdxp21=dxdxp21/(dxdxp21*dxdxp12-dxdxp22*dxdxp11)
        set idxdxp22=dxdxp11/(dxdxp22*dxdxp11-dxdxp21*dxdxp12)
        set idxdxp33=1/dxdxp33
        #
        set uutvsr=avgvsruu0
        set uurvsr=-(avgvsruu1*dxdxp11+avgvsruu2*dxdxp12) # - so matches gammie
        set uuhvsr=avgvsruu1*dxdxp21+avgvsruu2*dxdxp22
        set uupvsr=avgvsruu3*dxdxp33
        #
        set udtvsr=avgvsrud0
        set udrvsr=avgvsrud1*idxdxp11+avgvsrud2*idxdxp21
        set udhvsr=avgvsrud1*idxdxp12+avgvsrud2*idxdxp22
        set udpvsr=avgvsrud3*idxdxp33
        #
        set bsqvsr=avgvsrbsq
        set rhovsr=avgvsrrho
        set uvsr=avgvsrug
        set hor=avgvsrhor
        set gdetvsr=avgvsrgdet
        set uu0vsr=uutvsr
        set uuphivsr=uupvsr
        set udphivsr=udpvsr
        set ud0vsr=udtvsr
        #
        # want below to be fluxes, not averages
        # GODMARK: Until new averages are created, floor contamination in these averages will mean not as flat vs. radius as vsr versions that took at the floor.
        # assuming sign not modified during avgvsr creation, then - added below since gammie comparison is such that inflow of +angle momentum gives + value
        # i.e. Ldot/Mdot>0 with Mdot>0 means inflow of mass and Ldot>0 means inflow of + ang momentum (+ meaning w.r.t. \phi and normally disk rotates with +\phi as set by IC)
        set Tud10Bvsr=-avgvsrTudEM10*avgvsrrhosqint
        set Tud10PAvsr=-avgvsrTudPA10*avgvsrrhosqint
        set Tud10IEvsr=-avgvsrTudIE10*avgvsrrhosqint
        set Tud13Bvsr=-avgvsrTudEM13*avgvsrrhosqint
        set Tud13PAvsr=-avgvsrTudPA13*avgvsrrhosqint
        set Tud13IEvsr=-avgvsrTudIE13*avgvsrrhosqint
        #
        set newr=avgvsrr
        set Dphi=2*pi
        set boxfactor=(2*pi)/(Dphi)
        #
        #
        # then compute:
        #
        # compute Upsilon from code
        #set preupsilon=(sqrt(2)*(1.0/abs(mdotfinavgvsr30[ihor]))*sqrt(abs(mdotfinavgvsr30[ihor])/SAH))
        #set upsilon=intavgabsgdetB1*preupsilon
        #
        set intBr=avgvsrabsB1*avgvsrrhosqint
        set intFM=avgvsrrhouu1*avgvsrrhosqint
        set intFM=intFM*abs(mdotfinavgvsr30[ihor])/intFM[ihor]
        set FMvsr=intFM
        set intFMHa=avgvsrrhouu1[ihor]*avgvsrrhosqint[ihor]
        set intFMHb=abs(mdotfinavgvsr30[ihor]) # use better mass accretion rate since avg calculations don't yet exclude bsq/rho>30
        set intFMH=intFMHb
        set SA=(1/avgvsrr**2)*(avgvsrrhosqint/avgvsrdxdxp11)
        set SAH=SA[ihor]
        #
        # so now just upsilon for the non-jet region, which will be lower than the hole 4\pi region because jet has no Mdot but lots of flux.
        set upsilonvsr=sqrt(2)*(intBr/intFM)*sqrt(intFMH/SAH)
        set upsilonH=upsilonvsr[ihor]
        #
        if(a>=0.0){\
         riscocalc 0 risco # assumes stuff always goes positive
         riscocalc 1 risco2 # assumes stuff always goes positive
        }
        if(a<0.0){\
         riscocalc 1 risco # assumes stuff always goes positive
         riscocalc 0 risco2 # assumes stuff always goes positive
        }
        riscocalc 0 riscoprograde
        riscocalc 1 riscoretrograde
        elinfcalc risco tdeinfisco tdlinfisco
        #
        #
        #
4panelinflowsetup2 3 # 4panelinflowsetup Upsilon 10000 2030
		# get gammie solution
		define magpar ($1)
		define bhspin (a)
		define numpoints ($2)
		!./inf_const $magpar $bhspin $numpoints > ./gammiesol1.txt
		!tail -1 gammiesol1.txt > gammiesol2.txt
		da gammiesol2.txt
		lines 1 1
		read {gfl 3 gfe 4}
		print {gfl tdlinfisco gfe tdeinfisco}
		set tdfevsr=tdeinfisco+newr*0
		set tdflvsr=tdlinfisco+newr*0
		#
		define gammieFL (gfl)
		define gammieFE (gfe)
		#		define size (dimen(newr))
		define size ($3)
		!./inf_solv $magpar $bhspin $gammieFL $gammieFE $size > gammiesolve1.txt
		da gammiesolve1.txt
		lines 1 10000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {gr guu0 guu1 guu2 guu3 gl grho gE gfdd02 gfdd12 gMaf ged gB1 gB3}
		#
		# gfdd02 should be constant
		#
		set gB2=gB3*0
		#set gD=1-2/gr+a**2/gr**2
		#set gEoM=gD*gfdd02*gfdd12/(gr**2)
		#set gEtot=gE+gEoM
		#
		set gFEtot=-gfe+0*gE
		set gFEEM=-(-gFEtot+gE)
		#
		set gFLtot=-gfl+0*gE
		set gFLEM=-(-gFLtot+gl)
		#
		# jon's way of computing ged
		set gh=gr*0+pi/2
		set sigmabl=gr**2+a**2*cos(gh)**2
		set deltabl=gr**2-2*gr+a**2
		set Abl=(gr**2+a**2)**2-deltabl*a**2*sin(gh)**2
		#
		# total comoving energy for inflow solution
		set gco=ged+grho
		#
		set ggv00=-1+2*gr/sigmabl
		set ggv01=0
		set ggv02=0
		set ggv03=-2*a*gr*sin(gh)**2/sigmabl
		set ggv10=ggv01
		set ggv11=sigmabl/deltabl
		set ggv12=0
		set ggv13=0
		set ggv20=ggv02
		set ggv21=ggv12
		set ggv22=sigmabl
		set ggv23=0
		set ggv30=ggv03
		set ggv31=ggv13
		set ggv32=ggv23
		set ggv33=Abl*sin(gh)**2/sigmabl
		#
		#
		set gbu0=0		
		do ii=1,3,1 {\
		       do jj=0,3,1 {\
		       define kk (sprintf('%d',$ii)+sprintf('%d',$jj))
		       set gbu0=gbu0+gB$ii * guu$jj * ggv$kk
		    }
		 }
		 #
		 set gbu1=(gB1+gbu0*guu1)/guu0
		 set gbu2=(gB2+gbu0*guu2)/guu0
		 set gbu3=(gB3+gbu0*guu3)/guu0
		 set gbd0=ggv00*gbu0+ggv01*gbu1+ggv02*gbu2+ggv03*gbu3
		 set gbd1=ggv10*gbu0+ggv11*gbu1+ggv12*gbu2+ggv13*gbu3
		 set gbd2=ggv20*gbu0+ggv21*gbu1+ggv22*gbu2+ggv23*gbu3
		 set gbd3=ggv30*gbu0+ggv31*gbu1+ggv32*gbu2+ggv33*gbu3
		 # since used B1,B3 with 4pi's taken out, just like jon/code b^2
		 set gbsq=gbu0*gbd0+gbu1*gbd1+gbu2*gbd2+gbu3*gbd3
		 set mygbsqvsr=gbsq/2
		 #
		 # this is my version with absorbed 4pi factors
		 #rdraft
         define grin (gr[0])
         define grout (gr[dimen(gr)-1])
		 ctype default pl 0 gr mygbsqvsr 0101 $grin $grout 1E-5 1E1
		 # this is gammie output with apparently absorbed 4pi factors
		 ctype red pl 0 gr ged 0111 $grin $grout 1E-5 1E1
		 #
4panelinflowsetup3
         # Gammie F_M = -1  = 2*pi*r**2*rho*uur
         # use uur since need to use to make dimensionless from Gammie definition
         #set FMden=2*pi*gdet*rho*auur/(4*pi)*boxfactor
         #gcalc2 8 2 hor FMden FMdenvsr $rinner $router
         #
         #
         # correct FMden for quantities that aren't flux integrals for which FM is divisor
         # below works for no stratification.
         #set divfactor=1/(2*hor[0])
         set divfactor=1/(2*sin(hor[0]))
         set FMvsrg1=FMvsr[0]/(2*hor[0])*boxfactor + FMvsr*0
         #
         # below better when there is stratification, but requires u^r be similar to Gammie model at horizon.
         set FMgammie=grho*guu1
         set factorG=1.0
         set FMvsrg2=factorG*((rhovsr[0]*uurvsr[0])/FMgammie[0])
         #
         set FMvsrg=FMvsrg1
         #
         set bcog=(bsqvsr*0.5)/(FMvsrg)
         set rhovsrg=rhovsr/(FMvsrg)
         set uvsrg=uvsr/(FMvsrg)
         #
         # total comoving energy density
         set ecovsrg=rhovsrg+uvsrg+bcog
         #
         # for below, signs shouldn't be problem
         # integral, not average
         # FE and FL parts (these use FMvsr directly, since flux ratio)
         set Tud10totvsr=(Tud10PAvsr+Tud10Bvsr+Tud10IEvsr)
         set factorTud10=(Tud10totvsr[0]/FMvsr[0])/(Tud10totvsr/FMvsr)
         #set factorTud10=1
         set FEPAvsr=-Tud10PAvsr/(FMvsr)*factorTud10
         set FEEMvsr=-Tud10Bvsr/(FMvsr)*factorTud10
         set FEIEvsr=-Tud10IEvsr/(FMvsr)*factorTud10
         set FEtotvsr=FEPAvsr+FEEMvsr+FEIEvsr
         #
         # print {newr FMvsr Tud10totvsr FEtotvsr FEPAvsr FEEMvsr FEIEvsr factorTud10}
         #
         set Tud13totvsr=Tud13PAvsr+Tud13Bvsr+Tud13IEvsr
         set factorTud13=(Tud13totvsr[0]/FMvsr[0])/(Tud13totvsr/FMvsr)
         #set factorTud13=1
         set FLPAvsr=Tud13PAvsr/dxdxp33/(FMvsr)*factorTud13
         set FLEMvsr=Tud13Bvsr/dxdxp33/(FMvsr)*factorTud13
         set FLIEvsr=Tud13IEvsr/dxdxp33/(FMvsr)*factorTud13
         set FLtotvsr=FLPAvsr+FLEMvsr+FLIEvsr
         #
         # print {newr FMvsr Tud13totvsr FLtotvsr FLPAvsr FLEMvsr FLIEvsr factorTud13}
         #
         # redo vs. radius
         set tdfevsr=tdeinfisco+newr*0
         set tdflvsr=tdlinfisco+newr*0
         #
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
        #rhoshorvsr
        pl 0 (LG(r)) (LG(rhosrhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(ugsrhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(-vus1rhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(vus3rhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(bas1rhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(bas2rhosqdcden_vsr)) 0011 $myrin $myrout $lminy $lmaxy
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
        pl 0 (LG(r)) (LG(sqrt(bsqrhosqdcden_vsr))) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
		#
        #
panelplot2   0 #
		#
		#
        define myrin ((2.2))
		define myrout ((1E2))
        #
        iofr r $myrout whichi
        print {whichi}
        #
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
        #define lmaxy (130)
        define lmaxy (2.9)
        limits $xin $xout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\dot{E}/\dot{M}_{\rm H}"
        #yla "\dot{E}/\dot{M}"
        #
        #pl 0 (LG(r)) ((eomdot)) 0011 $myrin $myrout $lminy $lmaxy
        pl 0 (LG(r)) ((edottotvsr/mdotfinavgvsr30[ihor])) 0011 $myrin $myrout $lminy $lmaxy
        #
        ###################################
        #
        ticksize -1 0 0 0
        define lminy (0)
        #define lmaxy (1999)
        define lmaxy (50)
        limits $xin $xout $lminy $lmaxy
        define nm2 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm2 box 0 2 0 0
        yla "\dot{L}/\dot{M}_{\rm H}"
        #yla "\dot{L}/\dot{M}"
        #
        #pl 0 (LG(r)) ((lomdot)) 0011 $myrin $myrout $lminy $lmaxy
        pl 0 (LG(r)) ((ldottotvsr/mdotfinavgvsr30[ihor])) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.005))
        #define lmaxy (LG(8100))
        define lmaxy (LG(90))
        limits $xin $xout $lminy $lmaxy
        define nm3 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm3 box 0 2 0 0
        yla "\dot{M}_{\rm in}/\dot{M}_{\rm H}"
        #
        set toplot=mdin_vsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**1.7
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.005))
        define lmaxy (LG(2))
        limits $xin $xout $lminy $lmaxy
        define nm4 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm4 box 0 2 0 0
        yla "\dot{M}_{\rm j}/\dot{M}_{\rm H}"
        #
        set toplot=mdjet_vsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**0.9
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.005))
        define lmaxy (LG(2))
        limits $xin $xout $lminy $lmaxy
        define nm5 ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm5 box 0 2 0 0
        yla "\dot{M}_{\rm mw}/\dot{M}_{\rm H}"
        #
        set toplot=mdmwind_vsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**0.4
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.005))
        define lmaxy (LG(90))
        limits $xin $xout $lminy $lmaxy
        define nm6 ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm6 box 1 2 0 0
        yla "\dot{M}_{\rm w}/\dot{M}_{\rm H}"
		xla "r/r_g"
        #
        set toplot=mdwind_vsr/mdotfinavgvsr30[ihor]
        ltype 0 pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**1.7
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		##########################
		#
        #
iofr    2 # iofr r whichr whichi
        set rtest=$1
        set whichr=$2
        #
        define iter (0)
        while { rtest[$iter]<whichr } {\
            define iter ($iter+1)
            #
            if($iter>=dimen(rtest)){ break }
        }
        #
        set whichi=$iter
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
        define lminy (-0.01)
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
        define lmaxy (1.3)
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
        define lmaxy (0.95)
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
        yla "\Phi/\Phi_{a,s}"
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
        define lminy (-5)
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
        define lminy (-0.5)
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
        define lmaxy (35)
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
        ltype 2 pl 0 avgh (upsilonbz0) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh (upsilonbz2) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 avgh (upsilonbz) 0011 $myhin $myhout $lminy $lmaxy
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
panelplot7   0 #
		#
		#
        # skip m=0
        define mymin (LG(1))
		define mymout (LG(mm[dimen(mm)-1]))
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
		panelplot7replot
		#
panelplot7replot 0 #		
        #
        #define filename powervsm7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        #define filename powervsm1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        #define filename powervsm2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        #define filename powervsm8vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        #define filename powervsm11vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "|a_m|/|a_0|"
        #
        set normstringradhor=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm1radhor)
        define normstringradhordef (normstringradhor)
        set normstringrad4=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm1rad4)
        define normstringrad4def (normstringrad4)
        set normstringrad8=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm1rad8)
        define normstringrad8def (normstringrad8)
        set normstringrad30=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm1rad30)
        define normstringrad30def (normstringrad30)
        print {normpowerm1radhor normpowerm1rad4 normpowerm1rad8 normpowerm1rad30}
        set normstringall=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm1radhor) + sprintf(' %3.2g',normpowerm1rad4)
        #+ sprintf(' %3.2g',normpowerm1rad8) + sprintf(' %3.2g',normpowerm1rad30)
        define normstringalldef (normstringall)
        expand 0.9
        relocate 0.07  -4
        putlabel 6 "\dot{M} in Disk"
        # at r=r_+
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand 1.5
        #
        ltype 0 pl 0 mm powerm1radhor 1111 $mymin $mymout  $lminy $lmaxy
        ltype 2 pl 0 mm powerm1rad4 1111 $mymin $mymout  $lminy $lmaxy
        #ltype 0 pl 0 mm powerm1rad8 1111 $mymin $mymout  $lminy $lmaxy
        #        ltype 0 pl 0 mm powerm1rad30 1111 $mymin $mymout  $lminy $lmaxy
        #
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        #
        set normstringradhor=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm2radhor)
        define normstringradhordef (normstringradhor)
        set normstringrad4=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm2rad4)
        define normstringrad4def (normstringrad4)
        set normstringrad8=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm2rad8)
        define normstringrad8def (normstringrad8)
        set normstringrad30=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm2rad30)
        define normstringrad30def (normstringrad30)
        print {normpowerm2radhor normpowerm2rad4 normpowerm2rad8 normpowerm2rad30}
        set normstringall=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm2radhor) + sprintf(' %3.2g',normpowerm2rad4) + sprintf(' %3.2g',normpowerm2rad8) + sprintf(' %3.2g',normpowerm2rad30)
        define normstringalldef (normstringall)
        expand 0.9
        relocate 0.07  -4
        #  at r/r_g=r_+/r_g,4,8,30
        putlabel 6 "M_0 in Disk"
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand 1.5
        #
        ltype 0 pl 0 mm powerm2radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm2rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm2rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm2rad30 1111 $mymin $mymout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        #
        set normstringradhor=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm3radhor)
        define normstringradhordef (normstringradhor)
        set normstringrad4=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm3rad4)
        define normstringrad4def (normstringrad4)
        set normstringrad8=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm3rad8)
        define normstringrad8def (normstringrad8)
        set normstringrad30=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm3rad30)
        define normstringrad30def (normstringrad30)
        print {normpowerm3radhor normpowerm3rad4 normpowerm3rad8 normpowerm3rad30}
        set normstringall=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm3radhor) + sprintf(' %3.2g',normpowerm3rad4) + sprintf(' %3.2g',normpowerm3rad8) + sprintf(' %3.2g',normpowerm3rad30)
        define normstringalldef (normstringall)
        expand 0.9
        relocate 0.07  -4
        putlabel 6 "E_g in Disk"
        # at r=4r_g
        relocate 0.07 -5.2
        putlabel 6 $normstringalldef
        expand 1.5
        #
        ltype 0 pl 0 mm powerm3radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm3rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm3rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm3rad30 1111 $mymin $mymout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        #
        set normstringradhor=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm4radhor)
        define normstringradhordef (normstringradhor)
        set normstringrad4=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm4rad4)
        define normstringrad4def (normstringrad4)
        set normstringrad8=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm4rad8)
        define normstringrad8def (normstringrad8)
        set normstringrad30=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm4rad30)
        define normstringrad30def (normstringrad30)
        print {normpowerm4radhor normpowerm4rad4 normpowerm4rad8 normpowerm4rad30}
        set normstringall=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm4radhor) + sprintf(' %3.2g',normpowerm4rad4) + sprintf(' %3.2g',normpowerm4rad8) + sprintf(' %3.2g',normpowerm4rad30)
        define normstringalldef (normstringall)
        expand 0.9
        relocate 0.07  -4
        putlabel 6 "E_B in Jet"
        # at r=4r_g
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand 1.5
        #
        ltype 0 pl 0 mm powerm4radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm4rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm4rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm4rad30 1111 $mymin $mymout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm1 box 1 2 0 0
        yla "|a_m|/|a_0|"
        xla "m mode at r=r_+,4r_g,8r_g,30r_g"
        #
        set normstringradhor=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm5radhor)
        define normstringradhordef (normstringradhor)
        set normstringrad4=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm5rad4)
        define normstringrad4def (normstringrad4)
        set normstringrad8=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm5rad8)
        define normstringrad8def (normstringrad8)
        set normstringrad30=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm5rad30)
        define normstringrad30def (normstringrad30)
        print {normpowerm5radhor normpowerm5rad4 normpowerm5rad8 normpowerm5rad30}
        set normstringall=sprintf('|a_{m>0}|/|a_{m=0}|=%3.2g',normpowerm5radhor) + sprintf(' %3.2g',normpowerm5rad4) + sprintf(' %3.2g',normpowerm5rad8) + sprintf(' %3.2g',normpowerm5rad30)
        define normstringalldef (normstringall)
        expand 0.9
        relocate 0.07  -4
        putlabel 6 "\dot{E}^{\rm EM} in Jet"
        # at r=4r_g
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand 1.5
        #
        ltype 0 pl 0 mm powerm5radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm5rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm5rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm5rad30 1111 $mymin $mymout $lminy $lmaxy
        #
        # 
gammieplot 0    #
                #
                # whether to show deviations from NT or direct plots for j and e
                set showdev=0
                defaults
                #
                #
                add_ctype grey 200 200 200
                add_ctype lightgrey 230 230 230
                add_ctype orange 255 165 0
                add_ctype darkgreen 0 100 0
                add_ctype darkolivegreen 85 107 47
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
                # whether to use log in radius
                set logr=1
                #
                if(logr==0){\
                    define xinner (($rinner))
                    define xouter (($router))
                    set xsim=newr
                    set xgam=gr
                    set xisco=risco
                }\
                else{\
                    define xinner (LG($rinner))
                    define xouter (LG($router))
                    set xsim=(LG(newr))
                    set xgam=(LG(gr))
                    set xisco=(LG(risco))
                }
                #
                ###########################
                # now real plots
                #
                ##########################
                #limits  $xinner $xouter $uurvsrmin 0
                limits  $xinner $xouter -0.5 0
                if(logr==0){ ticksize 0 0 0 0 } else{ ticksize -1 0 0 0  }
                #
                ctype default window 2 2 1 2 box 1 2 0 0
                yla u^r
                xla r/M
                ltype 0 ctype default ltype 0 plo 0 xsim uurvsr
                #
                ltype 2 ctype default ltype 2 plo 0 xgam guu1
                ctype red ltype 0 vertline xisco
                #
                ###################################
                if(showdev==1){\
                   limits $xinner $xouter -150 150
                   define x2label "D[j]"
                   set jshow=100*(gl-tdlinfisco)/tdlinfisco
                   set jsimshow=100*(FLPAvsr-tdlinfisco)/tdlinfisco
                   set divisor=tdlinfisco/100.0
                }\
                else{\
                 limits $xinner $xouter -7 7
                 define x2label "j"
                 set jshow=gl
                 set jsimshow=FLPAvsr
                 set divisor=1
                }
                if(logr==0){ ticksize 0 0 0 0 } else{ ticksize -1 0 0 0  }
                #
                ctype default window 2 2 2 2 box 1 2 0 0
                define x1label "r/M"
                xla $x1label
                yla $x2label
                if(showdev==0){\
                 ctype default ltype 1 plo 0 xsim tdflvsr
                }
                ctype green ltype 0 plo 0 xsim (FLEMvsr/divisor)
                ctype magenta ltype 0 plo 0 xsim (FLIEvsr/divisor)
                #
                ctype green ltype 2 plo 0 xgam (gFLEM/divisor)
                ctype default ltype 0 plo 0 xsim jsimshow
                #ctype default ltype 0 plo 0 xsim (udphivsr/divisor)
                # particle term for gammie
                ctype default ltype 2 plo 0 xgam jshow
                #
                ctype red ltype 0 vertline xisco
                #
                #####################################
                limits $xinner $xouter -3 1
                if(logr==0){ ticksize 0 0 -1 0 } else{ ticksize -1 0 -1 0  }
                notation -2 2 -2 2
                #
                ctype default window 2 2 1 1 box 1 2 0 0
                xla r/M
                yla "comoving energy density"
                set lbcog=LG(bcog)
                ctype green ltype 0 plo 0 xsim lbcog
                set lrhovsrg=LG(rhovsrg)
                ctype default ltype 0 plo 0 xsim lrhovsrg
                set luvsrg=LG(uvsrg)
                ctype magenta ltype 0 plo 0 xsim luvsrg
                #
                set lmygbsqvsr=LG(mygbsqvsr)
                set lged=LG(ged)
                #
                ctype green ltype 2 plo 0 xgam lged
                #
                set lgrho=LG(grho)
                #
                ctype default ltype 2 plo 0 xgam lgrho
                #
                #set lgco=LG(gco)
                ctype red ltype 0 vertline xisco
                #
                ########################################
                if(showdev==1){\
                   limits $xinner $xouter -150 150
                   define x2label "D[e]"
                   set eshow=100*(gE-tdeinfisco)/tdeinfisco
                   set esimshow=100*(FEPAvsr-tdeinfisco)/tdeinfisco
                   set divisor=tdeinfisco/100
                }\
                else{\
                 limits $xinner $xouter -2.0 2.0
                 define x2label "e"
                 set eshow=gE
                 set esimshow=FEPAvsr
                 set divisor=1
                }
                #
                if(logr==0){ ticksize 0 0 0 0 } else{ ticksize -1 0 0 0  }
                #
                ctype default window 2 2 2 1 box 1 2 0 0
                #
                define x1label "r/M"
                xla $x1label
                yla $x2label
                if(showdev==0){
                   ctype default ltype 1 plo 0 xsim tdfevsr
                }
                #ctype default ltype 0 plo 0 xsim (FEtotvsr/divisor)
                #ctype default ltype 2 plo 0 xgam (gFEtot/divisor)
                ctype green ltype 0 plo 0 xsim (FEEMvsr/divisor)
                #
                ctype default ltype 0 plo 0 xsim esimshow
                #ctype default ltype 0 plo 0 xsim (-ud0vsr/divisor)
                ctype magenta ltype 0 plo 0 xsim (FEIEvsr/divisor)
                # particle term for gammie
                #
                ctype green ltype 2 plo 0 xgam (gFEEM/divisor)
                ctype default ltype 2 plo 0 xgam eshow
                #
                ctype red ltype 0 vertline xisco
                #
                #
                #
