from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webdriver import WebDriver

class LoginPage:
    def __init__(self, driver: WebDriver):
        self.driver = driver
        self.username_field = (By.ID, "username")
        self.password_field = (By.ID, "password")
        self.sign_in_button = (By.ID, "login-container")
        self.create_account_button = (By.ID, "createacc")

    def enter_username(self, username: str):
        self.driver.find_element(*self.username_field).send_keys(username)

    def enter_password(self, password: str):
        self.driver.find_element(*self.password_field).send_keys(password)

    def click_sign_in(self):
        self.driver.find_element(*self.sign_in_button).click()

    def click_create_account(self):
        self.driver.find_element(*self.create_account_button).click()