text = input("Enter a string: ")

result = ""

for ch in text:
    if ch not in result:
        result = result + ch

print("Unique string:", result)