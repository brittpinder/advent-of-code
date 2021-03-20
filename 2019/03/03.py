def get_positions(path):
    x, y = 0, 0
    positions = {(0, 0): 0}
    step = 1
    for instruction in path:
        direction, amount = instruction[0], int(instruction[1::])

        for i in range(amount):
            if direction == 'R':
                x += 1
            elif direction == 'L':
                x -= 1
            elif direction == 'U':
                y += 1
            elif direction == 'D':
                y -= 1

            if not positions.get((x, y)):
                positions[(x, y)] = step
            step += 1

    return positions

with open("input") as file:
    data = file.read().split('\n')

path1, path2 = data[0].split(','), data[1].split(',')

path1_positions = get_positions(path1)
path2_positions = get_positions(path2)

intersections = set(path1_positions.keys()) & set(path2_positions.keys())

if (0, 0) in intersections:
    intersections.remove((0, 0))

closest_intersection = min([abs(position[0]) + abs(position[1]) for position in intersections])
print(f"Answer 1: {closest_intersection}")
assert closest_intersection == 1211

fewest_steps = min([path1_positions[position] + path2_positions[position] for position in intersections])
print(f"Answer 2: {fewest_steps}")
assert fewest_steps == 101386
