# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}

include:
  - {{ sls_config_file }}

nomad-service-running-service-running:
  service.running:
    - name: {{ nomad.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}

# Enabling the service here to ensure each state is independent.
nomad-service:
  service.running:
    - name: nomad
    # Restart service if config changes
    - restart: True
    - enable: {{ nomad.service }}
