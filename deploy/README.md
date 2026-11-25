# Déploiement automatique sur le conteneur Nginx

Chaque minute, un timer systemd regarde si `main` a changé sur GitHub. Si oui,
il reconstruit le site avec MkDocs et le publie dans `/var/www/sin`.

```
git push ──► GitHub ◄── sin-deploy.timer (1 min) ──► mkdocs build --strict ──► /var/www/sin ──► Nginx
```

- **Aucun port à ouvrir** : le serveur va chercher les modifications, GitHub
  ne contacte jamais ta maison.
- **Un build raté ne casse rien** : le site en ligne reste tel quel (lien cassé,
  erreur de syntaxe…) et le serveur réessaie chaque minute jusqu'au prochain
  push correct.

## Installation (une seule fois, en root sur le conteneur)

```bash
apt install git
git clone https://github.com/PFrogerais/sti2d-sin.git /root/sti2d-sin
/root/sti2d-sin/deploy/install.sh
```

Puis adapte `server_name` dans `/etc/nginx/sites-available/sin` et
`systemctl reload nginx`.

Le script crée l'utilisateur `deploy`, le clone `/srv/sti2d-sin`, le venv
`/opt/sin-venv`, installe le timer et fait une première publication. On peut le
relancer sans risque.

## Au quotidien

| Besoin                          | Commande                                         |
|---------------------------------|--------------------------------------------------|
| suivre les publications         | `journalctl -u sin-deploy -f`                    |
| dernière publication            | `systemctl status sin-deploy`                    |
| forcer une reconstruction       | `sudo -u deploy FORCE=1 /usr/local/bin/sin-deploy` |
| suspendre / reprendre           | `systemctl stop sin-deploy.timer` / `start`      |
| prochaine vérification          | `systemctl list-timers sin-deploy.timer`         |

Après une modification de `deploy/sin-deploy.sh` ou des fichiers `.service` /
`.timer`, relancer `deploy/install.sh` depuis `/srv/sti2d-sin`.

## Réglages

Dans `/etc/default/sin-deploy` (facultatif) :

```bash
BRANCH=main
WEB_ROOT=/var/www/sin
```

## Fichiers

| Fichier              | Installé dans                        |
|----------------------|--------------------------------------|
| `sin-deploy.sh`      | `/usr/local/bin/sin-deploy`          |
| `sin-deploy.service` | `/etc/systemd/system/`               |
| `sin-deploy.timer`   | `/etc/systemd/system/`               |
| `nginx-sin.conf`     | `/etc/nginx/sites-available/sin`     |
