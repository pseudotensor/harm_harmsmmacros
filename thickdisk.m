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
        #
        #!cp /data2/jmckinne/thickdisk7/fromorange_movie8new5/inf* .
        #
        rdheaderstuff
        #
        #
        # 1D stuff
        rdvsr
        riscocalcs
        jrdpraddims # so gets effnom for Mdoteddcode
        visctheory
        #
        rdvsh
        rdvst
        #
        # 2D stuff
        rdavgvsh
        # Messages like "Vector preintavg???? has no elements" can be normal for below
        bzcomparisonsetup
        #
        rdavgvsr
        #
        # other 1D stuff
        rdvsphi
        #
        rdpowervsm
        rdpowervsn
        rdpowervsl
        #
        rdrbarnormvsphi
        rdrbarnormvsrad
        rdrbarnormvstheta
        #
riscocalcs 0 #
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
rdheaderstuff 0 #
        #
        # note SM barfs sometimes randomly on there being _ in names of vectors reading in.  So avoid them.
        #
        # get some header stuff from one file
        # only read some of the data that's required for the BZ comparison plot
        da dataavgvsh0.txt
        lines 1 2
        read {avgts 1 avgte 2 avgnitems 3 a 4 rhor 5 ihor 6 dx1 7 dx2 8 dx3 9 wedgef 10 n1 11 n2 12 n3 13}
        #
        #
        jrdpraddims
        #
rdvsr 0 #
        da datavsrhead.txt
        lines 1 1
        read '%g %g %g %g' {iin1 rfitin1 iout1 rfitout1}
        lines 2 2
        read '%g %g %g %g' {iin2 rfitin2 iout2 rfitout2}
        lines 3 3
        read '%g %g %g %g' {iin3 rfitin3 iout3 rfitout3}
        lines 4 4
        read '%g %g %g %g' {iin4 rfitin4 iout4 rfitout4}
        lines 5 5
        read '%g %g %g %g' {iin5 rfitin5 iout5 rfitout5}
        lines 6 6
        read '%g %g %g %g' {iin6 rfitin6 iout6 rfitout6}
        #
        # datavsr1.txt: rho,u over non-jet, v,B over whole flow
        # datavsr1b.txt : all only over bsq/rho<=1
        # datavsr1c.txt : all only in non-jet and density weighted to focus on disky part
        # datavsr2.txt: rho,u,v,B at equator no matter disk or jet
        # datavsr3.txt: rho,u over 2.5*hoverr3d non-jet and v,B over 2.5*hoverr3d
        # datavsr4.txt: rho,u,v,B over 2.0*hoverr3d non-jet
        #
        ################################################
        # 23
        da datavsr1.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqvsr ugsrhosqvsr uu0rhosqvsr vus1rhosqvsr vuas1rhosqvsr vus3rhosqvsr vuas3rhosqvsr vuasrotrhosqvsr Bs1rhosqvsr Bas1rhosqvsr Bs2rhosqvsr Bas2rhosqvsr Bs3rhosqvsr Bas3rhosqvsr bs1rhosqvsr bas1rhosqvsr bs2rhosqvsr bas2rhosqvsr bs3rhosqvsr bas3rhosqvsr bsqrhosqvsr}
        #
        # 23
        da datavsr1b.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqdcvsr ugsrhosqdcvsr uu0rhosqdcvsr vus1rhosqdcvsr vuas1rhosqdcvsr vus3rhosqdcvsr vuas3rhosqdcvsr vuasrotrhosqdcvsr Bs1rhosqdcvsr Bas1rhosqdcvsr Bs2rhosqdcvsr Bas2rhosqdcvsr Bs3rhosqdcvsr Bas3rhosqdcvsr bs1rhosqdcvsr bas1rhosqdcvsr bs2rhosqdcvsr bas2rhosqdcvsr bs3rhosqdcvsr bas3rhosqdcvsr bsqrhosqdcvsr}
        #
        # 23
        da datavsr1c.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqdcdenvsr ugsrhosqdcdenvsr uu0rhosqdcdenvsr vus1rhosqdcdenvsr vuas1rhosqdcdenvsr vus3rhosqdcdenvsr vuas3rhosqdcdenvsr vuasrotrhosqdcdenvsr Bs1rhosqdcdenvsr Bas1rhosqdcdenvsr Bs2rhosqdcdenvsr Bas2rhosqdcdenvsr Bs3rhosqdcdenvsr Bas3rhosqdcdenvsr bs1rhosqdcdenvsr bas1rhosqdcdenvsr bs2rhosqdcdenvsr bas2rhosqdcdenvsr bs3rhosqdcdenvsr bas3rhosqdcdenvsr bsqrhosqdcdenvsr}
        #
        # 23
        da datavsr2.txt
        lines 1 1000000
        read '%d %g  %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii r rhosrhosqeqvsr ugsrhosqeqvsr uu0rhosqeqvsr vus1rhosqeqvsr vuas1rhosqeqvsr vus3rhosqeqvsr vuas3rhosqeqvsr vuasrotrhosqeqvsr Bs1rhosqeqvsr Bas1rhosqeqvsr Bs2rhosqeqvsr Bas2rhosqeqvsr Bs3rhosqeqvsr Bas3rhosqeqvsr bs1rhosqeqvsr bas1rhosqeqvsr bs2rhosqeqvsr bas2rhosqeqvsr bs3rhosqeqvsr bas3rhosqeqvsr bsqrhosqeqvsr}
        #
        # 23
        da datavsr3.txt
        lines 1 0000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii r rhosrhosqhorpickvsr ugsrhosqhorpickvsr uu0rhosqhorpickvsr vus1rhosqhorpickvsr vuas1rhosqhorpickvsr vus3rhosqhorpickvsr vuas3rhosqhorpickvsr vuasrotrhosqhorpickvsr Bs1rhosqhorpickvsr Bas1rhosqhorpickvsr Bs2rhosqhorpickvsr Bas2rhosqhorpickvsr Bs3rhosqhorpickvsr Bas3rhosqhorpickvsr bs1rhosqhorpickvsr bas1rhosqhorpickvsr bs2rhosqhorpickvsr bas2rhosqhorpickvsr bs3rhosqhorpickvsr bas3rhosqhorpickvsr bsqrhosqhorpickvsr}
        #
        # 26
        da datavsr4.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii r rhoshorvsr ugshorvsr bsqshorvsr bsqorhoshorvsr bsqougshorvsr uu0horvsr vus1horvsr vuas1horvsr vus3horvsr vuas3horvsr vuasrothorvsr Bs1horvsr Bas1horvsr Bs2horvsr Bas2horvsr Bs3horvsr Bas3horvsr bs1horvsr bas1horvsr bs2horvsr bas2horvsr bs3horvsr bas3horvsr bsqhorvsr}
        set gam=4.0/3.0
        set pg=(gam-1.0)*ugshorvsr
        set beta=pg/bsqshorvsr
        #
        # (was 44, now 51 with alphamag4 and alphareynolds stuff)
        !sed 's/nan/0/g' datavsr5.txt > datavsr5n.txt
        !sed 's/inf/0/g' datavsr5n.txt > datavsr5nn.txt
        da datavsr5nn.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii r mdotfinavgvsr mdotfinavgvsr5 mdotfinavgvsr10 mdotfinavgvsr30 edemvsr edmavsr edmvsr ldemvsr ldmavsr ldmvsr phiabsjmu1vsr pjemfinavgvsr pjmakefinavgvsr pjkefinavgvsr ljemfinavgvsr ljmakefinavgvsr ljkefinavgvsr mdinvsr mdjetvsr mdmwindvsr mdwindvsr alphamag1vsr alphamag2vsr alphamag3vsr alphamag4vsr alphareynoldsa2vsr alphareynoldsb2vsr \
        alphareynoldsc2vsr alphareynoldsa3vsr alphareynoldsb3vsr alphareynoldsc3vsr fstotvsr fsinvsr feqtotvsr fsmaxtotvsr fsuphalfvsr upsilonvsr etajEMvsr etajMAKEvsr etamwEMvsr etamwMAKEvsr etawEMvsr etawMAKEvsr letajEMvsr letajMAKEvsr letamwEMvsr letamwMAKEvsr letawEMvsr letawMAKEvsr}
        #
        #
        set betamagplus1=(alphamag4vsr>0 && alphamag3vsr>0 ? alphamag4vsr/alphamag3vsr : 0)
        #
        set alphatot2vsr=alphareynoldsa2vsr+alphareynoldsb2vsr+alphareynoldsc2vsr+alphamag2vsr
        set alphatot3vsr=alphareynoldsa3vsr+alphareynoldsb3vsr+alphareynoldsc3vsr+alphamag3vsr
        #
        set edottotvsr=edemvsr+edmavsr
        set ldottotvsr=ldemvsr+ldmavsr
        set eomdot=edottotvsr/mdotfinavgvsr30
        set lomdot=ldottotvsr/mdotfinavgvsr30
        #
        set etajtotvsr=etajEMvsr+etajMAKEvsr
        set etamwtotvsr=etamwEMvsr+etamwMAKEvsr
        set etawtotvsr=etawEMvsr+etawMAKEvsr
        set effjlocal=etajtotvsr*(mdotfinavgvsr/mdinvsr)
        set effmwlocal=etamwtotvsr*(mdotfinavgvsr/mdinvsr)
        set effwlocal=etawtotvsr*(mdotfinavgvsr/mdinvsr)
        #
        # below factor1 converts upsilon so that both numerator and denominator are vs. radius
        set factor1=(mdotfinavgvsr30[ihor]/mdotfinavgvsr30)**0.5
        set upsilonvsrnorm=upsilonvsr*factor1
        # below factor2 is just constant that converts to upsilon
        set factor2=(upsilonvsr/fstotvsr)
        # below factor3 converts so upsilon uses mdotin(r) rather than fixed mdot at hole
        set factor3=(mdotfinavgvsr30[ihor]/mdinvsr)**0.5
        set upsiloninnorm=fsinvsr*factor2*factor3
        #
        # 17
        da datavsr6.txt
        lines 1 1000000
        read '%d %g   %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {ii rnyO2 dtheta dphi drvsr dHvsr dPvsr hoverrvsr hoverrcoronavsr hoverrjetvsr thetaalongfield qmridiskvsr q3mridiskvsr iq2mridiskvsr qmridiskweakvsr q3mridiskweakvsr iq2mridiskweakvsr}
        # iq2 comes without H/R
        set q2mridiskvsr=hoverrvsr/iq2mridiskvsr
        set q2mridiskweakvsr=hoverrvsr/iq2mridiskweakvsr
        #
        set ug=ugsrhosqdcdenvsr
        set pg=(gam-1.0)*ug
        set rho=rhosrhosqdcdenvsr
        set cs2=gam*pg/(rho+ug+pg)
        set vphi=vus3rhosqdcdenvsr
        set vk=r/(a+r**(1.5))
        set horalt1=sqrt(cs2)/vphi
        set horalt2=sqrt(cs2)/vk
        ################################################
rdvsh 0 #
        da datavsh1.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii hinnx4 rhosrhosqrad4vsh ugsrhosqrad4vsh uu0rhosqrad4vsh vus1rhosqrad4vsh vuas1rhosqrad4vsh vus3rhosqrad4vsh vuas3rhosqrad4vsh vuasrotrhosqrad4vsh Bs1rhosqrad4vsh Bas1rhosqrad4vsh Bs2rhosqrad4vsh Bas2rhosqrad4vsh Bs3rhosqrad4vsh Bas3rhosqrad4vsh bs1rhosqrad4vsh bas1rhosqrad4vsh bs2rhosqrad4vsh bas2rhosqrad4vsh bs3rhosqrad4vsh bas3rhosqrad4vsh bsqrhosqrad4vsh}
        #
        da datavsh2.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii hinnx8 rhosrhosqrad8vsh ugsrhosqrad8vsh uu0rhosqrad8vsh vus1rhosqrad8vsh vuas1rhosqrad8vsh vus3rhosqrad8vsh vuas3rhosqrad8vsh vuasrotrhosqrad8vsh Bs1rhosqrad8vsh Bas1rhosqrad8vsh Bs2rhosqrad8vsh Bas2rhosqrad8vsh Bs3rhosqrad8vsh Bas3rhosqrad8vsh bs1rhosqrad8vsh bas1rhosqrad8vsh bs2rhosqrad8vsh bas2rhosqrad8vsh bs3rhosqrad8vsh bas3rhosqrad8vsh bsqrhosqrad8vsh}
        #
        da datavsh3.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {ii hinnx30 rhosrhosqrad30vsh ugsrhosqrad30vsh uu0rhosqrad30vsh vus1rhosqrad30vsh vuas1rhosqrad30vsh vus3rhosqrad30vsh vuas3rhosqrad30vsh vuasrotrhosqrad30vsh Bs1rhosqrad30vsh Bas1rhosqrad30vsh Bs2rhosqrad30vsh Bas2rhosqrad30vsh Bs3rhosqrad30vsh Bas3rhosqrad30vsh bs1rhosqrad30vsh bas1rhosqrad30vsh bs2rhosqrad30vsh bas2rhosqrad30vsh bs3rhosqrad30vsh bas3rhosqrad30vsh bsqrhosqrad30vsh}
        #
        ################################################
rdvst 0 #
        #
        #columns=12
        da datavst1.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g' {tici ts mdtotihor md10ihor md30ihor mdinrdiskin mdinrdiskout mdjetrjetout mdmwindrjetin mdmwindrjetout mdwindrdiskin mdwindrdiskout}
        set mdothor=mdtotihor-md30ihor
        #
        #columns=20
        da datavst2.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  etabhEM etabhMAKE etabh etajEM etajMAKE etaj etamwinEM etamwinMAKE etamwin etamwoutEM etamwoutMAKE etamwout etawinEM etawinMAKE etawin etawoutEM etawoutMAKE etawout}
        #
        #columns=20
        da datavst3.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  letabhEM letabhMAKE letabh letajEM letajMAKE letaj letamwinEM letamwinMAKE letamwin letamwoutEM letamwoutMAKE letamwout letawinEM letawinMAKE letawin letawoutEM letawoutMAKE letawout}
        #
        # in case needed to fix using original data, but no longer need this.
        #da /data2/jmckinne/thickdisk7/fromorange_movie8/datavst2.txt
        #lines 1 1000000
        #read {ticialt 1 tsalt 2  etabhEMalt 3 etabhMAKEalt 4}
        #
        #da /data2/jmckinne/thickdisk7/fromorange_movie8/datavst3.txt
        #lines 1 1000000
        #read {ticialt 1 tsalt 2  letabhEMalt 3 letabhMAKEalt 4}
        #
        #columns=20
        da datavst4.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  hoverrhor hoverr2 hoverr5 hoverr10 hoverr20 hoverr100 hoverrcoronahor hoverrcorona2 hoverrcorona5 hoverrcorona10 hoverrcorona20 hoverrcorona100 hoverrjethor hoverrjet2 hoverrjet5 hoverrjet10 hoverrjet20 hoverrjet100}
        #
        # columns=32
        !sed 's/nan/0/g' datavst5.txt > datavst5n.txt
        !sed 's/inf/0/g' datavst5n.txt > datavst5nn.txt
        da datavst5nn.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
        {tici ts betamin0 betaavg0 betaratofavg0 betaratofmax0 alphamag110 alphamag210 alphamag310 alphamag410 alphareynoldsa210 alphareynoldsb210 alphareynoldsc210 alphareynoldsa310 alphareynoldsb310 alphareynoldsc310 lum1 lum2 lum3 lum4 lum5 lum6 lum7 lum8 lum9 lum10 lum11 lum12 lumsynchth lumsynchnon1 lumsynchnon2 lumsynchnon3}
        #        
        set alphatot210=alphareynoldsa210+alphareynoldsb210+alphareynoldsc210+alphamag210
        set alphatot310=alphareynoldsa310+alphareynoldsb310+alphareynoldsc310+alphamag310
        #
        # columns=20
        !sed 's/nan/0/g' datavst6.txt > datavst6n.txt
        da datavst6n.txt
        lines 1 1000000
        # below 10,20,100 are really now rfitin2,rfitout2,rfitout6
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts qmridisk10 qmridisk20 qmridisk100 q3mridisk10 q3mridisk20 q3mridisk100 iq2mridisk10 iq2mridisk20 iq2mridisk100 qmridiskweak10 qmridiskweak20 qmridiskweak100 q3mridiskweak10 q3mridiskweak20 q3mridiskweak100 iq2mridiskweak10 iq2mridiskweak20 iq2mridiskweak100}
        #
        # columns=30
        !sed 's/nan/0/g' datavst7.txt > datavst7n.txt
        !sed 's/inf/0/g' datavst7n.txt > datavst7nn.txt
        da datavst7nn.txt
        lines 1 1000000
        read '%d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {tici ts  phibh phirdiskin phirdiskout phij phimwin phimwout phiwin phiwout phijn phijs fstotihor fsmaxtotihor fsuphalfihor fmaxvst rifmaxvst reqstagvst feqstag feqstagnearfin fstotnormA0 fstotnormA1 fstotnormA2 fstotnormC fstotnormC2 fstotnormBwhichfirstlimited fstotnormD fstotnormE fstotnormE2 fstotnormF}
        #
        da datavsrrm1.txt
        lines 1 1000000
        read '%d %g %g' {tici ts rm1vstorig}
        set rm1vst=(rm1vstorig<2.2 ? 0 : rm1vstorig)
        #
        ################################################################
        #
