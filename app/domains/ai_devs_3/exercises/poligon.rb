module AiDevs3
  module Exercises
    class Poligon < Exercise
      def answer
        URI.open(data_link).readlines(chomp: true)
      end
    end
  end
end

# AiDevs3::Exercises::Poligon.new(
#   data_link: 'https://poligon.aidevs.pl/dane.txt',
#   destination_link: 'https://poligon.aidevs.pl/verify',
#   task: 'POLIGON'
# ).send_answer
