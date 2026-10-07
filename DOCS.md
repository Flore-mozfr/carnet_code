# Fonctionnement des templates du carnet

## De la configuration au PDF

`books/carnet.yaml` décrit le carnet : langue, titre, auteur, options des
accords et sélection des chants. Il choisit `data.tex` comme template avec
`book.template`.

La commande `songbook ./books/carnet.yaml` lit cette configuration et les
fichiers de chants, puis rend les templates pour générer `carnet.tex`.
LaTeX compile ensuite ce fichier en PDF. Patacrep construit aussi les index
et relance la compilation pour les intégrer.

Modifier `carnet.tex` ne constitue donc pas une modification durable : il est
régénéré. Modifier plutôt la configuration, les chants ou les templates du dépôt.

## La chaîne d’héritage

Les templates locaux sont dans `templates/songbook/`. Chaque flèche ci-dessous
signifie « hérite de » :

```text
data.tex → patacrep.tex → default.tex → songs.tex → layout.tex
```

| Fichier | Rôle |
| --- | --- |
| `layout.tex` | Squelette du document : préambule, début et fin du document, ordre des blocs. |
| `songs.tex` | Charge les outils LaTeX pour les chants, configure la langue et insère le contenu du carnet. |
| `default.tex` | Configure le titre, l’auteur et les index ; appelle la page de titre et affiche les index. |
| `patacrep.tex` | Charge le style de couverture `crepbook`, configure les couleurs, les liens et les informations de couverture. |
| `data.tex` | Personnalise les polices des chants et accords, la géométrie de la page et les colonnes. |

`default.tex` est donc un point central pour les éléments habituels du carnet,
mais le squelette et l’ordre des sections viennent de `layout.tex`.

## Comment les blocs s’assemblent

Les fichiers `.tex` contiennent à la fois du LaTeX et des directives de template :

```text
(* extends "default.tex" *)       hériter d’un parent
(* block title *)                remplacer le bloc title du parent
(* endblock *)                   terminer le bloc
(( super() ))                    reprendre le contenu du bloc parent
(( template_var.subtitle ))      insérer une valeur
```

Un enfant remplace uniquement les blocs qu’il redéfinit. Les autres restent
hérités. Dans un bloc redéfini, `super()` permet de conserver le contenu du
parent et d’y ajouter des éléments.

Les sections entre `(* variables *)` et `(* endvariables *)` décrivent les
paramètres du template et leurs valeurs par défaut. Le YAML du carnet peut
les personnaliser dans `template`, sous le nom du template concerné :

```yaml
template:
  default.tex:
    title: "Carnet de chants"
    author: "Groupe Joséphine Baker"
  patacrep.tex:
    subtitle: "parolier"
```

Dans cette section de paramètres, utiliser `#` pour un commentaire YAML.
Dans le code LaTeX, utiliser `%`. Les directives `(* ... *)` sont traitées
avant LaTeX : les préfixer avec `%` ne les désactive pas au niveau du moteur
de templates.

## Les templates et les styles LaTeX

Les templates produisent les commandes ; les fichiers `.sty` définissent leur
comportement et leur rendu. Certains styles sont locaux, dans
`templates/styles/`, et d’autres sont fournis par le paquet Python Patacrep.

Pour la couverture, le chemin est le suivant :

1. `patacrep.tex` charge `crepbook.sty` et fournit les informations de couverture.
2. Le bloc `title` de `default.tex` appelle `\maketitle`.
3. `crepbook.sty` définit le dessin de cette page, les libellés et le pied de page.

Les adaptations doivent rester dans le dépôt : une modification d’un style
dans `.venv/lib/.../site-packages/` ne serait pas partagée avec les autres
utilisateurs et pourrait disparaître lors d’une réinstallation.

## Où intervenir pour modifier le carnet ?

Choisir le fichier selon ce que l’on veut changer :

| Modification | Point de départ |
| --- | --- |
| Titre, auteur, langue, options des accords | `books/carnet.yaml` |
| Paroles, accords ou informations d’un chant | Le fichier `.sg` correspondant dans `songs/` |
| Polices des chants, format de page ou colonnes | Paramètres de `data.tex` dans le YAML, puis son bloc `preambule` si nécessaire |
| Contenu ou ordre des index | Blocs `index` et `songbookpreambule` de `default.tex` |
| Informations et apparence de la couverture | `patacrep.tex`, puis les commandes définies par `crepbook.sty` |
| Ordre général des sections | `layout.tex` ou les blocs concernés dans un template enfant |

Pour comprendre une modification, partir du résultat souhaité, retrouver le
bloc qui génère ses commandes, puis suivre leur définition dans le style
LaTeX si nécessaire. Une valeur de configuration change les données ; un
bloc change les commandes produites ; un style change leur rendu.

Par exemple, le titre suit ce parcours :

```text
books/carnet.yaml : template.default.tex.title
    → default.tex : \title{...}
    → default.tex : bloc title, appel de \maketitle
    → crepbook.sty : dessin de la page de titre
```

Après une modification, recompiler pour mettre à jour le PDF :

```bash
source .venv/bin/activate
songbook ./books/carnet.yaml
```

Si le rendu ne correspond pas à la modification, regarder `carnet.tex` pour
vérifier les commandes effectivement générées. Si LaTeX échoue, consulter
`carnet.log` : cela permet de distinguer un problème de génération du template
d’un problème d’exécution des commandes LaTeX.

## Étude de cas : retirer des informations de couverture

Le pied de page et le mail illustrent la séparation entre configuration,
template et style : retirer une valeur ou commenter un appel n’a pas toujours
le même effet que désactiver son affichage.

### Un contenu vide peut rester nécessaire

Le style `crepbook.sty` définit :

```latex
\def\footer#1{\def\@footer{#1}}
```

Sa page de titre utilise ensuite directement `\@footer`. Commenter l’appel
qui le définit peut donc provoquer une erreur `Undefined control sequence`.

Le template conserve la ligne d’origine en commentaire et définit un contenu
vide pour retirer la mention de génération :

```latex
% \footer{(( template_var.footer ))}
\footer{}
```

Cela vide le texte du pied de page ; les autres éléments dessinés par le style,
comme le trait au-dessus, restent en place.

### Une valeur vide ne désactive pas forcément une ligne

Le style transforme l’adresse en lien. Même avec une adresse vide,
`\mail{}` définit des commandes de lien dans `\@mail`, ce qui ne constitue pas
un contenu vide pour son test d’affichage. Le libellé « Mail : » peut rester.

Dans notre `patacrep.tex`, l’appel qui fournit l’adresse est commenté. Le
template redéfinit aussi `\@metainfos`, la liste des informations de couverture,
en conservant la ligne d’insertion du mail en commentaire :

```latex
% \@insertelement{mail}
```

Ainsi, toute la ligne du mail est désactivée, y compris son libellé, et son code
reste disponible. `\makeatletter` et `\makeatother` entourent cette adaptation
pour permettre l’utilisation des commandes internes contenant `@`.

Dans les deux cas, suivre la commande jusqu’à sa définition dans le style
explique le comportement : le pied de page exige une commande définie, tandis
que la ligne du mail possède sa propre logique d’affichage.
