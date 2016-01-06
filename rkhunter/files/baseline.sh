{% from "rkhunter/map.jinja" import rkhunter with context -%}

#!/bin/bash

LOCK_FILE='/var/run/rkhunter_baseline'

if [ ! -f $LOCK_FILE ]; then
  {%-  if salt['pillar.get']('rkhunter:http_proxy') is defined %}
  export http_proxy={{ salt['pillar.get']('rkhunter:http_proxy') }}
  {{ salt['pillar.get']('rkhunter:rkhunter_config:INSTALLDIR')|first }}/bin/rkhunter --versioncheck --update --propupd --nocolors > /tmp/rkhunter.tmp
  mail -s "[rkhunter] First rootkit hunter run on {{ salt['grains.get']('fqdn') }}" {{ salt['pillar.get']('rkhunter:rkhunter_config:MAIL-ON-WARNING')|first }} < /tmp/rkhunter.tmp
  touch $LOCK_FILE  
  unset http_proxy
  {% else %}
  {{ salt['pillar.get']('rkhunter:rkhunter_config:INSTALLDIR')|first }}/bin/rkhunter --versioncheck --update --propupd --nocolors > /tmp/rkhunter.tmp
  mail -s "[rkhunter] First rootkit hunter run on {{ salt['grains.get']('fqdn') }}" {{ salt['pillar.get']('rkhunter:rkhunter_config:MAIL-ON-WARNING')|first }} < /tmp/rkhunter.tmp
  touch $LOCK_FILE  
  {% endif -%}
else
  exit 0
fi
