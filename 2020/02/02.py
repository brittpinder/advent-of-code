with open("input") as file:
    data = [line for line in file]

num_valid = 0

for line in data:
    parts = line.split()
    numbers = parts[0].split('-')
    index1 = int(numbers[0]) - 1
    index2 = int(numbers[1]) - 1

    letter = parts[1][0]
    password = parts[2]

    if (password[index1] == letter) != (password[index2] == letter):
        num_valid += 1

print(num_valid)