-- ============================================================
-- SmartPhoneMatch — SOLO los 10 móviles nuevos
-- Pega esto en phpMyAdmin (pestaña SQL) sobre tu base de datos
-- YA EXISTENTE. No toca los 15 móviles que ya tenías.
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
