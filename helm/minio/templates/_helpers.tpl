{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper MinIO&reg; image name
*/}}
{{- define "minio.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}

{{- end -}}

{{/*
Return the proper MinIO&reg; Client image name
*/}}
{{- define "minio.clientImage" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.clientImage "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "minio.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "minio.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.clientImage .Values.volumePermissions.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Get the user to use to access MinIO&reg;
*/}}
{{- define "minio.secret.userValue" -}}
{{- if and (eq .Values.global.persistence.mode "s3") }}
    {{- if eq .Values.gateway.type "azure" }}
        {{- if .Values.gateway.auth.azure.accessKey }}
            {{- .Values.gateway.auth.azure.accessKey -}}
        {{- else -}}
            {{- randAlphaNum 10 -}}
        {{- end -}}
    {{- else if eq .Values.gateway.type "gcs" }}
        {{- if .Values.gateway.auth.gcs.accessKey }}
            {{- .Values.gateway.auth.gcs.accessKey -}}
        {{- else -}}
            {{- randAlphaNum 10 -}}
        {{- end -}}
    {{- else if eq .Values.gateway.type "nas" }}
        {{- if .Values.gateway.auth.nas.accessKey }}
            {{- .Values.gateway.auth.nas.accessKey -}}
        {{- else -}}
            {{- randAlphaNum 10 -}}
        {{- end -}}
    {{- else if eq .Values.global.persistence.mode "s3" }}
        {{- .Values.global.persistence.accessKey -}}
    {{- end -}}
{{- else if eq .Values.global.persistence.mode "minio" }}
    {{- $accessKey := .Values.global.persistence.accessKey -}}
    {{- if $accessKey }}
        {{- $accessKey -}}
        {{ required "An Access Key is required!" .Values.global.persistence.accessKey }}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Get the password to use to access MinIO&reg;
*/}}
{{- define "minio.secret.passwordValue" -}}
{{- if and (eq .Values.global.persistence.mode "s3") }}
    {{- if eq .Values.gateway.type "azure" }}
        {{- if .Values.gateway.auth.azure.secretKey }}
            {{- .Values.gateway.auth.azure.secretKey -}}
        {{- else -}}
            {{- randAlphaNum 40 -}}
        {{- end -}}
    {{- else if eq .Values.gateway.type "gcs" }}
        {{- if .Values.gateway.auth.gcs.secretKey }}
            {{- .Values.gateway.auth.gcs.secretKey -}}
        {{- else -}}
            {{- randAlphaNum 40 -}}
        {{- end -}}
    {{- else if eq .Values.gateway.type "nas" }}
        {{- if .Values.gateway.auth.nas.secretKey }}
            {{- .Values.gateway.auth.nas.secretKey -}}
        {{- else -}}
            {{- randAlphaNum 40 -}}
        {{- end -}}
    {{- else if eq .Values.global.persistence.mode "s3" }}
        {{- .Values.global.persistence.secretKey -}}
    {{- end -}}
{{- else if eq .Values.global.persistence.mode "minio" }}
    {{- $secretKey := .Values.global.persistence.secretKey -}}
    {{- if $secretKey }}
        {{- $secretKey -}}
        {{ required "A Secret Key is required!" .Values.global.persistence.secretKey }}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Get the credentials secret.
