@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of report repository'

define root view entity ZI_REPORT as select from zdt_report
//composition [0..*] of ZI_INTERFACE_ITEM as _InterfaceItem
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
    report_name,
  //  concat('javascript:window.open("https://www.google.com")','') as NavSPURL
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_pipo_hide,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_cpi_hide,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_rfc_hide,
    upload_flag,
    statcode,
    locallastchangedat
   // ,_InterfaceItem
}
