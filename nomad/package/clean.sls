# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}

include:
  - {{ sls_config_clean }}

nomad-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ nomad.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}


nomad-remove-binary:
   file.absent:
    - name: {{ nomad.bin_dir }}/nomad
    - require:
      - nomad-remove-service
