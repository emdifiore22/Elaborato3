Elaborato3

Scrivere un function file che implementa :
L’ algoritmo di Jacobi per la risoluzione di un sistema lineare Ax=b con A sparsa.
Parametri di input:

• A matrice dei coefficienti di grandi dimensioni e di tipo sparso

• b vettore dei termini noti

• TOL facoltativo , tolleranza gestita dall’utente, se omessa TOL=10-6

• MAXITER facoltativo, numero massimo di iterazioni, se omesso MAXITER=500.

Parametri di output:

• x soluzione calcolata del sistema

• niter facoltativo ,numero di iterazioni

• resrel facoltativo ,norm(b-A*x)/norm(b) residuo relativo

Se la function non converge stampa un messaggio di warning con il numero di iterazioni raggiunto ed il residuo relativo. Si testi il software su matrici sparse di notevoli dimensioni, generate usando funzioni Matlab,
che siano non singolari e ben condizionate. Illustrare, attraverso grafico, la struttura delle matrici di test.