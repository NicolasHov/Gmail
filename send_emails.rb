require "rubygems"
require "gmail"
require "dotenv"
require "pry"
require "json"
require "nokogiri"
require "bundler"
require 'mail'
Dotenv.load

class Email_sender

  def initialize
    @gmail = Gmail.connect!(ENV["GMAIL_LOGIN"],ENV["GMAIL_PASSWORD"])
  end

  # TODO prend l'email en colonne B, et lui enverra un message, qui pourra être alterné en fonction du nom de la
  # mairie en colonne A.

  def send_email_to_line
    @gmail.deliver do
      to "tarek.@gmail.com"
      subject "Félicitations TAREK ! Vous avez gagné un voyage à Châtelet-Les-Halles "
      text_part do
        body "Billets à récupérer à Reims avant le 19 octobre 2017."
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<p>Hello <em>World</em></p>'
      end
      # add_file "chatelet.jpg"
    end
  end


  def perform
    send_email_to_line
  end

end

email_test = Email_sender.new

email_test.perform
