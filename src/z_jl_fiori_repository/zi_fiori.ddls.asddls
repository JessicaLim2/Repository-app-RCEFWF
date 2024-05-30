@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of fiori repository'

define root view entity ZI_FIORI as select from zdt_fiori
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
    ui_repository,
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
    upload_flag,
    statcode,
    locallastchangedat
}
