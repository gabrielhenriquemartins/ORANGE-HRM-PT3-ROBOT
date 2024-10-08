*** Settings ***
Resource   variables_and_libraries.robot
Resource   login.robot

*** Keywords ***
Open Left Menu
    [Documentation]    General keyword used to open the left menu.
    ...    
    ...    Arguments: menu
    ...    
    ...    Example:
    ...    |     Open Left Menu  |   menu=Maintenance   |
    ...    
    ...    Dependency: Must be at the home page.
    ...    
    [Arguments]    ${menu}
    Reload
    ${custom_menu}   Replace String    ${custom_span}    custom    ${menu}
    Click    ${custom_menu}

Check Toast Message
    [Documentation]    General keyword used to check the toast pop-up.
    ...    
    ...    Arguments: message
    ...    
    ...    Example:
    ...    |     Check Toast Message  |   mmessage=Successfully Saved   |
    ...    
    ...    Dependency: Must be executed after an operation that generate a toast.
    ...    
    ...    Minimum Case:
    ...    |Open Left Menu      |   Claim              |
    ...    |Create an Event     |   Event Test         |
    ...    |Check Toast Message |   Successfully Saved |
    ...    
    [Arguments]   ${message}
    ${custom_toast}   Replace String    ${custom_toast_msg}    custom    ${message}
    Wait Until Keyword Succeeds    3x    2s     Get Element States    ${custom_toast}   validate    value & visible

Select Sub Menu
    [Documentation]    General keyword used to open a Sub Menu
    ...    
    ...    Arguments: menu, sub_menu, url
    ...    
    ...    Example:
    ...    |     Select Sub Menu  |   menu=Job   |   sub_menu=Job Titles   |   endpoint=Expected Endpoint
    ...    
    ...    Dependency: Must be at the home page, and the page should contain sub-menus visible.
    ...    
    [Arguments]   ${menu}    ${sub_menu}=none   ${endpoint}=none
    ${custom_menu}    Replace String    ${custom_menu}    custom    ${menu}
    Click     ${custom_menu}
    IF    '${sub_menu}' != 'none'
        ${custom_submenu}    Replace String    ${custom_submenu}    custom    ${sub_menu}
        Click     ${custom_submenu}
    END
    IF    '${endpoint}' != 'none'
        ${current_url}     Get Url    
        Should Be Equal As Strings    ${current_url}    ${URL}/${endpoint}
    END

Delete Item
    [Documentation]    Delete Item
    ...    
    ...    Arguments: None
    ...    
    ...    Example:
    ...    |    Delete Item     |
    Click      ${bin}
    Click    ${warning_alert}
    
Validate and Click Button
    [Documentation]    General keyword used to Validade an element and click in a button
    ...    
    ...    Arguments: to_validate, button
    ...    
    ...    Example:
    ...    |     Validate and Click Button  |   to_validate=${element}   |   button=${bt_submit}   |
    ...     
    [Arguments]    ${to_validate}    ${button}
    ${status}    Run Keyword And Return Status    Get Element States   ${to_validate}         validate    value & visible    
    IF    '${status}' != 'True'
        Click     ${button}
    END
    Wait Until Keyword Succeeds   3x   2s     Get Element States   ${to_validate}         validate    value & visible    

Find Checkbox
    [Documentation]    General keyword used to find a checkbox
    ...    
    ...    After the element is located, the keyword return the ID of the element.
    ...
    ...    Arguments: text
    ...    
    ...    Example:
    ...    |     Find Checkbox  |   text=Aroldo   |
    ...    
    ...    Dependency: The page must contain a table
    ...   
    [Arguments]   ${text}     ${start_count}=1    ${step}=1
    Wait until keyword Succeeds   5x   5s  Get Element States    (${general_table})[1]    validate    value & visible    
    ${count}    Get Element Count    ${general_table}
    FOR    ${i}    IN RANGE    ${start_count}    ${count}    ${step}
        ${table_text}   Get Text    (${general_table})[${i}]     
        IF    '${table_text}' == '${text}'
            Return From Keyword    ${i}
            Exit For Loop
        END 
    END

Verify Pdf Uploaded
    [Documentation]    Verify if a file name exist in the page.
    ...    
    ...    Arguments: pdf_name
    ...    
    ...    Example:
    ...    |    Verify Pdf Uploaded     |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu    |   Claim        |
    ...    | Submit Claim      |   Party        |   Canadian Dollar  |
    ...    | Add PDF File      |
    ...    | Verify Pdf Uploaded   |
    ...    
    [Arguments]    ${pdf_name}
    ${custom_pdf_name}   Replace String    ${custom_pdf}    custom    ${pdf_name}
    Get Element States    ${custom_pdf_name}

Maintenance Password
    [Documentation]    Do not use this keyword alone, it is part of the Candidate Records KW.
    Fill Text    ${password}    admin123
    Click    ${bt_submit}
