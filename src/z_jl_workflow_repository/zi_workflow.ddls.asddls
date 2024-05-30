@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of workflow repository'

define root view entity ZI_WORKFLOW as select from zdt_workflow
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
  //  workflow,
    workflow_temp,
    sap_build_proj,
    workflow_file_type,
    method,
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
    upload_flag,
    statcode,
    locallastchangedat
}
