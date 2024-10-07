*** Settings ***
Resource    ../login.robot

*** Keywords ***
Get First Title
    [Documentation]    This keywords Get First Title

    ...    This keyword return only the first available Title
    ...    
    ...    | Get Dashboards   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   GET On Session    alias=ORANGE    url=/api/v2/admin/job-titles?limit=0      headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}         Convert String To Json             ${response.content}
        ${first_row}       Get From List           ${json_response['data']}    0
        ${id}              Get From Dictionary     ${first_row}    id
        ${title}           Get From Dictionary     ${first_row}    title
        Log To Console     Job Title: ${title} has the ID: ${id}
        Return From Keyword    ${id}
    END

Add KPI
    [Documentation]    This keywords add a KPI
    ...    
    ...    This keyword adds a KPI in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add KPI   |     kpi=My KPI   |     jobTitleId=123   |     cookie=cookie   |     status=200   |     minRating   |     maxRating   |     isDefault   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]    ${cookie}    ${status}   ${kpi}   ${jobTitleId}    ${minRating}=0   ${maxRating}=100    ${isDefault}=false
    ${kpi_form_data}   Set Variable   {"title": "${kpi}", "jobTitleId": "${jobTitleId}", "minRating": ${minRating}, "maxRating": ${maxRating}, "isDefault": ${isDefault}}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/api/v2/performance/kpis     data=${kpi_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${id}              Get From Dictionary    ${data}    id
        Log To Console     KPI ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete KPI
    [Documentation]    This keywords delete a KPI

    ...    This keyword deletes a KPI in the OrangeHRM application.
    ...    
    ...    | Delete KPI   |    kpi_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${kpi_id}   ${cookie}    ${status}
    ${kpi_del_data}   Set Variable   {"ids": [${kpi_id}]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/api/v2/performance/kpis     data=${kpi_del_data}       headers=${header}   expected_status=${status}
    Log To Console     KPI ID Deleted: ${kpi_id}
