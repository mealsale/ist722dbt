with stg_orders as (

    select * from {{ source('northwind', 'orders') }}

),

stg_order_details as (

    select * from {{ source('northwind', 'order_details') }}

),

d_product as (

    select * from {{ ref('dim_product') }}

)

select
    {{ dbt_utils.generate_surrogate_key(['o.orderid', 'od.productid']) }} as saleskey,
    {{ dbt_utils.generate_surrogate_key(['o.employeeid']) }} as employeekey,
    {{ dbt_utils.generate_surrogate_key(['o.customerid']) }} as customerkey,
    replace(to_date(o.orderdate)::varchar, '-', '')::int as datekey,
    p.productkey,
    o.orderid,
    od.quantity,
    od.quantity * od.unitprice as extendedpriceamount,
    od.quantity * od.unitprice * od.discount as discountamount,
    od.quantity * od.unitprice * (1 - od.discount) as soldamount
from stg_orders o
join stg_order_details od
    on o.orderid = od.orderid
left join d_product p
    on od.productid = p.productid