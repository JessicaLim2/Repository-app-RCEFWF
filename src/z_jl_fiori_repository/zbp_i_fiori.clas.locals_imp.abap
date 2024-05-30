CLASS lhc_ZI_FIORI DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_fiori RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_fiori RESULT result.

    METHODS draftToActive FOR MODIFY
      IMPORTING keys FOR ACTION zi_fiori~draftToActive RESULT result.

    METHODS setDefaultTechArea FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_fiori~setDefaultTechArea.

    METHODS validateClientProj FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateClientProj.

    METHODS validateDeveloper FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateDeveloper.

    METHODS validateFunctional FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateFunctional.

    METHODS validateModuleName FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateModuleName.

    METHODS validateProject FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateProject.

    METHODS validateTechSubarea FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_fiori~validateTechSubarea.

ENDCLASS.

CLASS lhc_ZI_FIORI IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD draftToActive.
*   Modify the entities with required fields.
    MODIFY ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
      UPDATE FIELDS ( statcode )
          WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                          statcode ='MASS' ) ).

*   Check if there are any draft instances?
    DATA(lt_draft_docs) = keys.
    DELETE lt_draft_docs WHERE %is_draft = if_abap_behv=>mk-off.

    IF lt_draft_docs IS NOT INITIAL.

* EXECUTE Active only on draft instances.

        MODIFY ENTITIES OF ZI_FIORI IN LOCAL MODE
          ENTITY zi_fiori
            EXECUTE Activate FROM
            VALUE #( FOR key IN keys ( %key = key-%key ) )
          REPORTED DATA(activate_fioried)
          FAILED DATA(activate_failed)
          MAPPED DATA(activate_mapped).

   ENDIF.

* Change Keys to read active Instance
    DATA(lt_keys) = keys.
    LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>).
      <ls_key>-%is_draft = if_abap_behv=>mk-off.
    ENDLOOP.

* Read the active instance to send back to Fiori App.
    READ ENTITIES OF ZI_FIORI IN LOCAL MODE
        ENTITY zi_fiori
        ALL FIELDS WITH CORRESPONDING #( lt_keys )
        RESULT DATA(lt_fiori).

*    result = VALUE #( FOR ls_repository IN lt_repository ( %tky   = ls_repository-%tky
*                                                   %param = CORRESPONDING #( ls_repository ) ) ).

    result = VALUE #( for ls_fiori in lt_fiori ( %tky-%key = ls_fiori-%key
                                                      %tky-uuid = ls_fiori-uuid
                                                      %tky-%is_draft = if_abap_behv=>mk-on
                                                      %key = ls_fiori-%key
                                                      %param = CORRESPONDING #( ls_fiori ) ) ).
* Populate %key , %tky  to be filled from source instance while %param-%key to be filled from new instance.
*    result = VALUE #( for <fs_old_key> in keys
*                      for <fs_new_key> IN lt_keys WHERE ( UUID = <Fs_old_key>-UUID )
*                                                    ( %key = <fs_old_key>-%key
*                                                      %tky = <fs_old_key>-%tky
*                                                      %param-%key = <fs_new_key>-%key ) ).

    mapped-zi_fiori = CORRESPONDING #( lt_fiori ).
  ENDMETHOD.

  METHOD setDefaultTechArea.
