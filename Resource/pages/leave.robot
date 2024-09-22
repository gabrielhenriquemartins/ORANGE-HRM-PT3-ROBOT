*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Leave Type
    [Documentation]    This keywords add a Leave Type
    ...    
    ...    This keyword adds a Leave Type in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Leave Type   |     name=My Leave   |     situational=false   |      cookie=cookie   |     status=200   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${name}   ${situational}
    ${leave_form_data}   Set Variable   {"name": "${name}", "situational": ${situational}}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/leave/leave-types     data=${leave_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${id}              Get From Dictionary    ${data}    id
        Log To Console     Leave Type ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete Leave Type
    [Documentation]    This keywords delete a Leave Type

    ...    This keyword deletes a Leave Type in the OrangeHRM application.
    ...    
    ...    | Delete Leave Type   |    leave_type_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${leave_type_id}   ${cookie}    ${status}
    ${leave_type_del_data}   Set Variable   {"ids": [${leave_type_id}]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/leave/leave-types     data=${leave_type_del_data}       headers=${header}   expected_status=${status}
    Log To Console     Leave Type ID Deleted: ${leave_type_id}
