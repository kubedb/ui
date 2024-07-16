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

import (
	core "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

const (
	ResourceKindPgadmin = "Pgadmin"
	ResourcePgadmin     = "pgadmin"
	ResourcePgadmins    = "pgadmins"
)

// Pgadmin defines the schama for Pgadmin operator installer.

// +genclient
// +genclient:skipVerbs=updateStatus
// +k8s:openapi-gen=true
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// +kubebuilder:object:root=true
type Pgadmin struct {
	metav1.TypeMeta   `json:",inline,omitempty"`
	metav1.ObjectMeta `json:"metadata,omitempty"`
	Spec              PgadminSpec `json:"spec,omitempty"`
}

type PgadminSpec struct {
	ReplicaCount          int                       `json:"replicaCount"`
	Image                 ImageRef                  `json:"image"`
	ImagePullSecrets      []string                  `json:"imagePullSecrets"`
	NameOverride          string                    `json:"nameOverride"`
	FullnameOverride      string                    `json:"fullnameOverride"`
	ServiceAccount        ServiceAccountSpec        `json:"serviceAccount"`
	PodAnnotations        map[string]string         `json:"podAnnotations"`
	PodSecurityContext    *core.PodSecurityContext  `json:"podSecurityContext"`
	SecurityContext       *core.SecurityContext     `json:"securityContext"`
	Service               ServiceSpec               `json:"service"`
	Resources             core.ResourceRequirements `json:"resources"`
	NodeSelector          map[string]string         `json:"nodeSelector"`
	Tolerations           []core.Toleration         `json:"tolerations"`
	Affinity              *core.Affinity            `json:"affinity"`
	Namespace             CreateFlag                `json:"namespace"`
	Gateway               GatewaySpec               `json:"gateway"`
	Keda                  KedaSpec                  `json:"keda"`
	TargetPendingRequests int                       `json:"targetPendingRequests"`
	Autoscaling           Autoscaling               `json:"autoscaling"`
	App                   AppRef                    `json:"app"`
	Bind                  ObjectRef                 `json:"bind"`
	Authzproxy            AuthzproxySpec            `json:"authzproxy"`
}

// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// PgadminList is a list of Pgadmins
type PgadminList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	// Items is a list of Pgadmin CRD objects
	Items []Pgadmin `json:"items,omitempty"`
}
