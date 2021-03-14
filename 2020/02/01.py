with open("input") as file:
    data = [line for line in file]

num_valid = 0

for line in data:
    parts = line.split()
    numbers = parts[0].split('-')
    minimum = int(numbers[0])
    maximum = int(numbers[1])

    letter = parts[1][0]
    password = parts[2]
    occurrences = password.count(letter)

    if occurrences >= minimum and occurrences <= maximum:
        num_valid += 1

print(num_valid)