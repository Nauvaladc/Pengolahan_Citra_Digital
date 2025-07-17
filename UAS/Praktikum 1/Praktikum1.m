pkg load image

% 1. Membaca citra
citra = imread('Mobil.jpg'); % Ganti nama_file.jpg dengan nama file citra kamu

% 2. Menampilkan ukuran citra
[baris, kolom, kanal] = size(citra);
fprintf('Ukuran citra: %d baris x %d kolom x %d kanal\n', baris, kolom, kanal);

% 3. Mengonversi citra warna ke grayscale
if kanal == 3 % Cek jika citra berwarna (RGB)
    citra_gray = rgb2gray(citra);
else
    citra_gray = citra; % Sudah grayscale
end

% 4. Mengonversi citra grayscale ke biner
threshold = graythresh(citra_gray); % Otsu thresholding
citra_biner = im2bw(citra_gray, threshold);

% 5. Menampilkan hasil
figure_handle = figure;
subplot(1,3,1); imshow(citra); title('Citra Asli');
subplot(1,3,2); imshow(citra_gray); title('Citra Grayscale');
subplot(1,3,3); imshow(citra_biner); title('Citra Biner');

% 6. Menyimpan hasil
imwrite(citra_gray, 'citra_grayscale.jpg');
imwrite(citra_biner, 'citra_biner.jpg');
print(figure_handle, 'hasil_display.png', '-dpng'); % simpan dalam format PNG
disp('Hasil Berhasil Disimpan');

