%%
proj = [2.16534 0 0 0 
0 2.36135 0 0 
0 0 -1.00001 -1.00001 
0 0 -1 0 ];

near = proj(3,4) / (proj(3,3) - 1)
far = proj(3,4) / (proj(3,3) + 1)
bottom = near * (proj(2,3) - 1) / proj(2,2)
top = near * (proj(2,3) + 1) / proj(2,2)
left = near * (proj(1,3) - 1) / proj(1,1)
right = near * (proj(1,3) + 1) / proj(1,1)

