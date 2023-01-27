# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}


# Create nomad user
nomad-package-group-present:
  group.present:
    - name: {{ nomad.group }}
    {% if nomad.get('group_gid', None) != None -%}
    - gid: {{ nomad.group_gid }}
    {%- endif %}

nomad-package-user-present:
  user.present:
    - name: {{ nomad.user }}
    {% if nomad.get('user_uid', None) != None -%}
    - uid: {{ nomad.user_uid }}
    {% endif -%}
    - groups:
      - {{ nomad.group }}
    - home: {{ salt['user.info'](nomad.user)['home']|default(nomad.config.data_dir) }}
    - createhome: False
    - system: True
    - require:
      - group: nomad-group
