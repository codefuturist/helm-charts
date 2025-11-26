#!/usr/bin/env bash
# Script to replace values.yaml with Shlink configuration

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHART_DIR="$(dirname "$SCRIPT_DIR")"
VALUES_FILE="$CHART_DIR/values.yaml"

echo "Replacing values.yaml with Shlink configuration..."

cat > "$VALUES_FILE" << 'EOFVALUES'
# =============================================================================
# Global Parameters
# @section -- Global Parameters
# =============================================================================

# -- Override the namespace for all resources
# @default -- `.Release.Namespace`
namespaceOverride: ""

# -- Override the name of the chart
nameOverride: ""

# -- Override the full name of the chart
fullnameOverride: ""

# -- Additional labels to add to all resources
additionalLabels: {}

# -- Additional annotations to add to all resources
additionalAnnotations: {}

# =============================================================================
# Shlink Backend Image Configuration
# @section -- Image Configuration
# =============================================================================

image:
  # -- Shlink backend API Docker image repository
  repository: shlinkio/shlink
  # -- Shlink backend API Docker image tag
  # @default -- Chart appVersion
  tag: "4.2.4"
  # -- Image pull policy
  pullPolicy: IfNotPresent
  # -- Image digest (overrides tag if set)
  digest: ""

# -- Image pull secrets for private registries
imagePullSecrets: []

# =============================================================================
# Shlink Backend Configuration
# @section -- Shlink Backend Configuration
# =============================================================================

shlink:
  # -- Default domain for short URLs (e.g., short.example.com)
  # This is the primary domain where your short links will be accessible
  defaultDomain: "short.example.com"

  # -- URL schema for short URLs (http or https)
  defaultSchema: "https"

  # -- Initial API key for bootstrapping
  # Leave empty to auto-generate on first startup
  # IMPORTANT: For production, create API keys through the CLI after deployment
  initialApiKey: ""

  # -- Name of an existing secret containing Shlink configuration
  # The secret can contain keys for initialApiKey, geoLiteLicenseKey
  existingSecret: ""

  # -- Key in existingSecret that contains the initial API key
  existingSecretApiKeyKey: "initial-api-key"

  # -- Key in existingSecret that contains the GeoLite license key
  existingSecretGeoLiteKey: "geolite-license-key"

  # -- GeoLite2 license key for geolocation features
  # Get your free key from https://www.maxmind.com/en/geolite2/signup
  geoLiteLicenseKey: ""

  # -- Enable anonymizing IP addresses when collecting visits
  anonymizeRemoteAddr: true

  # -- Enable redirects logging (keep visit history)
  redirectsLogging: true

  # -- Enable orphan visits logging (visits to non-existent short codes)
  orphanVisitsLogging: true

  # -- Configure redirect behavior
  redirect:
    # -- Status code for redirects (301 or 302)
    statusCode: 302
    # -- Enable caching redirects (not recommended for analytics)
    cacheLifetime: 30

  # -- Delete threshold for short URLs (number of visits)
  # Set to prevent deletion of short URLs with more than X visits
  deleteShortUrlThreshold: -1

  # -- Redis configuration for caching (optional but recommended for production)
  redis:
    # -- Enable Redis caching
    enabled: false
    # -- Redis server(s) - can be comma-separated for multiple servers
    # Format: host:port or redis://host:port or redis://password@host:port
    servers: ""

  # -- URL shortener configuration
  urlShortener:
    # -- Domain configuration for multiple domains
    domain:
      # -- Schema for domain resolution
      schema: "https"
      # -- Hostname for domain resolution
      hostname: ""

  # -- Task worker configuration
  worker:
    # -- Number of task workers
    count: 16

  # -- Additional environment variables for Shlink backend
  # See https://shlink.io/documentation/environment-variables/
  extraEnv: []
  # - name: TIMEZONE
  #   value: "America/New_York"
  # - name: DEFAULT_SHORT_CODES_LENGTH
  #   value: "5"

# =============================================================================
# Database Configuration
# @section -- Database Configuration
# =============================================================================

database:
  # -- Database type (postgres, mysql, maria, mssql)
  type: "postgres"

  # -- Database host (use subchart service name if postgresql.enabled=true)
  # @default -- "shlink-postgresql" when postgresql.enabled=true
  host: ""

  # -- Database port
  port: 5432

  # -- Database name
  name: "shlink"

  # -- Database username
  user: "shlink"

  # -- Database password (only used if existingSecret is not set)
  password: "changeme"

  # -- Name of existing secret containing database credentials
  # The secret must contain keys for username and password
  existingSecret: ""

  # -- Key in existingSecret for database username
  existingSecretUserKey: "username"

  # -- Key in existingSecret for database password
  existingSecretPasswordKey: "password"

  # -- Database connection options
  options: {}
  # charset: utf8mb4

