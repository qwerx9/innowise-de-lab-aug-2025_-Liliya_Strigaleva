# part_1 Strings. Lists. Dictionaries.
# exercise_1 Операции со строкой
info_str = "Python Programming"

print(F"Длинна строки {len(info_str)}")
print(F"Длинна строки {info_str[7]}")
print("Последние 3 символа:", info_str[-3:])

if "gram" in info_str:
    print("Подстрока 'gram' найдена в строке.")
else:
    print("Подстрока 'gram' не найдена.\n")

# exercise_2 Методы строк и форматинг
email = " USER@DOMAIN.COM "
format_email = email.lower().strip()
print(format_email)

username, domain = format_email.split("@")
print(f"Username: {username}, Domane: {domain}\n")

# exercise_3 Методы списка
def show(fruits):
    print(fruits)

fruits = ["apple", "banana"]
fruits.append("orange");    show(fruits)
fruits.insert(1, "grape");  show(fruits)
fruits.pop(2);              show(fruits)
fruits.sort();              show(fruits)
fruits.reverse();           show(fruits)

# exercise_4 List comprehension и словари

words = ["hello", "world", "python", "code"]

length_words = [len(word) for word in words]
print(f"\nДлины слов: {length_words}" )

long_words = [word for word in words if len(word) > 4]
print(f"\nСлова > 4 символов: {long_words}" )

word_dict = {word: len(word) for word in words}
print(f"\nСловарь слов и их длин: {word_dict}" )

# exercise_5
nums = [11, 7, 2, 15]
target = 9

for index_1 in range(len(nums)):
    for index_2 in range(index_1 + 1, len(nums)):
        
        if nums[index_1] + nums[index_2] == target:
            print(f"\nОтвет [{index_1}, {index_2}] (потому что nums[{index_1}] + nums[{index_2}]"
                  f" = {nums[index_1]} + {nums[index_2]} = {target}")
            
            
# part_2
# exercise_1 Функции без параметров
from datetime import datetime

def show_current_time():
    now = datetime.now()
    
    print(f"\nТекущее время {now:%d.%m.%Y %H:%M}")

show_current_time()

# exercise_2 Функции с параметрами
def add_vat(price):
    nds = 0.20
    
    return price + price * nds

prices = [1000, 3499, 250]

for price in prices:
    nds_price = add_vat(price)
    
    print(f"\nИтоговая цена с НДС: {nds_price}\n")
    
# exercise_3 тяжкоо:(
student_data = [
    {'name': 'Алексей', 'scores': [85, 92, 78, 95]},
    {'name': 'Марина', 'scores': [65, 70, 58, 82]},
    {'name': 'Светлана', 'scores': [98, 95, 100]}
]

def calculate_average_score(scores, ignore_lowest = False):
    
    if ignore_lowest and len(scores) > 1:
        scores = scores.copy()
        scores.remove(min(scores))
        
    return sum(scores) / len(scores)


print("Все оценци:\n")
for student in student_data:
    avg = calculate_average_score(student['scores'])
    print(f"{student['name']}: {avg:.2f}")

print("\nБез худщей:\n")
for student in student_data:
    avg = calculate_average_score(student['scores'], ignore_lowest = True)
    print(f"{student['name']}: {avg:.2f}")
