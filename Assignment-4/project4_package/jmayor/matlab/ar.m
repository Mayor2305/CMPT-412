close all;
clear vars; 
ar_source = loadVid('../data/ar_source.mov');
book_mov = loadVid('../data/book.mov');
image = imread('../data/cv_cover.jpg');
write_file = VideoWriter('../results/augmentedR.avi');

open(write_file);
for i = 1: size(ar_source, 2)
    book_frames = book_mov(i).cdata;
    ar_frames = ar_source(i).cdata;

    [locs1, locs2] = matchPics(book_frames, image);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    ar_frames = imcrop(ar_frames, [0 45 size(ar_frames, 2) size(ar_frames, 1)- 100]);
    ar_frames = imresize(ar_frames, [ size(image, 1) size(image, 2)]);
    imshow (compositeH(inv(bestH2to1), ar_frames, book_frames)) ;
    writeVideo (write_file, compositeH (inv(bestH2to1) , ar_frames, book_frames));
end
close(write_file);
