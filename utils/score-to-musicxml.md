# Essai de reconnaissance de partitions

Le script `utils/score-to-musicxml.py` lance Audiveris pour reconnaître
une partition imprimée (PDF, PNG, JPG, TIFF…), puis utilise music21 pour lire
le MusicXML obtenu, le réexporter et vérifier qu'il peut être relu.
Cette vérification ne garantit pas la justesse musicale et ne corrige pas
automatiquement les erreurs de reconnaissance. Les partitions manuscrites
ne sont pas prises en charge par Audiveris.

## Installation

Depuis la racine du dépôt, installer la dépendance Python optionnelle :

```bash
.venv/bin/python -m pip install music21
```

### Installer Audiveris sous Linux (Ubuntu 24.04 / Zorin OS 18, x86_64)

Télécharger le paquet officiel Audiveris 5.11.0, puis l'installer :

```bash
curl -fL https://github.com/Audiveris/audiveris/releases/download/5.11.0/Audiveris-5.11.0-ubuntu24.04-x86_64.deb \
  -o /tmp/audiveris-5.11.0.deb
sudo apt install /tmp/audiveris-5.11.0.deb
```

Ce paquet inclut Java et installe le lanceur dans `/opt/audiveris/bin/Audiveris`.
Pour ouvrir l'interface graphique :

```bash
/opt/audiveris/bin/Audiveris
```

Pour une autre distribution ou architecture, choisir le paquet adapté sur
les [releases officielles](https://github.com/Audiveris/audiveris/releases).
Voir aussi la [documentation d'installation](https://audiveris.github.io/audiveris/_pages/tutorials/install/binaries/).

### Installer les données OCR pour le script

Depuis la racine du dépôt :

```bash
mkdir -p dist/tessdata
curl -fL https://raw.githubusercontent.com/tesseract-ocr/tessdata/main/eng.traineddata \
  -o dist/tessdata/eng.traineddata
```

Utiliser le modèle du dépôt `tessdata` : celui de `tessdata_fast` ne prend
pas en charge le mode legacy utilisé pendant notre test avec Audiveris 5.11.0.
L'interface graphique permet également d'installer les langues OCR.

Avec l'installation système ci-dessus, lancer la conversion ainsi :

```bash
JAVA_TOOL_OPTIONS=-Djava.awt.headless=true \
TESSDATA_PREFIX="$PWD/dist/tessdata" \
.venv/bin/python utils/score-to-musicxml.py "partition.pdf" \
  --sheets 1 --single-score \
  --audiveris /opt/audiveris/bin/Audiveris
```

### Variante locale sans sudo (utilisée pour notre test)

Après le téléchargement du même paquet `.deb`, l'extraire dans le projet :

```bash
mkdir -p dist/audiveris-runtime
dpkg-deb -x /tmp/audiveris-5.11.0.deb dist/audiveris-runtime
```

Dans la commande de conversion, remplacer alors `/opt/audiveris/bin/Audiveris`
par `dist/audiveris-runtime/opt/audiveris/bin/Audiveris`.

## Utilisation

Commencer avec une seule page contenant des portées :

```bash
.venv/bin/python utils/score-to-musicxml.py "partition.pdf" --sheets 1
```

Pour une image et un lanceur installé ailleurs :

```bash
.venv/bin/python utils/score-to-musicxml.py "partition.png" \
  --audiveris /chemin/vers/Audiveris/bin/Audiveris
```

Pour plusieurs pages, ajouter `--sheets 1 3-5`. Sans cette option, toutes les
pages sont traitées. Un PDF contenant uniquement des paroles et des accords
n'est pas une partition à reconnaître avec cet outil.

Si les retraits des portées provoquent un découpage incorrect du morceau,
ajouter `--single-score` pour désactiver cette détection dans Audiveris.

### Test local « Au cœur de la planète »

Audiveris 5.11.0 a été extrait dans `dist/audiveris-runtime/` et music21 10.5.1
installé dans `.venv`. Les données OCR anglaises sont dans `dist/tessdata/`.
Le PDF contient une page de partition puis une page de paroles seules.
Commande utilisée pour la première page :

```bash
JAVA_TOOL_OPTIONS=-Djava.awt.headless=true \
TESSDATA_PREFIX="$PWD/dist/tessdata" \
.venv/bin/python utils/score-to-musicxml.py \
  /home/romain/Téléchargements/partitions_au_coeur_de_la_planete_pdagogie-et-ducatif_louveteaux-jeannettes_be39c20f5a.pdf \
  --sheets 1 --single-score \
  --audiveris dist/audiveris-runtime/opt/audiveris/bin/Audiveris
```

Ces dépendances locales sont ignorées par Git. Le modèle OCR anglais permet
de tester le pipeline, mais les paroles françaises doivent être relues.

Pour tester seulement la lecture et l'export music21, sans Audiveris :

```bash
.venv/bin/python utils/score-to-musicxml.py "partition.mxl"
```

Chaque exécution crée un dossier unique dans `dist/omr-tests/` (déjà ignoré
par Git). Il contient le journal Audiveris, ses fichiers originaux et projets
`.omr`, ainsi que les fichiers `.musicxml` réexportés par music21. Le fichier
d'entrée est conservé. `--output-dir` permet de choisir un autre emplacement.
Ouvrir le résultat dans un éditeur de partitions et le comparer à l'original.
Conserver les fichiers `.omr` pour corriger la reconnaissance dans Audiveris.

Références : [CLI Audiveris](https://audiveris.github.io/audiveris/_pages/guides/advanced/cli/),
[formats music21](https://www.music21.org/music21docs/usersGuide/usersGuide_08_installingMusicXML.html).
