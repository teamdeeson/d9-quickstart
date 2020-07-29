<?php

/**
 * @file
 * Configuration for the stage_file_proxy module.
 */

if (SETTINGS_ENVIRONMENT === D_ENVIRONMENT_PROD) {
  $config['stage_file_proxy.settings']['origin'] = '';
}
else {
  $config['stage_file_proxy.settings']['origin'] = ''; // put your production url in here.
  $config['stage_file_proxy.settings']['origin_dir'] = 'sites/default/files';
  $config['stage_file_proxy.settings']['hotlink'] = TRUE;
}
