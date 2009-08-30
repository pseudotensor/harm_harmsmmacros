		############################################
		#
		# MATLAB OUTPUT OF DIFF VERSIONS
		#
		#############################################
		#
		#
		# REMAINING MACROS ARE FOR FINAL POST-MATLAB TABLES for F(U/P/CHI)
		# There are some macros for checking pre-matlab too
		#
		#
		#
		#
rdjoneosold 1      # old no-degen files
		#
		# eos_extract.m has interpolated to U/P/CHI space for this data
		#
		#
		da $1
		lines 1 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sm sn so sp rhob utotdiff ptotdiff chidiff hcm tdyn \
		       pofu uofp \
		       dpofudrho0 dpofudu \
		       cs2cgs \
		       sofu dsofudrho dsofudu \
		    pofchi dpofchidrho0 dpofchidchi \
		    qmofU tkofU tkofP tkofCHI}
		#
		#
		#
		#
rdjonheadernew 1 #
		#
		# see eos_extract.m
		#
                #
		da $1
		#
		lines 1 1
		read '%d %d %d' {whichrnpmethod whichynumethod whichhcmmethod}
                lines 2 2
                read '%d %d %d %d' {whichdatatype utotdegencut numoutcolumns numextras}
		lines 3 3
		read '%g %g %g %g %g %g' {nrhob lrhobmin lrhobmax steplrhob baselrhob linearoffsetlrhob}
		lines 4 4
		read '%g %g %g %g %g %g' {nutotout lutotoutmin lutotoutmax steplutotout baselutotout linearoffsetlutotout}
		lines 5 5
		read '%g %g %g %g %g %g' {nptotout lptotoutmin lptotoutmax steplptotout baselptotout linearoffsetlptotout}
		lines 6 6
		read '%g %g %g %g %g %g' {nchiout lchioutmin lchioutmax steplchiout baselchiout linearoffsetlchiout}
		lines 7 7
		read '%g %g %g %g %g %g' {nstotout lstotoutmin lstotoutmax steplstotout baselstotout linearoffsetlstotout}
		lines 8 8
		read '%g %g %g %g %g %g' {ntdynorye ltdynoryemin ltdynoryemax stepltdynorye baseltdynorye linearoffsetltdynorye}
		lines 9 9
		read '%g %g %g %g %g %g' {ntdynorynu ltdynorynumin ltdynorynumax stepltdynorynu baseltdynorynu linearoffsetltdynorynu}
		lines 10 10
		read '%g %g %g %g %g %g' {nhcm lhcmmin lhcmmax steplhcm baselhcm linearoffsetlhcm}
		lines 11 11
		read '%g %g' {lsoffset fakelsoffset}
		lines 12 12
		read '%g %g %g %g %g %g' {ntk ltkmin ltkmax stepltk baseltk linearoffsetltk}
		#
		#
rdjoneos 1      # E.g.:
		# rdjoneos 'test1'
		# rdjoneos ''
		#
		# see eos_extract.m
		#
		#
		# here the utot, ptot, chi are really offsets from the degenerate (sn==0) case
		# eos_extract.m has interpolated to U/P/CHI space for this data
		#
		#
		set h1=$1
		set h2='eosnew'
		set h3='.dat'
		set _fname=h2+h1+h3
                define filename (_fname)
		#
		set h3='.head'
		set _fname=h2+h1+h3
                define filenamehead (_fname)
		#
		#
		#
		# get header info that has whichrnpmethod
		rdjonheadernew $filenamehead
		#
		da $filename
		lines 1 100000000
		#
                # 29 base things, 1 extra for 30 total things
		if(whichdatatype==1){
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sm sn so sp sq \
		       rhob utotdiff ptotdiff chidiff tdynorye tdynorynu hcm \
		       uofutotdiff pofptotdiff chiofchidiff \
		       pofu uofp \
		       dpofudrho0 dpofudu \
		       cs2cgs \
		       sofu dsofudrho dsofudu \
		    pofchi dpofchidrho0 dpofchidchi \
		    tkofU tkofP tkofCHI qmofU}
		}
		#
		# 29 base things, 16 extra for 45 total things
		if(whichdatatype==2){
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sm sn so sp sq \
		       rhob utotdiff ptotdiff chidiff tdynorye tdynorynu hcm \
		       uofutotdiff pofptotdiff chiofchidiff \
		       pofu uofp \
		       dpofudrho0 dpofudu \
		       cs2cgs \
		       sofu dsofudrho0 dsofudu \
		    pofchi dpofchidrho0 dpofchidchi \
		    tkofU tkofP tkofCHI \
		    qtautelohcm qtauaelohcm \
		    qtautmuohcm qtauamuohcm \
		    qtautqtauohcm qtauaqtauohcm \
		    ntautelohcm ntauaelohcm \
		    ntautmuohcm ntauamuohcm \
		    ntautntauohcm ntauantauohcm \
		    gammapeglobal gammapnuglobalplusgammapenuglobal \
		    gammanglobalplusgammaneglobal gammannuglobal }
		 }
		# 29 base things, 9 extra, for 38 total things
		if(whichdatatype==3){
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sm sn so sp sq \
		       rhob utotdiff ptotdiff chidiff tdynorye tdynorynu hcm \
		       uofutotdiff pofptotdiff chiofchidiff \
		       pofu uofp \
		       dpofudrho0 dpofudu \
		       cs2cgs \
		       sofu dsofudrho0 dsofudu \
		    pofchi dpofchidrho0 dpofchidchi \
		    tkofU tkofP tkofCHI \
		    Qm graddotrhouyenonthermal graddotrhouye Tthermaltot lambdatot \
                    Enuglobal Enueglobal Enuebarglobal \
                    Ynu Ynu0 }
		 }
		#
		# end whichdatatype==3
		#
		if(whichdatatype==4){
                  #
		  set totalcolumnsA=5+8+4+1+2+2+1+3+3+3+4
		  set totalcolumnsB=24
		  set totalcolumns=totalcolumnsA+totalcolumnsB
		  print {totalcolumns}
		  #
                  # RECALL:  utotdiff, etc. are really lutotdiff in eos_extract.m
		  # 33 base things, 24 extra, for 57 total things
		  read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sm sn so sp sq \
		       rhob utotdiff ptotdiff chidiff stotdiff tdynorye tdynorynu hcm \
		       uofutotdiff pofptotdiff chiofchidiff sofstotdiff \
		       pofu \
		       uofp uofs \
		       dpofudrho0 dpofudu \
		       cs2cgs \
		       sofu dsofudrho0 dsofudu \
		       ssofchi dssofchidrho0 dssofchidchi \
		    pofchi dpofchidrho0 dpofchidchi \
		    tkofU tkofP tkofCHI tkofS \
		    \
                        qtautnueohcm  qtauanueohcm \
                    qtautnuebarohcm  qtauanuebarohcm \
                    qtautmuohcm  qtauamuohcm \
                    ntautnueohcm  ntauanueohcm \
                    ntautnuebarohcm  ntauanuebarohcm \
                    ntautmuohcm  ntauamuohcm \
                    unue0 unuebar0 unumu0 \
                    nnue0 nnuebar0 nnumu0 \
                    lambdatot lambdaintot \
                    tauphotonohcm tauphotonabsohcm \
		    nnueth0 nnuebarth0 }
		  }
		 # end whichdatatype==4
                  #
		#		#
rdjondegeneos 1	# rdjondegeneos 'test1'
		#
		#
		# here the utotoffset, ptotoffset, chioffset are really offsets from the degenerate (sdn==0) case
		# eos_extract.m has interpolated to U/P/CHI space for this data
		#
		#
		# 11 columns
		#
		set h1=$1
		set h2='eosdegennew'
		set h3='.dat'
		set _fname=h2+h1+h3
                define filename (_fname)
		#
		#
		da $filename
		lines 1 100000000
		read '%d %d %d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {sdm sdo sdp sdq \
		       rhobdegen tdynoryedegen tdynorynudegen hcmdegen \
		       utotoffset ptotoffset chioffset stotoffset \
		       utotin ptotin chiin stotin \
		       utotout ptotout chiout stotout \
		    }
		#
		#
		#
		#
		#
setuptaunse 0   #              
                #
                set AA=179.7*1.0D9
                set BB=39.0d0
                set CC=0.2d0
                set taunse=(rhob)**(CC)*exp(AA/(tempk)-BB)
                set taunselimit=1.0
                #
                set tminnse = AA/(BB+lg(taunselimit/(rhob)**(CC)))
                #
                plc 0 (LG(taunse))
		#
                plc 0 (LG(tminnse))
		#
		#
