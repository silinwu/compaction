clear
clc
prefix = '/home/pzhang/chen/dlvo/';
middle = 'test_cong1_';
for i = 809:809
name = strcat(prefix,middle,num2str(i,'%04d'),'.h5');
pos = h5read(name,'/Pposition');
nx = h5read(name,'/Nx');
ny = h5read(name,'/Ny');
Np = numel(pos)/6;
R = 5;
ii = 1:Np*2;
Pos = [pos(3*(ii-1)+1),pos(3*(ii-1)+2),pos(3*(ii-1)+3)];
ptag = h5read(name,'/PTag');
% pplist = h5read(name,'/PListPP');
% pglist = h5read(name,'/PListPG');
plist = h5read(name,'/PList');
pforce = h5read(name,'/PForce');
Pforce = [pforce(3*(ii-1)+1),pforce(3*(ii-1)+2),pforce(3*(ii-1)+3)];
num = 0;
color = {'r','g'};
% subplot(121)
figure(1)
viscircles(Pos(1,1:2),R,'color',char(color(ceil(1/Np))));
hold on
quiver(Pos(:,1),Pos(:,2),Pforce(:,1),Pforce(:,2),0.5)
plot(Pos(1,1),Pos(1,2),'b.')
text(Pos(1,1),Pos(1,2),num2str(1-1))
for j=2:Np*2
    if(ptag(j)>0)
        viscircles(Pos(j,1:2),R,'color',char(color(ceil(j/Np))));
        plot(Pos(j,1),Pos(j,2),'b.')
        if(j<=Np)
            text(Pos(j,1),Pos(j,2),num2str(j-1));
        else
            text(Pos(j,1),Pos(j,2),num2str(j-1-Np));
        end
        num = num +1;
    end
end

% for j=1:2:numel(pplist)-1
%     k = [pplist(j),pplist(j+1)]+1;
%     plot(Pos(k,1),Pos(k,2)+rand(1),'b')
% end
% for j=1:2:numel(pglist)-1
%     k = [pglist(j),pglist(j+1)]+1;
%     k = Ghost(k,Np,ptag);
%     plot(Pos(k,1),Pos(k,2)+rand(1),'g')
% end

plot([0 0],[0 ny-1],'k','linewidth',2)
plot([2*R 2*R],[0 ny-1],'k--','linewidth',2)
plot([nx-1 nx-1],[0 ny-1],'k','linewidth',2)
plot([nx-2*R-1 nx-2*R-1],[0 ny-1],'k--','linewidth',2)
% title_name = strcat(num2str(i),'   delta = ',num2str(40-norm(Pos(5,:)-Pos(6,:))));
% dp(i+1,1)= Pos(1,1)-Pos(10,1)+Pos(5,1)-Pos(6,1);
% title(title_name)
title(i)
axis([-2*R nx+2*R 0 ny])
% axis equal

drawnow
% cla(gca,'reset')
% subplot(122)
% ii = 1:numel(plist)/2;
% Plist = [plist(2*(ii-1)+1),plist(2*(ii-1)+2)];
% sp = size(Plist)
% llist=[];
% for j=1:sp(1)
%     k1 = Plist(j,1)+1;
%     k2 = Plist(j,2)+1;
%     flag1= false;
%     flag2= false;
%     
%     if(ptag(k1+100)<0 && ptag(k2+100)<0)
%         flag1 = norm(Pos(k1,:)-Pos(k2,:))<40;
%     elseif(ptag(k1+100)>0)
%         flag2 = norm(Pos(k1+100,:)-Pos(k2,:))<40;
%     elseif(ptag(k2+100)>0)
%         flag2 = norm(Pos(k1,:)-Pos(k2+100,:))<40;
%     end
%     if(flag1||flag2)
%         plot(Plist(j,1),Plist(j,2),'b*')
%         hold on
%         llist=[llist;[k1,k2]-1];
%     end
% end
% 
% list = [];
% for j=1:Np
%     dx = Pos(:,1)-Pos(j,1);
%     dy = Pos(:,2)-Pos(j,2);
%     d = sqrt(dx.^2+dy.^2);
%     kkk1 = find(d<40);
%     kkk2 = find(d>1.5);
%     kkk3 = find(ptag>0);
%     kkkk = intersect(kkk1,kkk2);
%     kkkk = intersect(kkkk,kkk3);
%     for jj=1:numel(kkkk)
%         if(kkkk(jj)<=100)
%             tuple = [j,kkkk(jj)];
%             tuple = sort(tuple);
%             
%             list = [list;tuple-1];
%             
%         else
%             tuple = [j,kkkk(jj)-100];
%             tuple = sort(tuple);
%             
%             list = [list;tuple-1];
%             
%         end
%     end
% end
% list1 = list;
% plot(list1(:,1),list1(:,2),'ro')
% hold off

end