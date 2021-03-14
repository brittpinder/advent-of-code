with open("input") as file:
    data = [int(num) for num in file.read().split(',')]

data[1], data[2] = 12, 2

for i in range(0, len(data), 4):
    opcode, num1, num2, location = data[i: i + 4]
    if opcode == 99:
        break
    elif opcode == 1:
        data[location] = data[num1] + data[num2]
    elif opcode == 2:
        data[location] = data[num1] * data[num2]

print(data[0])
