@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tech subarea VH of interface repository app'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TECHSUBAREA_VH as select from zdt_tech_subarea
//zdt_subarea_int
{
    @EndUserText.label: 'Technical Subarea'
    key tech_subarea
}where tech_area = 'Interface'
