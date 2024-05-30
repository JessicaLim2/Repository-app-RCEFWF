@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of form repository'

define root view entity ZI_FORM as select from zdt_form
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
    reference,
    sharepoint_url,
    form_name,
    print_prog,
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
    upload_flag,
    statcode,
    locallastchangedat
}
