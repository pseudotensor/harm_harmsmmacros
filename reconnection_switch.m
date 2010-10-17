loadrmac 0      #
		gogrmhd
		jre kaz.m
		jre grbmodel.m
		jre reconnection_switch.m
		jre axisstuff.m
		#
doallrplots 0   #
		plottype1
		plottype2
		plottype3
		plottype4
		plottype5
		plottype6
		plottype7
		plottype8
                #
                # new fcover plots
		plotnewtype1
		plotnewtype2
                #
		#
		#
readtype1       1       #
		#
		if($1==0){ da evfilenew_vs_br0_Ljet.txt }
		if($1==1){ da fixedevfile.txt }
		#
		lines 1 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk ljet fakemu br0 thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
readtype2       0 #
		#
		da evfilenew_vs_Ljet_mu_br0single.txt
		#
		lines 1 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk ljet fakemu br0 thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
readtype3       0 #
		#
		da evfilenew_vs_Ljet_nu_single.txt
		#
		lines 1 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll ljet fakemu br0 nu thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
readtype4       0 #
		#
		da evfilenew_vs_Ljet_rmono_single.txt
		#
		lines 1 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm ljet fakemu br0 nu rmono thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
		#
readtype5       0 #
		#
		da evfilenew_vs_Ljet_thfp_single.txt
		#
		lines 1 10000000
		#
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn ljet fakemu br0 nu rmono thfp thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
readtype6       0 # # first have to get rid of "'s in file.
		#
		da evfilenew_vs_Ljet_fakemu_single.txt
		#
		lines 1 10000000
		#
		# same as readtype5:
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn ljet fakemu br0 nu rmono thfp thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs}
		#
		#
		truncatelarge
		#
		#
		#
readtype7       0 # # first have to get rid of "'s in file.
		#
		da evfilenew_vs_Ljet_fakemu_single_m87.txt
		#
		lines 1 10000000
		#
		# same as readtype6 except 1 more thing
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn ljet fakemu br0 nu rmono thfp thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs power}
		#
		#
		truncatelarge
		#
		#
readtype8       0 # # first have to get rid of "'s in file.
		#
		da evfilenew_vs_Ljet_fakemu_single_grs1915.txt
		#
		lines 1 10000000
		#
		# same as readtype7
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn ljet fakemu br0 nu rmono thfp thetajet gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb deltaspc deltasps deltaspb conditionpc conditionps conditionpb eco eobs esynobs eobsickev tauspc tausps taul taupetp taube tdiffacrossspc tdiffacrosssps tdiffalong ttransit dtobs power}
		#
		#
		truncatelarge
		#
		#
		#
readnewtype 1   # # first have to get rid of "'s in file.
		#
		da $1
		#
		lines 1 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn roo ljet fakemu br0 nu rmono thfp thetajet fcover gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb lundquistt deltaspc deltasps deltaspb deltaspt conditionpc conditionps conditionpb conditionpt eco eobs esynobs eobsickev tauspc tausps tauspt taul taupetp taubet taubef taubeR tdiffacrossspc tdiffacrosssps tdiffacrossspt tdiffalong ttransit dtobs power netot}
		#
                #
readverynewtype 1   # # first have to get rid of "'s in file.
		#
		da $1
		#
		lines 1 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn roo ljet fakemu br0 nu rmono thfp thetajet fcover gammalorentz rhob bsq rjet lp taurad prad ppairs pbaryon pe pg t taualongjet tann tpl deltapetp vdprime rlarmor lundquistc lundquists lundquistb lundquistt deltaspc deltasps deltaspb deltaspt \
                     conditionpc conditionps conditionpb conditionpt eco eobs esynobs eobsickev tauspc tausps tauspt taul taupetp taubet taubef taubeR tdiffacrossspc tdiffacrosssps tdiffacrossspt tdiffalong ttransit dtobs \
                     power netot \
                     netotcurrent cthermg ctherms v1g v1s v2g v2s v3g v3s v5e v5p v6 v7 v8a v8b v9 v10 v11e v11p v12e v12p v13g v13s v14e v14p v15e v15p v16e v16p v17e v17p v19e v19p}
		#
                # for zeta=1E4 case:
                # violations: v6 at high field, small radius
                # v3s,v3g: low field -- all radii
                # v2s,v2g: low enough field or large enough radii
                # v1s,v1g: ""
                # ctherms,cthermg: ""
                # vdprime: low field at large radius
		#
                # 
                #
readtypelong1 1   # # first have to get rid of "'s in file.
		#
		da $1
		#
		lines 1 10000000
		#
                # 8 + 1 + 9 + 10 + 4 + 3 + 9 + 2 + 4 + 6 + 6 + 4 + 6 + 5 + 5 + 5 + 5 + 4 + 13 + 9 + 4 + 2 + 3 + 36 + 4 + 4 + 4 + 4 + 1 + 1 + 1 + 6 + 1 + 1 + 11
                # 
                #
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rii rjj rkk rll rmm rnn roo rpp \
                     computetime \
                     ljet fakemu br0 nu rmono thfp thetajet lmode mmode \
                     gammalorentz rhob bsq Bphi Br bgauss omegaf rjet lp powerjet \
                     rhobingoing rhobcenter rhobrad bgaussrad \
                     neingoing necenter nerad \
                     tauradsca tauradabs damptaurad damptaurad2 Habs Hsca sigmaesosigmat sigmaBosigmat sigmaknosigmat \
                     sigmaff sigmasynch \
                     Qtot Qrad Urad nrad \
                     Prad Ppairs Pbaryon Pe Pnu Pg \
                     Urad Upairs Ubaryon Ue Unu Ug \
                     T npairs Trad npairsrad \
                     taualongjet tann tpl deltapetp vdprime rlarmor \
                     lundquistc lundquistnu lundquists lundquistb lundquistt \
                     deltaspc deltaspnu deltasps deltaspb deltaspt \
                     conditionpc conditionpnu conditionps conditionpb conditionpt \
                     vrecc vrecnu vrecs vrecb vrect \
                     eco eobs esynobs eobsickev \
                     tauspc tausps tauspt taul taupetp taubet taubef taubeR tdiffacrossspc tdiffacrosssps tdiffacrossspt tdiffalong ttransit \
                     dttransitobs dtradobs dtminobs Tdiffsca1obs Tdiffsca2obs Tdiffsca3obs Tdiffabs1obs Tdiffabs2obs Tdiffabs3obs \
                     powerfoot netot netotforomegape gammae \
                     Lrobs1 Lrobsf \
                     cthermg ctherms cthermnu \
		     v1g v1s v2g v2s v3g v3s v5e v5p v6 v7 v8a v8b v8c v8d v9a v9b v10 v11 v12e v12p v13e v13p v14g v14s v15e v15p v16e v16p v17e v17p v18e v18p v19a v19b v20e v20p \
                     etacenternorm etacenterrad etaingoing etacenternormtrue \
                     npairs0 npairs0true npairs0truetrue npairs0qed \
                     Upairs0 Upairs0true Upairs0truetrue Upairs0qed \
                     Ppairs0 Ppairs0true Ppairs0truetrue Ppairs0qed \
                     Qnurat \
                     Aum \
                     Qum0 \
                     epmaxobs epmaxerror epmaxminobs epmaxminerror epmaxmaxobs epmaxmaxerror \
                     Yebeta \
                     degennuc \
                     taunusca Hnusca taunuabs Hnuabs damptaunu damptaunu2 Unu2 nnutrue nnu Pnu Qnu \
                    }
                    #
                    #
		#
 		setgrbconsts
		#
		set Bgaussr=Br*sqrt(4*pi)
		set Bgaussphi=Bphi*sqrt(4*pi)
		set Pbjet=(bsq/2)
		set ratco=(bsq/(rhob*c**2))
		#
		#
		#
		set taunse=rhob**(0.2)*exp(179.7*1E9/T-39)
                # non-degen regime, high temp
                set taunse2=(T/(1.35*1E10))**(-5)
		#
		set rnselab=c*taunse*gammalorentz
		set rnse2lab=c*taunse2*gammalorentz
		#
		set T11=(T/1E11)
		set rho10=(rhobingoing/1E10)
		set Xnuc=296*rho10**(-3/4)*T11**(9/8)*exp(-0.8209/T11)
		set Xnuc=(Xnuc>1 ? 1 : Xnuc)
		set Xnuc=(Xnuc<0 ? 0 : Xnuc)
		set rhobfreeingoing=Xnuc*rhobingoing
		#
		set Thetaethermal=(kb*T)/(me*c**2)
		#
		set pem=bsq/2
		set myconditionpt=sqrt(2*rhob*c**2/(pem*tauradsca))
		#
		set etaacc=0.1
		set um=bsq*0.5
		set umfrac=(etaacc*um)
		set Ye=0.5
		set nb=rhob/mb
		set ne=Ye*nb
		set Tacce=umfrac/(3.0*kb*ne)
		set thetae = (kb*Tacce)/(me*c**2)
		set Thetae = (3/2)*thetae
		set ve = c*sqrt(Thetae*(2 + Thetae))/(1 + Thetae)
		set venonrel = c*sqrt(3*kb*Tacce/(me*c**2))
		set gammae = 1/sqrt(1 - (ve/c)**2)
		set gammaultra = sqrt(2)*Thetae
		#
		set omegac=3*gammae**2*qe*bgauss/(2*me*c)
		set omegapeak=0.29*omegac
		set Epeak=hbar*omegapeak
		set Epeakobskev=gammalorentz*Epeak/ergPmev*1E3
		#
		#
		set sigmat=6.65E-25
		set omegapeprime=sqrt(4*pi*netotforomegape*qe**2/me)
		set tp=2*pi/omegapeprime
		set ta=1/((necenter+npairsrad)*sigmat*c)
		set prefactor=tp/ta
		set factor=exp(-prefactor)
                #
                #
                set omegape=sqrt(4*pi*(necenter+npairsrad)*qe**2/me)
                set deltapete=c/omegape
                #
                # proton totel mass-energy density
                set MEproton=mp*ne*c**2 + Ye*Ubaryon
                set MEpairs=me*(ne+npairsrad)*c**2 + Upairs + Ue
		#
		# print {ljet conditionpt tauradsca T npairsrad necenter netotforomegape prefactor factor}
		#
                # print {ljet conditionpt rnselab rnse2lab Xnuc}
		#
                # for zeta=1E4 case:
                # violations: v6 at high field, small radius
                # v3s,v3g: low field -- all radii
                # v2s,v2g: low enough field or large enough radii
                # v1s,v1g: ""
                # ctherms,cthermg: ""
                # vdprime: low field at large radius
		#
testissue 0     #
		ctype default ltype 0 pl 0 ljet MEproton 1100
		ctype red ltype 0 pl 0 ljet MEpairs 1110
                #
                #
