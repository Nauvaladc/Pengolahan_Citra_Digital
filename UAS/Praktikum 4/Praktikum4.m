%% 1. Setup axis
figure;
axis equal;
hold on;
axis([0 400 0 400]);
set(gca, 'YDir','reverse'); % Supaya Y ke bawah seperti koordinat gambar
xlabel('X');
ylabel('Y');

%% 2. Load texture image
texture = imread('polaka.jpg'); % Ganti dengan file tekstur kamu
if size(texture,3)==3
    texture = rgb2gray(texture); % Pastikan grayscale agar mudah
end

%% 3. Definisi objek segiempat (koordinat awal)
w = 100; h = 80; % ukuran segiempat
obj_center = [200, 200];
half_w = w/2; half_h = h/2;
obj_corners = [obj_center + [-half_w, -half_h];
               obj_center + [half_w, -half_h];
               obj_center + [half_w, half_h];
               obj_center + [-half_w, half_h]]';

%% 4. Fungsi rotasi 2D
rotate2d = @(theta, P, C) ([cosd(theta) -sind(theta); sind(theta) cosd(theta)] * (P - C) + C);

%% 5. Animasi transformasi, render tekstur & bounding box
for t = 0:2:180
    cla; % Bersihkan figure (clear axis)

    % Pola perpindahan (misal geser X dan Y sinusoidal)
    cx = obj_center(1) + 60 * sin(deg2rad(t));
    cy = obj_center(2) + 40 * cos(deg2rad(t));
    new_center = [cx; cy];

    % Rotasi objek
    new_corners = zeros(2,4);
    for k = 1:4
        new_corners(:,k) = rotate2d(t, obj_corners(:,k), obj_center');
    end
    % Geser ke posisi baru
    delta_c = new_center - obj_center';
    new_corners = new_corners + delta_c;

    % Hitung bounding box objek (untuk area gambar tekstur)
    min_x = floor(min(new_corners(1,:)));
    max_x = ceil(max(new_corners(1,:)));
    min_y = floor(min(new_corners(2,:)));
    max_y = ceil(max(new_corners(2,:)));

    % Render tekstur pada area bounding box
    box_w = max_x - min_x + 1;
    box_h = max_y - min_y + 1;
    % Resize tekstur sesuai bounding box
    texture_box = imresize(texture, [box_h, box_w]);
    % Tampilkan tekstur di bounding box (pakai image)
    image([min_x max_x], [min_y max_y], texture_box);

    % Gambar garis objek segiempat (line objek)
    line([new_corners(1,:) new_corners(1,1)], [new_corners(2,:) new_corners(2,1)], ...
        'Color','r','LineWidth',2);

    title(['Frame t = ' num2str(t)]);
    drawnow;
    pause(0.05);
end

hold off;

