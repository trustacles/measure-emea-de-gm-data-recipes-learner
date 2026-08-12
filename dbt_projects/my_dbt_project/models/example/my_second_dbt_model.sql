
-- Use the `ref` function to select from other models
{{
    config(
        schema = "staging",
        full_refresh = var('allow_full_refresh', false)
    )
}}


select *
from {{ ref('my_first_dbt_model') }}
where id = 1
