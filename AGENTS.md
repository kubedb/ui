# AGENTS.md - KubeDB UI Charts

This file provides instructions for AI coding agents working in this Go + Helm repository.

## Project Overview

KubeDB UI Charts: Helm chart distribution and Go API definitions for KubeDB database web UIs (DBGate, MongoUI, pgAdmin, phpMyAdmin, Kafka UI). The Go module under `apis/` defines `ui.kubedb.com/v1alpha1` CRD types whose `Spec` schemas are exported as Helm `values.openapiv3_schema.yaml` for each chart. Module path: `kubedb.dev/ui`, Go `1.25.0`.

API group: `ui.kubedb.com`, version `v1alpha1`. Registered kinds: `Dbgate`, `MongoUi`, `Pgadmin`, `Phpmyadmin` (no Kafka UI Go type yet; chart only).

## Build & Development Commands

```bash
# Format Go sources (runs hack/fmt.sh in build container)
make fmt

# Build the binary (no main package shipped; relies on `go install ./...`)
make build

# Run unit tests (Go)
make test
make unit-tests

# Lint with golangci-lint
make lint

# Full CI gate: verify + check-license + lint + build + unit-tests
make ci

# Regenerate deepcopy, CRDs, OpenAPI values schemas, chart README
make gen           # = clientset + manifests (gen-crds, gen-values-schema, gen-chart-doc)
make manifests     # CRDs + values schemas + chart docs only
make clientset     # deepcopy generation via gengo
make openapi       # OpenAPI v2 swagger via hack/gencrd

# Helm chart-testing (lint + install) against a kind cluster
make ct
make ct CT_COMMAND=lint TEST_CHARTS=charts/dbgate

# Verify generated files / go.mod are up to date
make verify
make verify-gen
make verify-modules

# License headers
make add-license
make check-license

# Clean build outputs
make clean
```

### Chart Version Bumps

```bash
# Sets repository.{name,url} in doc.yaml, plus Chart.yaml version/appVersion
# and dependency versions in charts/kubedb and charts/kubedb-opscenter
make update-charts CHART_VERSION=v2026.3.30 \
  CHART_REGISTRY=appscode \
  CHART_REGISTRY_URL=https://charts.appscode.com/stable/
```

### CRD Importer

```bash
# Pull KEDA http-add-on CRD into every chart's crds/ directory
./hack/scripts/import-crds.sh
```

## Project Structure

```
apis/ui/
  register.go                # GroupName = "ui.kubedb.com"
  v1alpha1/
    doc.go                   # +groupName, codegen markers
    register.go              # SchemeBuilder, addKnownTypes
    types.go                 # Shared structs (ImageRef, GatewaySpec, KedaSpec, ...)
    dbgate_types.go          # Dbgate / DbgateSpec / DBRef
    mongo_ui_types.go        # MongoUi / MongoUiSpec / MongoRef / MongoClientTLS
    pgadmin_types.go         # Pgadmin / PgadminSpec
    phpmyadmin.go            # Phpmyadmin / PhpmyadminSpec
    types_test.go            # schema-checker test for default values
    zz_generated.deepcopy.go # Generated DeepCopy methods
  install/install.go         # Scheme installer
  fuzzer/fuzzer.go           # Roundtrip fuzz helpers
charts/
  dbgate/      kafka-ui/  mongo-ui/  pgadmin/  phpmyadmin/
    Chart.yaml
    doc.yaml                 # chart-doc-gen input
    values.yaml
    values.openapiv3_schema.yaml  # Derived from .crds/ui.kubedb.com_<plural>.yaml
    templates/               # deployment, service, gw, keda, namespace, ...
    crds/                    # Imported third-party CRDs (KEDA http-add-on)
    ci/ci-values.yaml        # Inputs for `ct install`
    README.md                # chart-doc-gen output (do not hand-edit)
.crds/                       # Generated KubeDB UI CRDs (source of truth for values schemas)
hack/
  build.sh                   # ldflags + go install (CGO disabled, vendor mode)
  fmt.sh  test.sh  e2e.sh
  license/{go,bash,dockerfile,makefile}.txt   # ltag templates
  scripts/
    ct.sh                    # Per-chart lint/install loop (CI entrypoint)
    cleanup.sh
    update-chart-dependencies.sh
    import-crds.sh
    open-pr.sh
    update-release-tracker.sh
  kubernetes/kind.yaml
  crd-patch.json
.github/workflows/
  ci.yml                     # make ci + kind matrix (k8s v1.29..v1.35)
  publish-oci.yml
  release.yml
  release-tracker.yml
```

## Key Packages / APIs

