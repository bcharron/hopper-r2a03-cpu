#!/usr/bin/python

#    This file is part of hopper-r2a03-cpu.
#
#    hopper-r2a03-cpu is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    hopper-r2a03-cpu is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with hopper-r2a03-cpu.  If not, see <http://www.gnu.org/licenses/>.


import sys

# struct r2a3_inst {
#     char mnemonic[3];
#     uint8_t number;
#     bool isBranch;
#     enum r2a3_addressing_modes addr_mode;
#     uint8_t len;
# };


#OPCODES[0x60] = Opcode("RTS", 1, False, Addressing.NONE)

BRANCHES = {
	"BPL" : 0x10,
	"BMI" : 0x30,
	"BVC" : 0x50,
	"BVS" : 0x70,
	"BCC" : 0x90,
	"BCS" : 0xB0,
	"BNE" : 0xD0,
	"BEQ" : 0xF0
}

opcodes = []

BAD_OPCODE = "/* 0x{code} */ {{ \"BAD\", 0x{code}, TRUE, AM_IMPLIED, 1 }}"

for i in range(0,256):
	opcodes.append(BAD_OPCODE.format(code = "%02X" % i))

for line in sys.stdin:
	addrMode = "UNKNOWN"
	inst = "N/A"
	value = -1
	lenz = 0

	if line.startswith("Zero Page,X"):
		fields = line.split()
		inst = fields[2]
		value = int(fields[4].lstrip("$"), 16)
		lenz = fields[5]

		addrMode = "AM_ZERO_PAGE_X"

	elif line.startswith("Zero Page"):
		fields = line.split()
		inst = fields[2]
		value = int(fields[4].lstrip("$"), 16)
		lenz = fields[5]

		# print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.ZERO_PAGE)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_ZERO_PAGE, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_ZERO_PAGE"
	elif line.startswith("Immediate"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.IMMEDIATE)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_IMMEDIATE, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_IMMEDIATE"
	elif line.startswith("Absolute,X"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.ABSOLUTE_X)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_ABSOLUTE_X, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_ABSOLUTE_X"
	elif line.startswith("Absolute"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.ABSOLUTE)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_ABSOLUTE, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_ABSOLUTE"
	elif line.startswith("Indirect,X"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.INDIRECT_X)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_INDIRECT_X, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_INDIRECT_X"
	elif line.startswith("Indirect,Y"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.INDIRECT_Y)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_INDIRECT_Y, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)
		addrMode = "AM_INDIRECT_Y"
	elif line.startswith("Indirect"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]
		addrMode = "AM_INDIRECT"
	elif line.startswith("Implied"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[2].lstrip("$"), 16)
		lenz = fields[3]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.NONE)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_IMPLIED, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)

		addrMode = "AM_IMPLIED"
	elif line.startswith("Accumulator"):
		fields = line.split()
		inst = fields[1]
		value = int(fields[3].lstrip("$"), 16)
		lenz = fields[4]

		#print "OPCODES[0x%02X] = Opcode(\"%s\", %s, False, Addressing.NONE)" % ( value, inst, lenz )
		#print "{{ \"{name}\", 0x{code}, FALSE, AM_IMPLIED, {len} }}, // 0x{code}".format(name = inst, code = "%02X" % value, len = lenz)

		addrMode = "AM_ACCUMULATOR"

	if value > 0:
		opcodes[value] = "/* 0x{code} */ {{ \"{name}\", 0x{code}, FALSE, {addrMode}, {len} }}".format(name = inst, code = "%02X" % value, len = lenz, addrMode = addrMode)

for inst in BRANCHES.keys():
	value = BRANCHES[inst]
	lenz = 2

	opcodes[value] = "/* 0x{code} */ {{ \"{name}\", 0x{code}, TRUE, AM_IMMEDIATE, {len} }}".format(name = inst, code = "%02X" % value, len = lenz)

opcodes[0x00] = "/* 0x00 */ { \"BRK\", 0x00, FALSE, AM_IMPLIED, 1 }"

# Flag stuff
opcodes[0x18] = "/* 0x18 */ { \"CLC\", 0x18, FALSE, AM_IMPLIED, 1 }"
opcodes[0x38] = "/* 0x38 */ { \"SEC\", 0x38, FALSE, AM_IMPLIED, 1 }"
opcodes[0x58] = "/* 0x58 */ { \"CLI\", 0x58, FALSE, AM_IMPLIED, 1 }"
opcodes[0x78] = "/* 0x78 */ { \"SEI\", 0x78, FALSE, AM_IMPLIED, 1 }"
opcodes[0xB8] = "/* 0xB8 */ { \"CLV\", 0xB8, FALSE, AM_IMPLIED, 1 }"
opcodes[0xD8] = "/* 0xD8 */ { \"CLD\", 0xD8, FALSE, AM_IMPLIED, 1 }"
opcodes[0xF8] = "/* 0xF8 */ { \"SED\", 0xF8, FALSE, AM_IMPLIED, 1 }"

# Register instructions
opcodes[0xAA] = "/* 0xAA */ { \"TAX\", 0xAA, FALSE, AM_IMPLIED, 1 }"
opcodes[0x8A] = "/* 0x8A */ { \"TXA\", 0x8A, FALSE, AM_IMPLIED, 1 }"
opcodes[0xCA] = "/* 0xCA */ { \"DEX\", 0xCA, FALSE, AM_IMPLIED, 1 }"
opcodes[0xE8] = "/* 0xE8 */ { \"INX\", 0xE8, FALSE, AM_IMPLIED, 1 }"
opcodes[0xA8] = "/* 0xA8 */ { \"TAY\", 0xA8, FALSE, AM_IMPLIED, 1 }"
opcodes[0x98] = "/* 0x98 */ { \"TYA\", 0x98, FALSE, AM_IMPLIED, 1 }"
opcodes[0x88] = "/* 0x88 */ { \"DEY\", 0x88, FALSE, AM_IMPLIED, 1 }"
opcodes[0xC8] = "/* 0xC8 */ { \"INY\", 0xC8, FALSE, AM_IMPLIED, 1 }"

# Stack instructions
opcodes[0x9A] = "/* 0x9A */ { \"TXS\", 0x9A, FALSE, AM_IMPLIED, 1 }"
opcodes[0xBA] = "/* 0xBA */ { \"TSX\", 0xBA, FALSE, AM_IMPLIED, 1 }"
opcodes[0x48] = "/* 0x48 */ { \"PHA\", 0x48, FALSE, AM_IMPLIED, 1 }"
opcodes[0x68] = "/* 0x68 */ { \"PLA\", 0x68, FALSE, AM_IMPLIED, 1 }"
opcodes[0x08] = "/* 0x08 */ { \"PHP\", 0x08, FALSE, AM_IMPLIED, 1 }"
opcodes[0x28] = "/* 0x28 */ { \"PLP\", 0x28, FALSE, AM_IMPLIED, 1 }"

#print """#ifdef __OPCODES_H
#define __OPCODES_H

print "struct r2a3_inst R2A03_INSTRUCTIONS[] = {"

print ",\n".join(opcodes)

print "};"
#print "#endif"

