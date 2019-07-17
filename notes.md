# Notes

Things have to do: 
1. Create Migration for User Name
2. Create Migration for Classes and Models for:
    a. Property Managers == User
    b. Buildings
    c. Units
    d. Revenue
    e. Expenses
(First step will be on getting Property Managers Buildings and Units all interconnected with a has_many :through relationship
Second step will be to get the Revenue and Expenses linked up)

`rails g resource Building name:string address:string city:string state:string zip_code:string`
`rails g resource Unit apt_num:string tenant:string building_id:integer property_manager:integer`
`rails g resource Revenue type:string amount:string datetime:datetime unit_id:integer`

