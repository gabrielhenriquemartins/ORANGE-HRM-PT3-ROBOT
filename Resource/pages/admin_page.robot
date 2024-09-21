*** Settings ***
Resource    ../login.robot

*** Keywords ***
Add Job Title
    [Arguments]    ${job_name}   ${cookie}   
    ${job_form_data}   Set Variable   {"title": "${job_name}", "description": "My Description", "note": "My Note"}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   POST On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/job-titles     data=${job_form_data}       headers=${header}   expected_status=200
    ${json_response}             evaluate             json.loads('''${response.content}''')   json
    ${data}            Get From Dictionary    ${json_response}    data
    ${id}              Get From Dictionary    ${data}    id
    Log To Console     Job ID Created: ${id}
    Return From Keyword    ${id}

Delete Job Title
    [Arguments]    ${job_id}   ${cookie}
    ${job_del_data}   Set Variable   {"ids": ["${job_id}"]}
    ${header}     Create Dictionary header    set_cookie=${cookie}
    ${response}   DELETE On Session    alias=ORANGE    url=/web/index.php/api/v2/admin/job-titles     data=${job_del_data}       headers=${header}   expected_status=200
    Log To Console     Job ID Deleted: ${job_id}
