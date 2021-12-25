function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2

    pts2 = zeros(size(pts1, 1), 2);

    for i = 1 : size(pts1, 1)

        x = pts1(i, 1);
        y = pts1(i, 2);

        p1 = [x; y; 1];

        epipolar_line = F * p1;

        window = 3;

        window1 = double(im1((y - window) : (y + window), (x - window) : (x + window), :));

        dist = +inf; 

        epipolar_line = epipolar_line / -epipolar_line(2);

        window_im2 = 10;

        for j = x - window_im2 : x + window_im2
            x1 = j;
            y1 = (epipolar_line(1) * j) + epipolar_line(3);
            window2 = double(im2((y1 - window) : (y1 + window), (x1 - window) : (x1 + window), :));
            difference = (window1 - window2) .^ 2;

            for k = 1:3
                difference = sum(difference);        
            end

            distance = sqrt(difference);

            if(distance < dist)
                dist = distance;
                pts2(i, 1) = x1;
                pts2(i, 2) = y1;
            end
        end
    end
end

