# Assets de la couverture « veillée »

Les SVG dans `src/` proviennent de
[font-picto-sgdf](https://gitlab.com/sgdf/font-picto-sgdf), version
`bd52e715e8b1bcee84d0513e0be12d1dc5d1a1cf`.
Leurs noms d’origine sont `src/signesCommuns-{FeuDeCamp,Tente,Arbre,Lune,Etoile}.svg`.
Ils sont conservés sans modification, avec leur licence MIT dans `LICENSE`.

Les PDF vectoriels sont des copies recolorées en noir. `JB_Gerland-nb.png`
est une version monochrome du logo du groupe présent dans `img/JB_Gerland.png`.
Ces fichiers sont inclus dans le dépôt : la compilation du carnet ne nécessite
aucun téléchargement ni outil de conversion.

Pour les régénérer depuis la racine du projet :

```bash
/usr/bin/python3 utils/convert-cover-assets.py
```

Cet outil de maintenance utilise PyGObject avec Rsvg 2.0, Pycairo et Pillow
(sur Debian/Ubuntu : `python3-gi`, `gir1.2-rsvg-2.0`, `python3-cairo`, `python3-pil`).
Il ne modifie pas les SVG d’origine.
