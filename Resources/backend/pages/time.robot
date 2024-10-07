*** Settings ***
Resource    ../login.robot
Library     DateTime

*** Keywords ***
Get All Punch In Punch Out
    [Documentation]    This keywords Get All Punch In Punch Out

    ...    This keyword get all available Punch In Punch Out.
    ...    
    ...    | Get All Punch In Punch Out   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${current_time}    Get Current Date	   UTC	 - 3 hours
    ${date}    set Variable    ${current_time}[0:10]
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   GET On Session    alias=ORANGE    url=/api/v2/attendance/records?limit=50&offset=0&date=${date}     headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}    Get From Dictionary    ${json_response}    data
        @{ids}     Create List
        FOR    ${item}    IN    @{data}
            ${id}    Get From Dictionary    ${item}    id
            Append To List    ${ids}    ${id}
        END
        Log To Console     All Punch IDs: ${ids}
        Return From Keyword    ${ids}
    END
    
Delete Punch
    [Documentation]    This keywords Delete a Punch in/Out

    ...    This keyword deletes a Punch in/Out in the OrangeHRM application.
    ...    
    ...    | Delete Punch   |    punch_ids=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${punch_ids}   ${cookie}    ${status}
    ${header}     Create Dictionary header   set_cookie=${cookie}
    ${punch_del_data}   Set Variable   {"ids": [${punch_ids}]}
    ${response}   DELETE On Session    alias=ORANGE    url=/api/v2/attendance/records   data=${punch_del_data}   headers=${header}   expected_status=${status}
    Log To Console     Punch IDs Deleted: ${punch_ids}

Punch In
    [Documentation]    This keywords add a Punch In
    ...    
    ...    This keyword adds a Punch In in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Punch In   |     cookie=cookie   |     date=2024-09-09   |     time=18:20   |     note   |     timezoneOffset   |     timezoneName   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${date}   ${time}    ${note}=null    ${timezoneOffset}=-3    ${timezoneName}=America/Sao_Paulo
    ${punch_in_form_data}   Set Variable   {"date": "${date}", "time": "${time}", "note": ${note}, "timezoneOffset": ${timezoneOffset}, "timezoneName": "${timezoneName}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/api/v2/attendance/records     data=${punch_in_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        Should Not Be Empty    ${json_response}
    END

Punch Out
    [Documentation]    This keywords add a Punch Out
    ...    
    ...    This keyword adds a Punch Out in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Punch Out   |     cookie=cookie   |     date=2024-09-09   |     time=18:20   |     note   |     timezoneOffset   |     timezoneName   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${date}   ${time}    ${note}=null    ${timezoneOffset}=-3    ${timezoneName}=America/Sao_Paulo
    ${punch_in_form_data}   Set Variable   {"date": "${date}", "time": "${time}", "note": ${note}, "timezoneOffset": ${timezoneOffset}, "timezoneName": "${timezoneName}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/api/v2/attendance/records     data=${punch_in_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        Should Not Be Empty    ${json_response}
    END

Attendance Configuration
    [Documentation]    This keywords configure the user attendance
    ...    
    ...    This keyword allows the user to manipulate the attendance.
    ...    
    ...    Example:
    ...    | Attendance Configuration   |     cookie=cookie   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}
    ${punch_in_form_data}   Set Variable   {"canUserChangeCurrentTime": true, "canUserModifyAttendance": true, "canSupervisorModifyAttendance": true}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   PUT On Session    alias=ORANGE    url=/api/v2/attendance/configs     data=${punch_in_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        Should Not Be Empty    ${json_response}
    END