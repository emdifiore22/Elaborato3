% Capucchiò, vedi che le matrici di output di surfer s'hann chiammà G e U.

variabile = input('Inserire struttura dati: ','s');
load(variabile);

[R, out, in] = pagerank(G);

% Suddividere i plot in più finestre
subplot(1,3,1);
spy(G);
gs = digraph(G')
subplot(1,3,2);
p = plot(gs);
layout(p,'force');
subplot(1,3,3);
bar(R);

% Ordinamento e stampa
T = table(U, in, out', R);
T_ord = sortrows(T, 'R', 'descend');
T_new = head(T_ord,15);
disp(T_new)
