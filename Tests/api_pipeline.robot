*** Settings ***
Resource    ../Resource/backend/login.robot
Resource    ../Resource/backend/pages/admin.robot
Resource    ../Resource/backend/pages/pim.robot
Resource    ../Resource/backend/pages/leave.robot
Resource    ../Resource/backend/pages/time.robot
Resource    ../Resource/backend/pages/my_info.robot
Resource    ../Resource/backend/pages/recruitment.robot
Resource    ../Resource/backend/pages/performance.robot
Resource    ../Resource/backend/pages/dashboard.robot
Resource    ../Resource/backend/pages/claim.robot
Resource    ../Resource/backend/pages/buzz.robot
Library     DateTime
Library     String
Suite Setup     Store Cookie Header

*** Test Cases ***
Admin - Add Job Title
    ${job_id}    Add Job Title    job_name=My First Job    cookie=${cookie_header}    status=200
    Set Global Variable    ${job_id}

Admin - Add Duplicated Job Title - Expect 422
    Add Job Title    job_name=My First Job    cookie=${cookie_header}    status=422

Admin - Delete Job Title
    Delete Job Title    job_id=${job_id}   cookie=${cookie_header}    status=200

Admin - Delete Non-Existing Job Title - Expect 404
    Delete Job Title    job_id=${job_id}   cookie=${cookie_header}    status=404

Admin - Add Location
    ${location_id}    Add Location    location=R&D    cookie=${cookie_header}    status=200
    Set Global Variable    ${location_id}

Admin - Delete Location
    Delete Location    location_id=${location_id}   cookie=${cookie_header}    status=200

Admin - Delete Non-Existing Location - Expect 404
    Delete Location    location_id=${location_id}   cookie=${cookie_header}    status=404

Admin - Change Corp Brand
    Change Corp Brand     cookie=${cookie_header}    status=200  primary_color=#2efc04
    ...    primary_font_color=#FFFFFF    secondary_color=#1703fb  second_font_color=#FFFFFF
    ...    primary_grad_color=#f9e104    secondary_grad_color=#dc04f5

Admin - Change Corp Brand - Default
    Change Corp Brand     cookie=${cookie_header}    status=200   

Admin - Deactivate Modules - Expect 422
    Activate/Deactivate Modules     cookie=${cookie_header}    status=422   admin=false   pim=false   leave=false   time=false   recruitment=false   performance=false   maintenance=false   mobile=false   directory=false   claim=false   buzz=false  

Admin - Deactivate Modules - Expect 200
    Activate/Deactivate Modules     cookie=${cookie_header}    status=200   admin=true    pim=true   leave=false   time=false   recruitment=false   performance=false   maintenance=false   mobile=false   directory=false   claim=false   buzz=false  

Admin - Activate Modules
    Activate/Deactivate Modules     cookie=${cookie_header}    status=200  

Admin - Change Language To Spanish
    Change Language     cookie=${cookie_header}    status=200    language=es

Admin - Change Language To English
    Change Language     cookie=${cookie_header}    status=200 

Admin - Send Email Notification
    Send Email Notification     cookie=${cookie_header}    status=200 

Pim - Add Employee
    ${empNumber}    Add Employee     cookie=${cookie_header}    status=200    employeeId=9997   firstName=Gabriel   lastName=Martins   middleName=Henrique
    Set Global Variable    ${empNumber}

Pim - Add Duplicated Employee - Expect 422
    Add Employee     cookie=${cookie_header}    status=422    employeeId=9997   firstName=Gabriel   lastName=Martins   middleName=Henrique

Pim - Delete Employee
    Delete Employee   cookie=${cookie_header}    status=200    employee_id=${empNumber}

Pim - Delete Non-Existing Employee - Expect 404
    Delete Employee   cookie=${cookie_header}    status=404    employee_id=${empNumber}

Leave - Add Leave Type
    ${random_number}     Generate Random String     length=5   chars=[NUMBERS]
    Set Global Variable    ${random_number}    ${random_number}
    ${leave_id}    Add Leave Type     cookie=${cookie_header}    status=200    name=Leave ${random_number}   situational=false
    Set Global Variable    ${leave_id}