# =============================================================================
# Shlink Web Client Configuration
# @section -- Shlink Web Client Configuration
# =============================================================================

webClient:
  # -- Enable Shlink Web Client deployment
  enabled: true

  # -- Web client image configuration
  image:
    # -- Shlink Web Client Docker image repository
    repository: shlinkio/shlink-web-client
    # -- Shlink Web Client Docker image tag
    tag: "4.2.1"
    # -- Image pull policy
    pullPolicy: IfNotPresent
    # -- Image digest (overrides tag if set)
    digest: ""

  # -- Number of web client replicas
  replicaCount: 2

  # -- Pre-configured server definitions for web client
  # These servers will be available in the web UI immediately
  servers: []
  # - name: "Production"
  #   url: "https://short.example.com"
  #   apiKey: "your-api-key-here"
  # - name: "Staging"
  #   url: "https://short-staging.example.com"
  #   apiKey: "your-api-key-here"

  # -- Additional environment variables for web client
  extraEnv: []

  # -- Resource limits and requests for web client
  resources: {}
  #   limits:
  #     cpu: 100m
  #     memory: 128Mi
  #   requests:
  #     cpu: 50m
  #     memory: 64Mi

  # -- Security context for web client container
  securityContext: {}

  # -- Pod security context for web client
  podSecurityContext:
    runAsUser: 101
    runAsGroup: 101
    fsGroup: 101
    runAsNonRoot: true

  # -- Autoscaling configuration for web client
  autoscaling:
    enabled: false
    minReplicas: 2
    maxReplicas: 10
    targetCPUUtilizationPercentage: 80
    targetMemoryUtilizationPercentage: 80

# =============================================================================
# Controller Configuration
# @section -- Controller Configuration
# =============================================================================

controller:
  # -- Controller type (deployment or statefulset)
  type: "deployment"

  # -- Number of replicas (ignored for statefulsets, use autoscaling or set directly)
  replicaCount: 1

  # -- Deployment strategy / StatefulSet update strategy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0

  # -- StatefulSet pod management policy
  podManagementPolicy: "OrderedReady"

# =============================================================================
# Service Configuration
# @section -- Service Configuration
# =============================================================================

service:
  # -- Backend API service configuration
  backend:
    # -- Service type for backend API
    type: ClusterIP
    # -- Service port for backend API
    port: 8080
    # -- Target port for backend API
    targetPort: 8080
    # -- Node port for backend API (only for NodePort/LoadBalancer)
    nodePort: ""
    # -- Annotations for backend service
    annotations: {}
    # -- Labels for backend service
    labels: {}

  # -- Web client service configuration
  webClient:
    # -- Service type for web client
    type: ClusterIP
    # -- Service port for web client
    port: 80
    # -- Target port for web client
    targetPort: 8080
    # -- Node port for web client (only for NodePort/LoadBalancer)
    nodePort: ""
    # -- Annotations for web client service
    annotations: {}
    # -- Labels for web client service
    labels: {}

# =============================================================================
# Ingress Configuration
# @section -- Ingress Configuration
# =============================================================================

ingress:
  # -- Backend API ingress configuration
  backend:
    # -- Enable ingress for backend API
    enabled: false
    # -- Ingress class name
    className: ""
    # -- Annotations for backend ingress
    annotations: {}
      # cert-manager.io/cluster-issuer: letsencrypt-prod
      # nginx.ingress.kubernetes.io/ssl-redirect: "true"
    # -- Ingress hosts configuration
    hosts:
      - host: short.example.com
        paths:
          - path: /
            pathType: Prefix
    # -- TLS configuration
    tls: []
    #  - secretName: shlink-api-tls
    #    hosts:
    #      - short.example.com

  # -- Web client ingress configuration
  webClient:
    # -- Enable ingress for web client
    enabled: false
    # -- Ingress class name
    className: ""
    # -- Annotations for web client ingress
    annotations: {}
      # cert-manager.io/cluster-issuer: letsencrypt-prod
      # nginx.ingress.kubernetes.io/ssl-redirect: "true"
    # -- Ingress hosts configuration
    hosts:
      - host: shlink-admin.example.com
        paths:
          - path: /
            pathType: Prefix
    # -- TLS configuration
    tls: []
    #  - secretName: shlink-webclient-tls
    #    hosts:
    #      - shlink-admin.example.com

