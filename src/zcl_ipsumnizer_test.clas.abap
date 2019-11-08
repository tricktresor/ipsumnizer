class ZCL_IPSUMNIZER_TEST definition
  public
  create public .

public section.

  types:
    BEGIN OF ts_belegnummer,
             vbeln TYPE vbeln,
             submi TYPE submi,
             erdat TYPE erdat,
             ernam TYPE ernam,
           END OF ts_belegnummer .
  types:
    tt_belegtabelle TYPE SORTED TABLE OF ts_belegnummer WITH UNIQUE KEY vbeln .

  constants C_AUART_TA type AUART value 'TA' ##NO_TEXT.
  constants C_AUART_TAS type AUART value 'TAS' ##NO_TEXT.

  methods READ_DATA .
  methods GET_VORGANG
    returning
      value(RV_SUBMI) type SUBMI .
  methods SET_BELEGNUMMER
    importing
      !IV_PARAM type FLAG optional
      !IV_VBELN type VBELN .
  methods CHECK_CUSTOMER .
protected section.
private section.

  data BELEGNUMMER type VBELN .
  data VORGANG type SUBMI .
  data BELEGE type TT_BELEGTABELLE .
ENDCLASS.



CLASS ZCL_IPSUMNIZER_TEST IMPLEMENTATION.


  method CHECK_CUSTOMER.
  endmethod.


  METHOD get_vorgang.
    rv_submi = me->vorgang.
  ENDMETHOD.


  METHOD read_data.



  ENDMETHOD.


  METHOD set_belegnummer.

    IF iv_param IS INITIAL AND belegnummer IS INITIAL.
      belegnummer = iv_vbeln.
    ELSEIF iv_param IS NOT INITIAL.
      belegnummer = iv_vbeln.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
