*** Settings ***
Resource    ../login.robot

*** Keywords ***
Get Job Titles
    [Documentation]    This keywords Get Job Titles

    ...    This keyword Get all Job Titles
    ...    
    ...    | Get Job Titles   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   GET On Session    alias=ORANGE    url=/api/v2/admin/job-titles?limit=0      headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        Should Not Be Empty    ${response.content}
        Log To Console         Job Titles were Found!
    END