with 

source as (

    select * from {{ source('northwind', 'Employees') }}

),

renamed as (

    select
        employeeid,
        lastname,
        firstname,
        title,
        titleofcourtsey,
        birthdate,
        hiredate,
        address,
        city,
        region,
        postalcode,
        country,
        homephone,
        extension,
        notes,
        reportsto

    from source

)

select * from renamed