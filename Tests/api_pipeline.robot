*** Settings ***
Resource    ../Resource/login.robot
Resource    ../Resource/pages/admin_page.robot
Suite Setup     Store Cookie Header

*** Test Cases ***
Admin - Add Job Title
    ${job_id}    Add Job Title    job_name=My First Job    cookie=${cookie_header}
    Set Global Variable    ${job_id}

Admin - Delete Job Title
    Delete Job Title    job_id=${job_id}   cookie=${cookie_header}

*** Keywords ***
Store Cookie Header
    ${cookie_header}=    Login With Authentication
    Set Global Variable    ${cookie_header}
