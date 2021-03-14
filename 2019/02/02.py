with open("input") as file:
    data = [int(num) for num in file.read().split(',')]

def run_program(memory, noun, verb):
    memory[1], memory[2] = noun, verb
    for i in range(0, len(memory), 4):
        opcode, num1, num2, location = memory[i: i + 4]
        if opcode == 99:
            break
        elif opcode == 1:
            memory[location] = memory[num1] + memory[num2]
        elif opcode == 2:
            memory[location] = memory[num1] * memory[num2]
    return memory[0]

def find_answer():
    for i in range(100):
        for j in range(100):
            if (run_program(data[::], i, j) == 19690720):
                return 100 * i + j

print(find_answer())