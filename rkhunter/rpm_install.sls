{% from "rkhunter/map.jinja" import rkhunter with context %}
{#
# make sure pkgrepo has been installed
#}

rkhunter_rpm:
  pkg.installed:
    - name: {{ rkhunter.pkg_name }}
