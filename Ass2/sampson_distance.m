function d = sampson_distance(F, p1, p2)
    % calculate the sampson distanec
    p1 = [p1; ones(1,size(p1,2))];
    p2 = [p2; ones(1,size(p2,2))];

    fp1 = (F*p1).^2;
    fp2 = (F'*p2).^2;

    d = transpose((p2'*F*p1).^2/(fp1(1,:) + fp1(2,:) + fp2(1,:) + fp2(2,:)));

end