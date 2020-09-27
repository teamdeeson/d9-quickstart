<?php

namespace Drupal\entity_class_bundles_demo\Entity\TaxonomyTerm;

use Drupal\taxonomy\Entity\Term;
use Drupal;

class Tag extends Term implements TagInterface {

  public function getLoudName() {
    return strtoupper($this->getName());
  }
}