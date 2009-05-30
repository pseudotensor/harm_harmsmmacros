
// whether to use para with WENO
#define PARAMODWENO 0

// whether to use para for only contacts (0) or full hybrid method based upon indicators (e.g. stiffindicator)
#define FULLHYBRID 1

// see interppoint.para.c on the meaning of these
#define DOPPMCONTACTSTEEP 0 // contact steepener is invalid procedure for general problems with gravity and such things (e.g. can steepend density profiles due to force balance! -- like disks!!!)
#define DOPPMSTEEPVARTYPE 0 // not sure if field method works well enough to use generally
#define DOPPMREDUCE 0 // stay speculative

// whether to use MC when WENO reduces (only replaces WENO part, not PARA part)
// Point is that WENO3 is much more diffusion than MC
// may introduce slight switching problem when MC goes sharp
#define USEMCFORLOWERORDERWENO 0
