*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Expense Type
    [Documentation]    This keywords add a Expense Type
    ...    
    ...    This keyword adds a Expense Type in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Expense Type   |     name=My Expense   |     description=My Description   |     expense_status=true   |     cookie=cookie   |     status=200   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${name}   ${description}    ${expense_status}
    ${claim_form_data}   Set Variable   {"name": "${name}", "description": "${description}", "status": ${expense_status}}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/claim/expenses/types     data=${claim_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${id}              Get From Dictionary    ${data}    id
        Log To Console     Expense Type ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete Expense Type
    [Documentation]    This keywords delete an Expense Type

    ...    This keyword deletes an Expense Type in the OrangeHRM application.
    ...    
    ...    | Delete Expense Type   |    expense_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${expense_id}   ${cookie}    ${status}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${expense_type_del_data}      Set Variable   {"ids": [${expense_id}]}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/claim/expenses/types   data=${expense_type_del_data}   headers=${header}   expected_status=${status}
    Log To Console     Expense Type ID Deleted: ${expense_id}
