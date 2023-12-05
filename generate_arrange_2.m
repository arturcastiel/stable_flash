function [arrange] = generate_arrange_2(num)
all_num = [1:num]';
ii = repelem(all_num,num,1);
jj = repmat(all_num,num,1);
arrange = [ii jj];
end

