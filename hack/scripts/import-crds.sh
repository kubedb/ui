#!/bin/bash

# Copyright AppsCode Inc. and Contributors
#
# Licensed under the AppsCode Community License 1.0.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://github.com/appscode/licenses/raw/1.0.0/AppsCode-Community-1.0.0.md
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eou pipefail

KEDACORE_HTTP_ADD_ON_TAG=${KEDACORE_HTTP_ADD_ON_TAG:-v0.8.0}
KUBERNETES_SIGS_GATEWAY_API_TAG=${KUBERNETES_SIGS_GATEWAY_API_TAG:-v1.1.0}

# dashboard charts
crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/dbgate/crds
crd-importer \
    --input=https://github.com/kedacore/http-add-on/raw/${KEDACORE_HTTP_ADD_ON_TAG}/config/crd/bases/http.keda.sh_httpscaledobjects.yaml \
    --labels 'app.kubernetes.io/managed-by=Helm' \
    --annotations 'meta.helm.sh/release-name=keda-add-ons-http,meta.helm.sh/release-namespace=keda' \
    --out=./charts/dbgate/crds

crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/kafka-ui/crds
crd-importer \
    --input=https://github.com/kedacore/http-add-on/raw/${KEDACORE_HTTP_ADD_ON_TAG}/config/crd/bases/http.keda.sh_httpscaledobjects.yaml \
    --labels 'app.kubernetes.io/managed-by=Helm' \
    --annotations 'meta.helm.sh/release-name=keda-add-ons-http,meta.helm.sh/release-namespace=keda' \
    --out=./charts/kafka-ui/crds

crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/mongo-ui/crds
crd-importer \
    --input=https://github.com/kedacore/http-add-on/raw/${KEDACORE_HTTP_ADD_ON_TAG}/config/crd/bases/http.keda.sh_httpscaledobjects.yaml \
    --labels 'app.kubernetes.io/managed-by=Helm' \
    --annotations 'meta.helm.sh/release-name=keda-add-ons-http,meta.helm.sh/release-namespace=keda' \
    --out=./charts/mongo-ui/crds

crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/pgadmin/crds
crd-importer \
    --input=https://github.com/kedacore/http-add-on/raw/${KEDACORE_HTTP_ADD_ON_TAG}/config/crd/bases/http.keda.sh_httpscaledobjects.yaml \
    --labels 'app.kubernetes.io/managed-by=Helm' \
    --annotations 'meta.helm.sh/release-name=keda-add-ons-http,meta.helm.sh/release-namespace=keda' \
    --out=./charts/pgadmin/crds

crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/phpmyadmin/crds
crd-importer \
    --input=https://github.com/kedacore/http-add-on/raw/${KEDACORE_HTTP_ADD_ON_TAG}/config/crd/bases/http.keda.sh_httpscaledobjects.yaml \
    --labels 'app.kubernetes.io/managed-by=Helm' \
    --annotations 'meta.helm.sh/release-name=keda-add-ons-http,meta.helm.sh/release-namespace=keda' \
    --out=./charts/phpmyadmin/crds
