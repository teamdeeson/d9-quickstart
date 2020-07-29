<?php

/**
 * @file
 * Drupal config export configuration
 */

$settings['config_sync_directory'] = '../src/config/sync';

// Be sure to have development configuration disabled by default.
$config['config_split.config_split.development_config']['status'] = FALSE;

if (SETTINGS_ENVIRONMENT !== D_ENVIRONMENT_PROD) {
  $config['config_split.config_split.development_config']['status'] = TRUE;
}

// Do not export the following modules - they will have to be enabled by hand.
$settings['config_exclude_modules'] = ['stage_file_proxy', 'devel'];
