# most premium Hub to ever exist alot of games supported
for **more** info visit the website, and to know about the supported games open:
**Scr/games.json.**

## Repository layout

- `Scr/games/` contains one script per supported game, named by place ID (or a readable name for shared scripts).
- `Scr/games.json` is the manifest of those scripts. It is generated automatically by `.github/workflows/update-games.yml` (on push, daily, or manually). Do not edit it by hand.
- `.github/workflows/lint.yml` validates JSON files and runs Luau linting on pull requests.