readtypelong2 1 #
		readtypelong1 $1
		read {muconst 202 u4r 203 u4h 204 u4p 205 u4phi 206 B3r 207 B3h 208 B3p 209}
		#
		#
readtypelong3 1 #
		readtypelong2 $1
		read {bcot 210 bcor 211 bcoh 212 bcop 213 bcophi 214}
		#
		set ratkink=abs(bcophi/bcop)
		#
readtypelong4 1 #
		readtypelong3 $1
		read {Rgg2pairs 215 Rge2pairs 216 Ree2pairs 217 taupairssca 218 taupairsabs 219 damptaupairs 220 damptaupairs2 221 Qpairs 222}
		#
		#
readtypelong5 1 #
		readtypelong3 $1
		read {Qgg2pairs 215 Qge2pairs 216 Qee2pairs 217 taupairssca 218 taupairsabs 219 damptaupairs 220 damptaupairs2 221 Qpairs 222 Rgg2pairs 223 Rge2pairs 224 Ree2pairs 225 taunumpairsabs 226 damptaunumpairs 227 damptaunumpairs2 228 Rpairs 229}
		#
		#
readnewplotfile 0 # 1D
		#
		# jre reconnection_switch.m
		#
		#readtypelong1 grb_40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1000._0
		#
		#readtypelong1 grb_final.dat
		#
		# fixed $p_e$
		#readtypelong1 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		# added component field and velocity information
		#readtypelong2 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_fuller
		#
		# also added comoving fields
		# readtypelong3 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_withbco
		#
		# full new pairs
		#readtypelong4 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_fullpairs
		#
		# full new pairs fixed
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_fullfixedall
		#
	        #readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_newTinterp
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_newscatter
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_fixedscattersall
		#
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_mmode0.1
		#
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_dissm.1
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_dissm.1true
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_dissm.1truenew
		#
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_newdisscorrected
		#
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_finaldiss
		#
		#
		readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_evenmorefinal
		#
doallnewplots   0
		#
		# read file:
		#
		readnewplotfile
		#
		# first plot
		donewplot1 1
		donewplot2 1
		donewplot3 1
		#
		#
		#
readnormal 0    #		
		#
		readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_mmode0.1
		#
		#
		set bsqnodiss=bsq
		set bgaussnodiss=bgauss
		set Bgaussphinodiss=Bgaussphi
		set gammalorentznodiss=gammalorentz
		set Tnodiss=T
		set tauradscanodiss=tauradsca
		set taualongjetnodiss=taualongjet
		set deltasptnodiss=deltaspt
		set npairsradnodiss=npairsrad
		#
		#
		#readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_finaldiss
		readtypelong5 grb_40._1._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_3.2e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1.e4_1._0.1_1.e4_0.1_evenmorefinal
		#
		#
		#
dissmods 0      #		
		#
		set vrocfast=0.018
		#
		#
		set bsq0=5.3E10
		set r0=5E13
		#
		#
		set bsqdiss1=bsq0*(ljet/r0)**(-2)*exp(-4*vrocfast/lp/gammalorentz*(ljet-r0))
		#set bsqdiss1=bsq0*(ljet/r0)**(-2)*exp(-4*vrocfast/lp/700*(ljet-r0))
		#set r1=10**16.031
		#set bsqdiss2=1000 *(ljet/r1)**(-2.3)
		#set r1=10**15.2552
		#set bsqdiss2=10**4.06 *(ljet/r1)**(-4)
		set r1=10**16.23
		set bsqdiss2=10**0.55 *(ljet/r1)**(-4)
		#set bsqdiss=(ljet<r1 ? bsqdiss1 : bsqdiss2)
		#set bsqdiss=(ljet<r0 ? bsq : bsqdiss)
		set bsqdiss=(ljet<r0 ? bsq : bsqdiss1)
		set bgaussdiss=sqrt(bsqdiss*4*pi)
		#
		#set bgaussnodiss=(ljet<r0 ? bgauss : bgauss[25]*(ljet/r0)**(-1))
		#set Bgaussphinodiss=(ljet<r0 ? Bgaussphi : Bgaussphi[25]*(ljet/r0)**(-1))
		#
		set fakemu=(1+npairsrad/necenter)**2/(8*tauradsca*conditionpt**2)
		set fakebsq=2*fakemu*rhob*c**2
		set fakebgauss=sqrt(fakebsq*4*pi)
		#
		set Bgaussphidiss=-bgaussdiss*gammalorentz
		set Bgaussphidiss=(ljet<r0 ? Bgaussphi : Bgaussphidiss)
		#
		#
		set vrecfast=vrocfast*c
		set QEMfast=-4*bgaussdiss**2*vrecfast/(8*pi*lp)
		set vrecslow=vrect
		set QEMslow=-4*bgaussdiss**2*vrect/(8*pi*lp)
		set QEM=(ljet<r0 ? QEMslow : QEMfast)
		#
		set sigmafake=bsqdiss/(rhob*c**2)
		set munotconst = gammalorentz*(1+sigmafake)
		set munotconst = (ljet<r0 ? muconst : munotconst)
		#
		#
		#
		#
donewplot1 2    # jetfull.eps 4-panel
		#
		#
		define doprint $1
		#
		if($2==1){\
		       readnormal
		    }
		#
		echo "before dissmods"
		dissmods
		echo "after dissmods"
		#
		fdraft
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#now setup	   
		if($doprint) {\
		       #define fname ('jet' + sprintf('%04g',hor)+ 'mag' + sprintf('%04g',$magpar) + '.eps')
		       define fname ('jetfull.eps')
		       device postencap $fname
		}
		#
		#
		#define rinner (LG(ljet[0]))
		#define router (LG(ljet[dimen(ljet)-1]))
		define rinner 5
		define router 18
		define lrmono (LG(rmono[0]))
		#
		#
		limits $rinner $router -1.9 0.5
		ticksize -1 0 -1 0
		ctype default window 2 -2 1 2
		ltype 0
		box 0 2 0 0
		#myxaxis 3
		#myyaxis 4
		#xla "r [cm]"
		yla "\theta_j"
		ctype default ltype 0 pl 0 ljet thetajet 1110
		ctype default ltype 0 vertline $lrmono
		#
		echo "before gammas"
		limits $rinner $router -0.5 4.0
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 2
		ltype 0
		box 0 2 0 0
		#myxaxis 3
		#define x1label "r [cm]"
		define x2label "\gamma_\phi\ \ \gamma_\theta\ \ \gamma\ \ \mu"
		#xla $x1label
		yla $x2label
		ctype default ltype 0 pl 0 ljet gammalorentz 1110
		ctype default ltype 0 pl 0 ljet gammalorentznodiss 1110
		#
		set gammau4phi = sqrt(1+u4phi**2/c**2)
		set gammau4h = sqrt(1+u4h**2/c**2)
		set gammau4r = sqrt(1+u4r**2/c**2)
		ctype default ltype 2 pl 0 ljet gammau4phi 1110
		ctype default ltype 1 pl 0 ljet gammau4h 1110
		#ctype default ltype 3 pl 0 ljet gammau4r 1110
		# u4r u4h u4p u4phi
		define PLOTLWEIGHT (3)
                define NORMLWEIGHT (3)
		lweight 3
		#
		relocate 16.6515 3.6
		angle 0
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		relocate 16.6515 3.05
		angle 5
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		ctype default ltype 0 pl 0 ljet muconst 1110
		ctype default ltype 0 pl 0 ljet munotconst 1110
		define PLOTLWEIGHT (5)
                define NORMLWEIGHT (3)
		lweight $NORMLWEIGHT
		#
		echo "before fields"
		ctype default window 2 -2 1 1
		notation -2 2 -2 2
		ticksize -1 0 -1 0
		limits $rinner $router -8 16
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		xla "r [cm]"
		yla "B_r\ \ \ \ |b| \ \ -B_\phi"
		ctype default ltype 0 pl 0 ljet (abs(Bgaussr)) 1110
		ctype default ltype 2 pl 0 ljet (abs(bgaussnodiss)) 1110
	        #ctype default ltype 2 pl 0 ljet (abs(bgaussdiss)) 1110
		#ctype red ltype 2 pl 0 ljet (abs(bgauss)) 1110
		ctype default ltype 2 pl 0 ljet (abs(bgauss)) 1110  
		ctype default ltype 1 pl 0 ljet (abs(Bgaussphinodiss)) 1110
		#ctype default ltype 1 pl 0 ljet (abs(Bgaussphidiss)) 1110
		ctype default ltype 1 pl 0 ljet (abs(Bgaussphi)) 1110
		#
		relocate 16.95   6.3
		angle -35
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		relocate 16.95   3.4
		angle -35
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		set fakebgausstoplot=fakebgauss if(ljet>=3.67e+13)
		set ljettoplot=ljet if(ljet>=3.67e+13)
		#
		#ctype default ltype 3 pl 0 ljet bgaussdiss 1110
		#ctype red ltype 0 pl 0 ljettoplot fakebgausstoplot 1110
		#ctype blue ltype 0 pl 0 ljet (sqrt(bsqdiss1*4*pi)) 1110
		#ctype yellow ltype 0 pl 0 ljet (sqrt(bsqdiss2*4*pi)) 1110
		#
		#
		set Bc=4.41E13
		define PLOTLWEIGHT (3)
                define NORMLWEIGHT (3)
		lweight 3
		ctype default ltype 0 pl 0 ljet (Bc+ljet*0) 1110
		define PLOTLWEIGHT (5)
                define NORMLWEIGHT (3)
		lweight $NORMLWEIGHT
		#
		echo "before rho"
		limits $rinner $router -20 6
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 1
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		define x1label "r [cm]"
		#define x2label "\rho_0 \ \rho_{\rm f}"
		define x2label "\rho_0"
		xla $x1label
		yla $x2label
		ctype default ltype 0 pl 0 ljet rhobingoing 1110
		#ctype default ltype 1 pl 0 ljet rhobfreeingoing 1110
		#ctype default ltype 0 vertline $lrmono
		#
		#
		if($doprint) {\
		 device X11
		}
		#
		#
testjetapprox 0 #
		#
		set rfp=ljet[0]
		set Brfp=Bgaussr[0]
		#
		set thetajetapprox=(rmono/rfp)**(-nu/2)*(2*sin(thfp/2))
		#
		defaults
		#
		ltype 0 pl 0 ljet thetajet 1101 (ljet[0]) (ljet[dimen(ljet)-1]) 0.01 pi
		ltype 1 pl 0 ljet thetajetapprox 1111 (ljet[0]) (ljet[dimen(ljet)-1]) 0.01 pi
		#
		#
		set Brapprox=Brfp*(rmono/rfp)**(nu-2)*(ljet/rmono)**(-2)
		ltype 0 pl 0 ljet Bgaussr  1100
		ltype 1 pl 0 ljet Brapprox 1110
		#
		#
		set Bphiapprox=Brfp*(-2*rfp*omegaf/c)*(rmono/rfp)**(nu-1)*(ljet/rmono)**(-1)*tan(thetajet/2)
		ltype 0 pl 0 ljet Bgaussphi  1100
		ltype 1 pl 0 ljet Bphiapprox 1110
		#
		# bsq \approx B_\phi^2/\gamma^2
		# bgausssq = bsq/(4\pi) \approx Bgauss_\phi^2/\gamma^2
		#
		set bgausssqapprox=(Bphiapprox/gammalorentz)**2
		set Pbapprox=bgausssqapprox/(8*pi)
		ltype 0 pl 0 ljet Pbjet  1100
		ltype 1 pl 0 ljet Pbapprox 1110
		#
		#