rdavgvsh 0
        #
        # only read some of the data that's required for the BZ comparison plot
        rdheaderstuff
        #
        da dataavgvsh1.txt
        lines 2 1000000
        read {avgjj 1 avgh 2 avgrho 3 avgug 4 avgbsq 5 avgunb 6}
        read {avguu0 7 avguu1 8 avguu2 9 avguu3 10}
        read {avgbu0 11 avgbu1 12 avgbu2 13 avgbu3 14}
        read {avgud0 15 avgud1 16 avgud2 17 avgud3 18}
        read {avgbd0 19 avgbd1 20 avgbd2 21 avgbd3 22}
        read {avgB1 23 avgB2 24 avgB3 25}
        read {avggdetB1 26 avggdetB2 27 avggdetB3 28}
        read {avgrhouu1 34}
        read {avgomegaf2 29 avgomegaf2b 30 avgomegaf1 31 avgomegaf1b 32}
        read {avgvsrfdd00 73 avgvsrfdd10 74 avgvsrfdd20 75 avgvsrfdd30 76 avgvsrfdd01 77 avgvsrfdd11 78 avgvsrfdd21 79 avgvsrfdd31 80 \
              avgvsrfdd02 81 avgvsrfdd12 82 avgvsrfdd22 83 avgvsrfdd32 84 avgvsrfdd03 85 avgvsrfdd13 86 avgvsrfdd23 87 avgvsrfdd33 88}
        read {avgTud10 58 avgTud13 70 avgTudEM10 170 avgTudEM13 182 avgTudMA10 186 avgTudMA13 198 avgTudPA10 202 avgTudPA13 214 avgTudIE10 218 avgTudIE13 230}
        set avgTudMAKE10=-avgTudMA10-avgrhouu1
        # print {avgh avgbsqorho avgTudEM10 avgTudMA10 avgrhouu1 avgTudPA10 avgTudIE10}
        read {avgmu 233 avgsigma 234 avgbsqorho 235 avgabsB1 236 avgabsgdetB1 239 avgabsgdetB2 240 avgabsgdetB3 241 avggamma 243}
        read {avggdet 244 avgdxdxp11 245 avgdtheta 246 avgdxdxp12 247 avgdxdxp21 248 avgdxdxp33 249}
        #
        # new abs versions
        read {avgabsuu0 250 avgabsuu1 251 avgabsuu2 252 avgabsuu3 253}
        read {avgabsbu0 254 avgabsbu1 255 avgabsbu2 256 avgabsbu3 257}
        read {avgabsud0 258 avgabsud1 259 avgabsud2 260 avgabsud3 261}
        read {avgabsbd0 262 avgabsbd1 263 avgabsbd2 264 avgabsbd3 265}
        read {avgabsomegaf2 266 avgabsomegaf2b 267 avgabsomegaf1 268 avgabsomegaf1b 269}
        read {avgabsrhouu0 270 avgabsrhouu1 271 avgabsrhouu2 272 avgabsrhouu3 273}
        read {avgabsfdd00 274 avgabsfdd10 275 avgabsfdd20 276 avgabsfdd30 277 avgabsfdd01 278 avgabsfdd11 279 avgabsfdd21 280 avgabsfdd31 281 \
              avgabsfdd02 282 avgabsfdd12 283 avgabsfdd22 284 avgabsfdd32 285 avgabsfdd03 286 avgabsfdd13 287 avgabsfdd23 288 avgabsfdd33 289}
        #
        #
        set avgdxdxp22=avgdtheta/dx2
        #
        set avgomegaalt1=(avguu3/avguu0 + (avguu1/avguu0/avgabsgdetB1)*avgabsgdetB3)*avgdxdxp33
        set avgomegaalt2=(avgvsrfdd02/avgvsrfdd23)*avgdxdxp33
        set avgomegaalt3=(avgvsrfdd01/avgvsrfdd13)*avgdxdxp33
        #
        set avgabsomegaalt1=(avgabsuu3/avgabsuu0 + (avgabsuu1/avgabsuu0/avgabsgdetB1)*avgabsgdetB3)*avgdxdxp33
        set avgabsomegaalt2=(avgabsfdd02/avgabsfdd23)*avgdxdxp33
        set avgabsomegaalt3=(avgabsfdd01/avgabsfdd13)*avgdxdxp33
        #
        set rks=rhor
        set hks=avgh
        #
        set sigmaks=rks**2+(a*cos(hks))**2
        set deltaks=rks**2-2*rks+a**2
        set Aks=(rks**2+a**2)**2-a**2*deltaks*(sin(hks))**2
        #
        set gvks00=-(1.0-2.0*rks/sigmaks)
        set gvks11=(1.0+2.0*rks/sigmaks)
        set gvks22=sigmaks
        set gvks33=(sin(hks))**2*(sigmaks + a**2*(1.0 + 2.0*rks/sigmaks)*(sin(hks))**2)
        #
        # 3-vel quasi-orthonormal
        set avguur=(avguu1*avgdxdxp11 + avguu2*avgdxdxp12)*sqrt(gvks11)/avguu0
        set avguuh=(avguu1*avgdxdxp21 + avguu2*avgdxdxp22)*sqrt(gvks22)/avguu0
        set avguup=(avguu3*avgdxdxp33)*sqrt(gvks33)/avguu0
        #
        # 4-field quasi-orthonormal
        set avgbur=(avgbu1*avgdxdxp11 + avgbu2*avgdxdxp12)*sqrt(gvks11)
        set avgbuh=(avgbu1*avgdxdxp21 + avgbu2*avgdxdxp22)*sqrt(gvks22)
        set avgbup=(avgbu3*avgdxdxp33)*sqrt(gvks33)
        #
        # 4-field quasi-orthonormal
        set avgabsbur=(avgabsbu1*avgdxdxp11 + avgabsbu2*avgdxdxp12)*sqrt(gvks11)
        set avgabsbuh=(avgabsbu1*avgdxdxp21 + avgabsbu2*avgdxdxp22)*sqrt(gvks22)
        set avgabsbup=(avgabsbu3*avgdxdxp33)*sqrt(gvks33)
        #
        #
        #
rdavgvsr 0 #
        #
        ########################################################
        # avg1.write("#avgrho avgug avgbsq avgunb avguu avgbu avgud avgbd avgB avggdetB avgomegaf2 avgomegaf2b avgomegaf1 avgomegaf1b avgrhouu avgrhobu avgrhoud avgrhobd avguguu avgugud avgTud avgfdd avgrhouuud avguguuud avgbsquuud avgbubd avguuud avgTudEM  avgTudMA  avgTudPA  avgTudIE  avgmu  avgsigma  avgbsqorho  avgabsB  avgabsgdetB  avgpsisq avggamma avggdet dxdxp11 dxdxp22dx2 rhosqint")
        #set omegaf1=fdd01/fdd13 # = ftr/frp
        #set omegaf2=fdd02/fdd23 # = fth/fhp
        #set aomegaf1=afdd01/afdd13 # = ftr/frp
        #set aomegaf2=afdd02/afdd23 # = fth/fhp
        ################################################################
        # only read some of the data that's required for the Gammie plot
        # columns=13
        da dataavgvsr0.txt
        lines 1 2
        read {avgvsrts 1 avgvsrte 2 avgvsrnitems 3 a 4 rhor 5 ihor 6 dx1 7 dx2 8 dx3 9 wedgef 10 n1 11 n2 12 n3 13}
        # columns=292
        !sed 's/nan/0/g' dataavgvsr1.txt > dataavgvsr1n.txt
        !sed 's/inf/0/g' dataavgvsr1n.txt > dataavgvsr1nn.txt
        da dataavgvsr1nn.txt
        lines 2 1000000
        read {avgvsrii 1 avgvsrr 2 avgvsrrho 3 avgvsrug 4 avgvsrbsq 5 avgvsrunb 6}
        read {avgvsruu0 7 avgvsruu1 8 avgvsruu2 9 avgvsruu3 10}
        read {avgvsrud0 15 avgvsrud1 16 avgvsrud2 17 avgvsrud3 18}
        read {avgvsrB1 23 avgvsrgdetB1 26 avgvsrrhouu1 34 avgvsromegaf2 29 avgvsromegaf2b 30 avgvsromegaf1 31 avgvsromegaf1b 32}
        read {avgvsrTud10 58 avgvsrTud13 70 avgvsrTudEM10 170 avgvsrTudEM13 182 avgvsrTudMA10 186 avgvsrTudMA13 198 avgvsrTudPA10 202 avgvsrTudPA13 214 avgvsrTudIE10 218 avgvsrTudIE13 230}
        read {avgvsrfdd00 73 avgvsrfdd10 74 avgvsrfdd20 75 avgvsrfdd30 76 avgvsrfdd01 77 avgvsrfdd11 78 avgvsrfdd21 79 avgvsrfdd31 80 \
              avgvsrfdd02 81 avgvsrfdd12 82 avgvsrfdd22 83 avgvsrfdd32 84 avgvsrfdd03 85 avgvsrfdd13 86 avgvsrfdd23 87 avgvsrfdd33 88}
        set avgvsrTudMAKE10=-avgvsrTudMA10-avgvsrrhouu1
        # print {avgvsrh avgvsrbsqorho avgvsrTudEM10 avgvsrTudMA10 avgvsrrhouu1 avgvsrTudPA10 avgvsrTudIE10}
        read {avgvsrmu 233 avgvsrsigma 234 avgvsrbsqorho 235 avgvsrabsB1 236 avgvsrabsgdetB1 239 avgvsrabsgdetB2 240 avgvsrabsgdetB3 241 avgvsrgamma 243}
        read {avgvsrgdet 244 avgvsrdxdxp11 245 avgvsrdxdxp22 246 avgvsrdxdxp12 247 avgvsrdxdxp21 248 avgvsrdxdxp33 249}
        #
        # new abs versions
        read {avgvsrabsuu0 250 avgvsrabsuu1 251 avgvsrabsuu2 252 avgvsrabsuu3 253}
        read {avgvsrabsbu0 254 avgvsrabsbu1 255 avgvsrabsbu2 256 avgvsrabsbu3 257}
        read {avgvsrabsud0 258 avgvsrabsud1 259 avgvsrabsud2 260 avgvsrabsud3 261}
        read {avgvsrabsbd0 262 avgvsrabsbd1 263 avgvsrabsbd2 264 avgvsrabsbd3 265}
        read {avgvsrabsomegaf2 266 avgvsrabsomegaf2b 267 avgvsrabsomegaf1 268 avgvsrabsomegaf1b 269}
        read {avgvsrabsrhouu0 270 avgvsrabsrhouu1 271 avgvsrabsrhouu2 272 avgvsrabsrhouu3 273}
        read {avgvsrabsfdd00 274 avgvsrabsfdd10 275 avgvsrabsfdd20 276 avgvsrabsfdd30 277 avgvsrabsfdd01 278 avgvsrabsfdd11 279 avgvsrabsfdd21 280 avgvsrabsfdd31 281 \
              avgvsrabsfdd02 282 avgvsrabsfdd12 283 avgvsrabsfdd22 284 avgvsrabsfdd32 285 avgvsrabsfdd03 286 avgvsrabsfdd13 287 avgvsrabsfdd23 288 avgvsrabsfdd33 289}
        #
        # more:
        read {avgvsrhor 290 avgvsrrhosqint 291 avgvsrrhosqint2 292}
        #
        #
        #
        # omegaf2b=np.fabs(vphi) + (vpol/Bpol)*np.fabs(B[3])
        set avgvsromegaalt1=(avgvsruu3/avgvsruu0 - (avgvsruu1/avgvsruu0/avgvsrabsgdetB1)*avgvsrabsgdetB3)*avgvsrdxdxp33
        set avgvsromegaalt2=(avgvsrfdd02/avgvsrfdd23)*avgvsrdxdxp33
        set avgvsromegaalt3=(avgvsrfdd01/avgvsrfdd13)*avgvsrdxdxp33
        #
        set avgvsrabsomegaalt1=(avgvsruu3/avgvsruu0 - (avgvsruu1/avgvsruu0/avgvsrabsgdetB1)*avgvsrabsgdetB3)*avgvsrdxdxp33
        set avgvsrabsomegaalt2=(avgvsrabsfdd02/avgvsrabsfdd23)*avgvsrdxdxp33
        set avgvsrabsomegaalt3=(avgvsrabsfdd01/avgvsrabsfdd13)*avgvsrdxdxp33
        #
        #4panelinflowsetup 0.2 1.61346241523502 100 5
        4panelinflowsetup 0.2 1.799 100 5
        #
        defaults
        #
        ltype 0 ctype default  pl 0 avgvsrr (avgvsromegaf2/omegah*avgvsrdxdxp33) 1000
        # pretty good (sits offset from average --- high and low -- but ok)
        ctype yellow   pl 0 avgvsrr (avgvsromegaf2b/omegah*avgvsrdxdxp33) 1010
        # noisy as expected:
        #ctype green   pl 0 avgvsrr (avgvsromegaf1/omegah*avgvsrdxdxp33) 1010
        # not bad (sits closer to average than above)
        ctype magenta   pl 0 avgvsrr (avgvsromegaf1b/omegah*avgvsrdxdxp33) 1010
        #
        ltype 0 ctype default  pl 0 avgvsrr (avgvsromegaf2/omegah*avgvsrdxdxp33) 1000
        # much higher than normal version, so signed-version flips alot:
        ctype cyan  pl 0 avgvsrr (avgvsrabsomegaf2/omegah*avgvsrdxdxp33) 1010
        # not too bad, but generally above normal version:
        ctype yellow   pl 0 avgvsrr (avgvsrabsomegaf2b/omegah*avgvsrdxdxp33) 1010
        # noisy as expected:
        #ctype green   pl 0 avgvsrr (avgvsrabsomegaf1/omegah*avgvsrdxdxp33) 1010
        # sits a bit inside average, but not as good as non-abs version
        ctype magenta   pl 0 avgvsrr (avgvsrabsomegaf1b/omegah*avgvsrdxdxp33) 1010
        #
        ltype 0 ctype default  pl 0 avgvsrr (avgvsromegaf2/omegah*avgvsrdxdxp33) 1000
        # ok at small radii, but grows ever different at small radii -- very smooth though.
        ctype cyan  pl 0 avgvsrr (avgvsromegaalt1/omegah) 1010
        # noisy:
        ctype blue  pl 0 avgvsrr (avgvsromegaalt2/omegah) 1010
        # noisy:
        ctype red  pl 0 avgvsrr (avgvsromegaalt3/omegah) 1010
        #
        ltype 0 ctype default  pl 0 avgvsrr (avgvsromegaf2/omegah*avgvsrdxdxp33) 1000
        # just like non-avs version:
        ctype cyan  pl 0 avgvsrr (avgvsrabsomegaalt1/omegah) 1010
        # kinda ok:
        ctype blue  pl 0 avgvsrr (avgvsrabsomegaalt2/omegah) 1010
        # diverges at smaller radii
        ctype red  pl 0 avgvsrr (avgvsrabsomegaalt3/omegah) 1010
        #
        ################################################################
        #
