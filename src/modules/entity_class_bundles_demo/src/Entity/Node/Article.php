<?php

namespace Drupal\entity_class_bundles_demo\Entity\Node;

use Drupal\Core\Field\EntityReferenceFieldItemList;
use Drupal\node\Entity\Node;

class Article extends Node implements ArticleInterface {

  public function getBody() {
    return $this->get('body')->value;
  }

  public function getImage() {
    $image_items = $this->get('field_image');
    if(!$image_items->isEmpty()) {
      return $image_items->first()->getValue();
    }
    return NULL;
  }

  public function getComments() {
    // TODO: Implement getComments() method.
  }


  /**
   * @return \Drupal\entity_class_bundles_demo\Entity\TaxonomyTerm\Tag[]
   */
  public function getTags()  {
    /* @var EntityReferenceFieldItemList $tag_items */
    $tag_items = $this->get('field_tags');
    return $tag_items->referencedEntities();
  }
}