firstvalue0     0
		#
		# what lbsq(1) should be:
		#
		set lbsq1 = l
		#
		#
gettruediss 5   #  gettruediss <linear=1/log=2/otherlog=3,4> <vrec> <gamma, 0 = use normal, else constant value of gamma> <lp, as with gamma> <numiters>
		#
		# e.g.
		# gettruediss 2 0.1 0 0 1000
		# gettruediss 2 0.1 700 1E10 1000
		# gettruediss 2 0.1 700 (lp[39]) 1000
		# gettruediss 2 0.1 (gammalorentz[39]) (lp[39]) 1000
		#
		# load ideal model first so have bsqnodiss
		#
		readnormal
		#
		# integrate to get true dissipation radius
		#
		# first get ideal dlbsq/dlr
		# log-log is better since function is more linear in that.
		#
		set bsq=bsqnodiss
		set lbsq=lg(bsq)
		set lljet=lg(ljet)
		#
		der ljet bsq ljetd dbsqdljet
		der lljet lbsq lljetd dlbsqdljet
		#
		#
		set ticker=0,dimen(bsq)-1,1
		#
		#
		# initial guess is ideal solution
		set bsqdissfull=bsq
		set lbsqdissfull=LG(bsqdissfull)
		#
		#
		#
		#set vrocfast=0.018
		set vrocfast=$2
		#set vrocfast=0
		#
		if($3!=0){\
		 set gammalorentztouse=$3 + bsq*0
		}
		if($3==0){\
		 set gammalorentztouse=gammalorentz
		}
		#
		if($4!=0){\
		 set lptouse=$4 + bsq*0
		}
		if($4==0){\
		 set lptouse=lp
		}
		#
		#
		set wi=dimen(bsq)-1
		set rdissest=gammalorentztouse[wi]*lptouse[wi]/(4*vrocfast)
		print {rdissest}
		#
		#
		#
		set numiterdiss=$5
		#
		define x1label "r[cm]"
		define x2label "b^2"
		ctype default pl 0 ljet bsq 1100
		#
		do iterdiss=1,numiterdiss,1 {\
		       # linear
		       if($1==1){\
		              iterbsqdiss1
		       }
		       #
		       if($1==2){\
		       # log
		        iterbsqdiss2
		       }
		       #
		       if($1==3){\
		       # log
		        iterbsqdiss3
		       }
		       #
		       if($1==4){\
		       # log
		        iterbsqdiss4
		       }
		       #
		       ctype red pl 0 ljet bsqdissfull 1110
		       set goddiff=(bsq-bsqdissfull)/bsq 
		       #
		       #
		}
		#
		ctype blue pl 0 ljet bsqdissfull 1110
		#
		ctype yellow vertline (LG(rdissest))
		#
		#
iterbsqdiss1 0  #		linear
		#
		# only modify j>0 so that first cell has no dissipation
		do iii=1,dimen(bsq)-1,1 {\

		   # dbsqdjet is already centered
		   set middbsqdljet=dbsqdljet[$iii]
		   set midrec=0.5*(4*vrocfast*bsqdissfull[$iii]/(gammalorentztouse[$iii]*lptouse[$iii]) + 4*vrocfast*bsqdissfull[$iii-1]/(gammalorentztouse[$iii-1]*lptouse[$iii-1]) )
		   set dljet=(ljet[$iii]-ljet[$iii-1])
		   set bsqdissfull[$iii] = bsqdissfull[$iii-1] + (middbsqdljet - midrec )*dljet
		   
xsy		   set last=bsqdissfull[$iii-1]
		   set this=bsqdissfull[$iii]

		   #echo $iii
		   #print {middbsqdr midrec dljet this last}
		}
		#
iterbsqdiss2 0  #		 log
		#
		#
		set lbsqdisstemp=lbsqdissfull
		#
		# only modify j>0 so that first cell has no dissipation
		do iii=1,dimen(bsq)-1,1 {\

 		   # dlbsqdljet is already centered
		   set middlbsqdljet=dlbsqdljet[$iii]
		   set midrec4log=0.5*(4*vrocfast*ljet[$iii]/(gammalorentztouse[$iii]*lptouse[$iii]) + 4*vrocfast*ljet[$iii-1]/(gammalorentztouse[$iii-1]*lptouse[$iii-1]) )
		   set dlljet=(lljet[$iii]-lljet[$iii-1])
		   #set bratright=bsq[$iii]/(1E-30+bsqdissfull[$iii])
		   #set bratleft=bsq[$iii-1]/(1E-30+bsqdissfull[$iii-1])
		   #set bratright=(bratright<1 ? 1 : bratright)
		   #set bratleft=(bratleft<1 ? 1 : bratleft)
		   #set midbrat = 0.5*( bratleft + bratright )
		   #set midbrat = 10**(0.5*( (lbsq[$iii]-lbsqdissfull[$iii]) + (lbsq[$iii-1]-lbsqdissfull[$iii-1]) ) )
		   set midbrat = (bsq[$iii-1]+bsq[$iii])/(bsqdissfull[$iii-1]+bsqdissfull[$iii])
		   #
		   set dlbsqdiss=(middlbsqdljet*midbrat - midrec4log)*dlljet
		   #
		   set lbsqdisstemp[$iii] = lbsqdisstemp[$iii-1] + dlbsqdiss
		   #
		   set last=lbsqdisstemp[$iii-1]
		   set this=lbsqdisstemp[$iii]

		   #echo $iii
		   #print {middlbsqdljet midbrat dlljet this last dlbsqdiss}
		}
		#
		# control step size
		#
		set stepsize=1
		#
		set lbsqdissfull = lbsq + stepsize*(lbsqdisstemp - lbsq)
		#
		#
		set bsqdissfull=1E-30 + 10**lbsqdissfull
		#
iterbsqdiss3 0  #		 log
		#
		#
		set lbsqdisstemp=lbsqdissfull
		#
		# only modify j>0 so that first cell has no dissipation
		do iii=1,dimen(bsq)-1,1 {\

 		   # dlbsqdljet is already centered
		   set middlbsqdljet=dlbsqdljet[$iii]
		   set midrec4log=4*vrocfast*ljet[$iii-1]/(gammalorentztouse[$iii-1]*lptouse[$iii-1])
		   set dlljet=(lljet[$iii]-lljet[$iii-1])
		   set midbrat = (bsq[$iii-1])/(bsqdissfull[$iii-1])
		   #
		   set dlbsqdiss=(middlbsqdljet*midbrat - midrec4log)*dlljet
		   #
		   set lbsqdisstemp[$iii] = lbsqdisstemp[$iii-1] + dlbsqdiss
		   #
		   set last=lbsqdisstemp[$iii-1]
		   set this=lbsqdisstemp[$iii]

		   #echo $iii
		   #print {middlbsqdljet midbrat dlljet this last dlbsqdiss}
		}
		#
		# control step size
		#
		set stepsize=1
		#
		set lbsqdissfull = lbsq + stepsize*(lbsqdisstemp - lbsq)
		#
		#
		set bsqdissfull=1E-30 + 10**lbsqdissfull
		#
iterbsqdiss4 0  #		 log
		#
		#
		set lbsqdisstemp=lbsqdissfull
		#
		# only modify j>0 so that first cell has no dissipation
		do iii=1,dimen(bsq)-1,1 {\

 		   # dlbsqdljet is already centered
		   set middlbsqdljet=dlbsqdljet[$iii]
		   set midrec4log=4*vrocfast*ljet[$iii]/(gammalorentztouse[$iii]*lptouse[$iii])
		   set dlljet=(lljet[$iii]-lljet[$iii-1])
		   set midbrat = (bsq[$iii])/(bsqdissfull[$iii])
		   #
		   set dlbsqdiss=(middlbsqdljet*midbrat - midrec4log)*dlljet
		   #
		   set lbsqdisstemp[$iii] = lbsqdisstemp[$iii-1] + dlbsqdiss
		   #
		   set last=lbsqdisstemp[$iii-1]
		   set this=lbsqdisstemp[$iii]

		   #echo $iii
		   #print {middlbsqdljet midbrat dlljet this last dlbsqdiss}
		}
		#
		# control step size
		#
		set stepsize=1
		#
		set lbsqdissfull = lbsq + stepsize*(lbsqdisstemp - lbsq)
		#
		#
		set bsqdissfull=1E-30 + 10**lbsqdissfull
		#
		#
		#
