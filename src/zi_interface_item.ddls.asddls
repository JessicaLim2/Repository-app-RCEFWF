@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model of interface item repository'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_INTERFACE_ITEM as select from zdt_interf_item
//association to parent ZI_INTERFACE as _Interface     on  $projection.uuid = _Interface.UUID

{
    key interf_item_uuid,
    uuid,
    test_item,
    locallastchangedat
   // ,_Interface
}
