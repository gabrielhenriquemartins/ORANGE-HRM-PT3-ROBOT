*** Settings ***
Resource    ../login.robot

*** Keywords ***
Get Personal Details
    [Documentation]    This keywords Get Personal Details

    ...    This keyword Get all Personal Details
    ...    
    ...    | Get Personal Details   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   GET On Session    alias=ORANGE    url=/api/v2/pim/employees/7/personal-details      headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        Should Not Be Empty    ${json_response}
        Log To Console         Personal Details were Found!
    END