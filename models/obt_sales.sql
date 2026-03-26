with f_sales as (

    select * from {{ ref('fact_sales') }}

),

d_customer as (

    select * from {{ ref('dim_customer') }}

),

d_employee as (

    select * from {{ ref('dim_employee') }}

),

d_date as (

    select * from {{ ref('dim_date') }}

),

d_product as (

    select * from {{ ref('dim_product') }}

),

d_supplier as (

    select * from {{ ref('dim_supplier') }}

)

select
    f.saleskey,
    f.orderid,
    f.quantity,
    f.extendedpriceamount,
    f.discountamount,
    f.soldamount,
    d_customer.*,
    d_employee.*,
    d_date.*,
    d_product.*,
    d_supplier.suppliercompanyname,
    d_supplier.suppliercontactname,
    d_supplier.suppliercontacttitle,
    d_supplier.supplieraddress,
    d_supplier.suppliercity,
    d_supplier.supplierregion,
    d_supplier.supplierpostalcode,
    d_supplier.suppliercountry,
    d_supplier.supplierphone,
    d_supplier.supplierfax,
    d_supplier.supplierhomepage
from f_sales f
left join d_customer
    on f.customerkey = d_customer.customerkey
left join d_employee
    on f.employeekey = d_employee.employeekey
left join d_date
    on f.datekey = d_date.datekey
left join d_product
    on f.productkey = d_product.productkey
left join d_supplier
    on d_product.supplierkey = d_supplier.supplierkey