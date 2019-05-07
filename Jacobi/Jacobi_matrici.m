function [x, niter, resrel] = Jacobi_matrici(A, b, TOL, MAXITER)

narginchk(2,4);

% controlla ingressi vuoti
if(isempty(A) || isempty(b))
   error("Matrice A o vettore b vuoti.");
end
 
% controlla se la matrice A è di tipo sparse
if(issparse(A)==0)
    error("La matrice A non è tipo sparse.");
end

[n,m] = size(A);
 
% controlla se A è una matrice quadrata.
if(m~=n)
   error("Matrice A non quadrata.");
end

if(nnz(diag(A)) ~= n)
    error("La matrice A ha elementi nulli sulla diagonale. Riordinare la matrice e rieseguire l'algoritmo.");
end

% controlla se b è un vettore.
if(~isvector(b) || isscalar(b) || isa(b,'cell') || isa(b,'table') || isa(b,'struct'))
    error("b non è un vettore.");
end

% controlla se b è un vettore numeric
if(~isnumeric(b))
    error("Il vettore b non è vettore numerico.");
end

I=length(b);

% controlla la lunghezza di b.
if(I~=n)
    error("Il vettore dei termini noti non rispetta le dimensioni di A.");
end
 
% controlli parametri facoltativi
if(nargin == 2)
    
    TOL = 10^(-6);
    MAXITER = 500;
    
elseif(nargin == 3)
    
    MAXITER = 500;
   
    if ( (isnumeric(TOL) == 0) || (isreal(TOL) == 0) || (all(isfinite(TOL)) == 0) || (length(TOL) > 1) || TOL <= eps )
        TOL = 10^(-6);
        warning("TOL scorretto. Impostato a 10^(-6)");
    end
    
elseif(nargin == 4)
    
    if ( (isnumeric(TOL) == 0) || (isreal(TOL) == 0) || (all(isfinite(TOL)) == 0) || (length(TOL) > 1) || TOL <= eps)
        TOL = 10^(-6);
        warning("TOL scorretto. Impostato a 10^(-6)");
    end
    
    % controllo che MAXITER sia reale e finito
    if ( (isnumeric(MAXITER) == 0) || (isreal(MAXITER) == 0) || (all(isfinite(MAXITER)) == 0) || (length(MAXITER) > 1) || (MAXITER<=0) )
        MAXITER = 500;
        warning("Numero massimo di iterazioni scorretto. Impostato a 500.");
    end
        
    MAXITER = floor(MAXITER);
    
end

x0 = zeros(n,1);
niter = 0;

P = diag(diag(A));                                                    
N = P - A;                                                            
invP = inv(P);                                                    
B = eye(n,n) - invP*A;                                                
c = invP*b;                                                           
x = B*x0 + c;                                                      

TOLR = max(TOL*norm(x, "inf"), realmin);

while(norm(x - x0,"inf") >= TOLR && niter < MAXITER )
    x0 = x;
    x = B*x0 + c;
    TOLR = max(TOL*norm(x, "inf"), realmin);
    niter = niter + 1;
end

if(niter == MAXITER)
    warning("Attenzione! È stato raggiunto il numero massimo di iterazioni. Il risultato potrebbe non essere accurato.");
end

resrel = norm(b-A*x,"inf")/norm(b,"inf");

end

