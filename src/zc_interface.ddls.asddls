@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of interface repository'
@UI.headerInfo: { typeName: 'Interface', typeNamePlural: 'Interface', 
         title: { type: #STANDARD } }
define root view entity ZC_INTERFACE as projection on ZI_INTERFACE as Interface
{
    @UI.facet: [
         {
               label : 'General',
               id : 'Interface',
               purpose: #STANDARD,
               type : #COLLECTION,
               position: 10
           },
           {
             //  label: 'Header',
               id : 'Header',
               purpose: #STANDARD,
               parentId : 'Interface',
               type : #FIELDGROUP_REFERENCE,
               targetQualifier : 'Header',
               position: 20
           },
           {
               label : 'Detail',
               id : 'DetailColl',
               purpose: #STANDARD,
               type : #COLLECTION,
               position: 20,
               hidden: #(UICT_DETAIL_HIDE)
           },
           {
               label: 'Detail',
               id : 'Detail',
               purpose: #STANDARD,
               parentId : 'DetailColl',
               type : #FIELDGROUP_REFERENCE,
               targetQualifier : 'Detail',
               position: 10
           }
     //      ,
     //      {   id: 'InterfaceItem',
     //          purpose: #STANDARD,
     //          type: #LINEITEM_REFERENCE,
     //          label: 'Interface Item',
     //          position: 20,
     //          targetElement: '_InterfaceItem'}
//           {
//               label : 'CPI',
//               id : 'CPIColl',
//               purpose: #STANDARD,
//               type : #COLLECTION,
//               position: 30,
//               hidden: #(UICT_CPI_HIDE)
//           },
//           {
//               label: 'CPI',
//               id : 'CPI',
//               purpose: #STANDARD,
//               parentId : 'CPIColl',
//               type : #FIELDGROUP_REFERENCE,
//               targetQualifier : 'CPI',
//               position: 10
//           },
//           {
//               label : 'RFC',
//               id : 'RFCColl',
//               purpose: #STANDARD,
//               type : #COLLECTION,
//               position: 40,
//               hidden: #(UICT_RFC_HIDE)
//           },
//           {
//               label: 'RFC',
//               id : 'RFC',
//               purpose: #STANDARD,
//               parentId : 'RFCColl',
//               type : #FIELDGROUP_REFERENCE,
//               targetQualifier : 'RFC',
//               position: 10
//           }
           ]
                 
//   @UI.lineItem: [{ label: 'UUID' }]
   @EndUserText.label: 'UUID'
    key UUID,
//    @UI: {  lineItem:   [ { position: 1 , label: 'Technical Area' }]}
    tech_area,
    @UI: {  lineItem:   [ { position: 10 , label: 'Technical Subarea' } ],
            fieldGroup: [{ position: 10, label:'Technical Subarea', qualifier: 'Header'}]}
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_TECHSUBAREA_VH', 
                                         element: 'tech_subarea' } }]
 //   @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_TECH_VH', 
 //                                        element: 'technology' } }]
////    @Consumption.filter.hidden: true         only hide the field in main page adapt filters                         
    @EndUserText.label: 'Technical Subarea'   
    tech_subarea,
    @UI: {  lineItem:   [ { position: 20 , label: 'Client' } ],
            fieldGroup: [{ position: 20, label:'Client', qualifier: 'Header'}],
            selectionField: [ { position: 10 }] }
    //from z_jl       
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_CLIENTPROJECT_VH', 
                                        element: 'client_proj' } }]
    @EndUserText.label: 'Client'        
    client_prj,
    @UI: {  lineItem:   [ { position: 30 , label: 'Project' } ],
            fieldGroup: [{ position: 30, label:'Project', qualifier: 'Header'}],
          selectionField: [ { position: 30 }] }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_PROJECT_VH', element: 'project' },
    additionalBinding: [{ localElement: 'client_prj', element: 'client_prj' }]}]
    @EndUserText.label: 'Project'
    Project,
    @UI: {  lineItem:   [ { position: 40, label: 'Module'  } ],
            fieldGroup: [{ position: 40, label:'Module', qualifier: 'Header' }],
            selectionField: [ { position: 40 }] }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_MODULE_VH', 
                                         element: 'module_name' } }]
    @EndUserText.label: 'Module'
    module_name,
    
    @UI: {  lineItem:   [ { position: 50, label: 'Priority'  } ],
            fieldGroup: [{ position: 50, label:'Priority', qualifier: 'Header' }],
            selectionField: [ { position: 50 }] }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_PRIORITY_VH', 
                                         element: 'priority' } }]
    @EndUserText.label: 'Priority'
    priority,
    @UI: {  lineItem:   [ { position: 60, label: 'Complexity'  } ],
            fieldGroup: [{ position: 60, label:'Complexity', qualifier: 'Header' }],
            selectionField: [ { position: 60 }] }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_COMPLEXITY_VH', 
                                         element: 'complexity' } }]
    @EndUserText.label: 'Complexity'
    complexity,
    @UI: {  lineItem:   [ { position: 70, label: 'Estimated Manday'  } ],
            fieldGroup: [{ position: 70, label:'Estimated Manday', qualifier: 'Header' }],
            selectionField: [ { position: 70 }] }
    //from z_jl
