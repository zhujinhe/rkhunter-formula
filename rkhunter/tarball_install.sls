{% from "rkhunter/map.jinja" import rkhunter with context %}
{% set rkhunter_install_prefix = salt['pillar.get']('rkhunter:rkhunter_config:INSTALLDIR', []) %}

rkhunter_tarball:
  file.managed:
    - order: 1
    - name : /tmp/rkhunter-1.4.2.tar.gz
    - source: salt://rkhunter/files/rkhunter-1.4.2.tar.gz
    - user: root
    - mode: 640

rkhunter_install:
  cmd.run:
    - order: 2
    - name: |
        cd /tmp
        tar zxvf rkhunter-1.4.2.tar.gz
        cd rkhunter-1.4.2
        ./installer.sh --layout {{ rkhunter_install_prefix|first }} --install

rkhunter_conf:
  file.managed:
   - order: 3
   - name: {{ rkhunter.conf }}
   - source: salt://rkhunter/files/rkhunter.conf
   - template: jinja
   - user: root
   - mode: 640

rkhunter_baseline:
  file.managed:
    - order: 4
    - name: /usr/local/rkhunter_baseline.sh
    - user: root
    - group: root
    - mode: 750
    - source: salt://rkhunter/files/baseline.sh
    - template: jinja
  cmd.run:
    - name: bash /usr/local/rkhunter_baseline.sh
    - unless: ls /var/run/rkhunter_baseline
    - use_vt: True
    - require:
      - file: /usr/local/rkhunter_baseline.sh

rkhunter_cron:
  cron.present:
    - order: 5
    - name: {{ rkhunter_install_prefix|first }}/bin/rkhunter --cronjob
    - identifier: rkhunter_cron_daily
    - user: root
    - minute: random
    - hour: 9