*/}}
{{- define "minio.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- printf "%s" .Values.auth.existingSecret -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created
*/}}
{{- define "minio.createSecret" -}}
{{- if .Values.auth.existingSecret -}}
{{- else -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a PVC object should be created (only in standalone mode)
*/}}
{{- define "minio.createPVC" -}}
{{- if and .Values.persistence.enabled (not .Values.persistence.existingClaim) (or (and (eq .Values.mode "standalone") (not .Values.gateway.enabled)) (and .Values.gateway.enabled (eq .Values.gateway.type "nas"))) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the PVC name (only in standalone mode)
*/}}
{{- define "minio.claimName" -}}
{{- if and .Values.persistence.existingClaim }}
    {{- printf "%s" (tpl .Values.persistence.existingClaim $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either common.names.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "minio.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
    {{- else -}}
        {{ default "default" .Values.serviceAccount.name }}
    {{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "minio.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
 Return the appropriate apiVersion for ingress.
 */}}
 {{- define "minio.ingress.apiVersion" -}}
 {{- if .Capabilities.APIVersions.Has "extensions/v1beta1" -}}
 {{- print "extensions/v1beta1" -}}
 {{- else -}}
 {{- print "networking.k8s.io/v1beta1" -}}
 {{- end -}}
 {{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "minio.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "minio.validateValues.mode" .) -}}
{{- $messages := append $messages (include "minio.validateValues.totalDrives" .) -}}
{{- $messages := append $messages (include "minio.validateValues.tls" .) -}}
{{- $messages := append $messages (include "minio.validateValues.gateway.type" .) -}}
{{- $messages := append $messages (include "minio.validateValues.gateway.azure.credentials" .) -}}
{{- $messages := append $messages (include "minio.validateValues.gateway.gcs.projectID" .) -}}
{{- $messages := append $messages (include "minio.validateValues.gateway.nas.persistence" .) -}}
{{- $messages := append $messages (include "minio.validateValues.gateway.s3.credentials" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - must provide a valid mode ("distributed" or "standalone")
*/}}
{{- define "minio.validateValues.mode" -}}
{{- $allowedValues := list "distributed" "standalone" }}
{{- if not (has .Values.mode $allowedValues) -}}
minio: mode
    Invalid mode selected. Valid values are "distributed" and
    "standalone". Please set a valid mode (--set mode="xxxx")
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - total number of drives should be multiple of 4
*/}}
{{- define "minio.validateValues.totalDrives" -}}
{{- $replicaCount := int .Values.statefulset.replicaCount }}
{{- $drivesPerNode := int .Values.statefulset.drivesPerNode }}
{{- $totalDrives := mul $replicaCount $drivesPerNode }}
{{- if and (eq .Values.mode "distributed") (or (not (eq (mod $totalDrives 4) 0)) (lt $totalDrives 4)) -}}
minio: total drives
    The total number of drives should be multiple of 4 to guarantee erasure coding!
    Please set a combination of nodes, and drives per node that match this condition.
    For instance (--set statefulset.replicaCount=2 --set statefulset.drivesPerNode=2)
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - TLS secret must provided if TLS is enabled
*/}}
{{- define "minio.validateValues.tls" -}}
{{- if and .Values.tls.enabled (not .Values.tls.secretName) (not .Values.tls.existingSecret) (not .Values.tls.autoGenerated) }}
minio: tls.existingSecret, tls.autoGenerated
    In order to enable TLS, you also need to provide
    an existing secret containing the TLS certificates or
    enable auto-generated certificates.
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - must provide a valid gateway type ("azure", "gcs", "nas" or "s3")
*/}}
{{- define "minio.validateValues.gateway.type" -}}
{{- $allowedValues := list "azure" "gcs" "nas" "s3" }}
{{- if and .Values.gateway.enabled (not (has .Values.gateway.type $allowedValues)) -}}
minio: gateway.type
    Invalid Gateway type. Valid values are "azure", "gcs", "nas" and "s3".
    Please set a valid mode (--set gateway.type="xxxx")
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - when using MinIO&reg; as an Azure Gateway, the StorageAccount Name/Key are required
*/}}
{{- define "minio.validateValues.gateway.azure.credentials" -}}
{{- if and .Values.gateway.enabled (eq .Values.gateway.type "azure") (or (empty .Values.gateway.auth.azure.storageAccountName) (empty .Values.gateway.auth.azure.storageAccountKey)) (or (empty .Values.gateway.auth.azure.storageAccountNameExistingSecret) (empty .Values.gateway.auth.azure.storageAccountNameExistingSecretKey) (empty .Values.gateway.auth.azure.storageAccountKeyExistingSecret) (empty .Values.gateway.auth.azure.storageAccountKeyExistingSecretKey)) }}
minio: gateway.auth.azure
    The StorageAccount name and key are required to use MinIO&reg; as a Azure Gateway.
    Please set a valid StorageAccount information (--set gateway.auth.azure.storageAccountName="xxxx",gateway.auth.azure.storageAccountKey="yyyy")
    Alternatively, specify secrets info to extract StorageAccount name and key:
    --set gateway.auth.azure.storageAccountNameExistingSecret="xxxx", --set gateway.auth.azure.storageAccountNameExistingSecretKey="yyyy",
    --set gateway.auth.azure.storageAccountKeyExistingSecret="aaaa", --set gateway.auth.azure.storageAccountKeyExistingSecretKey="bbbb"
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - when using MinIO&reg; as a GCS Gateway, the GCP project ID is required
*/}}
{{- define "minio.validateValues.gateway.gcs.projectID" -}}
{{- if and .Values.gateway.enabled (eq .Values.gateway.type "gcs") (empty .Values.gateway.auth.gcs.projectID) }}
minio: gateway.auth.gcs.projectID
    A GCP project ID is required to use MinIO&reg; as a GCS Gateway.
    Please set a valid project ID (--set gateway.auth.gcs.projectID="xxxx")
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - when using MinIO&reg; as a NAS Gateway, ReadWriteMany volumes are required
*/}}
{{- define "minio.validateValues.gateway.nas.persistence" -}}
{{- $replicaCount := int .Values.gateway.replicaCount }}
{{- if and .Values.gateway.enabled (eq .Values.gateway.type "nas") (gt $replicaCount 1) (not .Values.persistence.enabled) }}
minio: persistence.enabled
    ReadWriteMany volumes are required to use MinIO&reg; as a NAS Gateway with N replicas.
    Please enable persistence (--set persistence.enabled=true)
{{- else if and .Values.gateway.enabled (eq .Values.gateway.type "nas") (gt $replicaCount 1) (include "minio.createPVC" .) (not (has "ReadWriteMany" .Values.persistence.accessModes)) }}
minio: persistence.accessModes
    ReadWriteMany volumes are required to use MinIO&reg; as a NAS Gateway with N replicas.
    Please set a valid mode (--set persistence.accessModes[0]="ReadWriteMany")
{{- end -}}
{{- end -}}

