/* ========================================================================== */
/* FLYSPECK - CODE FORMALIZATION                                              */
/*                                                                            */
/* Chapter: nonlinear inequalities                                           */
/* Author:  Thomas Hales     */
/* Date: 1997, 2010-09-04                                                    */
/* Date: Moved from taylorData 2012-6-1                                      */
/* ========================================================================= */


/*
CLASS
	FunctionLibraryB

	A library of static Functions of six variables.

OVERVIEW TEXT

	This class contains the most important Functions for
	sphere packings.  Much more general functions can be built
	up by taking linear combinations of these, using the operator
	overloading on addition and scalar multiplication for
	Functions.

AUTHOR
	
	Thomas C. Hales
*/


class FunctionLibraryB
{

  public:
	//////////
	// reorder args f(x2,x3,x1,x5,x6,x2); etc.
	//
 static Function rotate2(const Function&);
 static Function rotate3(const Function&);
 static Function rotate4(const Function&);
 static Function rotate5(const Function&);
 static Function rotate6(const Function&);


	//////////
	// unit is the constant function taking value 1.
	// x1,..,x6 are the squares of the edge lengths.
	// y1,...y6 are the edge lengths.
	// dih,dih2,dih3, are the dihedral angles along the first
	// three edges.
	// sol is the solid angle of a simplex
        // all of these are expressed in terms of the variables xi.
	//
 static const Function unit,x1,delta,dih,sol,rad2,

   // autogenerated.
   x2,x3,x4,x5,x6,
   y1,y2,y3,y4,y5,y6,
   delta_x4,x1_delta_x,delta4_squared_x,vol_x,
   dih2,dih3,dih4,dih5,dih6,
   ldih_x,ldih2_x,ldih3_x,ldih5_x,ldih6_x,
   eulerA_x;
	//
static void selfTest();

};