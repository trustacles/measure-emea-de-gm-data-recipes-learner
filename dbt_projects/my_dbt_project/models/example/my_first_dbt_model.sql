/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

{{
    config(
        schema = "staging",
        full_refresh = var('allow_full_refresh', false)
    )
}}

with source_data as (
    select 1 as id, 'Alice' as name, 'Electronics' as category, 250.00 as amount, cast('2024-01-05' as date) as created_at
    union all
    select 2 as id, 'Carla' as name, 'Groceries' as category, 89.99 as amount, cast('2024-01-12' as date) as created_at
    union all
    select 3 as id, 'David' as name, 'Electronics' as category, 1200.00 as amount, cast('2024-01-15' as date) as created_at
    union all
    select 4 as id, 'Elena' as name, 'Home & Garden' as category, 76.25 as amount, cast('2024-01-19' as date) as created_at
    union all
    select 5 as id, 'Frank' as name, 'Clothing' as category, 32.10 as amount, cast('2024-01-22' as date) as created_at
    union all
    select 6 as id, 'Grace' as name, 'Groceries' as category, 154.75 as amount, cast('2024-01-27' as date) as created_at
    union all
    select 7 as id, 'Henry' as name, 'Electronics' as category, 899.99 as amount, cast('2024-02-01' as date) as created_at
    
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null