checkpretableslarge 0 #
		#
		da eosother.dat
		lines 1 100000000
		read {s_eleposi 19}
		#
		rdkazheadernew
		da eos.dat
		lines 1 100000000
		read {rhob 1 tempk 2 tdynorye 3}
		#
		setgrbconsts
		#
		set Nb=rhob/mb
		#
                set ne=tdynorye*Nb
		set mecc=me*c**2
		set restmassuee=mecc*ne
		set sspeceecor=restmassuee/Nb/(kb*tempk)
		#
                set sspecee=(s_eleposi)/Nb
		#
		set iii=0,dimen(rhob)-1
                set mm=iii%nrhob
                set nn=INT(iii%(nrhob*ntk)/nrhob)
                set oo=INT(iii%(nrhob*ntk*ntdynorye)/(nrhob*ntk))
                set pp=INT(iii%(nrhob*ntk*ntdynorye*ntdynorynu)/(nrhob*ntk*ntdynorye))
		#
		print {nrhob ntk ntdynorye ntdynorynu}
		#
                set mymm=INT(mm[dimen(mm)-1]-39*2)
		set myoo=INT(oo[dimen(oo)-1]-3)
		set mypp=INT(pp[dimen(pp)-1]*0)
		print {mymm myoo mypp}
		#
                set myuse=((mm==mymm && oo==myoo && pp==mypp) ? 1 : 0)
                #
                # extract only if myuse is true
                set mysspecee = sspecee if(myuse)
                set mysspeceecor = sspeceecor if(myuse)
                set myrhob = rhob if(myuse)
		set mytdynorye = tdynorye if(myuse)
                set mytempk = tempk if(myuse)
		#
		set  mathsspecee={7.055919815517668e-10 1.2401168594559556e-9 2.179599068283459e-9 3.830874597704539e-9  \    
		   6.733330286199586e-9 1.1835249675169102e-8 2.080403303107157e-8 3.657215554008075e-8          \
		   6.429859746698151e-8 1.1306344031209896e-7 1.988586164390799e-7 3.498761520659816e-7  \
		   6.158842420342546e-7 1.0849159030911979e-6 1.9131386942718805e-6 2.811825195356003 \
		   -1.1473803208797961 0.8917831965413787 -0.2320016945965825 0.01295714278912186 \
		   0.018046121146650593 0.026176716270725955 0.03812005186461481 0.055508742334277515 \
		   0.08081739820751385 0.11762850101351115 0.17109349009971123 0.24851588789211418 \
		   0.35994623323425334 0.5184038993944239 0.7392206649801661 1.0437599274032634 \
		   1.5360205517906127 2.959937760458456 8.104073081155828 24.540120911262548 75.22592952263565 \
		   231.15671151888208 711.3398059425236 2191.4111494651347 6756.437999178434 20842.881988839843 \
		   64323.50175803371 198564.17598391196 613076.3887717722 1.8931506070191357e6 \
		    5.846485993088243e6 1.805641863490493e7 5.576822858237962e7 1.7224825148071504e8 }
		#
		#
		print {mytempk mysspecee mysspeceecor mathsspecee}
		#
		#
		#
checkpretables  0 #
		#
		#
		####################################
		# read-in pre-Matlab tables
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		# check on behavior of quantities before Matlab deals with things
		#
		define WHICHLEV (ntdynorye-4)
		#
		plc 0 (LG(dptot))
		#
		plc 0 (LG(dutot))
		#
		plc 0 (LG(dstot))
		#
                #
                #
                plc 0 (LG(abar))
                #
                #
                #
		setgrbconsts
                #
                set nb=rhob/mb
                set ne=tdynorye*nb
                #
                set mecc=me*c**2
		set restmassuee=mecc*ne
                #
		# reproduce TIMMES entropy
		set kazsdenee=(p_eleposi+rho_eleposi)/(kb*tempk)
		set timmessdenee=kazsdenee-etae*ne
		set timmessspecee=timmessdenee/nb
                #
                set rho_eleposinorest = rho_eleposi - restmassuee
		set etaenorest = etae-me*c**2/(kb*tempk)
		set kazsdeneenorest=(p_eleposi+rho_eleposinorest)/(kb*tempk)
		set timmessdeneenorest=kazsdenee-etaenorest*ne
		set timmessspeceenorest=timmessdenee/nb
		#
		#
                #
		set nb=rhob/mb
		set ne=tdynorye*nb
		set etaenorest = etae-me*c**2/(kb*tempk)
		set rho_eleposinorest = rho_eleposi-me*c**2*ne
		# entropy density (1/cc) 
		set seerest = restmassuee/(kb*tempk)
                #
                #set kazsden=(dptot+dutot)/(kb*tempk)
                # Kaz says it's:
                set kazsdenee=(p_eleposi+rho_eleposi-restmassuee)/(kb*tempk)
                # TIMMES says it's:
                #set etaenorest = etae - (me*c**2/(kb*tempk))
                set timmessdenee=kazsdenee-etae*ne
                #set timmessdenee=kazsdenee-etae*ne + restmassuee/(kb*tempk)
                #set timmessdenee=kazsdenee-etaenorest*ne
                #set timmessdenee=(p_eleposi+rho_eleposi-restmassuee)/(kb*tempk)-etaenorest*ne
                #
                # seems to be that eele+epos is missing rest-mass from epos since apparently TIMMES subtracts me c^2 n_{e_+} from epos!  So my rest-mass correction in jon_lsbox.f is then wrong!  Compare with KAZ!
                #
                plc 0 (LG(kazsdenee))
                #
                plc 0 (LG(timmessdenee))
                #
                # actual:
                plc 0 (LG(s_eleposi))
		#
                #
                #
                #
                # photons:
                set sphoton1=(p_photon+rho_photon)/(kb*tempk)
                set sphoton2=s_photon
		plc 0 (LG(sphoton1))
		plc 0 (LG(sphoton2))
		plc 0 (abs(sphoton1-sphoton2)/(abs(sphoton1)+abs(sphoton2)))
                #
                #
		#
		plc 0 (LG(dstot+seerest))
		#
		plc 0 (LG(s_eleposi/rhob))
		#
 		plc 0 (LG((s_eleposi-seerest)/rhob+1E29))
		#
		set gods_eleposi = (rho_eleposinorest+p_eleposi)/(kb*tempk) - etaenorest*ne
		plc 0 (LG(gods_eleposi/rhob))
		#
		set god2s_eleposi = (rho_eleposi+p_eleposi)/(kb*tempk) - etae*ne
		plc 0 (LG(god2s_eleposi/rhob))
		#
		set god3s_eleposi = (rho_eleposi+p_eleposi)/(kb*tempk)
		plc 0 (LG(god3s_eleposi/rhob))
		#
		# checking what lowest limit is:
                # Can't really work due to machine error level subtraction.  Have to wait till produce new table without stupid entropy offset.
		setgrbconsts
		set nb=rhob/mb
		set s_N_lsoffset=lsoffset*ergPmev/(kb*tempk)*nb
		set specelsoffset=s_N_lsoffset/rhob
                set toplot=(dstot-s_N_lsoffset)/nb
		plc 0 toplot
                #
                set beforestot = dstot
                set beforespecdimless = dstot/nb
                print '%21.15g %21.15g\n' {beforestot beforespecdimless}
                #
                set afterstot = dstot-s_N_lsoffset
                set afterspecdimless = (dstot-s_N_lsoffset)/nb
                print {afterstot afterspecdimless}
                #
                #
                set diff=dstot-s_N_lsoffset
                # min=-9.464e+37
                #
                # dstot
                # min=5.935e+26
                #
                # print file.txt {toplot}
                # sort -g file.txt > filesort.txt
                # head -10 filesort.txt
                #
                #
		agzplc 0 toplot
		#
		# min:-12.94
		#
		#
		# See Y_e dependence
		agzplc 0 (LG(dptot))
		#
		agzplc 0 (LG(dutot))
		#
		agzplc 0 (LG(dstot))
		#
		#
		# So far noticed things:
		# 1) Unlike post-Matlab, pre-Matlab dptot,dutot,dstot looks good ... no feature at rhob=2E9 near low-temperatures
		# 2) None of results are noisy, so Matlab must be producing the noise
		#
                # check entropy monotonicity
		define WHICHLEV (ntdynorye-4)
		#
checksmono 0    #              
		#
		plc 0 (LG(s_N/rhob))
		#
		plc 0 (LG(specelsoffset))
		#
		plc 0 (LG((s_N-s_N_lsoffset)/rhob))
		#
                #
                plc 0 (LG(s_eleposi/rhob))
		#
                #
                #
                #
                plc 0 (LG((s_eleposi+seerest)/rhob))
                #
		#
                plc 0 (LG(s_photon/rhob))
                #
                plc 0 (LG(s_N/rhob))
                #
		#
		#
                set sspectotfake=(s_eleposi+s_photon+s_N)/rhob
                set sspectottrue=(s_eleposi+seerest+s_photon+s_N)/rhob
                #
                set sspeceefake=(s_eleposi)/rhob
                set sspeceetrue=(s_eleposi+seerest)/rhob
                #
                set sspecN=(s_N)/rhob
                set sspecphoton=(s_photon)/rhob
                #
                plc 0 (LG((s_eleposi+seerest+s_photon+s_N)/rhob))
                #
                plc 0 (LG(abar))    
                #
                set mymm=INT(mm[dimen(mm)-1]/2)
		set myoo=INT(oo[dimen(oo)-1]-4)
		set mypp=INT(pp[dimen(pp)-1]*0)
		print {mymm myoo mypp}
		#
                set myuse=((mm==mymm && oo==myoo && pp==mypp) ? 1 : 0)
                #
                # extract only if myuse is true
                set mysspectottrue = sspectottrue if(myuse)
                set mysspectotfake = sspectotfake if(myuse)
                set mysspeceetrue = sspeceetrue if(myuse)
                set mysspeceefake = sspeceefake if(myuse)
                set mysspecN = sspecN if(myuse)
                set mysspecphoton = sspecphoton if(myuse)
                set myrhob = rhob if(myuse)
                set mydutot = dutot if(myuse)
                #
                set myddutot=(mydutot-mydutot[0]*0.999999)
                #
                #
                # TOT:
                ctype default
		pl 0 myddutot (mysspectottrue) 1101 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                ctype magenta
		pl 0 myddutot (mysspectotfake) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # ee only:
                ctype red
		pl 0 myddutot (mysspeceetrue) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                ctype yellow
		pl 0 myddutot (mysspeceefake) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # N only:
                ctype blue
		pl 0 myddutot (mysspecN) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # photon only:
                ctype green
		pl 0 myddutot (mysspecphoton) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                #
                #
                # OTHERS:
		pl 0 mydutot (mysspectottrue) 1101 1E26 1E27 1E24 2E24
                #
                ctype default
                pl 0 mydutot (mysspectottrue) 1101 1.8E26 2E26 1E24 1.4E24
                ctype red
                pl 0 mydutot (mysspectotfake) 1111 1.8E26 2E26 1E24 1.4E24
                #
                #
