with open('input') as file:
    heights = [[int(x) for x in line] for line in file.read().split('\n')]

width, height = len(heights[0]), len(heights)

def get_score(x, y):
    value = heights[y][x]
    if x > 0 and value >= heights[y][x - 1]:
        return 0
    if x < width - 1 and value >= heights[y][x + 1]:
        return 0
    if y > 0 and value >= heights[y - 1][x]:
        return 0
    if y < height - 1 and value >= heights[y + 1][x]:
        return 0
    return value + 1

score = 0
for y in range(height):
    for x in range(width):
        score += get_score(x, y)

print(score)
assert score == 600
