-- ============================================================
-- SmartPhoneMatch — datos completos (25 móviles)
-- Para una base de datos NUEVA: ejecutar después de schema.sql
-- ============================================================

-- Marcas
INSERT INTO brands (name, slug) VALUES ('Xiaomi', 'xiaomi')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Samsung', 'samsung')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Motorola', 'motorola')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Nothing', 'nothing')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Google', 'google')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('OnePlus', 'oneplus')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Apple', 'apple')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('OPPO', 'oppo')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('HONOR', 'honor')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO brands (name, slug) VALUES ('Sony', 'sony')
  ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Tiendas
INSERT INTO retailers (name, slug) VALUES ('Amazon', 'amazon')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO retailers (name, slug) VALUES ('MediaMarkt', 'mediamarkt')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO retailers (name, slug) VALUES ('PcComponentes', 'pccomponentes')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO retailers (name, slug) VALUES ('Back Market', 'backmarket')
  ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO retailers (name, slug) VALUES ('CeX', 'cex')
  ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Móviles
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Redmi Note 13', 'redmi-note-13', 'Android', 'normal', '6.67" AMOLED', '120 Hz', 'Snapdragon 685', '8 GB', '256 GB', '5000 mAh', '33 W', '108 MP', '8 MP', '—', '16 MP', '188 g', 'IP54', 2, FALSE, TRUE, FALSE, FALSE, 60, 55, 50, 80, 65, 90, 179, 220, 105, 165, TRUE, '2026-09-16', FALSE, TRUE FROM brands WHERE slug = 'xiaomi';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy A15', 'galaxy-a15', 'Android', 'normal', '6.5" AMOLED', '90 Hz', 'Helio G99', '6 GB', '128 GB', '5000 mAh', '25 W', '50 MP', '5 MP', '—', '13 MP', '200 g', 'No', 4, FALSE, TRUE, FALSE, FALSE, 55, 50, 45, 78, 60, 85, 110, 190, 65, 145, TRUE, '2026-09-16', FALSE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Moto G54', 'moto-g54', 'Android', 'normal', '6.5" IPS', '120 Hz', 'Dimensity 7020', '8 GB', '256 GB', '5000 mAh', '33 W', '50 MP', '8 MP', '—', '16 MP', '191 g', 'IP52', 2, TRUE, TRUE, FALSE, FALSE, 58, 52, 55, 82, 58, 88, 125, 220, 75, 165, TRUE, '2026-09-16', FALSE, TRUE FROM brands WHERE slug = 'motorola';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy A35', 'galaxy-a35', 'Android', 'normal', '6.6" AMOLED', '120 Hz', 'Exynos 1380', '8 GB', '256 GB', '5000 mAh', '25 W', '50 MP', '8 MP', '—', '13 MP', '209 g', 'IP67', 4, TRUE, TRUE, FALSE, FALSE, 68, 60, 58, 75, 72, 85, 245, 380, 145, 285, TRUE, '2026-09-16', FALSE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Phone (2a)', 'nothing-phone-2a', 'Android', 'normal', '6.7" AMOLED', '120 Hz', 'Dimensity 7200 Pro', '8 GB', '256 GB', '5000 mAh', '45 W', '50 MP', '50 MP', '—', '32 MP', '190 g', 'IP54', 3, TRUE, TRUE, FALSE, FALSE, 70, 65, 60, 80, 75, 84, 290, 390, 175, 295, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'nothing';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Pixel 8a', 'pixel-8a', 'Android', 'compacto', '6.1" OLED', '120 Hz', 'Google Tensor G3', '8 GB', '128 GB', '4492 mAh', '18 W', '64 MP', '13 MP', '—', '13 MP', '188 g', 'IP67', 6, TRUE, TRUE, TRUE, TRUE, 90, 75, 65, 72, 78, 82, 320, 430, 190, 325, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'google';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy A55', 'galaxy-a55', 'Android', 'normal', '6.6" AMOLED', '120 Hz', 'Exynos 1480', '8 GB', '256 GB', '5000 mAh', '25 W', '50 MP', '12 MP', '5 MP', '32 MP', '213 g', 'IP67', 4, TRUE, TRUE, FALSE, FALSE, 75, 68, 62, 78, 80, 80, 340, 460, 205, 345, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Nord 4', 'nord-4', 'Android', 'normal', '6.74" AMOLED', '120 Hz', 'Snapdragon 7+ Gen 3', '8 GB', '256 GB', '5500 mAh', '100 W', '50 MP', '8 MP', '—', '16 MP', '199 g', 'IP65', 3, TRUE, TRUE, FALSE, FALSE, 76, 82, 80, 85, 78, 83, 380, 520, 230, 390, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'oneplus';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy S24 FE', 'galaxy-s24-fe', 'Android', 'normal', '6.7" AMOLED', '120 Hz', 'Exynos 2400e', '8 GB', '256 GB', '4700 mAh', '25 W', '50 MP', '12 MP', '8 MP', '10 MP', '213 g', 'IP68', 5, TRUE, TRUE, TRUE, TRUE, 85, 82, 78, 80, 85, 78, 490, 660, 295, 495, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'iPhone SE (3ª gen)', 'iphone-se', 'iOS', 'compacto', '4.7" IPS', '60 Hz', 'A15 Bionic', '4 GB', '128 GB', '2018 mAh', '20 W', '12 MP', '—', '—', '7 MP', '144 g', 'IP67', 5, TRUE, TRUE, TRUE, TRUE, 65, 80, 75, 60, 55, 68, 430, 570, 260, 430, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'apple';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'iPhone 15', 'iphone-15', 'iOS', 'compacto', '6.1" OLED', '60 Hz', 'A16 Bionic', '6 GB', '128 GB', '3349 mAh', '20 W', '48 MP', '12 MP', '—', '12 MP', '171 g', 'IP68', 6, TRUE, TRUE, TRUE, TRUE, 88, 88, 82, 78, 82, 70, 700, 830, 420, 625, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'apple';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Pixel 9', 'pixel-9', 'Android', 'normal', '6.3" OLED', '120 Hz', 'Google Tensor G4', '12 GB', '128 GB', '4700 mAh', '27 W', '50 MP', '48 MP', '—', '10.5 MP', '198 g', 'IP68', 7, TRUE, TRUE, TRUE, TRUE, 95, 85, 78, 80, 85, 75, 680, 820, 410, 615, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'google';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy S24', 'galaxy-s24', 'Android', 'compacto', '6.2" AMOLED', '120 Hz', 'Snapdragon 8 Gen 3', '8 GB', '256 GB', '4000 mAh', '25 W', '50 MP', '12 MP', '10 MP', '12 MP', '167 g', 'IP68', 7, TRUE, TRUE, TRUE, TRUE, 90, 88, 85, 82, 90, 75, 700, 870, 420, 655, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'iPhone 15 Pro', 'iphone-15-pro', 'iOS', 'normal', '6.1" OLED', '120 Hz', 'A17 Pro', '8 GB', '256 GB', '3274 mAh', '27 W', '48 MP', '12 MP', '12 MP', '12 MP', '187 g', 'IP68', 7, TRUE, TRUE, TRUE, TRUE, 94, 96, 92, 80, 90, 65, 900, 1060, 540, 795, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'apple';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy S24 Ultra', 'galaxy-s24-ultra', 'Android', 'grande', '6.8" AMOLED', '120 Hz', 'Snapdragon 8 Gen 3', '12 GB', '256 GB', '5000 mAh', '45 W', '200 MP', '12 MP', '50 MP', '12 MP', '233 g', 'IP68', 7, TRUE, TRUE, TRUE, TRUE, 98, 95, 90, 85, 96, 68, 1050, 1290, 630, 970, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'iPhone 16', 'iphone-16', 'iOS', 'compacto', '6.1" OLED', '60 Hz', 'Apple A18', '8 GB', '128 GB', '3561 mAh', '20 W', '48 MP', '12 MP', '—', '12 MP', '170 g', 'IP68', 6, TRUE, TRUE, TRUE, TRUE, 90, 92, 88, 80, 82, 68, 899, 999, 540, 750, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'apple';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Galaxy Z Flip6', 'galaxy-z-flip6', 'Android', 'compacto', '6.7" AMOLED plegable', '120 Hz', 'Snapdragon 8 Gen 3 for Galaxy', '12 GB', '256 GB', '4000 mAh', '25 W', '50 MP', '12 MP', '—', '10 MP', '187 g', 'IPX8', 7, TRUE, TRUE, TRUE, TRUE, 82, 85, 80, 72, 85, 60, 1050, 1200, 630, 900, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'samsung';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Xiaomi 14T', 'xiaomi-14t', 'Android', 'normal', '6.67" AMOLED', '120 Hz', 'Dimensity 8300-Ultra', '12 GB', '256 GB', '5000 mAh', '67 W', '50 MP', '12 MP', '50 MP', '32 MP', '193 g', 'IP68', 4, TRUE, TRUE, FALSE, FALSE, 84, 78, 75, 82, 78, 82, 400, 480, 240, 360, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'xiaomi';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Pixel 9a', 'pixel-9a', 'Android', 'compacto', '6.3" OLED', '120 Hz', 'Google Tensor G4', '8 GB', '128 GB', '5100 mAh', '23 W', '48 MP', '13 MP', '—', '13 MP', '186 g', 'IP68', 7, TRUE, TRUE, TRUE, TRUE, 87, 78, 68, 82, 80, 85, 480, 550, 290, 410, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'google';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'OnePlus 12', 'oneplus-12', 'Android', 'normal', '6.82" AMOLED', '120 Hz', 'Snapdragon 8 Gen 3', '16 GB', '256 GB', '5400 mAh', '100 W', '50 MP', '48 MP', '64 MP', '32 MP', '220 g', 'IP65', 4, TRUE, TRUE, FALSE, TRUE, 88, 92, 90, 88, 90, 78, 800, 950, 480, 710, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'oneplus';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Motorola Razr 50', 'moto-razr-50', 'Android', 'compacto', '6.9" pOLED plegable', '120 Hz', 'Dimensity 7300X', '8 GB', '256 GB', '4200 mAh', '30 W', '50 MP', '13 MP', '—', '32 MP', '189 g', 'IPX8', 3, TRUE, TRUE, FALSE, TRUE, 75, 68, 62, 75, 80, 74, 550, 650, 330, 490, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'motorola';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'OPPO Reno 12', 'oppo-reno-12', 'Android', 'normal', '6.7" AMOLED', '120 Hz', 'Dimensity 7300-Energy', '12 GB', '256 GB', '5800 mAh', '80 W', '50 MP', '8 MP', '32 MP', '50 MP', '186 g', 'IP65', 3, TRUE, TRUE, FALSE, FALSE, 78, 70, 65, 85, 78, 80, 430, 500, 260, 375, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'oppo';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'HONOR 200', 'honor-200', 'Android', 'normal', '6.7" AMOLED', '120 Hz', 'Snapdragon 7 Gen 3', '12 GB', '512 GB', '5200 mAh', '66 W', '50 MP', '12 MP', '50 MP', '50 MP', '187 g', 'IP54', 4, TRUE, TRUE, FALSE, FALSE, 82, 74, 68, 80, 80, 82, 480, 550, 290, 410, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'honor';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Nothing Phone (2)', 'nothing-phone-2', 'Android', 'normal', '6.7" AMOLED', '120 Hz', 'Snapdragon 8+ Gen 1', '12 GB', '256 GB', '4700 mAh', '45 W', '50 MP', '50 MP', '—', '32 MP', '201 g', 'IP54', 3, TRUE, TRUE, FALSE, TRUE, 78, 80, 78, 78, 82, 76, 500, 600, 300, 450, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'nothing';
INSERT INTO smartphones (brand_id, model, slug, os, size_category, screen_size, refresh_rate, processor, ram, storage, battery_mah, fast_charging, main_camera, ultrawide_camera, telephoto, front_camera, weight, water_resistance, update_years, has_5g, has_nfc, has_esim, wireless_charging, photo_score, performance_score, gaming_score, battery_score, screen_score, value_score, price_min, price_max, refurb_price_min, refurb_price_max, price_verified, price_checked_at, is_demo_data, active)
SELECT id, 'Sony Xperia 1 VI', 'sony-xperia-1-vi', 'Android', 'normal', '6.5" OLED 21:9', '120 Hz', 'Snapdragon 8 Gen 3', '12 GB', '256 GB', '5000 mAh', '30 W', '48 MP', '48 MP', '48 MP', '12 MP', '192 g', 'IP68', 4, TRUE, TRUE, FALSE, TRUE, 90, 88, 82, 78, 88, 55, 1250, 1400, 750, 1050, FALSE, NULL, TRUE, TRUE FROM brands WHERE slug = 'sony';

