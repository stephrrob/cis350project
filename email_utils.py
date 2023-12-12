import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import random

def send_email(to_email, subject, message):
    # Your email and password (use an app password for security)
    email_address = 'your_email@gmail.com'
    email_password = 'your_email_password'

    # Create an SMTP server instance
    smtp_server = smtplib.SMTP('smtp.gmail.com', 587)
    smtp_server.starttls()
    smtp_server.login(email_address, email_password)

    # Create a message
    msg = MIMEMultipart()
    msg['From'] = email_address
    msg['To'] = to_email
    msg['Subject'] = subject

    # Add message body
    msg.attach(MIMEText(message, 'plain'))

    # Send the message
    smtp_server.sendmail(email_address, to_email, msg.as_string())

    # Quit the SMTP server
    smtp_server.quit()

def send_assignment_email(roommate):
    assigned_chore = random.choice(chores)
    subject = 'Chore Assignment'
    message = f'This week, your chore is to {assigned_chore}.'
    send_email(roommate['email'], subject, message)

def main():
    roommates = [
        {'name': 'John', 'email': 'john@example.com'},
        {'name': 'Alice', 'email': 'alice@example.com'},
        # Add more roommates as needed
    ]

    chores = [
        'Clean the kitchen',
        'Take out the trash',
        'Vacuum the living room',
        # Add more chores as needed
    ]

    for roommate in roommates:
        send_assignment_email(roommate)

if __name__ == '__main__':
    main()
