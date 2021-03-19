def is_num_valid(num):
    digits = [int(char) for char in str(num)]
    if digits != sorted(digits):
        return False
    for i in range(1, len(digits)):
        current, previous = digits[i], digits[i - 1]
        if current == previous and digits.count(current) == 2:
            return True
    return False

num_valid = 0
for i in range(245182, 790572):
    if is_num_valid(i):
        num_valid += 1

print(num_valid)