-- Enlaces a tiendas
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'redmi-note-13' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'redmi-note-13' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'redmi-note-13' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'redmi-note-13' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'redmi-note-13' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a15' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a15' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a15' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a15' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a15' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-g54' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-g54' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-g54' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-g54' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-g54' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a35' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a35' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a35' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a35' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a35' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2a' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2a' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2a' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2a' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2a' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-8a' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-8a' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-8a' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-8a' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-8a' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a55' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a55' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a55' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a55' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-a55' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nord-4' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nord-4' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nord-4' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nord-4' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nord-4' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-fe' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-fe' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-fe' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-fe' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-fe' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-se' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-se' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-se' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-se' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-se' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15-pro' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15-pro' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15-pro' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15-pro' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-15-pro' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-ultra' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-ultra' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-ultra' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-ultra' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-s24-ultra' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-16' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-16' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-16' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-16' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'iphone-16' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-z-flip6' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-z-flip6' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-z-flip6' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-z-flip6' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'galaxy-z-flip6' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'xiaomi-14t' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'xiaomi-14t' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'xiaomi-14t' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'xiaomi-14t' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'xiaomi-14t' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9a' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9a' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9a' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9a' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'pixel-9a' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oneplus-12' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oneplus-12' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oneplus-12' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oneplus-12' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oneplus-12' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-razr-50' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-razr-50' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-razr-50' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-razr-50' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'moto-razr-50' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oppo-reno-12' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oppo-reno-12' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oppo-reno-12' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oppo-reno-12' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'oppo-reno-12' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'honor-200' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'honor-200' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'honor-200' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'honor-200' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'honor-200' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'nothing-phone-2' AND r.slug = 'cex';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'sony-xperia-1-vi' AND r.slug = 'amazon';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'sony-xperia-1-vi' AND r.slug = 'mediamarkt';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'nuevo', NULL, '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'sony-xperia-1-vi' AND r.slug = 'pccomponentes';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Muy bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'sony-xperia-1-vi' AND r.slug = 'backmarket';
INSERT INTO prices (smartphone_id, retailer_id, `condition`, refurb_grade, url, availability)
SELECT s.id, r.id, 'reacondicionado', 'Bueno', '#demo', 'unknown'
FROM smartphones s, retailers r WHERE s.slug = 'sony-xperia-1-vi' AND r.slug = 'cex';
