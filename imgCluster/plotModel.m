%% plot model
[pt, face, color] = showOff('kxm.off');
color = color / 255.0;
% figure
[nfa, dim] = size(face);
hold on
[npt, dim] = size(pt);
% for i=1:npt
%     plot3(pt(i,1),pt(i,2),pt(i,3),'.');
% end
for i=1:nfa
    plot3([pt(face(i,1),1),pt(face(i,2),1)],...
        [pt(face(i,1),2),pt(face(i,2),2)],...
        [pt(face(i,1),3),pt(face(i,2),3)]);
    plot3([pt(face(i,1),1),pt(face(i,3),1)],...
        [pt(face(i,1),2),pt(face(i,3),2)],...
        [pt(face(i,1),3),pt(face(i,3),3)]);
    plot3([pt(face(i,3),1),pt(face(i,2),1)],...
        [pt(face(i,3),2),pt(face(i,2),2)],...
        [pt(face(i,3),3),pt(face(i,2),3)]);
end
