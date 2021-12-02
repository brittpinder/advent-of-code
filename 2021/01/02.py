with open("input") as file:
    depths = [int(line) for line in file]

total_increases = sum([1 for i in range(len(depths) - 3) if depths[i + 3] > depths[i]])

print(total_increases)
assert total_increases == 1645
