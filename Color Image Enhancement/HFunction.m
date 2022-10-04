function [result] =  HFunction(x)
    Qn = 0.008856;
    if(x > Qn)
        result = x ^ (1.0/3.0);
    else
        result = 7.787 * x + (16.0/116.0);
    end
end