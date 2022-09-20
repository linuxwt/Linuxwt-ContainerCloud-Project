external_url 'https://gitlab.k8s:30013'

gitlab_rails['gitlab_shell_ssh_port'] = 30012

prometheus['enable'] = false
alertmanager['enable'] = false
grafana['enable'] = false
gitlab_exporter['enable'] = false
node_exporter['enable'] = false
postgres_exporter['enable'] = false
redis_exporter['enable'] = false
