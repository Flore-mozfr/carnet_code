# Historique des changements

## 2026-10-08

### Diagrammes d’accords de guitare

- Ajout des diagrammes manquants pour les chants de `books/selection.yaml` :
  les accords des 14 chants disposent désormais d’un diagramme.
- Centralisation des 24 positions dans `templates/styles/guitar-diagrams.sty`,
  chargé par le template `data.tex`.
- Utilisation de `\chorddiagram{Accord}` dans les chants de la sélection,
  pour réutiliser une position commune sans recopier sa définition.
- Documentation du fonctionnement dans le README et `DOCS.md`.

Validation : compilation de `books/selection.yaml` en PDF réussie.
