rkhunter_update:
  cmd.run:
    - name: |
          {%-  if salt['pillar.get']('rkhunter:http_proxy') is defined %}
          export http_proxy={{ salt['pillar.get']('rkhunter:http_proxy') }}
          {{ salt['pillar.get']('rkhunter:rkhunter_config:INSTALLDIR')|first }}/bin/rkhunter --update --nocolors
          unset http_proxy
          {% else %}
          {{ salt['pillar.get']('rkhunter:rkhunter_config:INSTALLDIR')|first }}/bin/rkhunter --update --nocolors
          {% endif %}
