<?php
/**
 * The base configuration for WordPress
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 * @package WordPress
 */

// Helper function para pegar variáveis de ambiente (Docker)
if (!function_exists('getenv_docker')) {
	function getenv_docker($env, $default) {
		if ($fileEnv = getenv($env . '_FILE')) {
			return rtrim(file_get_contents($fileEnv), "\r\n");
		} else if (($val = getenv($env)) !== false) {
			return $val;
		} else {
			return $default;
		}
	}
}

// Configurações do banco de dados
define('DB_NAME',     getenv_docker('WORDPRESS_DB_NAME', 'wordpress'));
define('DB_USER',     getenv_docker('WORDPRESS_DB_USER', 'example username'));
define('DB_PASSWORD', getenv_docker('WORDPRESS_DB_PASSWORD', 'example password'));
define('DB_HOST',     getenv_docker('WORDPRESS_DB_HOST', 'mysql'));
define('DB_CHARSET',  getenv_docker('WORDPRESS_DB_CHARSET', 'utf8'));
define('DB_COLLATE',  getenv_docker('WORDPRESS_DB_COLLATE', ''));

// Chaves de autenticação e salts (use as suas variáveis de ambiente ou valores padrões)
define('AUTH_KEY',         getenv_docker('WORDPRESS_AUTH_KEY',         'f0dd39382cde1817900bae6eb9f7c0d30e1b9f71'));
define('SECURE_AUTH_KEY',  getenv_docker('WORDPRESS_SECURE_AUTH_KEY',  '44be415e0e102232cbb186e66198a3d32391f93b'));
define('LOGGED_IN_KEY',    getenv_docker('WORDPRESS_LOGGED_IN_KEY',    '445f9ef2fc1da9894f106c9bdd42a01858c38384'));
define('NONCE_KEY',        getenv_docker('WORDPRESS_NONCE_KEY',        '9c69adc22736831b174bcc1339d13c0862e70245'));
define('AUTH_SALT',        getenv_docker('WORDPRESS_AUTH_SALT',        '7b08c462537c5ba6b685051a425c9b459bd9401e'));
define('SECURE_AUTH_SALT', getenv_docker('WORDPRESS_SECURE_AUTH_SALT', '6aa612492b36b5f113e8ea47a68d245d7630faf3'));
define('LOGGED_IN_SALT',   getenv_docker('WORDPRESS_LOGGED_IN_SALT',   '6b2df3cae272fd51707b61041822a8b7f66a6e2b'));
define('NONCE_SALT',       getenv_docker('WORDPRESS_NONCE_SALT',       '9424c66000339f8fa5f4cb87a60df86e7bca7971'));

// Prefixo das tabelas
$table_prefix = getenv_docker('WORDPRESS_TABLE_PREFIX', 'wp_');

// Ativa modo debug e cria log para erros (útil para diagnosticar o erro crítico)
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);

// Aumenta limite de memória para evitar erros por falta de memória
define('WP_MEMORY_LIMIT', '256M');

// Detecta se estamos atrás de proxy e força HTTPS se necessário (útil em Docker com proxy reverso)
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
	$_SERVER['HTTPS'] = 'on';
}

// Permite adicionar configurações extras via variável de ambiente (opcional)
if ($configExtra = getenv_docker('WORDPRESS_CONFIG_EXTRA', '')) {
	eval($configExtra);
}

/* Isso é tudo, pode parar de editar aqui. :) */

/** Caminho absoluto até o diretório WordPress */
if (!defined('ABSPATH')) {
	define('ABSPATH', __DIR__ . '/');
}

/** Configura WordPress */
require_once ABSPATH . 'wp-settings.php';