require "rubygems"
require "gmail"
require "dotenv"
require "pry"
require "json"
require "nokogiri"
require "bundler"
require 'mail'
Dotenv.load

## Step 1 : fill up the mail

def get_the_email_html(name_city)
  "<p>Bonjour,<br><br> Je m'appelle Nicolas, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle <strong>The Hacking Project</strong> (http://thehackingproject.org/).<br> Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.<br> Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à #{name_city}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves) donc nous serions ravis de travailler avec #{name_city} !<br><br> Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80<br><br> Bien à vous<br><br> Nicolas</p>"
end

@gmail = Gmail.connect!(ENV["GMAIL_LOGIN"],ENV["GMAIL_PASSWORD"])

## Step 2 : send one email to sbdy
def send_one_email_to(name, mail)
  email = @gmail.compose do
    to mail
    subject "Apprentissage entre pairs + gratuité + code = The Hacking Project"
    html_part do
      content_type 'text/html; charset=UTF-8'
      body get_the_email_html(name) #TODO faire pour toutes les villes du tableau -> suppose de lire les colonnes du tableau dans une boucle (ajouter un délai)
    end
  end
email.deliver!
end
## Step 3
# TODO prend l'email en colonne B, et lui enverra un message, qui pourra être alterné en fonction du nom de la
# mairie en colonne A.

def send_email_to_line
  # load 'scrapping.rb'
  # @array_mail_city.each do |mail|

  # array_mail_test = ["kola.hov@gmail.com", "hovart.nicolas@gmail.com"]
  hash_test = {"Paris" => "kola.hov@gmail.com", "Conflans" => "hovart.nicolas@gmail.com", "Perigueux" => "yvan.sraka@gmail.com"}
  hash_test.each do |key|
    send_one_email_to(key, hash_test[:key])
  end
end

send_email_to_line
