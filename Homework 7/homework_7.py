# task_1
print("Задание 1: Список покупок")

shopping_list = ["milk", "bread", "eggs", "butter", "apples"]
num = 0

print("Список покупок:")

for prod in shopping_list:
    num = num + 1
    print(f"{num}. {prod}")

# task_2
print("\nЗадание 2: Обратный отсчет до запуска")

input_num = int(input("Введите число для обратного отсчета: "))

for i in range(input_num, 0, -1):
    print(f"{i}...")
    
print("Go!")

# task_3
print("\nЗадание 3: Угадай число")

print("Попробуй угадать число от 1 до 10")

secret_num = 7

input_num = None

while input_num != secret_num:
    input_num = int(input("Введите число: "))
    
    if secret_num == input_num:
        print("Молодец ты угадал!")
        
    else:
        print("Попробуй еще")

# task_4
print("\nЗадание 4: Обработка данных")

scores = [75, 88, -10, 95, 100, -25, 89]
total_score = 0
negativ_score = False

for score in scores:
    if score < 0:
        print(f"Пропушен балл: {score}")
        continue
    
    elif score == 0:
        negativ_score = True
        
        print("Операция прервана.")
        break
    
    else:
        total_score += score
        print(f"Добавлен балл: {score}")
        
if negativ_score != True:
    print("\nВсе данные обработаны")

print(f"Итоговая сумма баллов: {total_score}")

# task_5
print("\nЗадание 5: Рисуем Прямоугольник")

heigth = int(input("Введите высоту прямоугольника: "))
width = int(input("Введите ширину прямоугольника: "))

for i in range(heigth):
    
    for j in range(width):
        print("*", end="")
    
    print()