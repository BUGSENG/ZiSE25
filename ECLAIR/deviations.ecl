# Project-wide deviations for temp_alert

## General deviations

-file_tag+={application_files,"^.*/ZiSe25/ZiSe25/(src|inc)/.*$"}
-source_files+={hide, "!application_files"}

-reports+={adopted, "all_area(all_loc(file(!application_files)))"}

-doc_begin="These functions do not store the address of the local variable."
-call_properties+={"name(tm1637_write_segments)",
                   {"taken()"}
}
-call_properties+={"name(display_write)",
                   {"taken()"}
}
-doc_end

## Guideline-specific tailoring

-config=MC4.R5.10,reports+={adopted, "any_area(any_loc(any_exp(macro(name(LOG_MODULE_DECLARE||Z_LOG2)))))"}

-doc_begin="Allow pointers of non-character type as long as the pointee is const-qualified."
-config=MC4.R7.4,same_pointee=false
-doc_end

-doc_begin="Allow Zephyr macros to be not MISRA compliant."
-config=MC4.R10.1,reports+={adopted, "any_area(any_loc(any_exp(macro(name(LOG_MODULE_DECLARE||LOG_ERR||z_tmcvt_divisor)))))"}
-doc_end

-doc_begin="Assigning the address of a function having the noreturn attribute to
a function pointer without the attribute is safe, as it does not change the ABI and semantics."
-config=MC4.R11.1,casts+={safe,
  "kind(bitcast)&&
   to(type(pointer(inner(return(builtin(void))&&all_param(1..3, pointer(builtin(void)))))))&&
   from(expr(skip(!syntactic(),ref(property(noreturn)))))"
}
-doc_end

-config=MC4.R20.7,arg_expansion={safe, safe}

-remap_rtag={adopted, hide}
