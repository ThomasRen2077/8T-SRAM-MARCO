addpath('/opt/cadence/INNOVUS201/tools.lnx86/spectre/matlab/64bit');

directory0 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result0');
directory1 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result1');
directory2 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result2');
directory3 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result3');
directory4 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result4');
directory5 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result5');
directory6 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result6');
directory7 = sprintf('%s/MATLAB/%s.psf', getenv('HOME'), '8T_Array_Result7');

Vdd = 1.2; 



% get input signals
Result_0 = cds_srr(directory0, 'tran-tran', '/Result0', 0);
Result_1 = cds_srr(directory1, 'tran-tran', '/Result1', 0);
Result_2 = cds_srr(directory2, 'tran-tran', '/Result2', 0);
Result_3 = cds_srr(directory3, 'tran-tran', '/Result3', 0);
Result_4 = cds_srr(directory4, 'tran-tran', '/Result4', 0);
Result_5 = cds_srr(directory5, 'tran-tran', '/Result5', 0);
Result_6 = cds_srr(directory6, 'tran-tran', '/Result6', 0);
Result_7 = cds_srr(directory7, 'tran-tran', '/Result7', 0);


t_ps =  Result_0.time * 1e9;

R_0 = Result_0.V; 
R_1 = Result_1.V; 
R_2 = Result_2.V; 
R_3 = Result_3.V; 
R_4 = Result_4.V; 
R_5 = Result_5.V; 
R_6 = Result_6.V; 
R_7 = Result_7.V; 

R = [R_0, R_1, R_2, R_3, R_4, R_5, R_6, R_7];

t1 = linspace(0, 7, 8);
t2 = linspace(0, 7, 8);

for row = 1:8
    for col = 1:8
        for i = 1:length(t_ps)
            if(t_ps(i) > 10.5 + (col - 1) * 24 + (row - 1) * 192) 
                t1(col) = i;
                break;
            end
        end

        R_col = R(:,col);

        if(Read_0(R_col, t1(col), Vdd)) 
            disp(['Read 0 Successfully at Cell Row ', num2str(row - 1)  ', Col ', num2str(col - 1)]);
        else
            disp(['Read 0 Failed at at Cell Row ', num2str(row - 1)  ', Col ', num2str(col - 1)]);
        end


        for i = 1:length(t_ps)
            if(t_ps(i) > 22.5 + (col - 1) * 24 + (row - 1) * 192) 
                t2(col) = i;
                break;
            end
        end

        R_col = R(:,col);

        if(Read_1(R_col, t2(col), Vdd)) 
            disp(['Read 1 Successfully at Cell Row ', num2str(row - 1)  ', Col ', num2str(col - 1)]);
        else
            disp(['Read 1 Failed at at Cell Row ', num2str(row - 1)  ', Col ', num2str(col - 1)]);
        end

    end
end

function a = Read_0(v, t, Vdd)
    if(v(t) < 0.2 * Vdd)
        a =  true;
    else
        a = false;
    end
end

function a = Read_1(v, t, Vdd)
    if(v(t) > 0.8 * Vdd)
        a =  true;
    else
        a = false;
    end
end
