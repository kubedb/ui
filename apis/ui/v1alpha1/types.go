/*
Copyright AppsCode Inc. and Contributors

Licensed under the AppsCode Community License 1.0.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://github.com/appscode/licenses/raw/1.0.0/AppsCode-Community-1.0.0.md

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package v1alpha1

type ImageRef struct {
	Repository string `json:"repository"`
	PullPolicy string `json:"pullPolicy"`
	Tag        string `json:"tag"`
}

type ServiceAccountSpec struct {
	Create bool `json:"create"`
	//+optional
	Name *string `json:"name"`
	//+optional
	Annotations map[string]string `json:"annotations"`
}

type ServiceSpec struct {
	Type string `json:"type"`
	Port int    `json:"port"`
}

type CreateFlag struct {
	Create bool `json:"create"`
}

type ObjectRef struct {
	Name      string `json:"name"`
	Namespace string `json:"namespace"`
}

type LocalObjectRef struct {
	Name string `json:"name"`
}

type GatewaySpec struct {
	ClassName      string     `json:"className"`
	Port           int        `json:"port"`
	TlsSecretRef   ObjectRef  `json:"tlsSecretRef"`
	ReferenceGrant CreateFlag `json:"referenceGrant"`
}

type KedaSpec struct {
	ProxyService ProxyServiceSpec `json:"proxyService"`
}

type ProxyServiceSpec struct {
	Namespace string `json:"namespace"`
	Name      string `json:"name"`
	Port      int    `json:"port"`
}

type Autoscaling struct {
	Http ReplicaRange `json:"http"`
}

type ReplicaRange struct {
	MinReplicas int `json:"minReplicas"`
	MaxReplicas int `json:"maxReplicas"`
}

type AppRef struct {
	Service    ObjectRef      `json:"service"`
	AuthSecret LocalObjectRef `json:"authSecret"`
}

type SecureAppRef struct {
	Service    ObjectRef      `json:"service"`
	AuthSecret LocalObjectRef `json:"authSecret"`
	TLS        TLS            `json:"tls"`
}

type TLS struct {
	Enabled bool `json:"enabled"`
}
