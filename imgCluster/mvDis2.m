function dis = mvDis2(A,B)
    dis = norm(logm(expm(A*inv(B))));
