<?php

namespace Drupal\entity_class_bundles_demo\Entity\Node;

interface ArticleInterface {

  public function getBody();

  public function getImage();

  public function getComments();

  public function getTags();
}