.macro  jeq     Target
        .if     .match(Target, 0)
        bne     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        beq     Target
        .else
        bne     *+5
        jmp     Target
        .endif
.endmacro
.macro  jne     Target
        .if     .match(Target, 0)
        beq     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bne     Target
        .else
        beq     *+5
        jmp     Target
        .endif
.endmacro
.macro  jmi     Target
        .if     .match(Target, 0)
        bpl     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bmi     Target
        .else
        bpl     *+5
        jmp     Target
        .endif
.endmacro
.macro  jpl     Target
        .if     .match(Target, 0)
        bmi     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bpl     Target
        .else
        bmi     *+5
        jmp     Target
        .endif
.endmacro
.macro  jcs     Target
        .if     .match(Target, 0)
        bcc     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bcs     Target
        .else
        bcc     *+5
        jmp     Target
        .endif
.endmacro
.macro  jcc     Target
        .if     .match(Target, 0)
        bcs     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bcc     Target
        .else
        bcs     *+5
        jmp     Target
        .endif
.endmacro
.macro  jvs     Target
        .if     .match(Target, 0)
        bvc     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bvs     Target
        .else
        bvc     *+5
        jmp     Target
        .endif
.endmacro
.macro  jvc     Target
        .if     .match(Target, 0)
        bvs     *+5
        jmp     Target
        .elseif .def(Target) .and ((*+2)-(Target) <= 127)
        bvc     Target
        .else
        bvs     *+5
        jmp     Target
        .endif
.endmacro