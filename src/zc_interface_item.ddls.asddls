@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view of interface item repository'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI: {
  headerInfo: { typeName: 'Interface Item',
                typeNamePlural: 'Interface Item'//,
              //  title: { type: #STANDARD, value: 'BookingID' } 
               } 
     }
define view entity ZC_INTERFACE_ITEM as projection on ZI_INTERFACE_ITEM as InterfaceItem
{
 @UI.facet: [ { id:            'InterfaceItem',
                 purpose:       #STANDARD,
                 type:          #IDENTIFICATION_REFERENCE,
                 label:         'Interface Item',
                 position:      10 }  ]

 @UI: {  lineItem:   [ { position: 1 , label: 'Item UUID' } ],
         identification: [{ position: 1, label:'Item UUID'}]}
    key interf_item_uuid,
    @UI: {  lineItem:   [ { position: 2 , label: 'UUID' } ],
         identification: [{ position: 2, label:'UUID'}]}
    uuid,
    @UI: {  lineItem:   [ { position: 3 , label: 'Item field' } ],
         identification: [{ position: 3, label:'Item field'}]}
    test_item
  //  ,_Interface : redirected to parent ZC_INTERFACE
}
