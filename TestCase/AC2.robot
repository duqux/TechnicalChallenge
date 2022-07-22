*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  SeleniumLibrary
Library  webdriver
Library  ChromeDriverManager

*** Variables ***
${url}  http://localhost:8080/

*** Test Cases ***
AC2_TC013
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    FOR  ${item}  IN  @{object}
    ${birthday} =  Set variable  ${item["birthday"]}
    ${gender} =   Set variable  ${item["gender"]}
    ${name} =   Set variable  ${item["name"]}
    ${natid} =   Set variable  ${item["natid"]}
    ${salary} =   Set variable  ${item["salary"]}
    ${tax} =   Set variable  ${item["tax"]}
    &{body} =  Create Dictionary  birthday=${birthday}  gender=${gender}  name=${name}  natid=${natid}  salary=${salary}  tax=${tax}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  202
    END

AC2_TC014 - TC023
    create session  AddData  ${url}
    ${json} =  Get file  Data/MutipleErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    FOR  ${item}  IN  @{object}
    ${birthday} =  Set variable  ${item["birthday"]}
    ${gender} =   Set variable  ${item["gender"]}
    ${name} =   Set variable  ${item["name"]}
    ${natid} =   Set variable  ${item["natid"]}
    ${salary} =   Set variable  ${item["salary"]}
    ${tax} =   Set variable  ${item["tax"]}
    &{body} =  Create Dictionary  birthday=${birthday}  gender=${gender}  name=${name}  natid=${natid}  salary=${salary}  tax=${tax}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500
    END
