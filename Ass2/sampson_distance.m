function d = sampson_distance(F, p1, p2)

p1 = [p1, ones(size(p1,1),1)]';
p2 = [p2, ones(size(p2,1),1)]';

fp1 = (F*p1).^2;
fp2 = (F'*p2).^2;

d = (p2'*F*p1).^2/(fp1(1,:) + fp1(2,:) + fp2(1,:) + fp2(2,:));

end