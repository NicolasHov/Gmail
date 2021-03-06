require "rubygems"
require "gmail"
require "dotenv"
require "pry"
require "json"
require "nokogiri"
require "bundler"
require 'mail'
Dotenv.load

def get_the_email_html(name_city)
  "<p>Bonjour,<br> Je m'appelle Nicolas, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle <strong>The Hacking Project</strong> (http://thehackingproject.org/).<br> Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.<br> Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à #{name_city}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec #{name_city} !<br> Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80<br> Bien à vous<br> Nicolas</p>"
end

class Email_sender

  def initialize
    @gmail = Gmail.connect!(ENV["GMAIL_LOGIN"],ENV["GMAIL_PASSWORD"])
  end

  # TODO prend l'email en colonne B, et lui enverra un message, qui pourra être alterné en fonction du nom de la
  # mairie en colonne A.

  def send_email_to_line
    email = @gmail.compose do
      to "kola.hov@gmail.com"
      subject "Liberté et apprentissage : The Hacking Project"
      html_part do
        content_type 'text/html; charset=UTF-8'
        body get_the_email_html("Pot-aux-roses")
        add_file "chatelet.jpg"
      end
    end
    email.deliver!
  end

  def perform
    send_email_to_line
  end

end

email_test = Email_sender.new
email_test.perform
