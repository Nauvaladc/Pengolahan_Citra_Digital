%% 1. Baca dan konversi gambar
img = imread('Mobil.jpg');
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

%% 2. Definisikan beberapa noise
img_gauss = imnoise(img_gray, 'gaussian', 0, 0.01); % Gaussian noise
img_saltpepper = imnoise(img_gray, 'salt & pepper', 0.05); % Salt & Pepper noise
img_speckle = imnoise(img_gray, 'speckle', 0.04); % Speckle noise

noise_list = {img_gauss, img_saltpepper, img_speckle};
noise_name = {'Gaussian', 'Salt & Pepper', 'Speckle'};

%% 3. Definisikan beberapa filter
h_mean = fspecial('average', 3); % Mean filter kernel 3x3
h_gauss = fspecial('gaussian', 3, 0.5); % Gaussian filter kernel 3x3

%% 4. Proses dan tampilkan hasil untuk semua noise dalam satu display
f = figure('Name', 'Hasil Filter pada Semua Noise');

for i = 1:length(noise_list)
    noisy_img = noise_list{i};
    img_mean = imfilter(noisy_img, h_mean);
    img_gaussian = imfilter(noisy_img, h_gauss);
    img_median = medfilt2(noisy_img, [3 3]);

    img_mean_flip = fliplr(img_mean);
    img_gaussian_flip = fliplr(img_gaussian);
    img_median_flip = fliplr(img_median);

    % Baris ke-i untuk masing-masing noise
    row = i;

    subplot(3, 7, (row-1)*7 + 1); imshow(noisy_img); title([noise_name{i} ' Noise']);
    subplot(3, 7, (row-1)*7 + 2); imshow(img_mean); title('Mean');
    subplot(3, 7, (row-1)*7 + 3); imshow(img_gaussian); title('Gaussian');
    subplot(3, 7, (row-1)*7 + 4); imshow(img_median); title('Median');
    subplot(3, 7, (row-1)*7 + 5); imshow(img_mean_flip); title('Mean Flip');
    subplot(3, 7, (row-1)*7 + 6); imshow(img_gaussian_flip); title('Gauss Flip');
    subplot(3, 7, (row-1)*7 + 7); imshow(img_median_flip); title('Median Flip');
end

set(f, 'Position', [100 100 1400 600]); % Perbesar window agar hasil subplot rapi
print(f, 'hasil_filter_noise.png', '-dpng');

