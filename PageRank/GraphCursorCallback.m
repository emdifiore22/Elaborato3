function output_txt = GraphCursorCallback(obj, event_obj,NodeProperties)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text (character vector or cell array of character vectors).

h = get(event_obj,'Target');
pos = get(event_obj,'Position');
ind = find(h.XData == pos(1) & h.YData == pos(2), 1);

output_txt = {['Node ' num2str(ind)], ['PageRank: ' num2str(NodeProperties.PageRank(ind))]};