with open("input") as file:
    numbers = [line for line in file.read().split("\n")]

totals = [0] * len(numbers[0])
for i in range(len(numbers[0])):
    totals[i] = sum([int(number[i]) for number in numbers])

half_elements = len(numbers) / 2
gamma_rate = ['1' if total > half_elements else '0' for total in totals]
epsilon_rate = ['0' if total > half_elements else '1' for total in totals]

gamma_rate = int(''.join(gamma_rate), 2)
epsilon_rate = int(''.join(epsilon_rate), 2)

answer = gamma_rate * epsilon_rate
print(answer)
assert answer == 4174964
