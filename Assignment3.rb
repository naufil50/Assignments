# input.txt file is used as input

class MainApp
    attr_reader :file_name
  
    def initialize(file_name)
      @file_name = file_name
    end
  
    def run
      input = File.open(file_name).read()

    #   Parsing the input
      matches = input.split("\n").map do |line|
        team_one, team_two, state = line.split(";")
      end
  
      tournament = Tournament.new(matches)  
      tournament.score_card
    end
end
  


class Tournament
    SCORE = {
      win:  3,
      lose: 0,
      draw: 1
    }
  
    attr_accessor :matches, :teams
  
    def initialize(matches)
      self.teams = {}
        
    #   Creating Teams
      self.matches = matches.map do |match_str|
        team_one = @teams[match_str[0]] ||= Team.new(match_str[0])
        team_two = @teams[match_str[1]] ||= Team.new(match_str[1])
                     
        Match.new(team_one, team_two, match_str[2]).calculate_result
        
        
      end
    end
  
    def score_card
        # Header
      result = "Team            | MP  | W | D | L | P\n"
      
        # Appending results
      result += teams.values
                     .sort_by { |team| [-team.points, team.name] }
                     .map { |team| team.to_s + "\n" }
                     .join
                
      puts result
    end
end
 


class Match
    attr_accessor :team_one, :team_two, :status

    def initialize(team_one, team_two, status)
      self.team_one = team_one
      self.team_two = team_two
      self.status = status
    end

    def calculate_result
        
      case status           
        when 'win'
            team_one.wins
            team_two.loses
                
        when 'loss'
            team_one.loses
            team_two.wins
                
        when 'draw'
            team_one.draws
            team_two.draws
            
        else
            puts "status #{status} is invalid"      
      end               
    end
end
 


class Team
    attr_accessor :name, :win, :lose, :draw
  
    def initialize(name)
      self.name = name
      self.win = 0
      self.lose = 0
      self.draw = 0
    end
  
    def wins
      self.win +=1
    end
  
    def draws
      self.draw += 1
    end
  
    def loses
      self.lose += 1
    end
  
    def matches
      self.win + self.lose + self.draw
    end
  
    def points
      score = Tournament::SCORE
      win * score[:win] + draw * score[:draw] + lose * score[:lose]
    end
  
    def to_s
      "#{name}          | #{matches}   | #{win} | #{draw} | #{lose} | #{points}"
    end
end
  
MainApp.new(ARGV[0]).run