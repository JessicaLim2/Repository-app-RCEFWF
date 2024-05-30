@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of interface repository'

define root view entity ZI_INTERFACE as select from zdt_interface
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
    interface as Interface,
    multiple_variant,
    iflow as IFlow,
    integration_dom,
    integration_sty,
    integration_pat,
    sender as Sender,
    receiver as Receiver,
    communication as Communication,
    technology as Technology,
    sender_format,
    receiver_format,
    mapping as Mapping,
    sender_sec,
    receiver_sec,
    sender_type,
    receiver_type,
    
  //  concat('javascript:window.open("https://www.google.com")','') as NavSPURL
    concat('javascript:window.open(sharepoint_url)','') as NavSPURL,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_pipo_hide,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_cpi_hide,
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_INTERFACE_HIDE'
//    cast('' as abap.char(1)) as uict_rfc_hide,
    adapter,
    function_module,
    upload_flag,
    statcode,
    locallastchangedat
   // ,_InterfaceItem
}
