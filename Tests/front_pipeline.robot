*** Settings ***
Resource         ../Resource/frontend/login.robot
Resource         ../Resource/frontend/common.robot
Resource         ../Resource/frontend/pages/admin.robot
Resource         ../Resource/frontend/pages/pim.robot
Resource         ../Resource/frontend/pages/leave.robot
Resource         ../Resource/frontend/pages/time.robot
Resource         ../Resource/frontend/pages/recruitment.robot
Resource         ../Resource/frontend/pages/my_info.robot
Resource         ../Resource/frontend/pages/performance.robot
Resource         ../Resource/frontend/pages/dashboard.robot
Resource         ../Resource/frontend/pages/directory.robot
Resource         ../Resource/frontend/pages/maintenance.robot
Resource         ../Resource/frontend/pages/claim.robot
Resource         ../Resource/frontend/pages/buzz.robot

Suite Setup      Wait Until Keyword Succeeds    5x    2s     Open Orange Home Page

*** Test Cases ***
[Robot] Home - Check Invalid Credentials
    Log To Console  Jira Issue: OTS-61
    Invalid Login

[Robot] Home - Check Required Username Message
    Log To Console  Jira Issue: OTS-62
    Username Required

[Robot] Home - Check Required Password Message
    Log To Console  Jira Issue: OTS-63 
    Password Required

[Robot] Home - Check Required Username and Password Message
    Log To Console  Jira Issue: OTS-64 
    Username and Password Required

[Robot] Home - Check Official Orange Home Page
    Log To Console  Jira Issue: OTS-65 
    Check Orange HRM link

[Robot] Home - Check Forgot Password and Email Message Sent
    Log To Console  Jira Issue: OTS-66 
    Check Forgot Password

[Robot] Home - Login as Admin
    Log To Console  Jira Issue: OTS-67 
    Login With the User Admin

[Robot] Admin - Add Location
    Log To Console   Jira Issue: OTS-68  
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu    Admin
    Add Location           name=R&D   city=New York  state=California  
    Check Toast Message    Successfully Saved

[Robot] Admin - Delete Location
    Log To Console   Jira Issue: OTS-69 
    Delete Location        name=R&D
    Check Toast Message    Successfully Deleted

[Robot] Admin - Add Language
    Log To Console   Jira Issue: OTS-70 
    Add Language           language=Brazilian
    Check Toast Message    Successfully Saved

[Robot] Admin - Delete Language
    Log To Console   Jira Issue: OTS-71 
    Delete Language        language=Brazilian
    Check Toast Message    Successfully Deleted

[Robot] Admin - Add Membership
    Log To Console   Jira Issue: OTS-72 
    Add Membership     membership=ISTQB
    Check Toast Message    Successfully Saved

[Robot] Admin - Delete Membership
    Log To Console   Jira Issue: OTS-73 
    Delete Membership    membership=ISTQB
    Check Toast Message    Successfully Deleted

[Robot] Admin - Add Nationality
    Log To Console   Jira Issue: OTS-74 
    ${random_number}     Generate Random String     length=8   chars=[NUMBERS]
    Set Global Variable    ${random_number}    ${random_number}
    Add Nationality    nationality=Brazilian${random_number}
    Check Toast Message    Successfully Saved

[Robot] Admin - Delete Nationality
    Log To Console   Jira Issue: OTS-75 
    Delete Nationality    nationality=Brazilian${random_number}
    Check Toast Message    Successfully Deleted
    
[Robot] Admin - Send Email Configuration
    Log To Console   Jira Issue: OTS-76 
    Send Email Configuration   email_sender=test_sender@hotmail.com       email_destination=test_destination@hotmail.com
    Check Toast Message    Successfully Saved
    Check Toast Message    Test Email Sent

[Robot] Admin - Add Social Media Authentication
    Log To Console   Jira Issue: OTS-77 
    Add Social Media Authentication       name=provider_test   provider_url=provider.com   client_id=123456   client_secret=123456
    Check Toast Message    Successfully Saved

