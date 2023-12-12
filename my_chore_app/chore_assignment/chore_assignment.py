from utils.email_utils import send_assignment_email

def main():
    roommates = [
        {'name': 'John', 'email': 'john@example.com'},
        {'name': 'Alice', 'email': 'alice@example.com'},
        # Add more roommates as needed
    ]

    for roommate in roommates:
        send_assignment_email(roommate)

if __name__ == '__main__':
    main()
