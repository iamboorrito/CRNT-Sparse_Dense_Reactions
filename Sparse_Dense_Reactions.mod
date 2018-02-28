/*********************************************
 * OPL 12.8.0.0 Model
 * Author: evan
 * Creation Date: Feb 23, 2018 at 10:59:47 AM
 *********************************************/

// Data declarations
int rows = ...;
int cols = ...;
int ubound = ...;
float Y[1..rows][1..cols] = ...;
float M[1..rows][1..cols] = ...;
float eps = ...;

// Decision variable declarations
dvar float A[1..cols][1..cols];
dvar int y[1..cols][1..cols];

// Objective
minimize sum(i in 1..cols, j in 1..cols) y[i][j];

// Begin Constraints
subject to {

	// A is a conservation matrix where its
	// columns sum to 0
	forall(j in 1..cols){
		sum(i in 1..cols) A[i][j] == 0;
		
		// The off-diagonal entries are nonnegative
		// and diagonal entries are nonpositive.
		forall(i in 1..cols){
				
			// y[i][j] is binary
			0 <= y[i][j] <= 1;
			
			if(i != j){
				-A[i][j] + ubound*y[i][j] >= 0;
				A[i][j] - eps*y[i][j] >= 0;			
				A[i][j] >= 0;
				A[i][j] <= ubound;
			}else{
				A[i][j] <= 0;			
			}
		}
		
	}
	
	// YA = M
	forall(i in 1..rows){
		forall(j in 1..cols){	
			sum(k in 1..cols) Y[i][k]*A[k][j] == M[i][j];			
		}		
	}
	
}

// Print soln to console
execute DISPLAY{}




