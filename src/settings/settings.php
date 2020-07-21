<?php

/**
 * @file
 * Default Drupal configuration file sites/default/settings.php.
 *
 * You should not normally need to modify this file.
 */

// Detect the environment.
require_once dirname(DRUPAL_ROOT) . '/src/settings/environment.inc';

// Configure the application.
foreach (glob(dirname(DRUPAL_ROOT) . '/src/settings/*.settings.inc') as $file) {
  require_once $file;
}
$databases['default']['default'] = array (
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'prefix' => '',
  'host' => 'mariadb',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
$settings['hash_salt'] = '0VwzvcKyOBefR3RiWYGHjMRYiqx0IcJOqmSQ6p0XbVg156GtTqaxhkCCit4SYwcgMSJjjFJ1Jg';
$settings['config_sync_directory'] = 'sites/default/files/config_CHYnkkYrQBRVFkijl3GbPBXLM3e_QNrnmp8jpe9g-k2QNjwgb2K7FhKGxssFjj0v8Y2sYjRHsw/sync';
