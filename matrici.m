% AD OGNI TEST STAMPARE: niter, raggio spettrale, norma di B.

n = 5000;
e = ones(n,1);

% caso in cui il raggio spettrale < 1 e buon condizionamento
% CONVERGE
Z = spdiags([e 3*e 15*e -e e], [-1300 -500 0 400 2500], n, n);

% caso in cui il raggio spettrale < 1 (ma maggiore di prima) e buon condizionamento (ma maggiore rispetto a prima)
% CONVERGE ma con più iterazioni
X = gallery('poisson',20);

% caso in cui diagonale non strettamente dominante e buon condizionamento
% (vale per tutti i tol)
% NON CONVERGE anche con Tol = 10^-15 e aumentando le iterazioni.
W = spdiags([e 5*e 2*e -e e], [-1300 -500 0 400 2500], n, n);

% condizionamento = 150.4169, norma di B = 1, p(B) =  0.9808 (TOL : -12 to -15)
% CONVERGE dopo 1613
Q = gallery('poisson',15);

