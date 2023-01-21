# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}

include:
  - {{ sls_service_clean }}

nomad-config-clean-file-absent:
  file.absent:
    - name: {{ nomad.config }}
    - require:
      - sls: {{ sls_service_clean }}

nomad-remove-service:
  service.dead:
    - name: nomad
  file.absent:
    - name: /etc/systemd/system/nomad.service
    - require:
      - service: nomad-remove-service
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: nomad-remove-service


nomad-remove-config:
    file.absent:
      - name: {{ nomad.config_dir }}
      - require:
        - nomad-remove-binary

nomad-remove-datadir:
    file.absent:
      - name: {{ nomad.config.data_dir }}
      - require:
        - nomad-remove-config
      - onlyif: 
        - 'command -v {{ nomad.bin_dir }}/nomad'
