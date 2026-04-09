user_input = input("Enter number of minutes: ")

if user_input.isdigit():
    minutes = int(user_input)

    if minutes >= 0:
        hours = minutes // 60
        remaining_minutes = minutes % 60

        if hours > 0 and remaining_minutes > 0:
            print(hours, "hrs", remaining_minutes, "minutes")
        elif hours > 0:
            print(hours, "hrs")
        else:
            print(remaining_minutes, "minutes")
    else:
        print("Please enter a non-negative number.")
else:
    print("Invalid input! Please enter only numbers.")