*   no need to change active to draft instance even if im using on save. NOTE: tech area cannot be key field
    MODIFY ENTITIES OF zi_fiori IN LOCAL MODE
            ENTITY zi_fiori
            UPDATE FIELDS ( tech_area ) WITH VALUE #(
            FOR key IN keys (
                              %key = key-%key
                              %is_draft = key-%is_draft
*%tky = key-%tky
*                              %is_draft = if_abap_behv=>mk-off
                              tech_area = 'Fiori'
                              %control = VALUE #( tech_area = if_abap_behv=>mk-on ) ) )
*
**    %tky-uuid = key-uuid %tky-%key = key-%key %key = key-%key
**    INDEX INTO i
**
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_fioried).

    READ ENTITIES OF zi_fiori IN LOCAL MODE
        ENTITY zi_fiori
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_fiori).
  ENDMETHOD.

  METHOD validateClientProj.
  " Read relevant project instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( client_prj ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_clientproj_temp TYPE SORTED TABLE OF zdt_clientpj_rep WITH UNIQUE KEY client_proj.

    " Optimization of DB select: extract distinct non-initial project
    lt_clientproj_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING client_proj = client_prj EXCEPT * ).
    DELETE lt_clientproj_temp WHERE client_proj IS INITIAL.
    IF lt_clientproj_temp IS NOT INITIAL.
    " Check if project exist
      SELECT FROM zdt_clientpj_rep FIELDS client_proj
        FOR ALL ENTRIES IN @lt_clientproj_temp
        WHERE client_proj = @lt_clientproj_temp-client_proj
        INTO TABLE @DATA(lt_clientproj).
    ENDIF.

    " Raise msg for non existing and initial project
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_CLIENTPJ' )
        TO reported-zi_fiori.

      IF lwa_fiori-client_prj IS INITIAL OR NOT line_exists( lt_clientproj[ client_proj = lwa_fiori-client_prj ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_CLIENTPJ'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Client'
                                              v2 = lwa_fiori-client_prj
                                              severity = if_abap_behv_message=>severity-error )
                         %element-client_prj = if_abap_behv=>mk-on )
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDeveloper.
  " Read relevant developer instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( developer ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_Developer_temp TYPE SORTED TABLE OF zdt_consultant WITH UNIQUE KEY consultant.

    " Optimization of DB select: extract distinct non-initial developer
    lt_Developer_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING consultant = developer EXCEPT * ).
    DELETE lt_Developer_temp WHERE consultant IS INITIAL.
    IF lt_Developer_temp IS NOT INITIAL.
    " Check if developer exist
      SELECT FROM zdt_consultant FIELDS consultant
        FOR ALL ENTRIES IN @lt_Developer_temp
        WHERE consultant = @lt_Developer_temp-consultant
        INTO TABLE @DATA(lt_Developer).
    ENDIF.

    " Raise msg for non existing and initial developer
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_DEVELOPER' )
        TO reported-zi_fiori.

      IF lwa_fiori-developer IS NOT INITIAL AND NOT line_exists( lt_Developer[ consultant = lwa_fiori-developer ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_DEVELOPER'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Developer'
                                              v2 = lwa_fiori-developer
                                              severity = if_abap_behv_message=>severity-error )
                         %element-developer = if_abap_behv=>mk-on ) "display fieldname that is triggering the error
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateFunctional.
  " Read relevant functional instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( functional ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_Function_temp TYPE SORTED TABLE OF zdt_consultant WITH UNIQUE KEY consultant.

    " Optimization of DB select: extract distinct non-initial functional
    lt_Function_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING consultant = functional EXCEPT * ).
    DELETE lt_Function_temp WHERE consultant IS INITIAL.
    IF lt_Function_temp IS NOT INITIAL.
    " Check if functional exist
      SELECT FROM zdt_consultant FIELDS consultant
        FOR ALL ENTRIES IN @lt_Function_temp
        WHERE consultant = @lt_Function_temp-consultant
        INTO TABLE @DATA(lt_Function).
    ENDIF.

    " Raise msg for non existing and initial functional
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_FUNCTIONAL' )
        TO reported-zi_fiori.

      IF lwa_fiori-functional IS NOT INITIAL AND NOT line_exists( lt_Function[ consultant = lwa_fiori-functional ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_FUNCTIONAL'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Functional'
                                              v2 = lwa_fiori-functional
                                              severity = if_abap_behv_message=>severity-error )
                         %element-functional = if_abap_behv=>mk-on ) "display fieldname that is triggering the error
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateModuleName.
  " Read relevant module instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( module_name ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_moduleName_temp TYPE SORTED TABLE OF zdt_module_rep WITH UNIQUE KEY module_name.

    " Optimization of DB select: extract distinct non-initial module
    lt_moduleName_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING module_name = module_name EXCEPT * ).
    DELETE lt_moduleName_temp WHERE module_name IS INITIAL.
    IF lt_moduleName_temp IS NOT INITIAL.
    " Check if module exist
      SELECT FROM zdt_module_rep FIELDS module_name
        FOR ALL ENTRIES IN @lt_moduleName_temp
        WHERE module_name = @lt_moduleName_temp-module_name
        INTO TABLE @DATA(lt_moduleName).
    ENDIF.

    " Raise msg for non existing and initial module
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_MODULENAME' )
        TO reported-zi_fiori.

      IF lwa_fiori-module_name IS NOT INITIAL AND NOT line_exists( lt_moduleName[ module_name = lwa_fiori-module_name ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_MODULENAME'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Module Name'
                                              v2 = lwa_fiori-module_name
                                              severity = if_abap_behv_message=>severity-error )
                         %element-module_name = if_abap_behv=>mk-on ) "display fieldname that is triggering the error
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateProject.
  " Read relevant project instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( project ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_project_temp TYPE SORTED TABLE OF zdt_project_rep WITH UNIQUE KEY project.

    " Optimization of DB select: extract distinct non-initial project
    lt_project_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING project = project EXCEPT * ).
    DELETE lt_project_temp WHERE project IS INITIAL.
    IF lt_project_temp IS NOT INITIAL.
    " Check if project exist
      SELECT FROM zdt_project_rep FIELDS project
        FOR ALL ENTRIES IN @lt_project_temp
        WHERE project = @lt_project_temp-project
        INTO TABLE @DATA(lt_project).
    ENDIF.

    " Raise msg for non existing and initial project
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_PROJECT' )
        TO reported-zi_fiori.

      IF lwa_fiori-project IS INITIAL OR NOT line_exists( lt_project[ project = lwa_fiori-project ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_PROJECT'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Project'
                                              v2 = lwa_fiori-project
                                              severity = if_abap_behv_message=>severity-error )
                         %element-project = if_abap_behv=>mk-on )
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateTechSubarea.
  " Read relevant project instance data
    READ ENTITIES OF zi_fiori IN LOCAL MODE
      ENTITY zi_fiori
        FIELDS ( tech_subarea ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fiori).

    DATA lt_techSubarea_temp TYPE SORTED TABLE OF zdt_tech_subarea WITH UNIQUE KEY tech_subarea.

    " Optimization of DB select: extract distinct non-initial project
    lt_techSubarea_temp = CORRESPONDING #( lt_fiori DISCARDING DUPLICATES MAPPING tech_subarea = tech_subarea EXCEPT * ).
    DELETE lt_techSubarea_temp WHERE tech_subarea IS INITIAL.
    IF lt_techSubarea_temp IS NOT INITIAL.
    " Check if project exist
      SELECT FROM zdt_tech_subarea FIELDS tech_subarea
        FOR ALL ENTRIES IN @lt_techSubarea_temp
        WHERE tech_area = 'Fiori' AND tech_subarea = @lt_techSubarea_temp-tech_subarea
        INTO TABLE @DATA(lt_techSubarea).
    ENDIF.

    " Raise msg for non existing and initial project
    LOOP AT lt_fiori INTO DATA(lwa_fiori).
    " Clear state messages that might exist
      APPEND VALUE #(  %tky        = lwa_fiori-%tky
                       %state_area = 'VALIDATE_TECHSUBAREA' )
        TO reported-zi_fiori.

      IF lwa_fiori-tech_subarea IS INITIAL OR NOT line_exists( lt_techSubarea[ tech_subarea = lwa_fiori-tech_subarea ] ).
        APPEND VALUE #(  %tky = lwa_fiori-%tky ) TO failed-zi_fiori.

        APPEND VALUE #(  %tky        = lwa_fiori-%tky
                         %state_area = 'VALIDATE_TECHSUBAREA'
                         %msg = new_message(  id = 'Z_MSG_REPOSITORY'
                                              number   = '001' " &1 unknown
                                              v1 = 'Technical Subarea'
                                              v2 = lwa_fiori-tech_subarea
                                              severity = if_abap_behv_message=>severity-error )
                         %element-tech_subarea = if_abap_behv=>mk-on )
          TO reported-zi_fiori.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
