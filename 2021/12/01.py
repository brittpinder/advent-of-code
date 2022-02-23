with open('input') as file:
    cave_connections = [line.strip().split('-') for line in file]

# Create adjacency list
connections = {}
for connection in cave_connections:
    first, second = connection[0], connection[1]
    if first not in connections:
        connections[first] = []
    if second not in connections:
        connections[second] = []
    connections[first].append(second)
    connections[second].append(first)

# Part 1
complete_paths = []
active_paths = [['start']]

while active_paths:
    current_path = active_paths.pop()
    current_cave = current_path[-1]

    for neighbour in connections[current_cave]:
        if neighbour == 'start' or (neighbour in current_path and neighbour.islower()):
            continue
        elif neighbour == 'end':
            complete_paths.append(current_path + [neighbour])
        else:
            active_paths.append(current_path + [neighbour])

num_paths = len(complete_paths)
print(f"Part One: {num_paths}")
assert num_paths == 4186

# Part 2
def has_visited_small_cave_twice(path):
    small_caves = [cave for cave in path if cave != 'start' and cave != 'end' and cave.islower()]
    return len(set(small_caves)) < len(small_caves)

complete_paths = []
active_paths = [['start']]

while active_paths:
    current_path = active_paths.pop()
    current_cave = current_path[-1]

    for neighbour in connections[current_cave]:
        if neighbour == 'start':
            continue
        elif neighbour == 'end':
            complete_paths.append(current_path + [neighbour])
        elif neighbour.islower() and neighbour in current_path and has_visited_small_cave_twice(current_path):
            continue
        else:
            active_paths.append(current_path + [neighbour])

num_paths = len(complete_paths)
print(f"Part Two: {num_paths}")
assert num_paths == 92111
