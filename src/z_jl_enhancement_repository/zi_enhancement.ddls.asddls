@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of enhancement repository'

define root view entity ZI_ENHANCEMENT as select from zdt_enhancement
{
    key uuid as UUID, // Make association public
    tech_area,
    tech_subarea,
    client_prj,
    project as Project,
    module_name,
    priority,
    complexity,
    estimated_manday,
    approved_manday,
    developer as Developer,
    functional as Functional,
    ricefw_id,
    ricefw_desc,
    sharepoint_url,
    reference,
    //function_module as 
    enhancement_name,
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
    upload_flag,
    statcode,
    locallastchangedat
}
