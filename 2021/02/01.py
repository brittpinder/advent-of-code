with open("input") as file:
    instructions = [line.split(" ") for line in file.read().split('\n')]
    instructions = [(direction, int(amount)) for [direction, amount] in instructions]

x, y = 0, 0

for direction, amount in instructions:
    if direction == "forward":
        x += amount
    elif direction == "down":
        y += amount
    elif direction == "up":
        y -= amount

answer = x * y
print(answer)
assert answer == 2322630
