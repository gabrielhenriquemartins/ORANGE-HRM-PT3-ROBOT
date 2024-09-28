*** Settings ***
Resource   ../variables_and_libraries.robot

*** Keywords ***
Find professional
    [Documentation]    Test to find a professional in the directory menu.
    ...    
    ...    Arguments: professional
    ...    
    ...    Example:
    ...    |     Directory - Find professional  |   first_name=Gabriel | last_name=Martins   |
    ...    
    ...    Dependency: Must be at Directory menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                      | First Name |    Last Name   |
    ...    | Directory - Find professional       | Gabriel    |    Martins     |
    ...    
    [Arguments]    ${first_name}    ${last_name}
    Fill Text    ${autocomplete}    ${first_name}
    ${custom_professional}   Replace String    ${custom_autocomplete}    custom    ${first_name}${SPACE}${SPACE}${last_name}
    Click     ${custom_professional}
    Click     ${bt_submit}
    Click     ${professional}
    Get Element States    ${professional_right}