loadrmac 0      #
		gogrmhd
		jre kaz.m
		jre grbmodel.m
		jre reconnection.m
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
plotnewtype1      0 #
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
		set toplot=(mycondition>1.0 ? 1E30 : taualongjet-1)
		#set toplot=(taualongjet-1)
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
		#set toplot=(mycondition>1.0 ? 1E30 : taualongjet-1)
		set toplot=(taualongjet-1)
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
