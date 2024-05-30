@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of conversion repository'

define root view entity ZI_CONVERSION as select from zdt_conversion
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
    abap_prog,
    lsmw_proj,
    lsmw_subproj,
    lsmw_obj,
    ltmc_mig,
    bods_proj,
    file_type,
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
    upload_flag,
    statcode,
    locallastchangedat
}
