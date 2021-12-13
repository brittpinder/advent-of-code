with open("input") as file:
    dots, folds = file.read().strip().split('\n\n')

dots = [tuple([int(num) for num in dot.split(',')]) for dot in dots.split('\n')]

folds = [line.split('=') for line in folds.split('\n')]
for fold in folds:
    fold[0] = fold[0][-1]
    fold[1] = int(fold[1])

def fold_paper(direction, fold_position):
    for i in range(len(dots)):
        x, y = dots[i][0], dots[i][1]
        if direction == 'y' and y > fold_position:
            dots[i] = (x, y - (y - fold_position) * 2)
        elif direction == 'x' and x > fold_position:
            dots[i] = (x - (x - fold_position) * 2, y)
    return list(set(dots))

# Part One:
dots = fold_paper(folds[0][0], folds[0][1])
number_of_dots = len(dots)
print(number_of_dots)
assert number_of_dots == 781

# Part Two:
for i in range(1, len(folds)):
    dots = fold_paper(folds[i][0], folds[i][1])

x_coords, y_coords = zip(*dots)

for y in range(max(y_coords) + 1):
    line = ""
    for x in range(max(x_coords) + 1):
        line += '# ' if (x, y) in dots else '. '
    print(line)
