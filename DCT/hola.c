#include "mex.h"

/* mexFunction es la rutina de enlace con el código C. */ 
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mexPrintf("Hola Mundo!\n");
}