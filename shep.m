shep1   0     #
        #
        #
        # gogrmhd
        #
        cd /data2/jmckinne/runlocaldipole3dfiducial/moviefinal17noavg
        #cat datavsrsharenew.txt | column -t | less -S
        #
        da datavsrsharenew.txt
        lines 1 1000000
        read '%d %g %g %g %g' {ii r hoverr theta1 theta2}
        #
        pl 0 r hoverr 1100
        #
        set R=r*sin(hoverr)
        set z=r*cos(hoverr)
        #
        pl 0 z R
        points z R
        #