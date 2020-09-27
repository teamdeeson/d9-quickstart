<?php

namespace Drupal\entity_class_bundles_demo\Entity\Node;

use Drupal\node\Entity\Node;

class BasicPage extends Node implements BasicPageInterface {

  // Implement whatever business logic specific to basic pages.
  public function getBody() {
    return $this->get('body')->value;
  }

}