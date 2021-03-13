with open("input") as file:
    expense_report = [int(line) for line in file]

for i in range(len(expense_report)):
    entry_one = expense_report[i]
    for j in range(i + 1, len(expense_report)):
        entry_two = expense_report[j]
        for k in range(j + 1, len(expense_report)):
            entry_three = expense_report[k]
            if entry_one + entry_two + entry_three == 2020:
                answer = entry_one * entry_two * entry_three
                break

print(answer)