checksmono2 0   #              
		#
		set Nb=rhob/mb
		#
                plc 0 (LG(s_eleposi/Nb))
		#
                #
                #
                set sspecee=(s_eleposi)/Nb
                set sspecN=(s_N)/Nb
                set sspecphoton=(s_photon)/Nb
		set sspectot=sspecee+sspecN+sspecphoton
                #
                set mymm=INT(mm[dimen(mm)-1]-39)
		set myoo=INT(oo[dimen(oo)-1]-3)
		set mypp=INT(pp[dimen(pp)-1]*0)
		print {mymm myoo mypp}
		#
                set myuse=((mm==mymm && oo==myoo && pp==mypp) ? 1 : 0)
                #
                # extract only if myuse is true
                set mysspectot = sspectot if(myuse)
                set mysspecee = sspecee if(myuse)
                set mysspecN = sspecN if(myuse)
                set mysspecphoton = sspecphoton if(myuse)
                set myrhob = rhob if(myuse)
                set myNb = Nb if(myuse)
                set mytdynorye = tdynorye if(myuse)
                set mytempk = tempk if(myuse)
                set mydutot = dutot if(myuse)
		set myetae = etae if(myuse)
                #
                set myddutot=(mydutot-mydutot[0]*0.999999)
                #
		set  mathsspecee={7.055919815517668e-10 1.2401168594559556e-9 2.179599068283459e-9 3.830874597704539e-9  \    
		   6.733330286199586e-9 1.1835249675169102e-8 2.080403303107157e-8 3.657215554008075e-8          \
		   6.429859746698151e-8 1.1306344031209896e-7 1.988586164390799e-7 3.498761520659816e-7  \
		   6.158842420342546e-7 1.0849159030911979e-6 1.9131386942718805e-6 2.811825195356003 \
		   -1.1473803208797961 0.8917831965413787 -0.2320016945965825 0.01295714278912186 \
		   0.018046121146650593 0.026176716270725955 0.03812005186461481 0.055508742334277515 \
		   0.08081739820751385 0.11762850101351115 0.17109349009971123 0.24851588789211418 \
		   0.35994623323425334 0.5184038993944239 0.7392206649801661 1.0437599274032634 \
		   1.5360205517906127 2.959937760458456 8.104073081155828 24.540120911262548 75.22592952263565 \
		   231.15671151888208 711.3398059425236 2191.4111494651347 6756.437999178434 20842.881988839843 \
		   64323.50175803371 198564.17598391196 613076.3887717722 1.8931506070191357e6 \
		    5.846485993088243e6 1.805641863490493e7 5.576822858237962e7 1.7224825148071504e8 }
		#
		# print {mytempk mysspecee mathsspecee}       
		#
                #
                # TOT:
                ctype default
		pl 0 myddutot (mysspectot) 1101 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # ee only:
                ctype red
		pl 0 myddutot (mysspecee) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # N only:
                ctype blue
		pl 0 myddutot (mysspecN) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                # photon only:
                ctype green
		pl 0 myddutot (mysspecphoton) 1111 (myddutot[0]*.8) (myddutot[dimen(myddutot)-1]*1.2) 1E15 1E34
                #
                #
                #
                #
checkpremonotables  0 #
		#
		# Shouldn't read-in pre-Matlab and monotonized at same time since some similar names for variables
		# Monotonized but still in T-space
		rdmykazmonoeos eosmonodegen.dat
		#
		define WHICHLEV (ntdynorye-4)
		#
		plc 0 (LG(dptot))
		#
		plc 0 (LG(dutot))
		#
		plc 0 (LG(dstot))
		#
		plc 0 (LG(cs2rhoT))
		#
		# See Y_e dependence
		agzplc 0 (LG(dptot))
		#
		agzplc 0 (LG(dutot))
		#
		agzplc 0 (LG(dstot))
		#
		# So far noticed things:
		# 1) dptot and dutot develop feature at 2E9
		# 2) dstot becomes very noisy
		# 3) noisy and truncations appear in ?degenfit, ?offset, ?diff
		#
                set mymmin=INT(mmin[dimen(mmin)-1]/2)
		set myooin=INT(ooin[dimen(ooin)-1]-4)
		set myppin=INT(ppin[dimen(ppin)-1]*0)
		print {mymmin myooin myppin}
		#
                set myuse=((mmin==mymmin && ooin==myooin && ppin==myppin) ? 1 : 0)
                #
                # extract only if myuse is true
                set mydptot = dptot if(myuse)
                set mydutot = dutot if(myuse)
                set mydstot = dstot if(myuse)
                set myrhob = rhob if(myuse)
                #
		#pl 0 mydutot mydstot 1100
		pl 0 mydutot (mydstot/myrhob) 1100
                #
                #
		#
		#
checkposttables 0 #
		####################################
		# read-in post-Matlab tables
		checkeossimplenew
		#
		# So far noticed things:
		# 1) Ss stuff is very noisy
		# 2) dpofchidchi noisy at ye~0.43
		# 3) pofchi has sharp jump around 2E9 for ye~0.43 for all temperatures up to 1E8K
		#
                # New noticed:
                # 1) tkofS poorly resolves temperature near tk=1E9.  Probably degenoffset is too close to bottom and overresolves very low tk.  Should push bottom further down.
                # 2) cs2cgs messed up near nuclear density (AND NOW TOTALLY INVERTED VALUES!)
                # 3) Things are somewhat non-monotonic.   Should monotonize at end as well! Then derivatives not quite right.  Maybe monotonize before derivatives.
                # 4) How to avoid jump-up in tkofU/etc. at high density?  Ruins temperature resolution.  Maybe degen offset is bad?
                #
		# By plotting tkofU,CHI,P,S, one sees how well-resolved temperature is.
		#
		# Ynu=0 and Ye~.43
		define WHICHLEV (ntdynorye-4)
		#
		plc 0 (LG(pofu))
		#
		#
		plc 0 (LG(tkofU))
		#
		plc 0 (LG(tkofP)) 
		#
		plc 0 (LG(tkofCHI)) 
		#
		#
		plc 0 (LG(tkofS))
		#
		#
		plc 0 (LG(cs2cgs))
		#
		#
		# See Y_e dependence
		agzplc 0 (LG(tkofCHI))
		#
                #
                setgrbconsts
                set nb=rhob/mb
                set ssdimenless = ssofchi*rhob*c*c/nb
                plc 0 (LG(ssdimenless))
                #
                #
		#
postdegencheck 0 # degen check
		#
		rdjondegeneos ''
		setupplc nrhob ntdynorye ntdynorynu rhobdegen tdynoryedegen tdynorynudegen
		define x1label "\rho_b"
		define x2label "Y_e"
		#
		plc 0 (LG(utotoffset))
		#
		#
		#
checkeossimplenew 0
		#jre kaz.m
		#cd ~/research/kazeos/run.200sq.1e15tdyn.1em15hcm/
		#rdjoneos eossimplenew.dat
		#
		# new format of eosnew.dat
		#cd ~/research/kazeos/allfixed_200sq_new/
		#cd ~/research/kazeos/4848163.allfixed.new/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
                #cd /u1/ki/jmckinne/research/helm/200x200x1x50/
                #cd /u1/ki/jmckinne/research/helm/100x50x20x50/
                #cd /u1/ki/jmckinne/research/helm/200x200x1x50x1/
		#
		rdjoneos ''
		rdjondegeneos ''
		#
		#set myuse=(sm==115 && sn==105 && so==0 && sp==0) ? 1 : 0
		#set myrhob=rhob if(myuse)
		#set myie=utotdiff if(myuse)
		#set mypofu=pofu if(myuse)
		#print {myrhob myie mypofu}
		#
		#
                setupplc nrhob nutotout ntdynorye rhob utotdiff tdynorye
                #
                #
                #
                set i=0,dimen(rhob)-1,1
		#
		set tti = i%$nx
		set ttj = int(i/$nx)
                set ttk=INT(i/($nx*$ny))
                set ttl=INT(i/($nx*$ny*$nz))
                #
		#set myuse = (sp==46 && so==10) ? 1 : 0
                #set mytemp=tkofU if(myuse)
		#set myu=uofutotdiff if(myuse)
		#set myutotoffset=utotoffset if(sdo==10 && sdp==46)
		#set mysdm=sdm if(sdo==10 && sdp==46)
		#
		#
                #
                #
