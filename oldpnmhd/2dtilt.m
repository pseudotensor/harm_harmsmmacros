doit 0       #
             defaults
             image(21 , 21) -1 1 -1 1
             set y=0,20
             do x=0,20{\
	       set r=sqrt((y- 10)**2 + ($x - 10)**2)\
	       set image[$x,y] = J0( r)\
             }
             limits -1 1 -1 1
             erase
             box
             minmax min max echo $min $max
             if($min*$max < 0.) {\
                        define delta (($max-$min)/50.)
                        set lev=$min,-$delta,$delta
                        levels lev
                        ltype 2
                        contour
                        #
                        set lev=$delta,$max,$delta
                        levels lev
                        ltype 0
                        contour
                } \
                else {\
                        set lev=$min,$max,($max-$min)/50.
                        levels lev
                        ltype 0
                        contour
                }  
#            erase
#            surface 3 10
             erase
	     load surfaces
             set realx=0,20,1
             set realy=0,20,1
             do i=0,20,1{
               set realx[$i]=-1+$i/10.0*1.0
               set realy[$i]=-1+$i/10.0*1.0
	     }
             #viewpoint 50 50 0
             Viewpoint 50 50 0
             #surface 13 $min $max realx realy
             Surface 13 $min $max realx realy
             #Viewpoint 50 50 0
             #Surface
             define Lo_x (-1)
             define Hi_x (1)
             define Lo_y (-1)
             define Hi_y (1)
             box3
             label3 x X-label [xunit]
             label3 y Y-label [yunit]
             label3 z Z-label [zunit]

J0 1         #
             set x=abs($1) set t=x/3 set u=(t<1) ? t**2 : 1/(t+1e-9)
             set v=u/3
             set $0=(t<1) ? 1 + \
             u*(-2.2499997+u*( 1.2656208+u*(-0.3163866+ \
             u*( 0.0444479+u*(-0.0039444+u*0.00021))))) : \
             (0.79788456+u*(-0.00000077+u*(-0.0055274 +u*(-0.00009512+ \
             u*( 0.00137237+u*(-0.00072805+u*0.00014476))))))* \
             cos(x-0.78539816+u*(-0.04166397+u*(-0.00003954+u*(0.00262573+ \
             u*(-0.00054125+u*(-0.00029333+u*0.00013558))))))*sqrt(v)
