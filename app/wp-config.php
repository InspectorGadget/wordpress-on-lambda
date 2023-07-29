<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_lambda' );

/** Database username */
define( 'DB_USER', 'wp_lambda' );

/** Database password */
define( 'DB_PASSWORD', 'wp_lambda@123' );

/** Database hostname */
define( 'DB_HOST', 'mysql.rtgnetworks.com' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'BSL{N.qz/Sp2UVAkC^ll1_uE/s(r9NvHF+UkvHf9YGF{znw9 (TjZHs+_9dE}fwm' );
define( 'SECURE_AUTH_KEY',  'n@Rm{Rhi+x/+01,a{yOZVq=Qp9W~+M8Q0$@sSe|xet:R6eQ.4D4E oE(rQ-_DY:v' );
define( 'LOGGED_IN_KEY',    'G|Kl15L-u{;IIPbuE_R*V!NDj@Ds7qtx]%EyG.1?p`$=yaHWZ:)8[z|TyBx}6]Uw' );
define( 'NONCE_KEY',        'C Y`%J7Ew?WQ)xIR5lvh|`ZIQAmAhLl)&5F}r2E06U<L!$@o[TW{4R@w[nn+0LP ' );
define( 'AUTH_SALT',        'Va^qacvoT$R@2{zF,}?.*?U!dUG`Rps)`]GC,{gJf[>53f>XaROth =8(Q71~{&+' );
define( 'SECURE_AUTH_SALT', '1EQtLWS.7To4JxOIP[j<6tIn+;i*/w4l_b#`?%6TNcel[^-hIA(BBN]lG/mnZ!/x' );
define( 'LOGGED_IN_SALT',   '8}q%KLCI5tPLB(Z)aoXN!N XYX$G7_ionFTb|99svsF9 AGblAEDy![;D^.YC;l+' );
define( 'NONCE_SALT',       'MI7MFj5b|T0;.WTIMME&,M{:LJ5;4Qa[I<6W4!9QbO_V3p;{(dci`>:9*n=Kk4*_' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */

define('FORCE_SSL_ADMIN', true);
define('WP_HOME','https://wordpress.raeveen.me');
define('WP_SITEURL','https://wordpress.raeveen.me');

if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
	$_SERVER['HTTPS'] = 'on';
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
