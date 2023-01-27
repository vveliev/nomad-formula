# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}
{%- from tplroot ~ "/libs/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

nomad-config-file-file-managed:
  file.managed:
    - name: {{ nomad.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='nomad-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ nomad.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        nomad: {{ nomad | json }}



{%- from "nomad/map.jinja" import nomad with context %}

nomad-config:
  file.serialize:
    - name: {{ nomad.config_dir }}/nomad.hcl
    - formatter: json
    - dataset_pillar: nomad:config
    - mode: 640
    - user: root
    - group: root
    {%- if nomad.service != False %}
    - watch_in:
       - service: nomad-service
    {%- endif %}

