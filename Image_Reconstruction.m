f = SimpleFunctions();
n = -5:5;

% Question 1A
% y = f.unitstep(n) - 2*f.unitstep(n-1) + f.unitstep(n-4);
% Question 1B
% y = (n+2).*f.unitstep(n+2) - 2*f.unitstep(n) - n.*f.unitstep(n-4);
% % Question 1C
% y = f.delta(n+1) - f.delta(n) + f.unitstep(n+1) - f.unitstep(n-2);
% % Question 1D
y = exp(0.8*n).*f.unitstep(n+1) + f.unitstep(n);

stem(n,y,'LineWidth', 3);
text(-5, 50,'Marryam Kamal - 400446997', 'FontSize', 10)

opts = detectImportOptions('course_grades_2024.xlsx');
opts = setvartype(opts, {'ID_Number', 'Name'}, 'string');
T = readtable('course_grades_2024.xlsx', opts);

% Question 2A
function maxLab(t)
    t([1],:) = [];
    total_lab_mark = sum(t{:,3:6},2);
    [val, idx] = max(total_lab_mark);
    disp(['Name: ', t.Name(idx), 'Total lab mark: ', val]);
end
%maxLab(T)

% Question 2B
function maxExam(t)
    t([1],:) = [];
    total_exam_mark = sum(t{:,8:11},2);
    [val, idx] = max(total_exam_mark);
    disp(['Name: ', t.Name(idx), 'Total exam mark: ', val]);
end
%maxExam(T)

% Question 2C
function maxFinal(t)
    t([1],:) = [];
    total_mark = sum(t{:,3:11},2);
    [val, idx] = max(total_mark);
    disp(['Name: ', t.Name(idx), 'Total final mark: ', val]);
end
%maxFinal(T)

% Question 2D
newRow = {'Marryam Kamal','400446997',0,0,0,0,0,0,0,0,0};
T = [T;newRow];

img = imread('ee3tp3picture2024.jpg');
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);
red = red*3;
green = green*3;
blue = 0.5*blue;
reconstructed_image = cat(3, red, green, blue);
imshow(reconstructed_image);
