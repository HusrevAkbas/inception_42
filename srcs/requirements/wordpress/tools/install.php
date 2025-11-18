<?php

// Check if WordPress is already installed
if (defined('ABSPATH')) {
    echo 'WordPress is already installed!';
    exit;
}

// Define default admin credentials
$admin_user = 'admin'; // Admin username
$admin_pass = 'adminpassword'; // Admin password
$admin_email = 'admin@example.com'; // Admin email
$site_title = 'My WordPress Site'; // Site title

// Define database connection parameters
define('DB_NAME', 'exampledb');
define('DB_USER', 'exampleuser');
define('DB_PASSWORD', 'examplepass');
define('DB_HOST', 'localhost');

// Set the URL and Site Title in wp-config
define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_HOME', WP_SITEURL);

// Include WordPress' core files (this assumes WordPress is already extracted)
require_once('wp-load.php');

// Check if WordPress is properly loaded
if (!defined('ABSPATH')) {
    echo 'Error: WordPress is not properly installed!';
    exit;
}

// Start the installation process
function complete_installation($admin_user, $admin_pass, $admin_email, $site_title) {
    // Set the site title
    update_option('blogname', $site_title);

    // Create the admin user
    if (!username_exists($admin_user) && !email_exists($admin_email)) {
        $admin_id = wp_create_user($admin_user, $admin_pass, $admin_email);
        $user = get_user_by('id', $admin_id);
        $user->set_role('administrator');
    }

    // Set up default permalinks
    update_option('permalink_structure', '/%postname%/');

    // Optionally, you can activate the default theme
    $theme = wp_get_theme('twentytwentyone'); // You can change the theme name here
    switch_theme($theme->get_stylesheet());

    // Finished!
    echo 'WordPress is now installed and configured!';
}

// Run the installation
complete_installation($admin_user, $admin_pass, $admin_email, $site_title);

?>

