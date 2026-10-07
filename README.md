# Carnet de chants
Bienvenue dans le dépôt du carnet de chant du groupe SGDF Joséphine Baker !

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

## Quitter l’environnement

Pour quitter l’environnement :

```bash
deactivate
```