donewplot2 2    # jetfullrec1.eps 4-panel
		#
		#
		define doprint $1
		#
		#
		if($2==1){\
		       readnormal
		    }
		#
		dissmods
		#
		fdraft
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#now setup	   
		if($doprint) {\
		       define fname ('jetfullrec1.eps')
		       device postencap $fname
		}
		#
		#
		#define rinner (LG(ljet[0]))
		#define router (LG(ljet[dimen(ljet)-1]))
		define rinner 5
		define router 18
		define lrmono (LG(rmono[0]))
		#
		# print {ljet conditionpt tauradsca T npairsrad necenter}
		#
		limits $rinner $router 6.5 12
		ticksize -1 0 -1 0
		ctype default window 2 -2 1 2
		ltype 0
		box 0 2 0 0
		#myxaxis 3
		#myyaxis 4
		#xla "r [cm]"
		yla "T [K]"
		ctype default ltype 0 pl 0 ljet T 1110
		#ctype default ltype 0 pl 0 ljet Tnodiss 1110
		define PLOTLWEIGHT (3)
                define NORMLWEIGHT (3)
		lweight 3
		ctype default ltype 0 vertline $lrmono
		define PLOTLWEIGHT (5)
                define NORMLWEIGHT (3)
		lweight $NORMLWEIGHT
		#
		#relocate 16.3 9.3
		#angle -70
		#expand 0.6
		#putlabel 5 "Ideal"
		#angle 0
		## fdraft expand
		#expand 1.5
		#
		#
		limits $rinner $router 0.5 40
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 2
		ltype 0
		box 0 0 0 0
		myyaxis 4
		#myxaxis 3
		#define x1label "r [cm]"
		#define x2label "n_e\  n_{\rm pairs}\  n_{e'}\  n_{\\nu}"
		define x2label "n_e\  n_{\rm pairs}\  n_{\\nu}"
		#xla $x1label
		yla $x2label
		ctype default ltype 0 pl 0 ljet necenter 1110
		ctype default ltype 2 pl 0 ljet npairsrad 1110
		ctype default ltype 2 pl 0 ljet npairsradnodiss 1110
		#ctype default ltype 1 pl 0 ljet netotforomegape 1110
		ctype default ltype 3 pl 0 ljet nnutrue 1110
		#
		#
		relocate 16.3 9.3
		angle -70
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		#
		#
		# -4.0 to avoid showing neutrino Q_\nu that just barely exists at Q_\nu = 10**(-4.472)
		limits $rinner $router -4.3 35
		notation -2 2 -2 2
		ticksize -1 0 -1 0
		ctype default window 2 -2 1 1
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		xla "r [cm]"
		#yla "Q_{\rm tot}\  Q_{\gamma}\  Q_{\nu}\ Q_{\rm EM}\  Q_{\rm SP}"
		yla "Q_{\gamma}\  Q_{\nu} \  \ Q_{\rm EM} \ Q_{\rm SP}"
		#ctype default ltype 0 pl 0 ljet Qtot 1110
		ctype default ltype 0 pl 0 ljet Qrad 1110
		ctype default ltype 3 pl 0 ljet Qnu 1110
		ctype default ltype 1 pl 0 ljet Qum0 1110
		ctype default ltype 2 pl 0 ljet QEM 1110
		#
		limits $rinner $router -4 31
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 1
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		define x1label "r [cm]"
		#define x2label "p_g  p_b  p_e  p_\gamma  p_{\rm pairs}  p_{\\nu}"
		define x2label "p_b  p_e  p_{\\nu} p_{\rm pairs} p_\gamma"
		xla $x1label
		yla $x2label
		#ctype default ltype 0 pl 0 ljet Pg 1110
		ctype default ltype 0 pl 0 ljet Prad 1110
		ctype default ltype 2 pl 0 ljet Ppairs 1110
		ctype default ltype 3 pl 0 ljet Pnu 1110
		ctype default ltype 1 pl 0 ljet Pbaryon 1110
		ctype default ltype 4 pl 0 ljet Pe 1110
		#
		#
		if($doprint) {\
		 device X11
		}
		#
		#
donewplot3 2    # jetfullrec2.eps 4-panel
		#
		#
		#
		define doprint $1
		#
		#
		if($2==1){\
		       readnormal
		    }
		#
		dissmods
		#
		fdraft
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#now setup	   
		if($doprint) {\
		       define fname ('jetfullrec2.eps')
		       device postencap $fname
		}
		#
		#
		#define rinner (LG(ljet[0]))
		#define router (LG(ljet[dimen(ljet)-1]))
		define rinner 5
		define router 18
		define lrmono (LG(rmono[0]))
		#
		#
		limits $rinner $router -7.9 8
		ticksize -1 0 -1 0
		ctype default window 2 -2 1 2
		ltype 0
		box 0 0 0 0
		#myxaxis 3
		myyaxis 3
		#xla "r [cm]"
		yla "\delta_{\rm Pet}\ \ \ \ \delta_{\rm SP'}"
		ctype default ltype 0 pl 0 ljet deltapetp 1110
		ctype default ltype 2 pl 0 ljet deltaspt  1110
		ctype default ltype 2 pl 0 ljet deltasptnodiss  1110
		#ctype default ltype 3 pl 0 ljet deltapete 1110
		define PLOTLWEIGHT (3)
                define NORMLWEIGHT (3)
		lweight 3
		ctype default ltype 0 vertline $lrmono
		define PLOTLWEIGHT (5)
                define NORMLWEIGHT (3)
		lweight $NORMLWEIGHT
		#
		relocate 16.95   1
		angle 0
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		#
		limits $rinner $router -7 28
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 2
		ltype 0
		box 0 0 0 0
		myyaxis 4
		#myxaxis 3
		#define x1label "r [cm]"
		#define x2label "V\ v_{r,\rm SP'}\  S"
		define x2label "v_{r,\rm SP'}\  S"
		#xla $x1label
		yla $x2label
		getminV
		# print {ljet necenter npairsrad netotforomegape nnutrue} 
		#ctype default ltype 0 pl 0 ljet (minv) 1110
		ctype default ltype 0 pl 0 ljet (vrect) 1110
		ctype default ltype 2 pl 0 ljet lundquistt 1110
		#
		#limits $rinner $router -8 25
		limits $rinner $router -6 6
		notation -2 2 -2 2
		ticksize -1 0 -1 0
		ctype default window 2 -2 1 1
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		xla "r [cm]"
		#yla "dt_{\rm obs, tra}\  dt_{\rm obs,m}\  dt_{\rm obs,\gamma}"
		yla "dt_{\rm obs, \{tra\ m\ ad\ sd\ \gamma\}}"
		ctype default ltype 0 pl 0 ljet dttransitobs 1110
		set fakem=0.1
		set TF=2*pi/((fakem*omegaf))
		set vrecm=0.02*c
		set dtminobsm=(c/vrecm)*TF
		ctype default ltype 2 pl 0 ljet dtminobsm 1110
		ctype default ltype 1 pl 0 ljet Tdiffabs1obs 1110
		ctype default ltype 3 pl 0 ljet Tdiffsca1obs 1110
		ctype default ltype 4 pl 0 ljet dtradobs 1110
		#
		#limits $rinner $router -28 20
		limits $rinner $router -18 20
		ticksize -1 0 -1 0
		ctype default window 2 -2 2 1
		ltype 0
		box 0 0 0 0
		myxaxis 3
		myyaxis 4
		define x1label "r [cm]"
		define x2label " \tau_{\\nu,\rm sca}\  \tau_{\gamma,\rm sca}\  \tau_{||}"
		xla $x1label
		yla $x2label
		ctype default ltype 0 pl 0 ljet taunusca 1110
		ctype default ltype 2 pl 0 ljet tauradsca 1110
		ctype default ltype 2 pl 0 ljet tauradscanodiss 1110
		ctype default ltype 1 pl 0 ljet taualongjet 1110
		ctype default ltype 1 pl 0 ljet taualongjetnodiss 1110
		define PLOTLWEIGHT (3)
                define NORMLWEIGHT (3)
		ctype default ltype 0 pl 0 ljet (ljet*0+1) 1110
		define PLOTLWEIGHT (5)
                define NORMLWEIGHT (3)
		#
		relocate 16.3   -4.5
		angle -25
		expand 0.6
		putlabel 5 "Ideal"
		angle 0
		# fdraft expand
		expand 1.5
		#
		#
		if($doprint) {\
		 device X11
		}
		#
		# v8a barely below 1 at first cell
		# v8c quite below until few cells
		#
		# deltaspt deltapetp (i.e. conditionpt)
		# lundquisttt vrect MIN(v1g v1s v2g v2s v3g v3s v5e v5p v6 v7 v8a v8b v8c v8d v9a v9b v10 v11 v12e v12p v13e v13p v14g v14s v15e v15p v16e v16p v17e v17p v18e v18p v19a v19b v20e v20p)
		# dttransitobs dtradobs dtminobs Tdiff(sca,abs)(1,2,3)obs
		# tauradsca taunusca taualongjet
		#
