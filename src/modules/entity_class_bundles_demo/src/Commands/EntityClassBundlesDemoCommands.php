<?php

namespace Drupal\entity_class_bundles_demo\Commands;

use Drupal\entity_class_bundles_demo\Entity\Node\Article;
use Drush\Commands\DrushCommands;

class EntityClassBundlesDemoCommands extends DrushCommands {

  /**
   * Drush command to list all articles and their tags.
   *
   * @command entity_class_bundles_demo:log_article_tags
   * @aliases ecbd:lat
   * @usage entity_class_bundles_demo:log_article_tags
   */
  public function logArticleTags() {
    $articles = \Drupal::entityTypeManager()->getStorage('node')->loadByProperties(['type' => 'article', 'status' => 1]);
    foreach($articles as $article) {
      if($article instanceof Article) {
        \Drupal::logger('entity_class_bundles_demo')->notice('Article' . $article->getTitle() . '  has these tags:');
        $tags = $article->getTags();
        foreach($tags as $tag) {
          \Drupal::logger('entity_class_bundles_demo')->notice('--' . $tag->getLoudName());
        }
      }
    }
  }
}