rdvsphi 0
        ##############
        #1:lrhosmall3215_Rzxym1.eps
        #2:lrhosmall4190_Rzxym1.eps
        #3:lrhosmall4300_Rzxym1.eps
        #
        # columns=15
        define filename datavsphi1.txt
        da $filename
        lines 1 100000
        read '%g %d %g   %g %g %g %g   %g %g %g %g   %g %g %g %g' {tphi1 phik1 phi1 rhovsphi1radhor rhovsphi1rad4 rhovsphi1rad8 rhovsphi1rad30 rhovsphi1eqradhor rhovsphi1eqrad4 rhovsphi1eqrad8 rhovsphi1eqrad30 rhovsphi1equnradhor rhovsphi1equnrad4 rhovsphi1equnrad8 rhovsphi1equnrad30}
        #
        # columns=15
        define filename datavsphi2.txt
        da $filename
        lines 1 100000
        read '%g %d %g   %g %g %g %g   %g %g %g %g   %g %g %g %g' {tphi2 phik2 phi2 rhovsphi2radhor rhovsphi2rad4 rhovsphi2rad8 rhovsphi2rad30 rhovsphi2eqradhor rhovsphi2eqrad4 rhovsphi2eqrad8 rhovsphi2eqrad30 rhovsphi2equnradhor rhovsphi2equnrad4 rhovsphi2equnrad8 rhovsphi2equnrad30}
        #
        # columns=15
        define filename datavsphi3.txt
        da $filename
        lines 1 100000
        read '%g %d %g   %g %g %g %g   %g %g %g %g   %g %g %g %g' {tphi3 phik3 phi3 rhovsphi3radhor rhovsphi3rad4 rhovsphi3rad8 rhovsphi3rad30 rhovsphi3eqradhor rhovsphi3eqrad4 rhovsphi3eqrad8 rhovsphi3eqrad30 rhovsphi3equnradhor rhovsphi3equnrad4 rhovsphi3equnrad8 rhovsphi3equnrad30}
        #
        #
        #
        #
rdpowervsmold 0
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
        define filename powervs7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1radhor}
        #
        define filename powervs9vsma_FMrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad4}
        #
        define filename powervs9vsmb_FMrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad8}
        #
        define filename powervs9vsmc_FMrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad30}
        #
        ###########################
        define filename powervs1vsmz_rhosrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2radhor}
        #
        #
        define filename powervs1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad4}
        #
        define filename powervs1vsmb_rhosrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad8}
        #
        define filename powervs1vsmc_rhosrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad30}
        #
        ##############################
        #
        define filename powervs2vsmz_ugsrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3radhor}
        #
        define filename powervs2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad4}
        #
        define filename powervs2vsmb_ugsrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad8}
        #
        define filename powervs2vsmc_ugsrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad30}
        #
        ##############################
  
        define filename powervs6vsmz_bsqrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4radhor}
        #
        define filename powervs8vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad4}
        #
        define filename powervs8vsmb_bsqrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad8}
        #
        define filename powervs8vsmc_bsqrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad30}
        #
        ##############################
        define filename powervs9vsmz_FEEMrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5radhor}
        #
        define filename powervs11vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad4}
        #
        define filename powervs11vsmb_FEEMrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad8}
        #
        define filename powervs11vsmc_FEEMrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad30}
        #
rdpowervsm 0
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
        define filename powervs7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1radhor}
        #
        define filename powervs10vsma_FMrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad4}
        #
        define filename powervs10vsmb_FMrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad8}
        #
        define filename powervs10vsmc_FMrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm1rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm1rad30}
        #
        ###########################
        define filename powervs1vsmz_rhosrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2radhor}
        #
        #
        define filename powervs1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad4}
        #
        define filename powervs1vsmb_rhosrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad8}
        #
        define filename powervs1vsmc_rhosrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm2rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm2rad30}
        #
        ##############################
        #
        define filename powervs2vsmz_ugsrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3radhor}
        #
        define filename powervs2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad4}
        #
        define filename powervs2vsmb_ugsrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad8}
        #
        define filename powervs2vsmc_ugsrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm3rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm3rad30}
        #
        ##############################
  
        define filename powervs6vsmz_bsqrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4radhor}
        #
        define filename powervs9vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad4}
        #
        define filename powervs9vsmb_bsqrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad8}
        #
        define filename powervs9vsmc_bsqrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm4rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm4rad30}
        #
        ##############################
        define filename powervs9vsmz_FEEMrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5radhor}
        #
        define filename powervs12vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad4}
        #
        define filename powervs12vsmb_FEEMrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad8}
        #
        define filename powervs12vsmc_FEEMrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {mmi mm powerm5rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerm5rad30}
        #
        #
rdpowervsl 0
        ################
        # powervsl
        #
        # powervsl%d%s_%s.txt" % (filenum,fileletter,pllabel)
        #(_dx1,_dx2,_dx3))
        #("ii","xtoplot","ytoplot"))
        #(normpowersumnotm0a,normpowersumnotm0b,np.fabs(qty[0]),(1.0/_dx1)*np.fabs(qty[0])))
        #
        #
        #
        define filename powervs7vslz_FMrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl1radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl1radhor}
        #
        define filename powervs9vsla_FMrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl1rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl1rad4}
        #
        define filename powervs9vslb_FMrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl1rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl1rad8}
        #
        define filename powervs9vslc_FMrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl1rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl1rad30}
        #
        ###########################
        define filename powervs1vslz_rhosrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl2radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl2radhor}
        #
        #
        define filename powervs1vsla_rhosrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl2rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl2rad4}
        #
        define filename powervs1vslb_rhosrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl2rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl2rad8}
        #
        define filename powervs1vslc_rhosrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl2rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl2rad30}
        #
        ##############################
        #
        define filename powervs2vslz_ugsrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl3radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl3radhor}
        #
        define filename powervs2vsla_ugsrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl3rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl3rad4}
        #
        define filename powervs2vslb_ugsrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl3rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl3rad8}
        #
        define filename powervs2vslc_ugsrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl3rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl3rad30}
        #
        ##############################
  
        define filename powervs6vslz_bsqrhosq_jet_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl4radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl4radhor}
        #
        define filename powervs8vsla_bsqrhosq_jet_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl4rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl4rad4}
        #
        define filename powervs8vslb_bsqrhosq_jet_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl4rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl4rad8}
        #
        define filename powervs8vslc_bsqrhosq_jet_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl4rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl4rad30}
        #
        ##############################
        define filename powervs9vslz_FEEMrhosq_jet_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl5radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl5radhor}
        #
        define filename powervs11vsla_FEEMrhosq_jet_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl5rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl5rad4}
        #
        define filename powervs11vslb_FEEMrhosq_jet_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl5rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl5rad8}
        #
        define filename powervs11vslc_FEEMrhosq_jet_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {lli ll powerl5rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowerl5rad30}
        #
        #
rdpowervsn 0
        ################
        # powervsn
        #
        # powervsn%d%s_%s.txt" % (filenum,fileletter,pllabel)
        #(_dx1,_dx2,_dx3))
        #("ii","xtoplot","ytoplot"))
        #(normpowersumnotm0a,normpowersumnotm0b,np.fabs(qty[0]),(1.0/_dx1)*np.fabs(qty[0])))
        #
        #
        #
        define filename powervs7vsnz_FMrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern1radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern1radhor}
        #
        define filename powervs9vsna_FMrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern1rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern1rad4}
        #
        define filename powervs9vsnb_FMrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern1rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern1rad8}
        #
        define filename powervs9vsnc_FMrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern1rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern1rad30}
        #
        ###########################
        define filename powervs1vsnz_rhosrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern2radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern2radhor}
        #
        #
        define filename powervs1vsna_rhosrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern2rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern2rad4}
        #
        define filename powervs1vsnb_rhosrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern2rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern2rad8}
        #
        define filename powervs1vsnc_rhosrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern2rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern2rad30}
        #
        ##############################
        #
        define filename powervs2vsnz_ugsrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern3radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern3radhor}
        #
        define filename powervs2vsna_ugsrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern3rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern3rad4}
        #
        define filename powervs2vsnb_ugsrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern3rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern3rad8}
        #
        define filename powervs2vsnc_ugsrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern3rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern3rad30}
        #
        ##############################
  
        define filename powervs6vsnz_bsqrhosq_jet_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern4radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern4radhor}
        #
        define filename powervs8vsna_bsqrhosq_jet_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern4rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern4rad4}
        #
        define filename powervs8vsnb_bsqrhosq_jet_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern4rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern4rad8}
        #
        define filename powervs8vsnc_bsqrhosq_jet_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern4rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern4rad30}
        #
        ##############################
        define filename powervs9vsnz_FEEMrhosq_jet_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern5radhor}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern5radhor}
        #
        define filename powervs11vsna_FEEMrhosq_jet_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern5rad4}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern5rad4}
        #
        define filename powervs11vsnb_FEEMrhosq_jet_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern5rad8}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern5rad8}
        #
        define filename powervs11vsnc_FEEMrhosq_jet_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {nni nn powern5rad30}
        !head -4 $filename | tail -1 | awk '{print \\$2}' > $filename.norm
        da $filename.norm
        read '%g' {normpowern5rad30}
        #
        #
rdrbarnormvsphiold 0
        ################
        # rbarnormvs
        #
        # FILE:
        #file1 = open("rbarnormvs%d%s_%s.txt" % (filenum,fileletter,pllabel) , 'w')
        #file1.write("#%g %g %g\n" % (_dx1,_dx2,_dx3))
        #file1.write("#%s %s   %s\n" % ("ii","myph","Rbarnorm"))
        #file1.write("#%g\n" % (mcor))
        #file1.write("#Recall that ii and myph here are not true grid, but from inverse Fourier of (possibly) low-m-filled-with-zero Fourier transform, so myph always goes from 0 to 2pi.  Better than duplicating original \phi cells since anyways\n")
        #for ii in np.arange(0,len(myph)):
        #    file1.write("%d %g   %g\n" % (ii,myph[ii],Rbarnorm[ii]))
        #file1.close()
        #
        #
        #
        define filename rbarnormvs7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1radhor}
        #
        define filename rbarnormvs9vsma_FMrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad4}
        #
        define filename rbarnormvs9vsmb_FMrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad8}
        #
        define filename rbarnormvs9vsmc_FMrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad30}
        #
        ###########################
        define filename rbarnormvs1vsmz_rhosrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2radhor}
        #
        #
        define filename rbarnormvs1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad4}
        #
        define filename rbarnormvs1vsmb_rhosrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad8}
        #
        define filename rbarnormvs1vsmc_rhosrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad30}
        #
        ##############################
        #
        define filename rbarnormvs2vsmz_ugsrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3radhor}
        #
        define filename rbarnormvs2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad4}
        #
        define filename rbarnormvs2vsmb_ugsrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad8}
        #
        define filename rbarnormvs2vsmc_ugsrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad30}
        #
        ##############################
  
        define filename rbarnormvs6vsmz_bsqrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4radhor}
        #
        define filename rbarnormvs8vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad4}
        #
        define filename rbarnormvs8vsmb_bsqrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad8}
        #
        define filename rbarnormvs8vsmc_bsqrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad30}
        #
        ##############################
        define filename rbarnormvs9vsmz_FEEMrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5radhor}
        #
        define filename rbarnormvs11vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad4}
        #
        define filename rbarnormvs11vsmb_FEEMrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad8}
        #
        define filename rbarnormvs11vsmc_FEEMrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g' | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad30}
        #
