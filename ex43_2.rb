class Fighter
  attr_accessor :health, :power

  def initialize(health, power)
    @health = health
    @power = power
    puts @health, @power
  end

  gothons = ["Hrothgarr Stonemug", "Arthas Menethil", "Illidan Stormrage",
    "Sylvanas Windrunner", "Muradin Bronzebeard", "Varok Saurfang",
    "Bolvar Fordragon", "Kael'thas Sunstrider", "Orgrim Doomhammer",
    "Varian Wrynn"]

  $gothon = gothons.sample
end



class Fight
  def fight(gothon, hero)
    while gothon.health > 0 && hero.health > 0
      gothon.health -= hero.power
      hero.health -= gothon.power
      puts "#{$gothon}:  #{gothon.health} health points"
      puts "You: " + "#{hero.health} health points"
      if gothon.health > 0
        "#{$gothon} win"
        # return :death
      elsif hero.health > 0
       puts "You lucky bastard!"
      #  return :laser_weapon_armory
      else
       puts "You're both dead"
       # return :death
      end
    end
  end
end


x = 2
if x > 1
   puts "test ok!"
   gothon = Fighter.new(rand(75..90), rand(7..9))
   hero = Fighter.new(rand(35..45), rand(15..18))
   walka = Fight.new
   gracze = walka.fight(gothon, hero)
 else
  puts "i"
end

# tworzymy obiekty w wyniku if-statement
# jednak dostep do utworzonych w ten sposob jest rowniez z "zewnatrz"
# czyli moge dodac ten fragment do elsifa w central_corridor