checkcs0 1      # checkcs0 <whicheos>
                # e.g. checkcs0 0
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "T"
		define x2label "c_s^2/c^2"
		ctype default pl 0 tkofU (cs2cgs/c**2) 1001 1 1E13 -0.1 1.0
		ctype cyan pl 0 tkofU (3.1/3.0-1.0+tkofU*0) 1010
		ctype red pl 0 tkofU (4.0/3.0-1.0+tkofU*0) 1010
		ctype blue pl 0 tkofU (5.0/3.0-1.0+tkofU*0) 1010
		#
checkcs1 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "\rho_b"
		define x2label "c_s^2/c^2"
		ctype default pl 0 rhob (cs2cgs/c**2) 1001 1E2 1E15 -0.1 1.0
		ctype cyan pl 0 rhob (3.1/3.0-1.0+rhob*0) 1010
		ctype red pl 0 rhob (4.0/3.0-1.0+rhob*0) 1010
		ctype blue pl 0 rhob (5.0/3.0-1.0+rhob*0) 1010
		#
		#
checkcs2 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "T"
		define x2label "c_s^2/c^2"
		ctype default pl 0 tkofU dpofchidchi 1000
		set gam=3.1
		set myfun=(gam-1)/gam
		ctype cyan pl 0 tkofU (myfun+tkofU*0) 1010
		set gam=4.0/3.0
		set myfun=(gam-1)/gam
		ctype red pl 0 tkofU (myfun+tkofU*0) 1010
		set gam=5.0/3.0
		set myfun=(gam-1)/gam
		ctype blue pl 0 tkofU (myfun+tkofU*0) 1010
		#
checkcs3 1      #
		define whicheos $1
		if($whicheos==0){\
		       checkeossimplenew
		    }
		if($whicheos==1){\
		           checkeossimplenewhelm
		        }
		        #
		define x1label "\rho_b"
		define x2label "c_s^2/c^2"
		ctype default pl 0 rhob dpofchidchi 1000
		set gam=3.1
		set myfun=(gam-1)/gam
		ctype cyan pl 0 rhob (myfun+rhob*0) 1010
		set gam=4.0/3.0
		set myfun=(gam-1)/gam
		ctype red pl 0 rhob (myfun+rhob*0) 1010
		set gam=5.0/3.0
		set myfun=(gam-1)/gam
		ctype blue pl 0 rhob (myfun+rhob*0) 1010
		#
checknewdiff1 0 #
		ctype default pl 0 utotdiff pofu 1100
		ctype red pl 0 ptotdiff uofp 1110
		ctype blue pl 0 chidiff pofchi 1110
		#
checknewdiff2 0  #
		#
		define x1label "rhob"
		define x2label "utotdiff & utotoffset"
		ctype default pl 0 rhob utotdiff 1100
		ctype blue pl 0 rhobdegen utotoffset 1110
		#
		#
		# notice that utot = utotoffset+utotdiff
		#
		#
		#
checkeossimplenewhelm 0 # checkeossimplenewhelm
		jre kaz.m
		#
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq/
		#cd /u1/ki/jmckinne/research/helm/200x200x1x50/
                #
		rdjoneos ''
		rdjondegeneos ''
		#
		set myuse=(sm==19 && sn==216 && so==0 && sp==0) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myie=ie if(myuse)
		set mypofu=pofu if(myuse)
		#print {myrhob myie mypofu}
		#
		# not a bad value for the interpolation to use
		# 3.255e+09   6.143e+27   2.048e+27
checkbadtemp 0  #
		#
		erase
		set myx=(LG(rhob))
		set myy=(LG(ABS(tkofU)+1E-20))
		limits myx myy
		box
		points myx myy
		#
checkPvsTk   0  #
		erase
		xla "P(U)"
		yla "T[K]"
		set myx=(LG(pofu))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 15 38 1 13
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		#
checkUvsTk   0  #
		erase
		xla "ie"
		yla "T[K]"
		set myx=(LG(utotdiff))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 15 38 1 13
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		#
checkrhobvsTk   0  #
		erase
		ctype default
		xla "\rho"
		yla "T[K]"
		set myx=(LG(rhob))
		set myy=(LG(ABS(tkofU)+1E-30))
		#limits myx myy
		limits 2 14 1 14
		ticksize -1 10 -1 10
		box
		points myx myy
		connect myx myy if(myy>1E-19)
		#
		ctype red
		lweight 5
		# rhob
		set myboxx={1E9 1E9 1E12 1E12 1E9}
		# Tk
		set myboxy={1E8 1E11 1E11 1E8 1E8}
		connect (LG(myboxx)) (LG(myboxy))
		lweight 3
		#
		#
		set dlrho = (15-2)/200
		set dlrho2 = (12-8)/50
		print {dlrho dlrho2}
		#
                #
		#
		#
checkingders 1  # checkingders 'test1'
		#
		checkeossimplenew $1
		#       
		dercalc 0 pofchi pofchid
		#
		set myrhob=rhob if(tj==197)    	
		set myrhobcsq=myrhob*c*c
		set mypofchidx=pofchidx if(tj==197)	
		set mydpofchidrho0=dpofchidrho0 if(tj==197)
		set mypofchi=pofchi if(tj==197) 
		#
		der myrhobcsq mypofchi dmyrhob dmypofchidrhobcsq
		#
		#
		ctype default pl 0 myrhob mydpofchidrho0 1100 
		ctype red pl 0 myrhob (1/4+myrhob*0) 1110  
		ctype blue pl 0 myrhob dmypofchidrhobcsq 1110
		ctype cyan pl 0 myrhob (mypofchi/myrhobcsq) 1110
		#
		#
                ##############################################################################################
		# START MONO CHECKS [Checks monotonicity of pre and post Matlab EOSs]
		#
		#
checktemp2 0    #
		#checkhelmmonoeos 0 0
		#redohelmmono 0 0
		#nonmonosequence2
		#
		# from nonmonosequence2
		# HELM EOS estimate for 10^(10)K:
		# utot=10**27.6193=4.162e+27
		# rhob=2.073e+09
		#
		# dostandard
		# stellar model
		# print {r rhob utot ptot temp} 
		# utot,ptot come from stellar HELM EOS for given rhob,temp
		# 1.047e+06   3.616e+09   6.512e+27   2.424e+27    8.12e+09
		#
		#ctype default pl 0 rorlold ucgs 1100
		#
		#print {rorlold rhocgs ucgs pcgs tempk}
		#0.1631   3.616e+09   6.512e+27   4.337e+27           0
		#
		#
		#
		#
checktemp3    0 #  # uses post-Matlab EOS tables
		checkhelmeos 0 0
		nonmonosequence2
		ctype cyan pl 0 tempk (6.512e+27+tempk*0) 1110
		ctype cyan vertline (LG(8.12e+09))
		#
		#
checktemp4 0	#
		redohelmmono 0 0
		#redohelm
		set god=INT((nrhob/2+nrhob/13))
		set god=115
		set god2=rhob[god]
		print {god god2}
		#
		# from stellar model:
		set therhob=3.616e+09
		set thetemp=8.12e+09
		#set theutot=6.512e+27
		set theutot=6.567e+27
		# FROM 1 point in jonhelm: utot=6.567495770363091E+27
		# FROM 1 point in jonhelmstellar: utot=6.567495770363091E+27
		#
		set codeudegen=8211210.0*Pressureunit
		print {therhob thetemp theutot codeudegen}
		print {therhob codeudegen}
		#
		# FROM HELM EOS MONOTONIZED
		set mymm=115
		set myutot1=utot if(mm==mymm)
		set mytempk1=tempk if(mm==mymm)
		set myrhob1=rhob if(mm==mymm && nn==0 && ll==0 && pp==0)
		set utotdegen1=udegenfit if(mm==mymm && nn==0 && ll==0 && pp==0)
		print {myrhob1 utotdegen1}
		#
		#ctype default pl 0 mytempk1 myutot1 1100
		#ctype default pl 0 mytempk1 myutot1 1101 1E9 1E11 1E27 1E28
		define x1label "T"
		define x2label "utot"
		ctype default pl 0 mytempk1 myutot1 1101 1E4 1E11 1E27 1E29
		points (LG(mytempk1)) (LG(myutot1))
		#
		set mymm=116
		set myutot2=utot if(mm==mymm)
		set mytempk2=tempk if(mm==mymm)
		set myrhob2=rhob if(mm==mymm && nn==0 && ll==0 && pp==0)
		set utotdegen2=udegenfit if(mm==mymm && nn==0 && ll==0 && pp==0)
		print {myrhob2 utotdegen2}
		#
		ctype red pl 0 mytempk2 myutot2 1110
		points (LG(mytempk2)) (LG(myutot2))
		#
		# overlay utot value from stellar model (i.e. initial data)
		ctype cyan pl 0 mytempk1 (theutot+mytempk1*0) 1110
		ctype cyan vertline (LG(thetemp))
		points (LG(thetemp)) (LG(theutot))
		#
		ctype green pl 0 mytempk1 (codeudegen+mytempk1*0) 1110
		#
		ctype blue pl 0 mytempk1 (utotdegen1+mytempk1*0) 1110
		ctype blue pl 0 mytempk2 (utotdegen2+mytempk2*0) 1110
		#
		#
