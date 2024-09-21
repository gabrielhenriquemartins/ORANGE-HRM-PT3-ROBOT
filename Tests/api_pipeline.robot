*** Settings ***
Resource    ../Resource/login.robot
Resource    ../Resource/pages/admin_page.robot
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

Admin - Add Duplicated Location - Expect 200
    Add Location    location=R&D    cookie=${cookie_header}    status=200

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


*** Keywords ***
Store Cookie Header
    ${cookie_header}=    Login With Authentication
    Set Global Variable    ${cookie_header}
