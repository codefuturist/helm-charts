#!/usr/bin/env -S uv run --script
"""
Docker Compose to Helm Chart Converter

This tool converts Docker Compose files into Helm charts following best practices.
It generates a complete chart structure with templates, values.yaml, and documentation.

Usage:
    python compose2helm.py --compose docker-compose.yml --output my-chart --name myapp

Features:
    - Converts services to Deployments
    - Maps ports to Services
    - Converts volumes to PVCs
    - Maps environment variables
    - Handles networks
    - Generates ingress configurations
    - Creates ConfigMaps and Secrets
    - Supports health checks
    - Implements resource limits
"""

import argparse
import yaml
import os
import sys
from pathlib import Path
from typing import Dict, Any, List, Optional
import re
from datetime import datetime


class ComposeConverter:
    """Main converter class for Docker Compose to Helm Chart conversion."""

    def __init__(self, compose_file: str, output_dir: str, chart_name: str):
        self.compose_file = compose_file
        self.output_dir = output_dir
        self.chart_name = chart_name
        self.compose_data = {}
        self.services = {}
        self.volumes = {}
        self.networks = {}
        self.secrets = {}

    def load_compose(self) -> None:
        """Load and parse the Docker Compose file."""
        try:
            with open(self.compose_file, 'r') as f:
                self.compose_data = yaml.safe_load(f)

            self.services = self.compose_data.get('services', {})
            self.volumes = self.compose_data.get('volumes', {})
            self.networks = self.compose_data.get('networks', {})
            self.secrets = self.compose_data.get('secrets', {})

            print(f"✓ Loaded compose file with {len(self.services)} services")
        except Exception as e:
            print(f"✗ Error loading compose file: {e}")
            sys.exit(1)

    def create_chart_structure(self) -> None:
        """Create the Helm chart directory structure."""
        chart_path = Path(self.output_dir) / self.chart_name

        # Create directories
        dirs = [
            chart_path,
            chart_path / 'templates',
            chart_path / 'templates' / 'tests',
            chart_path / 'examples',
        ]

        for dir_path in dirs:
            dir_path.mkdir(parents=True, exist_ok=True)

        print(f"✓ Created chart structure at {chart_path}")

    def generate_chart_yaml(self) -> None:
        """Generate Chart.yaml file."""
        chart_yaml = {
            'apiVersion': 'v2',
            'name': self.chart_name,
            'description': f'A Helm chart for {self.chart_name}',
            'type': 'application',
            'version': '0.1.0',
            'appVersion': '1.0.0',
            'keywords': [self.chart_name, 'kubernetes'],
            'maintainers': [
                {
                    'name': 'Your Name',
                    'email': 'your.email@example.com'
                }
            ]
        }

        chart_path = Path(self.output_dir) / self.chart_name / 'Chart.yaml'
        with open(chart_path, 'w') as f:
            yaml.dump(chart_yaml, f, default_flow_style=False, sort_keys=False)

        print(f"✓ Generated Chart.yaml")

    def generate_values_yaml(self) -> None:
        """Generate values.yaml from compose services."""
        values = {
            'namespaceOverride': '',
            'componentOverride': '',
            'partOfOverride': '',
            'applicationName': '',
            'additionalLabels': {},
        }

        # Process each service
        for service_name, service_config in self.services.items():
            service_values = self._convert_service_to_values(service_name, service_config)
            values.update(service_values)

        # Add global configurations
        if self.volumes:
            values['persistence'] = self._convert_volumes_to_values()

        # Add service configuration
        values['service'] = {
            'type': 'ClusterIP',
            'port': 80,
            'annotations': {}
        }

        # Add ingress configuration
        values['ingress'] = {
            'enabled': False,
            'className': '',
            'annotations': {},
            'hosts': [],
            'tls': []
        }

        # Add configMap and secret stubs
        values['configMap'] = {
            'enabled': False,
            'data': {}
        }

        values['secret'] = {
            'enabled': False,
            'data': {}
        }

        chart_path = Path(self.output_dir) / self.chart_name / 'values.yaml'
        with open(chart_path, 'w') as f:
            # Add header comments
            f.write("# Helm chart values generated from Docker Compose\n")
            f.write(f"# Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            yaml.dump(values, f, default_flow_style=False, sort_keys=False, width=120)

        print(f"✓ Generated values.yaml")

    def _convert_service_to_values(self, service_name: str, service_config: Dict) -> Dict:
        """Convert a compose service to Helm values."""
        # Determine if this is the main service or a dependency
        prefix = 'deployment' if len(self.services) == 1 else service_name

        values = {
            prefix: {
                'enabled': True,
                'additionalLabels': {},
                'podLabels': {},
                'annotations': {},
                'additionalPodAnnotations': {},
                'reloadOnChange': True,
                'replicas': 1,
                'strategy': {
                    'type': 'RollingUpdate'
                },
                'autoscaling': {
                    'enabled': False,
                    'minReplicas': 1,
                    'maxReplicas': 10,
                    'targetCPUUtilizationPercentage': 80
                },
                'imagePullSecrets': [],
                'nodeSelector': {},
                'tolerations': [],
                'affinity': {},
                'topologySpreadConstraints': [],
            }
        }

        # Image configuration
        image_str = service_config.get('image', '')
        image_parts = self._parse_image(image_str)
        values[prefix]['image'] = {
            'repository': image_parts['repository'],
            'tag': image_parts['tag'],
            'digest': '',
            'imagePullPolicy': 'IfNotPresent'
        }

        # Command and args
        if 'command' in service_config:
            command = service_config['command']
            if isinstance(command, str):
                values[prefix]['command'] = ['/bin/sh', '-c', command]
            else:
                values[prefix]['command'] = command

        if 'entrypoint' in service_config:
            entrypoint = service_config['entrypoint']
            if isinstance(entrypoint, str):
                values[prefix]['entrypoint'] = [entrypoint]
            else:
                values[prefix]['entrypoint'] = entrypoint

        if 'args' in service_config:
            args = service_config['args']
            values[prefix]['args'] = args if isinstance(args, list) else [args]

        # Environment variables
        env_vars = self._convert_environment(service_config.get('environment', {}))
        if env_vars:
            values[prefix]['env'] = env_vars

        # Ports configuration
        if 'ports' in service_config:
            ports = self._convert_ports(service_config['ports'])
            values[prefix]['ports'] = ports

        # Resources
        resources = self._convert_resources(service_config)
        if resources:
            values[prefix]['resources'] = resources

        # Health checks
        healthchecks = self._convert_healthcheck(service_config.get('healthcheck', {}))
        if healthchecks:
            values[prefix].update(healthchecks)

        # Volumes
        if 'volumes' in service_config:
            volumes = self._convert_service_volumes(service_config['volumes'])
            if volumes:
                values[prefix]['volumes'] = volumes

        # Security context
        if 'user' in service_config:
            user_id = service_config['user'].split(':')[0]
            values[prefix]['securityContext'] = {
                'runAsUser': int(user_id) if user_id.isdigit() else 1000,
                'runAsNonRoot': True,
                'readOnlyRootFilesystem': False
            }

        return values

    def _parse_image(self, image_str: str) -> Dict[str, str]:
        """Parse Docker image string into repository and tag."""
        if ':' in image_str:
            repository, tag = image_str.rsplit(':', 1)
        else:
            repository = image_str
            tag = 'latest'

        return {
            'repository': repository,
            'tag': tag
        }

    def _convert_environment(self, env_config: Any) -> Dict:
        """Convert environment variables to Helm format."""
        env_vars = {}

        if isinstance(env_config, dict):
            for key, value in env_config.items():
                if value is None:
                    # Environment variable without value (references host env)
                    env_vars[key] = {
                        'value': ''
                    }
                else:
                    env_vars[key] = {
                        'value': str(value)
                    }
        elif isinstance(env_config, list):
            for item in env_config:
                if '=' in item:
                    key, value = item.split('=', 1)
                    env_vars[key] = {
                        'value': value
                    }
                else:
                    env_vars[item] = {
                        'value': ''
                    }

        return env_vars

    def _convert_ports(self, ports_config: List) -> List[Dict]:
        """Convert ports configuration to Helm format."""
        result = []

        for port in ports_config:
            port_mapping = {}

            if isinstance(port, str):
                # Parse "8080:80/tcp" or "8080:80" or "80/udp" or "80"
                protocol = 'TCP'

                # Check for protocol suffix (e.g., /tcp, /udp)
                if '/' in port:
                    port, protocol = port.rsplit('/', 1)
                    protocol = protocol.upper()

                parts = port.split(':')
                if len(parts) == 2:
                    container_port = parts[1]
                    port_mapping = {
                        'name': f'port-{container_port}-{protocol.lower()}',
                        'containerPort': int(container_port),
                        'protocol': protocol
                    }
                else:
                    container_port = parts[0]
                    port_mapping = {
                        'name': f'port-{container_port}-{protocol.lower()}',
                        'containerPort': int(container_port),
                        'protocol': protocol
                    }
            elif isinstance(port, dict):
                container_port = port.get('target', port.get('published'))
                protocol = port.get('protocol', 'TCP').upper()
                port_mapping = {
                    'name': f"port-{container_port}-{protocol.lower()}",
                    'containerPort': int(container_port),
                    'protocol': protocol
                }

            if port_mapping:
                result.append(port_mapping)

        return result

    def _convert_resources(self, service_config: Dict) -> Optional[Dict]:
        """Convert resource limits and reservations."""
        deploy = service_config.get('deploy', {})
        resources_config = deploy.get('resources', {})

        if not resources_config:
            return None

        result = {}

        # Limits
        limits = resources_config.get('limits', {})
        if limits:
            result['limits'] = {}
            if 'cpus' in limits:
                result['limits']['cpu'] = str(limits['cpus'])
            if 'memory' in limits:
                result['limits']['memory'] = limits['memory']

        # Reservations
        reservations = resources_config.get('reservations', {})
        if reservations:
            result['requests'] = {}
            if 'cpus' in reservations:
                result['requests']['cpu'] = str(reservations['cpus'])
            if 'memory' in reservations:
                result['requests']['memory'] = reservations['memory']

        return result if result else None

    def _convert_healthcheck(self, healthcheck: Dict) -> Dict:
        """Convert healthcheck to Kubernetes probes."""
        if not healthcheck:
            return {}

        result = {}

        # Parse the test command
        test = healthcheck.get('test', [])
        if test and len(test) > 1:
            command = test[1:] if test[0] in ['CMD', 'CMD-SHELL'] else test

            # Try to determine if it's an HTTP check
            cmd_str = ' '.join(command)
            if 'curl' in cmd_str or 'wget' in cmd_str:
                # Extract URL/path
                match = re.search(r'https?://[^\s]+|(?:localhost|127\.0\.0\.1):\d+(/[^\s]*)?', cmd_str)
                if match:
                    url = match.group(0)
                    # Parse port and path
                    port_match = re.search(r':(\d+)', url)
                    path_match = re.search(r'(/[^\s]*)', url)

                    result['livenessProbe'] = {
                        'httpGet': {
                            'path': path_match.group(1) if path_match else '/',
                            'port': int(port_match.group(1)) if port_match else 80
                        },
                        'initialDelaySeconds': int(healthcheck.get('start_period', '30s').rstrip('s')),
                        'periodSeconds': int(healthcheck.get('interval', '30s').rstrip('s')),
                        'timeoutSeconds': int(healthcheck.get('timeout', '5s').rstrip('s')),
                        'failureThreshold': int(healthcheck.get('retries', 3))
                    }
                    result['readinessProbe'] = result['livenessProbe'].copy()
            else:
                # Exec probe
                result['livenessProbe'] = {
                    'exec': {
                        'command': command
                    },
                    'initialDelaySeconds': int(healthcheck.get('start_period', '30s').rstrip('s')),
                    'periodSeconds': int(healthcheck.get('interval', '30s').rstrip('s')),
                    'timeoutSeconds': int(healthcheck.get('timeout', '5s').rstrip('s')),
                    'failureThreshold': int(healthcheck.get('retries', 3))
                }

        return result

    def _convert_service_volumes(self, volumes: List) -> List[Dict]:
        """Convert service volumes to Helm format."""
        result = []

        for volume in volumes:
            if isinstance(volume, str):
                parts = volume.split(':')
                if len(parts) >= 2:
                    source = parts[0]
                    target = parts[1]
                    read_only = len(parts) > 2 and 'ro' in parts[2]

                    # Determine if it's a named volume or bind mount
                    if source.startswith('/') or source.startswith('.'):
                        # Bind mount
                        result.append({
                            'name': self._sanitize_name(source.split('/')[-1]),
                            'type': 'hostPath',
                            'mountPath': target,
                            'hostPath': source,
                            'readOnly': read_only
                        })
                    else:
                        # Named volume
                        result.append({
                            'name': self._sanitize_name(source),
                            'type': 'persistentVolumeClaim',
                            'mountPath': target,
                            'readOnly': read_only
                        })
            elif isinstance(volume, dict):
                vol_type = volume.get('type', 'volume')
                result.append({
                    'name': self._sanitize_name(volume.get('source', 'data')),
                    'type': 'persistentVolumeClaim' if vol_type == 'volume' else 'hostPath',
                    'mountPath': volume.get('target', '/data'),
                    'readOnly': volume.get('read_only', False)
                })

        return result

    def _convert_volumes_to_values(self) -> Dict:
        """Convert top-level volumes to persistence configuration."""
        result = {}

        for vol_name, vol_config in self.volumes.items():
            result[vol_name] = {
                'enabled': True,
                'storageClass': '',
                'accessModes': ['ReadWriteOnce'],
                'size': '10Gi',
                'annotations': {}
            }

            if isinstance(vol_config, dict):
                if 'driver_opts' in vol_config:
                    opts = vol_config['driver_opts']
                    if 'size' in opts:
                        result[vol_name]['size'] = opts['size']

        return result

    def _sanitize_name(self, name: str) -> str:
        """Sanitize names for Kubernetes."""
        # Replace invalid characters with hyphens
        sanitized = re.sub(r'[^a-z0-9-]', '-', name.lower())
        # Remove leading/trailing hyphens
        sanitized = sanitized.strip('-')
        # Ensure it starts with alphanumeric
        if sanitized and not sanitized[0].isalnum():
            sanitized = 'v-' + sanitized
        return sanitized or 'data'

    def generate_templates(self) -> None:
        """Generate Kubernetes template files."""
        chart_path = Path(self.output_dir) / self.chart_name / 'templates'

        # Generate _helpers.tpl
        self._generate_helpers(chart_path)

        # Generate deployment templates
        for service_name in self.services:
            self._generate_deployment(chart_path, service_name)
            self._generate_service(chart_path, service_name)

        # Generate other templates
        self._generate_configmap(chart_path)
        self._generate_secret(chart_path)
        self._generate_ingress(chart_path)
        self._generate_pvc(chart_path)
        self._generate_notes(chart_path)

        print(f"✓ Generated template files")

    def _generate_helpers(self, chart_path: Path) -> None:
        """Generate _helpers.tpl file."""
        helpers_content = '''{{/*
Expand the name of the chart.
*/}}
{{- define "''' + self.chart_name + '''.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "''' + self.chart_name + '''.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.applicationName }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "''' + self.chart_name + '''.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "''' + self.chart_name + '''.labels" -}}
helm.sh/chart: {{ include "''' + self.chart_name + '''.chart" . }}
{{ include "''' + self.chart_name + '''.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "''' + self.chart_name + '''.selectorLabels" -}}
app.kubernetes.io/name: {{ include "''' + self.chart_name + '''.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "''' + self.chart_name + '''.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "''' + self.chart_name + '''.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for networking.
*/}}
{{- define "''' + self.chart_name + '''.ingress.apiVersion" -}}
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1beta1
{{- else -}}
extensions/v1beta1
{{- end }}
{{- end }}

{{/*
Return namespace
*/}}
{{- define "''' + self.chart_name + '''.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
'''

        with open(chart_path / '_helpers.tpl', 'w') as f:
            f.write(helpers_content)

    def _generate_deployment(self, chart_path: Path, service_name: str) -> None:
        """Generate deployment.yaml template."""
        prefix = 'deployment' if len(self.services) == 1 else service_name

        template = f'''{{{{- if .Values.{prefix}.enabled }}}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{{{ include "{self.chart_name}.fullname" . }}}}{"-" + service_name if len(self.services) > 1 else ""}
  namespace: {{{{ include "{self.chart_name}.namespace" . }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" . | nindent 4 }}}}
    {{{{- with .Values.{prefix}.additionalLabels }}}}
    {{{{- toYaml . | nindent 4 }}}}
    {{{{- end }}}}
  {{{{- with .Values.{prefix}.annotations }}}}
  annotations:
    {{{{- toYaml . | nindent 4 }}}}
  {{{{- end }}}}
spec:
  {{{{- if not .Values.{prefix}.autoscaling.enabled }}}}
  replicas: {{{{ .Values.{prefix}.replicas }}}}
  {{{{- end }}}}
  selector:
    matchLabels:
      {{{{- include "{self.chart_name}.selectorLabels" . | nindent 6 }}}}
      {{{{- with .Values.{prefix}.podLabels }}}}
      {{{{- toYaml . | nindent 6 }}}}
      {{{{- end }}}}
  {{{{- with .Values.{prefix}.strategy }}}}
  strategy:
    {{{{- toYaml . | nindent 4 }}}}
  {{{{- end }}}}
  template:
    metadata:
      annotations:
        checksum/config: {{{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}}}
        {{{{- if .Values.{prefix}.reloadOnChange }}}}
        checksum/secret: {{{{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}}}
        {{{{- end }}}}
        {{{{- with .Values.{prefix}.additionalPodAnnotations }}}}
        {{{{- toYaml . | nindent 8 }}}}
        {{{{- end }}}}
      labels:
        {{{{- include "{self.chart_name}.selectorLabels" . | nindent 8 }}}}
        {{{{- with .Values.{prefix}.podLabels }}}}
        {{{{- toYaml . | nindent 8 }}}}
        {{{{- end }}}}
    spec:
      {{{{- with .Values.{prefix}.imagePullSecrets }}}}
      imagePullSecrets:
        {{{{- toYaml . | nindent 8 }}}}
      {{{{- end }}}}
      {{{{- with .Values.{prefix}.securityContext }}}}
      securityContext:
        {{{{- toYaml . | nindent 8 }}}}
      {{{{- end }}}}
      containers:
      - name: {service_name}
        image: "{{{{ .Values.{prefix}.image.repository }}}}:{{{{ .Values.{prefix}.image.tag | default .Chart.AppVersion }}}}"
        imagePullPolicy: {{{{ .Values.{prefix}.image.imagePullPolicy }}}}
        {{{{- with .Values.{prefix}.command }}}}
        command:
          {{{{- toYaml . | nindent 10 }}}}
        {{{{- end }}}}
        {{{{- with .Values.{prefix}.args }}}}
        args:
          {{{{- toYaml . | nindent 10 }}}}
        {{{{- end }}}}
        {{{{- if .Values.{prefix}.ports }}}}
        ports:
        {{{{- range .Values.{prefix}.ports }}}}
        - name: {{{{ .name }}}}
          containerPort: {{{{ .containerPort }}}}
          protocol: {{{{ .protocol | default "TCP" }}}}
        {{{{- end }}}}
        {{{{- end }}}}
        {{{{- if .Values.{prefix}.env }}}}
        env:
        {{{{- range $key, $value := .Values.{prefix}.env }}}}
        - name: {{{{ $key }}}}
          {{{{- if $value.valueFrom }}}}
          valueFrom:
            {{{{- toYaml $value.valueFrom | nindent 12 }}}}
          {{{{- else }}}}
          value: {{{{ tpl (toString $value.value) $ | quote }}}}
          {{{{- end }}}}
        {{{{- end }}}}
        {{{{- end }}}}
        {{{{- with .Values.{prefix}.livenessProbe }}}}
        livenessProbe:
          {{{{- toYaml . | nindent 10 }}}}
        {{{{- end }}}}
        {{{{- with .Values.{prefix}.readinessProbe }}}}
        readinessProbe:
          {{{{- toYaml . | nindent 10 }}}}
        {{{{- end }}}}
        {{{{- with .Values.{prefix}.resources }}}}
        resources:
          {{{{- toYaml . | nindent 10 }}}}
        {{{{- end }}}}
        {{{{- if .Values.{prefix}.volumes }}}}
        volumeMounts:
        {{{{- range .Values.{prefix}.volumes }}}}
        - name: {{{{ .name }}}}
          mountPath: {{{{ .mountPath }}}}
          {{{{- if .subPath }}}}
          subPath: {{{{ .subPath }}}}
          {{{{- end }}}}
          {{{{- if .readOnly }}}}
          readOnly: {{{{ .readOnly }}}}
          {{{{- end }}}}
        {{{{- end }}}}
        {{{{- end }}}}
      {{{{- if .Values.{prefix}.volumes }}}}
      volumes:
      {{{{- range .Values.{prefix}.volumes }}}}
      - name: {{{{ .name }}}}
        {{{{- if eq .type "persistentVolumeClaim" }}}}
        persistentVolumeClaim:
          claimName: {{{{ include "{self.chart_name}.fullname" $ }}}}-{{{{ .name }}}}
        {{{{- else if eq .type "configMap" }}}}
        configMap:
          name: {{{{ .configMapName | default (include "{self.chart_name}.fullname" $) }}}}
        {{{{- else if eq .type "secret" }}}}
        secret:
          secretName: {{{{ .secretName | default (include "{self.chart_name}.fullname" $) }}}}
        {{{{- else if eq .type "emptyDir" }}}}
        emptyDir: {{}}
        {{{{- else if eq .type "hostPath" }}}}
        hostPath:
          path: {{{{ .hostPath }}}}
        {{{{- end }}}}
      {{{{- end }}}}
      {{{{- end }}}}
      {{{{- with .Values.{prefix}.nodeSelector }}}}
      nodeSelector:
        {{{{- toYaml . | nindent 8 }}}}
      {{{{- end }}}}
      {{{{- with .Values.{prefix}.affinity }}}}
      affinity:
        {{{{- toYaml . | nindent 8 }}}}
      {{{{- end }}}}
      {{{{- with .Values.{prefix}.tolerations }}}}
      tolerations:
        {{{{- toYaml . | nindent 8 }}}}
      {{{{- end }}}}
{{{{- end }}}}
'''

        filename = 'deployment.yaml' if len(self.services) == 1 else f'deployment-{service_name}.yaml'
        with open(chart_path / filename, 'w') as f:
            f.write(template)

    def _generate_service(self, chart_path: Path, service_name: str) -> None:
        """Generate service.yaml template."""
        prefix = 'deployment' if len(self.services) == 1 else service_name

        template = f'''{{{{- if and .Values.{prefix}.enabled .Values.{prefix}.ports }}}}
apiVersion: v1
kind: Service
metadata:
  name: {{{{ include "{self.chart_name}.fullname" . }}}}{"-" + service_name if len(self.services) > 1 else ""}
  namespace: {{{{ include "{self.chart_name}.namespace" . }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" . | nindent 4 }}}}
  {{{{- with .Values.service.annotations }}}}
  annotations:
    {{{{- toYaml . | nindent 4 }}}}
  {{{{- end }}}}
spec:
  type: {{{{ .Values.service.type | default "ClusterIP" }}}}
  {{{{- if .Values.service.clusterIP }}}}
  clusterIP: {{{{ .Values.service.clusterIP }}}}
  {{{{- end }}}}
  ports:
  {{{{- range .Values.{prefix}.ports }}}}
  - port: {{{{ .containerPort }}}}
    targetPort: {{{{ .name }}}}
    protocol: {{{{ .protocol | default "TCP" }}}}
    name: {{{{ .name }}}}
  {{{{- end }}}}
  selector:
    {{{{- include "{self.chart_name}.selectorLabels" . | nindent 4 }}}}
    {{{{- with .Values.{prefix}.podLabels }}}}
    {{{{- toYaml . | nindent 4 }}}}
    {{{{- end }}}}
{{{{- end }}}}
'''

        filename = 'service.yaml' if len(self.services) == 1 else f'service-{service_name}.yaml'
        with open(chart_path / filename, 'w') as f:
            f.write(template)

    def _generate_configmap(self, chart_path: Path) -> None:
        """Generate configmap.yaml template."""
        template = f'''{{{{- if .Values.configMap.enabled }}}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{{{ include "{self.chart_name}.fullname" . }}}}
  namespace: {{{{ include "{self.chart_name}.namespace" . }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" . | nindent 4 }}}}
data:
  {{{{- range $key, $value := .Values.configMap.data }}}}
  {{{{ $key }}}}: {{{{ $value | quote }}}}
  {{{{- end }}}}
{{{{- end }}}}
'''

        with open(chart_path / 'configmap.yaml', 'w') as f:
            f.write(template)

    def _generate_secret(self, chart_path: Path) -> None:
        """Generate secret.yaml template."""
        template = f'''{{{{- if .Values.secret.enabled }}}}
apiVersion: v1
kind: Secret
metadata:
  name: {{{{ include "{self.chart_name}.fullname" . }}}}
  namespace: {{{{ include "{self.chart_name}.namespace" . }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" . | nindent 4 }}}}
type: Opaque
stringData:
  {{{{- range $key, $value := .Values.secret.data }}}}
  {{{{ $key }}}}: {{{{ $value | quote }}}}
  {{{{- end }}}}
{{{{- end }}}}
'''

        with open(chart_path / 'secret.yaml', 'w') as f:
            f.write(template)

    def _generate_ingress(self, chart_path: Path) -> None:
        """Generate ingress.yaml template."""
        template = f'''{{{{- if .Values.ingress.enabled }}}}
apiVersion: {{{{ include "{self.chart_name}.ingress.apiVersion" . }}}}
kind: Ingress
metadata:
  name: {{{{ include "{self.chart_name}.fullname" . }}}}
  namespace: {{{{ include "{self.chart_name}.namespace" . }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" . | nindent 4 }}}}
  {{{{- with .Values.ingress.annotations }}}}
  annotations:
    {{{{- toYaml . | nindent 4 }}}}
  {{{{- end }}}}
spec:
  {{{{- if .Values.ingress.ingressClassName }}}}
  ingressClassName: {{{{ .Values.ingress.ingressClassName }}}}
  {{{{- end }}}}
  {{{{- if .Values.ingress.tls }}}}
  tls:
    {{{{- range .Values.ingress.tls }}}}
    - hosts:
        {{{{- range .hosts }}}}
        - {{{{ . | quote }}}}
        {{{{- end }}}}
      secretName: {{{{ .secretName }}}}
    {{{{- end }}}}
  {{{{- end }}}}
  rules:
    {{{{- range .Values.ingress.hosts }}}}
    - host: {{{{ .host | quote }}}}
      http:
        paths:
          {{{{- range .paths }}}}
          - path: {{{{ .path }}}}
            pathType: {{{{ .pathType | default "Prefix" }}}}
            backend:
              service:
                name: {{{{ include "{self.chart_name}.fullname" $ }}}}
                port:
                  number: {{{{ .port | default 80 }}}}
          {{{{- end }}}}
    {{{{- end }}}}
{{{{- end }}}}
'''

        with open(chart_path / 'ingress.yaml', 'w') as f:
            f.write(template)

    def _generate_pvc(self, chart_path: Path) -> None:
        """Generate pvc.yaml template."""
        template = f'''{{{{- range $name, $config := .Values.persistence }}}}
{{{{- if $config.enabled }}}}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{{{ include "{self.chart_name}.fullname" $ }}}}-{{{{ $name }}}}
  namespace: {{{{ include "{self.chart_name}.namespace" $ }}}}
  labels:
    {{{{- include "{self.chart_name}.labels" $ | nindent 4 }}}}
  {{{{- with $config.annotations }}}}
  annotations:
    {{{{- toYaml . | nindent 4 }}}}
  {{{{- end }}}}
spec:
  accessModes:
    {{{{- range $config.accessModes }}}}
    - {{{{ . }}}}
    {{{{- end }}}}
  {{{{- if $config.storageClass }}}}
  storageClassName: {{{{ $config.storageClass }}}}
  {{{{- end }}}}
  resources:
    requests:
      storage: {{{{ $config.size }}}}
{{{{- end }}}}
{{{{- end }}}}
'''

        with open(chart_path / 'pvc.yaml', 'w') as f:
            f.write(template)

    def _generate_notes(self, chart_path: Path) -> None:
        """Generate NOTES.txt template."""
        # Use triple quotes without f-string to avoid escaping issues
        notes = '''Thank you for installing {{ .Chart.Name }}.

Your release is named {{ .Release.Name }}.

To learn more about the release, try:

  $ helm status {{ .Release.Name }}
  $ helm get all {{ .Release.Name }}

{{- if .Values.ingress.enabled }}

Application URL:
{{- range .Values.ingress.hosts }}
  http{{- if $.Values.ingress.tls }}s{{- end }}://{{ .host }}
{{- end }}
{{- else if contains "NodePort" .Values.service.type }}

Get the application URL by running:
  export NODE_PORT=$(kubectl get --namespace {{ .Release.Namespace }} -o jsonpath="{.spec.ports[0].nodePort}" services {{ include "''' + self.chart_name + '''.fullname" . }})
  export NODE_IP=$(kubectl get nodes --namespace {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
{{- else if contains "LoadBalancer" .Values.service.type }}

Get the application URL by running:
  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
  export SERVICE_IP=$(kubectl get svc --namespace {{ .Release.Namespace }} {{ include "''' + self.chart_name + '''.fullname" . }} --template "{{"{{range(index .status.loadBalancer.ingress 0) }}{{.}}{{end}}"}}")
  echo http://$SERVICE_IP:{{ .Values.service.port }}
{{- else if contains "ClusterIP" .Values.service.type }}

Get the application URL by running:
  export POD_NAME=$(kubectl get pods --namespace {{ .Release.Namespace }} -l "app.kubernetes.io/name={{ include "''' + self.chart_name + '''.name" . }},app.kubernetes.io/instance={{ .Release.Name }}" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace {{ .Release.Namespace }} $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace {{ .Release.Namespace }} port-forward $POD_NAME 8080:$CONTAINER_PORT
{{- end }}
'''

        with open(chart_path / 'NOTES.txt', 'w') as f:
            f.write(notes)

    def generate_readme(self) -> None:
        """Generate README.md file."""
        readme_content = f'''# {self.chart_name}

A Helm chart for {self.chart_name}

## Description

This chart was generated from a Docker Compose file and follows Kubernetes best practices.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+

## Installation

```bash
helm install my-release ./{self.chart_name}
```

## Configuration

The following table lists the configurable parameters and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespaceOverride` | Override namespace | `""` |
| `deployment.enabled` | Enable deployment | `true` |
| `deployment.replicas` | Number of replicas | `1` |
| `service.type` | Service type | `ClusterIP` |
| `ingress.enabled` | Enable ingress | `false` |

## Examples

### Minimal Configuration

```yaml
deployment:
  enabled: true
  replicas: 1
```

### Production Configuration

```yaml
deployment:
  enabled: true
  replicas: 3
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "500m"

ingress:
  enabled: true
  hosts:
    - host: example.com
      paths:
        - path: /
          pathType: Prefix
```

## Upgrading

```bash
helm upgrade my-release ./{self.chart_name}
```

## Uninstalling

```bash
helm uninstall my-release
```

## Support

For issues and questions, please open an issue in the repository.
'''

        chart_path = Path(self.output_dir) / self.chart_name / 'README.md'
        with open(chart_path, 'w') as f:
            f.write(readme_content)

        print(f"✓ Generated README.md")

    def generate_examples(self) -> None:
        """Generate example values files."""
        examples_path = Path(self.output_dir) / self.chart_name / 'examples'

        # Minimal example
        minimal = {
            'deployment': {
                'enabled': True,
                'replicas': 1
            }
        }

        with open(examples_path / 'values-minimal.yaml', 'w') as f:
            f.write("# Minimal configuration example\n")
            yaml.dump(minimal, f, default_flow_style=False, sort_keys=False)

        # Production example
        production = {
            'deployment': {
                'enabled': True,
                'replicas': 3,
                'resources': {
                    'requests': {
                        'memory': '256Mi',
                        'cpu': '100m'
                    },
                    'limits': {
                        'memory': '512Mi',
                        'cpu': '500m'
                    }
                },
                'affinity': {
                    'podAntiAffinity': {
                        'preferredDuringSchedulingIgnoredDuringExecution': [
                            {
                                'weight': 100,
                                'podAffinityTerm': {
                                    'labelSelector': {
                                        'matchExpressions': [
                                            {
                                                'key': 'app.kubernetes.io/name',
                                                'operator': 'In',
                                                'values': [self.chart_name]
                                            }
                                        ]
                                    },
                                    'topologyKey': 'kubernetes.io/hostname'
                                }
                            }
                        ]
                    }
                }
            },
            'ingress': {
                'enabled': True,
                'ingressClassName': 'nginx',
                'annotations': {
                    'cert-manager.io/cluster-issuer': 'letsencrypt-prod'
                },
                'hosts': [
                    {
                        'host': 'example.com',
                        'paths': [
                            {
                                'path': '/',
                                'pathType': 'Prefix',
                                'port': 80
                            }
                        ]
                    }
                ],
                'tls': [
                    {
                        'secretName': f'{self.chart_name}-tls',
                        'hosts': ['example.com']
                    }
                ]
            }
        }

        with open(examples_path / 'values-production.yaml', 'w') as f:
            f.write("# Production configuration example\n")
            yaml.dump(production, f, default_flow_style=False, sort_keys=False)

        print(f"✓ Generated example values files")

    def convert(self) -> None:
        """Main conversion method."""
        print(f"\n🚀 Converting Docker Compose to Helm Chart: {self.chart_name}\n")

        self.load_compose()
        self.create_chart_structure()
        self.generate_chart_yaml()
        self.generate_values_yaml()
        self.generate_templates()
        self.generate_readme()
        self.generate_examples()

        print(f"\n✅ Conversion complete! Chart created at: {Path(self.output_dir) / self.chart_name}")
        print(f"\nNext steps:")
        print(f"  1. Review and customize the generated values.yaml")
        print(f"  2. Test the chart: helm install test-release ./{self.chart_name}")
        print(f"  3. Check the deployment: kubectl get all")


def main():
    parser = argparse.ArgumentParser(
        description='Convert Docker Compose files to Helm charts',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  # Basic conversion
  python compose2helm.py --compose docker-compose.yml --output charts --name myapp

  # Specify custom output directory
  python compose2helm.py -c docker-compose.yml -o ./my-charts -n myapp
        '''
    )

    parser.add_argument(
        '-c', '--compose',
        required=True,
        help='Path to Docker Compose file'
    )

    parser.add_argument(
        '-o', '--output',
        default='./charts',
        help='Output directory for the Helm chart (default: ./charts)'
    )

    parser.add_argument(
        '-n', '--name',
        required=True,
        help='Name of the Helm chart'
    )

    parser.add_argument(
        '--version',
        action='version',
        version='compose2helm 1.0.0'
    )

    args = parser.parse_args()

    # Validate compose file exists
    if not os.path.exists(args.compose):
        print(f"✗ Error: Compose file not found: {args.compose}")
        sys.exit(1)

    # Create converter and run
    converter = ComposeConverter(args.compose, args.output, args.name)
    converter.convert()


if __name__ == '__main__':
    main()
