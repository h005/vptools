function dis = mvDis(A,B)
    dis = norm(expm(logm(A*inv(B))));
