with open('input') as file:
    entries = [line for line in file.read().split('\n')]

entries = [line.split('|')[1] for line in entries]

entries = [line.strip().split(' ') for line in entries]

lengths = [2, 4, 3, 7]

entries = [item for sublist in entries for item in sublist if len(item) in lengths]

answer = len(entries)

print(answer)
assert answer == 456