# =============================================================================
# Persistence Configuration
# @section -- Persistence Configuration
# =============================================================================

persistence:
  # -- Enable persistence for Shlink data
  enabled: true

  # -- Storage class for PersistentVolumeClaim
  # @default -- default storage class
  storageClass: ""

  # -- Access modes for PersistentVolumeClaim
  accessModes:
    - ReadWriteOnce

  # -- Size of PersistentVolumeClaim
  size: 1Gi

  # -- Annotations for PersistentVolumeClaim
  annotations: {}

  # -- Selector for PersistentVolumeClaim
  selector: {}

  # -- Data source for PersistentVolumeClaim
  dataSource: {}

  # -- Existing PersistentVolumeClaim name (if set, no new PVC will be created)
  existingClaim: ""

# =============================================================================
# Security Context Configuration
# @section -- Security Context Configuration
# =============================================================================

# -- Security context for Shlink backend container
securityContext: {}
  # capabilities:
  #   drop:
  #   - ALL
  # readOnlyRootFilesystem: true
  # runAsNonRoot: true
  # runAsUser: 1001

# -- Pod security context for Shlink backend
podSecurityContext:
  runAsUser: 1001
  runAsGroup: 1001
  fsGroup: 1001
  runAsNonRoot: true

# =============================================================================
# Resource Configuration
# @section -- Resource Configuration
# =============================================================================

# -- Resource limits and requests for Shlink backend
resources: {}
  # limits:
  #   cpu: 500m
  #   memory: 512Mi
  # requests:
  #   cpu: 250m
  #   memory: 256Mi

# =============================================================================
# Health Checks Configuration
# @section -- Health Checks Configuration
# =============================================================================

# -- Liveness probe configuration for Shlink backend
livenessProbe:
  enabled: true
  httpGet:
    path: /rest/health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  successThreshold: 1
  failureThreshold: 3

# -- Readiness probe configuration for Shlink backend
readinessProbe:
  enabled: true
  httpGet:
    path: /rest/health
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
  timeoutSeconds: 3
  successThreshold: 1
  failureThreshold: 3

# -- Startup probe configuration for Shlink backend
startupProbe:
  enabled: true
  httpGet:
    path: /rest/health
    port: 8080
  initialDelaySeconds: 0
  periodSeconds: 5
  timeoutSeconds: 3
  successThreshold: 1
  failureThreshold: 30

# =============================================================================
# Pod Configuration
# @section -- Pod Configuration
# =============================================================================

# -- Additional labels for pods
podLabels: {}

# -- Additional annotations for pods
podAnnotations: {}

# -- Node selector for pod assignment
nodeSelector: {}

# -- Tolerations for pod assignment
tolerations: []

# -- Affinity and anti-affinity rules
affinity: {}

# -- Topology spread constraints
topologySpreadConstraints: []

# -- Priority class name for pods
priorityClassName: ""

# -- Node name for pod assignment
nodeName: ""

# -- Host aliases for pods
hostAliases: []

# -- DNS policy for pods
dnsPolicy: "ClusterFirst"

# -- DNS config for pods
dnsConfig: {}

# -- Share process namespace
shareProcessNamespace: false

# -- Termination grace period in seconds
terminationGracePeriodSeconds: 30

# -- Init containers to run before main containers
initContainers: []

# -- Additional containers to run alongside main container
extraContainers: []

# -- Additional volumes
extraVolumes: []

# -- Additional volume mounts for main container
extraVolumeMounts: []

# =============================================================================
# ServiceAccount Configuration
# @section -- ServiceAccount Configuration
# =============================================================================

serviceAccount:
  # -- Enable service account creation
  create: true

  # -- Annotations for service account
  annotations: {}

  # -- Name of service account to use (if not created by chart)
  name: ""

  # -- Automatically mount service account token
  automountServiceAccountToken: false

# =============================================================================
# RBAC Configuration
# @section -- RBAC Configuration
# =============================================================================

rbac:
  # -- Enable RBAC resources
  create: false

  # -- Rules for the Role/ClusterRole
  rules: []
  # - apiGroups: [""]
  #   resources: ["configmaps", "secrets"]
  #   verbs: ["get", "list"]

# =============================================================================
# Network Policy Configuration
# @section -- Network Policy Configuration
# =============================================================================

