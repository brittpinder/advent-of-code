def is_num_valid(num):
    digits = [int(char) for char in str(num)]
    if digits != sorted(digits):
        return False
    for i in range(1, len(digits)):
        current = digits[i]
        if current == digits[i - 1] and digits.count(current) == 2:
            return True
    return False

num_valid = 0
for i in range(245182, 790572):
    if is_num_valid(i):
        num_valid += 1

print(num_valid)
assert num_valid == 710