getminV 0       #
		#
		define num (dimen(v1g))
		set minv=1,$num,1
		set minv=minv*0+1E30
		#
		do ii=0,$num-1,1{\
		set minv[$ii]=(minv[$ii]>v1g[$ii] ? v1g[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v1s[$ii] ? v1s[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v2g[$ii] ? v2g[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v3g[$ii] ? v3g[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v5e[$ii] ? v5e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v5p[$ii] ? v5p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v6[$ii] ? v6[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v7[$ii] ? v7[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v8a[$ii] ? v8a[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v8b[$ii] ? v8b[$ii] : minv[$ii])
		# realized using sigmaes and should use sigmaps that is about 1000X smaller, so not an issue
		#set minv[$ii]=(minv[$ii]>v8c[$ii] ? v8c[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v8d[$ii] ? v8d[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v9a[$ii] ? v9a[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v9b[$ii] ? v9b[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v10[$ii] ? v10[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v11[$ii] ? v11[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v12e[$ii] ? v12e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v12p[$ii] ? v12p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v13e[$ii] ? v13e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v13p[$ii] ? v13p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v14g[$ii] ? v14g[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v14s[$ii] ? v14s[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v15e[$ii] ? v15e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v16e[$ii] ? v16e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v16p[$ii] ? v16p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v17e[$ii] ? v17e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v17p[$ii] ? v17p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v18e[$ii] ? v18e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v18p[$ii] ? v18p[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v19a[$ii] ? v19a[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v19b[$ii] ? v19b[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v20e[$ii] ? v20e[$ii] : minv[$ii])
		set minv[$ii]=(minv[$ii]>v20p[$ii] ? v20p[$ii] : minv[$ii])
		}
		#
		#v1s v2g v2s v3g v3s v5e v5p v6 v7 v8a v8b v8c v8d v9a v9b v10 v11 v12e v12p v13e v13p v14g v14s v15e v15p v16e v16p v17e v17p v18e v18p v19a v19b v20e v20p)
                #
                #
truncatelarge 0 #
		#
		set largest=1E300
		#
		set rii=(abs(rii)>largest ? largest : rii)
		set rjj=(abs(rjj)>largest ? largest : rjj)
		set rkk=(abs(rkk)>largest ? largest : rkk)
		set ljet=(abs(ljet)>largest ? largest : ljet)
		set fakemu=(abs(fakemu)>largest ? largest : fakemu)
		set br0=(abs(br0)>largest ? largest : br0)
		set thetajet=(abs(thetajet)>largest ? largest : thetajet)
		set gammalorentz=(abs(gammalorentz)>largest ? largest : gammalorentz)
		set rhob=(abs(rhob)>largest ? largest : rhob)
		set bsq=(abs(bsq)>largest ? largest : bsq)
		set rjet=(abs(rjet)>largest ? largest : rjet)
		set lp=(abs(lp)>largest ? largest : lp)
		set taurad=(abs(taurad)>largest ? largest : taurad)
		set prad=(abs(prad)>largest ? largest : prad)
		set ppairs=(abs(ppairs)>largest ? largest : ppairs)
		set pbaryon=(abs(pbaryon)>largest ? largest : pbaryon)
		set pe=(abs(pe)>largest ? largest : pe)
		set pg=(abs(pg)>largest ? largest : pg)
		set t=(abs(t)>largest ? largest : t)
		set taualongjet=(abs(taualongjet)>largest ? largest : taualongjet)
		set tann=(abs(tann)>largest ? largest : tann)
		set tpl=(abs(tpl)>largest ? largest : tpl)
		set deltapetp=(abs(deltapetp)>largest ? largest : deltapetp)
		set vdprime=(abs(vdprime)>largest ? largest : vdprime)
		set rlarmor=(abs(rlarmor)>largest ? largest : rlarmor)
		set lundquistc=(abs(lundquistc)>largest ? largest : lundquistc)
		set lundquists=(abs(lundquists)>largest ? largest : lundquists)
		set lundquistb=(abs(lundquistb)>largest ? largest : lundquistb)
		set deltaspc=(abs(deltaspc)>largest ? largest : deltaspc)
		set deltasps=(abs(deltasps)>largest ? largest : deltasps)
		set deltaspb=(abs(deltaspb)>largest ? largest : deltaspb)
		set conditionpc=(abs(conditionpc)>largest ? largest : conditionpc)
		set conditionps=(abs(conditionps)>largest ? largest : conditionps)
		set conditionpb=(abs(conditionpb)>largest ? largest : conditionpb)
		set eco=(abs(eco)>largest ? largest : eco)
		set eobs=(abs(eobs)>largest ? largest : eobs)
		set esynobs=(abs(esynobs)>largest ? largest : esynobs)
		set eobsickev=(abs(eobsickev)>largest ? largest : eobsickev)
		set tauspc=(abs(tauspc)>largest ? largest : tauspc)
		set tausps=(abs(tausps)>largest ? largest : tausps)
		set taul=(abs(taul)>largest ? largest : taul)
		set taupetp=(abs(taupetp)>largest ? largest : taupetp)
		set taubet=(abs(taubet)>largest ? largest : taubet)
		set tdiffacrossspc=(abs(tdiffacrossspc)>largest ? largest : tdiffacrossspc)
		set tdiffacrosssps=(abs(tdiffacrosssps)>largest ? largest : tdiffacrosssps)
		set tdiffalong=(abs(tdiffalong)>largest ? largest : tdiffalong)
		set ttransit=(abs(ttransit)>largest ? largest : ttransit)
		set dtobs=(abs(dtobs)>largest ? largest : dtobs)
		#
		#
		#
reconnectionplc1 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype1 0
		setupplc 40 1 40 ljet fakemu br0
		fixfile
		readtype1 1
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
reconnectionplc2 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype2
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#
reconnectionplc3 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype3
		# assume other dimensiones are 1 in size including missing br0 dimension
		setupplc 40 1 40 ljet fakemu nu
		#
		define x1label "r[cm]"
		# below is \\nu because \nu would be replaced by carriage return and "u"
		define x2label "\\nu"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#
reconnectionplc4 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype4
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu rmono
		#
		define x1label "r[cm]"
		define x2label "r_{\rm mono}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#
reconnectionplc5 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype5
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu thfp
		#
		define x1label "r[cm]"
		define x2label "\theta_{\rm fp}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
reconnectionplc6 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype6
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
reconnectionplc7 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype7
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
reconnectionplc8 0
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readtype8
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#
		#
		#
fixfile 0       # reorder k as fastest to i as fastest
		#
		!rm -rf fixedevfile.txt
		#
		define print_noheader (1)
		#
		do myi=0,$nx-1,1{\
		       do myj=0,$ny-1,1{\
		       do myk=0,$nz-1,1{\
		       #original index:
		       #define index ($myk + $nz*$myj + $nz*$ny*$myi)
		       #fixed index:
		       define index ($myi + $nx*$myj + $nx*$ny*$myk)
		       #
		       set riivar=rii[$index]
		       set rjjvar=rjj[$index]
		       set rkkvar=rkk[$index]
		       set ljetvar=ljet[$index]
		       set fakemuvar=fakemu[$index]
		       set br0var=br0[$index]
		       set thetajetvar=thetajet[$index]
		       set gammalorentzvar=gammalorentz[$index]
		       set rhobvar=rhob[$index]
		       set bsqvar=bsq[$index]
		       set rjetvar=rjet[$index]
		       set lpvar=lp[$index]
		       set tauradvar=taurad[$index]
		       set pradvar=prad[$index]
		       set ppairsvar=ppairs[$index]
		       set pbaryonvar=pbaryon[$index]
		       set pevar=pe[$index]
		       set pgvar=pg[$index]
		       set tvar=t[$index]
		       set taualongjetvar=taualongjet[$index]
		       set tannvar=tann[$index]
		       set tplvar=tpl[$index]
		       set deltapetpvar=deltapetp[$index]
		       set vdprimevar=vdprime[$index]
		       set rlarmorvar=rlarmor[$index]
		       set lundquistcvar=lundquistc[$index]
		       set lundquistsvar=lundquists[$index]
		       set lundquistbvar=lundquistb[$index]
		       set deltaspcvar=deltaspc[$index]
		       set deltaspsvar=deltasps[$index]
		       set deltaspbvar=deltaspb[$index]
		       set conditionpcvar=conditionpc[$index]
		       set conditionpsvar=conditionps[$index]
		       set conditionpbvar=conditionpb[$index]
		       set ecovar=eco[$index]
		       set eobsvar=eobs[$index]
		       set esynobsvar=esynobs[$index]
		       set eobsickevvar=eobsickev[$index]
		       set tauspcvar=tauspc[$index]
		       set tauspsvar=tausps[$index]
		       set taulvar=taul[$index]
		       set taupetpvar=taupetp[$index]
		       set taubevar=taube[$index]
		       set tdiffacrossspcvar=tdiffacrossspc[$index]
		       set tdiffacrossspsvar=tdiffacrosssps[$index]
		       set tdiffalongvar=tdiffalong[$index]
		       set ttransitvar=ttransit[$index]
		       set dtobsvar=dtobs[$index]
		       #
		       print + fixedevfile.txt '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {riivar rjjvar rkkvar ljetvar fakemuvar br0var thetajetvar gammalorentzvar rhobvar bsqvar rjetvar lpvar tauradvar pradvar ppairsvar pbaryonvar pevar pgvar tvar taualongjetvar tannvar tplvar deltapetpvar vdprimevar rlarmorvar lundquistcvar lundquistsvar lundquistbvar deltaspcvar deltaspsvar deltaspbvar conditionpcvar conditionpsvar conditionpbvar ecovar eobsvar esynobsvar eobsickevvar tauspcvar tauspsvar taulvar taupetpvar taubevar tdiffacrossspcvar tdiffacrossspsvar tdiffalongvar ttransitvar dtobsvar}
		    #
		 }
		}
		}
		#
		#
		##############################
		# old non-reordered indices
		#
		##############################
		# TYPE1/TYPE2 plots
		#
		#
plottype1      0 #
		#
		reconnectionplc1
		#
		plottype1setup
		plottype1setup2
		device postencap brvsratfakemu100.eps
		plottype1doit
		device X11
		#
plottype2      0 #
		#
		reconnectionplc2
		#
		plottype1setup
		plottype1setup2
		device postencap fakemuatbrvsr1e15.eps
		plottype1doit
		device X11
		#
plottype3      0 #
		#
		reconnectionplc3
		#
		plottype1setup
		plottype1setup2
		device postencap nuatmu1e4brvsr1e15.eps
		plottype1doit
		device X11
		#
plottype4      0 #
		#
		reconnectionplc4
		#
		plottype1setup
		plottype1setup2
		device postencap rmonoatnu.75mu1e4brvsr1e15.eps
		plottype1doit
		device X11
		#
plottype5      0 #
		#
		reconnectionplc5
		#
		plottype1setup
		plottype1setup2
		device postencap thfpatrmono3e10atnu.75mu1e4brvsr1e15.eps
		plottype1doit
		device X11
		#
plottype6      0 #
		#
		#
		reconnectionplc6
		#
		plottype1setup
		plottype1setup2
		device postencap br0atfakemu1e4.eps
		plottype1doit
		device X11
		#
plottype7      0 #
		#
		#
		reconnectionplc7
		#
		plottype1setup
		plottype1setup2
		device postencap fakemu_m87.eps
		plottype1doit
		device X11
		#
plottype8      0 #
		#
		#
		reconnectionplc8
		#
		plottype1setup
		plottype1setup2
		device postencap fakemu_grs1915.eps
		plottype1doit
		device X11
		#
		#
		##############################
		# already-reordered indices
plotnewtype1      0 
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grb_40._1._40._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1._1
		#readnewtype $myfile
                define myfile "grb_40._1._40._1._1._1._1._1._1.e12_5.e14_100._1.e6_100._1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2.e-9_1._2.e-9"
		readverynewtype $myfile
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
                #
plotnewtype2      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grb_40._1._40._1._1._1._1._1._1.e12_5.e14_100._1.e6_100._1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1._1
		#readnewtype $myfile
		#
                define myfile "grb_40._1._40._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2.e-9_1._2.e-9"
                readverynewtype $myfile
                #
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype3      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		define myfile grb_40._40._1._1._1._1._1._1._1.e12_5.e14_50._1.e10_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1._1
		readnewtype $myfile
		#
		define myfile "grb_40._40._1._1._1._1._1._1._1.e12_5.e14_100._1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2.e-9_1._2.e-9"
		readverynewtype $myfile
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype4      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		define myfile "grb_40._1._1._1._1._1._40._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1.e-10_1._1"
		readnewtype $myfile
		#
		define myfile "grb_40._1._1._1._1._1._40._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1.e-10_1._2.e-9"
		readverynewtype $myfile
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu fcover
		#
		define x1label "r[cm]"
		define x2label "f"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype5      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grb_40._1._1._40._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.1_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_1._1._1
		#readnewtype $myfile
		#
		define myfile "grb_40._1._1._40._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.1_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2.e-9_1._2.e-9"
		readverynewtype $myfile
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu nu 
		#
		define x1label "r[cm]"
		define x2label "\\nu"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype6      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grb_40._1._1._1._40._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_1._1.e12_3.e10_1.571_1.571_1.571_1._1._1
		#readnewtype $myfile
		#
		define myfile "grb_40._1._1._1._40._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_1._1.e12_3.e10_1.571_1.571_1.571_2.e-9_1._2.e-9"
		readverynewtype $myfile		
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu rmono
		#
		define x1label "r[cm]"
		define x2label "r_{\rm mono}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype7      0 #
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grb_40._1._1._1._1._40._1._1._1.e12_5.e14_1.e4_1.e10_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_0.1571_1.571_1.571_1._1._1
		#readnewtype $myfile
		#
		define myfile "grb_40._1._1._1._1._40._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_0.1571_1.571_1.571_2.e-9_1._2.e-9"
		readverynewtype $myfile		
		#
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu thfp
		#
		define x1label "r[cm]"
		define x2label "\theta_{\rm fp}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
                #
plotnewtype8      0 # M87
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile m87_40._40._1._1._1._1._1._1._1.e12_1.e8_50._1.e6_50._1000._1.e6_0.75_1._0.75_100._1.e12_100._1.571_1.571_1.571_1._1._1
		#readnewtype $myfile
		#
		define myfile ""
		readverynewtype $myfile		
		#
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
plotnewtype9      0 # GRS1915+105
		#
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		#define myfile grs_40._40._1._1._1._1._1._1._1.e12_1.e8_50._1.e6_50._1.e9_1.e11_0.75_1._0.75_100._1.e12_100._1.571_1.571_1.571_1._1._1
		readnewtype $myfile
		#
		define myfile ""
		readverynewtype $myfile		
		#
		truncatelarge
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setup
		plottype2setup2
		device postencap $myfile.eps
		plottype2doit
		device X11
		#
                #
		#
		#
                #
		###########################
                # TYPE1
                ###########################
                #
plottype1setup 0     #
		#
		#
		set mycondition=conditionpc+conditionps+conditionpb
		plc0 0 (LG(mycondition))
		set conditionnewfun=newfun
		#
		define missing_data (1E30)
		#
		#set toplot=(mycondition>1.0 ? 1E30 : prad/pg-0.2)
		set toplot=(prad/pg-0.2)
		plc0 0 toplot
		set pradopgnewfun=newfun
		#
		set toplot=(mycondition>1.0 ? 1E30 :  ppairs/pg-0.2)
		plc0 0 toplot
		set ppairsopgnewfun=newfun
		#
		set toplot=(mycondition>1.0 ? 1E30 :  pbaryon/pg-0.2)
		plc0 0 toplot
		set pbaryonopgnewfun=newfun
		#
		smooth2d taualongjet taualongjetnew 40 40 3
		set toplot=(mycondition>1.0 ? 1E30 : taualongjetnew-1)
		#set toplot=(taualongjetnew-1)
		plc0 0 toplot
		set taualongjetnewfun=newfun
		#
		plc0 0 (gammalorentz*thetajet-1)
		set gammatheta1newfun=newfun
		#
		#
plottype1setup2 0
		#
		erase
		#
plottype1doit 0     #
		fdraft
		lweight 5
		#rdraft
		ltype 0
		ptype 1 1
		ctype default
                box
		labelaxes 0
                #
                limits $txl $txh $tyl $tyh
                image ($rnx,$rny) $txl $txh $tyl $tyh
		#
                set image[ix,iy] = conditionnewfun
		set lev={0}
                levels lev
		#ctype blue contour
		ltype 0 ctype default contour
                #
                set image[ix,iy] = pradopgnewfun
                set lev={0}
		levels lev
                #ctype red contour
		ltype 1 ctype default contour
                #
                set image[ix,iy] = ppairsopgnewfun
                set lev={0}
                levels lev
		#ctype yellow contour
		#lweight 2
		ltype 5 ctype default contour
		#lweight 3
                #
                set image[ix,iy] = pbaryonopgnewfun
                set lev={0}
                levels lev
		#ctype red contour
		ltype 4 ctype default contour
                #
                set image[ix,iy] = taualongjetnewfun
                set lev={0}
                levels lev
		#ctype green contour
		ltype 2 ctype default contour
                #
		#
                set image[ix,iy] = gammatheta1newfun
                set lev={0}
                levels lev
		#ctype red contour
		ltype 4 ctype default contour
                #
		#
		###########################
                # TYPE2
                ###########################
                #
plottype2setup 0     #
		#
		#
		set mycondition=conditionpt
		plc0 0 (LG(mycondition))
		set conditionnewfun=newfun
		#
		define missing_data (1E30)
		#
		#set toplot=(mycondition>1.0 ? 1E30 : prad/pg-0.2)
		set toplot=(prad/pg-0.2)
		plc0 0 toplot
		set pradopgnewfun=newfun
		#
		set toplot=(mycondition>1.0 ? 1E30 :  ppairs/pg-0.2)
                set toplot=(ppairs/pg-0.2)
		plc0 0 toplot
		set ppairsopgnewfun=newfun
		#
		#set toplot=(mycondition>1.0 ? 1E30 :  pbaryon/pg-0.2)
                set toplot=(pbaryon/pg-0.2)
		plc0 0 toplot
		set pbaryonopgnewfun=newfun
		#
		smooth2d taualongjet taualongjetnew 40 40 3
		#set toplot=(mycondition>1.0 ? 1E30 : taualongjetnew-1)
		set toplot=(taualongjetnew-1)
		plc0 0 toplot
		set taualongjetnewfun=newfun
		#
		plc0 0 (gammalorentz*thetajet-1)
		set gammatheta1newfun=newfun
		#
		#
plottype2setup2 0
		#
		erase
		#
plottype2doit 0     #
		fdraft
		lweight 5
		#rdraft
		ltype 0
		ptype 1 1
		ctype default
                box
		labelaxes 0
                #
                limits $txl $txh $tyl $tyh
                image ($rnx,$rny) $txl $txh $tyl $tyh
		#
                set image[ix,iy] = conditionnewfun
		set lev={0}
                levels lev
		#ctype blue contour
		ltype 0 ctype default contour
                #
                set image[ix,iy] = pradopgnewfun
                set lev={0}
		levels lev
                #ctype red contour
		ltype 1 ctype default contour
                #
                set image[ix,iy] = ppairsopgnewfun
                set lev={0}
                levels lev
		#ctype yellow contour
		#lweight 2
		ltype 5 ctype default contour
		#lweight 3
                #
                set image[ix,iy] = pbaryonopgnewfun
                set lev={0}
                levels lev
		#ctype red contour
		ltype 4 ctype default contour
                #
                set image[ix,iy] = taualongjetnewfun
                set lev={0}
                levels lev
		#ctype green contour
		ltype 2 ctype default contour
                #
		#
                set image[ix,iy] = gammatheta1newfun
                set lev={0}
                levels lev
		#ctype red contour
		ltype 4 ctype default contour
		#
		#
		#
		#
		#
		#
		#
		###########################
                # TYPE2 latest
                ###########################
                #
		#
grabdtlabatrtrans 0 #
		#
		# Get dtlab at rtrans
		#
		define mynx 40
		define myny 40
		#
		set mydtlab=conditionpt*0
		set rtrans=conditionpt*0
		set rdiss=conditionpt*0
		set mypowerjet=conditionpt*0
		set myEpeakobskev=conditionpt*0
		set mygammalorentz=conditionpt*0
		set mythetajet=conditionpt*0
		#
		#
		do jjj=0,$myny-1,1 {\
		 #
		 set mypos=-1
		 #
		 define iii ($nx-1)
		 #
		 while { $iii>=0 } {\
		   #     
		   #
		   set pos=$iii+$jjj*$mynx
		   #
		   #echo $iii $jjj
		   #
		   if(conditionpt[pos]<1){\
		          # dttransitobs = dttransit/gamma and dtlab = gamma dttransit
		          set mydtlab[pos]=dttransitobs[pos]*gammalorentz[pos]**2
		          set rtrans[pos]=ljet[pos]
		          set rdiss[pos]=rtrans[pos]+c*mydtlab[pos]
		          set mypowerjet[pos]=powerjet[pos]
		          set myEpeakobskev[pos]=Epeakobskev[pos]
		          set mygammalorentz[pos]=gammalorentz[pos]
		          set mythetajet[pos]=thetajet[pos]
		          #
		          # if possible, then linearly interpolate for smoother contour
		          if($iii<$nx-1){\
		           set conditionptm1low=conditionpt[pos]-1
		           set conditionptm1high=conditionpt[pos+1]-1
		           #
		           set mydtlablow=(dttransitobs[pos]*gammalorentz[pos]**2)
		           set mydtlabhigh=(dttransitobs[pos+1]*gammalorentz[pos+1]**2)
		           set mydtlab[pos]= mydtlablow + (mydtlabhigh-mydtlablow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set rtranslow=ljet[pos]
		           set rtranshigh=ljet[pos+1]
		           set rtrans[pos]= rtranslow + (rtranshigh - rtranslow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set rdisslow=ljet[pos]+c*(dttransitobs[pos]*gammalorentz[pos]**2)
		           set rdisshigh=ljet[pos+1]+c*(dttransitobs[pos+1]*gammalorentz[pos+1]**2)
		           set rdiss[pos]= rdisslow + (rdisshigh - rdisslow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set mypowerjetlow=powerjet[pos]
		           set mypowerjethigh=powerjet[pos+1]
		           set mypowerjet[pos]= mypowerjetlow + (mypowerjethigh - mypowerjetlow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set myEpeakobskevlow=Epeakobskev[pos]
		           set myEpeakobskevhigh=Epeakobskev[pos+1]
		           set myEpeakobskev[pos]= myEpeakobskevlow + (myEpeakobskevhigh - myEpeakobskevlow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set mygammalorentzlow=gammalorentz[pos]
		           set mygammalorentzhigh=gammalorentz[pos+1]
		           set mygammalorentz[pos]= mygammalorentzlow + (mygammalorentzhigh - mygammalorentzlow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		           set mythetajetlow=thetajet[pos]
		           set mythetajethigh=thetajet[pos+1]
		           set mythetajet[pos]= mythetajetlow + (mythetajethigh - mythetajetlow)/(conditionptm1high-conditionptm1low)*(0-conditionptm1low)
		           #
		          }
		          #
		          set mypos=pos
		          break
		   }
		   #
		   define iii (($iii)-1)
		   #
		 }
		 #
		 # set all radii to this dtlab
		 #
		 if(mypos==-1 && conditionpt[0]<1){\
		  set mypos=0
		 }
		 #
		 if(mypos==-1 && conditionpt[0]>1){\
		  set mypos=$nx-1
		 }
		 #
		 do iii=$mynx-1,0,-1 {\
		        set mydtlab[$iii+$jjj*$mynx]=mydtlab[mypos]
		        set rtrans[$iii+$jjj*$mynx]=rtrans[mypos]
		        set rdiss[$iii+$jjj*$mynx]=rdiss[mypos]
		        set mypowerjet[$iii+$jjj*$mynx]=mypowerjet[mypos]
		        set myEpeakobskev[$iii+$jjj*$mynx]=myEpeakobskev[mypos]
		        set mygammalorentz[$iii+$jjj*$mynx]=mygammalorentz[mypos]
		        set mythetajet[$iii+$jjj*$mynx]=mythetajet[mypos]
		 }
		 #
		}
		#
		# plc0 0 (mydtlab-dttransitobs*gammalorentz**2)
		# plc0 0 (conditionpt-1)     
		#
ghirlandacheck 0 #
		#
		# plotlatesttype1 0 0
		#
		ctype default ltype 0
		pl 0 myEpeakobskev mypowerjet 1101 1 1E3 1E48 1E55
		#
		ctype red ltype 0
		set myfit=10**54.3244*(myEpeakobskev/10**0.160385)**(-1.846)
		pl 0 myEpeakobskev myfit 1111 1 1E3 1E48 1E55
		# T\propto P_j^{-1.8} or T\propto E_j^{2.23} required to satisfy Ghirlanda relation
		#
		#
		# plotlatesttype3 0 0
		# power doesn't depend upon \zeta
		#
		# plotlatesttype4 0 0
		# power doesn't go from 48 to 52 over same epeak range
		#
 		# plotlatesttype5 0 0
		# power doesn't depend upon r_{\rm mono}
		#
 		# plotlatesttype6 0 0
		# need to redo powerjet or powerfoot to depend upon thetafp
		#
		#
		ctype default ltype 0
		set thetafactor=(4/3)*(2+cos(thfp))*sin(thfp/2)**4
		pl 0 myEpeakobskev (mypowerjet*thetafactor) 1101 1 1E3 1E48 1E51
		#
		ctype red ltype 0
		set myfit=10**50.143*(myEpeakobskev/10**2.39804)**(0.7255)
		pl 0 myEpeakobskev myfit 1111 1 1E3 1E48 1E51
		# T\propto E_j^{0.5} required to satisfy Ghirlanda relation
		#
		# try again:
		ctype default ltype 0
		set thetafactor=(9*sin(1/mygammalorentz)*sin(thfp) - sin(3/mygammalorentz)*sin(3*thfp))/6.
		set thetafactor=thetafactor*(mythetajet*2*mygammalorentz)**2
		pl 0 myEpeakobskev (mypowerjet*thetafactor) 1101 1 1E3 1E48 1E51
		#
		ctype red ltype 0
		set myfit=10**50.7389*(myEpeakobskev/10**2.39377)**(1.0)
		pl 0 myEpeakobskev myfit 1111 1 1E3 1E48 1E51
		# T\propto E_j^{1/3} required to satisfy Ghirlanda relation
		#
		#
		#
		# others not interesting
		#
		#
doalllatest 1   #
		#
		plotlatesttype1 $1 1
		
		#
		#######################
		# latest 2D contour plots
		#
readbrzeta1e4 0 # 2D	
		#
		readtypelong1 grb_40._1._40._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._40._1._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
                #
readbrzeta1e2 0 # 2D	
		#
		# below file has been processed as described in runscript8.sh
		# well, that caused problems.  And found even though updated gamma_jet, the lorentz factor was wrong -- so updates were stupid -- could redo, but just describe plot results
		readtypelong1 grb_40._1._40._1._1._1._1._1.1._1._1._1._1._1._1._1.40._1._40._1._1._1._1._1._1._1.e12_5.e14_100._1.e6_100._1.e8_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
                #
readmu	0	# 2D
		#
		#readtypelong1 grb_40._40._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._40._1._1._1._1._1._1._1._1.e12_5.e14_50._1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		readtypelong3 grb_40._40._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._40._1._1._1._1._1._1._1._1.e12_5.e14_50._1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0_redo
		#
		grabdtlabatrtrans
		#
readnu  0       #		
		#readtypelong1 grb_40._1._1._40._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._40._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.1_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		# new larger nu range
		#readtypelong1 grb_40._1._1._40._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._40._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.0001_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		# fixed jet but messed-up new variables --- ok since not used
		readtypelong1 grb_40._1._1._40._1._1._1._1.1._1._1._1._1._1._1._1.40._1._1._40._1._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.0001_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		grabdtlabatrtrans
		#
		#
		#
readrmono 0     #
		#
		readtypelong1 grb_40._1._1._1._40._1._1._1.1._1._1._1._1._1._1._1.40._1._1._1._40._1._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_1._1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
		#
readthfp 0      #		
		#readtypelong1 grb_40._1._1._1._1._40._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._40._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_0.1571_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		#readtypelong1 grb_40._1._1._1._1._40._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._40._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_0.0001_1.571_1.571_2._1.e4_2._0_1.e4_0
		#
		# corrupt for new stuff past mu
		readtypelong1 grb_40._1._1._1._1._40._1._1.1._1._1._1._1._1._1._1.40._1._1._1._1._40._1._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_0.0001_1.571_1.571_2._1.e4_2._0_1.e4_0
		read {muconst 202}
		#
		grabdtlabatrtrans
		#
readlmode 0     #		
		readtypelong1 grb_40._1._1._1._1._1._40._1.1._1._1._1._1._1._1._1.40._1._1._1._1._1._40._1._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
		#
readmmode 0     #		
		readtypelong1 grb_40._1._1._1._1._1._1._40.1._1._1._1._1._1._1._1.40._1._1._1._1._1._1._40._1._1.e12_5.e14_1.e4_1.e6_1.e4_1.e15_1.e17_0.75_1._0.75_3.e10_1.e12_3.e10_1.571_1.571_1.571_2._1.e4_2._0.01_1.e4_0
		grabdtlabatrtrans
		#
readm87   0     #
		readtypelong1 m87_40._40._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._40._1._1._1._1._1._1._1._1.e12_1.e8_50._1.e6_50._1000._1.e6_0.75_1._0.75_100._1.e12_100._1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
		#
readgrs   0     #		
		readtypelong1 grs_40._40._1._1._1._1._1._1.1._1._1._1._1._1._1._1.40._40._1._1._1._1._1._1._1._1.e12_1.e8_50._1.e6_50._1.e9_1.e11_0.75_1._0.75_100._1.e12_100._1.571_1.571_1.571_2._1.e4_2._0_1.e4_0
		grabdtlabatrtrans
		#
		#
plotlatesttype1      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readbrzeta1e4
		#
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap br_zeta1e4.eps
		}
		plottype2doitlatest
		doshadething1
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype2      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readbrzeta1e2
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "B_r(r_{\rm fp})[G]"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap br_zeta1e2.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype3      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readmu
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap zeta.eps
		}
		plottype2doitlatest
		doshadething2
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype4      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readnu
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu nu
		#
		define x1label "r[cm]"
		define x2label "\\nu"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap nu.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype5      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readrmono
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu rmono
		#
		define x1label "r[cm]"
		define x2label "r_{\rm mono}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap rmono.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype6      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readthfp
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu thfp
		#
		define x1label "r[cm]"
		define x2label "\theta_{\rm fp}"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap thfp.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype7      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readlmode
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu lmode
		#
		define x1label "r[cm]"
		define x2label "l mode"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#plottype2setuplatest
		plottype2setuplatestforlmode
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap lmode.eps
		}
		plottype2doitlatest
		#
		doshadething3
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype8      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readmmode
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 1 40 ljet fakemu mmode
		#
		define x1label "r[cm]"
		define x2label "m mode"
		define PLANE 2
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#plottype2setuplatest
		plottype2setuplatest # forlmode
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap mmode.eps
		}
		plottype2doitlatest
		#
		doshadething4
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype9      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readm87
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#plottype2setuplatest
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap m87.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
plotlatesttype10      2
		#
		define doprint $1
		define shadeonly $2
		#
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		readgrs
		#
		# assume other dimensiones are 1 in size including missing br0,nu dimension
		setupplc 40 40 1 ljet fakemu br0
		#
		define x1label "r[cm]"
		define x2label "\zeta"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		#plottype2setuplatest
		plottype2setuplatest
		plottype2setup2latest
		if($doprint==1){\
 		 device postencap grs.eps
		}
		plottype2doitlatest
		#
		#
		#
		if($doprint==1){\
		 device X11
		}
		#
shadenotused    0 #		
		# user coords using plc: $txl $txh $tyl $tyh
		# screen coords: $gx1 $gx2 $gy1 $gy2
		#
		# convert to screen coordinates
		set screenx = $gx1 + (($gx2-$gx1)/($txh-$txl))*(myx-$txl)
		set screeny = $gy1 + (($gy2-$gy1)/($tyh-$tyl))*(myy-$tyl)
		#
shadehottodo    0 #		
		# how to do:
		#
		# image cursor myx myy myz
		# print '%g ' {myx}
		# print '%g ' {myy}
		# and then add braces
		#
doshadething1 0  #
		#
		define shadenum 500
		#define shadenum 2000
		#
		relocate 7.38348   15.1669
		angle 61
		putlabel 5 "|b|=b_{\rm QED}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		relocate 7.82489   10.0036
		angle 20
		putlabel 5 "\tau_{||}=1" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		set myx={6.9245 6.65984 6.39519 6.18328 6.05974 5.79509 5.61834 5.60076 6.96013}
		set myy={17.0023 16.6626 16.4263 16.2047 16.0273 15.8205 15.7318 17.017 17.017}
		#
		lweight 3 ltype 0 angle (39+90)
		shade $shadenum myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		relocate 6.65984 16.2165
		angle 50
		putlabel 5 \tau_{\\nu}=1
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		set myx={17.9568 16.9861 16.4919 14.7619 13.8088 12.0261 11.1789 10.7199 10.7019 10.4904 17.9924 18.01}
		set myy={13.0878 12.5412 12.246 11.3005 10.754 9.70542 9.05545 8.65651 8.28735 8.0216 7.97709 13.1176}
		#
		lweight 3 ltype 0 angle 39
		shade $shadenum myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
 		connect myx myy
		relocate 8.49578 14.1315
		angle 60
		putlabel 5 "n_e=n_{\rm pairs}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		set myx={11.0905 10.7375 10.6491 6.57147 6.78338 10.4904 11.885 13.5266 17.2331 11.0373}
		set myy={17.017 16.7513 16.116 11.1677 11.1824 13.3833 14.2107 15.0819 17.0317 17.0023}
		lweight 3 ltype 0 angle 39
		shade $shadenum myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		relocate 14.0559 11.2092
		angle 39
		putlabel 5 "n_e=n_{\rm pairs}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		set myx={17.6921 16.28 14.4797 12.9616 11.2844 10.7551 10.4728 9.21942 7.89568 7.56023 7.10125 5.61834 5.93621 6.28924 7.94842 9.78436 11.7966 14.1794 15.7683 17.2688 18.0276 18.0276 17.6569}
		set myy={17.0108 16.2875 15.3937 14.5284 13.578 13.2377 12.7981 12.0179 11.0675 10.7553 10.4575 9.43607 9.45047 9.57811 10.6846 11.9044 13.1241 14.4293 15.252 16.0038 16.4011 17.0252 17.0393}
		lweight 3 ltype 0 angle 0
		shade $shadenum myx myy
		lweight 3 ltype 0 angle 90
		shade $shadenum myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		relocate 9.41328   11.3369
		angle 45
		putlabel 5 "r_{\rm diss}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		relocate 7.45428   11.0957
		angle 46
		putlabel 5 "r_{\rm trans}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
doshadething2 0  #
		#
		relocate 7.2072   3.91736
		angle 90
		putlabel 5 "|b|=b_{\rm QED}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		set myx={9.76631 9.71357 9.67841 9.64277 9.64277 9.51923 9.44891 9.41328 9.37812 17.445 16.5979 14.9914 14.1442 13.2971 12.4143 11.5139 11.32 11.0021 9.76631}
		set myy={6.00813 4.09519 3.98227 3.85512 3.79162 3.71404 3.62223 2.04806 1.7021 1.69506 2.11156 2.88809 3.37512 4.01746 4.73753 5.45041 5.888 6.00813 6.01517}
		#
		lweight 3 ltype 0 angle (39+90)
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		relocate 9.27216   4.59521
		angle 90
		putlabel 5 "n_e=n_{\rm pairs}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		set myx={11.9553 12.3439 12.8732 13.2614 13.7028 14.091 14.3913 14.7795 15.1857 15.4328 15.8386 16.1565 16.4919 16.8449 17.2507 17.4275 17.6921 17.445 16.9685 16.3684 15.821 15.3444 14.9738 14.5856 14.2502 13.9855 13.9148 11.9904}
		set myy={6.01204 5.5713 4.95446 4.52748 4.08675 3.72749 3.45629 3.17837 2.91405 2.74467 2.50741 2.32426 2.14127 1.97862 1.75481 1.69381 1.68708 1.81596 2.15488 2.6904 3.24625 3.79537 4.32401 4.86641 5.48325 5.88317 6.01877 6.00516}
		lweight 3 ltype 0 angle 0
		shade 500 myx myy
		lweight 3 ltype 0 angle 90
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		#
		relocate 15.0974   4.72408
		angle -75
		putlabel 5 "r_{\rm diss}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		relocate 12.95   4.62914
		angle -70
		putlabel 5 "r_{\rm trans}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		relocate 12.2   5.52392
		angle 50
		putlabel 5 \tau_{||}=1
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		relocate 13.9499   2.09388
		angle 0
		putlabel 5 "\gamma\theta_j=1"
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
doshadething3 0  #
		#
		relocate 7.2072   2.1
		angle 90
		putlabel 5 "|b|=b_{\rm QED}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		relocate 14.25   3.30486
		angle 90
		putlabel 5 \tau_{||}=1
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		set myx={9.64277 9.66083 13.2795 13.385 13.4206 13.5969 13.5793 13.6145 9.66083}
		set myy={4.01036 0.290807 0.290807 0.547314 0.722175 1.05454 1.53259 4.01036 4.01036}
		#
		lweight 3 ltype 0 angle (39+90)
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		#
		relocate 9.27216   2.5
		angle 90
		putlabel 5 "n_e=n_{\rm pairs}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		set myx={11.32 11.9025 12.3259 12.7145 12.926 13.0852 13.3146 13.4382 13.6145 13.6853 13.738 13.8264 13.8088 15.1501 15.1501 14.7092 14.0031 13.5617 13.2087 12.8024 12.4851 12.1496 11.8317 11.5319 11.3728}
		set myy={4.01614 3.27567 2.73939 2.26135 1.96395 1.7599 1.38099 1.10122 0.821307 0.646447 0.524044 0.401642 0.296591 0.296591 0.41321 0.693121 1.19443 1.56177 1.87074 2.27884 2.61699 3.0076 3.39821 3.75385 4.01036}
		lweight 3 ltype 0 angle 0
		shade 500 myx myy
		lweight 3 ltype 0 angle 90
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		#
		relocate 14.9738  0.850495
		angle -65
		putlabel 5 "r_{\rm diss}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		relocate 12.7849   1.58504
		angle -75
		putlabel 5 "r_{\rm trans}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
doshadething4 0  #
		#
		#
		relocate 7.2072  1.1
		angle 90
		putlabel 5 "|b|=b_{\rm QED}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		relocate 13.4733   3.25076
		angle 90
		putlabel 5 \tau_{||}=1
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		set myx={9.66083 9.66083 13.385 13.2439 13.1027 13.0676 13.1379 12.9968 12.944 12.7849 12.697 12.6789 12.6789 9.69599}
		set myy={3.99782 -2.02596 -2.0072 -1.92211 -1.80844 -1.57215 -1.364 -1.2128 -0.673673 0.0637817 1.21753 2.67389 4.02618 4.02618}
		#
		lweight 3 ltype 0 angle (39+90)
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		#
		relocate 9.27216   1.5
		angle 90
		putlabel 5 "n_e=n_{\rm pairs}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
		#
		#
		set myx={11.0554 11.35 11.6906 12.0788 12.3967 12.6086 12.7497 12.9084 13.0676 13.2087 13.3674 13.4909 14.5681 14.2678 13.7736 13.3674 12.9968 12.7673 12.4494 11.9553 11.5671 11.2492 11.1081 11.055}
		set myy={4.0168 3.50604 2.72124 1.88909 1.24589 0.725745 0.309673 -0.191491 -0.7304 -1.17484 -1.6856 -2.0072 -2.01658 -1.67622 -1.052 -0.512873 0.0543999 0.5368 1.18916 2.2672 3.09935 3.76131 4.0168 4.0168}
		lweight 3 ltype 0 angle 0
		shade 500 myx myy
		lweight 3 ltype 0 angle 90
		shade 500 myx myy
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		connect myx myy
		#
		relocate 14.4441   -1.373
		angle -65
		putlabel 5 "r_{\rm diss}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		relocate 12.5026 0.0921454
		angle -75
		putlabel 5 "r_{\rm trans}" 
		angle 0 ltype 0 lweight $PLOTLWEIGHT
		#
plottype2setuplatest 0     #
		#
		#
		set mycondition=conditionpt
		plc0 0 (LG(mycondition))
		set fun0=newfun
		#
		set mydiss=(ljet-rdiss)
		plc0 0 mydiss
		set fun0diss=newfun
		#
		define missing_data (1E30)
		#
		set toplot=(taunusca-1)
		plc0 0 toplot
		set fun1=newfun
		#
		set toplot=(Ppairs/Prad-1)
		plc0 0 toplot
		set fun2=newfun
		#
		set toplot=(npairs/necenter-1)
		plc0 0 toplot
		set fun3=newfun
		#
		smooth2d taualongjet taualongjetnew 40 40 3
		#set toplot=(mycondition>1.0 ? 1E30 : taualongjetnew-1)
		set toplot=(taualongjetnew-1)
		plc0 0 toplot
		set fun4=newfun
		#
		# below only applies for near axis plots
		plc0 0 (gammalorentz*thetajet-1)
		set fun5=newfun
		#
		plc0 0 (bgauss-Bc)
		set fun6=newfun
		#
		#
plottype2setuplatestforlmode 0     #
		#
		#
		set mycondition=conditionpt
		plc0 0 (LG(mycondition))
		set fun0=newfun
		#
		set mydiss=(ljet-rdiss)
		plc0 0 mydiss
		set fun0diss=newfun
		#
		#
		define missing_data (1E30)
		#
		set toplot=(taunusca-1)
		plc0 0 toplot
		set fun1=newfun
		#
		set toplot=(Ppairs/Prad-1)
		plc0 0 toplot
		set fun2=newfun
		#
		set toplot=(npairs/necenter-1)
		plc0 0 toplot
		set fun3=newfun
		#
		smooth2d taualongjet taualongjetnew 40 40 5
		set toplot=(ljet>10**14.2678 ? 1E30 : taualongjetnew-1)
		#set toplot=(taualongjetnew-1)
		plc0 0 toplot
		set fun4=newfun
		#
		# below only applies for near axis plots
		plc0 0 (gammalorentz*thetajet-1)
		set fun5=newfun
		#
		plc0 0 (bgauss-Bc)
		set fun6=newfun
		#
		#
plottype2setup2latest 0
		#
		erase
		#
plottype2doitlatest 0     #
		fdraft
		lweight 5
		#rdraft
		ltype 0
		ptype 1 1
		ctype default
                box
		labelaxes 0
                #
                limits $txl $txh $tyl $tyh
                image ($rnx,$rny) $txl $txh $tyl $tyh
		#
		if($shadeonly==0){
                set image[ix,iy] = fun0
		set lev={0}
                levels lev
		#ctype blue contour
		ltype 0 ctype default contour
                #
                set image[ix,iy] = fun0diss
		set lev={0}
                levels lev
		#ctype blue contour
		ltype 0 ctype default contour
		}
                #
		if($shadeonly==0){
                set image[ix,iy] = fun1
                set lev={0}
		levels lev
                #ctype red contour
		ltype 2 ctype default contour
		}
                #
		if($shadeonly==0){
		#set image[ix,iy] = fun2
                #set lev={0}
                #levels lev
		#ctype yellow contour
		#lweight 2
		#ltype 1 ctype default contour
		#lweight 3
		}
                #
		if($shadeonly==0){
                set image[ix,iy] = fun3
                set lev={0}
                levels lev
		#ctype red contour
		ltype 4 ctype default contour
		}
                #
                set image[ix,iy] = fun4
                set lev={0}
                levels lev
		#ctype green contour
		ltype 1 ctype default contour
                #
		#
                set image[ix,iy] = fun5
                set lev={0}
                levels lev
		#ctype red contour
		ltype 3 ctype default contour
                #
                set image[ix,iy] = fun6
                set lev={0}
                levels lev
		#ctype red contour
		ltype 2 ctype default contour
                #
		#
		#
smooth2d 5      # smooth2d input output $nx $ny smoothwidth
		#
		# e.g.'s:
		# smooth2d taualongjet outputtau 40 40 1
		#
		# using smoothwidth=1 gives back input as output
		#
		set input=$1
		set output=$1*0
		set mynx=$3
		set myny=$4
		set width=$5
		#
		do jjj=0,myny-1,1 {\
		   do iii=0,mynx-1,1 {\
		   #echo "outside:" $iii $jjj
		   #
		   set outputpos=$iii+$jjj*mynx
		   #
		   # initialize 
		   set norm=0
		   set output[outputpos]=0
		   #
		   set intw=INT(width/2)
		   #
		   do lll=-intw,intw,1 {\
		      do kkk=-intw,intw,1 {\
		         set inputx=$iii+$kkk
		         set inputy=$jjj+$lll
		         # only add term if within image boundaries (i.e. don't wrap)
		         #echo "inside:" $kkk $lll
		         if(inputx>=0 && inputx<mynx && inputy>=0 && inputy<myny){\
		          #echo "deep"
		          #
		          set inputpos=inputx + inputy*mynx
		          #
		          #set rsq=($iii - $kkk)**2 + ($jjj - $lll)**2
		          set rsq=($kkk)**2 + ($lll)**2
		          set addterm=exp(-rsq/(2*width))
		          set norm=norm + addterm
		          set output[outputpos] = output[outputpos] + addterm*input[inputpos]
		          #print {outputpos inputpos rsq addterm norm}
		         }
		      }
		   }
		   # normalize
		   set output[outputpos]=output[outputpos]/norm
		   }
		}
		#
		set $2=output
		#
		#
		#
		#
		#
