with open("input") as file:
    instructions = [line.split(" ") for line in file.read().split('\n')]
    instructions = [(direction, int(amount)) for [direction, amount] in instructions]

x, y, aim = 0, 0, 0

for direction, amount in instructions:
    if direction == "forward":
        x += amount
        y += aim * amount
    elif direction == "down":
        aim += amount
    elif direction == "up":
        aim -= amount

answer = x * y
print(answer)
assert answer == 2105273490
