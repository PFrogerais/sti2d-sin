# STI2D SIN

Cours, TD, TP et projets de la spécialité **Systèmes d'Information et
Numérique** (STI2D), écrits en Markdown :

- publiés en site web avec **MkDocs Material** ;
- importables dans **Canoprof** grâce à [md2canoprof](https://github.com/PFrogerais/md2canoprof).

```
docs/**/*.md ──► make build ──► site/        ──► Nginx (déploiement automatique)
             └─► make scar  ──► build/scar/  ──► Canoprof (Importer)
```

## Démarrage

```bash
git clone https://github.com/PFrogerais/sti2d-sin.git && cd sti2d-sin
make install        # venv ~/.venv/md2canoprof : MkDocs + md2canoprof
make serve          # aperçu en direct : http://127.0.0.1:8000
```

## Au quotidien

| Commande                        | Effet                                                 |
|---------------------------------|-------------------------------------------------------|
| `make serve`                    | aperçu local, rechargé à chaque enregistrement        |
| `make build`                    | construit `site/`, échoue si un lien est cassé        |
| `make scar`                     | une archive Canoprof par leçon dans `build/scar/`     |
| `make scar FILTER=02_cour_info` | seulement un thème                                    |
| `make check`                    | `make scar` + vérification de structure Canoprof      |
| `make figures SRC=… OUT=…`      | schémas KiCad / Fritzing → SVG propres                |

Un `git push` sur `main` met le site à jour sur le serveur en moins d'une
minute (voir [deploy/](deploy/README.md)). La CI vérifie la construction du site
et des archives à chaque push.

## Organisation

```
docs/
├── index.md                 # page d'accueil
├── Classes/TSIN/            # périodes (pages d'index)
├── Cours TD TP/             # cours, TD, TP par thème
├── Projet/                  # projets
└── assets/                  # extra.css (blocs Canoprof), video.js, mathjax.js
deploy/                      # mise en ligne sur le conteneur Nginx (systemd)
tools/build_scar.sh          # utilisé par make scar
```

L'arborescence reprend celle de l'atelier Canoprof. Les images, les SVG et le
code sont rangés à côté de la page qui les utilise.

## Écrire une leçon

Voir la syntaxe complète dans le
[README de md2canoprof](https://github.com/PFrogerais/md2canoprof#syntaxe).
L'essentiel :

```markdown
---
title: "TP 4 - Commande d'une LED"
duration: "2h"
---

## Montage

!!! consigne
    Calculer la résistance $R$ pour $I = 10\,mA$.

<!-- zone: 4 -->
```

## Vidéos

Seules les vidéos produites pour le cours sont dans le dépôt. Les vidéos
YouTube sont référencées par un lien (`[▶ Titre](https://youtube.com/...)`).
