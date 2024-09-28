*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Employee
    [Documentation]    This keywords add an Employee
    ...    
    ...    This keyword adds an Employee in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Employee   |     cookie=cookie   |     status=200   |     employeeId=9878   |     firstName=Gabriel   |     lastName=Martins  |     middleName=Henrique   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${employeeId}   ${firstName}   ${lastName}   ${middleName}
    ${employee_form_data}   Set Variable   {"employeeId": "${employeeId}", "firstName": "${firstName}", "lastName": "${lastName}", "middleName": "${middleName}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/pim/employees     data=${employee_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${empNumber}              Get From Dictionary    ${data}    empNumber
        Log To Console     Employee ID Created: ${empNumber}
        Return From Keyword    ${empNumber}
    END
    
Delete Employee
    [Documentation]    This keywords delete an Employee

    ...    This keyword deletes an Employee in the OrangeHRM application.
    ...    
    ...    | Delete Employee   |    employee_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${employee_id}   ${cookie}    ${status}
    ${employee_del_data}   Set Variable   {"ids": ["${employee_id}"]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/pim/employees     data=${employee_del_data}       headers=${header}   expected_status=${status}
    Log To Console     Employee ID Deleted: ${employee_id}
