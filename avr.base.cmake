#**************************************************************************************************
#*
#* Copyright Zygmunt Ptak <zygmuntptak@gmail.com> All Rights Reserved.
#*
#* Reviewed
#*
#*/

function(set_if varname value)
    if(NOT DEFINED ${varname})
        set(${varname} ${value} PARENT_SCOPE)
    endif()
endfunction()


