@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of form repository'
@UI.headerInfo: { typeName: 'Form', typeNamePlural: 'Form', 
         title: { type: #STANDARD } }
define root view entity ZC_FORM as projection on ZI_FORM as Form
{
    @UI.facet: [
         {
               label : 'General',
               id : 'Report',
               purpose: #STANDARD,
               type : #COLLECTION,
               position: 10
           },
           {
             //  label: 'Header',
               id : 'Header',
               purpose: #STANDARD,
               parentId : 'Report',
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
           ]
                 
//   @UI.lineItem: [{ label: 'UUID' }]
   @EndUserText.label: 'UUID'
    key UUID,
//    @UI: {  lineItem:   [ { position: 1 , label: 'Technical Area' }]}
    tech_area,
    @UI: {  lineItem:   [ { position: 10 , label: 'Technical Subarea' } ],
            fieldGroup: [{ position: 10, label:'Technical Subarea', qualifier: 'Header'}]}
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_FORM_TECHSUBAREA_VH', 
                                         element: 'tech_subarea' } }]
 //   @Consumption.valueHelpDefinition: [{ entity:{name: 'ZI_TECH_VH', 
 //                                        element: 'technology' } }]
////    @Consumption.filter.hidden: true         only hide the field in main page adapt filters                         
    @EndUserText.label: 'Technical Subarea'
    
    tech_subarea,
    @UI: {  lineItem:   [ { position: 20 , label: 'Client' } ],
            fieldGroup: [{ position: 20, label:'Client', qualifier: 'Header'}],
            selectionField: [ { position: 1 }] }
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
//    @EndUserText.quickInfo: 'Project name'
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
    
    NavSPURL,
    @UI: {  lineItem:       [ { position: 130, label: 'Sharepoint URL',
                                type: #WITH_URL, url: 'sharepoint_url'  } ],
            fieldGroup: [{ position: 130, label:'Sharepoint URL', qualifier: 'Header' }],
            selectionField: [ { position: 130 }] }
    @EndUserText.label: 'Sharepoint URL'
    sharepoint_url,
    @UI: {  lineItem:       [ { position: 160, label: 'Reference' } ],
            fieldGroup: [{ position: 140, label:'Reference', qualifier: 'Header' }],
            selectionField: [ { position: 140 }] }
    @EndUserText.label: 'Reference'
    reference,
//    uict_pipo_hide,
//    uict_cpi_hide,
//    uict_rfc_hide,
    @UI: {  lineItem:       [ { position: 140, label: 'Form Name' } ],
            fieldGroup: [{ position: 140, label:'Form Name', qualifier: 'Detail' }],
            selectionField: [ { position: 140 }] }
    @EndUserText.label: 'Form Name'
    form_name,
    @UI: {  lineItem:       [ { position: 150, label: 'Print Program Name' } ],
            fieldGroup: [{ position: 150, label:'Print Program Name', qualifier: 'Detail' }],
            selectionField: [ { position: 150 }] }
    @EndUserText.label: 'Print Program Name'
    print_prog,
    upload_flag,
    @UI.lineItem: [{ position: 150, label: 'Draft To Active' ,type: #FOR_ACTION, dataAction: 'draftToActive'}]
 //   @UI.lineItem: [{ position: 2, label: 'draft To Active'}]
    statcode,
    locallastchangedat
    //,_ReportItem : redirected to composition child ZC_Report_ITEM
    
}
