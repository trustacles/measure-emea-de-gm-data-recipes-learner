{% macro generate_schema_name(schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set subunit = var('subunit', '') -%}

    {%- if schema_name is none -%}

        {{ default_schema }}

    {% elif target.name == 'sandbox' %}

        {{ target.name }}_{{ default_schema }}_bq_cgh_mp_{{ subunit | trim }}_{{ schema_name | trim }}

    {%- else -%}

        bq_cgh_mp_{{ subunit | trim }}_{{ schema_name | trim }}

    {%- endif -%}

{%- endmacro %}