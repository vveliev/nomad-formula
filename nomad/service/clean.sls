# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/libs/map.jinja" import mapdata as nomad with context %}

nomad-service-clean-service-dead:
  service.dead:
    - name: {{ nomad.service.name }}
    - enable: False