<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'aabounak' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'h`e@&Egxr2)6xxgWg!gVk?V$WG=LQ_C^=minH.kSZ]8dMyKytO!15U)@Us%?e1x9');
define( 'SECURE_AUTH_KEY',  '9Z+|x>u1yGAB|K0d|%:Tjmq`uAUg^eg>7gX|!+|NE9!H9$ePa<$q+c+ j<P6!A`r');
define( 'LOGGED_IN_KEY',    'WT9B+,X;+<OlQJVcgKfMDsJMe?Gaca73zXP).?OER cIq[JNTKH}etm$)~Dj7-1Q');
define( 'NONCE_KEY',        ']kqMe[*{zb]qE/#f|iIBq_<D+$Jm%M@xb:+P&g>,GG_)`~jlp3Mrty7j;6yW|]F!');
define( 'AUTH_SALT',        '0qGi#-i>|OuqT?/:Jv]_R*K7|gJ}1ffcAF*wo4:>)}t,Uf5vRC:HfYil3(0Q=/0^');
define( 'SECURE_AUTH_SALT', 'S;5+?WX/,E(uWbBu5H(Z|&t?DaHAzIMxj;m8*,|R9^*qx:tQ!;[}5;R)Z{$43v1.');
define( 'LOGGED_IN_SALT',   '$xIwB88!u>BVj5K(l%SXKG*h}7a*H=-NlPhHz%vZ4?g<,?#(b>t9K^t;&=+)kQkH');
define( 'NONCE_SALT',       'hvQwuz`0~wh+_EF-%lcy7bsH4IsWD#6>v}n<WDN~ ~B*2.eq>d2cEn2Z?@]]Pr_*');

/**#@-*/

/**
 * WordPress Database Table prefix.
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
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );