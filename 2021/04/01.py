def board_has_bingo(board, number):
    for row in board:
        if number in row:
            # Check for horizontal bingo
            if all(elem in drawn_numbers for elem in row):
                return True

            # Check for vertical bingo
            column = list(zip(*board))[row.index(number)]
            if all(elem in drawn_numbers for elem in column):
                return True

    return False

def calculate_score(board, drawn_numbers, winning_number):
    return sum([number for row in board for number in row if number not in drawn_numbers]) * winning_number

def part_1():
    for number in numbers_to_draw:
        drawn_numbers.append(number)
        for board in bingo_boards:
            if board_has_bingo(board, number):
                return (board, number)

def part_2():
    for number in numbers_to_draw:
        drawn_numbers.append(number)
        for board in list(bingo_boards):
            if board_has_bingo(board, number):
                if len(bingo_boards) == 1:
                    return (bingo_boards[0], number)
                bingo_boards.remove(board)

with open("input") as file:
    numbers_to_draw, *bingo_boards = file.read().split('\n\n')

numbers_to_draw = [int(number) for number in numbers_to_draw.split(',')]

bingo_boards = [board.split('\n') for board in bingo_boards]
bingo_boards = [[list(map(int, row.split())) for row in board] for board in bingo_boards]

# Part 1
drawn_numbers = []
winning_board, winning_number = part_1()
score = calculate_score(winning_board, drawn_numbers, winning_number)

print(f'Part 1 Score: {score}')
assert score == 51034

# Part 2
drawn_numbers = []
last_board_to_win, winning_number = part_2()
score = calculate_score(last_board_to_win, drawn_numbers, winning_number)

print(f'Part 2 Score: {score}')
assert score == 5434
