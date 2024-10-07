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
[Robot] Admin - Add Job Title
    Log To Console   Jira Issue: OTS-92 
    ${job_id}    Add Job Title    job_name=My First Job    cookie=${cookie_header}    status=200
    Set Global Variable    ${job_id}

[Robot] Admin - Add Duplicated Job Title - Expect 422
    Log To Console   Jira Issue: OTS-93
    Add Job Title    job_name=My First Job    cookie=${cookie_header}    status=422

[Robot] Admin - Delete Job Title
    Log To Console   Jira Issue: OTS-94
    Delete Job Title    job_id=${job_id}   cookie=${cookie_header}    status=200

[Robot] Admin - Delete Non-Existing Job Title - Expect 404
    Log To Console   Jira Issue: OTS-95
    Delete Job Title    job_id=${job_id}   cookie=${cookie_header}    status=404

[Robot] Admin - Add Location
    Log To Console   Jira Issue: OTS-96
    ${location_id}    Add Location    location=R&D    cookie=${cookie_header}    status=200
    Set Global Variable    ${location_id}

[Robot] Admin - Delete Location
    Log To Console   Jira Issue: OTS-97
    Delete Location    location_id=${location_id}   cookie=${cookie_header}    status=200

[Robot] Admin - Delete Non-Existing Location - Expect 404
    Log To Console   Jira Issue: OTS-98
    Delete Location    location_id=${location_id}   cookie=${cookie_header}    status=404

[Robot] Admin - Change Corp Brand
    Log To Console   Jira Issue: OTS-99
    Change Corp Brand     cookie=${cookie_header}    status=200  primary_color=#2efc04
    ...    primary_font_color=#FFFFFF    secondary_color=#1703fb  second_font_color=#FFFFFF
    ...    primary_grad_color=#f9e104    secondary_grad_color=#dc04f5

[Robot] Admin - Change Corp Brand - Default
    Log To Console   Jira Issue: OTS-100
    Change Corp Brand     cookie=${cookie_header}    status=200   

[Robot] Admin - Deactivate Modules - Expect 422
    Log To Console   Jira Issue: OTS-101
    Activate/Deactivate Modules     cookie=${cookie_header}    status=422   admin=false   pim=false   leave=false   time=false   recruitment=false   performance=false   maintenance=false   mobile=false   directory=false   claim=false   buzz=false  

[Robot] Admin - Deactivate Modules - Expect 200
    Log To Console   Jira Issue: OTS-102
    Activate/Deactivate Modules     cookie=${cookie_header}    status=200   admin=true    pim=true   leave=false   time=false   recruitment=false   performance=false   maintenance=false   mobile=false   directory=false   claim=false   buzz=false  

[Robot] Admin - Activate Modules
    Log To Console   Jira Issue: OTS-103
    Activate/Deactivate Modules     cookie=${cookie_header}    status=200  

[Robot] Admin - Change Language To English
    Log To Console   Jira Issue: OTS-105
    Change Language     cookie=${cookie_header}    status=200 

[Robot] Admin - Send Email Notification
    Log To Console   Jira Issue: OTS-106
    Send Email Notification     cookie=${cookie_header}    status=200 

[Robot] Pim - Add Employee
    Log To Console   Jira Issue: OTS-107
    ${empNumber}    Add Employee     cookie=${cookie_header}    status=200    employeeId=9997   firstName=Gabriel   lastName=Martins   middleName=Henrique
    Set Global Variable    ${empNumber}

[Robot] Pim - Add Duplicated Employee - Expect 422
    Log To Console   Jira Issue: OTS-108
    Add Employee     cookie=${cookie_header}    status=422    employeeId=9997   firstName=Gabriel   lastName=Martins   middleName=Henrique

[Robot] Pim - Delete Employee
    Log To Console   Jira Issue: OTS-109
    Delete Employee   cookie=${cookie_header}    status=200    employee_id=${empNumber}

[Robot] Pim - Delete Non-Existing Employee - Expect 404
    Log To Console   Jira Issue: OTS-110
    Delete Employee   cookie=${cookie_header}    status=404    employee_id=${empNumber}

[Robot] Leave - Add Leave Type
    Log To Console   Jira Issue: OTS-111
    ${random_number}     Generate Random String     length=5   chars=[NUMBERS]
    Set Global Variable    ${random_number}    ${random_number}
    ${leave_id}    Add Leave Type     cookie=${cookie_header}    status=200    name=Leave ${random_number}   situational=false
    Set Global Variable    ${leave_id}

[Robot] Leave - Add Duplicated Leave Type - Expect 422
    Log To Console   Jira Issue: OTS-112
    Add Leave Type     cookie=${cookie_header}    status=422    name=Leave ${random_number}   situational=false

[Robot] Leave - Delete Leave Type
    Log To Console   Jira Issue: OTS-113
    Delete Leave Type   cookie=${cookie_header}    status=200    leave_type_id=${leave_id}

[Robot] Leave - Delete Non-Existing Leave Type - Expect 404
    Log To Console   Jira Issue: OTS-114
    Delete Leave Type   cookie=${cookie_header}    status=404    leave_type_id=${leave_id}