checkmononew0 0 # notice that ptot is not single-valued function of utot even for original kaz EOS
		#redokaz
		#redokazmono
		# seems helm EOS is single-valued in sensitive regions
		#redohelm
		redohelmmono 0 0
		#set mymm=115
		set mymm=151
		set myptot=ptot if(mm==mymm)
		set myutot=utot if(mm==mymm)
		set mychi=chi if(mm==mymm)
		#
		ctype default
		define x1label "u_{tot}"
		define x2label "p_{tot}"
		pl 0 myutot myptot 1100
		#
		#print {myutot myptot}
checkmononew1 0 #
		#
		#print {mychi myutot}
		define x1label "\chi"
		define x2label "u_{tot}"
		ctype default pl 0 mychi myutot 1101 1E31 1.5E31 5.0E30 1E31
		ctype red points (LG(mychi)) (LG(myutot))
		#
checkmononew2 0 #
		#
		#print {mychi myptot}
		define x1label "\chi"
		define x2label "u_{tot}"
		ctype default pl 0 mychi myptot 1101 1E31 1.5E31 2.0E30 1E31
		ctype red points (LG(mychi)) (LG(myptot))
		#
checketaenew0 2	# 
		#redokaz
		#redokazmono
		set mykaznn=$1
		set myhelmnn=$1
		#set mykaznn=140
		#set myhelmnn=0+140
		#
		if($1==0){\
		       # picking density point
		       set mypickvar=mm
		       set mypick=$2
		    }
		if($1==1){\
		           # picking temperature point
		       set mypickvar=nn
		       set mypick=$2
		    }
		#
		#
		# seems helm EOS is single-valued in sensitive regions
		redohelm
		#redohelmmono 0 0
		set helmyefree=1/(1+npratio)
		#
		set myhelmrhob=rhob if(mypickvar==mypick)
		set myhelmptot=ptot if(mypickvar==mypick)
		set myhelmutot=utot if(mypickvar==mypick)
		set myhelmchi=chi if(mypickvar==mypick)
		set myhelmetae=etae-me*c*c/(kb*tempk) if(mypickvar==mypick)
		set myhelmtempk=tempk if(mypickvar==mypick)
		degenpar
		set myhelmrelfact=relfact if(mypickvar==mypick)
		set myhelmreldegen=reldegen if(mypickvar==mypick)
		set myhelmnonreldegen=nonreldegen if(mypickvar==mypick)
		set myhelmnpratio=npratio if(mypickvar==mypick)
		set myhelmyefree=(1/(1+npratio)) if(mypickvar==mypick)
		set myhelmyetot=yetot if(mypickvar==mypick)
		set myhelmxnuc=xnuc if(mypickvar==mypick)
		#print {myhelmtempk myhelmrelfact myhelmreldegen myhelmnonreldegen}
		#print {myhelmtempk}
		#
		#redokazmono
		redokaz
		set kazyefree=1/(1+npratio)
		#
		set mykazrhob=rhob if(mypickvar==mypick)
		set mykazptot=ptot if(mypickvar==mypick)
		set mykazutot=utot if(mypickvar==mypick)
		set mykazchi=chi if(mypickvar==mypick)
		set mykazetae=etae-me*c*c/(kb*tempk) if(mypickvar==mypick)
		set mykaztempk=tempk if(mypickvar==mypick)
		degenpar
		set mykazrelfact=relfact if(mypickvar==mypick)
		set mykazreldegen=reldegen if(mypickvar==mypick)
		set mykaznonreldegen=nonreldegen if(mypickvar==mypick)
		set mykaznpratio=npratio if(mypickvar==mypick)
		set mykazyefree=(1/(1+npratio)) if(mypickvar==mypick)
		set mykazxnuc=xnuc if(mypickvar==mypick)
		#print {mykaztempk myhelmrelfact mykazreldegen mykaznonreldegen}
		#print {mykaztempk}
		#
		#
		#
		ctype default
		define x2label "\eta_e"
		if($1==0){\
		       define x1label "T[K]"
		       # picking density point
		       ctype default pl 0 myhelmtempk myhelmetae 1100
		       ctype red pl 0 mykaztempk mykazetae 1110
		    }
		if($1==1){\
		           define x1label "\rho_b"
		       # picking temperature point
		       ctype default pl 0 myhelmrhob myhelmetae 1100
		       ctype red pl 0 mykazrhob mykazetae 1110
		    }
		#
		#print {myutot myptot}
		#
plreldegen      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "reldegen"
		ctype default pl 0 myhelmrhob myhelmreldegen 1100
		ctype red pl 0 mykazrhob mykazreldegen 1110
		#
plnonreldegen      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "nonreldegen"
		ctype default pl 0 myhelmrhob myhelmnonreldegen 1100
		ctype red pl 0 mykazrhob mykaznonreldegen 1110
		#
plrelfact      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "relfact"
		ctype default pl 0 myhelmrhob myhelmrelfact 1100
		ctype red pl 0 mykazrhob mykazrelfact 1110
		#
plnpratio      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "npratio"
		ctype default pl 0 myhelmrhob myhelmnpratio 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykaznpratio 1110
plyefree      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "yefree"
		ctype default pl 0 myhelmrhob myhelmyefree 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykazyefree 1110
		ctype blue pl 0 myhelmrhob myhelmyetot 1110
		#
degenpar 0      #
		set relfact=(kb*tempk/(me*c**2))
		#
		set mue=2
		set ne = (rhob/(mue*mp))
		set reldegen = ne/(2*(kb*tempk/(hbar*c))**3/(pi**2))
		set nonreldegen = ne/(2*(me*kb*tempk/(2*pi*hbar**2)))**(3/2)
		#
plxnuc      0 #
		ctype default
		define x1label "\rho_b"
		define x2label "xnuc"
		ctype default pl 0 myhelmrhob myhelmxnuc 1101 1E8 1E15 1E-5 1E5
		ctype red pl 0 mykazrhob mykazxnuc 1110
		#
checkrdkaz 0    #
		#
		#
		# let's look in run.200sq.1e15tdyn.1em15hcm:
		# do: less -S -# 5 -N eos.dat
		# let's read in eos.dat into SM:
		jre kaz.m
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/run.200sq.1e15tdyn.1em15hcm/
		# stays high:
		#set utotfix=1
		#cd ~/research/kazeos/eoslarge_corrxnuc_tkcolumn/
		# stays high:
		#set utotfix=1
		#cd ~/research/kazeos/eoslarge_oldxnuc/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/etaefixed_200sq/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/allfixed_200sq_new/
		# goes low:
		#set utotfix=0
		#cd ~/research/kazeos/run.4848163/
		#
		#set utotfix=0
		#cd ~/research/kazeos/kaz_allfixed_changemuektrestmass_200sq/
		#
		#set utotfix=0
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		#
		set utotfix=0
		cd ~/research/kazeos/kaz_allfixed_ye.5_200sq/
		#
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set pkaz_eleposi=p_eleposi
		set ukaz_eleposi=rho_eleposi
		#
checkrdkazmono 0    #
		#
		#
		jre kaz.m
		set utotfix=0
		#cd ~/research/kazeos/allfixed_200sq_new/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		#cd ~/research/kazeos/kaz_allfixed_tdynsmall_200sq/
		cd ~/research/kazeos/kaz_newdist_rnp1_200sq
		#
		#
		rdmykazmonoeos eosmonodegen.dat
		rdmykazeosother eosother.dat
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set pkaz_eleposi=p_eleposi
		set ukaz_eleposi=rho_eleposi
		#
checkrdhelmmono 0    #
		#
		#
		#jre kaz.m
		set utotfix=0
		#cd ~/research/helm/helm_mutot_linearmutot_yefit/
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq
		#cd ~/research/helm/200x200x1x50/
		#
		rdmykazmonoeos eosmonodegen.dat
		rdmykazeos eos.dat
		rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
checkrdhelmmono2 0    #
		#
		#
		jre kaz.m
		set utotfix=0
		#
		#cd ~/research/helm/helm_mutot_linearmutot_yefit/
		#cd ~/research/helm/helm_mutot_linearmutot_yefit_200sq
		#cd ~/research/helm/200x200x1x50/
		#
		rdmykazmonoeos eosmonodegen.dat
		#rdmykazeosother eosother.dat
		#rdhelmcou eoscoulomb.dat
		#rdhelmextra eosazbar.dat
		#
		if(utotfix==1){ set utot=utot-rhob*c**2 }
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
		#