[Robot] Admin - Delete Social Media Authentication
    Log To Console   Jira Issue: OTS-78 
    Delete Social Media Authentication    name=provider_test
    Check Toast Message    Successfully Deleted

[Robot] Pim - Add Termination Reason
    Log To Console  Jira Issue: OTS-92
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   PIM
    Add Termination Reason    reason=Vacation
    Check Toast Message    Successfully Saved

[Robot] Pim - Delete Termination Reason
    Log To Console  Jira Issue: OTS-93 
    Delete Termination Reason   reason=Vacation
    Check Toast Message    Successfully Deleted

[Robot] Pim - Add Reporting Method
    Log To Console  Jira Issue: OTS-94 
    Add Reporting Method   method=One-o-One
    Check Toast Message    Successfully Saved

[Robot] Pim - Delete Reporting Method
    Log To Console  Jira Issue: OTS-95
    Delete Reporting Method   method=One-o-One
    Check Toast Message    Successfully Deleted

[Robot] Leave - Create Leave Type
    Log To Console  Jira Issue: OTS-96 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Leave 
    ${random_number}     Generate Random String     length=8   chars=[NUMBERS]
    Set Global Variable    ${random_number}    ${random_number}
    Create Leave Type      type=Carnival${random_number}
    Check Toast Message    Successfully Saved

[Robot] Leave - Delete Leave Type
    Log To Console  Jira Issue: OTS-97 
    Delete Leave Type      type=Carnival${random_number}
    Check Toast Message    Successfully Deleted

[Robot] Time - Add Punch in Punch Out
    Log To Console   Jira Issue: OTS-98 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Time
    Add Punch in Punch Out

[Robot] Time - Delete Punch in Punch Out
    Log To Console   Jira Issue: OTS-99 
    Delete Punch in Punch Out
    Check Toast Message    Successfully Deleted

[Robot] Time - Add Costumer
    Log To Console   Jira Issue: OTS-100 
    Add Customer    customer=Amazon
    Check Toast Message    Successfully Saved

[Robot] Time - Add Project and Activities
    Log To Console   Jira Issue: OTS-101 
    Add Project and Activities    project_name=Arquiteture    customer=Amazon    activity=Bug Fix
    Check Toast Message    Successfully Saved

[Robot] Time - Add Row in My Timesheet
    Log To Console   Jira Issue: OTS-102 
    Add Row in My Timesheet    project=Arquiteture    activity=Bug Fix
    Check Toast Message    Successfully Saved

[Robot] Time - Delete Costumer
    Log To Console   Jira Issue: OTS-103  
    Delete Customer    customer=Amazon
    Check Toast Message    Successfully Deleted

[Robot] Recruitment - Add Candidate
    Log To Console   Jira Issue: OTS-104
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Recruitment
    Add Candidate    first_name=Gabriel    last_name=Martins    email=gabriel@hotmail.com
    Check Toast Message    Successfully Saved

[Robot] Recruitment - Delete Candidate
    Log To Console   Jira Issue: OTS-105 
    Delete Candidate   first_name=Gabriel Martins
    Check Toast Message    Successfully Deleted

[Robot] My_Info - Add PDF to Profile
    Log To Console   Jira Issue: OTS-106 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   My Info
    Add PDF to Profile
    Verify Pdf Uploaded    pdf_test.pdf
    Check Toast Message    Successfully Saved

[Robot] My_Info - Delete PDF from Profile
    Log To Console   Jira Issue: OTS-107 
    Delete PDF from Profile     pdf_test.pdf
    Check Toast Message    Successfully Deleted

[Robot] Admin - Add Job Title
    Log To Console   Jira Issue: OTS-108
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Admin
    Add Job Title          Senior DevOps
    Sleep    3s
    Check Toast Message    Successfully Saved

[Robot] Performance - Add KPI
    Log To Console   Jira Issue: OTS-109
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Performance
    Add KPI       kpi=Active Defects    job_title=Senior DevOps 
    Check Toast Message    Successfully Saved

