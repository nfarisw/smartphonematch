<?php
// POST /recommend.php   body JSON: { "answers": { budget, refurb, priority, gaming, ... }, "lang": "es"|"en" }
require __DIR__ . '/config.php';
require __DIR__ . '/../lang/i18n.php';
json_headers();

$body = json_decode(file_get_contents('php://input'), true);
$a = $body['answers'] ?? null;
if (!$a) send_json(['error' => 'missing_answers'], 400);
$lang = in_array($body['lang'] ?? '', SPM_LANGS, true) ? $body['lang'] : resolve_lang();
$allowedMarkets = SPM_LANG_MARKETS[$lang] ?? [];
$market = in_array($body['market'] ?? '', $allowedMarkets, true) ? $body['market'] : resolve_market($lang);

const BUDGET_RANGES = [
    'lt200'    => [0, 200],   '200-300' => [200, 300], '300-400' => [300, 400],
    '400-600'  => [400, 600], '600-800' => [600, 800], '800-1000' => [800, 1000],
    'gt1000'   => [1000, PHP_INT_MAX],
];

function overlaps($loA, $hiA, $loB, $hiB): bool { return $hiA >= $loB && $loA <= $hiB; }

function score_phone(array $p, array $a, string $lang, string $market): ?array {
    if (!empty($a['os']) && $a['os'] !== 'any' && $p['os'] !== $a['os']) return null;

    [$min, $max] = BUDGET_RANGES[$a['budget']] ?? [0, PHP_INT_MAX];
    $lowBound = $min * 0.8;
    $highBound = $max === PHP_INT_MAX ? PHP_INT_MAX : $max * 1.2;

    $newFits = overlaps((float)$p['price_min'], (float)$p['price_max'], $lowBound, $highBound);
    $refurbFits = ($a['refurb'] ?? 'no') === 'si'
        && overlaps((float)$p['refurb_price_min'], (float)$p['refurb_price_max'], $lowBound, $highBound);
    if (!$newFits && !$refurbFits) return null;
    $refurbMatch = !$newFits && $refurbFits;
    $strongOverlap = overlaps((float)$p['price_min'], (float)$p['price_max'], $min, $max);
    $budgetFit = $strongOverlap ? 15 : ($refurbMatch ? 12 : 6);

    $pts = 20;
    $pros = []; $cons = [];
    $s = [
        'camera' => (int)$p['photo_score'], 'performance' => (int)$p['performance_score'],
        'gaming' => (int)$p['gaming_score'], 'battery' => (int)$p['battery_score'],
        'screen' => (int)$p['screen_score'], 'value' => (int)$p['value_score'],
    ];

    // prioridad principal
    $priorityMap = ['camera'=>'camera','battery'=>'battery','performance'=>'performance','screen'=>'screen','value'=>'value','design'=>null];
    $key = $priorityMap[$a['priority']] ?? null;
    $priorityScore = $key ? $s[$key] : ($s['screen'] + $s['value']) / 2;
    $pts += ($priorityScore / 100) * 25;
    $label = t('rec.priority_label.' . ($a['priority'] ?? 'value'), $lang);
    if ($priorityScore >= 80) $pros[] = t('rec.pro_excellent_at', $lang, ['label' => $label]);
    elseif ($priorityScore < 55) $cons[] = t('rec.con_not_standout_at', $lang, ['label' => $label]);

    // gaming
    $gaming = $a['gaming'] ?? 'no';
    if ($gaming === 'occasional') $pts += ($s['gaming'] / 100) * 8;
    elseif ($gaming === 'yes') { $pts += ($s['gaming'] / 100) * 16; if ($s['gaming'] >= 75) $pros[] = t('rec.pro_gaming', $lang); }
    elseif ($gaming === 'demanding') {
        $pts += ($s['gaming'] / 100) * 22;
        if ($s['gaming'] >= 80) $pros[] = t('rec.pro_demanding_gaming', $lang); else $cons[] = t('rec.con_demanding_gaming', $lang);
    }

    // cámara
    $camW = ['low'=>0,'medium'=>8,'high'=>16,'veryhigh'=>24][$a['cameraImportance'] ?? 'low'] ?? 0;
    $pts += ($s['camera'] / 100) * $camW;
    if (($a['cameraImportance'] ?? '') === 'veryhigh' && $s['camera'] < 80) $cons[] = t('rec.con_camera_tight', $lang);
    if (in_array($a['cameraImportance'] ?? '', ['high','veryhigh'], true) && $s['camera'] >= 85) $pros[] = t('rec.pro_camera_high_end', $lang);

    // duración / actualizaciones
    $holdW = ['1-2'=>0,'2-3'=>4,'3-4'=>9,'4plus'=>16][$a['holdDuration'] ?? '1-2'] ?? 0;
    $updOk = ['1-2'=>1,'2-3'=>3,'3-4'=>4,'4plus'=>5][$a['holdDuration'] ?? '1-2'] ?? 1;
    $updates = (int)$p['update_years'];
    if ($updates >= $updOk) { $pts += $holdW; if ($updates >= 5) $pros[] = t('rec.pro_updates_years', $lang, ['years' => $updates]); }
    else $cons[] = t('rec.con_updates_years', $lang, ['years' => $updates]);

    // tamaño
    if (!empty($a['size']) && $a['size'] !== 'any') {
        if ($p['size_category'] === $a['size']) $pts += 5;
        else { $pts -= 6; $cons[] = t('rec.con_size_mismatch', $lang, ['size' => t('rec.size.' . $p['size_category'], $lang), 'wanted' => t('rec.size.' . $a['size'], $lang)]); }
    }

    // carga rápida
    $fastNum = (int)filter_var($p['fast_charging'], FILTER_SANITIZE_NUMBER_INT);
    if (($a['fastCharging'] ?? '') === 'medium') { if ($fastNum >= 25) $pts += 4; }
    elseif (($a['fastCharging'] ?? '') === 'high') {
        if ($fastNum >= 45) { $pts += 8; $pros[] = t('rec.pro_fast_charging', $lang); }
        else { $pts -= 4; $cons[] = t('rec.con_slow_charging', $lang); }
    }

    // autonomía
    $battW = ['poco'=>0,'normal'=>6,'mucho'=>14][$a['batteryImportance'] ?? 'poco'] ?? 0;
    $pts += ($s['battery'] / 100) * $battW;
    if (($a['batteryImportance'] ?? '') === 'mucho') {
        if ($s['battery'] >= 78) $pros[] = t('rec.pro_all_day_battery', $lang); else $cons[] = t('rec.con_battery_tight', $lang);
    }

    // preferencia precio
    $midPrice = ((float)$p['price_min'] + (float)$p['price_max']) / 2;
    if (($a['preference'] ?? '') === 'cheap') {
        $span = max(1, ($max === PHP_INT_MAX ? $midPrice : $max) - $min);
        $cheapness = 1 - (($midPrice - $min) / $span);
        $pts += max(0, $cheapness) * 8;
    } elseif (($a['preference'] ?? '') === 'best') {
        $pts += ((($s['camera'] + $s['performance'] + $s['screen']) / 3) / 100) * 8;
    }

    // extras
    if (!$p['wireless_charging']) $cons[] = t('rec.con_no_wireless', $lang);
    $cons[] = t('rec.con_no_charger', $lang);
    if ($refurbMatch) $pros[] = t('rec.pro_refurb_fits', $lang, ['price' => $p['refurb_price_min']]);
    else $pros[] = t('rec.pro_fits_budget', $lang);
    if (!($market === 'ES' && $p['price_verified'])) $cons[] = t('rec.con_price_unverified', $lang);

    $pts += $budgetFit;
    $final = max(0, min(100, (int)round($pts)));

    return [
        'phone' => $p,
        'score' => $final,
        'pros' => array_slice($pros, 0, 4),
        'cons' => array_slice($cons, 0, 3),
        'refurbMatch' => $refurbMatch,
    ];
}

try {
    $stmt = db()->query(
        "SELECT s.*, b.name AS brand_name FROM smartphones s JOIN brands b ON b.id = s.brand_id WHERE s.active = 1"
    );
    $all = $stmt->fetchAll();

    $results = [];
    foreach ($all as $phone) {
        $r = score_phone($phone, $a, $lang, $market);
        if ($r) $results[] = $r;
    }
    usort($results, fn($x, $y) => $y['score'] <=> $x['score']);

    send_json(['count' => count($results), 'results' => $results]);
} catch (Throwable $e) {
    send_error($e);
}
