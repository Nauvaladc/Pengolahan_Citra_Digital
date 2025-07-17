% 1. Menampilkan histogram citra warna dan grayscale
img = imread('Mobil.jpg');
f1 = figure('Name','Histogram Warna dan Grayscale');
subplot(2,2,1); imhist(img(:,:,1)); title('Histogram Red');
subplot(2,2,2); imhist(img(:,:,2)); title('Histogram Green');
subplot(2,2,3); imhist(img(:,:,3)); title('Histogram Blue');
img_gray = rgb2gray(img);
subplot(2,2,4); imhist(img_gray); title('Histogram Grayscale');
print(f1, 'histogram_warna_grayscale.png', '-dpng'); % simpan display

% 2. Pisahkan channel RGB dan tampilkan
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
f2 = figure('Name','Channel RGB');
subplot(1,3,1); imshow(R); title('Channel Merah');
subplot(1,3,2); imshow(G); title('Channel Hijau');
subplot(1,3,3); imshow(B); title('Channel Biru');
print(f2, 'channel_rgb.png', '-dpng');

% 3. Meningkatkan kecerahan dan tampilkan bersama
nilai_bright = 50; % Nilai kecerahan tetap
img_bright = img + nilai_bright;
img_bright(img_bright > 255) = 255; % Hindari overflow
img_bright = uint8(img_bright);
f3 = figure('Name','Citra Asli dan Lebih Cerah');
subplot(1,2,1); imshow(img); title('Citra Asli');
subplot(1,2,2); imshow(img_bright); title('Citra Lebih Cerah');
print(f3, 'cerah.png', '-dpng');

% 4. Meregangkan kontras (contrast stretching)
img_gray_double = double(img_gray);
min_val = min(img_gray_double(:));
max_val = max(img_gray_double(:));
img_stretch = (img_gray_double - min_val) * 255 / (max_val - min_val);
img_stretch = uint8(img_stretch);
f4 = figure('Name','Regang Kontras dan Histogram');
subplot(2,2,1); imshow(uint8(img_gray)); title('Sebelum Regang Kontras');
subplot(2,2,2); imhist(uint8(img_gray)); title('Hist. Sebelum');
subplot(2,2,3); imshow(img_stretch); title('Setelah Regang Kontras');
subplot(2,2,4); imhist(img_stretch); title('Hist. Setelah');
print(f4, 'regang_kontras.png', '-dpng');

% 5. Membalik citra (flip horizontal) dan tampilkan berdampingan
img_flip = fliplr(img);
f5 = figure('Name','Flip Horizontal');
subplot(1,2,1); imshow(img); title('Citra Asli');
subplot(1,2,2); imshow(img_flip); title('Citra Flip Horizontal');
print(f5, 'flip_horizontal.png', '-dpng');

% 6. Pemetaan nonlinear (log transformation) dan tampilkan berdampingan
c = 255 / log(1 + 255);
img_log = c * log(1 + double(img_gray));
img_log = uint8(img_log);
f6 = figure('Name','Log Transform');
subplot(1,2,1); imshow(uint8(img_gray)); title('Citra Grayscale');
subplot(1,2,2); imshow(img_log); title('Log Transform');
print(f6, 'log_transform.png', '-dpng');

% 7. Pemotongan aras keabuan (thresholding manual)
batas_bawah = 100; % Bisa disesuaikan
batas_atas  = 180; % Bisa disesuaikan
img_cut = img_gray;
img_cut(img_gray < batas_bawah | img_gray > batas_atas) = 0;
f7 = figure('Name','Pemotongan Aras Keabuan');
subplot(1,2,1); imshow(uint8(img_gray)); title('Citra Grayscale');
subplot(1,2,2); imshow(uint8(img_cut)); title('Hasil Pemotongan');
print(f7, 'pemotongan_aras_keabuan.png', '-dpng');

% 8. Ekualisasi histogram dan tampilkan hasil + histogram dalam 1 window
img_eq = histeq(uint8(img_gray));
f8 = figure('Name','Ekualisasi Histogram');
subplot(2,2,1); imshow(uint8(img_gray)); title('Sebelum Ekualisasi');
subplot(2,2,2); imshow(img_eq); title('Setelah Ekualisasi');
subplot(2,2,3); imhist(uint8(img_gray)); title('Hist. Sebelum');
subplot(2,2,4); imhist(img_eq); title('Hist. Setelah');
print(f8, 'ekualisasi_histogram.png', '-dpng');

