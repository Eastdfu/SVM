GX = [X(1,:);X(10,:);X(100,:);X(1000,:);X(1500,:);];
GY = [y(1);y(10);y(100);y(1000);y(1500)];
opgap = poptval - doptval
dgap = sum((X * pw + pb) - (X * dw' + db)) / 1500