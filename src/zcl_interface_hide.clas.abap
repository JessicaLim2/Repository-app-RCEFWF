CLASS zcl_interface_hide DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces  IF_SADL_EXIT_CALC_ELEMENT_READ.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INTERFACE_HIDE IMPLEMENTATION.


METHOD if_sadl_exit_calc_element_read~calculate.
  FIELD-SYMBOLS: <lv_data>     TYPE any,
                 <lv_data2>    TYPE any.

   LOOP AT it_original_data ASSIGNING <lv_data>.
* Set index
     ASSIGN COMPONENT 'tech_subarea' OF STRUCTURE <lv_data> TO <lv_data2>.
      IF <lv_data2> IS ASSIGNED AND <lv_data2> <> ''.

        DATA(lv_index) = sy-tabix.

*         "Hide PIPO Collection
         ASSIGN COMPONENT to_upper( 'UICT_INTEG_HIDE' )  OF STRUCTURE ct_calculated_data[ lv_index ] TO FIELD-SYMBOL(<lv_integ>).
         IF <lv_integ> IS ASSIGNED.
            IF <lv_data2> = 'FIORI' OR <lv_data2> = 'FORM'.
*           abap_true means hide
                <lv_integ> = abap_true.
            ELSE.
                <lv_integ> = abap_false.
            ENDIF.
         ENDIF.

         "Hide CPI Collection
         ASSIGN COMPONENT to_upper( 'UICT_FIORI_HIDE' )  OF STRUCTURE ct_calculated_data[ lv_index ] TO FIELD-SYMBOL(<lv_fiori>).
         IF <lv_fiori> IS ASSIGNED.
            IF <lv_data2> = 'INTEG' OR <lv_data2> = 'FORM'.
*             abap_true means hide
               <lv_fiori> = abap_true.
            ELSE.
               <lv_fiori> = abap_false.
            ENDIF.
         ENDIF.

         "Hide RFC Collection
         ASSIGN COMPONENT to_upper( 'UICT_FORM_HIDE' )  OF STRUCTURE ct_calculated_data[ lv_index ] TO FIELD-SYMBOL(<lv_form>).
         IF <lv_form> IS ASSIGNED.
            IF <lv_data2> = 'INTEG' OR <lv_data2> = 'FIORI'.
*           abap_true means hide
                <lv_form> = abap_true.
            ELSE.
                <lv_form> = abap_false.
            ENDIF.
         ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity EQ 'ZI_INTERFACE'.
*      INSERT |UICT_PIPO_HIDE| INTO TABLE et_requested_orig_elements.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
