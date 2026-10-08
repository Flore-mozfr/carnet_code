# Historique des changements

## 2026-10-08

### Liste des auteurs

- Ajout de l’option booléenne `template.default.tex.listeauteurs`, activée
  par défaut, pour afficher ou masquer l’index des auteurs.
- Désactivation de cette liste dans `books/selection.yaml`, sans retirer
  les noms des auteurs sous les titres des chants.

### Diagrammes d’accords de guitare

- Ajout des diagrammes manquants pour les chants de `books/selection.yaml` :
  les accords des 14 chants disposent désormais d’un diagramme.
- Centralisation des 24 positions dans `templates/styles/guitar-diagrams.sty`,
  chargé par le template `data.tex`.
- Utilisation de `\chorddiagram{Accord}` dans les chants de la sélection,
  pour réutiliser une position commune sans recopier sa définition.
- Documentation du fonctionnement dans le README et `DOCS.md`.

Validation : compilation de `books/selection.yaml` en PDF réussie.
