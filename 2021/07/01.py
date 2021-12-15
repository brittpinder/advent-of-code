with open('input') as file:
    crabs = sorted([int(x) for x in file.read().split(',')])

# Part One
median = crabs[len(crabs) // 2]
min_fuel = sum([abs(x - median) for x in crabs])

print(min_fuel)
assert min_fuel == 352997

# Part Two
def calculate_fuel(distance):
    return sum(range(distance + 1))

mean = sum(crabs) // len(crabs)
min_fuel = sum([calculate_fuel(abs(x - mean)) for x in crabs])

print(min_fuel)
assert min_fuel == 101571302
