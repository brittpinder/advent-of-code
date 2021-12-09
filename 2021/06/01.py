from collections import defaultdict

def simulate(old_fish, number_of_days):
    for i in range(number_of_days):
        new_fish: dict[int, int] = defaultdict(lambda: 0)

        for state in old_fish.keys():
            if state == 0:
                new_fish[6] += old_fish[state]
                new_fish[8] += old_fish[state]
            else:
                new_fish[state - 1] += old_fish[state]
        old_fish = new_fish

    return new_fish

initial_fish: dict[int, int] = defaultdict(lambda: 0)

with open("input") as file:
    for x in file.read().split(","):
        initial_fish[int(x)] += 1

# Part One:
final_fish = simulate(initial_fish.copy(), 80)

total_fish = sum(final_fish.values())
print(f"Total Fish: {total_fish}")
assert total_fish == 389726

# Part Two:
final_fish = simulate(initial_fish.copy(), 256)

total_fish = sum(final_fish.values())
print(f"Total Fish: {total_fish}")
assert total_fish == 1743335992042
