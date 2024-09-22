*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    String
Library    OperatingSystem
Library    Collections
Library    JSONLibrary

*** Variables ***
${csrf_token_start}    token="&quot;
${csrf_token_end}      &quot
${username}            "Admin"
${password}            "admin123"

*** Keywords ***
Login With Authentication
    [Documentation]    This keywords Login With Authentication

    ...    This keyword login into the application and return the cookies to be reused
    ...    for further requests.
    ...    
    ...    | Login With Authentication   |
    ...    
    ...    Author: Gabriel Martins
    Delete All Sessions
    Create Session    alias=ORANGE   url=https://opensource-demo.orangehrmlive.com/

    ${response}   GET On Session      alias=ORANGE   url=web/index.php/auth/login    expected_status=200

    ${csrf_token_right}    Fetch From Right    ${response.text}           ${csrf_token_start}
    ${csrf_token}          Fetch From Left     ${csrf_token_right}        ${csrf_token_end}

    Should Not Be Empty    ${csrf_token}
    Log To Console    CSRF TOKEN: ${csrf_token}

    ${set_cookie}=    Get From Dictionary    ${response.headers}    Set-Cookie

    ${cookie_header_right}    Fetch From Right   ${set_cookie}            :${SPACE} 
    ${cookie_header}          Fetch From Left    ${cookie_header_right}   ; p 
    Log To Console    Set-Cookie: ${cookie_header}

    ${header}   Create Dictionary header   set_cookie=${cookie_header}   content_type=application/x-www-form-urlencoded
    ${data}=    Set Variable    {"_token": "${csrf_token}", "username": ${username}, "password": ${password}}
    ${json_data}=     Convert String To Json    ${data}

    ${resp}   POST On Session    alias=ORANGE    url=web/index.php/auth/validate     data=${json_data}     headers=${header}    expected_status=200
    Return From Keyword      ${cookie_header}

Create Dictionary header
    [Documentation]    This keywords Create a Dictionary header

    ...    This keyword create a header with cookies and content-type to be reused
    ...    for further requests.
    ...    
    ...    | Create Dictionary header   |   set_cookie=cookies   |   content_type  |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]   ${set_cookie}   ${content_type}=application/json  
    ${header}     Create Dictionary    Connection=keep-alive    Content-Type=${content_type}    Cookies=${set_cookie}
    Return From Keyword     ${header}
