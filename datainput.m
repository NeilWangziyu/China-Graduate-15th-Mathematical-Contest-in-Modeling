Population = [3727.57, 1092.9, 351.96, 883.21, 988.1, 2418.3, 53.03, 1604.47, 3075.16, 1089.29, 672.8, 2702.67];
Population = Population/100;

Distance = [0	1059.227	2452.198	910.455	598.455	1012.756	2595.691	1518.324	1455.916	1026.878	2077.904	1873.325;
    0	0	3052.653	1966.518	1640.482	1675.735	3571.429	2572.187	2514.618	2002.003	3136.412	2798.873;
    0	0	0	2110.147	2435.674	3257.623	1602.334	2048.347	2290.64	2763.725	2488.466	3320.708;
    0	0	0	0	434.127	1214.3	1768.667	608.195	573.327	653.827	1187.179	1344.968;
    0	0	0	0	0	825.127	2202.165	1005.113	890.331	476.656	1506.046	1320.376;
    0	0	0	0	0	0	2914.652	1655.563	1447.67	683.667	1954.749	1204.77;
    0	0	0	0	0	0	0	1261.398	1492.829	2242.249	1263.756	2373.878;
    0	0	0	0	0	0	0	0	259.807	980.868	638.102	1284.297;
    0	0	0	0	0	0	0	0	0	764.354	622.021	1032.192;
    0	0	0	0	0	0	0	0	0	0	1290.38	850.396;
    0	0	0	0	0	0	0	0	0	0	0	1134.423;
    0	0	0	0	0	0	0	0	0	0	0	0];

load border;

city.long = [116.808335 126.63333 87.68333 108.95 113.65 121.43333 91 ... 
    104.06667 106.45 114.31667 102.73333 113.65];
city.lat = [39.525 45.75 43.76667 34.26667 34.76667 31.23 29.6 30.66667 ...
    29.56667 30.51667 25.05 22.89167];

save DATA;