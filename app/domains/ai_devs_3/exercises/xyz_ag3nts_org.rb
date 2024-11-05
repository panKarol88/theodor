# S01E01 - Zadanie 1
# {{FLG:FIRMWARE}}
# https://xyz.ag3nts.org/files/0_13_4b.txt - Oprogramowanie robota patrolującego

module AiDevs3
  module Exercises
    class XyzAg3ntsOrg < Exercise
      def captcha_answer(human_question_content)
        p human_question_content

        chat_message = 'Answer the following question:\n'
        chat_message += "## QUESTION ## #{human_question_content} ######\n"
        chat_message += 'The answer is only a number. Return only number and nothing else.\n'
        chat_message += '## EXAMPLES ##\n'
        chat_message += 'Question:Jaki jest rok założenia Solidarności w Polsce?\n 1980'
        captcha_payload = chat(chat_message)
        p captcha_payload

        captcha_payload[:content]
      end

      def login
        options = Selenium::WebDriver::Chrome::Options.new
        # options.add_argument('--headless')
        options.add_argument('--disable-gpu')
        options.add_argument('--window-size=1920,1080')

        # Initialize the driver
        driver = Selenium::WebDriver.for :chrome, options: options

        begin
          driver.navigate.to 'https://xyz.ag3nts.org/'

          username_field = driver.find_element(name: 'username')
          username_field.send_keys('tester')

          password_field = driver.find_element(name: 'password')
          password_field.send_keys('574e112a')

          captcha = captcha_answer(driver.find_element(id: 'human-question').text)
          password_field = driver.find_element(name: 'answer')
          password_field.send_keys(captcha)

          submit_button = driver.find_element(id: 'submit')
          submit_button.click
        ensure
          # Quit the driver after use
          # driver.quit
        end
      end

      def answer
        URI.open(data_link).readlines(chomp: true)
      end
    end
  end
end

# AiDevs3::Exercises::XyzAg3ntsOrg.new(data_link: 'https://xyz.ag3nts.org').login
