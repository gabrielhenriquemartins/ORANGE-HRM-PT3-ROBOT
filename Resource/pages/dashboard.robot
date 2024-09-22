*** Settings ***
Resource    ../login.robot
Library    DateTime

*** Keywords ***
Get Dashboards
    [Documentation]    This keywords Get all Dashboards

    ...    This keyword get all available Dashboards.
    ...    
    ...    | Get Dashboards   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${current_time}    Get Current Date	   UTC	 - 3 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${time}    set Variable    ${current_time}[11:16]
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   GET On Session    alias=ORANGE    url=/web/index.php/api/v2/dashboard/employees/time-at-work?timezoneOffset=-3&currentDate=${date}&currentTime=${time}      headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        Should Not Be Empty    ${json_response}
        Log To Console         Dashboards Found!
    END