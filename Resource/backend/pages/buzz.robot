*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Post
    [Documentation]    This keywords add a post
    ...    
    ...    This keyword adds a Post in the OrangeHRM application.
    ...    
    ...    Example:
    ...    | Add Post   |     type=text   |     text=Hello World!   |     cookie=cookie   |     status=200   |
    ...    
    ...    Autor: Gabriel Martins
    [Arguments]   ${cookie}    ${status}   ${type}   ${text}
    ${buzz_form_data}   Set Variable   {"type": "${type}", "text": "${text}"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/buzz/posts     data=${buzz_form_data}       headers=${header}    expected_status=${status}
    IF    '${status}' == '200'
        ${json_response}             evaluate             json.loads('''${response.content}''')   json
        ${data}            Get From Dictionary    ${json_response}    data
        ${post}            Get From Dictionary    ${data}    post
        ${id}              Get From Dictionary    ${post}    id
        Log To Console     Post ID Created: ${id}
        Return From Keyword    ${id}
    END
    
Delete Post
    [Documentation]    This keywords delete a Post

    ...    This keyword deletes a Post in the OrangeHRM application.
    ...    
    ...    | Delete Post   |    post_id=123   |    cookie=cookie   |    status=200   |
    ...    
    ...    Author: Gabriel Martins
    [Arguments]    ${post_id}   ${cookie}    ${status}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${body}       Set Variable         {"id": ${post_id}}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/buzz/shares/${post_id}   data=${body}   headers=${header}   expected_status=${status}
    Log To Console     Post ID Deleted: ${post_id}