checkrdhelm 0   #
		#
		# let's look in helm/helm_mutot_yefit
		# do: less -S -# 5 -N eos.dat
		# let's read in eos.dat into SM:
		#jre kaz.m
                #
                #
		#cd ~/research/helm/200x200x1x50/
		#
		rdmykazeos eos.dat
                rdmykazeosother eosother.dat
		rdhelmcou eoscoulomb.dat
		rdhelmextra eosazbar.dat
		#
		set phelm_eleposi=p_eleposi
		set uhelm_eleposi=rho_eleposi
		#
setfixedeos 2   #
		checkrdkaz
		set utotfinal=utot-ukaz_eleposi
		set ptotfinal=ptot-pkaz_eleposi
		checkrdhelm
		set utotfinal=utotfinal+uhelm_eleposi
		set ptotfinal=ptotfinal+phelm_eleposi
		set utot=utotfinal
		set ptot=ptotfinal
		#
		checkanyeos $1 $2
		#
checkkazeos 2   #
		checkrdkaz
		checkanyeos $1 $2
		#
checkkazmonoeos 2   #
		checkrdkazmono
		checkanyeos $1 $2
		#
checkhelmmonoeos 2 # check monotonicity of pre-Matlab EOS
		# checkhelmmonoeos <0/1> <0/1/2>
		checkrdhelmmono
		checkanyeos $1 $2
		#
checkhelmmonoeos2 2	#
		checkrdhelmmono2
		checkanyeos $1 $2
		#
checkhelmeos 2  #
		checkrdhelm
		checkanyeos $1 $2
		#
nonmonocheck0 0  #
		# should make this consistent with nonmonocheck2
		set myuse=(rhob>1E10 && rhob<1.1E10 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		#define x2label "\rho_{ep}"
		#set whichfun=rho_eleposi
		#define x2label "p_{ep}"
                define x2label "chosenfun"
                # set whichfun=p_eleposi
		set mychosenfun=chosenfun if(myuse)
		#set mychosenfun=rho_N-rhob*C**2 if(myuse)
		#set mychosenfun=rho_nu if(myuse)
		#set mychosenfun=rho_photon if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		pl 0 mytempk mychosenfun 1101 1E5 1E13 1E10 1E40
		points (LG(mytempk)) (LG(mychosenfun))
		#
nonmonocheck02 1  #
		# should make this consistent with nonmonocheck22
		set myuse=(mm==$1 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		#
		# assume checkhelmeos or checkkazeos sets whichfun
		set mychosenfun=chosenfun if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		pl 0 mytempk mychosenfun 1101 1E5 1E13 1E10 1E40
		points (LG(mytempk)) (LG(mychosenfun))
		# below assumes rhob associated with fastest index
		set temprhob=rhob[$1]
		print {temprhob}
                #
nonmonocheck22  1  # Check a given rho(mm), Ye=0, Ynu=0, Tk-dependent monotonicity
		set myuse=(mm==$1 && oo==0 && pp==0) ? 1 : 0
		set mytempk=tempk if(myuse)
		set mychosenfun=chosenfun if(myuse)
		#
		#ctype default
		define x1label "T[K]"
		#define x2label "\rho_{ep}"
		pl 0 mytempk mychosenfun 1111 1E5 1E13 1E10 1E40
		# below assumes rhob associated with fastest index
		set temprhob=rhob[$1]
		print {temprhob}
		#
		#
nonmonosequence 0 #
		ctype default
		nonmonocheck0
		plotnonmono1
		ctype default
		nonmonocheck2 1E2 1.15E2
		plotnonmono1
		ctype default
		nonmonocheck2 1E3 1.15E3
		plotnonmono1
		ctype default
		nonmonocheck2 1E4 1.15E4
		plotnonmono1
		ctype default
		nonmonocheck2 1E5 1.15E5
		plotnonmono1
		ctype default
		nonmonocheck2 1E6 1.15E6
		plotnonmono1
		ctype default
		nonmonocheck2 1E7 1.15E7
		plotnonmono1
		ctype default
		nonmonocheck2 1E8 1.15E8
		plotnonmono1
		ctype default
		nonmonocheck2 1E9 1.15E9
		plotnonmono1
		ctype default
		nonmonocheck2 1E10 1.15E10
		plotnonmono1
		ctype default
		nonmonocheck2 1E11 1.15E11
		plotnonmono1
		ctype default
		nonmonocheck2 1E12 1.15E12
		plotnonmono1
		ctype default
		nonmonocheck2 1E13 1.15E13
		plotnonmono1
		ctype default
		nonmonocheck2 1E14 1.15E14
		plotnonmono1
		ctype default
		nonmonocheck2 1E15 1.15E15
		plotnonmono1
		#
nonmonosequence2 0 #
		ctype default
		nonmonocheck02 (INT(nrhob/14)*0)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*1)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*2)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*3)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*4)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*5)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*6)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*7)
		plotnonmono1
		#
		ctype default
		nonmonocheck22 (INT(nrhob/14)*8)
		plotnonmono1
		#
		#
		#ctype default
		#nonmonocheck22 (nrhob/2+nrhob/20)
		#plotnonmono1
		#
		#
		ctype default
		set god=INT((nrhob/2+nrhob/13))
		nonmonocheck22 god
		plotnonmono1
		#
		ctype default
		nonmonocheck22 (INT(nrhob/14)*9)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*10)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*11)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*12)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*13)
		plotnonmono1
		ctype default
		nonmonocheck22 (INT(nrhob/14)*14)
		plotnonmono1
		#
nonmonocheck1 0  #
		# call nonmonocheck0 first
		der mytempk mychosenfun dmytempk dmychosenfun
		#
		set rat=(dmychosenfun/mychosenfun)
		#
		set mydmytempk=dmytempk if(rat>0)
		set myrat=rat if(rat>0)
		set mydmytempk2=dmytempk if(rat<=0)
		set myrat2=rat if(rat<=0)
		#
plotnonmono1  0  #
		# just did this in prior macro: pl 0 mytempk mychosenfun 1111 1E5 1E13 1E10 1E40
		nonmonocheck1
		set myyo=mychosenfun if(dmychosenfun<0)
		set myxo=mytempk if(dmychosenfun<0)
		ctype red pl 0 myxo myyo 1111 1E5 1E13 1E10 1E40
		ctype red points (LG(myxo)) (LG(myyo))
		#
nonmonocheck1plot 0  #
		ctype red
		pl 0 mydmytempk myrat 1100
		ctype blue
		pl 0 mydmytempk2 myrat2 1110
		#
checkanyeos 2   # checkanyeos <0/1> <0/1/2>
		#
		#
                if($1==0){ set TEMPLIMIT =1.01E4 }
                if($1==1){ set TEMPLIMIT =5E12 }
		#
		# 0 = utot
		# 1 = ptot
		# 2 = chi
		define whichfun $2
		#
		#
		#
		#
		jre grbmodel.m
		setgrbconsts
		# approximately
		set temp=tempk
		setyefit
		#
		#
		#
		#ctype default pl 0 rhob dutot 1100
		ctype default
		erase
		#
		if($whichfun==0){\
		       set chosenfun=dutot
		    }
		if($whichfun==1){\
		       set chosenfun=dptot
		    }
		if($whichfun==2){\
		       set chosenfun=dchi
		    }
		#
		#limits (LG(rhob)) (LG(chosenfun))
		limits (LG(rhob)) 0 40
		erase
		box
		xla "\rho"
		if($whichfun==0){\
		       define x2label "u_{tot}"
		    }
		if($whichfun==1){\
		           define x2label "p_{tot}"
		        }
		#
		if($whichfun==2){\
		           define x2label "\chi"
		        }
		#
		yla $x2label
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set mychosenfun=chosenfun if(myuse)
		set myutot=dutot if(myuse)
		set myptot=dptot if(myuse)
		set mychi=dchi if(myuse)
		#
		if(dimen(mychi)==0){\
		       echo "If no elements, TEMPLIMIT too small"
		}
		#
		ctype default points (LG(myrhob)) (LG(mychosenfun))
		#
		rhobutotpoint
		#
		#
		# plot degen overlay here so uses larger Kaz-EOS span of rhob and tempk
		if($whichfun==0){\
		       plotdegenoverlay
		    }
		#
		#
		#
		#