{{/*
Validate values of MinIO&reg; - when using MinIO&reg; as a S3 Gateway, the Access & Secret keys are required
*/}}
{{- define "minio.validateValues.gateway.s3.credentials" -}}
{{- if and .Values.gateway.enabled (eq .Values.gateway.type "s3") (or (empty .Values.gateway.auth.s3.accessKey) (empty .Values.gateway.auth.s3.secretKey)) }}
minio: gateway.auth.s3
    The Access & Secret keys are required to use MinIO&reg; as a S3 Gateway.
    Please set valid keys (--set gateway.auth.s3.accessKey="xxxx",gateway.auth.s3.secretKey="yyyy")
{{- end -}}
{{- end -}}

{{/*
Return the secret containing MinIO TLS certificates
*/}}
{{- define "minio.tlsSecretName" -}}
{{- $secretName := coalesce .Values.tls.existingSecret .Values.tls.secretName -}}
{{- if $secretName -}}
    {{- printf "%s" (tpl $secretName $) -}}
{{- else -}}
    {{- printf "%s-crt" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a TLS secret object should be created
*/}}
{{- define "minio.createTlsSecret" -}}
{{- if and .Values.tls.enabled .Values.tls.autoGenerated (not .Values.tls.secretName) (not .Values.tls.existingSecret) }}
    {{- true -}}
{{- end -}}
{{- end -}}