networkPolicy:
  # -- Enable network policy
  enabled: false

  # -- Policy types to enforce
  policyTypes:
    - Ingress
    - Egress

  # -- Ingress rules
  ingress: []
  # - from:
  #   - podSelector:
  #       matchLabels:
  #         app: nginx-ingress
  #   ports:
  #   - protocol: TCP
  #     port: 8080

  # -- Egress rules
  egress: []
  # - to:
  #   - podSelector:
  #       matchLabels:
  #         app: postgresql
  #   ports:
  #   - protocol: TCP
  #     port: 5432

# =============================================================================
# Monitoring Configuration
# @section -- Monitoring Configuration
# =============================================================================

monitoring:
  # -- ServiceMonitor configuration for Prometheus Operator
  serviceMonitor:
    # -- Enable ServiceMonitor
    enabled: false
    # -- Namespace for ServiceMonitor (defaults to release namespace)
    namespace: ""
    # -- Interval for scraping metrics
    interval: 30s
    # -- Timeout for scraping metrics
    scrapeTimeout: 10s
    # -- Additional labels for ServiceMonitor
    labels: {}
    # -- Metric relabeling configs
    metricRelabelings: []
    # -- Relabeling configs
    relabelings: []
    # -- HTTP path to scrape metrics from
    path: /rest/v3/metrics
    # -- Scheme for metrics endpoint (http or https)
    scheme: http
    # -- TLS config for metrics endpoint
    tlsConfig: {}

  # -- PrometheusRule configuration for alerting
  prometheusRule:
    # -- Enable PrometheusRule
    enabled: false
    # -- Namespace for PrometheusRule (defaults to release namespace)
    namespace: ""
    # -- Additional labels for PrometheusRule
    labels: {}
    # -- Alert rules
    rules: []
    # - alert: ShlinkHighErrorRate
    #   expr: rate(shlink_errors_total[5m]) > 0.1
    #   for: 5m
    #   labels:
    #     severity: warning
    #   annotations:
    #     summary: "High error rate in Shlink"
    #     description: "Shlink error rate is {{ $value }} errors/sec"

# =============================================================================
# Autoscaling Configuration
# @section -- Autoscaling Configuration
# =============================================================================

autoscaling:
  # -- Enable Horizontal Pod Autoscaler
  enabled: false

  # -- Minimum number of replicas
  minReplicas: 1

  # -- Maximum number of replicas
  maxReplicas: 10

  # -- Target CPU utilization percentage
  targetCPUUtilizationPercentage: 80

  # -- Target memory utilization percentage
  targetMemoryUtilizationPercentage: 80

  # -- Behavior configuration for scaling
  behavior: {}

# =============================================================================
# Pod Disruption Budget Configuration
# @section -- Pod Disruption Budget Configuration
# =============================================================================

podDisruptionBudget:
  # -- Enable Pod Disruption Budget
  enabled: false

  # -- Minimum available pods
  minAvailable: 1

  # -- Maximum unavailable pods (alternative to minAvailable)
  maxUnavailable: ""

# =============================================================================
# Diagnostic Mode Configuration
# @section -- Diagnostic Mode Configuration
# =============================================================================

diagnosticMode:
  # -- Enable diagnostic mode (sleep infinity instead of running application)
  enabled: false

  # -- Command to run in diagnostic mode
  command:
    - sleep

  # -- Arguments for diagnostic mode command
  args:
    - infinity

# =============================================================================
# PostgreSQL Subchart Configuration
# @section -- PostgreSQL Configuration
# =============================================================================

# -- PostgreSQL subchart configuration
# See https://github.com/bitnami/charts/tree/main/bitnami/postgresql for all options
postgresql:
  # -- Enable PostgreSQL subchart
  enabled: true

  # -- PostgreSQL authentication configuration
  auth:
    # -- PostgreSQL username
    username: shlink
    # -- PostgreSQL password
    password: changeme
    # -- PostgreSQL database name
    database: shlink
    # -- Existing secret with PostgreSQL credentials
    existingSecret: ""

  # -- PostgreSQL architecture (standalone or replication)
  architecture: standalone

  # -- PostgreSQL primary configuration
  primary:
    # -- Persistence configuration for primary
    persistence:
      enabled: true
      size: 8Gi

    # -- Resource limits for primary
    resources: {}
    #   limits:
    #     cpu: 500m
    #     memory: 512Mi
    #   requests:
    #     cpu: 250m
    #     memory: 256Mi
EOFVALUES

echo "✅ values.yaml replacement complete"
