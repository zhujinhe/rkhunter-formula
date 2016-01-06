{% if salt['pillar.get']('rkhunter:install_method') == 'tarball' %}
include:
  - rkhunter.tarball_install
{% endif %}
