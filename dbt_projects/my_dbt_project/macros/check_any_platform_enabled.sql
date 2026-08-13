{% macro check_any_platform_enabled(platforms) %}
{% set enable = false %}
  {% for platform in platforms %}
    {% if var('include_' ~ platform, false) %}
      {% set enable = true %}
      {{ return(enable | as_bool) }}
    {% endif %}
  {% endfor %}
  {{ return(enable | as_bool) }}
{% endmacro %}