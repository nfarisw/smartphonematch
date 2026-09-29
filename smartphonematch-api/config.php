<?php
// Configuración de conexión — valores por defecto de XAMPP (usuario root sin
// contraseña) para desarrollo local. En el servidor de producción, define
// las variables de entorno DB_HOST/DB_NAME/DB_USER/DB_PASS/CORS_ORIGIN (por
// ejemplo en la configuración de Apache o en un archivo .env cargado antes)
// en vez de tocar este archivo.
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_NAME', getenv('DB_NAME') ?: 'smartphonematch');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');
// Dominio permitido para CORS. En local, '*' (cualquier origen) es cómodo
// porque el HTML se abre suelto. En producción, define CORS_ORIGIN con el
// dominio real (https://tudominio.com) para no dejar la API abierta a todos.
define('CORS_ORIGIN', getenv('CORS_ORIGIN') ?: '*');
// Muestra el detalle técnico de los errores en la respuesta JSON. Debe
// quedar en false en producción (define APP_DEBUG=1 solo en desarrollo).
define('APP_DEBUG', getenv('APP_DEBUG') === '1');
// IDs de Afiliado de Amazon — uno POR MERCADO, porque Amazon España y
// Amazon.com son programas de afiliados distintos con etiquetas distintas
// (ej. "tunombre-21" en Amazon.es, "tunombre-20" en Amazon.com). En cuanto
// definas cada uno (aquí o como variables de entorno AMAZON_ASSOC_TAG_ES /
// AMAZON_ASSOC_TAG_US), los enlaces de Amazon de ese mercado pasan a
// llevar la etiqueta automáticamente — no hay que tocar la base de datos.
define('AMAZON_ASSOC_TAG_ES', getenv('AMAZON_ASSOC_TAG_ES') ?: getenv('AMAZON_ASSOC_TAG') ?: '');
define('AMAZON_ASSOC_TAG_US', getenv('AMAZON_ASSOC_TAG_US') ?: '');

// Añade la etiqueta de afiliado de Amazon correspondiente al mercado a una
// URL de amazon.es o amazon.com, si hay una etiqueta configurada para ese
// mercado y la URL aún no lleva una.
function apply_amazon_tag(string $url, string $market = 'ES'): string {
    $tag = $market === 'US' ? AMAZON_ASSOC_TAG_US : AMAZON_ASSOC_TAG_ES;
    if ($tag === '') return $url;
    if (!str_contains($url, 'amazon.')) return $url;
    if (str_contains($url, 'tag=')) return $url;
    $sep = str_contains($url, '?') ? '&' : '?';
    return $url . $sep . 'tag=' . urlencode($tag);
}

// URL de la portada. En local, "/" está secuestrada por la página de
// bienvenida de XAMPP (redirige a /dashboard/), así que ahí enlazamos
// directamente al HTML de la demo. En un dominio real, "/" sí es la
// portada de verdad (cuando subas el proyecto, ese archivo pasa a
// llamarse index.html en la raíz y esto vuelve a apuntar a "/" solo).
function home_url(): string {
    $host = $_SERVER['HTTP_HOST'] ?? '';
    return (str_contains($host, 'localhost') || str_contains($host, '127.0.0.1'))
        ? '/smartphonematch-demo.html' : '/';
}

function db(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $pdo = new PDO(
            "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
            DB_USER,
            DB_PASS,
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
        );
    }
    return $pdo;
}

// Cabeceras comunes a todos los endpoints: JSON + CORS abierto
// (CORS abierto es cómodo para el MVP porque la demo es un HTML suelto;
//  cuando la web tenga dominio propio, restringe esto a ese dominio).
function json_headers(): void {
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: ' . CORS_ORIGIN);
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type');
    header('X-Robots-Tag: noindex, nofollow');
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }
}

function send_json($data, int $status = 200): void {
    http_response_code($status);
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// Log del error real en el servidor y respuesta genérica al cliente —
// así no se filtran detalles internos (nombres de tablas, rutas...) a
// quien llame a la API. Con APP_DEBUG=1 (solo en desarrollo) sí se
// devuelve el mensaje real, para depurar más rápido.
function send_error(Throwable $e, string $publicError = 'server_error', int $status = 500): void {
    error_log($e->getMessage());
    $payload = ['error' => $publicError];
    if (APP_DEBUG) $payload['message'] = $e->getMessage();
    send_json($payload, $status);
}