rdrbarnormvsphi 0
        ################
        # rbarnormvs
        #
        # FILE:
        #file1 = open("rbarnormvs%d%s_%s.txt" % (filenum,fileletter,pllabel) , 'w')
        #file1.write("#%g %g %g\n" % (_dx1,_dx2,_dx3))
        #file1.write("#%s %s   %s\n" % ("ii","myph","Rbarnorm"))
        #file1.write("#%g\n" % (mcor))
        #file1.write("#Recall that ii and myph here are not true grid, but from inverse Fourier of (possibly) low-m-filled-with-zero Fourier transform, so myph always goes from 0 to 2pi.  Better than duplicating original \phi cells since anyways\n")
        #for ii in np.arange(0,len(myph)):
        #    file1.write("%d %g   %g\n" % (ii,myph[ii],Rbarnorm[ii]))
        #file1.close()
        #
        #
        #
        define filename rbarnormvs7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1radhor}
        #
        define filename rbarnormvs10vsma_FMrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad4}
        #
        define filename rbarnormvs10vsmb_FMrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad8}
        #
        define filename rbarnormvs10vsmc_FMrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm1rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm1rad30}
        #
        ###########################
        define filename rbarnormvs1vsmz_rhosrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2radhor}
        #
        #
        define filename rbarnormvs1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad4}
        #
        define filename rbarnormvs1vsmb_rhosrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad8}
        #
        define filename rbarnormvs1vsmc_rhosrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm2rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm2rad30}
        #
        ##############################
        #
        define filename rbarnormvs2vsmz_ugsrhosq_diskcorona_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3radhor}
        #
        define filename rbarnormvs2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad4}
        #
        define filename rbarnormvs2vsmb_ugsrhosq_diskcorona_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad8}
        #
        define filename rbarnormvs2vsmc_ugsrhosq_diskcorona_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm3rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm3rad30}
        #
        ##############################
  
        define filename rbarnormvs6vsmz_bsqrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4radhor}
        #
        define filename rbarnormvs9vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad4}
        #
        define filename rbarnormvs9vsmb_bsqrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad8}
        #
        define filename rbarnormvs9vsmc_bsqrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm4rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm4rad30}
        #
        ##############################
        define filename rbarnormvs9vsmz_FEEMrhosq_jet_phipow_radhor_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5radhor}
        #
        define filename rbarnormvs12vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad4}
        #
        define filename rbarnormvs12vsmb_FEEMrhosq_jet_phipow_rad8_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad8}
        #
        define filename rbarnormvs12vsmc_FEEMrhosq_jet_phipow_rad30_vsm.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {phii myph rbarm5rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g' | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {mcorm5rad30}
        #
        #
        #
rdrbarnormvstheta 0
        ################
        # rbarnormvs
        #
        # FILE:
        #file1 = open("rbarnormvs%d%s_%s.txt" % (filenum,fileletter,pllabel) , 'w')
        #file1.write("#%g %g %g\n" % (_dx1,_dx2,_dx3))
        #file1.write("#%s %s   %s\n" % ("ii","myth","Rbarnorm"))
        #file1.write("#%g\n" % (lcor))
        #file1.write("#Recall that ii and myth here are not true grid, but from inverse Fourier of (possibly) low-m-filled-with-zero Fourier transform, so myth always goes from 0 to 2pi.  Better than duplicating original \phi cells since anyways\n")
        #for ii in np.arange(0,len(myth)):
        #    file1.write("%d %g   %g\n" % (ii,myth[ii],Rbarnorm[ii]))
        #file1.close()
        #
        #
        #
        define filename rbarnormvs7vslz_FMrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl1radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm1radhor}
        #
        define filename rbarnormvs9vsla_FMrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl1rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm1rad4}
        #
        define filename rbarnormvs9vslb_FMrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl1rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm1rad8}
        #
        define filename rbarnormvs9vslc_FMrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl1rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm1rad30}
        #
        ###########################
        define filename rbarnormvs1vslz_rhosrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl2radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm2radhor}
        #
        #
        define filename rbarnormvs1vsla_rhosrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl2rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm2rad4}
        #
        define filename rbarnormvs1vslb_rhosrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl2rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm2rad8}
        #
        define filename rbarnormvs1vslc_rhosrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl2rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm2rad30}
        #
        ##############################
        #
        define filename rbarnormvs2vslz_ugsrhosq_diskcorona_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl3radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm3radhor}
        #
        define filename rbarnormvs2vsla_ugsrhosq_diskcorona_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl3rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm3rad4}
        #
        define filename rbarnormvs2vslb_ugsrhosq_diskcorona_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl3rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm3rad8}
        #
        define filename rbarnormvs2vslc_ugsrhosq_diskcorona_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl3rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm3rad30}
        #
        ##############################
  
        define filename rbarnormvs6vslz_bsqrhosq_jet_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl4radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm4radhor}
        #
        define filename rbarnormvs8vsla_bsqrhosq_jet_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl4rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm4rad4}
        #
        define filename rbarnormvs8vslb_bsqrhosq_jet_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl4rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm4rad8}
        #
        define filename rbarnormvs8vslc_bsqrhosq_jet_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl4rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm4rad30}
        #
        ##############################
        define filename rbarnormvs9vslz_FEEMrhosq_jet_thetapow_radhor_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl5radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm5radhor}
        #
        define filename rbarnormvs11vsla_FEEMrhosq_jet_thetapow_rad4_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl5rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm5rad4}
        #
        define filename rbarnormvs11vslb_FEEMrhosq_jet_thetapow_rad8_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl5rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm5rad8}
        #
        define filename rbarnormvs11vslc_FEEMrhosq_jet_thetapow_rad30_vsl.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {thetaii myth rbarl5rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g' | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {lcorm5rad30}
        #
        #
        #
rdrbarnormvsrad 0
        ################
        # rbarnormvs
        #
        # FILE:
        #file1 = open("rbarnormvs%d%s_%s.txt" % (filenum,fileletter,pllabel) , 'w')
        #file1.write("#%g %g %g\n" % (_dx1,_dx2,_dx3))
        #file1.write("#%s %s   %s\n" % ("ii","myrad","Rbarnorm"))
        #file1.write("#%g\n" % (ncor))
        #file1.write("#Recall that ii and myrad here are not true grid, but from inverse Fourier of (possibly) low-m-filled-with-zero Fourier transform, so myrad always goes from 0 to 2pi.  Better than duplicating original \phi cells since anyways\n")
        #for ii in np.arange(0,len(myrad)):
        #    file1.write("%d %g   %g\n" % (ii,myrad[ii],Rbarnorm[ii]))
        #file1.close()
        #
        #
        #
        define filename rbarnormvs7vsnz_FMrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myradhor rbarn1radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm1radhor}
        #
        define filename rbarnormvs9vsna_FMrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad4 rbarn1rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm1rad4}
        #
        define filename rbarnormvs9vsnb_FMrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad8 rbarn1rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm1rad8}
        #
        define filename rbarnormvs9vsnc_FMrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad30 rbarn1rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm1rad30}
        #
        ###########################
        define filename rbarnormvs1vsnz_rhosrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myradhor rbarn2radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm2radhor}
        #
        #
        define filename rbarnormvs1vsna_rhosrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad4 rbarn2rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm2rad4}
        #
        define filename rbarnormvs1vsnb_rhosrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad8 rbarn2rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm2rad8}
        #
        define filename rbarnormvs1vsnc_rhosrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad30 rbarn2rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm2rad30}
        #
        ##############################
        #
        define filename rbarnormvs2vsnz_ugsrhosq_diskcorona_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myradhor rbarn3radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm3radhor}
        #
        define filename rbarnormvs2vsna_ugsrhosq_diskcorona_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad4 rbarn3rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm3rad4}
        #
        define filename rbarnormvs2vsnb_ugsrhosq_diskcorona_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad8 rbarn3rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm3rad8}
        #
        define filename rbarnormvs2vsnc_ugsrhosq_diskcorona_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad30 rbarn3rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm3rad30}
        #
        ##############################
  
        define filename rbarnormvs6vsnz_bsqrhosq_jet_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myradhor rbarn4radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm4radhor}
        #
        define filename rbarnormvs8vsna_bsqrhosq_jet_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad4 rbarn4rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm4rad4}
        #
        define filename rbarnormvs8vsnb_bsqrhosq_jet_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad8 rbarn4rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm4rad8}
        #
        define filename rbarnormvs8vsnc_bsqrhosq_jet_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad30 rbarn4rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm4rad30}
        #
        ##############################
        define filename rbarnormvs9vsnz_FEEMrhosq_jet_radiuspow_radhor_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myradhor rbarn5radhor}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm5radhor}
        #
        define filename rbarnormvs11vsna_FEEMrhosq_jet_radiuspow_rad4_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad4 rbarn5rad4}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm5rad4}
        #
        define filename rbarnormvs11vsnb_FEEMrhosq_jet_radiuspow_rad8_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad8 rbarn5rad8}
        !head -3 $filename | tail -1 | sed 's/\#//g'  | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm5rad8}
        #
        define filename rbarnormvs11vsnc_FEEMrhosq_jet_radiuspow_rad30_vsn.txt
        da $filename
        lines 3 100000
        read '%d %g   %g' {radii myrad30 rbarn5rad30}
        !head -3 $filename | tail -1 | sed 's/\#//g' | awk '{print \\$1}' > $filename.norm
        lines 1 2
        da $filename.norm
        read '%g' {ncorm5rad30}
        #
        #
        #
visctheory 0 #
        #
        set rcut1=r if(r>risco)
        #set rcut1=r
        set omegak=1.0/(a + rcut1**(1.5))
        set vuasrotrhosqdcdenvsrkep=rcut1*omegak
        # G*M*m/r = (1/2)*m*v^2 -> v=sqrt(2GM/r)
         #
        set rcut2=rcut1
        #
        set thetat=atan(horalt1)
        #
        set myhor=hoverrvsr
        #set myhor=horalt1
        #set myhor=thetat
        #set myhor=1.0 + r*0 # for getting epsilon or fit
        #
        #set myalpha=alphatot3vsr # better for normal disks
        set myalpha=alphatot3vsr*betamagplus1  # better for fiducial model
        #set myalpha=alphamag4vsr
        #set myalpha=0.10 + r*0 # for getting epsilon or fit
        #
        set alphahorsq=(myalpha*myhor**2) if (r>risco)
        set alphahorsqvel=(myalpha*myhor**2*vuasrotrhosqdcdenvsr) if (r>risco)
        set alphahorsqvelalt=(0.1*vuasrotrhosqdcdenvsr) if (r>risco)
        #
        # Page & Thorne (1974) eq14,15
        set xx=sqrt(rcut2)
        set signa=(a>=0 ? 1 : -1)
        set Z1=1 + (1-a**2)**(1/3)*((1+a)**(1/3) + (1-a)**(1/3) )
        set Z2=sqrt(3*a**2+Z1**2)
        set rms=3 + Z2 - signa*sqrt((3 - Z1)*(3 + Z1 + 2*Z2) )
        set xx0=sqrt(rms)
        set xx1=2*cos((1/3)*acos(a)-pi/3)
        set xx2=2*cos((1/3)*acos(a)+pi/3)
        set xx3=-2*cos((1/3)*acos(a))
        #
        set AA=1 + a**2/xx**4 + 2*a**2/xx**6
        set BB=1 + a/xx**3
        set CC=1 - 3/xx**2 + 2*a/xx**3
        set DD=1 - 2/xx**2 + a**2/xx**4
        set EE=1 + 4*a**2/xx**4 - 4*a**2/xx**6 + 3*a**4/xx**8
        set FF=1 - 2*a/xx**3 + a**2/xx**4
        set GG=1 - 2/xx**2 + a/xx**3
        #
        set Edag=(CC)**(-0.5)*GG
        set Ldag=xx*(CC)**(-0.5)*FF
        #
        # Page & Thorne (1974) eq 35
        set QQa=((1 + a/xx**3)/sqrt(1 - 3/xx**2 + 2*a/xx**3))*(1/xx)
        set QQb=xx - xx0 - (3/2)*a*ln(xx/xx0) - (3*(xx1-a)**2)/(xx1*(xx1-xx2)*(xx1-xx3))*ln((xx-xx1)/(xx0-xx1)) - (3*(xx2-a)**2)/(xx2*(xx2-xx1)*(xx2-xx3))*ln((xx-xx2)/(xx0-xx2)) - (3*(xx3-a)**2)/(xx3*(xx3-xx1)*(xx3-xx2))*ln((xx-xx3)/(xx0-xx3))
        set QQ=QQa*QQb
        set GRFACTOR=AA**(-2)*BB**(3)*CC**(-3/2)*DD**(3/2)*EE*QQ**(-1)
        #
        set vus1rhosqdcdenvsrffNEWT=(alphahorsq)*vuasrotrhosqdcdenvsrkep
        set vus1rhosqdcdenvsrffGR=(alphahorsqvel)*GRFACTOR
        set vus1rhosqdcdenvsrffGRalt=(alphahorsqvelalt)*GRFACTOR
        #
        #
        set horsqvphi=(myhor**2*vuasrotrhosqdcdenvsr) if (r>risco)
        #set myvr=vuas1rhosqdcdenvsr if (r>risco)
        #GODMARK: Different in disk! even for thin disk
        set myvr=vus1rhosqdcdenvsr if (r>risco)
        set alphaeffvsr =-myvr/(GRFACTOR*horsqvphi)
        #
        #
        #
        #
        #
        #
        #
