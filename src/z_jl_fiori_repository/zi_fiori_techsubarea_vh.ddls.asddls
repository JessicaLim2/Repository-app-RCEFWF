@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Technical subarea value help of fiori repository'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FIORI_TECHSUBAREA_VH as select from zdt_tech_subarea
//zdt_subarea_rep
{
    //key tech_area,
    @EndUserText.label: 'Technical Subarea'
    key tech_subarea
}where tech_area = 'Fiori'