Leave - Add Duplicated Leave Type - Expect 422
    Add Leave Type     cookie=${cookie_header}    status=422    name=Leave ${random_number}   situational=false

Leave - Delete Leave Type
    Delete Leave Type   cookie=${cookie_header}    status=200    leave_type_id=${leave_id}

Leave - Delete Non-Existing Leave Type - Expect 404
    Delete Leave Type   cookie=${cookie_header}    status=404    leave_type_id=${leave_id}

Performance - Get Titles
    ${title_id}    Get First Title     cookie=${cookie_header}    status=200
    Set Global Variable    ${title_id}

Performance - Add KPI
    ${perform_kpi_id}    Add KPI     cookie=${cookie_header}    status=200   kpi=My KPI   jobTitleId=${title_id}
    Set Global Variable    ${perform_kpi_id}

Performance - Delete KPI
    Delete KPI    cookie=${cookie_header}    status=200     kpi_id=${perform_kpi_id} 

Performance - Delete Non-Existing KPI - Expect 404
    Delete KPI    cookie=${cookie_header}    status=404     kpi_id=${perform_kpi_id}
    
My Info - Get Personal Details
    Get Personal Details     cookie=${cookie_header}    status=200

Recruitment - Get Job Titles
    Get Job Titles     cookie=${cookie_header}    status=200

Time - Punch Out - Ignore Error
    ${current_time}    Get Current Date	   UTC	 + 999 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Run Keyword and Ignore Error    Punch Out      cookie=${cookie_header}    status=200     date=${date}   time=${time}

Time - Get All Punch Before Register
    ${punch_ids}    Get All Punch In Punch Out      cookie=${cookie_header}    status=200
    Set Global Variable    ${punch_ids}

Time - Delete Punch Before Register
    Run keyword and ignore Error    Delete Punch      cookie=${cookie_header}    status=200    punch_ids=${punch_ids}

Time - Punch In
    ${current_time}    Get Current Date	   UTC	 - 3 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Punch In      cookie=${cookie_header}    status=200     date=${date}   time=${time}

Time - Punch Out
    ${current_time}    Get Current Date	   UTC	 - 2 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Punch Out      cookie=${cookie_header}    status=200     date=${date}   time=${time}

Time - Get All Punch After Register
    ${punch_ids}    Get All Punch In Punch Out      cookie=${cookie_header}    status=200
    Set Global Variable    ${punch_ids}

Time - Delete Punch After Register
    Delete Punch      cookie=${cookie_header}    status=200    punch_ids=${punch_ids}

Dashboard - Get Dashboards
    Get Dashboards     cookie=${cookie_header}    status=200

Claim - Add Expense Type
    ${expense_type_id}    Add Expense Type     cookie=${cookie_header}    status=200    name=My Expense   description=My Description!    expense_status=true
    Set Global Variable    ${expense_type_id}

Claim - Add Duplicated Expense Type - Expect 422
    Add Expense Type     cookie=${cookie_header}    status=422    name=My Expense   description=My Description!    expense_status=true

Claim - Delete Expense Type
    Delete Expense Type   cookie=${cookie_header}    status=200    expense_id=${expense_type_id}

Claim - Delete Non-Existing Expense Type - Expect 404
    Delete Expense Type   cookie=${cookie_header}    status=404    expense_id=${expense_type_id}


Buzz - Add Post
    ${buzz_post_id}    Add Post     cookie=${cookie_header}    status=200    type=text   text=My friend!
    Set Global Variable    ${buzz_post_id}

Buzz - Delete Post
    Delete Post   cookie=${cookie_header}    status=200    post_id=${buzz_post_id}

Buzz - Delete Non-Existing Post - Expect 422
    Delete Post   cookie=${cookie_header}    status=422    post_id=${buzz_post_id}

*** Keywords ***
Store Cookie Header
    ${cookie_header}=    Login With Authentication
    Set Global Variable    ${cookie_header}