//    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_MODULE_VH', 
//                                         element: 'module_name' } }]
    @EndUserText.label: 'Estimated Manday'
    estimated_manday,
    @UI: {  lineItem:   [ { position: 80, label: 'Approved Manday'  } ],
            fieldGroup: [{ position: 80, label:'Approved Manday', qualifier: 'Header' }],
            selectionField: [ { position: 80 }] }
    //from z_jl
//    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_MODULE_VH', 
//                                         element: 'module_name' } }]
    @EndUserText.label: 'Approved Manday'
    approved_manday,
    @UI: {  lineItem:   [ { position: 90, label: 'Developer'  } ],
            fieldGroup: [{ position: 90, label:'Developer', qualifier: 'Header' }],
            selectionField: [ { position: 90 }] }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_CONSULTANT_VH', 
                                         element: 'consultant' } }]
    @EndUserText.label: 'Developer'
    Developer,
    @UI: {  lineItem:   [ { position: 100, label: 'Functional'  } ],
            fieldGroup: [{ position: 100, label:'Functional', qualifier: 'Header' }],
            selectionField: [ { position: 100 }] }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_CONSULTANT_VH', 
                                         element: 'consultant' } }]
    @EndUserText.label: 'Functional'
    Functional,
    @UI: {  lineItem:   [ { position: 110, label: 'RICEFW ID'  } ],
            fieldGroup: [{ position: 110, label:'RICEFW ID', qualifier: 'Header' }],
            selectionField: [ { position: 110 }] }
    @EndUserText.label: 'RICEFW ID'
    ricefw_id,
    @UI: {  lineItem:   [ { position: 120, label: 'RICEFW Description'  } ],
            fieldGroup: [{ position: 120, label:'RICEFW Description', qualifier: 'Header' }],
            selectionField: [ { position: 120 }] }
    @EndUserText.label: 'RICEFW Description'
    ricefw_desc,
    @UI: {  lineItem:       [ { position: 130, label: 'Sharepoint URL',
                                type: #WITH_URL, url: 'sharepoint_url'  } ],
            fieldGroup: [{ position: 130, label:'Sharepoint URL', qualifier: 'Header' }],
            selectionField: [ { position: 130 }] }
    @EndUserText.label: 'Sharepoint URL'
    sharepoint_url,
    @UI: {  lineItem:       [ { position: 140, label: 'Reference' } ],
            fieldGroup: [{ position: 140, label:'Reference', qualifier: 'Header' }],
            selectionField: [ { position: 140 }] }
    @EndUserText.label: 'Reference'
    reference,
    
    @UI: {  lineItem:   [ { position: 150, label: 'IFlow Name'  } ],
            fieldGroup: [{ position: 20, label:'IFlow', qualifier: 'Detail' }]
         }
    @EndUserText.label: 'IFlow Name'
    IFlow,
    @UI: {  lineItem:   [ { position: 140, label: 'Integration Domain'  } ],
            fieldGroup: [{ position: 30, label:'Integration Domain', qualifier: 'Detail' }]
         }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_INTEGRATION_DOM_VH', 
                                         element: 'integration_dom' } }]
    @EndUserText.label: 'Integration Domain'
    integration_dom,
    @UI: {  lineItem:   [ { position: 160, label: 'Integration Style'  } ],
            fieldGroup: [{ position: 40, label:'Integration Style', qualifier: 'Detail' }]
         }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_INTEGRATION_STY_VH', 
                                         element: 'integration_sty' } }]
    @EndUserText.label: 'Integration Style'
    integration_sty,
    @UI: {  lineItem:       [ { position: 170, label: 'Integration Use Case Pattern'  } ],
            fieldGroup: [{ position: 50, label:'Integration Pattern', qualifier: 'Detail' }]
         }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_INTEGRATION_PATT_VH', element: 'integration_pat' },
    additionalBinding: [{ localElement: 'integration_sty', element: 'integration_sty' }]}]
    @EndUserText.label: 'Integration Use Case Pattern'
    integration_pat,
    @UI: {  lineItem:       [ { position: 180, label: 'Sender System'  } ],
            fieldGroup: [{ position: 60, label:'Sender System', qualifier: 'Detail' }]
         }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_SYSTEM_VH', 
                                         element: 'syst' } }]
    @EndUserText.label: 'Sender System'
    Sender,
    @UI: {  lineItem:   [ { position: 190, label: 'Receiver System'  } ],
            fieldGroup: [{ position: 70, label:'Receiver System', qualifier: 'Detail' }]
          }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_SYSTEM_VH', 
                                         element: 'syst' } }]
    @EndUserText.label: 'Receiver System'
    Receiver,
    @UI: {  lineItem:       [ { position: 200, label: 'Interface Mode'  } ],
            fieldGroup: [{ position: 80, label:'Interface Mode', qualifier: 'Detail' }]
         }
    //from z_jl 
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_COMMUNICATION_VH', 
                                         element: 'communication' } }]
    @EndUserText.label: 'Interface Mode'
    Communication,
 //   @UI: {  lineItem:       [ { position: 120, label: 'Integration Technology'  } ],
 //           fieldGroup: [{ position: 90, label:'Technology', qualifier: 'Detail' }]
 //         }
 //   @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_TECH_VH', 
 //                                        element: 'technology' } }]
 //   @EndUserText.label: 'Integration Technology'
 //   Technology,
    @UI: {  lineItem:       [ { position: 210, label: 'Sender Data Format'  } ],
            fieldGroup: [{ position: 100, label:'Sender Data Format', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_DATAFORMAT_VH', 
                                         element: 'data_format' } }]
    @EndUserText.label: 'Sender Data Format'
    sender_format,
    @UI: {  lineItem:       [ { position: 220, label: 'Receiver Data Format'  } ],
            fieldGroup: [{ position: 110, label:'Receiver Data Format', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_DATAFORMAT_VH', 
                                         element: 'data_format' } }]
    @EndUserText.label: 'Receiver Data Format'
    receiver_format,
    @UI: {  lineItem:       [ { position: 230, label: 'Mapping'  } ],
            fieldGroup: [{ position: 120, label:'Mapping', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_MAPPING_VH', 
                                         element: 'mapping' } }]
    //@Consumption.filter.multipleSelections: true
    @EndUserText.label: 'Mapping'
    Mapping,
    @UI: {  lineItem:       [ { position: 240, label: 'Sender Security'  } ],
            fieldGroup: [{ position: 130, label:'Sender Security', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_SECURITY_VH', 
                                         element: 'security' } }]
    @EndUserText.label: 'Sender Security'
    sender_sec,
    @UI: {  lineItem:       [ { position: 250, label: 'Receiver Security'  } ],
            fieldGroup: [{ position: 140, label:'Receiver Security', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_SECURITY_VH', 
                                         element: 'security' } }]
    @EndUserText.label: 'Receiver Security'
    receiver_sec,
    @UI: {  lineItem:       [ { position: 260, label: 'Sender Integration Type'  } ],
            fieldGroup: [{ position: 150, label:'Sender Integration Type', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_INTEGRATION_TYPE_VH', 
                                         element: 'integration_type' } }]
    @EndUserText.label: 'Sender Integration Type'
    sender_type,
    @UI: {  lineItem:   [ { position: 270, label: 'Receiver Integration Type'  } ],
            fieldGroup: [{ position: 160, label:'Receiver Integration Type', qualifier: 'Detail' }]
         }
    //from z_jl
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_INTEGRATION_TYPE_VH', 
                                         element: 'integration_type' } }]
    @EndUserText.label: 'Receiver Integration Type'
    receiver_type,
    @UI: {  lineItem:   [ { position: 280, label: 'Multiple Variant'  } ],
            fieldGroup: [{ position: 190, label:'Multiple Variant', qualifier: 'Detail' }]
         }
    @EndUserText.label: 'Multiple Variant'
   // @Consumption.valueHelpDefinition: [{ entity:{name: 'ZDT_SUBAREA_INT', 
   //                                      element: 'tech_subarea' } }]
    multiple_variant,
    
    
    NavSPURL,
    
//    uict_pipo_hide,
//    uict_cpi_hide,
//    uict_rfc_hide,
 //   @UI: {  fieldGroup: [{ position: 290, label:'Adapter', qualifier: 'Detail' }]}
 //   @EndUserText.label: 'Adapter'
 //   adapter,
 //   @UI: {  fieldGroup: [{ position: 300, label:'Function Module', qualifier: 'Detail' }]}
 //   @EndUserText.label: 'Function Module'
 //   function_module,
    upload_flag,
    @UI.lineItem: [{ position: 2, label: 'Draft To Active' ,type: #FOR_ACTION, dataAction: 'draftToActive'}]
 //   @UI.lineItem: [{ position: 2, label: 'draft To Active'}]
    statcode,
    locallastchangedat
    //,_InterfaceItem : redirected to composition child ZC_INTERFACE_ITEM
    
}
