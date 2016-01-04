csc 1                   # returns cosecant
		set $0=1.0/(sin($1))
cot 1     # returns cotangent
		set $0=1.0/(tan($1))
		#
smcopy    0             #
		!scp -rp jon@relativity.cfa.harvard.edu:sm/* ~/sm/
		smstart
		jre gtwodmaps.m
		jre metrics.m
		#
smbhcopy    0             #
		!scp -rp jon@bh.astro.uiuc.edu:sm/* ~/sm/
		smstart
		jre levinson.m
		jre punsly.m
		#
		#
		#
der1        2     # derivative in radial direction (e.g. der1 Tud10 Tud10d)
		set $2=0,$nx*$ny-1,1
		set $2=$2*0
                 do iii=0,$nx*$ny-1,1 {
		    set indexi=INT($iii%$nx)
		    set indexj=INT(($iii%($nx*$ny))/$nx)
		    set indexk=INT($iii/($nx*$ny))
		    define tempi (indexi)
		    define tempj (indexj)
		    define tempk (indexk)
		    #
		    if(indexi==0){\
		           # forward difference
		       set $2[$iii]=$1[$iii+1]-$1[$iii]
		    }
		    if(indexi==$nx-1) {\
		              # backward difference
		       set $2[$iii]=$1[$iii]-$1[$iii-1]
		       echo got here $tempj
		    }
		    if((indexi>0)&&(indexi<$nx-1)) {\
		              # centered difference
		       set $2[$iii]=0.5*($1[$iii+1]-$1[$iii-1])
		    }
		 }
		 set $2=$2/$dx1
		 #
der2        2     # derivative in theta direction (e.g. der2 Tud10 Tud10d)
		set $2=0,$nx*$ny-1,1
		set $2=$2*0
                 do iii=0,$nx*$ny-1,1 {
		    set indexi=INT($iii%$nx)
		    set indexj=INT(($iii%($nx*$ny))/$nx)
		    set indexk=INT($iii/($nx*$ny))
		    define tempi (indexi)
		    define tempj (indexj)
		    define tempk (indexk)
		    #
		    if(indexj==0){\
		           # forward difference
		       set $2[$iii]=$1[$iii+$nx]-$1[$iii]
		    }
		    if(indexj==$ny-1) {\
		              # backward difference
		       set $2[$iii]=$1[$iii]-$1[$iii-$nx]
		    }
		    if((indexj>0)&&(indexj<$ny-1)) {\
		              # centered difference
		       set $2[$iii]=0.5*($1[$iii+$nx]-$1[$iii-$nx])
		    }
		 }
		 set $2=$2/$dx2
		 #
der        4            # derivative (e.g. der t min1 td min1d)
                  set _length=dimen($1)
                  echo der
                  define length (_length)
                  set $3=0,$length-1,1
                  set $4=0,$length-1,1
                  do ii=1,$length-1,1 {
                     set $3[$ii]=0.5*($1[$ii-1]+$1[$ii]) 
		     set $4[$ii]=($2[$ii]-$2[$ii-1])/($1[$ii]-$1[$ii-1])
  		  }
                  # hack to allow derivative same size as function, should really linearly interpolate function to get this
		  set $3[0]=$1[0]
                  set $4[0]=$4[1]
                  # hack to avoid problem at end with same time data
                  #set $4[$length-1]=$4[$length-2]
                  #
grad       4      # (e.g. grad  pot gpot 3 2) div <fun> <newfun> <coord> <grid>
	          # <coord> 3->spc 2->cyl 1->cart
                  # <grid> 2 -> b-grid, 1 -> a-grid for source data
                  # currently assume a-grid source data
                  if($3==1){\
                    set newf1=$1
                    set newf2=$1
                    set newf3=$1
                    set f1=x12/x12
                    set f2=x12/x12
		    set f3=x12/x12
		    define dxx1 dx1
		    define dxx2 dx2
		    define dxx3 dx3
		    set shiftx1m=0
		    set shiftx1p=1
		    set shiftx2m=0
		    set shiftx2p=$nx
		    set shiftx3m=0
		    set shiftx3p=$nx*$ny
                  }\
                  else{\
                    if($3==3){\
			if($4==1){\
                         set newf1=$1
                         set newf2=$1
                         set newf3=$1
                         set f1=1/(g12)
                         set f2=1/(g22)
                         set f3=1/(g32*g42)
		         define dxx1 dx1
	                 define dxx2 dx2
	                 define dxx3 dx3
		         set shiftx1m=0
		         set shiftx1p=1
		         set shiftx2m=0
		         set shiftx2p=$nx
		         set shiftx3m=0
		         set shiftx3p=$nx*$ny
                        }
		        if($4==2){\
                         set newf1=$1
                         set newf2=$1
		         set newf3=$1
                         set f1=1/(g1)
		         set f2=1/(g2)
		         set f3=1/(g3*g4)
		         # more complicated due to nonuni grid
		         define dxx1 dx12
	                 define dxx2 dx22
	                 define dxx3 dx32
		         set shiftx1m=-1
		         set shiftx1p=0
		         set shiftx2m=-$nx
		         set shiftx2p=0
		         set shiftx3m=-$nx*$ny
		         set shiftx3p=0
                        }
                    }
                  }
                  set $2x=0,$nx*$ny*$nz-1,1
                  set $2y=0,$nx*$ny*$nz-1,1
                  set $2z=0,$nx*$ny*$nz-1,1
	          set $2x=$2x*0
	          set $2y=$2y*0
	          set $2z=$2z*0
                  do kk=0,$nx*$ny*$nz-1,1 {
		     set indexi=INT($kk%$nx)
		     set indexj=INT(($kk%($nx*$ny))/$nx)
		     set indexk=INT($kk/($nx*$ny))

		     set gox1=1
		     set gox2=1
		     set gox3=1
		     if($4==1){\
		            if(indexi==$nx-1){ set gox1=0 }
		            if(indexj==$ny-1){ set gox2=0 }
		            if(indexk==$nz-1){ set gox3=0 }
		     }
		     if($4==2){\
		            if(indexi==0){ set gox1=0 }
		            if(indexj==0){ set gox2=0 }
		            if(indexk==0){ set gox3=0 }
		     }
		     if(($nx>1)&&(gox1)){ set mydx1=$dxx1[$kk] }
		     if(($ny>1)&&(gox2)){ set mydx2=$dxx2[$kk] }
		     if(($nz>1)&&(gox3)){ set mydx3=$dxx3[$kk] }
		     if(($nx>1)&&(gox1)){ set $2x[$kk]=f1[$kk]*(newf1[$kk+shiftx1p]-newf1[$kk+shiftx1m])/mydx1 } else { set $2x[$kk]=0 }
		     if(($ny>1)&&(gox2)){ set $2y[$kk]=f2[$kk]*(newf2[$kk+shiftx2p]-newf2[$kk+shiftx2m])/mydx2 } else { set $2y[$kk]=0 }
		     if(($nz>1)&&(gox3)){ set $2z[$kk]=f3[$kk]*(newf3[$kk+shiftx3p]-newf3[$kk+shiftx3m])/mydx3 } else { set $2z[$kk]=0 }
		  }
                  #
vdotgradv   5     # (e.g. vdotgradv  vtodot v result 3 2) fdotgradv <vec\cdot> <v> <newv> <coord> <grid>
	          # gradient of vector
	          # <coord> 3->spc 2->cyl 1->cart
                  # <grid> 2 -> b-grid, 1 -> a-grid for source data
                  # currently assume a-grid source data
		  # just normal gradient with additional curvature terms in spc only
	          grad $2x tempx $4 $5
	          grad $2y tempy $4 $5
	          grad $2z tempz $4 $5
		  # v\cdot(\nablda v)
                  # now, e.g. tempxy means x component, y-dir derivative
		  # contraction on the derivative
		  set $3x=$1x*tempxx+$1y*tempxy+$1z*tempxz
		  set $3y=$1x*tempyx+$1y*tempyy+$1z*tempyz
		  set $3z=$1x*tempzx+$1y*tempzy+$1z*tempzz
		  if($4==3){\
		   # additional curvature terms if spc
		   if($5==2){\
		    set $3x=$3x-$1y*($2y/g22)-$1z*$2z/g32
		    set $3y=$3y+$1y*($2x/g22)-$1z*($2z*dg42/(g22*g42))
		    set $3z=$3z+$1z*($2x/g32+$2y*dg42/(g22*g42))
		   }
		   if($5==1){\
		    set $3x=$3x-$1y*($2y/g22)-$1z*$2z/g32
		    set $3y=$3y+$1y*($2x/g22)-$1z*($2z*dg42/(g22*g42))
		    set $3z=$3z+$1z*($2x/g32+$2y*dg42/(g22*g42))
		   }
                  }
                  #
div       5       # (e.g. div  v dv 3 2 0) div <fun> <newfun> <coord> <grid> <diffvol>
	          # <coord> 3->spc 2->cyl 1->cart
                  # <grid> 2 -> b-grid, 1 -> a-grid for source data
                  # currently assume a-grid source data
                  # <diffvol> whether to use diff=0 or volume=1 method
		  if($3==1){\
                    set newf1=$1x
                    set newf2=$1y
                    set newf3=$1z
                    set f1=x12/x12
                    set f2=x22/x22
                    set f3=x32/x32
                    set dx1temp=dx1
                    set dx2temp=dx2
                    set dx3temp=dx3
                  }\
                  else{\
                    if($3==3){\
                     if($5==0){\
                      set newf1=$1x*g2*g3
                      set newf2=$1y*g4
                      set newf3=$1z
                      set f1=1/(g22*g32)
                      set f2=1/(g32*g42)
                      set f3=1/(g32*g42)
                      set dx1temp=dx1
                      set dx2temp=dx2
                      set dx3temp=dx3
                     }\
                     else{\
		      echo "diffvol"
                      set newf1=$1x*g2*g3
                      set newf2=$1y*g4
                      set newf3=$1z
                      set f1=dx1/dx1
                      set f2=1/(g22)
                      set f3=1/(g32*g42)
                      set dx1temp=dvl1
                      set dx2temp=dvl2
                      set dx3temp=dvl3
                     }
                    }
                  }
                  set $2=0,$nx*$ny*$nz-1,1
                  do kk=0,$nx*$ny*$nz-1,1 {
		   set indexi=INT($kk%$nx)
		   set indexj=INT(($kk%($nx*$ny))/$nx)
		   set indexk=INT($kk/($nx*$ny))
	                if( ((indexi!=$nx-1)||($nx==1))&&((indexj!=$ny-1)||($ny==1))&&((indexk!=$nz-1)||($nz==1)) ){\
	                   set $2[$kk]=0
	                   if($nx>1){\
	        	    set $2[$kk]=$2[$kk]+f1[$kk]*(newf1[$kk+1]-newf1[$kk])/dx1temp[$kk]
                           }
                           if($ny>1){\
                            set $2[$kk]=$2[$kk]+f2[$kk]*(newf2[$kk+$nx]-newf2[$kk])/dx2temp[$kk]
                           }
                           if($nz>1){\
                             if($DODIV3==1){\
	                      set $2[$kk]=$2[$kk]+f3[$kk]*(newf3[$kk+$nx*$ny]-newf3[$kk])/dx3temp[$kk]
                             }
                           }
                        }\
                        else{\
			   # just copy over outer layer
                           if(($nx>1)&&(indexi==$nx-1)){ set $2[$kk]=$2[$kk-1] }
                           if(($ny>1)&&(indexj==$ny-1)){ set $2[$kk]=$2[$kk-$nx] }
                           if(($nz>1)&&(indexk==$nz-1)){ set $2[$kk]=$2[$kk-$nx*$ny] }
                        }
		  }
gdiv       2       # (e.g. div  v dv) div <fun> <newfun> 
		set newf1=$1r*gdet
		set newf2=$1h*gdet
                  set $2=0,$nx*$ny*$nz-1,1
                  do kk=$nx*$ny*$nz-1,0,-1 {
		   set indexi=INT($kk%$nx)
		   set indexj=INT(($kk%($nx*$ny))/$nx)
		   set indexk=INT($kk/($nx*$ny))
	                if( (indexi!=0)&&(indexj!=0) ){\
	                   set $2[$kk]=0
		           set $2[$kk]=$2[$kk]+0.5*(newf1[$kk]+newf1[$kk-$nx]-newf1[$kk-1]-newf1[$kk-$nx-1])/$dx1
		           set $2[$kk]=$2[$kk]+0.5*(newf2[$kk]+newf2[$kk-1]-newf2[$kk-$nx]-newf2[$kk-$nx-1])/$dx2
                        }\
                        else{\
			   # just copy over outer layer
                           if(($nx>1)&&(indexi==0)){ set $2[$kk]=$2[$kk+1] }
                           if(($ny>1)&&(indexj==0)){ set $2[$kk]=$2[$kk+$nx] }
                        }
  		  }

                  #
curl       4      # (e.g. curl vecin vecout 2) curl <fun> <newfun> <coord> <source grid>
	          # <coord> 3->spc 2->cyl 1->cart
                  # <grid> 2 -> b-grid, 1 -> a-grid for source data
                  # currently assume a-grid source data
                  if($3==1){\
                    set newf1=$1x
                    set newf2=$1y
                    set newf3=$1z
                    set f1=x12/x12
                    set f2=x12/x12
		    set f3=x12/x12
		    define dxx1 dx1
		    define dxx2 dx2
		    define dxx3 dx3
		    set shiftx1m=0
		    set shiftx1p=1
		    set shiftx2m=0
		    set shiftx2p=$nx
		    set shiftx3m=0
		    set shiftx3p=$nx*$ny
                  }\
                  else{\
                    if($3==3){\
			if($4==1){\
                         set newf1=$1x*g1
                         set newf2=$1y*g2
                         set newf3=$1z*g3*g4
                         set f1=1/(g22*g32*g4)
                         set f2=1/(g1*g3*g42)
                         set f3=1/(g12*g22)
		         define dxx1 dx12
	                 define dxx2 dx22
	                 define dxx3 dx32
		         set shiftx1m=-1
		         set shiftx1p=0
		         set shiftx2m=-$nx
		         set shiftx2p=0
		         set shiftx3m=-$nx*$ny
		         set shiftx3p=0
                        }
		        if($4==2){\
		               # not right (doesn't result in same location)
		         set newf1=$1x*g1
                         set newf2=$1y*g2
                         set newf3=$1z*g3*g4
                         set f1=1/(g22*g32*g4)
                         set f2=1/(g1*g3*g42)
                         set f3=1/(g12*g22)
		         define dxx1 dx12
	                 define dxx2 dx22
	                 define dxx3 dx32
	                 define dxx1 dx1
	                 define dxx2 dx2
	                 define dxx3 dx3
		         set shiftx1m=0
		         set shiftx1p=1
		         set shiftx2m=0
		         set shiftx2p=$nx
		         set shiftx3m=0
		         set shiftx3p=$nx*$ny
                        }
                    }
                  }
                  set $2x=0,$nx*$ny*$nz-1,1
                  set $2y=0,$nx*$ny*$nz-1,1
                  set $2z=0,$nx*$ny*$nz-1,1
	          set $2x=$2x*0
	          set $2y=$2y*0
	          set $2z=$2z*0
                  do kk=0,$nx*$ny*$nz-1,1 {
		     set indexi=INT($kk%$nx)
		     set indexj=INT(($kk%($nx*$ny))/$nx)
		     set indexk=INT($kk/($nx*$ny))

		     set gox1=1
		     set gox2=1
		     set gox3=1
		     if($4==2){\
		            if(indexi==$nx-1){\
		             # because kk+1 doesn't exist
		             set gox1=0
		            }
		            if(indexj==$ny-1){\
		             # because kk+1 doesn't exist
		             set gox2=0
		            }
		            if(indexk==$nz-1){\
		             # because kk+1 doesn't exist
		             set gox3=0
		            }
		     }
		     if($4==1){\
		            if(indexi==0){\
		             # because kk-1 doesn't exist
		             set gox1=0
		            }
		            if(indexj==0){\
		             # because kk-1 doesn't exist
		             set gox2=0
		            }
		            if(indexk==0){\
		             # because kk-1 doesn't exist
		             set gox3=0
		            }
		     }
		     set $2x[$kk]=0
		     set $2y[$kk]=0
		     set $2z[$kk]=0
		     if(($ny>1)&&(gox2)){ set $2x[$kk]=$2x[$kk]+f1[$kk]*(newf3[$kk+shiftx2p]-newf3[$kk+shiftx2m])/$dxx2[$kk] }
		     if(($nz>1)&&(gox3)){ set $2x[$kk]=$2x[$kk]-f1[$kk]*(newf2[$kk+shiftx3p]-newf2[$kk+shiftx3m])/$dxx3[$kk] }
		     if(($nz>1)&&(gox3)){ set $2y[$kk]=$2y[$kk]+f2[$kk]*(newf1[$kk+shiftx3p]-newf1[$kk+shiftx3m])/$dxx3[$kk] }
		     if(($nx>1)&&(gox1)){ set $2y[$kk]=$2y[$kk]-f2[$kk]*(newf3[$kk+shiftx1p]-newf3[$kk+shiftx1m])/$dxx1[$kk] }
		     if(($nx>1)&&(gox1)){ set $2z[$kk]=$2z[$kk]+f3[$kk]*(newf2[$kk+shiftx1p]-newf2[$kk+shiftx1m])/$dxx1[$kk] }
		     if(($ny>1)&&(gox2)){ set $2z[$kk]=$2z[$kk]-f3[$kk]*(newf1[$kk+shiftx2p]-newf1[$kk+shiftx2m])/$dxx2[$kk] }
		  }
crossprod  3      # crossproduct first second result
		  set $3x=$1y*$2z-$1z*$2y
		  set $3y=$1z*$2x-$1x*$2z
		  set $3z=$1x*$2y-$1y*$2x
		  #
dotprod 3         # dotprod first second result
		  set $3=$1x*$2x+$1y*$2y+$1z*$2z
		  #
fieldint  2       # (e.g. fieldit b aphi)
	          # <coord> 3->spc 2->cyl 1->cart
                  # <grid> 2 -> b-grid, 1 -> a-grid for source data
                  # currently assume b-grid source data
                  set $2=0,$nx*$ny-1,1
	          set A=-$1y*g32*g42
	          set B=$1x*g22*g32*g42
	          set differA=A*dx1
	          set differB=B*dx2
                  do kk=0,$nx*$ny-1,1 {
			   set temp=differB if((i==$kk%$nx)&&(j<=$kk/$nx))
			   set temp2=differA if((i<=$kk%$nx)&&(j==0))
	        	   set $2[$kk]=SUM(temp)+SUM(temp2)
  		  }
                  # final norm factor(messes things up?)
	          #set $2=$2/(x12*g42)
                  #
                  #
fftreallim 7       # (eg. fftreallim 1 td min1d freq min1dfpow 10000 20000)
                   # assume all have same dimension
                   #set itreal=dimen($3)
                   set itin=$6
                   set itout=$7
                   set it=$7-$6+1
                   set crap=0,it-1,1
                   set complex=crap*0
                   set deltat=($2[itout]-$2[itin])
                   set delt=($2[itout]-$2[itin])/it
                   #set $4=1/4000*(-0.5*it/deltat+crap/deltat)
                   #set $4=-0.5*it*deltat+crap*deltat
                   set $4=1,it,1
                   set realin=1,it,1
                   set jj=0
                   do ii=0,it/2-1,1 {
		      define itj (jj)
                      set $4[$ii]=-$itj/deltat
                      set realin[$ii]=$3[$ii+itin]
                      set jj=jj+1
		   }
                   set jj=0
                   if(it/2-INT(it/2)>.001){ set doit=it} else{set doit=it-1} 
                   do ii=it/2,doit,1 {
		     define itj (jj)
                      set $4[$ii]=0.5*it/deltat-$itj/deltat
                      set realin[$ii]=$3[$ii+itin]
                      set jj=jj+1
            	   }
                   fft $1 realin complex outreal outcomplex
                   set $5= outreal**2+outcomplex**2
		   #
fftreal 5          # (eg. fftreal 1 td min1d freq min1dfpow)
                   # assume all have same dimension
                  set inneri=0
	          set outeri=dimen($3)-1
                  fftreallim $1 $2 $3 $4 $5 inneri outeri
                  #
integrate  4      # (e.g. integrate td min1d t min1)
		# running integration, not true
                  set _length=dimen($1)
                  define length (_length)
                  set $3=0,$length-1,1
                  set $4=0,$length-1,1
		  set $3=$3*0
		  set $4=$4*0
                  do ii=1,$length-1,1 {
                     set $3[$ii]=0.5*($1[$ii-1]+$1[$ii]) 
		     set $4[$ii]=$4[$ii-1]+0.5*($2[$ii]+$2[$ii-1])*($1[$ii]-$1[$ii-1])
  		  }
                  # hack to allow derivative same size as function, should really linearly interpolate function to get this
		  set $3[0]=$1[0]
                  set $4[0]=$4[1]
                  #
runabs     4      # running integrated absolute value (.e.g runabs t min1 ta min1a)
                  set _length=dimen($1)
                  define length (_length)
                  set $3=0,$length-1,1
                  set $4=0,$length-1,1
	          # hack to allow recursive add
		  set $3[0]=$1[0]
                  set $4[0]=0
                  do ii=1,$length-1,1 {
                     set $3[$ii]=0.5*($1[$ii-1]+$1[$ii]) 
		     set $4[$ii]=0.5*ABS($2[$ii]+$2[$ii-1])+$4[$ii-1]
  		  }
                  #
avg 3		  # average: (e.g. avg td min1d min1davg)
                  set _length=dimen($1)
                  define length (_length)
	          avglim $1 $2 $3 0 $length
                  #
avglim 5	  # average: (e.g. avglim td min1d min1davg 20000 30000)
                  set _length=$5
                  define length (_length)
                  set temptime=0
                  set $3=1,1,1
		  set $3[0]=0
                  do ii=$4+1,$length-1,1 {
                     set tempdt=($1[$ii]-$1[$ii-1]) 
                     set temptime=temptime+tempdt
		     set $3=$3+$2[$ii]*tempdt
  		  }
                  set $3=$3/temptime
                  set tempaverage=$3
                  print '%21.15g\n' {tempaverage}
                  #
pdimen 1          # print dimension (e.g. pdimen td)
                  set tempdimen=dimen($1)
                  print '%g\n' {tempdimen}
                  #
rdraft            #
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
                  define finaldraft (0)
                  define PLOTLWEIGHT (1)
                  define NORMLWEIGHT (1)
                  lweight $NORMLWEIGHT
                  ltype 0
 	          expand 1.00001
                  location 5000 31000 3500 31000
fdraft            #
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
                  define finaldraft (1)
                  define PLOTLWEIGHT (5)
                  define NORMLWEIGHT (3)
                  expand 1.5
	          ltype 0
                  lweight $NORMLWEIGHT
	          location 5000 31000 3500 31000
	          #location 7000 31000 3500 31000
                  #LOCATION $($gx1 + 1000) $gx2 $gy1 $gy2
                  #                  
mypoints 3        #
		  lweight $PLOTLWEIGHT
                  if(!($finaldraft)){\
                   #points $1 $2
                  }
                  if($3==1){ connect $1 $2 }
                   if($3==0){ connect ($1) ($2) if(condconnect) }
		  lweight $NORMLWEIGHT
		  #
defaults2     # stuff not yet outputted in code
		define coord (1)                
defaults
		# go back to defaults
	          if($?npdone == 0){\
		   define npdone (0)
	          }
		     define jet 0
	        define filetype (1)
       		 rdraft
		 define DOGCALC (1)
	        define ncpux1 (1)
	        define ncpux2 (1)
	        define ncpux3 (2)
		define coord (3)
                NOTATION -4 4 -4 4
                define LOOPTYPE (1) # used recently alot
                define COMPDIM (3)
                define DODIV3 (1)
	        expand 1.00001
                define IMAGEORDER 0
	        define PLANE (3)
		define PLOTERASE (1)
		define CONSTLEVELS (0)
		define ANIMSKIP (1)
		define SOLIDCONTOURS (0)
		define SKIPFACTOR (1)
		define UNITVECTOR (0)
     		define PRINTTO (0)
    	    	define AVG1DWHICH (2)
                if($?GAMMIE==0){\
                 define GAMMIE (0)
                }
      		  define DOCALCS (1)
		  define WHICHLEV (0)
	          notation -2 2 -2 2
		  define loginterprho 0
                  ticksize 0 0 0 0
                  if(!($finaldraft)){\
                   rdraft
                  }\
                  else{ fdraft }
	          define cres (15) # see plc
	          ctype default
	          window 1 1 1 1
	          location 5000 31000 3500 31000
		  #
		  define POSCONTCOLOR red
		  define NEGCONTCOLOR default
		  define BOXCOLOR default
		  define POSCONTLTYPE 0
		  define NEGCONTLTYPE 0
          define DOCONNECT 1
          define print_noheader (0)
		  #
defaultsold          # go back to defaults
	          if($?npdone == 0){\
		   define npdone (0)
	          }
	        define filetype (1)
       		 rdraft
                define LOOPTYPE (3) # used recently alot
                define coord (3)
                define COMPDIM (2)
                define DODIV3 (0)
	        expand 1.00001
	        define PLANE (3)
		define PLOTERASE (1)
		define CONSTLEVELS (0)
		define ANIMSKIP (1)
		define SOLIDCONTOURS (0)
		define SKIPFACTOR (1)
     		define PRINTTO (0)
    	    	define AVG1DWHICH (2)
      		  define DOCALCS (1)
	          notation -2 2 -2 2
		  define loginterprho 0
                  ticksize 0 0 0 0
                  if(!($finaldraft)){\
                   rdraft
                  }\
                  else{ fdraft }
	          define cres (15) # see plc
	          ctype default
	          window 1 1 1 1
	          location 5000 31000 3500 31000
		  #
shrink3  7         # assumes $2,$3 are original coords, $nx $ny are original sizes
                   # shrink3 <oldfun> <oldx1> <oldx2> <xl> <xh> <yl> <yh>
                   # default(0) to not use limits on sm line
                   define txl ($4)
                   define txh ($5)
                   define tyl ($6)
                   define tyh ($7)
                   # determine index range from requested numerical range
                   set flipi=0
                   set flipo=0
                   do kk=0,$nx-1,1{
                     if( ($2[$kk]>=$txl)&(flipi==0)){ set tempxl=$kk set flipi=1}
                     if( ($2[$kk]>=$txh)&(flipo==0)){ set tempxh=$kk set flipo=1}
                   }
                   if(flipi==0){ set tempxl=0 }
                   if(flipo==0){ set tempxh=$nx-1 }
                   set flipi=0
                   set flipo=0
                   do kk=0,$ny-1,1{
                     if( ($3[$kk*$nx]>=$tyl)&(flipi==0)){ set tempyl=$kk set flipi=1}
                     if( ($3[$kk*$nx]>=$tyh)&(flipo==0)){ set tempyh=$kk set flipo=1}
                   }
                   if(flipi==0){ set tempyl=0 }
                   if(flipo==0){ set tempyh=$ny-1 }
                   set temprnx=(tempxh-tempxl+1)
                   set temprny=(tempyh-tempyl+1)
                   define rxl (tempxl)
                   define rxh (tempxh)
                   define ryl (tempyl)
                   define ryh (tempyh)
                   define rnx (temprnx)
                   define rny (temprny)
	           set iiold=1,$nx*$ny,1
                   set ixold=(iiold - $nx*int((iiold-0.5)/$nx) - 1)
                   set iyold=((int((iiold-0.5)/$nx) ))
                   set ii=1,$rnx*$rny,1
                   set ix=(ii - $rnx*int((ii-0.5)/$rnx) - 1)
                   set iy=((int((ii-0.5)/$rnx) ))
                   set $2new=$2 if( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh))
                   set $3new=$3 if( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh))
                   set $1new=$1 if( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh))
                   #
reduce   5         # (e.g. reduce td min1d tdr min1dr 10)
                   set reduction=($5)
                   define reductiondef (reduction)
                   echo reduced by $reductiondef
                   set _length=dimen($1)
                   define length (_length)
                   set $3=0,$length/$5-1,1
                   set $4=0,$length/$5-1,1
                   do i=0,$length/$5-1,1 {
                      set $3[$i]=$1[$i*$5]
		      set $4[$i]=$2[$i*$5]
  		   }
                   #
shrink2  6         # (e.g. shrink   td min1d tds min1ds 0 1E5)
                   set _length=dimen($1)
                   define length (_length)
		   # determine index range from requested numerical range
                   set flipi=0
                   set flipo=0
                   do kk=0,$length-1,1{
                     if( ($1[$kk]>=$5)&(flipi==0)){ set tempxl=$kk set flipi=1}
                     if( ($1[$kk]>=$6)&(flipo==0)){ set tempxh=$kk set flipo=1}
                   }
                   if(flipi==0){ set tempxl=0 }
                   if(flipo==0){ set tempxh=$length-1 }
                   set temprnx=(tempxh-tempxl+1)
                   define rxl (tempxl)
                   define rxh (tempxh)
                   define rnx (temprnx)
                   set ix=0,$length-1,1
                   set $3=$1 if( (ix>=$rxl)&(ix<=$rxh))
                   set $4=$2 if( (ix>=$rxl)&(ix<=$rxh))
                   #
minmaxs     2      # find min and max's and print out location/values
		   set values=0,3,1
		   set values=values*0
		   set _length=dimen($1)
                   define length (_length)
		   set maxes=1,$length,1
		   set maxes=maxes*0
		   set mins=maxes*0
		   set timemax=maxes*0
		   set timemin=maxes*0
		   set nummaxes=0
		   set nummins=0
		   set values[0]=$2[0]
		   set values[1]=$2[1]
                   do kk=1,$length-2,1{
		      if(($2[$kk]>=$2[$kk-1])&&($2[$kk]>=$2[$kk+1])){\
		             set maxes[nummaxes]=$2[$kk]
		             set timemax[nummaxes]=$1[$kk]
		             set nummaxes=nummaxes+1
		      }
		      if(($2[$kk]<=$2[$kk-1])&&($2[$kk]<=$2[$kk+1])){\
		             set mins[nummins]=$2[$kk]
		             set timemin[nummins]=$1[$kk]
		             set nummins=nummins+1
		      }
                   }
		   set temptemp=timemax
		   set maxes=maxes if(temptemp!=0)
		   set timemax=timemax if(temptemp!=0)
		   set temptemp=timemin
		   set mins=mins if(temptemp!=0)
		   set timemin=timemin if(temptemp!=0)
                   #
trueminmax 2 # trueminmax r rho
		# returns truemin, trueminloc, truemax, truemaxloc
		   set _length=dimen($1)
                   define length (_length)
		   set truemax=$2[0]
		   set truemin=$2[0]
		   #
                   do kk=1,$length-1,1{
		      if($2[$kk]>=truemax){\
		          set truemax=$2[$kk]
		          set truemaxloc=$1[$kk]
		       }
		      if($2[$kk]<=truemin){\
		             set truemin=$2[$kk]
		             set trueminloc=$1[$kk]
		      }
                   }
		   print {truemin trueminloc truemax truemaxloc}
		   #
sm2rh   4       # sm2rh p1 p2 myr myh
                echo Use cursor to derive actual r,h location in sm image plot
		#
		set tempp1=$1
		set tempp2=$2
		#
		set fr=tempp1/(Rout-Rin)
		set fh=tempp2/pi
		#
		set myx1=fr*(tx1[dimen(tx1)-1]-tx1[0])+tx1[0]
		if(myx1<tx1[0]) { set myx1=tx1[0]+1E-30 }
		if(myx1>tx1[dimen(tx1)-1]) { set myx1=tx1[dimen(tx1)-1]-1E-30 }
		#
		set myx2=fh*(tx2[dimen(tx2)-1]-tx2[0])+tx2[0]
		if(myx2<tx2[0]) { set myx2=tx2[0]+1E-30 }
		if(myx2>tx2[dimen(tx2)-1]) { set myx2=tx2[dimen(tx2)-1]-1E-30 }
		#
		set usex1=( (tx1>myx1)&&(tx2==tx2[0])) ? 1 : 0
		set usex2=( (tx2>myx2)&&(tx1==tx1[0])) ? 1 : 0
		#
		set listti=ti if(usex1)
		set listtj=tj if(usex2)
		#
		set myti=listti[0]
		set mytj=listtj[0]
		#
		set $3=r[myti]
		set $4=h[mytj*$nx]
		#
		#
		#print {tempp1 tempp2 myr myh}
		#
image2rh   0    #
		CURSOR _x _y
		DEFINE _d ( dimen(_x) )
                IF($_d < 1) {
                   echo I need at least one vector
                   DELETE _x DELETE _y
		   DEFINE _d DELETE
                   RETURN
                }
		set myr=0,$_d-1,1
		set myr=0*myr
		set myh=myr
		#
		IF($_d>=1) {
		   do iii=0,$_d-1,1 {\
		       sm2rh _x[$iii] _y[$iii] myr[$iii] myh[$iii]
		    }
		}
		print {_x _y myr myh}
		#
		#
piplot          2       #
		# gammie's requested pi plot
		#erase limits 0 2 0 2 box 0 2 0 0
		define ldown ($1)
		define lup ($2)
		define lgod ($1-($2-$1)/20)
		limits 0 1 $ldown $lup
		define tickbig (($2-$1)/5)
		define ticksmall (($2-$1)/20)
		ticksize 0.1 1 $ticksmall $tickbig
		box 0 2 0 0
		relocate 0 $lgod
		putlabel 5 "0"
		relocate .5 $lgod
		putlabel 5 "\frac{\pi}{4}"
		relocate 1 $lgod
		putlabel 5 "\frac{\pi}{2}"
		#
		define xhigh (pi/2)
		limits 0 $xhigh $ldown $lup
		#
		#
draw_arrowhead 3    # draw an arrow from ($1,$2) with angle $3
		# plot pointer is left at ($3,$4)
		# the size of the head is set by the value of expand
		# see `arrow' for interactively drawing an arrow
		DEFINE _phi 0.4           # opening angle of head
		DEFINE vars { expand fx1 fx2 fy1 fy2 gx1 gx2 gy1 gy2 }
		foreach v { $!!vars } { DEFINE $v | }
		DEFINE expand | DEFINE _len (1000*$expand)
		DEFINE gx2 ( ($gx2 - $gx1)/($fx2 - $fx1) )
		DEFINE gx1 ( $gx1 - $gx2*$fx1 )
		DEFINE gy2 ( ($gy2 - $gy1)/($fy2 - $fy1) )
		DEFINE gy1 ( $gy1 - $gy2*$fy1 )
		DEFINE _x0 ( ($1)*$gx2 + $gx1 )
		#DEFINE _x1 ( ($3)*$gx2 + $gx1 )
		DEFINE _x1 ($_x0)
		DEFINE _y0 ( ($2)*$gy2 + $gy1 )
		DEFINE _y1 ($_y0)
		#DEFINE _y1 ( ($4)*$gy2 + $gy1 )
		#IF($_x0 == $_x1) {
		#   IF($_y1 > $_y0) { DEFINE _theta (PI/2)
		#   } ELSE { DEFINE _theta (-PI/2) }
		#} else {
		#   DEFINE _theta ( ATAN(($_y1-$_y0)/($_x1-$_x0)) )
		#}
		DEFINE _theta ($3/180*pi)
		IF($_x1 < $_x0) { DEFINE _len ( -$_len ) }
		RELOCATE ( $_x0 $_y0 ) DRAW ( $_x0 $_y0 )
                set myx=0,5,1
		set myy=0,5,1
		set myx[0]=$_x0
		set myy[0]=$_y0
		set myx[1]=$_x0
		set myy[1]=$_y0
		DEFINE _x0 ( $_x1 - $_len*COS($_theta - $_phi) )
		DEFINE _y0 ( $_y1 - $_len*SIN($_theta - $_phi) )
		DRAW ( $_x0 $_y0 )
		set myx[2]=$_x0
		set myy[2]=$_y0
		DEFINE _x0 ( $_x1 - 0.6*$_len*COS($_theta) )
		DEFINE _y0 ( $_y1 - 0.6*$_len*SIN($_theta) )
		DRAW ( $_x0 $_y0 )
		set myx[3]=$_x0
		set myy[3]=$_y0
		DEFINE _x0 ( $_x1 - $_len*COS($_theta + $_phi) )
		DEFINE _y0 ( $_y1 - $_len*SIN($_theta + $_phi) )
		DRAW ( $_x0 $_y0 ) DRAW ( $_x1 $_y1 )
		set myx[4]=$_x0
		set myy[4]=$_y0
		set myx[5]=$_x1
		set myy[5]=$_y1
		# 
		set myx=(myx-$gx1)/$gx2
		set myy=(myy-$gy1)/$gy2
		set myx=myx concat $(myx[0])
		set myy=myy concat $(myy[0])
		shade 0 myx myy
		#
		FOREACH _v { _len _phi _theta _x0 _x1 _y0 _y1 $!!vars vars } {
		   DEFINE $_v DELETE
		}
		#
		#
printd   1        #
		set temptemp=$1
		print '%21.15g\n' {temptemp}
		#
showmpigrid 0
        set ncpux1=4
        set ncpux2=4
        define cresold ($cres)
        define cres 2
        plc0 0 (ti-$nx/ncpux1*1) 010
        plc0 0 (ti-$nx/ncpux1*2) 010
        plc0 0 (ti-$nx/ncpux1*3) 010
        plc0 0 (tj-$ny/ncpux2*1) 010
        plc0 0 (tj-$ny/ncpux2*2) 010
        plc0 0 (tj-$ny/ncpux2*3) 010
        define cres ($cresold)
        #
		
