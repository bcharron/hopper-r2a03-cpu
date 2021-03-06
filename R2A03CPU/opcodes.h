struct r2a3_inst R2A03_INSTRUCTIONS[] = {
/* 0x00 */ { "BRK", 0x00, FALSE, AM_IMPLIED, 1 },
/* 0x01 */ { "ORA", 0x01, FALSE, AM_INDIRECT_X, 2 },
/* 0x02 */ { "BAD", 0x02, TRUE, AM_IMPLIED, 1 },
/* 0x03 */ { "BAD", 0x03, TRUE, AM_IMPLIED, 1 },
/* 0x04 */ { "BAD", 0x04, TRUE, AM_IMPLIED, 1 },
/* 0x05 */ { "ORA", 0x05, FALSE, AM_ZERO_PAGE, 2 },
/* 0x06 */ { "ASL", 0x06, FALSE, AM_ZERO_PAGE, 2 },
/* 0x07 */ { "BAD", 0x07, TRUE, AM_IMPLIED, 1 },
/* 0x08 */ { "PHP", 0x08, FALSE, AM_IMPLIED, 1 },
/* 0x09 */ { "ORA", 0x09, FALSE, AM_IMMEDIATE, 2 },
/* 0x0A */ { "ASL", 0x0A, FALSE, AM_ACCUMULATOR, 1 },
/* 0x0B */ { "BAD", 0x0B, TRUE, AM_IMPLIED, 1 },
/* 0x0C */ { "BAD", 0x0C, TRUE, AM_IMPLIED, 1 },
/* 0x0D */ { "ORA", 0x0D, FALSE, AM_ABSOLUTE, 3 },
/* 0x0E */ { "ASL", 0x0E, FALSE, AM_ABSOLUTE, 3 },
/* 0x0F */ { "BAD", 0x0F, TRUE, AM_IMPLIED, 1 },
/* 0x10 */ { "BPL", 0x10, TRUE, AM_IMMEDIATE, 2 },
/* 0x11 */ { "ORA", 0x11, FALSE, AM_INDIRECT_Y, 2 },
/* 0x12 */ { "BAD", 0x12, TRUE, AM_IMPLIED, 1 },
/* 0x13 */ { "BAD", 0x13, TRUE, AM_IMPLIED, 1 },
/* 0x14 */ { "BAD", 0x14, TRUE, AM_IMPLIED, 1 },
/* 0x15 */ { "ORA", 0x15, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x16 */ { "ASL", 0x16, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x17 */ { "BAD", 0x17, TRUE, AM_IMPLIED, 1 },
/* 0x18 */ { "CLC", 0x18, FALSE, AM_IMPLIED, 1 },
/* 0x19 */ { "ORA", 0x19, FALSE, AM_ABSOLUTE, 3 },
/* 0x1A */ { "BAD", 0x1A, TRUE, AM_IMPLIED, 1 },
/* 0x1B */ { "BAD", 0x1B, TRUE, AM_IMPLIED, 1 },
/* 0x1C */ { "BAD", 0x1C, TRUE, AM_IMPLIED, 1 },
/* 0x1D */ { "ORA", 0x1D, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x1E */ { "ASL", 0x1E, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x1F */ { "BAD", 0x1F, TRUE, AM_IMPLIED, 1 },
/* 0x20 */ { "JSR", 0x20, FALSE, AM_ABSOLUTE, 3 },
/* 0x21 */ { "AND", 0x21, FALSE, AM_INDIRECT_X, 2 },
/* 0x22 */ { "BAD", 0x22, TRUE, AM_IMPLIED, 1 },
/* 0x23 */ { "BAD", 0x23, TRUE, AM_IMPLIED, 1 },
/* 0x24 */ { "BIT", 0x24, FALSE, AM_ZERO_PAGE, 2 },
/* 0x25 */ { "AND", 0x25, FALSE, AM_ZERO_PAGE, 2 },
/* 0x26 */ { "ROL", 0x26, FALSE, AM_ZERO_PAGE, 2 },
/* 0x27 */ { "BAD", 0x27, TRUE, AM_IMPLIED, 1 },
/* 0x28 */ { "PLP", 0x28, FALSE, AM_IMPLIED, 1 },
/* 0x29 */ { "AND", 0x29, FALSE, AM_IMMEDIATE, 2 },
/* 0x2A */ { "ROL", 0x2A, FALSE, AM_ACCUMULATOR, 1 },
/* 0x2B */ { "BAD", 0x2B, TRUE, AM_IMPLIED, 1 },
/* 0x2C */ { "BIT", 0x2C, FALSE, AM_ABSOLUTE, 3 },
/* 0x2D */ { "AND", 0x2D, FALSE, AM_ABSOLUTE, 3 },
/* 0x2E */ { "ROL", 0x2E, FALSE, AM_ABSOLUTE, 3 },
/* 0x2F */ { "BAD", 0x2F, TRUE, AM_IMPLIED, 1 },
/* 0x30 */ { "BMI", 0x30, TRUE, AM_IMMEDIATE, 2 },
/* 0x31 */ { "AND", 0x31, FALSE, AM_INDIRECT_Y, 2 },
/* 0x32 */ { "BAD", 0x32, TRUE, AM_IMPLIED, 1 },
/* 0x33 */ { "BAD", 0x33, TRUE, AM_IMPLIED, 1 },
/* 0x34 */ { "BAD", 0x34, TRUE, AM_IMPLIED, 1 },
/* 0x35 */ { "AND", 0x35, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x36 */ { "ROL", 0x36, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x37 */ { "BAD", 0x37, TRUE, AM_IMPLIED, 1 },
/* 0x38 */ { "SEC", 0x38, FALSE, AM_IMPLIED, 1 },
/* 0x39 */ { "AND", 0x39, FALSE, AM_ABSOLUTE, 3 },
/* 0x3A */ { "BAD", 0x3A, TRUE, AM_IMPLIED, 1 },
/* 0x3B */ { "BAD", 0x3B, TRUE, AM_IMPLIED, 1 },
/* 0x3C */ { "BAD", 0x3C, TRUE, AM_IMPLIED, 1 },
/* 0x3D */ { "AND", 0x3D, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x3E */ { "ROL", 0x3E, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x3F */ { "BAD", 0x3F, TRUE, AM_IMPLIED, 1 },
/* 0x40 */ { "RTI", 0x40, FALSE, AM_IMPLIED, 1 },
/* 0x41 */ { "EOR", 0x41, FALSE, AM_INDIRECT_X, 2 },
/* 0x42 */ { "BAD", 0x42, TRUE, AM_IMPLIED, 1 },
/* 0x43 */ { "BAD", 0x43, TRUE, AM_IMPLIED, 1 },
/* 0x44 */ { "BAD", 0x44, TRUE, AM_IMPLIED, 1 },
/* 0x45 */ { "EOR", 0x45, FALSE, AM_ZERO_PAGE, 2 },
/* 0x46 */ { "LSR", 0x46, FALSE, AM_ZERO_PAGE, 2 },
/* 0x47 */ { "BAD", 0x47, TRUE, AM_IMPLIED, 1 },
/* 0x48 */ { "PHA", 0x48, FALSE, AM_IMPLIED, 1 },
/* 0x49 */ { "EOR", 0x49, FALSE, AM_IMMEDIATE, 2 },
/* 0x4A */ { "LSR", 0x4A, FALSE, AM_ACCUMULATOR, 1 },
/* 0x4B */ { "BAD", 0x4B, TRUE, AM_IMPLIED, 1 },
/* 0x4C */ { "JMP", 0x4C, FALSE, AM_ABSOLUTE, 3 },
/* 0x4D */ { "EOR", 0x4D, FALSE, AM_ABSOLUTE, 3 },
/* 0x4E */ { "LSR", 0x4E, FALSE, AM_ABSOLUTE, 3 },
/* 0x4F */ { "BAD", 0x4F, TRUE, AM_IMPLIED, 1 },
/* 0x50 */ { "BVC", 0x50, TRUE, AM_IMMEDIATE, 2 },
/* 0x51 */ { "EOR", 0x51, FALSE, AM_INDIRECT_Y, 2 },
/* 0x52 */ { "BAD", 0x52, TRUE, AM_IMPLIED, 1 },
/* 0x53 */ { "BAD", 0x53, TRUE, AM_IMPLIED, 1 },
/* 0x54 */ { "BAD", 0x54, TRUE, AM_IMPLIED, 1 },
/* 0x55 */ { "EOR", 0x55, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x56 */ { "LSR", 0x56, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x57 */ { "BAD", 0x57, TRUE, AM_IMPLIED, 1 },
/* 0x58 */ { "CLI", 0x58, FALSE, AM_IMPLIED, 1 },
/* 0x59 */ { "EOR", 0x59, FALSE, AM_ABSOLUTE, 3 },
/* 0x5A */ { "BAD", 0x5A, TRUE, AM_IMPLIED, 1 },
/* 0x5B */ { "BAD", 0x5B, TRUE, AM_IMPLIED, 1 },
/* 0x5C */ { "BAD", 0x5C, TRUE, AM_IMPLIED, 1 },
/* 0x5D */ { "EOR", 0x5D, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x5E */ { "LSR", 0x5E, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x5F */ { "BAD", 0x5F, TRUE, AM_IMPLIED, 1 },
/* 0x60 */ { "RTS", 0x60, FALSE, AM_IMPLIED, 1 },
/* 0x61 */ { "ADC", 0x61, FALSE, AM_INDIRECT_X, 2 },
/* 0x62 */ { "BAD", 0x62, TRUE, AM_IMPLIED, 1 },
/* 0x63 */ { "BAD", 0x63, TRUE, AM_IMPLIED, 1 },
/* 0x64 */ { "BAD", 0x64, TRUE, AM_IMPLIED, 1 },
/* 0x65 */ { "ADC", 0x65, FALSE, AM_ZERO_PAGE, 2 },
/* 0x66 */ { "ROR", 0x66, FALSE, AM_ZERO_PAGE, 2 },
/* 0x67 */ { "BAD", 0x67, TRUE, AM_IMPLIED, 1 },
/* 0x68 */ { "PLA", 0x68, FALSE, AM_IMPLIED, 1 },
/* 0x69 */ { "ADC", 0x69, FALSE, AM_IMMEDIATE, 2 },
/* 0x6A */ { "ROR", 0x6A, FALSE, AM_ACCUMULATOR, 1 },
/* 0x6B */ { "BAD", 0x6B, TRUE, AM_IMPLIED, 1 },
/* 0x6C */ { "JMP", 0x6C, FALSE, AM_INDIRECT, 3 },
/* 0x6D */ { "ADC", 0x6D, FALSE, AM_ABSOLUTE, 3 },
/* 0x6E */ { "ROR", 0x6E, FALSE, AM_ABSOLUTE, 3 },
/* 0x6F */ { "BAD", 0x6F, TRUE, AM_IMPLIED, 1 },
/* 0x70 */ { "BVS", 0x70, TRUE, AM_IMMEDIATE, 2 },
/* 0x71 */ { "ADC", 0x71, FALSE, AM_INDIRECT_Y, 2 },
/* 0x72 */ { "BAD", 0x72, TRUE, AM_IMPLIED, 1 },
/* 0x73 */ { "BAD", 0x73, TRUE, AM_IMPLIED, 1 },
/* 0x74 */ { "BAD", 0x74, TRUE, AM_IMPLIED, 1 },
/* 0x75 */ { "ADC", 0x75, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x76 */ { "ROR", 0x76, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x77 */ { "BAD", 0x77, TRUE, AM_IMPLIED, 1 },
/* 0x78 */ { "SEI", 0x78, FALSE, AM_IMPLIED, 1 },
/* 0x79 */ { "ADC", 0x79, FALSE, AM_ABSOLUTE, 3 },
/* 0x7A */ { "BAD", 0x7A, TRUE, AM_IMPLIED, 1 },
/* 0x7B */ { "BAD", 0x7B, TRUE, AM_IMPLIED, 1 },
/* 0x7C */ { "BAD", 0x7C, TRUE, AM_IMPLIED, 1 },
/* 0x7D */ { "ADC", 0x7D, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x7E */ { "ROR", 0x7E, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x7F */ { "BAD", 0x7F, TRUE, AM_IMPLIED, 1 },
/* 0x80 */ { "BAD", 0x80, TRUE, AM_IMPLIED, 1 },
/* 0x81 */ { "STA", 0x81, FALSE, AM_INDIRECT_X, 2 },
/* 0x82 */ { "BAD", 0x82, TRUE, AM_IMPLIED, 1 },
/* 0x83 */ { "BAD", 0x83, TRUE, AM_IMPLIED, 1 },
/* 0x84 */ { "STY", 0x84, FALSE, AM_ZERO_PAGE, 2 },
/* 0x85 */ { "STA", 0x85, FALSE, AM_ZERO_PAGE, 2 },
/* 0x86 */ { "STX", 0x86, FALSE, AM_ZERO_PAGE, 2 },
/* 0x87 */ { "BAD", 0x87, TRUE, AM_IMPLIED, 1 },
/* 0x88 */ { "DEY", 0x88, FALSE, AM_IMPLIED, 1 },
/* 0x89 */ { "BAD", 0x89, TRUE, AM_IMPLIED, 1 },
/* 0x8A */ { "TXA", 0x8A, FALSE, AM_IMPLIED, 1 },
/* 0x8B */ { "BAD", 0x8B, TRUE, AM_IMPLIED, 1 },
/* 0x8C */ { "STY", 0x8C, FALSE, AM_ABSOLUTE, 3 },
/* 0x8D */ { "STA", 0x8D, FALSE, AM_ABSOLUTE, 3 },
/* 0x8E */ { "STX", 0x8E, FALSE, AM_ABSOLUTE, 3 },
/* 0x8F */ { "BAD", 0x8F, TRUE, AM_IMPLIED, 1 },
/* 0x90 */ { "BCC", 0x90, TRUE, AM_IMMEDIATE, 2 },
/* 0x91 */ { "STA", 0x91, FALSE, AM_INDIRECT_Y, 2 },
/* 0x92 */ { "BAD", 0x92, TRUE, AM_IMPLIED, 1 },
/* 0x93 */ { "BAD", 0x93, TRUE, AM_IMPLIED, 1 },
/* 0x94 */ { "STY", 0x94, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x95 */ { "STA", 0x95, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0x96 */ { "STX", 0x96, FALSE, AM_ZERO_PAGE, 2 },
/* 0x97 */ { "BAD", 0x97, TRUE, AM_IMPLIED, 1 },
/* 0x98 */ { "TYA", 0x98, FALSE, AM_IMPLIED, 1 },
/* 0x99 */ { "STA", 0x99, FALSE, AM_ABSOLUTE, 3 },
/* 0x9A */ { "TXS", 0x9A, FALSE, AM_IMPLIED, 1 },
/* 0x9B */ { "BAD", 0x9B, TRUE, AM_IMPLIED, 1 },
/* 0x9C */ { "BAD", 0x9C, TRUE, AM_IMPLIED, 1 },
/* 0x9D */ { "STA", 0x9D, FALSE, AM_ABSOLUTE_X, 3 },
/* 0x9E */ { "BAD", 0x9E, TRUE, AM_IMPLIED, 1 },
/* 0x9F */ { "BAD", 0x9F, TRUE, AM_IMPLIED, 1 },
/* 0xA0 */ { "LDY", 0xA0, FALSE, AM_IMMEDIATE, 2 },
/* 0xA1 */ { "LDA", 0xA1, FALSE, AM_INDIRECT_X, 2 },
/* 0xA2 */ { "LDX", 0xA2, FALSE, AM_IMMEDIATE, 2 },
/* 0xA3 */ { "BAD", 0xA3, TRUE, AM_IMPLIED, 1 },
/* 0xA4 */ { "LDY", 0xA4, FALSE, AM_ZERO_PAGE, 2 },
/* 0xA5 */ { "LDA", 0xA5, FALSE, AM_ZERO_PAGE, 2 },
/* 0xA6 */ { "LDX", 0xA6, FALSE, AM_ZERO_PAGE, 2 },
/* 0xA7 */ { "BAD", 0xA7, TRUE, AM_IMPLIED, 1 },
/* 0xA8 */ { "TAY", 0xA8, FALSE, AM_IMPLIED, 1 },
/* 0xA9 */ { "LDA", 0xA9, FALSE, AM_IMMEDIATE, 2 },
/* 0xAA */ { "TAX", 0xAA, FALSE, AM_IMPLIED, 1 },
/* 0xAB */ { "BAD", 0xAB, TRUE, AM_IMPLIED, 1 },
/* 0xAC */ { "LDY", 0xAC, FALSE, AM_ABSOLUTE, 3 },
/* 0xAD */ { "LDA", 0xAD, FALSE, AM_ABSOLUTE, 3 },
/* 0xAE */ { "LDX", 0xAE, FALSE, AM_ABSOLUTE, 3 },
/* 0xAF */ { "BAD", 0xAF, TRUE, AM_IMPLIED, 1 },
/* 0xB0 */ { "BCS", 0xB0, TRUE, AM_IMMEDIATE, 2 },
/* 0xB1 */ { "LDA", 0xB1, FALSE, AM_INDIRECT_Y, 2 },
/* 0xB2 */ { "BAD", 0xB2, TRUE, AM_IMPLIED, 1 },
/* 0xB3 */ { "BAD", 0xB3, TRUE, AM_IMPLIED, 1 },
/* 0xB4 */ { "LDY", 0xB4, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xB5 */ { "LDA", 0xB5, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xB6 */ { "LDX", 0xB6, FALSE, AM_ZERO_PAGE, 2 },
/* 0xB7 */ { "BAD", 0xB7, TRUE, AM_IMPLIED, 1 },
/* 0xB8 */ { "CLV", 0xB8, FALSE, AM_IMPLIED, 1 },
/* 0xB9 */ { "LDA", 0xB9, FALSE, AM_ABSOLUTE, 3 },
/* 0xBA */ { "TSX", 0xBA, FALSE, AM_IMPLIED, 1 },
/* 0xBB */ { "BAD", 0xBB, TRUE, AM_IMPLIED, 1 },
/* 0xBC */ { "LDY", 0xBC, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xBD */ { "LDA", 0xBD, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xBE */ { "LDX", 0xBE, FALSE, AM_ABSOLUTE, 3 },
/* 0xBF */ { "BAD", 0xBF, TRUE, AM_IMPLIED, 1 },
/* 0xC0 */ { "CPY", 0xC0, FALSE, AM_IMMEDIATE, 2 },
/* 0xC1 */ { "CMP", 0xC1, FALSE, AM_INDIRECT_X, 2 },
/* 0xC2 */ { "BAD", 0xC2, TRUE, AM_IMPLIED, 1 },
/* 0xC3 */ { "BAD", 0xC3, TRUE, AM_IMPLIED, 1 },
/* 0xC4 */ { "CPY", 0xC4, FALSE, AM_ZERO_PAGE, 2 },
/* 0xC5 */ { "CMP", 0xC5, FALSE, AM_ZERO_PAGE, 2 },
/* 0xC6 */ { "DEC", 0xC6, FALSE, AM_ZERO_PAGE, 2 },
/* 0xC7 */ { "BAD", 0xC7, TRUE, AM_IMPLIED, 1 },
/* 0xC8 */ { "INY", 0xC8, FALSE, AM_IMPLIED, 1 },
/* 0xC9 */ { "CMP", 0xC9, FALSE, AM_IMMEDIATE, 2 },
/* 0xCA */ { "DEX", 0xCA, FALSE, AM_IMPLIED, 1 },
/* 0xCB */ { "BAD", 0xCB, TRUE, AM_IMPLIED, 1 },
/* 0xCC */ { "CPY", 0xCC, FALSE, AM_ABSOLUTE, 3 },
/* 0xCD */ { "CMP", 0xCD, FALSE, AM_ABSOLUTE, 3 },
/* 0xCE */ { "DEC", 0xCE, FALSE, AM_ABSOLUTE, 3 },
/* 0xCF */ { "BAD", 0xCF, TRUE, AM_IMPLIED, 1 },
/* 0xD0 */ { "BNE", 0xD0, TRUE, AM_IMMEDIATE, 2 },
/* 0xD1 */ { "CMP", 0xD1, FALSE, AM_INDIRECT_Y, 2 },
/* 0xD2 */ { "BAD", 0xD2, TRUE, AM_IMPLIED, 1 },
/* 0xD3 */ { "BAD", 0xD3, TRUE, AM_IMPLIED, 1 },
/* 0xD4 */ { "BAD", 0xD4, TRUE, AM_IMPLIED, 1 },
/* 0xD5 */ { "CMP", 0xD5, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xD6 */ { "DEC", 0xD6, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xD7 */ { "BAD", 0xD7, TRUE, AM_IMPLIED, 1 },
/* 0xD8 */ { "CLD", 0xD8, FALSE, AM_IMPLIED, 1 },
/* 0xD9 */ { "CMP", 0xD9, FALSE, AM_ABSOLUTE, 3 },
/* 0xDA */ { "BAD", 0xDA, TRUE, AM_IMPLIED, 1 },
/* 0xDB */ { "BAD", 0xDB, TRUE, AM_IMPLIED, 1 },
/* 0xDC */ { "BAD", 0xDC, TRUE, AM_IMPLIED, 1 },
/* 0xDD */ { "CMP", 0xDD, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xDE */ { "DEC", 0xDE, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xDF */ { "BAD", 0xDF, TRUE, AM_IMPLIED, 1 },
/* 0xE0 */ { "CPX", 0xE0, FALSE, AM_IMMEDIATE, 2 },
/* 0xE1 */ { "SBC", 0xE1, FALSE, AM_INDIRECT_X, 2 },
/* 0xE2 */ { "BAD", 0xE2, TRUE, AM_IMPLIED, 1 },
/* 0xE3 */ { "BAD", 0xE3, TRUE, AM_IMPLIED, 1 },
/* 0xE4 */ { "CPX", 0xE4, FALSE, AM_ZERO_PAGE, 2 },
/* 0xE5 */ { "SBC", 0xE5, FALSE, AM_ZERO_PAGE, 2 },
/* 0xE6 */ { "INC", 0xE6, FALSE, AM_ZERO_PAGE, 2 },
/* 0xE7 */ { "BAD", 0xE7, TRUE, AM_IMPLIED, 1 },
/* 0xE8 */ { "INX", 0xE8, FALSE, AM_IMPLIED, 1 },
/* 0xE9 */ { "SBC", 0xE9, FALSE, AM_IMMEDIATE, 2 },
/* 0xEA */ { "NOP", 0xEA, FALSE, AM_IMPLIED, 1 },
/* 0xEB */ { "BAD", 0xEB, TRUE, AM_IMPLIED, 1 },
/* 0xEC */ { "CPX", 0xEC, FALSE, AM_ABSOLUTE, 3 },
/* 0xED */ { "SBC", 0xED, FALSE, AM_ABSOLUTE, 3 },
/* 0xEE */ { "INC", 0xEE, FALSE, AM_ABSOLUTE, 3 },
/* 0xEF */ { "BAD", 0xEF, TRUE, AM_IMPLIED, 1 },
/* 0xF0 */ { "BEQ", 0xF0, TRUE, AM_IMMEDIATE, 2 },
/* 0xF1 */ { "SBC", 0xF1, FALSE, AM_INDIRECT_Y, 2 },
/* 0xF2 */ { "BAD", 0xF2, TRUE, AM_IMPLIED, 1 },
/* 0xF3 */ { "BAD", 0xF3, TRUE, AM_IMPLIED, 1 },
/* 0xF4 */ { "BAD", 0xF4, TRUE, AM_IMPLIED, 1 },
/* 0xF5 */ { "SBC", 0xF5, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xF6 */ { "INC", 0xF6, FALSE, AM_ZERO_PAGE_X, 2 },
/* 0xF7 */ { "BAD", 0xF7, TRUE, AM_IMPLIED, 1 },
/* 0xF8 */ { "SED", 0xF8, FALSE, AM_IMPLIED, 1 },
/* 0xF9 */ { "SBC", 0xF9, FALSE, AM_ABSOLUTE, 3 },
/* 0xFA */ { "BAD", 0xFA, TRUE, AM_IMPLIED, 1 },
/* 0xFB */ { "BAD", 0xFB, TRUE, AM_IMPLIED, 1 },
/* 0xFC */ { "BAD", 0xFC, TRUE, AM_IMPLIED, 1 },
/* 0xFD */ { "SBC", 0xFD, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xFE */ { "INC", 0xFE, FALSE, AM_ABSOLUTE_X, 3 },
/* 0xFF */ { "BAD", 0xFF, TRUE, AM_IMPLIED, 1 }
};
