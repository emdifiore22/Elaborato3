% LANCIARE LO SCRIPT 'elaborato_pagerank' ED INSERIRE IL NOME DEL FILE CONTENTE LE DUE MATRICI.
% La matrice di adiacenza deve essere chiamata G, il cell array degli URL deve essere chiamato U.

load(input('Inserire struttura dati: ','s'));


figure('Name','Struttura di G', 'NumberTitle','off');
spy(G);
title('Grafico che visualizza la struttura di G.');


figure('Name','Grafo di G', 'NumberTitle','off');
gs = digraph(G', 'omitselfloops');
p = plot(gs);
layout(p,'force');
title('Grafo associato a G.');

% Calcolo del pagerank
[R, outdegree, indegree] = pagerank(G);


figure('Name','Bar Plot degli in-degree di G', 'NumberTitle','off');
bar(indegree);
xlabel("Nodi");
ylabel("in-degree");
title('In-degree di G.');

% IN-DEGREE - OUT-DEGREE
figure('Name','Bar Plot degli out-degree di G', 'NumberTitle','off');
bar(outdegree);
xlabel("Nodi");
ylabel("out-degree");
title('Out-degree di G.');

figure('Name','Grafico del PageRank di G', 'NumberTitle','off');
bar(R);
xlabel("Nodi");
ylabel("PageRank");
title('Grafico a barre del PageRank.');


% TABELLA 
outdegree = outdegree';
T = table(U, indegree, outdegree, R);
T = sortrows(T, 'R', 'descend');
T = head(T,15);
disp(T);


%%%% Plot del sottografo %%%%%

M = mean(R); % Calcolo media.
rk_s = sort(R(R>M)); % Vettore dei rank ordinati.
g_media = subgraph(gs, R>M); % Sottografo dei nodi con rank maggiori della media.


% Plot effettivo del sottografo
figure('Name','Sottografo di G', 'NumberTitle','off');
sizes = rk_s*500;
gr = [.7 .7 .7];
p=plot(g_media,'NodeLabel',{},'MarkerSize',sizes,'NodeCData',rk_s,'EdgeColor',gr);
colormap jet; % Impostazione colormap per bar laterale.
layout(p,'force'); % Disposizione nodi
ylabel(colorbar, 'PageRank'); % Aggiunta label alla bar laterale.

% Visualizzazione rank nella label del nodo (vedi funzione GraphCursorCallback.m).
g_media.Nodes.PageRank = rk_s; % Impostiamo la voce PageRank nella label.
hdt = datacursormode;
hdt.UpdateFcn=@(obj, event_obj)GraphCursorCallback(obj,event_obj,g_media.Nodes);

% Aggiunta titolo al grafico.
title(['Sottografo dei nodi con rank maggiore della media M=' num2str(M,16) '.']);