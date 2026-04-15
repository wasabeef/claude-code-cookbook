# Mettre à jour les dépendances Rust en toute sécurité

Met à jour en toute sécurité les dépendances de votre projet Rust.

## Utilisation

```bash
# Vérifier le statut des dépendances et demander l'aide de Claude
cargo tree
"Please update the dependencies in Cargo.toml to their latest versions"
```

## Exemples de base

```bash
# Vérifier les dépendances actuelles
cat Cargo.toml
"Analyze this Rust project's dependencies and tell me which crates can be updated"

# Vérifier la liste des crates à mettre à jour
cargo update --dry-run
"Analyze the risk level of updating these crates"
```

## Intégration avec Claude

```bash
# Mise à jour complète des dépendances
cat Cargo.toml
"Analyze Rust dependencies and perform the following:
1. Research the latest version of each crate
2. Check for breaking changes
3. Evaluate risk level (safe, caution, dangerous)
4. Suggest necessary code changes
5. Generate updated Cargo.toml"

# Mise à jour sûre et progressive
cargo tree
"Update only crates that can be safely updated, avoiding major version upgrades"

# Analyse d'impact pour la mise à jour d'un crate spécifique
"Tell me the impact and necessary changes when updating tokio to the latest version"
```

## Exemples détaillés

```bash
# Analyse détaillée incluant les notes de version
cat Cargo.toml && cargo tree
"Analyze dependencies and provide the following for each crate in table format:
1. Current → Latest version
2. Risk evaluation (safe, caution, dangerous)
3. Main changes (from CHANGELOG)
4. Trait bound changes
5. Required code fixes"

# Analyse de migration de runtime async
cat Cargo.toml src/main.rs
"Present all necessary changes for migrating from async-std to tokio or upgrading tokio to a new major version"
```

## Critères de risque

```text
Sûr (🟢) :
- Mise à niveau de version patch (0.1.2 → 0.1.3)
- Corrections de bugs uniquement
- Compatibilité ascendante garantie

Attention (🟡) :
- Mise à niveau de version mineure (0.1.0 → 0.2.0)
- Nouvelles fonctionnalités ajoutées
- Avertissements de dépréciation

Dangereux (🔴) :
- Mise à niveau de version majeure (0.x.y → 1.0.0, 1.x.y → 2.0.0)
- Changements cassants
- Suppression ou modification d'API
- Changements de trait bounds
```

## Exécution de la mise à jour

```bash
# Créer des sauvegardes
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# Exécuter la mise à jour
cargo update

# Vérifier après la mise à jour
cargo check
cargo test
cargo clippy
```

## Notes

Toujours vérifier la fonctionnalité après les mises à jour. En cas de problème, restaurer avec :

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
