REPORT zipsumnizer_prototype.

" Status read class
* ipsonize method name

PARAMETERS p_prefix AS CHECKBOX DEFAULT 'X'. "Leave prefixes (LV_, IV_, MC_, C_, ...)
PARAMETERS p_sign   AS CHECKBOX DEFAULT space.
PARAMETERS p_class TYPE seoclskey  DEFAULT 'ZCL_IPSUMNIZER_TEST'.

CLASS lcl_ipsum DEFINITION.
  PUBLIC SECTION.
    METHODS get RETURNING VALUE(word) TYPE string.
    METHODS constructor.

  PROTECTED SECTION.
    DATA wordlist TYPE string_table.
    DATA rnd TYPE REF TO cl_abap_random_int.
ENDCLASS.
CLASS lcl_ipsum IMPLEMENTATION.
  METHOD constructor.
    wordlist = VALUE #(
          ( `AT` )
          ( `LOREM` )
          ( `STET` )
          ( `ACCUSAM` )
          ( `ALIQUYAM` )
          ( `AMET` )
          ( `CLITA` )
          ( `CONSETETUR` )
          ( `DIAM` )
          ( `DOLOR` )
          ( `DOLORE` )
          ( `DOLORES` )
          ( `DUO` )
          ( `EA` )
          ( `ERIMOD` )
          ( `ELITRA` )
          ( `EOS` )
          ( `ERAT` )
          ( `EST` )
          ( `ET` )
          ( `GUBERGREN` )
          ( `INVIDUNT` )
          ( `IPSUM` )
          ( `JUSTO` )
          ( `KASD` )
          ( `LABORE` )
          ( `MAGNA` )
          ( `NO` )
          ( `NONUMY` )
          ( `REBUM` )
          ( `SADIPSCING` )
          ( `SANCTUS` )
          ( `SEA` )
          ( `SED` )
          ( `SIT` )
          ( `TAKIMATA` )
          ( `TEMPOR` )
          ( `UT` )
          ( `VERO` )
          ( `VOLUPTUA` )
         ).
    rnd = cl_abap_random_int=>create(
            seed = 111
            min  = 1
            max  = lines( wordlist ) ).

  ENDMETHOD.
  METHOD get.
    word = wordlist[ me->rnd->get_next( ) ].
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.


  DATA methodkey   TYPE  seocpdkey.
  DATA source_code TYPE  seop_source_string.
  DATA(ipsum) = NEW lcl_ipsum( ).
  DATA method_new TYPE seoclsname.
  DATA tnew TYPE string_table.

  DATA(class_flat) = NEW cl_oo_class_components_flat( p_class ).
  LOOP AT class_flat->methods INTO DATA(method).
    CLEAR method_new.
    CLEAR tnew.
    SPLIT method-cpdname AT '_' INTO TABLE DATA(torg).
    LOOP AT torg INTO DATA(lorg).
      CASE lorg.
        WHEN 'CHECK'
          OR 'GET'
          OR 'SET'
          OR 'SAVE'
          OR 'READ'.
          APPEND lorg TO tnew.
        WHEN OTHERS.
          APPEND ipsum->get( ) TO tnew.
      ENDCASE.
    ENDLOOP.

    LOOP AT tnew INTO DATA(lnew).
      IF method_new IS INITIAL.
        method_new = lnew.
      ELSE.
        CONCATENATE method_new '_' lnew INTO method_new.
      ENDIF.
    ENDLOOP.


*    WRITE: / method-cpdname, method-descript.
    WRITE: / method_new, method-descript.
    IF p_sign = abap_true.
      LOOP AT class_flat->parameters INTO DATA(signature)
      WHERE cpdname = method-cpdname.
        CASE signature-pardecltyp.
          WHEN '0'. "Importing
            WRITE: / 'imp'.
          WHEN '1'. "Exporting
            WRITE: / 'exp'.
          WHEN '2'. "Changing
            WRITE: / 'chg'.
          WHEN '3'. "Returning
            WRITE: / 'ret'.
        ENDCASE.
        WRITE: signature-sconame, signature-descript.
      ENDLOOP.
    ENDIF.

    methodkey-clsname = p_class.
    methodkey-cpdname = method-cpdname.
    CLEAR source_code.
    CALL FUNCTION 'SEO_METHOD_GET_SOURCE'
      EXPORTING
        mtdkey                        = methodkey
        state                         = 'A'
      IMPORTING
        source_expanded               = source_code
      EXCEPTIONS
        _internal_method_not_existing = 1
        _internal_class_not_existing  = 2
        version_not_existing          = 3
        inactive_new                  = 4
        inactive_deleted              = 5
        OTHERS                        = 6.
    IF sy-subrc = 0.
*      LOOP AT source_code INTO DATA(line).
*        WRITE: /5 line.
*      ENDLOOP.
    ENDIF.

  ENDLOOP.
