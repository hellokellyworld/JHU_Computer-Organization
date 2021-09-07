# a list with one instruction
instructions = ['00000001101011100101100000100100']

# dictionary of opcodes
op_codes = {'000000': 'R-type'}

# dictionary of function codes
func_codes = {'100100': 'and'}

# dictionary of registers
registers = {'01101': '$t5'}

# get the first 6 bits (opcode) of the first instruction (index 0)
opcode = instructions[0][0:6]

# get the instruction format
if opcode == '000000':
    print('This is an R-type instruction.');

    # parse the instruction according to the R-type format

    # 1.  get the 6-bit function code using string slicing
    func_code = instructions[0][26:32]
    print('Function code (binary): ' + func_code)

    # 2.  look up the function code in the dictionary
    print('MIPS Instruction: ' + func_codes[func_code])

    # 3.  get the 5 bit RS register and look it up in the dictionary
    register = instructions[0][6:11]
    print('Register:  ' + registers[register])

    # 4.  get the 5 bit RT register and look it up in the dictionary

    # 5.  get the 5 bit RD register and look it up in the dictionary

    # 6.  print the instruction with the operands