[Robot] Performance - Delete KPI
    Log To Console   Jira Issue: OTS-110 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Performance
    Delete KPI    kpi=Active Defects
    Check Toast Message    Successfully Deleted
    
[Robot] Admin - Delete Job Title
    Log To Console   Jira Issue: OTS-111
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Admin 
    Delete Job Title       Senior DevOps
    Check Toast Message    Successfully Deleted

[Robot] Dashboard - Check If the main seven dashboards exists
    Log To Console   Jira Issue: OTS-112 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Dashboard
    Check If Dashboard Time at Work exists
    Check If Dashboard My Actions exists
    Check If Dashboard Quick Launch exists
    Check If Dashboard Buzz Latest Posts exists
    Check If Dashboard Employees on Leave Today exists
    Check If Dashboard Employee Distribution by Sub Unit exists
    Check If Dashboard Employee Distribution by Location exists

[Robot] Pim - Add Employee
    Log To Console  Jira Issue: OTS-113 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu    PIM
    ${id}     Add Employee     first_name=Gabriel    last_name=Martins
    Set Global Variable    ${id}    ${id}
    Check Toast Message    Successfully Saved

[Robot] Directory - Find Professional
    Log To Console    Jira Issue: OTS-114 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu    Directory
    Find Professional    Gabriel    Martins

[Robot] Pim - Delete Employee
    Log To Console  Jira Issue: OTS-115
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu    PIM
    Delete Employee    id=${id}
    Check Toast Message    Successfully Deleted

[Robot] Maintenance - Candidate Records
    Log To Console    Jira Issue: OTS-79 
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Maintenance
    Candidate Records    Software Engineer

[Robot] Claim - Create an Event
    Log to Console   Jira Issue: OTS-80
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu   Claim
    Create an Event    Event Test
    Check Toast Message    Successfully Saved

[Robot] Claim - Delete Event
    Log To Console   Jira Issue: OTS-81 
    Delete Event    Event Test
    Check Toast Message    Successfully Deleted

[Robot] Claim - Create an Expense Type
    Log to Console   Jira Issue: OTS-82  
    Create an Expense Type    Expense Test
    Check Toast Message    Successfully Saved

[Robot] Claim - Submit Claim
    Log to Console   Jira Issue: OTS-83  
    Wait Until Keyword Succeeds   3x   2s    Submit Claim   Accommodation    Canadian Dollar
    Check Toast Message    Successfully Saved

[Robot] Claim - Add Expenses
    Log To Console   Jira Issue: OTS-84 
    Add Expenses    Expense Test    20
    Check Toast Message    Successfully Saved
    Verify Added Expense    Expense Test

[Robot] Claim - Delete Expenses
    Log To Console   Jira Issue: OTS-85 
    Delete Item
    Check Toast Message    Successfully Deleted

[Robot] Claim - Add PDF File
    Log To Console   Jira Issue: OTS-86 
    Add PDF File
    Verify Pdf Uploaded    pdf_test.pdf
    Check Toast Message    Successfully Saved

[Robot] Claim - Delete Pdf
    Log To Console   Jira Issue: OTS-87 
    Delete Item
    Check Toast Message    Successfully Deleted

[Robot] Claim - Delete Expense Type
    Log to Console   Jira Issue: OTS-88 
    Delete Expense Type    Expense Test
    Check Toast Message    Successfully Deleted

[Robot] Buzz - Post a Message
    Log To Console   Jira Issue: OTS-89
    Wait Until Keyword Succeeds    5x   2s    Open Left Menu    Buzz
    Write and Post    message=Hello There
    Check Toast Message    Successfully Saved

[Robot] Buzz - Check Published Message
    Log To Console   Jira Issue: OTS-90  
    Check Published Message    message=Hello There

[Robot] Buzz - Like a Message
    Log To Console   Jira Issue: OTS-91 
    React to the first Message with a Heart