
function [acc,prec]=metrique(Predicted,Label)



predLabel=im2double(Predicted);
Label=im2double(Label)
[height, width, rim] = size(predLabel);
TP = 0;
FN = 0;
TN = 0;
FP = 0;
Total = 0;

predLabel(predLabel>0) = 1;
Label(Label>0) = 1;

for i = 1: height
    for j= 1: width
        
            if ((predLabel(i,j) == 0) && (Label(i,j) == 0))
                TN = TN +1;
            end
            if ((predLabel(i,j) == 1) && (Label(i,j) == 0))
                FP = FP +1;
            end
            if ((predLabel(i,j) == 1) && (Label(i,j) == 1))
                TP = TP +1;
            end
            if ((predLabel(i,j) == 0) && (Label(i,j) == 1))
                FN = FN +1;
            end
            Total = Total + 1;
        
    end
end

somme=TN+FP+TP+FN;
acc=(TP+TN)/somme;
prec=TP/(TP+FP);
disp(acc);
disp(prec);