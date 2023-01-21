# -*- coding: utf-8 -*-
# vim: ft=yaml
---
portage:
  sync_wait_one_day: true
nomad:
  pkg:
    name: 'app-shells/bash'
  service:
    name: "{{ 'systemd-journald' if grains.init == 'systemd' else 'mtab' }}"
