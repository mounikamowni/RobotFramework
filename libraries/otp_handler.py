import imaplib
import email

class OTPHandler:
    def __init__(self, email_server, email_user, email_pass):
        self.email_server = email_server
        self.email_user = email_user
        self.email_pass = email_pass

    def get_otp_from_email(self, subject_filter):
        # Connect to the email server
        mail = imaplib.IMAP4_SSL(self.email_server)
        mail.login(self.email_user, self.email_pass)
        mail.select('inbox')

        # Search for the email with OTP
        result, data = mail.search(None, f'SUBJECT "{subject_filter}"')
        email_ids = data[0].split()
        latest_email_id = email_ids[-1]

        # Fetch the latest email
        result, data = mail.fetch(latest_email_id, '(RFC822)')
        msg = email.message_from_bytes(data[0][1])

        # Extract OTP from the email body (you might need to adjust this part)
        email_body = msg.get_payload(decode=True).decode()
        otp = self.extract_otp(email_body)

        mail.logout()
        return otp

    def extract_otp(self, email_body):
        import re
        match = re.search(r'Your OTP is (\d{6})', email_body)
        return match.group(1) if match else None