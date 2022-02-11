open_to_close = {'(':')', '[':']', '{':'}', '<':'>'}
corruption_points = { ')':3, ']':57, '}':1197, '>':25137 }
autocompletion_points = { ')':1, ']':2, '}':3, '>':4 }

def get_corruption_score(char):
    return corruption_points[char]

def get_autocompletion_score(chars):
    score = 0
    for char in chars:
        score = score * 5 + autocompletion_points[char]
    return score

with open('input') as file:
    lines = [[char for char in line] for line in file.read().split('\n')]

corrupt_score = 0
incomplete_scores = []

for line in lines:
    queue = []
    corrupt = False
    for char in line:
        if char in open_to_close:
            queue.append(open_to_close[char])
        else:
            if queue[-1] == char:
                queue.pop()
            else:
                corrupt_score += get_corruption_score(char)
                corrupt = True
                break
    if not corrupt and len(queue) > 0:
        incomplete_scores.append(get_autocompletion_score(queue[::-1]))

print(f"Part 1: {corrupt_score}")
assert corrupt_score == 339411

incomplete_scores = sorted(incomplete_scores)
middle_score = incomplete_scores[len(incomplete_scores) // 2]
print(f"Part 2: {middle_score}")
assert middle_score == 2289754624
