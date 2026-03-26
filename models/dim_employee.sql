with stg_employees as (

    select * from {{ source('northwind', 'employees') }}

)

select
    {{ dbt_utils.generate_surrogate_key(['stg_employees.employeeid']) }} as employeekey,
    stg_employees.*
from stg_employees