[Robot] Performance - Get Titles
    Log To Console   Jira Issue: OTS-115
    ${title_id}    Get First Title     cookie=${cookie_header}    status=200
    Set Global Variable    ${title_id}

[Robot] Performance - Add KPI
    Log To Console   Jira Issue: OTS-116
    ${perform_kpi_id}    Add KPI     cookie=${cookie_header}    status=200   kpi=My KPI   jobTitleId=${title_id}
    Set Global Variable    ${perform_kpi_id}

[Robot] Performance - Delete KPI
    Log To Console   Jira Issue: OTS-117
    Delete KPI    cookie=${cookie_header}    status=200     kpi_id=${perform_kpi_id} 

[Robot] Performance - Delete Non-Existing KPI - Expect 404
    Log To Console   Jira Issue: OTS-118
    Delete KPI    cookie=${cookie_header}    status=404     kpi_id=${perform_kpi_id}
    
[Robot] My Info - Get Personal Details
    Log To Console   Jira Issue: OTS-119
    Get Personal Details     cookie=${cookie_header}    status=200

[Robot] Recruitment - Get Job Titles
    Log To Console   Jira Issue: OTS-120
    Get Job Titles     cookie=${cookie_header}    status=200

[Robot] Time - Attendance Configuration
    Log To Console   Jira Issue: OTS-121
    Attendance Configuration     cookie=${cookie_header}    status=200

[Robot] Time - Punch Out - Ignore Error
    Log To Console   Jira Issue: OTS-122
    ${current_time}    Get Current Date	   UTC	 + 999 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Run Keyword and Ignore Error    Punch Out      cookie=${cookie_header}    status=200     date=${date}   time=${time}

[Robot] Time - Get All Punch Before Register
    Log To Console   Jira Issue: OTS-123
    ${punch_ids}    Get All Punch In Punch Out      cookie=${cookie_header}    status=200
    Set Global Variable    ${punch_ids}

[Robot] Time - Delete Punch Before Register
    Log To Console   Jira Issue: OTS-124
    Run keyword and ignore Error    Delete Punch      cookie=${cookie_header}    status=200    punch_ids=${punch_ids}

[Robot] Time - Punch In
    Log To Console   Jira Issue: OTS-125
    ${current_time}    Get Current Date	   UTC	 - 3 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Punch In      cookie=${cookie_header}    status=200     date=${date}   time=${time}

[Robot] Time - Punch Out
    Log To Console   Jira Issue: OTS-126
    ${current_time}    Get Current Date	   UTC	 - 2 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    Punch Out      cookie=${cookie_header}    status=200     date=${date}   time=${time}

[Robot] Time - Get All Punch After Register
    Log To Console   Jira Issue: OTS-127
    ${punch_ids}    Get All Punch In Punch Out      cookie=${cookie_header}    status=200
    Set Global Variable    ${punch_ids}

[Robot] Time - Delete Punch After Register
    Log To Console   Jira Issue: OTS-128
    Delete Punch      cookie=${cookie_header}    status=200    punch_ids=${punch_ids}

[Robot] Dashboard - Get Dashboards
    Log To Console   Jira Issue: OTS-129
    Get Dashboards     cookie=${cookie_header}    status=200

[Robot] Claim - Add Expense Type
    Log To Console   Jira Issue: OTS-130
    ${expense_type_id}    Add Expense Type     cookie=${cookie_header}    status=200    name=My Expense   description=My Description!    expense_status=true
    Set Global Variable    ${expense_type_id}

[Robot] Claim - Add Duplicated Expense Type - Expect 422
    Log To Console   Jira Issue: OTS-131
    Add Expense Type     cookie=${cookie_header}    status=422    name=My Expense   description=My Description!    expense_status=true

[Robot] Claim - Delete Expense Type
    Log To Console   Jira Issue: OTS-132
    Delete Expense Type   cookie=${cookie_header}    status=200    expense_id=${expense_type_id}

[Robot] Claim - Delete Non-Existing Expense Type - Expect 404
    Log To Console   Jira Issue: OTS-133
    Delete Expense Type   cookie=${cookie_header}    status=404    expense_id=${expense_type_id}

[Robot] Buzz - Add Post
    Log To Console   Jira Issue: OTS-134
    ${buzz_post_id}    Add Post     cookie=${cookie_header}    status=200    type=text   text=My friend!
    Set Global Variable    ${buzz_post_id}

[Robot] Buzz - Delete Post
    Log To Console   Jira Issue: OTS-135
    Delete Post   cookie=${cookie_header}    status=200    post_id=${buzz_post_id}

[Robot] Buzz - Delete Non-Existing Post - Expect 422
    Log To Console   Jira Issue: OTS-136
    Delete Post   cookie=${cookie_header}    status=422    post_id=${buzz_post_id}

*** Keywords ***
Store Cookie Header
    ${cookie_header}=    Login With Authentication
    Set Global Variable    ${cookie_header}
