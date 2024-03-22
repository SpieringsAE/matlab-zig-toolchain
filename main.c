/* Copyright 2012 The MathWorks, Inc. */
/*
** coderrand_main.c
*/
#include <stdio.h>
#include <stdlib.h>
#include "coderrand.h"
#include "coderrand_initialize.h"
#include "coderrand_terminate.h"

int main()
{
    coderrand_initialize();
    
    printf("coderrand=%g\n", coderrand());
    
    coderrand_terminate();
    
    return 0;
}
/* LocalWords:  coderrand
 */
