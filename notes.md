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

[X] `rails g resource Building name:string address:string city:string state:string zip_code:string` 
[X] `rails g resource Unit apt_num:string tenant:string building_id:integer property_manager:integer`
[X] `rails g resource Revenue type:string amount:string date:date unit_id:integer`
[X] `rails g resource Expense type:string amount:string date:date unit_id:integer`

Building Resources
[X] New Form
[X] Edit Form
[X] Index Page
[ ] Show Page

Units 
[X] New Form
[X] Edit Form
<!-- [ ] Index Page -->
[X] Show Page

[X] Create a way that only those signed in can see the page.
[ ] Only see the pages related to the current_user
[ ] Add Validations for invalid user/password
[ ] Protect against multiple Apartment Numbers per Building per User (Validation) -- 


[X]Nested Routes
- Create Unit Show Page.
- Create Nested Route 'buildings/:id/units' - index of all units for that Building
    ```
        resources :buildings, only: [:index, :show] do 
            resources :units, only: [:show, :index]
        end
    ```

Add OmniAuth
- Watch https://instruction.learn.co/student/video_lectures#/443


[X] Route - '/tenants'
[X] Create a scope method - Returns all Units Tenants in Alphabetical Order
[X] Units Index - List out the Tenants and what units they belong to and what building they belong to.

12-25-2019 Goal: Expenses
1) Add ability to Edit Expense Types
[ ] ADD table for expense_types
[ ] CHANGE table expenses column exp_type with expense_type_id (for relationship)
[ ] ADD relationship between expense_types and expenses table
[ ] ADD ability to add expenses on the fly with auto-complete if already there

2) Add Expenses to Buildings
[ ] CREATE expenses
[ ] EDIT expenses
[ ] SHOW expenses
[ ] Add expenses to the units show page.

3) Total Expenses
[ ] Add Total of expenses to the bottom of the page
[ ] Add Total of Revenues
[ ] Show Net Profit from the building