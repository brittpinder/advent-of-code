def print_octopi():
    for row in octopi:
        print(''.join([str(num) for num in row]))

def step(octopi):
    octopi = [[num + 1 for num in row] for row in octopi]

    full_energy_positions = []
    for y in range(len(octopi)):
        for x in range(len(octopi[y])):
            if octopi[y][x] > 9:
                octopi[y][x] = 0
                full_energy_positions.append((y, x))

    while len(full_energy_positions) > 0:
        position = full_energy_positions.pop(0)
        y_pos, x_pos = position[0], position[1]

        for y in range(y_pos - 1, y_pos + 2):
            for x in range(x_pos - 1, x_pos + 2):
                if y < 0 or y > 9 or x < 0 or x > 9 or octopi[y][x] == 0:
                    continue
                octopi[y][x] += 1
                if octopi[y][x] > 9:
                    octopi[y][x] = 0
                    full_energy_positions.append((y, x))

    return octopi

def get_num_flashes(octopi):
    return sum(sum([1 for num in row if num == 0]) for row in octopi)

def is_simultaneous_flash(octopi):
    for row in octopi:
        for x in row:
            if x != 0:
                return False
    return True

with open('input') as file:
    original_octopi = [[int(num) for num in row] for row in file.read().split('\n')]

# Part 1
octopi = original_octopi
total_flashes = 0
for i in range(100):
    octopi = step(octopi)
    total_flashes += get_num_flashes(octopi)

print(f"Part 1: {total_flashes}")
assert total_flashes == 1735

# Part 2
octopi = original_octopi
count = 0
while(not is_simultaneous_flash(octopi)):
    count += 1
    octopi = step(octopi)

print(f"Part 2: {count}")
assert count == 400
