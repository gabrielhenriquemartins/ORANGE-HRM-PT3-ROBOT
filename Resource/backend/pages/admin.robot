*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Job Title
    [Documentation]    This keywords add a job title
    ...    
    ...    This keyword adds a job title in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Job Title   |     job_name=My Job   |     cookie=cookie   |     status=200   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]    ${job_name}   ${cookie}    ${status}
    ${job_form_data}   Set Variable   {"title": "${job_name}", "description": "My Description", "note": "My Note"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/job-titles     data=${job_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${id}              Get From Dictionary    ${data}    id
        Log To Console     Job ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete Job Title
    [Documentation]    This keywords delete a job title

    ...    This keyword deletes a job title in the OrangeHRM application.
    ...    
    ...    | Delete Job Title   |    job_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${job_id}   ${cookie}    ${status}
    ${job_del_data}   Set Variable   {"ids": ["${job_id}"]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/job-titles     data=${job_del_data}       headers=${header}   expected_status=${status}
    Log To Console     Job ID Deleted: ${job_id}

Add Location
    [Documentation]    This keywords add a Location
    ...    
    ...    This keyword adds a Location in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Location   |     location=R&D   |     cookie=cookie   |     status=200   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]    ${location}   ${cookie}    ${status}
    ${location_form_data}   Set Variable   {"address": "Address", "city": "Cidade", "countryCode":"BR", "fax":"10000", "name":"${location}", "note":"Notes", "phone":"10000", "province":"Minas", "zipCode":"1000000"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/locations     data=${location_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${id}              Get From Dictionary    ${data}    id
        Log To Console     Location ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete Location
    [Documentation]    This keywords delete a location

    ...    This keyword deletes a location in the OrangeHRM application.
    ...    
    ...    | Delete Location   |    location_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${location_id}   ${cookie}    ${status}
    ${location_del_data}   Set Variable   {"ids": ["${location_id}"]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/locations     data=${location_del_data}       headers=${header}   expected_status=${status}
    Log To Console     Location ID Deleted: ${location_id}

Change Corp Brand
    [Documentation]    This keywords change the page color

    ...    This keyword change the page color in the OrangeHRM application. 
    ...    The default value is defined in Arguments.
    ...    
    ...    | Change Corp Brand   |    cookie=cookie   |    status=200   |  primary_color   |    primary_font_color   |   secondary_color   |   second_font_color   |   primary_grad_color   |   secondary_grad_color   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${cookie}    ${status}   ${primary_color}=#FF7B1D    ${primary_font_color}=#FFFFFF   ${secondary_color}=#76BC21   ${second_font_color}=#FFFFFF   ${primary_grad_color}=#FF920B   ${secondary_grad_color}=#F35C17
    ${non_default_color}   Set Variable   {"variables": {"primaryColor": "${primary_color}", "primaryFontColor": "${primary_font_color}", "secondaryColor": "${secondary_color}", "secondaryFontColor": "${second_font_color}", "primaryGradientStartColor": "${primary_grad_color}", "primaryGradientEndColor": "${secondary_grad_color}"}, "showSocialMediaImages": true, "currentClientLogo": null, "clientLogo": null, "currentClientBanner": null, "clientBanner": null, "currentLoginBanner": null, "loginBanner": null}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/theme     data=${non_default_color}       headers=${header}    expected_status=${status}

Activate/Deactivate Modules
    [Documentation]    This keywords set the modules

    ...    This keyword set the available modules in the OrangeHRM application.
    ...    By default, all modules are set as true.
    ...    
    ...    | Activate/Deactivate Modules   |    cookie=cookie   |    status=200   |  admin   |    pim   |   leave   |   time   |   recruitment   |   performance   |   maintenance   |   mobile   |   directory   |   claim   |   buzz   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${cookie}    ${status}   ${admin}=true   ${pim}=true   ${leave}=true   ${time}=true   ${recruitment}=true   ${performance}=true   ${maintenance}=true   ${mobile}=true   ${directory}=true   ${claim}=true   ${buzz}=true
    ${non_default_color}   Set Variable   {"admin": ${admin}, "pim": ${pim}, "leave": ${leave}, "time": ${time}, "recruitment": ${recruitment}, "performance": ${performance}, "maintenance": ${maintenance}, "mobile": ${mobile}, "directory": ${directory}, "claim": ${claim}, "buzz": ${buzz}}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/modules     data=${non_default_color}       headers=${header}    expected_status=${status}

Change Language
    [Documentation]    This keywords set the language

    ...    This keyword set the language in the OrangeHRM application.
    ...    By default, the language is set to english.
    ...    
    ...    | Change Language   |    cookie=cookie   |    status=200   |  language   |    date_format   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${cookie}    ${status}   ${language}=en_US   ${date_format}=Y-d-m   
    ${language}   Set Variable   {"language": "${language}", "dateFormat": "${date_format}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/localization     data=${language}       headers=${header}    expected_status=${status}

Send Email Notification
    [Documentation]    This keywords send an email configuration

    ...    This keyword send an email notification.
    ...    
    ...    | Send Email Notification   |    cookie=cookie   |    status=200   |  sentAs   |    test_email_address   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]     ${cookie}     ${status}   ${sentAs}=admin@mail.com   ${test_email_address}=test@mail.com 
    ${email_data}   Set Variable   {"mailType": "sendmail", "sentAs": "${sentAs}", "smtpHost": null, "smtpPort": null, "smtpUsername": "", "smtpPassword": null, "smtpAuthType": "none", "smtpSecurityType": "none", "testEmailAddress": "${test_email_address}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/email-configuration     data=${email_data}       headers=${header}    expected_status=${status}