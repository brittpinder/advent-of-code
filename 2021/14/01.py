def add_amount_to_dict(dictionary, key, amount):
    if key in dictionary:
        dictionary[key] += amount
    else:
        dictionary[key] = amount

def run_program(pairs, num_steps):
    for _ in range(num_steps):
        new_pairs = {}

        for pair in pairs:
            new_letter = rules[pair]
            amount = pairs[pair]
            add_amount_to_dict(new_pairs, pair[0] + new_letter, amount)
            add_amount_to_dict(new_pairs, new_letter + pair[1], amount)

        pairs = new_pairs

    letter_totals = {template[-1]: 1} # Add the last letter in the template since it won't be covered in for loop
    for pair in pairs:
        add_amount_to_dict(letter_totals, pair[0], pairs[pair])

    return max(letter_totals.values()) - min(letter_totals.values())

with open('input') as file:
    template, rules = file.read().split('\n\n')

rules = [rule.split(' -> ') for rule in rules.split('\n')]
rules = {rule[0]: rule[1] for rule in rules}

pairs = {}
for index in range(len(template) - 1):
    add_amount_to_dict(pairs, template[index] + template[index + 1], 1)

answer_part_one = run_program(pairs, 10)
print(f"Part One: {answer_part_one}")
assert answer_part_one == 2233

answer_part_two = run_program(pairs, 40)
print(f"Part Two: {answer_part_two}")
assert answer_part_two == 2884513602164
