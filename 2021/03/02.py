def get_most_common_digit_at_position(numbers, position):
    total = sum([int(number[position]) for number in numbers])
    return '1' if total >= len(numbers) / 2 else '0'

def get_least_common_digit_at_position(numbers, position):
    total = sum([int(number[position]) for number in numbers])
    if total == len(numbers):
        return '1'
    elif total == 0:
        return '0'
    return '0' if total >= len(numbers) / 2 else '1'

def find_value_with_bit_criteria(numbers, criteria_func):
    for i in range(len(numbers[0])):
        value = criteria_func(numbers, i)
        numbers = [number for number in numbers if number[i] == value]

    assert len(numbers) == 1
    return int(numbers[0], 2)

with open("input") as file:
    numbers = [line for line in file.read().split("\n")]

oxygen_rating = find_value_with_bit_criteria(numbers, get_most_common_digit_at_position)
co2_rating = find_value_with_bit_criteria(numbers, get_least_common_digit_at_position)

life_support_rating = oxygen_rating * co2_rating
print(life_support_rating)
assert life_support_rating == 4474944
