def decipher_patterns(patterns):
    codes = {}

    pattern1 = ''
    pattern4 = ''
    patterns_with_length_of_5 = []
    patterns_with_length_of_6 = []

    # Find 1, 4, 7, 8: Check for unique lengths
    for pattern in patterns:
        pattern = ''.join(sorted(pattern))
        length = len(pattern)

        if length == 2:
            codes[pattern] = 1
            pattern1 = set(pattern)
        elif length == 3:
            codes[pattern] = 7
        elif length == 4:
            codes[pattern] = 4
            pattern4 = set(pattern)
        elif length == 7:
            codes[pattern] = 8
        elif length == 5:
            patterns_with_length_of_5.append(pattern)
        elif length == 6:
            patterns_with_length_of_6.append(pattern)
        else:
            assert false

    # Find 3: Length of 5 with all letters in 1
    for pattern in patterns_with_length_of_5:
        if len(pattern1 & set(pattern)) == 2:
            codes[pattern] = 3
            patterns_with_length_of_5.remove(pattern)
            break

    # Find 5: Length of 5 with 3 of the characters in 4
    for pattern in patterns_with_length_of_5:
        if len(pattern4 & set(pattern)) == 3:
            codes[pattern] = 5
            patterns_with_length_of_5.remove(pattern)
            break

    # Find 2: Last one with length of 5
    codes[patterns_with_length_of_5[0]] = 2

    # Find 6: Length of 6 with just one of the characters in 1
    for pattern in patterns_with_length_of_6:
        if len(pattern1 & set(pattern)) == 1:
            codes[pattern] = 6
            patterns_with_length_of_6.remove(pattern)
            break

    # Find 9: Length of 6 that contains all characters in 4
    for pattern in patterns_with_length_of_6:
        if len(pattern4 & set(pattern)) == 4:
            codes[pattern] = 9
            patterns_with_length_of_6.remove(pattern)
            break

    # Find 0: Last one with length of 6
    codes[patterns_with_length_of_6[0]] = 0

    return codes

with open('input') as file:
    entries = [line for line in file.read().split('\n')]

sum = 0
for entry in entries:
    patterns, output_values = entry.split('|')

    patterns = decipher_patterns(patterns.strip().split(' '))

    output_values = [''.join(sorted(digit)) for digit in output_values.strip().split(' ')]
    output_values = [str(patterns[digit]) for digit in output_values]

    four_digit_number = int(''.join(output_values))
    sum += four_digit_number

print(sum)
assert sum == 1091609
