% La matrice di adiacenza deve essere chiamata G, il cell array degli URL deve essere chiamato U.

load(input('Inserire struttura dati: ','s'));

[R, outdegree, indegree] = pagerank(G);

% Suddividere i plot in più finestre
figure(1);
spy(G);
title('Grafico che visualizza la struttura di G.');

figure(2);
gs = digraph(G');
p = plot(gs);
layout(p,'force');
title('Grafo associato a G.');

figure(3);
bar(R);
title('Grafico a barre del PageRank.');

% Ordinamento e stampa
outdegree = outdegree';
T = table(U, indegree, outdegree, R);
T = sortrows(T, 'R', 'descend');
T = head(T,15);
disp(T);

%%%% Plot del sottografo %%%%%

M = mean(R); % Calcolo media.
rank_sorted = sort(R(R>M)); % Vettore dei rank ordinati.
g_media = subgraph(gs, R>M); % Sottografo dei nodi con rank maggiori della media.


% Plot effettivo del sottografo
figure(4);
p = plot(g_media, 'NodeLabel',{},'MarkerSize',rank_sorted*500, 'NodeCData', rank_sorted, 'EdgeColor',[.7 .7 .7]);
colormap jet; % Impostazione colormap per bar laterale.
layout(p,'force'); % Disposizione nodi
ylabel(colorbar, 'PageRank'); % Aggiunta label alla bar laterale.

% Visualizzazione rank nella label del nodo (vedi funzione GraphCursorCallback.m).
g_media.Nodes.PageRank = rank_sorted; % Impostiamo la voce PageRank nella label.
hdt = datacursormode;
hdt.UpdateFcn = @(obj, event_obj) GraphCursorCallback(obj, event_obj, g_media.Nodes); % Visualizzazione Label

% Aggiunta titolo al grafico.
title(['Sottografo dei nodi con rank maggiore della media dei rank ' num2str(M,16) '. ']);

%%%% Fine plot del sottografo %%%%%
