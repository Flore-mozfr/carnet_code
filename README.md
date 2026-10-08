# Carnet de chants
Bienvenue dans le dépôt du carnet de chant du groupe SGDF Joséphine Baker !

Les carnets utilisent Raleway pour les titres et Sarabun pour les paroles,
les accords et le texte courant. Les polices et leurs licences sont incluses
dans `fonts/` ; leur configuration se trouve dans `templates/songbook/data.tex`.

Les changements du carnet sont consignés dans le [changelog](CHANGELOG.md).

Pour lancer la génération du carnet de chants, activer l’environnement puis exécuter :

Rendez compil.sh exécutable :
```bash
chmod +x compil.sh
```

Puis exécutez :
```bash
./compil.sh
```

## Créer et activer l’environnement Python

Avec Python 3 installé, créer un environnement virtuel depuis la racine du
dépôt (Linux ou macOS, avec Bash ou Zsh) :

```bash
python3 -m venv .venv
source .venv/bin/activate
```

La création est nécessaire une seule fois. À chaque nouveau terminal,
réactiver l’environnement depuis la racine du dépôt :

```bash
source .venv/bin/activate
```

## Installer les dépendances Python

Une fois l’environnement activé, installer les dépendances du dépôt :

```bash
python -m pip install -r requirements.txt
```

`requirements.txt` installe `patacrep`, qui fournit la commande `songbook`,
ainsi que la version compatible de `setuptools`.

`patacrep` utilise encore `pkg_resources`, supprimé de `setuptools` à partir
de la version 82. Il faut donc conserver ici `setuptools` en version 81.0.0.
Sans cette version compatible, la commande `songbook` peut échouer avec :

```text
ModuleNotFoundError: No module named 'pkg_resources'
```

Si cette erreur apparaît, activer l’environnement puis réinstaller la version
compatible :

```bash
python -m pip install "setuptools==81.0.0"
```

## Nommer les fichiers de chants

Les fichiers de chants sont rangés dans `songs/`, par artiste. Utiliser des
espaces entre les mots du nom de fichier, plutôt que des underscores, et
conserver l’extension `.sg` : par exemple `le matou revient.sg`.

Le titre affiché dans le carnet est défini par `\beginsong{Titre du chant}`
à l’intérieur du fichier. Le nom du fichier ne définit pas ce titre.
Dans les commandes du terminal, entourer les chemins contenant des espaces
de guillemets.

## Diagrammes d’accords de guitare

Les 14 chants de `books/selection.yaml` utilisent des diagrammes dont les
24 positions sont définies dans
[`templates/styles/guitar-diagrams.sty`](templates/styles/guitar-diagrams.sty).
Le template `data.tex` charge ce fichier commun.

Pour afficher un diagramme dans un chant, placer sa référence après les
informations du chant et avant le premier couplet ou refrain :

```tex
\chorddiagram{Am}
\chorddiagram{C}
```

Pour ajouter ou modifier une position, éditer sa déclaration dans le fichier
commun :

```tex
\DeclareGuitarDiagram{Am}{X02210}
```

La modification s’applique à tous les chants qui référencent cet accord.
Un chant peut toujours définir une position particulière avec `\gtab`.
L’option `chords.diagramreminder: all` du YAML affiche les diagrammes ;
`tablatures: true` concerne les tablatures musicales, distinctes des diagrammes.

Voir [DOCS.md](DOCS.md) pour les détails des templates et des réglages.

## Quitter l’environnement

Pour quitter l’environnement :

```bash
deactivate
```
