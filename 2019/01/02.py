def calculate_fuel_needed_for_fuel(fuel):
    if fuel > 0:
        return fuel + calculate_fuel_needed_for_fuel(fuel // 3 - 2)
    return 0

with open("input") as file:
    data = [int(line) for line in file]

total_fuel = sum([calculate_fuel_needed_for_fuel(mass // 3 - 2) for mass in data])

print(total_fuel)
assert total_fuel == 5083024
