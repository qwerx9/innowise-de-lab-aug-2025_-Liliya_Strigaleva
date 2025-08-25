import random

# задание 1: Приветствие
print("Задание 1")

name = input("Как тебя зовут? ")
print(f"Привет, {name}! Приятно познакомиться")
print()

# задание 2: Площадь прямоугольника
print("Задание 2")

lenght = int(input("Введите длину прямоугольника: "))
width = int(input("Введите ширину прямоугольника: "))

area = lenght * width

print(f"Площать прямоугольника: {area}")
print()

# задание 3: Конвертер температур
print("Задание 3")

tempr_c = int(input("Введите температуру в градусах: "))
tempr_f = (tempr_c * 9) / 5 + 32

print(f"{tempr_c}°C это {tempr_f}°F")
print()

# задание 4: Игра угадай число
print("Задание 4")

print("Я загадал число от 1 до 5. Попробуй угадать!")
random_num = random.randint(1,5)

input_num = None

while input_num != random_num:
    input_num = int(input("Введите число: "))
    
    if random_num == input_num:
        print("Молодец ты угадал!")
        
    elif random_num < input_num:
        print("Слишком много")
        
    else:
        print("Слишком мало")

print()

# задание 5: Проверка числа на чётность
print("Задание 5")

check_num = int(input("Введите число: "))

if check_num % 2 == 0:
    print(f"Число {check_num} - чётное.")
else:
    print(f"Число {check_num} - нечётное.")

print()
    
# задание 6: Калькулятор 
print("Задание 6")

symbol = input("Введите операцию (+, -, *, /, **, %, //): ")

num_1 = int(input("Введите первое число: "))
num_2 = int(input("Введите второе число: "))

if symbol == "+" :
    result = num_1 + num_2
    print(f"Результат сложения равен: {result}")
    
elif symbol == "-" :
    result = num_1 - num_2
    print(f"Результат вычитания равен: {result}")
    
elif symbol == "*" :
    result = num_1 * num_2
    print(f"Результат умножения равен: {result}")
    
elif symbol == "/" :
    result = num_1 / num_2
    print(f"Результат деления равен: {result}")

elif symbol == "**" :
    result = num_1 ** num_2
    print(f"Результат возведения в степень равен: {result}")
    
elif symbol == "%" :
    result = num_1 % num_2
    print(f"Результат остатка от деления равен: {result}")
    
elif symbol == "//" :
    result = num_1 // num_2
    print(f"Результат целочисленного деления равен: {result}")
    
else:
    print("Вы некорректно указали оперцию")