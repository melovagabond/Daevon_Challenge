import re

def is_valid_credit_card_number(number):
    # Remove hyphens and spaces from the number
    number = number.replace("-", "")
    
    # Check if the number matches the required pattern
    if not re.match(r'^[3456]\d{3}(?:[ -]?\d{4}){3}$', number):
        return False

    # Check for consecutive repeated digits
    if re.search(r'(\d)\1{3,}', number):
        return False

    # All checks passed, the number is valid
    return True

# Take user input for credit card number
number = input("Enter your credit card number: ")

# Call the function to check if the number is valid
if is_valid_credit_card_number(number):
    print('Valid credit card number!')
else:
    print('Invalid credit card number.')