setfitskaz 0    # Old way of setting degeneracy line
		#
		# plot u_tot - u_degen to see spread in temperature
		#set udegenfit=1.5163*K*((rhob+3E6)*yefit)**(1/3)*rhob
		#set udegenfit=1.51663*K*((rhob+3.7E6)*yefit)**(1/3)*rhob
		#set udegenfit=1.51663*K*((rhob+4.6E6)*yefit)**(0.9999/3)*rhob**(1.0)
		# try log with break
		set npow=1.95
		set udegenfit1=1.516*K*((rhob+0.0E6))**(4.0/3)* yefit**(1.0/3)
		#set udegenfit1=0
		set udegenfit2=1.66*1E2*1.516*K*((rhob+0.0E6))**(1.0)* yefit**(1.0/3)
		#set udegenfit2=0
		#set udegenfit = (1.0/(1.0/udegenfit1**npow+1.0/udegenfit2**npow))**(1/npow)
		set udegenfit = (udegenfit1**npow + udegenfit2**npow)**(1/npow)
		#
		#
		# below not set good fit
		#set pdegenfit1=(3.0335*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=(0.028*K*((rhob+0E6)*yefit)**(1.94/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set npow=1.95
		#
		# below best fit so far for ptot
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		# print '%21.15g %21.15g %21.15g\n' {mydiffptot myrhob pdegenfit1} 
		set pdegenfit1=(K*((rhob+0E6)*yefit)**(1.0001/3)*rhob)*(4.0/3.0-1.0)*yefit
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		set usepdegenfit1=pdegenfit1 if(myuse)
		set ii=1,dimen(usepdegenfit1)
		set P0 = 4.93066895509393e+34
		set P1 = usepdegenfit1[199]
		set pdegenfit1=P0*pdegenfit1/P1
		#set pdegenfit1=0
		#
		set pdegenfit2=(K*((rhob+0E6)*yefit)**(1.5/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=0
		set usepdegenfit2=pdegenfit2 if(myuse)
		set ii=1,dimen(usepdegenfit2)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit2[31]
		set pdegenfit2=P0*pdegenfit2/P1
		#
		set pdegenfit3=(K*((rhob+0E6)*yefit)**(2.0/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit3=0
		set usepdegenfit3=pdegenfit3 if(myuse)
		set ii=1,dimen(usepdegenfit3)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit3[31]
		set pdegenfit3=P0*pdegenfit3/P1
		#
		set npow=3.0
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow+1.0/pdegenfit3**npow))**(1/npow)
		#set pdegenfit = pdegenfit1
		#
		# from SM:
		#       below best fit so far for ptot
		set pdegenfit1=(3.0310*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		set pdegenfit2=(0.0235*K*((rhob+0E6)*yefit)**(2.00/3)*rhob)*(4.0/3.0-1.0)*yefit
 		set npow=1.94
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow))**(1/npow)
		#
		#
		#
redohelmkaz 2   # 
		jre phivsr.m
		checkhelmeos $1 $2
		#
		setfixedeos
		#
		setgennumfits
		#
		# functional fits
		#setfitshelmkaz
		#
		showdegendiff
		#
redokazmono 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkkazmonoeos $1 $2
		showdegendiff
		#
redohelmmono 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkhelmmonoeos $1 $2
		#
		#setgennumfits
		# test of how good matlab degen is
		#setdegenoffset
		#
		#
		showdegendiff
		#
redohelmmono2 2   #  eos_extract.m produced temporary output of stuff vs. T
		#  read-in processed table and show eos values
		#  also show difference between tot and degenfit (=totdiff)
		checkhelmmonoeos2 $1 $2
		#
		# test of how good mathlab degen is
		#setgennumfits
		#
		#
		showdegendiff
		#
redokaz 2   # 
		#jre phivsr.m
		checkkazeos $1 $2
		#
		# numerical fits
		setgennumfits
		#
		# functional fits
		#setfitskaz
		#
		showdegendiff
		#
		#
redohelm 2   # 
		#jre phivsr.m
		checkhelmeos $1 $2
		#
		# numerical fits
		setgennumfits
		#
		# functional fits
		#setfitshelm
		#
		showdegendiff
		#
setdegenoffset  0 #
		# NOT RIGHT: If want to use Matlab generated degeneracy line with pre-Matlab data based upon Temperature
		# then since T is not slowest index, can't just concat like below
		#
		set numcats = dimen(dutot)/dimen(utotoffset)
		#
                set utotoffset0 = utotoffset
                set ptotoffset0 = ptotoffset
                set chioffset0 = chioffset
		#
                set utotoffset1 = utotoffset
                set ptotoffset1 = ptotoffset
                set chioffset1 = chioffset
		#
		do kk=0,numcats-2,1{
		   set utotoffset1 = utotoffset1 CONCAT utotoffset0
		   set ptotoffset1 = ptotoffset1 CONCAT ptotoffset0
		   set chioffset1 = chioffset1 CONCAT chioffset0
		}
		#
		#
setgennumfits 0 #
		# try using numerical fit
		#
		# get lowest temperature utot vs rhob
		#
		# works for Kaz except known problem area (higher temp dip near 1E11K)
		set A0 = 0.999
		# HELM (best can be done due to some non-monotonic stuff at higher temp)
		#set A0 = 0.96
		#
                #
                #
		set udegenfit = dutot if(nn==0 && oo==0 && pp==0)
		set pdegenfit = dptot if(nn==0 && oo==0 && pp==0)
		set chidegenfit = udegenfit+pdegenfit
                #
                set utotoffset0 = udegenfit - abs(udegenfit)*(1-A0)
                set ptotoffset0 = pdegenfit - abs(pdegenfit)*(1-A0)
		set chioffset0 = utotoffset0 + ptotoffset0
                #
		set myusenum=SUM(myuse)
		set numcats=myusenum/dimen(utotoffset0)
		#
		# actually just need to make it as big as normal arrays
		#
		set numcats = dimen(myuse)/dimen(utotoffset0)
		#
		# concat until as long as myuse selection method
		set utotoffset1=utotoffset0
		set ptotoffset1=ptotoffset0
		set chioffset1=chioffset0
		do kk=0,numcats-2,1{
		   set utotoffset1 = utotoffset1 CONCAT utotoffset0
		   set ptotoffset1 = ptotoffset1 CONCAT ptotoffset0
		   set chioffset1 = chioffset1 CONCAT chioffset0
		}
		#
		#
		#
setfitshelmkaz 0    # old way of checking degeneracy line
		# try log with break
		set npow=1.95
		set udegenfit1=0.73*K*((rhob+0.0E6))**(4.065/3)* yefit**(1.0/3)
		#set udegenfit1=1E50
		#set udegenfit2=.0061*K*((rhob+0.0E6))**(4.9/3.0)* yefit**(1.0/3)
		set udegenfit2=1E50
		set udegenfit = (1.0/(1.0/udegenfit1**npow+1.0/udegenfit2**npow))**(1/npow)
		#set udegenfit = (udegenfit1**npow + udegenfit2**npow)**(1/npow)
		#
		#
		# below not set good fit
		#set pdegenfit1=(3.0335*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=(0.028*K*((rhob+0E6)*yefit)**(1.94/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set npow=1.95
		#
		# below best fit so far for ptot
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		# print '%21.15g %21.15g %21.15g\n' {mydiffptot myrhob pdegenfit1} 
		set pdegenfit1=(K*((rhob+0E6)*yefit)**(1.0001/3)*rhob)*(4.0/3.0-1.0)*yefit
		# even if myuse grabs multiple lines, first 200 points are lowest temperature
		set usepdegenfit1=pdegenfit1 if(myuse)
		set ii=1,dimen(usepdegenfit1)
		set P0 = 4.93066895509393e+34
		set P1 = usepdegenfit1[199]
		set pdegenfit1=P0*pdegenfit1/P1
		#set pdegenfit1=0
		#
		set pdegenfit2=(K*((rhob+0E6)*yefit)**(1.5/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit2=0
		set usepdegenfit2=pdegenfit2 if(myuse)
		set ii=1,dimen(usepdegenfit2)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit2[31]
		set pdegenfit2=P0*pdegenfit2/P1
		#
		set pdegenfit3=(K*((rhob+0E6)*yefit)**(2.0/3)*rhob)*(4.0/3.0-1.0)*yefit
		#set pdegenfit3=0
		set usepdegenfit3=pdegenfit3 if(myuse)
		set ii=1,dimen(usepdegenfit3)
		# around rhob=1E4
		#print {rhob ptot ii}
		set P0 = 1.606e+19
		set P1 = usepdegenfit3[31]
		set pdegenfit3=P0*pdegenfit3/P1
		#
		set npow=3.0
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow+1.0/pdegenfit3**npow))**(1/npow)
		#set pdegenfit = pdegenfit1
		#
		# from SM:
		#       below best fit so far for ptot
		set pdegenfit1=(3.0310*K*((rhob+0E6)*yefit)**(1/3)*rhob)*(4.0/3.0-1.0)*yefit
		set pdegenfit2=(0.0235*K*((rhob+0E6)*yefit)**(2.00/3)*rhob)*(4.0/3.0-1.0)*yefit
 		set npow=1.94
		set pdegenfit = (1.0/(1.0/pdegenfit1**npow+1.0/pdegenfit2**npow))**(1/npow)
		#
showdegendiff 0 #
		#
		if($whichfun==0){\
		       set myudegenfit=utotoffset1 if(myuse)
		       ctype magenta points (LG(myrhob)) (LG(myudegenfit))
		       set diffutot = dutot-utotoffset1
		       set mydiffutot = diffutot if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffutot))
		       ctype red points (LG(myrhob)) (LG(-mydiffutot))
		       #
		       #set myelerestmass = me*c*c*rhob/mb*zbar/abar if(myuse)
                       #ctype blue points (LG(myrhob)) (LG(myelerestmass))
		       #ctype blue points (LG(myrhob)) (LG(2.0*myelerestmass))
                                 
		    }
		#
		if($whichfun==1){\
		       set mypdegenfit=ptotoffset1 if(myuse)
		       ctype magenta points (LG(myrhob)) (LG(mypdegenfit))
		       set diffptot = dptot-ptotoffset1
		       set mydiffptot = diffptot if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffptot))
		       ctype red points (LG(myrhob)) (LG(-mydiffptot))
		    }
		#
		#
		if($whichfun==2){\
		       set mychidegenfit=chioffset1 if(myuse)
		       #
		       ctype magenta points (LG(myrhob)) (LG(mychidegenfit))
		       set diffchi = dchi-chioffset1
		       set mydiffchi = diffchi if(myuse)
		       ctype cyan points (LG(myrhob)) (LG(mydiffchi))
		       ctype red points (LG(myrhob)) (LG(-mydiffchi))
		    }
		#
		#
