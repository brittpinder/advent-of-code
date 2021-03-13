with open("input") as file:
    expense_report = [int(line) for line in file]

visited = {}
for entry in expense_report:
    if 2020 - entry in visited:
        answer = entry * (2020 - entry)
        break
    else:
        visited[entry] = True

print(answer)