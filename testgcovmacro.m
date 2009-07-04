

set i={0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 4}
set j={0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3 4}
#set gcovi=(i>=j) ? i : j
set gcovi=((i>=j)*(i-j) + j)
#set gcovj=(i>=j) ? j : i
set gcovj=((i>=j)*(j-i) + i)
set ind0=gcovj*4+gcovi
set ind=ind0 - (gcovj>0 ? gcovj : 0) - (gcovj-1>0 ? gcovj-1 : 0) - (gcovj-2>0 ? gcovj-2 : 0)
set indsasha = (i+j)/2 + (8-abs(j-i))*abs(j-i)/2
print {i j gcovi gcovj ind0 ind indsasha}



# use: gcov[ind]
# where
#define GCOVI(i,j) (i>=j) ? i : j
#define GCOVJ(i,j) (i>=j) ? j : i
#define GIND(i,j) GCOVJ(i,j)*4 + GCOVI(i,j) - MAX(GCOVJ(i,j),0) - MAX(GCOVJ(i,j)-1,0) - MAX(GCOVJ(i,j)-2,0)