velvsradpl 1 # velvsradpl <doscp=0,1>
        #########################################
        # jet included:
        #pl 0 r vus1rhosqvsr 1101 2.1 1E4 1E-3 1
        # jet not included, but still not over full disk+corona (i.e. non-jet)
        #pl 0 r vus1horvsr 1101 2.1 1E4 1E-4 1
        #pl 0 r vus3horvsr 1101 2.1 1E4 1E-4 1
        #pl 0 r beta 1101 (r[0]) 100 1E-3 1E3
        #
        # bounding box:
        #http://amath.colorado.edu/documentation/LaTeX/reference/bbox.html
        #
        #
        # these postencap's are setup on ki-jmck:
        # FINALPLOTS:
        #
        #
        device postencap rhovelvsr.eps
        panelplot1
        device X11
        if(doscp==1){\
                     # jon@ki-rh42:/data/jon/thickdisk/harm_thickdisk/
                     # jon@physics-179.umd.edu:/data/jon/harm_harmrad/
         !scp rhovelvsr.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap rhoveleqvsr.eps
        panelplot1eq
        device X11
        if(doscp==1){\
         !scp rhoveleqvsr.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap rhovelhorvsr.eps
        panelplot1hor
        device X11
        if(doscp==1){\
         !scp rhovelhorvsr.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap6c2 fluxvsr.eps
        #device postencap6c fluxvsr.eps
        panelplot2
        device X11
        if(doscp==1){\
        !scp fluxvsr.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        #device postencap5 othersvsr.eps
        device  postencap4 othersvsr.eps
        panelplot3
        device X11
        if(doscp==1){\
        !scp othersvsr.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap4 rhovelvsh.eps
        panelplot4
        device X11
        if(doscp==1){\
        !scp rhovelvsh.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap6b2 fluxvst.eps
        panelplot5
        device X11
        if(doscp==1){\
        !scp fluxvst.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap5 horizonflux.eps
        panelplot6
        device X11
        if(doscp==1){\
        !scp horizonflux.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap5t powervsm.eps
        panelplot7
        device X11
        if(doscp==1){\
        !scp powervsm.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap gammieplot.eps
        gammieplot
        device X11
        if(doscp==1){\
        !scp gammieplot.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap4t rhovsphi.eps
        panelplot8
        device X11
        if(doscp==1){\
         !scp rhovsphi.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        device postencap2t rhovsphib.eps
        panelplot8b
        device X11
        if(doscp==1){\
         !scp rhovsphib.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
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
        #set faker=2  #rhor
        set faker=rhor
        # gdet B^1 dx2 dx3 = r**2 sin(hbz) B^r dh dphi = dtheta A_\phi,\theta
        set avgabsgdetB1bz2=0.5*( (faker+2.0*ln(1.0+cos(hbz)))*sin(hbz) )*avgdtheta
        #
        set omegafpara0=(1/4*sin(hbz)**2*(1+ln(1+cos(hbz))))/(4*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz)))
        set omegafpara0=(a>=0 ? omegafpara0 : -omegafpara0) # account for sign
        # get omegaf/omegah in form as done in BZ -- issue is BZ is expansion in a for omegaf/omegah
        set omegafohpara=abs(omegafpara0)/(1.0/(2*2))
        set omegafpara1=omegafohpara*omegah # reget for general omegah, including with correct sign
        #
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
        set pickomegaf=avgomegaf2*avgdxdxp33
        # alt's already have dxdxp33's in them
        #set pickomegaf=avgomegaalt1
        # below is closest to <omegaf2> without being noisy -- rests near average of noisy part rather than trending above or below
        set pickomegaf=avgomegaf1b*avgdxdxp33
        #
        set cleanavgomegaf2=(pickomegaf/omegah)
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
            set cleanavgomegaf2=(pickomegaf/omegah)
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
        ######################################################
        # FULL bz formula using code B1 and omegaf, not as in his paper's mono or paraboloidal models.
        #set chooseomegaf=cleanavgomegaf2*omegah
        set chooseomegaf=pickomegaf
        #
        set sigma=rhor**2+a**2*cos(avgh)**2
        set gdetbz=sigma*abs(sin(avgh))
        # add our gdet and remove their gdet
        set avgabsBr=avgdxdxp11*avgabsB1
        #
        set avggdetTudEM10bz=-2*(avgabsBr)**2*(chooseomegaf)*rhor*(omegah-chooseomegaf)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        #
        #*(fakegdet/(gdetbz*2*pi*avgdtheta))
        set omegah1=(1/2)
        #        set LdotEMvshbz=4*EdotEMvshbz*(omegah/omegah1)**(-1)
        #set LdotEMvshbz=8*EdotEMvshbz/(a)
        set avggdetTudEM13bz=avggdetTudEM10bz/(chooseomegaf)
        # (omegah/omegah1)^{-1}=omegah1/omegah=(1/2)/(a/(2*rp)) = rp/a \sim 2/a for small a. 
        # omega=a/8 for small a
        #
        #
        #
        ######################################################
        ######################################################
        # FULL BZ (BUT WITH PARA OMEGAF)
        set chooseomegaf2=omegafpara0
        #
        set avggdetTudEM10bz2=-2*(avgabsBr)**2*(chooseomegaf2)*rhor*(omegah-chooseomegaf2)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        set avggdetTudEM13bz2=avggdetTudEM10bz2/(chooseomegaf2)
        #
        ######################################################
        # FULL BZ (BUT WITH PARA OMEGAF -- alt version)
        set chooseomegaf2alt=omegafpara1
        #
        set avggdetTudEM10bz2alt=-2*(avgabsBr)**2*(chooseomegaf2alt)*rhor*(omegah-chooseomegaf2alt)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        set avggdetTudEM13bz2alt=avggdetTudEM10bz2alt/(chooseomegaf2alt)
        ######################################################
        # FULL BZ (BUT WITH PARA OMEGAF and PARA FLUX -- altalt version)
        set chooseomegaf2altalt=omegafpara1
        #
        # get magnetic flux ratio so can renormalize power result
        set fluxratio=SUM(avgabsBr*2*pi*gdetbz*avgdtheta)/SUM(avgabsgdetB1bz2)
        set avgabsBrbz2=avgabsgdetB1bz2/(gdetbz*avgdtheta*2*pi)
        #
        set avggdetTudEM10bz2altalt=-2*fluxratio**2*(avgabsBrbz2)**2*(chooseomegaf2altalt)*rhor*(omegah-chooseomegaf2altalt)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        set avggdetTudEM13bz2altalt=avggdetTudEM10bz2altalt/(chooseomegaf2altalt)
        #
        ######################################################
        # FULL BZ (BUT WITH dumb PARA OMEGAF and PARA FLUX -- altaltalt version)
        set chooseomegaf2altaltalt=omegafpara0
        #
        # get magnetic flux ratio so can renormalize power result
        set fluxratio=SUM(avgabsBr*2*pi*gdetbz*avgdtheta)/SUM(avgabsgdetB1bz2)
        set avgabsBrbz2=avgabsgdetB1bz2/(gdetbz*avgdtheta*2*pi)
        #
        set avggdetTudEM10bz2altaltalt=-2*fluxratio**2*(avgabsBrbz2)**2*(chooseomegaf2altaltalt)*rhor*(omegah-chooseomegaf2altaltalt)*sin(avgh)**2*(2*pi*gdetbz*avgdtheta)
        set avggdetTudEM13bz2altaltalt=avggdetTudEM10bz2altaltalt/(chooseomegaf2altaltalt)
        #
        #
        #
        #
        ######################################################
        # integrate in theta around equator
        set intavgabsgdetB1=avgabsgdetB1*0
        set intavgabsgdetB1bz0=avgabsgdetB1*0
        set intavgabsgdetB1bz=avgabsgdetB1*0
        set intavgabsgdetB1bz2=avgabsgdetB1*0
        set intavgTudEM10=avgabsgdetB1*0
        set intavggdetTudEM10bz=avgabsgdetB1*0
        set intavggdetTudEM13bz=avgabsgdetB1*0
        set intavggdetTudEM10bz2=avgabsgdetB1*0
        set intavggdetTudEM13bz2=avgabsgdetB1*0
        set intavggdetTudEM10bz2alt=avgabsgdetB1*0
        set intavggdetTudEM13bz2alt=avgabsgdetB1*0
        set intavggdetTudEM10bz2altalt=avgabsgdetB1*0
        set intavggdetTudEM13bz2altalt=avgabsgdetB1*0
        set intavggdetTudEM10bz2altaltalt=avgabsgdetB1*0
        set intavggdetTudEM13bz2altaltalt=avgabsgdetB1*0
        set intavggdetTudEM10bz2altaltaltalt=avgabsgdetB1*0
        set intavggdetTudEM13bz2altaltaltalt=avgabsgdetB1*0
        set intavgTudMA10=avgabsgdetB1*0
        set intavgrhouu1=avgabsgdetB1*0
        set intavgTudEM13=avgabsgdetB1*0
        set intavgTudMA13=avgabsgdetB1*0
        #
        # for thickdisk models
        set maxbsqorho=30.0
        # for sasha models
        #set maxbsqorho=100.0
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
          ###########################
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz=(-avggdetTudEM10bz) if(myuse)
          set intavggdetTudEM10bz[$jj]=SUM(preintavggdetTudEM10bz)
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz=(-avggdetTudEM13bz) if(myuse)
          set intavggdetTudEM13bz[$jj]=SUM(preintavggdetTudEM13bz)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz2=(-avggdetTudEM10bz2) if(myuse)
          set intavggdetTudEM10bz2[$jj]=SUM(preintavggdetTudEM10bz2)
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz2=(-avggdetTudEM13bz2) if(myuse)
          set intavggdetTudEM13bz2[$jj]=SUM(preintavggdetTudEM13bz2)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz2alt=(-avggdetTudEM10bz2alt) if(myuse)
          set intavggdetTudEM10bz2alt[$jj]=SUM(preintavggdetTudEM10bz2alt)
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz2alt=(-avggdetTudEM13bz2alt) if(myuse)
          set intavggdetTudEM13bz2alt[$jj]=SUM(preintavggdetTudEM13bz2alt)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz2altalt=(-avggdetTudEM10bz2altalt) if(myuse)
          set intavggdetTudEM10bz2altalt[$jj]=SUM(preintavggdetTudEM10bz2altalt)
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz2altalt=(-avggdetTudEM13bz2altalt) if(myuse)
          set intavggdetTudEM13bz2altalt[$jj]=SUM(preintavggdetTudEM13bz2altalt)
          #
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM10bz2altaltalt=(-avggdetTudEM10bz2altaltalt) if(myuse)
          set intavggdetTudEM10bz2altaltalt[$jj]=SUM(preintavggdetTudEM10bz2altaltalt)
          # uses gdetbz, not code's gdet
          set preintavggdetTudEM13bz2altaltalt=(-avggdetTudEM13bz2altaltalt) if(myuse)
          set intavggdetTudEM13bz2altaltalt[$jj]=SUM(preintavggdetTudEM13bz2altaltalt)
          #
          ###########################
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
        ###########################
        set EdotEMvshbz=intavggdetTudEM10bz/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz=intavggdetTudEM13bz/abs(mdotfinavgvsr30[ihor])
        set EdotEMvshbz2=intavggdetTudEM10bz2/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz2=intavggdetTudEM13bz2/abs(mdotfinavgvsr30[ihor])
        set EdotEMvshbz2alt=intavggdetTudEM10bz2alt/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz2alt=intavggdetTudEM13bz2alt/abs(mdotfinavgvsr30[ihor])
        set EdotEMvshbz2altalt=intavggdetTudEM10bz2altalt/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz2altalt=intavggdetTudEM13bz2altalt/abs(mdotfinavgvsr30[ihor])
        set EdotEMvshbz2altaltalt=intavggdetTudEM10bz2altaltalt/abs(mdotfinavgvsr30[ihor])
        set LdotEMvshbz2altaltalt=intavggdetTudEM13bz2altaltalt/abs(mdotfinavgvsr30[ihor])
        ###########################
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
          4panelinflowsetup2 upsilongammie 100 $iijj
          set printiijj=$iijj
          print {printiijj}
        }
        #
        #
        # 4panelinflowsetup 0.1 1.81 100 7
         #        4panelinflowsetup 0.2 1.61346241523502 100 5
4panelinflowsetup 4 # Gammie plot setup all parts
        #
        set myhor=$1
        set myfactor=$2
        set numiters=$3
        set numpoints=$4
        #
        4panelinflowsetup1 myhor
        #
        # get Gammie solution
        #        set upsilongammie=upsilonH*1.49
        set upsilongammie=upsilonH*myfactor # matches F_L better even though bsq a bit worse still looks good in log
        #set upsilongammie=8.26301122953957 # trial from before
        #4panelinflowsetup2 upsilongammie 1000 43
        #4panelinflowsetup2 upsilongammie 1000 7000
        #4panelinflowsetup2 upsilongammie 1000 5
        4panelinflowsetup2 upsilongammie numiters numpoints
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
4panelinflowsetup1 1 # Gammie plot setup
        #
        set myhor=$1
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
        set uurvsr=(avgvsruu1*dxdxp11+avgvsruu2*dxdxp12) # matches gammie
        #set avgvsrh=pi*0.5
        #set Sigma=avgvsrr**2+(a*cos(avgvsrh))**2
        #set gv311ks=1+2*avgvsrr/Sigma
        #set uurvsr=uurvsr*sqrt(gks311)
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
        #set hor=avgvsrhor
        set hor=myhor
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
        # avoid cookie-cutout effect for disk-jet boundary:
        set Tud10Bvsr=-avgvsrTudEM10*avgvsrrhosqint
        smooth Tud10Bvsr sTud10Bvsr 5
        set Tud10Bvsr=sTud10Bvsr
        set Tud10PAvsr=-avgvsrTudPA10*avgvsrrhosqint
        set Tud10IEvsr=-avgvsrTudIE10*avgvsrrhosqint
        set Tud13Bvsr=-avgvsrTudEM13*avgvsrrhosqint
        smooth Tud13Bvsr sTud13Bvsr 5
        set Tud13Bvsr=sTud13Bvsr
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
        set upsilonvsrgammie=sqrt(2)*(intBr/intFM)*sqrt(intFMH/SAH)
        set upsilonH=upsilonvsrgammie[ihor]
        #
        #
        #
        #
4panelinflowsetup2 3 # 4panelinflowsetup Upsilon 10000 2030
		# get gammie solution
		define magpar ($1)
		define bhspin (a)
		define numpoints ($2)
        #
		!./inf_const $magpar $bhspin $numpoints > ./gammiesol1.txt
        !wc -l ./gammiesol1.txt | awk '{print \\$1}' > wcit.txt
        da wcit.txt
        lines 1 1
        read {numlines 1}
        if(numlines==0){\
         define numpoints 1000
 		 !./inf_const $magpar $bhspin $numpoints > ./gammiesol1.txt
        }
        #
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
         set FMvsrg1=FMvsr[0]/(2*hor[0])*boxfactor
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
         # (Tud10PAvsr+Tud10Bvsr+Tud10IEvsr)/FMvsr = constant(r)
         set C10vsr=(Tud10PAvsr+Tud10Bvsr+Tud10IEvsr)/FMvsr
         set newTud10Bvsr = C10vsr[0]*FMvsr - (Tud10PAvsr+Tud10IEvsr)
         #
         # for below, signs shouldn't be problem
         # integral, not average
         # FE and FL parts (these use FMvsr directly, since flux ratio)
         set Tud10totvsr=(Tud10PAvsr+Tud10Bvsr+Tud10IEvsr)
         set factorTud10=(Tud10totvsr[0]/FMvsr[0])/(Tud10totvsr/FMvsr)
         #set factorTud10=1
         smooth factorTud10 sfactorTud10 5
         #set sfactorTud10=1
         #
         # only EM flux is cut-off at edge of non-jet cut, so only need to de-cookie that term
         set FEPAvsr=-Tud10PAvsr/(FMvsr)*1
         set FEEMvsr=-newTud10Bvsr/(FMvsr)*1
         set FEIEvsr=-Tud10IEvsr/(FMvsr)*1
         set FEtotvsr=FEPAvsr+FEEMvsr+FEIEvsr
         #
         # print {newr FMvsr Tud10totvsr FEtotvsr FEPAvsr FEEMvsr FEIEvsr factorTud10}
         #
         set C13vsr=(Tud13PAvsr+Tud13Bvsr+Tud13IEvsr)/FMvsr
         set newTud13Bvsr = C13vsr[0]*FMvsr - (Tud13PAvsr+Tud13IEvsr)
         #
         set Tud13totvsr=Tud13PAvsr+Tud13Bvsr+Tud13IEvsr
         set factorTud13=(Tud13totvsr[0]/FMvsr[0])/(Tud13totvsr/FMvsr)
         #set factorTud13=1
         smooth factorTud13 sfactorTud13 5
         #set sfactorTud13=1
         #
         set FLPAvsr=Tud13PAvsr/dxdxp33/(FMvsr)*1
         set FLEMvsr=newTud13Bvsr/dxdxp33/(FMvsr)*1
         set FLIEvsr=Tud13IEvsr/dxdxp33/(FMvsr)*1
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
        define myrin ((rhor))
		#define myrout ((1E2))
        define myrout ((25.0))
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
        define numpanels 3
        #
		panelplot1replot
		#
panelplot1replot 0 #		
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2-1)
        define lmaxy (2)
        limits $xin $xout $lminy $lmaxy
        #ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        yla "\rho_0 u_g u_b [Edd]"
        #
        #
        #rhoshorvsr
        ltype 0 pl 0 (LG(r)) (LG(rhosrhosqdcdenvsr/rhoeddcode)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(ugsrhosqdcdenvsr/ueddcode)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bsqrhosqdcdenvsr*0.5/ueddcode)) 0011 $myrin $myrout $lminy $lmaxy
        #
        lweight 5
        ltype 0 ctype red vertline (LG(risco))
        ltype 0 ctype cyan vertline (LG(rfitin2))
        ltype 0 ctype cyan vertline (LG(rfitout2))
        #ltype 2 ctype cyan vertline (LG(rfitin6))
        ltype 2 ctype cyan vertline (LG(rfitout6))
        lweight 3
        #
        ###################################
        #
        ticksize -1 0 -1 0
        define lminy (-3.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-1)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "-v_{r} v_{\rm rot} v_{\rm K} v_{\rm visc}"
        #
        ltype 0 pl 0 (LG(r)) (LG(-vus1rhosqdcdenvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #ltype 2 pl 0 (LG(r)) (LG(vus3rhosqdcdenvsr)) 0011 $myrin $myrout $lminy $lmaxy
        # GODMARK: below different than above for thick disk high negative spin poloidal field models!
        #ltype 2 pl 0 (LG(r)) (LG(vus3rhosqdcdenvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(vuasrotrhosqdcdenvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
        ctype blue ltype 2 pl 0 (LG(rcut1)) (LG(vuasrotrhosqdcdenvsrkep)) 0011 $myrin $myrout $lminy $lmaxy
        ctype blue ltype 0 pl 0 (LG(rcut2)) (LG(vus1rhosqdcdenvsrffGR)) 0011 $myrin $myrout $lminy $lmaxy
        ctype blue ltype 1 pl 0 (LG(rcut2)) (LG(vus1rhosqdcdenvsrffGRalt)) 0011 $myrin $myrout $lminy $lmaxy
        #ctype yellow ltype 0 pl 0 (LG(rcut2)) (LG(vus1rhosqdcdenvsrffNEWT)) 0011 $myrin $myrout $lminy $lmaxy
        #
        lweight 5
        ltype 0 ctype red vertline (LG(risco))
        ltype 0 ctype cyan vertline (LG(rfitin2))
        ltype 0 ctype cyan vertline (LG(rfitout2))
        #ltype 2 ctype cyan vertline (LG(rfitin6))
        ltype 2 ctype cyan vertline (LG(rfitout6))
        lweight 3
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9-1)
        define lmaxy (1.1-1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-2)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        yla "|b_{r,\theta,\phi}| [Edd]"
        xla "r [r_g]"
        #
        ltype 0 pl 0 (LG(r)) (LG(bas1rhosqdcdenvsr/sqrt(ueddcode))) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(bas2rhosqdcdenvsr/sqrt(ueddcode))) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bas3rhosqdcdenvsr/sqrt(ueddcode))) 0011 $myrin $myrout $lminy $lmaxy
        #
        lweight 5
        ltype 0 ctype red vertline (LG(risco))
        ltype 0 ctype cyan vertline (LG(rfitin2))
        ltype 0 ctype cyan vertline (LG(rfitout2))
        #ltype 2 ctype cyan vertline (LG(rfitin6))
        ltype 2 ctype cyan vertline (LG(rfitout6))
        lweight 3
		#
        #
panelplot1eq   0 #
		#
		#
        define myrin ((rhor))
		define myrout ((25.0))
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
        define numpanels 3
        #
		panelplot1eqreplot
		#
panelplot1eqreplot 0 #		
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-1.9)
        define lmaxy (2)
        limits $xin $xout $lminy $lmaxy
        #ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        yla "\rho_0 u_g u_b"
        #
        #rhoshorvsr
        ltype 0 pl 0 (LG(r)) (LG(rhosrhosqeqvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(ugsrhosqeqvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bsqrhosqeqvsr*0.5)) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize -1 0 -1 0
        define lminy (-3.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-1)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "-v_{r} v_{\rm rot}"
        #
        ltype 0 pl 0 (LG(r)) (LG(abs(-vus1rhosqeqvsr))) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(abs(vusarotrhosqeqvsr))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-2)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        yla "|b_{r,\theta,\phi}|"
        xla "r [r_g]"
        #
        ltype 0 pl 0 (LG(r)) (LG(bas1rhosqeqvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(bas2rhosqeqvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bas3rhosqeqvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		#
        #
panelplot1hor   0 #
		#
		#
        define myrin ((rhor))
		define myrout ((25.0))
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
        define numpanels 3
        #
		panelplot1horreplot
		#
panelplot1horreplot 0 #		
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-1.9)
        define lmaxy (2)
        limits $xin $xout $lminy $lmaxy
        #ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        ctype default window 1 -$numpanels 1 $numpanels box 0 2 0 0
        yla "\rho_0 u_g u_b"
        #
        #rhoshorvsr
        ltype 0 pl 0 (LG(r)) (LG(rhoshorvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(ugshorvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bsqhorvsr*0.5)) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize -1 0 -1 0
        define lminy (-3.9)
        define lmaxy (0.1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-1)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 0 2 0 0
        yla "-v_r v_{\rm rot}"
        #
        ltype 0 pl 0 (LG(r)) (LG(abs(-vus1horvsr))) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(abs(vuasrothorvsr))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.1)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-2)
        #ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        ctype default window 1 -$numpanels 1 $nm box 1 2 0 0
        yla "|b_{r,\theta,\phi}|"
        xla "r [r_g]"
        #
        ltype 0 pl 0 (LG(r)) (LG(bas1horvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(bas2horvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(bas3horvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		#
        #
panelplot2   0 #
		#
        #
        define myrin ((rhor))
		define myrout ((25.0))
        #
        # can get "whichi is not a macro here" error, but stupid SM bug.  Can often ignore and is fine.
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
        define numpanels 10
        #
		notation -2 2 -2 2
        define expandlow (0.9)
        define expanddefault (1.1)
		panelplot2replot
		notation -4 4 -4 4
		#
panelplot2replot 0 #		
		###################################
        #
        expand $expanddefault
        ticksize -1 0 0 0
        define lminy (0)
        define lmaxy (100)
        limits $xin $xout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        expand $expandlow
        yla "\dot{M}/M_{\rm Edd}"
        expand $expanddefault
        #
        pl 0 (LG(r)) ((mdotfinavgvsr30/Mdoteddcode)) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.015))
        #define lmaxy (LG(8100))
        define lmaxy (LG(90))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{M}_{\rm in}/\dot{M}_{\rm H}"
        expand $expanddefault
        #
        #
        set toplot=mdinvsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        #set rcut3=r if(r>=rfitin3 && r<=rfitout3)
        set rcut3=r
        set tofit=toplot[whichi]*(rcut3/r[whichi])**1.7
        ltype 2 pl 0 (LG(rcut3)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.015)-2)
        define lmaxy (LG(2)-2)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{M}_{\rm j}/\dot{M}_{\rm H}"
        expand $expanddefault
        #
        set toplot=mdjetvsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**0.9
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.015))
        define lmaxy (LG(2))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{M}_{\rm mw}/\dot{M}_{\rm H}"
        expand $expanddefault
        #
        set toplot=mdmwindvsr/mdotfinavgvsr30[ihor]
        pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**0.4
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.015))
        define lmaxy (LG(90))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{M}_{\rm w}/\dot{M}_{\rm H}"
        expand $expanddefault
        #
        set toplot=mdwindvsr/mdotfinavgvsr30[ihor]
        ltype 0 pl 0 (LG(r)) (LG(toplot)) 0011 $myrin $myrout $lminy $lmaxy
        set tofit=toplot[whichi]*(r/r[whichi])**1.7
        ltype 2 pl 0 (LG(r)) (LG(tofit)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (-0.3-2)
        #define lmaxy (130)
        define lmaxy (2.9)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{E}/\dot{M}_{\rm H}"
        #yla "\dot{E}/\dot{M}"
        expand $expanddefault
        #
        #pl 0 (LG(r)) ((eomdot)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 (LG(r)) ((edottotvsr/mdotfinavgvsr30[ihor])) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.0011))
        define lmaxy (LG(4.9))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\eta_{\rm j,mw,w}"
        expand $expanddefault
        #
        ltype 0 pl 0 (LG(r)) (LG(etajtotvsr/100.0)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(etamwtotvsr/100.0)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(etawtotvsr/100.0)) 0011 $myrin $myrout $lminy $lmaxy
        #
        #
        ###################################
        #
        ticksize -1 0 0 0
        define lminy (-19)
        #define lmaxy (1999)
        define lmaxy (19)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\dot{J}/\dot{M}_{\rm H}"
        #yla "\dot{J}/\dot{M}"
        expand $expanddefault
        #
        #pl 0 (LG(r)) ((lomdot)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0 pl 0 (LG(r)) ((ldottotvsr/mdotfinavgvsr30[ihor])) 0011 $myrin $myrout $lminy $lmaxy
        #
        ##########################
        #
        ticksize -1 0 0 0
        define lminy (-20)
        #define lmaxy (1999)
        define lmaxy (20)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-8)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "\Upsilon_{\rm in,total}"
        expand $expanddefault
        #
        #
        ltype 0 pl 0 (LG(r)) ((upsilonvsrnorm)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((upsiloninnorm)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        expand $expanddefault
        ticksize -1 0 0 0
        #define lminy (-0.5) # for sasham9
        #define lmaxy (0.5) # for sasham9
        define lminy (0)
        define lmaxy (0.6)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-9)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        expand $expandlow
        yla "\Omega_F/\Omega_H"
		xla "r [r_g]"
        expand $expanddefault
        #
        # orig:
        #ltype 0 ctype default  pl 0 (LG(avgvsrr)) (avgvsromegaf2/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # much higher than normal version, so signed-version flips alot:
        #ctype cyan  pl 0 (LG(avgvsrr)) (avgvsrabsomegaf2/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # not bad (sits closer to average than above)
        ctype default ltype 0 pl 0 (LG(avgvsrr)) (avgvsromegaf1b/omegah*avgvsrdxdxp33)  0011 $myrin $myrout $lminy $lmaxy
        # pretty good (sits offset from average --- high and low -- but ok)
        ctype default ltype 2  pl 0 (LG(avgvsrr)) (avgvsromegaf2b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # kinda ok:
        ctype default ltype 1  pl 0 (LG(avgvsrr)) (avgvsrabsomegaalt2/omegah)   0011 $myrin $myrout $lminy $lmaxy
        # sits a bit inside average, but not as good as non-abs version
        ctype default ltype 3   pl 0 (LG(avgvsrr)) (avgvsrabsomegaf1b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # not too bad, but generally above normal version:
        ctype default ltype 4   pl 0 (LG(avgvsrr)) (avgvsrabsomegaf2b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
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
panelplot2sasha 0 #
		##########################
        #
        defaults
        defaults
        erase
        expand $expanddefault
        ticksize -1 0 0 0
        define lminy (-0.5) # for sasham9
        define lmaxy (0.5) # for sasham9
        #define lminy (0)
        #define lmaxy (0.29)
        limits $xin $xout $lminy $lmaxy
        #define nm ($numpanels-9)
        #ctype default window 8 -$numpanels 2:8 $nm
        box 1 2 0 0
        expand $expandlow
        yla "\Omega_F/\Omega_H"
		xla "r [r_g]"
        expand $expanddefault
        #
        # orig:
        ltype 0 ctype default  pl 0 (LG(avgvsrr)) (avgvsromegaf2/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # much higher than normal version, so signed-version flips alot:
        #ctype cyan  pl 0 (LG(avgvsrr)) (avgvsrabsomegaf2/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # not bad (sits closer to average than above)
        ctype default ltype 0 pl 0 (LG(avgvsrr)) (avgvsromegaf1b/omegah*avgvsrdxdxp33)  0011 $myrin $myrout $lminy $lmaxy
        # pretty good (sits offset from average --- high and low -- but ok)
        ctype default ltype 2  pl 0 (LG(avgvsrr)) (avgvsromegaf2b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # kinda ok:
        ctype default ltype 1  pl 0 (LG(avgvsrr)) (avgvsrabsomegaalt2/omegah)   0011 $myrin $myrout $lminy $lmaxy
        # sits a bit inside average, but not as good as non-abs version
        ctype default ltype 3   pl 0 (LG(avgvsrr)) (avgvsrabsomegaf1b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
        # not too bad, but generally above normal version:
        ctype default ltype 4   pl 0 (LG(avgvsrr)) (avgvsrabsomegaf2b/omegah*avgvsrdxdxp33)   0011 $myrin $myrout $lminy $lmaxy
		#
        #
panelplot3   0 #
		#
		#
        define myrin ((rhor))
		define myrout ((25.0))
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
		notation -3 3 -3 3
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
        define lminy (-0.3)
        define lmaxy (pi/2)
        limits $xin $xout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\theta^{\rm d, t}"
        #c_s/v_{\rm rot}
        #
        ltype 0 pl 0 (LG(r)) ((hoverrvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((atan(horalt1))) 0011 $myrin $myrout $lminy $lmaxy
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (-0.2)
        define lmaxy (pi/2)
        limits $xin $xout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\theta^{\rm dc, cj}"
        #
        ltype 0 pl 0 (LG(r)) ((hoverrcoronavsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((hoverrjetvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.0)
        define lmaxy (15.0)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "Q_{\theta,\rm MRI}"
        #
        ltype 0 pl 0 (LG(r)) ((qmridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((qmridiskweakvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) ((6+0*qmridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.0)
        define lmaxy (15.0)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "Q_{\phi,\rm MRI}"
        #
        ltype 0 pl 0 (LG(r)) ((q3mridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((q3mridiskweakvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) ((6+0*q3mridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 0 0
        define lminy (0.0)
        define lmaxy (35.0)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "S_{\rm d,\rm MRI}"
        #
        ltype 0 pl 0 (LG(r)) ((q2mridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) ((q2mridiskweakvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1
        pl 0 (LG(r)) ((0.5+0*q2mridiskvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 0
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(1.5E-3))
        define lmaxy (LG(9.0))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\alpha_b \alpha_{b,\rm eff}"
        #
        ltype 0 pl 0 (LG(r)) (LG(alphatot3vsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(rcut2)) (LG(alphaeffvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (1.9-4)
        define lmaxy (3.9-4)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\Phi_r"
        #
        ltype 0 pl 0 (LG(r)) (LG(fstotvsr*0.5)) 0011 $myrin $myrout $lminy $lmaxy
        #
		##########################
        #
        ticksize -1 0 -1 0
        define lminy (0-2)
        define lmaxy (2.5-3)
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        yla "\Psi_{\rm eq}"
		xla "r [r_g]"
        #
        ltype 0 pl 0 (LG(r)) (LG(abs(feqtotvsr))) 0011 $myrin $myrout $lminy $lmaxy
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
        define numpanels 8
        #
        expand 1.2
		panelplot4replot
        expand 1.5
		#
checkingondensityweight 0 #
        #print {avgh   avgrhoclean avgugclean  ubvsh}
        #       1.574  31.21       79.61       91.86
        #
        # print {r      rhosrhosqdcdenvsr bsqrhosqdcdenvsr rhosrhosqeqvsr bsqrhosqeqvsr }
        #        1.333  61.86             129.9            38.67          186.2 
        # print {r      rhosrhosqdcdenvsr bsqrhosqdcdenvsr/2 rhosrhosqeqvsr bsqrhosqeqvsr/2 }
        #        1.333  61.86             65                 38.67          93
        #
        set norm=avggdet*avgrhoclean
        # print {avgh norm}
        #
        ctype default pl 0 avgh (avgrhoclean/avgrhoclean[64]) 0101 0 pi 1E-3 25.0
        ctype red pl 0 avgh (norm/norm[64]) 0111 0 pi 1E-3 25.0
        set hortest=0.12
        set dentest=exp(-(avgh-pi/2)**2/(2*hortest**2))
        ctype blue pl 0 avgh dentest 0111 0 pi 1E-3 25.0
        set hortest=0.16
        set dentest=exp(-(avgh-pi/2)**2/(2*hortest**2))
        ctype cyan pl 0 avgh dentest 0111 0 pi 1E-3 25.0
        #
        set norm=avggdet*avgrhoclean
        set numerator=SUM(norm*avgrhoclean)
        set denominator=SUM(norm)
        set ratio1=numerator/denominator
        set fracratio1=ratio1/avgrhoclean[64]
        #
        set norm=avggdet
        set numerator=SUM(norm*avgrhoclean)
        set denominator=SUM(norm)
        set ratio2=numerator/denominator
        set fracratio2=ratio2/avgrhoclean[64]
        print {ratio1 fracratio1 ratio2 fracratio2}
        #
        #
panelplot4replot 0 #		
		###################################
        #
        # mix with dataavg stuff: avgh avgrho avgug avgbsq avguur avguup  avgbur avgbuh
        #
        #
        ticksize 0 0 -1 0
        define lminy (-0.3-2)
        define lmaxy (1.8)
        limits $myhin $myhout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\rho_0/\rho_{\rm Edd}"
        #
        set avgrhoclean=(avgbsq/avgrho<maxbsqorho ? avgrho : 0)
        set rhosrhosqrad4vshclean=(bsqrhosqrad4vsh/rhosrhosqrad4vsh<maxbsqorho ? rhosrhosqrad4vsh : 0)
        set rhosrhosqrad8vshclean=(bsqrhosqrad8vsh/rhosrhosqrad8vsh<maxbsqorho ? rhosrhosqrad8vsh : 0)
        set rhosrhosqrad30vshclean=(bsqrhosqrad30vsh/rhosrhosqrad30vsh<maxbsqorho ? rhosrhosqrad30vsh : 0)
        #
        ltype 0 pl 0 ((avgh)) (LG(avgrhoclean/rhoeddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(rhosrhosqrad4vshclean/rhoeddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(rhosrhosqrad8vshclean/rhoeddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(rhosrhosqrad30vshclean/rhoeddcode)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-0.9-4)
        define lmaxy (2.5-2)
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "u_g/u_{\rm Edd}"
        #
        set avgugclean=(avgbsq/avgrho<maxbsqorho ? avgug : 0)
        set ugsrhosqrad4vshclean=(bsqrhosqrad4vsh/rhosrhosqrad4vsh<maxbsqorho ? ugsrhosqrad4vsh : 0)
        set ugsrhosqrad8vshclean=(bsqrhosqrad8vsh/rhosrhosqrad8vsh<maxbsqorho ? ugsrhosqrad8vsh : 0)
        set ugsrhosqrad30vshclean=(bsqrhosqrad30vsh/rhosrhosqrad30vsh<maxbsqorho ? ugsrhosqrad30vsh : 0)
        #
        ltype 0 pl 0 ((avgh)) (LG(avgugclean/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(ugsrhosqrad4vshclean/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(ugsrhosqrad8vshclean/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(ugsrhosqrad30vshclean/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 -1 0
        define lminy (-3.5)
        define lmaxy (2.7)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "u_b/u_{\rm Edd}"
        #
        ltype 0 pl 0 ((avgh)) (LG(0.5*avgbsq/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG((0.5*bsqrhosqrad4vsh/ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG((0.5*bsqrhosqrad8vsh/ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG((0.5*bsqrhosqrad30vsh/ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 -1 0
        define lminy (-1.9-2)
        define lmaxy (3.1-2)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "p_{\rm tot}/u_{\rm Edd}"
        #
        set gam=(5.0/3.0)
        set pradhor=(gam-1.0)*avgugclean
        set prad4=(gam-1.0)*ugsrhosqrad4vshclean
        set prad8=(gam-1.0)*ugsrhosqrad8vshclean
        set prad30=(gam-1.0)*ugsrhosqrad30vshclean
        ltype 0 pl 0 ((avgh)) (LG((0.5*avgbsq+pradhor)/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG((0.5*bsqrhosqrad4vsh+prad4)/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG((0.5*bsqrhosqrad8vsh+prad8)/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG((0.5*bsqrhosqrad30vsh+prad30)/ueddcode)) 0011 $myhin $myhout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 -1 0
        define lminy (-2.5)
        define lmaxy (0.0)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "|v_r|"
        #
        ltype 0 pl 0 ((avgh)) (LG(abs(avguur))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(vuas1rhosqrad4vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(vuas1rhosqrad8vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(vuas1rhosqrad30vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.1)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "v_{\rm rot}"
        #
        ltype 0 pl 0 ((avgh)) (LG(abs(avguup))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(vuasrotrhosqrad4vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(vuasrotrhosqrad8vsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(vuasrotrhosqrad30vsh)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (1.8)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "|b_r|/b_{\rm Edd}"
        #
        ltype 0 pl 0 ((avgh)) (LG(abs(avgabsbur)/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(bas1rhosqrad4vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(bas1rhosqrad8vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(bas1rhosqrad30vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 -1 0
        define lminy (-2.9)
        define lmaxy (0.3)
        limits $myhin $myhout $lminy $lmaxy
        define nm ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm box 1 2 0 0
        yla "|b_\theta|/b_{\rm Edd}"
		xla "\theta"
        #
        ltype 0 pl 0 ((avgh)) (LG(abs(avgabsbuh/sqrt(ueddcode)))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 ((hinnx4)) (LG(bas2rhosqrad4vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 ((hinnx8)) (LG(bas2rhosqrad8vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
        ltype 3 pl 0 ((hinnx30)) (LG(bas2rhosqrad30vsh/sqrt(ueddcode))) 0011 $myhin $myhout $lminy $lmaxy
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
        define numpanels 9
        #
        expand 0.9
		panelplot5replot
        expand 1.5
		#
panelplot5replot 0 #		
		###################################
        #
        notation -3 3 -3 3
        #
        ticksize 0 0 -1 0
        define lminy (-0.9)
        define lmaxy (3)
        limits $mytin $mytout $lminy $lmaxy
        ctype default window 8 -$numpanels 2:8 $numpanels box 0 2 0 0
        yla "\dot{M}_{\rm out}/M_{\rm Edd}"
        #
        # already showing mdot in another plot, so can skip for clarity
        #ltype 0 pl 0 ((ts)) (LG(mdothor/Mdoteddcode)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) (LG(mdinrdiskout/Mdoteddcode)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 1 pl 0 ((ts)) (LG(mdjetrjetout/Mdoteddcode)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 0 pl 0 ((ts)) (LG(mdmwindrjetout/Mdoteddcode)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) (LG(mdwindrdiskout/Mdoteddcode)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-1)
        define lmaxy (1.0)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\eta_{\rm H}"
        #
        ltype 0 pl 0 ((ts)) ((etabhEM/100.0)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((etabhMAKE/100.0)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 3 pl 0 ((ts)) (((etabh-etabhEM-etabhMAKE)/100.0)) 0011 $mytin $mytout $lminy $lmaxy
        #
        # alt stuff below is no longer required
        #set tbreak=4000
        #set etaEMmod1=etabhEM/100 if(ts>tbreak)
        #set tsmod1=ts if(ts>tbreak)
        #set etaEMmod2=etabhEMalt/100 if(tsalt<=tbreak)
        #set tsmod2=tsalt if(tsalt<=tbreak)
        #set etaMAKEmod1=etabhMAKE/100 if(ts>tbreak)
        #set etaMAKEmod2=etabhMAKEalt/100 if(tsalt<=tbreak)
        #ltype 0 pl 0 ((tsmod1)) ((etaEMmod1)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 0 pl 0 ((tsmod2)) ((etaEMmod2)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((tsmod1)) ((etaMAKEmod1)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((tsmod2)) ((etaMAKEmod2)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-10)
        define lmaxy (10)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "j_{\rm H}"
        #
        ltype 0 pl 0 ((ts)) ((letabhEM/100)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 2 pl 0 ((ts)) ((letabhMAKE/100)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 3 pl 0 ((ts)) (((letabh-letabhEM-letabhMAKE)/100)) 0011 $mytin $mytout $lminy $lmaxy
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.19)
        define lmaxy (pi/4)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\theta^d"
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
        define lmaxy (1.0)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\alpha_{b\ [r=10r_g]}"
        #
        ltype 0 pl 0 ((ts)) ((alphatot310)) 0011 $mytin $mytout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (10)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-5)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        yla "\Upsilon_{\rm H\ outer}"
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
        #define lmaxy (LG(5.3*r[dimen(r)-1]))
        define lmaxy (1.5)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-6)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #yla "r_{\rm flux,stag}"
        #yla "r_m r_{\Psi_{\rm a}}"
        yla "r_{\Psi_{\rm a}}"
        #
        ltype 0 pl 0 ((ts)) (LG(rifmaxvst)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) (LG(rm1vst)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) (LG(reqstagvst)) 0011 $mytin $mytout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 0 0
        define lminy (-0.15)
        define lmaxy (1.1)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-7)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        #yla "\frac{\Phi_{\rm H}}{\Phi_{\rm H}}"
        #yla "\Phi/\Phi_{\rm a,s}"
        yla "\Psi_{\rm H}/\Psi_{a}"
        #
        #ltype 0 pl 0 ((ts)) ((fstotnormA0)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 0 pl 0 ((ts)) ((fstotnormA1)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((fstotnormA2)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 0 pl 0 ((ts)) ((fstotnormC)) 0011 $mytin $mytout $lminy $lmaxy
        ltype 0 pl 0 ((ts)) ((fstotnormC2)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((fstotnormBwhichfirstlimited)) 0011 $mytin $mytout $lminy $lmaxy
        #ltype 2 pl 0 ((ts)) ((fstotnormE2)) 0011 $mytin $mytout $lminy $lmaxy
        #
		##########################
        #
        ticksize 0 0 0 0
        define lminy (-1.1)
        define lmaxy (1.1)
        limits $mytin $mytout $lminy $lmaxy
        define nm ($numpanels-8)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand 0.9
        #yla "\frac{\Phi_{\rm H}}{\Psi_{\rm tH}}"
        yla "\Psi_{\rm tH}/\Phi_{\rm H}"
        expand 0.7
		#xla "t [r_g/c]"
        expand 0.9
        # SM acting stupid and not putting down consistent ticks (depends upon box 1 2 0 0 vs. box 0 2 0 0)
        # so put in tick labels manually
        relocate 0 -1.5
        putlabel 5 "0"
        relocate 10000 -1.5
        putlabel 5 "10^4"
        relocate 15000 -1.6
        putlabel 5 "t [r_g/c]"
        expand 1.1
        #
        ltype 0 pl 0 ((ts)) ((1.0/fstotnormD)) 0011 $mytin $mytout $lminy $lmaxy
        #
        notation -4 4 -4 4
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
        # whether to do sasha type plot
        define sashaplot (0)
        #define sashaplot (1) # for a=+0.9
        #define sashaplot (2) # for a=-0.9
		#
        #############
        #
        #
        ticksize 0 0 0 0
        #define lminy (-.5)
        define lminy (-0.1)
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
        ltype 5 pl 0 avgh (omegafohpara) 0011 $myhin $myhout $lminy $lmaxy
        #
        # omegaalt1 is smoothest and most similar to average behavior for time-average of omegaf2 directly
        #ctype red ltype 0 pl 0 avgh (avgomegaalt1/omegah) 0011 $myhin $myhout $lminy $lmaxy
        #ctype blue ltype 0 pl 0 avgh (avgomegaalt2/omegah) 0011 $myhin $myhout $lminy $lmaxy
        #ctype cyan ltype 0 pl 0 avgh (avgomegaalt3/omegah) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-5)
        define lmaxy (25)
        if($sashaplot>0){\
            define lminy (-5)
            define lmaxy (25)
        }
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-1)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "\dot{M}_{\rm H}/\dot{M}_{\rm Edd}"
        #
        ltype 0 pl 0 avgh ((Mdotvsh/Mdoteddcode)) 0011 $myhin $myhout $lminy $lmaxy
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-0.5)
        define lmaxy (0.5)
        if($sashaplot==1){\
            define lminy (-0.1)
            define lmaxy (1.3)
        }
        if($sashaplot==2){\
            define lminy (-0.1)
            define lmaxy (0.49)
        }
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-2)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        #yla "\dot{E}/\dot{M}"
        yla "\eta_{\rm H}"
        #
        ltype 0 pl 0 avgh ((EdotEMvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 4 pl 0 avgh ((EdotMAvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh ((EdotEMvshbz)) 0011 $myhin $myhout $lminy $lmaxy
        if($sashaplot>0){\
           ctype red ltype 1 pl 0 avgh ((EdotEMvshbz2)) 0011 $myhin $myhout $lminy $lmaxy
           ctype blue ltype 1 pl 0 avgh ((EdotEMvshbz2alt)) 0011 $myhin $myhout $lminy $lmaxy
           ctype cyan ltype 1 pl 0 avgh ((EdotEMvshbz2altalt)) 0011 $myhin $myhout $lminy $lmaxy
           ctype yellow ltype 1 pl 0 avgh ((EdotEMvshbz2altaltalt)) 0011 $myhin $myhout $lminy $lmaxy
        }
        #
        set result0=EdotEMvsh[dimen(EdotEMvsh)/2]
        set result1=EdotEMvshbz[dimen(EdotEMvshbz)/2]
        set result2=EdotEMvshbz2[dimen(EdotEMvshbz2)/2]
        set result3=EdotEMvshbz2alt[dimen(EdotEMvshbz2alt)/2]
        set result4=EdotEMvshbz2altalt[dimen(EdotEMvshbz2altalt)/2]
        set result5=EdotEMvshbz2altaltalt[dimen(EdotEMvshbz2altaltalt)/2]
        #
        print {result0 result1 result2 result3 result4 result5}
        #
		###################################
        #
        ticksize 0 0 0 0
        define lminy (-2)
        define lmaxy (2)
        if($sashaplot==1){\
            define lminy (-5)
            define lmaxy (15)
        }
        if($sashaplot==2){\
            define lminy (-6)
            define lmaxy (1)
        }
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-3)
        ctype default window 8 -$numpanels 2:8 $nm1 box 0 2 0 0
        yla "j_{\rm H}"
        #
        ltype 0 pl 0 avgh ((LdotEMvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 4 pl 0 avgh ((LdotMAvsh)) 0011 $myhin $myhout $lminy $lmaxy
        ltype 1 pl 0 avgh ((LdotEMvshbz)) 0011 $myhin $myhout $lminy $lmaxy
        if($sashaplot>0){\
           ctype red ltype 1 pl 0 avgh ((LdotEMvshbz2)) 0011 $myhin $myhout $lminy $lmaxy
           ctype blue ltype 1 pl 0 avgh ((LdotEMvshbz2alt)) 0011 $myhin $myhout $lminy $lmaxy
           ctype cyan ltype 1 pl 0 avgh ((LdotEMvshbz2altalt)) 0011 $myhin $myhout $lminy $lmaxy
           ctype yellow ltype 1 pl 0 avgh ((LdotEMvshbz2altaltalt)) 0011 $myhin $myhout $lminy $lmaxy
        }
        #
        set result0=LdotEMvsh[dimen(LdotEMvsh)/2]
        set result1=LdotEMvshbz[dimen(LdotEMvshbz)/2]
        set result2=LdotEMvshbz2[dimen(LdotEMvshbz2)/2]
        set result3=LdotEMvshbz2alt[dimen(LdotEMvshbz2alt)/2]
        set result4=LdotEMvshbz2altalt[dimen(LdotEMvshbz2altalt)/2]
        set result5=LdotEMvshbz2altalt[dimen(LdotEMvshbz2altaltalt)/2]
        #
        print {result0 result1 result2 result3 result4 result5}
        #
        ###################################
        #
        ticksize 0 0 0 0
        define lminy (0)
        define lmaxy (5)
        if($sashaplot==1){\
            define lminy (0)
            define lmaxy (14)
        }
        if($sashaplot==2){\
            define lminy (0)
            define lmaxy (8)
        }
        limits $myhin $myhout $lminy $lmaxy
        define nm1 ($numpanels-4)
        ctype default window 8 -$numpanels 2:8 $nm1 box 1 2 0 0
        yla "\Upsilon_{\rm H}"
        xla "\theta"
        #
        #
        #
        ltype 0 pl 0 avgh (upsilon) 0011 $myhin $myhout $lminy $lmaxy
        ltype 2 pl 0 avgh (upsilonbz0) 0011 $myhin $myhout $lminy $lmaxy
        ltype 5 pl 0 avgh (upsilonbz2) 0011 $myhin $myhout $lminy $lmaxy
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
		notation -2 2 -2 2
        define expandlow (1.01)
        define expandverylow (0.67)
        define expanddefault (1.5)
        #
		panelplot7replot
		#
panelplot7replot 0 #		
        #
        # for fil in `ls rbar*rad4*` ; do echo $fil ; head -3 $fil | tail -1 ; done
        #
        #define filename powervs7vsmz_FMrhosq_diskcorona_phipow_radhor_vsm.txt
        #define filename powervs1vsma_rhosrhosq_diskcorona_phipow_rad4_vsm.txt
        #define filename powervs2vsma_ugsrhosq_diskcorona_phipow_rad4_vsm.txt
        #define filename powervs8vsma_bsqrhosq_jet_phipow_rad4_vsm.txt
        #define filename powervs11vsma_FEEMrhosq_jet_phipow_rad4_vsm.txt
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        expand $expandlow
        ctype default window 8 -$numpanels 3:8 $numpanels box 0 2 0 0
        yla "|a_m|/|a_0|"
        expand $expanddefault
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
        expand $expandverylow
        relocate 0.07  -4
        putlabel 6 "\dot{M} in Disk"
        # at r=r_{\rm H}
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand $expanddefault
        #
        ltype 0 pl 0 mm powerm1radhor 1111 $mymin $mymout  $lminy $lmaxy
        ltype 2 pl 0 mm powerm1rad4 1111 $mymin $mymout  $lminy $lmaxy
        #ltype 0 pl 0 mm powerm1rad8 1111 $mymin $mymout  $lminy $lmaxy
        #        ltype 0 pl 0 mm powerm1rad30 1111 $mymin $mymout  $lminy $lmaxy
        #
        ltype 0
        expand 2.5
        ptype 4 3 points (LG(mcorm1radhor)) (LG(powerm1radhor[int(mcorm1radhor)] ))
        ptype 4 3 points (LG(mcorm1rad4)) (LG(powerm1rad4[int(mcorm1rad4)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm1radhor[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm1rad4[int(n3/6)] ))
        angle 0
        expand 1.5
        #        ltype 5 vertline (LG(n3/6))
        #
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-1)
        expand $expandlow
        ctype default window 8 -$numpanels 3:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        expand $expanddefault
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
        expand $expandverylow
        relocate 0.07  -4
        #  at r/r_g=r_+/r_g,4,8,30
        putlabel 6 "M_0 in Disk"
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand $expanddefault
        #
        ltype 0 pl 0 mm powerm2radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm2rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm2rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm2rad30 1111 $mymin $mymout $lminy $lmaxy
        #
        ltype 0
        expand 2.5
        ptype 4 3 points (LG(mcorm2radhor)) (LG(powerm2radhor[int(mcorm2radhor)] ))
        ptype 4 3 points (LG(mcorm2rad4)) (LG(powerm2rad4[int(mcorm2rad4)] ))
        ptype 4 3 points (LG(mcorm2rad8)) (LG(powerm2rad8[int(mcorm2rad8)] ))
        ptype 4 3 points (LG(mcorm2rad30)) (LG(powerm2rad30[int(mcorm2rad30)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm2radhor[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm2rad4[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm2rad8[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm2rad30[int(n3/6)] ))
        angle 0
        expand 1.5
        #        ltype 5 vertline (LG(n3/6))
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-2)
        expand $expandlow
        ctype default window 8 -$numpanels 3:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        expand $expanddefault
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
        expand $expandverylow
        relocate 0.07  -4
        putlabel 6 "E_g in Disk"
        # at r=4r_g
        relocate 0.07 -5.2
        putlabel 6 $normstringalldef
        expand $expanddefault
        #
        ltype 0 pl 0 mm powerm3radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm3rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm3rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm3rad30 1111 $mymin $mymout $lminy $lmaxy
        #
        ltype 0
        expand 2.5
        ptype 4 3 points (LG(mcorm3radhor)) (LG(powerm3radhor[int(mcorm3radhor)] ))
        ptype 4 3 points (LG(mcorm3rad4)) (LG(powerm3rad4[int(mcorm3rad4)] ))
        ptype 4 3 points (LG(mcorm3rad8)) (LG(powerm3rad8[int(mcorm3rad8)] ))
        ptype 4 3 points (LG(mcorm3rad30)) (LG(powerm3rad30[int(mcorm3rad30)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm3radhor[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm3rad4[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm3rad8[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm3rad30[int(n3/6)] ))
        angle 0
        expand 1.5
        #        ltype 5 vertline (LG(n3/6))
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-3)
        expand $expandlow
        ctype default window 8 -$numpanels 3:8 $nm1 box 0 2 0 0
        yla "|a_m|/|a_0|"
        expand $expanddefault
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
        expand $expandverylow
        relocate 0.07  -4
        putlabel 6 "E_B in Jet"
        # at r=4r_g
        relocate 0.07  -5.2
        #relocate 0.07  -1
        putlabel 6 $normstringalldef
        expand $expanddefault
        #
        ltype 0 pl 0 mm powerm4radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm4rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm4rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm4rad30 1111 $mymin $mymout $lminy $lmaxy
        #
        ltype 0
        expand 2.5
        ptype 4 3 points (LG(mcorm4radhor)) (LG(powerm4radhor[int(mcorm4radhor)] ))
        ptype 4 3 points (LG(mcorm4rad4)) (LG(powerm4rad4[int(mcorm4rad4)] ))
        ptype 4 3 points (LG(mcorm4rad8)) (LG(powerm4rad8[int(mcorm4rad8)] ))
        ptype 4 3 points (LG(mcorm4rad30)) (LG(powerm4rad30[int(mcorm4rad30)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm4radhor[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm4rad4[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm4rad8[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm4rad30[int(n3/6)] ))
        angle 0
        expand 1.5
        #        ltype 5 vertline (LG(n3/6))
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (-5.9)
        define lmaxy (-0.1)
        limits $mymin $mymout $lminy $lmaxy
        define nm1 ($numpanels-4)
        expand $expandlow
        ctype default window 8 -$numpanels 3:8 $nm1 box 1 2 0 0
        yla "|a_m|/|a_0|"
        xla "m [at r=r_{\rm H},4r_g,8r_g,30r_g]"
        expand $expanddefault
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
        expand $expandverylow
        relocate 0.07  -4
        putlabel 6 "\dot{E}^{\rm EM} in Jet"
        # at r=4r_g
        relocate 0.07  -5.2
        putlabel 6 $normstringalldef
        expand $expanddefault
        #
        ltype 0 pl 0 mm powerm5radhor 1111 $mymin $mymout $lminy $lmaxy
        ltype 2 pl 0 mm powerm5rad4 1111 $mymin $mymout $lminy $lmaxy
        ltype 1 pl 0 mm powerm5rad8 1111 $mymin $mymout $lminy $lmaxy
        ltype 3 pl 0 mm powerm5rad30 1111 $mymin $mymout $lminy $lmaxy
        #
        ltype 0
        expand 2.5
        ptype 4 3 points (LG(mcorm5radhor)) (LG(powerm5radhor[int(mcorm5radhor)] ))
        ptype 4 3 points (LG(mcorm5rad4)) (LG(powerm5rad4[int(mcorm5rad4)] ))
        ptype 4 3 points (LG(mcorm5rad8)) (LG(powerm5rad8[int(mcorm5rad8)] ))
        ptype 4 3 points (LG(mcorm5rad30)) (LG(powerm5rad30[int(mcorm5rad30)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm5radhor[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm5rad4[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm5rad8[int(n3/6)] ))
        angle 90 ptype 2 3 points (LG(n3/6)) (LG(powerm5rad30[int(n3/6)] ))
        angle 0
        expand 1.5
        #        ltype 5 vertline (LG(n3/6))
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
                yla "u^r [contravariant]"
                xla "r [r_g]"
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
                 define x2label "\dot{J}/\dot{M}"
                 set jshow=gl
                 set jsimshow=FLPAvsr
                 set divisor=1
                }
                if(logr==0){ ticksize 0 0 0 0 } else{ ticksize -1 0 0 0  }
                #
                ctype default window 2 2 2 2 box 1 2 0 0
                define x1label "r [r_g]"
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
                limits $xinner $xouter -1 3
                if(logr==0){ ticksize 0 0 -1 0 } else{ ticksize -1 0 -1 0  }
                notation -2 2 -2 2
                #
                ctype default window 2 2 1 1 box 1 2 0 0
                xla "r [r_g]"
                yla "\rho_0 u_g u_b"
                set lbcog=LG(bcog*(FMvsrg))
                ctype green ltype 0 plo 0 xsim lbcog
                set lrhovsrg=LG(rhovsrg*(FMvsrg))
                ctype default ltype 0 plo 0 xsim lrhovsrg
                set luvsrg=LG(uvsrg*(FMvsrg))
                ctype magenta ltype 0 plo 0 xsim luvsrg
                #
                set lmygbsqvsr=LG(mygbsqvsr)
                set lged=LG(ged*(FMvsrg))
                #
                ctype green ltype 2 plo 0 xgam lged
                #
                set lgrho=LG(grho*(FMvsrg))
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
                 define x2label "\dot{E}/\dot{M}"
                 set eshow=gE
                 set esimshow=FEPAvsr
                 set divisor=1
                }
                #
                if(logr==0){ ticksize 0 0 0 0 } else{ ticksize -1 0 0 0  }
                #
                ctype default window 2 2 2 1 box 1 2 0 0
                #
                define x1label "r [r_g]"
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
		###################################
panelplot8   0 #
		#
		#
        define myphiin (0)
		define myphiout (2*pi)
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
        define numpanels 4
        #
		panelplot8replot
		#
panelplot8replot 0 #		
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-0)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        ctype default window 8 -$numpanels 3:8 $numpanels box 0 2 0 0
        expand 1.2
        yla "\rho^{\rm avg}_0"
        expand 1.5
        #
        relocate 0.17   2.2
        expand 0.9
        set ts1=sprintf('t=%5dr_g/c',tphi1)
        define ts1def (ts1)
        putlabel 6 $ts1def
        expand 1.5
        #
        relocate 3.14   1.83
        expand 0.9
        putlabel 5 "r=r_{\rm H}"
        expand 1.5
        ltype 0 pl 0 phi1 rhovsphi1radhor 0111 $myphiin $myphiout  $lminy $lmaxy
        relocate 3.14   1.1
        expand 0.9
        putlabel 5 "r=4r_g"
        expand 1.5
        ltype 2 pl 0 phi1 rhovsphi1rad4 0111 $myphiin $myphiout  $lminy $lmaxy
        relocate 3.14   0.25
        expand 0.9
        putlabel 5 "r=8r_g"
        expand 1.5
        ltype 1 pl 0 phi1 rhovsphi1rad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #relocate 3.14   -0.3
        #expand 0.9
        #putlabel 5 "r=30r_g"
        #expand 1.5
        #ltype 3 pl 0 phi1 rhovsphi1rad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        #
        ticksize 0 0 -1 0
        define lminy (-0)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 3:8 $nm  box 0 2 0 0
        expand 1.2
        yla "\rho^{\rm eq}_0"
        #xla "\phi"
        expand 1.5
        #
        relocate 0.17   2.2
        expand 0.9
        set ts1=sprintf('t=%5dr_g/c',tphi1)
        define ts1def (ts1)
        putlabel 6 $ts1def
        expand 1.5
        #
        #
        ltype 0 pl 0 phi1 rhovsphi1eqradhor 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 2 pl 0 phi1 rhovsphi1eqrad4 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 1 pl 0 phi1 rhovsphi1eqrad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #ltype 3 pl 0 phi1 rhovsphi1eqrad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        ticksize 0 0 -1 0
        define lminy (-0)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        define nm ($numpanels-2)
        ctype default window 8 -$numpanels 3:8 $nm box 0 2 0 0
        expand 1.2
        yla "\rho^{\rm avg}_0"
        expand 1.5
        #
        relocate 0.17   2.2
        expand 0.9
        set ts2=sprintf('t=%5dr_g/c',tphi2)
        define ts2def (ts2)
        putlabel 6 $ts2def
        expand 1.5
        #
        ltype 0 pl 0 phi2 rhovsphi2radhor 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 2 pl 0 phi2 rhovsphi2rad4 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 1 pl 0 phi2 rhovsphi2rad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #ltype 3 pl 0 phi2 rhovsphi2rad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        #
        ticksize 0 0 -1 0
        define lminy (-1)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        define nm ($numpanels-3)
        ctype default window 8 -$numpanels 3:8 $nm  box 1 2 0 0
        expand 1.2
        yla "\rho^{\rm eq}_0"
        xla "\phi"
        expand 1.5
        #
        relocate 0.17   2.2
        expand 0.9
        set ts2=sprintf('t=%5dr_g/c',tphi2)
        define ts2def (ts2)
        putlabel 6 $ts2def
        expand 1.5
        #
        ltype 0 pl 0 phi2 rhovsphi2eqradhor 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 2 pl 0 phi2 rhovsphi2eqrad4 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 1 pl 0 phi2 rhovsphi2eqrad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #ltype 3 pl 0 phi2 rhovsphi2eqrad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        #
        #
		###################################
panelplot8b   0 #
		#
		#
        define myphiin (0)
		define myphiout (2*pi)
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
        define numpanels 2
        #
		panelplot8breplot
		#
panelplot8breplot 0 #		
        #
		###################################
        #
        ticksize 0 0 -1 0
        define lminy (-0)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        ctype default window 8 -$numpanels 3:8 $numpanels box 0 2 0 0
        expand 1.2
        yla "\rho^{\rm avg}_0"
        expand 1.5
        #
        relocate 3.14   1.73
        expand 0.9
        putlabel 5 "r=r_{\rm H}"
        expand 1.5
        ltype 0 pl 0 phi2 rhovsphi2radhor 0111 $myphiin $myphiout  $lminy $lmaxy
        relocate 3.14   0.9
        expand 0.9
        putlabel 5 "r=4r_g"
        expand 1.5
        ltype 2 pl 0 phi2 rhovsphi2rad4 0111 $myphiin $myphiout  $lminy $lmaxy
        relocate 3.14   0.25
        expand 0.9
        putlabel 5 "r=8r_g"
        expand 1.5
        ltype 1 pl 0 phi2 rhovsphi2rad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #relocate 3.14   -0.3
        #expand 0.9
        #putlabel 5 "r=30r_g"
        #expand 1.5
        #ltype 3 pl 0 phi2 rhovsphi2rad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        #
        ticksize 0 0 -1 0
        define lminy (-0)
        define lmaxy (2.6)
        limits $myphiin $myphiout $lminy $lmaxy
        define nm ($numpanels-1)
        ctype default window 8 -$numpanels 3:8 $nm  box 1 2 0 0
        expand 1.2
        yla "\rho^{\rm eq}_0"
        xla "\phi"
        expand 1.5
        #
        #
        #
        ltype 0 pl 0 phi2 rhovsphi2eqradhor 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 2 pl 0 phi2 rhovsphi2eqrad4 0111 $myphiin $myphiout  $lminy $lmaxy
        ltype 1 pl 0 phi2 rhovsphi2eqrad8 0111 $myphiin $myphiout  $lminy $lmaxy
        #ltype 3 pl 0 phi2 rhovsphi2eqrad30 0111 $myphiin $myphiout  $lminy $lmaxy
        #
        #
        #
###############
extra1 0 # from fluxvsr plot, removed
		###################################
        #
        ticksize -1 0 -1 0
        define lminy (LG(0.011))
        define lmaxy (LG(5.0))
        limits $xin $xout $lminy $lmaxy
        define nm ($numpanels-8)
        ctype default window 8 -$numpanels 2:8 $nm box 0 2 0 0
        expand $expandlow
        yla "j_{j,mw,w}"
        expand $expanddefault
        #
        ltype 0 pl 0 (LG(r)) (LG(letajEMvsr+letajMAKEvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 2 pl 0 (LG(r)) (LG(letamwEMvsr+letamwMAKEvsr)) 0011 $myrin $myrout $lminy $lmaxy
        ltype 1 pl 0 (LG(r)) (LG(letawEMvsr+letawMAKEvsr)) 0011 $myrin $myrout $lminy $lmaxy
        #
thickdisk3lmode # 0
        #
        cd /data2/jmckinne/thickdisk3/fromorange/thickdisk3/
        !sed 's/nan/0/g' datavst7.txt > datavst7n.txt
        !sed 's/inf/0/g' datavst7n.txt > datavst7nn.txt
        #  !cat datavst7nn.txt | column -t | less -S
        da datavst7nn.txt
        lines 1 1000000
        #read {tici1 1 ts1 2 phibh1 3 phij1 6 lmode1 26}
        read {tici1 1 ts1 2 phibh1 3 phij1 6 lmode1 27}
        #
        cd /data2/jmckinne/thickdisk3/fromorange/thickdiskhr3/
        !sed 's/nan/0/g' datavst7.txt > datavst7n.txt
        !sed 's/inf/0/g' datavst7n.txt > datavst7nn.txt
        da datavst7nn.txt
        #  !cat datavst7nn.txt | column -t | less -S
        lines 4 1000000
        read {tici2 1 ts2 2 phibh2 3 phij2 6 lmode2 26}
        set myuse=(tici2!=25360 && tici2!=25361)
        set ts2new=ts2 if(myuse)
        set lmode2new=lmode2 if(myuse)
        set phibh2new=phibh2 if(myuse)
        set phij2new=phij2 if(myuse)
        #
        set psiophi1=(1.0/lmode1)
        set psiophi1=(psiophi1>1.0 ? 1.0 : psiophi1)
        set psiophi1=(psiophi1<-1.0 ? -1.0 : psiophi1)
        #
        set psiophi2=(1.0/lmode2new)
        set psiophi2=(psiophi2>1.0 ? 1.0 : psiophi2)
        set psiophi2=(psiophi2<-1.0 ? -1.0 : psiophi2)
        #
        #        
        #        
        #        
		fdraft
        ctype default window 1 1 1 1
		notation -4 4 -4 4
		erase
        #
        device postencap psiophitoroidal.eps
        #
        define x1label "t[r_g/c]"
        define x2label "\Psi_{\rm tH}/\Phi_{\rm H}"
        ctype default ltype 0 pl 0 ts1 psiophi1
        #ctype red ltype 0 pl 0 ts2new psiophi2 0010
        #ctype default ltype 0 pl 0 ts2new psiophi2 
        #
        device X11
        #
        set doscp=1
        #
        if(doscp==1){\
         !scp psiophitoroidal.eps jon@physics-179.umd.edu:/data/jon/harm_harmrad/
        }
        #
        defaults
        #
        ctype default ltype 0 pl 0 ts1 phibh1
        ctype red ltype 0 pl 0 ts2new phibh2new 0010
        #
        ctype default ltype 0 pl 0 ts1 phij1
        ctype red ltype 0 pl 0 ts2new phij2new 0010
        #
        #
        #
boundcheck 0
        #jrdpcf3dudipole dump0000
        #
        #jrdpcf3duentropy dump0000
        #        jrdpcf3duentropy dump0001
        #
        # negative is unbound
        #
        set myuse=(rho>1E-4 ? 1 : 0)
        set cons1=(myuse==1 ? -(1+ud0) : 0)
        # cons1: min:-0.174734205 max:0.00496853888
        #
        set cons2=(myuse==1 ? -ud0*(u+p)/rho : 0)
        # cons2: min:-0.2810166478 max:0
        #
        set cons3=(myuse==1 ? -ud0*(bsq)/rho : 0)
        # cons3: min:-0.003286495339 max:0
        #
        set constotal=cons1+cons2+cons3
        # constotal: min:-0.2786330283 max:0
        #
        set cons3rat=(myuse==1 ? (cons3/constotal) : 0)
        #
        # at most 1% effect over all points within the torus
        #
        stresscalc 1
        set mu1 = -(Tud10+rho*uu1)/(rho*uu1)
        set mu3 = -Tud30/(rho*uu3)
        #
        set entropy=p/rho**$gam
        #
othertd9 0
        # # thickdisk9 feqtotvsr plot
        fdraft
        define x2label "\Psi_{\rm H} + \Psi_{\rm eq}"
        #device postencap thickdisk9.feqtotvsr.eps
        ctype default ltype 0 pl 0  r (fsuphalfvsr[ihor]-feqtotvsr) 0001 rhor 30 1E1 1E3
        #ctype red ltype 0 pl 0  r feqtotvsr 1100
        #device X11
        #
othertd9b 0
        # # thickdisk9 feqtotvsr plot
        fdraft
        define x2label "B_z"
        #device postencap thickdisk9.bzvsr.eps
        #ctype default ltype 0 pl 0  r (Bas2rhosqdcdenvsr) 1101 rhor 30 0.001 10
        ctype default ltype 0 pl 0  r (Bas2rhosqeqvsr) 1101 rhor 30 0.001 10
        #
        #ctype red ltype 0 pl 0  r feqtotvsr 1100
        #device X11
        #
mdotvst 0 #
        #
        da datavst1.txt
        lines 1 1000000
        read {tici 1 ts 2 mdtotihor 3}
        #
        smooth mdtotihor smdtotihor 400
        #
        #
        ctype default pl 0 ts mdtotihor
        ctype red pl 0 ts smdtotihor 0010
        #