rhobutotpoint 0 #
		set rhobpoint=3.5E9+0*myrhob
		ctype red connect (LG(rhobpoint)) (LG(myutot))
		#
		set utotpoint=5.95E27+0*myrhob
		ctype red connect (LG(myrhob)) (LG(utotpoint))
		#
		#
		#
checkkazetae 0  #
		checkrdkaz
		#
		erase
		ticksize -1 10 -1 10
		#
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myetae=etae if(myuse)
		#
		ctype default
		limits (LG(rhob)) (LG(etae))
		erase
		box
		xla "\rho"
		yla "\eta_e"
		ctype default points (LG(myrhob)) (LG(myetae))
		#
checkkazetae2 0  #
		checkrdkaz
		#
		erase	
		ticksize -1 10 -1 10
		#
		set myuse=(rhob>9.7E11 && rhob<1.2E12) ? 1 : 0
		#set myuse=(rhob>1E4 && rhob<3E4) ? 1 : 0
		set mytempk=tempk if(myuse)
		set myetae=etae if(myuse)
		#
		ctype default
		#
		#limits (LG(tempk)) (LG(etae))
		limits (LG(tempk)) -15 15
		erase
		box
		xla "T"
		yla "\eta_e"
		ctype default points (LG(mytempk)) (LG(myetae))
		#
checkhelmetae 0 #
		checkrdhelm
		#erase
		#
		set myuse=(tempk<TEMPLIMIT) ? 1 : 0
		set myrhob=rhob if(myuse)
		set myetae=etae if(myuse)
		#
		#limits (LG(myrhob)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		ctype blue points (LG(myrhob)) (LG(myetae))
		#
checkhelmetae2 0 #
		checkrdhelm
		#erase
		#
		set myuse=(rhob>9.7E11 && rhob<1.2E12) ? 1 : 0
		#set myuse=(rhob>1E4 && rhob<3E4) ? 1 : 0
		set mytempk=tempk if(myuse)
		set myetae=etae if(myuse)
		#
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		ctype blue points (LG(mytempk)) (LG(myetae))
		#
overlayetaes 2  # checking etae from kaz and other EOSs
		#
		checketaenew0 $1 $2
		checkmyetae $1 $2
		#
		#
checkmyetae 2 # checking etae from kaz and other EOSs
		set oldmyetae=myetae
		#
		#erase
		#
		#
		#set myuse=(tempk<TEMPLIMIT) ? 1 : 0
 		if($1==0){\
		       # pick density point
		       set myuse=(mm==$2) ? 1 : 0
		    }
 		if($1==1){\
		       # pick temp point
		       set myuse=(nn==$2) ? 1 : 0
		    }
		set myrhob=rhob if(myuse)
		set mytempk=tempk if(myuse)
		#
		if($1==0){\
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		#ctype red points (LG(myrhob)) (LG(myetae))
		#
		# works for rhob=1E12
		#set myfitetae=10**6.66764*(tempk/10**5.01258)**(-1)
		# works for rhob=2E4
		#set myfitetae=10**6.66764*(2.2/.03*tempk/10**5.01258)**(-1)
		computefitetae
		computemyetae
		#
		ctype green points (LG(mytempk)) (LG(myfitetaechop))
		ctype blue points (LG(mytempk)) (LG(mycomputedetae))
		#
		}
		#
		if($1==1){\
		#limits (LG(mytempk)) (LG(etae))
		#erase
		#box
		#xla "\rho"
		#yla "\eta_e"
		#ctype red points (LG(myrhob)) (LG(myetae))
		#
		# works for rhob=1E12
		#set myfitetae=10**6.66764*(tempk/10**5.01258)**(-1)
		# works for rhob=2E4
		#set myfitetae=10**6.66764*(2.2/.03*tempk/10**5.01258)**(-1)
		computefitetae
		computemyetae
		#
		ctype green points (LG(myrhob)) (LG(myfitetaechop))
		ctype blue points (LG(myrhob)) (LG(mycomputedetae))
		#
		set np=myrhob/mp
		set km02fit=(3*pi**2*np)**(1/3)*hbar*c/(kb*mytempk)
		ctype cyan points (LG(myrhob)) (LG(km02fit))
		#
		set np=myrhob/mp
		set km02fit=(3*pi**2*np)**(1/3)*hbar*c/(kb*mytempk)
		ctype magenta points (LG(myrhob)) (LG(km02fit))
		#
		}
		#set rat=oldmyetae/myetae
		#
plotrat 0       #
		ctype default
		pl 0 mytempk rat 1000
		#
computefitetae 0  #checking etae from kaz and other EOSs
		set myn = (LG(4.5)-LG(2.2/.03))/(10.2039-6.5629)
		#set myA = (rhob<10**6.5629) ? 2.2/.03 : (rhob>10**10.2039) ? 1.0 : 2.2/.03*(rhob/10**6.5629)**myn
		set myA = (rhob<10**6.5629) ? 2.2/.03 : 2.2/.03*(rhob/10**6.5629)**myn
		set myfitetae=10**6.66764*(myA*tempk/10**5.01258)**(-1)
		#
		set myfitetaechop=myfitetae if(myuse)
		#
computemyetae 0        #checking etae from kaz and other EOSs
		#set T=tempk*2.2
		set T=tempk
		#set T=tempk*.03
		set E=exp(1.0)
		#
		set rhosick=rhob
		set A=1.9892646415649775e7
		set B=5.00266040170966e9
		set log1=B/T + LN(A*rhosick**(1/3)/T)
		#set log1=(log1>1E-30) ? log1 : 1E-30
		#
		#set log2 = LN((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)
		set log2=B/T + LN(rhosick**(1/3)/T)
		#
		#set computedetae=(3.*log1**4 - \
		#    3.*(15.805860694551079 + log2)*(1. + log1**2)*LN(log1) + \
		#    (20.70879104182662 + 1.5*log4)* LN(log1)**2 + \
		#    LN(log1)**3)/ \
		#    log1**3
		#
		#   
		#
		set computedetae=3.*log1 - (47.41758208365324*LN(log1))/log1**3 - (47.41758208365324*LN(log1))/log1 - \
		 (3.*log2*LN(log1))/log1**3 - (3.*log2*LN(log1))/log1 + (20.70879104182662*LN(log1)**2)/log1**3 + \
		 (1.5*log2*LN(log1)**2)/log1**3 + (1.*LN(log1)**3)/log1**3
		 #
		#
		#  
		#
		# (3.*Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**4 - 
		#-    3.*(15.805860694551079 + Log((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))*
		#-     (1. + Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**2)*
		#-     Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)) + 
		#-    (20.70879104182662 + 1.5*Log((E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))*
		#-     Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))**2 + 
		#-    1.*Log(Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T))**3)/
		#-  Log((1.9892646415649775e7*E**(5.00266040170966e9/T)*rhosick**0.3333333333333333)/T)**3
		#
		set mycomputedetae=computedetae if(myuse)
		#
plotdegenoverlay 0 #
		# PWF99 with my Y_e
		set udegenpwf99myye=3.0*K*(rhob*yefit)**(1/3)*rhob
		# apparently what HELM EOS gives
		set udegenhelm=1.6*K*(rhob*yefit)**(1/3)*rhob
		# pure PWF99
		set udegenpurepwf99=3.0*K*(rhob*0.5)**(1/3)*rhob
		#
		#ctype cyan points (LG(rhob)) (LG(udegenpwf99myye))
		ctype green points (LG(rhob)) (LG(udegenhelm))
		#ctype magenta points (LG(rhob)) (LG(udegenpurepwf99))
		#
		#
checkhelmcs0  0 #
		redohelmmono
		# HELM's output
		ctype default pl 0 tempk cs2helm 1100
		# MY OUTPUT (should be same if rhob,T,utot,ptot same)
		ctype red pl 0 tempk cs2rhoT 1110
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#
		#xnut,xprot,xalfa,xh,a,x
		#
		#
		#
death1 0        #
		#
		set xnut=8.875070451931031E-003
		set xprot=8.863457202678457E-006
		set xalfa=4.620834513710024E-002
		set xh=0.944907720953766
		set a=60.6643737084135
		set x=0.430610272414859
		#
		set ytot1   = xnut  + xprot + 0.25d0*xalfa 
		set ytot1 = ytot1 + xh/a
		#
		set zbarxx  = xprot + 0.5d0*xalfa
		set zbarxx = zbarxx + x*xh
		#
		set abarnum    = 1.0d0/ytot1
		set abar=abarnum
		set zbar    = zbarxx * abar
		set yelocal = zbar/abarnum
		#
		print {abar zbar}
		#
		#