- `apis/ui` (`GroupName = "ui.kubedb.com"`) — defines the API group constant only.
- `apis/ui/v1alpha1` — CRD `Spec` types whose JSON tags drive the Helm `values.yaml` shape. Top-level types embed `metav1.TypeMeta` + `metav1.ObjectMeta` plus a `Spec`.
- Shared spec building blocks in `types.go`: `ImageRef`, `ServiceAccountSpec`, `ServiceSpec`, `CreateFlag`, `ObjectRef`, `LocalObjectRef`, `GatewaySpec`, `KedaSpec`, `ProxyServiceSpec`, `Autoscaling` / `ReplicaRange`, `AppRef`, `SecureAppRef`, `TLS`. These are reused across all four UI Specs.
- Per-product references: `DBRef` (DBGate, with `Kind`), `MongoRef` + `MongoClientTLS` (MongoUI), and equivalents in pgadmin / phpmyadmin types.
- `apis/ui/v1alpha1/register.go` — `SchemeGroupVersion`, `Kind`, `Resource`, `addKnownTypes` registers Dbgate, MongoUi, Pgadmin, Phpmyadmin (and their List kinds).
- `apis/ui/install/install.go` — `Install(scheme)` calls `v1alpha1.AddToScheme` + `SetVersionPriority`.
- `apis/ui/fuzzer/fuzzer.go` — used by `install/roundtrip_test.go`.

Codegen tags in use: `+genclient`, `+genclient:skipVerbs=updateStatus`, `+k8s:openapi-gen=true`, `+k8s:deepcopy-gen:interfaces=...runtime.Object`, `+kubebuilder:object:root=true`, `+k8s:conversion-gen`, `+k8s:defaulter-gen=TypeMeta`.

## Testing

- Go unit tests: `make unit-tests` (or `make test`). Test directories declared via `SRC_PKGS := apis`.
- `apis/ui/v1alpha1/types_test.go` runs `kmodules.xyz/schema-checker` against each `Spec` to validate default values vs. generated OpenAPI schema.
- `apis/ui/install/roundtrip_test.go` exercises codec roundtrips with the fuzzer.
- Helm chart tests via chart-testing (`ct`): `make ct` shells into `quay.io/helmpack/chart-testing:v3.13.0`, running `./hack/scripts/cleanup.sh`, `./hack/scripts/update-chart-dependencies.sh`, then `ct $(CT_COMMAND)` (default `lint-and-install`). Per-chart driver: `hack/scripts/ct.sh`.
- CI matrix (`.github/workflows/ci.yml`) installs charts on kind across k8s `v1.29.14`, `v1.31.14`, `v1.33.7`, `v1.35.0`.

## Dependencies

- Runtime libs (required): `k8s.io/api`, `k8s.io/apimachinery`, `kmodules.xyz/resource-metadata` (provides `shared.RegistryProxies` used in every Spec), `kmodules.xyz/schema-checker` (test-only).
- All other deps are indirect via vendor. Build uses `GOFLAGS=-mod=vendor` and `CGO_ENABLED=0`.
- `go.mod` replaces:
  - `github.com/Masterminds/sprig/v3` -> `github.com/gomodules/sprig/v3 v3.2.3-0.20220405051441-0a8a99bac1b8`
  - `sigs.k8s.io/controller-runtime` -> `github.com/kmodules/controller-runtime v0.22.5-0.20251227114913-f011264689cd`
  - `github.com/imdario/mergo` -> `v0.3.6`
  - `k8s.io/apiserver` -> `github.com/kmodules/apiserver v0.34.4-0.20251227112449-07fa35efc6fc`
- External tooling images: `ghcr.io/appscode/gengo:release-1.32` (codegen), `ghcr.io/appscode/golang-dev:1.25` (build/test/lint), `quay.io/helmpack/chart-testing:v3.13.0` (ct).

## Code Conventions

- License header (AppsCode Community License 1.0.0) required on every Go file; templates in `hack/license/`. Enforce with `make check-license`; apply with `make add-license`.
- `golangci-lint` config (`.golangci.yml`): standard linters + `unparam`; formatters `gofmt` + `goimports`; gofmt rewrite rule converts `interface{}` -> `any`; `client/` and `vendor/` excluded; `generated.*\\.go` files skipped.
- All Go work happens via Docker through `make` targets; do not invoke `go build` locally if you need reproducible CI parity (build container provides matching toolchain and writes into `.go/` cache).
- New API types belong in `apis/ui/v1alpha1/` and must be added to `addKnownTypes` in `register.go`. Re-run `make gen` after type changes to refresh `zz_generated.deepcopy.go`, CRDs in `.crds/`, and per-chart `values.openapiv3_schema.yaml`.
- Chart values schemas are derived from CRDs: `make gen-values-schema` looks up `.crds/ui.kubedb.com_<dir-with-dashes-removed>s.yaml` (so chart dir `mongo-ui` maps to CRD `ui.kubedb.com_mongouis.yaml`). Rename consistency matters.
- Chart README files are generated by `chart-doc-gen` from `charts/<name>/doc.yaml`; never edit `charts/*/README.md` by hand.
- Imported third-party CRDs (KEDA http-add-on) live in each chart's `crds/` directory and are refreshed via `./hack/scripts/import-crds.sh` (controlled by `KEDACORE_HTTP_ADD_ON_TAG`).
- Reuse the shared types in `apis/ui/v1alpha1/types.go` (`ImageRef`, `GatewaySpec`, `KedaSpec`, etc.) rather than redefining per product.
