from functools import reduce

with open('input') as file:
    rows = [row for row in file.read().split('\n')]

row_length = len(rows[0])

def get_trees_for_slope(x_slope, y_slope):
    num_trees, x = 0, 0

    for y in range(0, len(rows), y_slope):
        if x >= row_length:
            x -= row_length
        if rows[y][x] == '#':
            num_trees += 1
        x += x_slope

    return num_trees

# Part 1
answer = get_trees_for_slope(3, 1)
print(f"Part One: {answer}")
assert answer == 178

# Part 2
slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
trees = [get_trees_for_slope(slope[0], slope[1]) for slope in slopes]
answer = reduce(lambda a, b: a * b, trees)
print(f"Part Two: {answer}")
assert answer == 3492520200
