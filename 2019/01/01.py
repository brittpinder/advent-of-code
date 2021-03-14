with open("input") as file:
    data = [int(line) for line in file]

total_fuel = sum([mass // 3 - 2 for mass in data])

print(total_fuel)
