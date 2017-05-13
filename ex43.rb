# * Map
#   - next_scene
#   - opening_scene
# * Engine
#   - play
# * Scene
#   - enter
#   * Death
#   * Central Corridor
#   * Laser Weapon Armory
#   * The Bridge
#   * Escape Pod

class Scene
  def enter()
    puts "This scene is not yet configured. Subclass it and implement enter()."
    exit(1)
  end
end

class Engine

# tworzymy zmienna klasy scene_map

  def initialize(scene_map)
    @scene_map = scene_map
  end

# tworzymy metode play w ktorej definujemy poczatkowa i ostatnia scene
# (korzystamy z metod opening_scene i next_scene z klasy Map)
# przy ostatniej scenie jako argument funkcji podajemy finished, ktore jest
# symbolem oznaczajacym utworzenie sie klasy Finished i wywołanie jej metod
#
# Następnie tworzymy pętle, która działa dopóki obecna scena nie jest ostatnią
# w przeciwnym wypadku zmienna next_scene_name
# powoduje wywolanie metody enter w obiekcie klasy do, której aktualnie trafiliśmy

# zmienna current_scene w pętli zmienia po kolei wartość "przyjmująć" kolejne
# sceny aż do Finished, która kończy grę.
  def play()
    current_scene = @scene_map.opening_scene()
    last_scene = @scene_map.next_scene(:finished)

    while current_scene != last_scene
      next_scene_name = current_scene.enter()
      current_scene = @scene_map.next_scene(next_scene_name)
    end
     current_scene.enter()
  end
end


class Death < Scene
 @@quips = [
   "You died. You kinda suck at this.",
   "Your mom would be proud...if she were smarter.",
   "Sucha a luser.",
   "I have a small puppy that's better at this."
 ]
 def enter()
   puts @@quips[rand(0..(@@quips.length-1))]
   exit(1)
 end
end


class Central_Corridor < Scene
  def enter()
    puts "Gothons from Planet Percal #25 have invaded your spaceship."
    puts "You are the last surviving member of your crew."
    puts "You need to get to the laser weapons armory to get the neutron bomb,"
    puts "and escape after setting up the spaceship to explode."
    puts "You run down the central corridor but a Gothon suddenly jumps out and blocks your path."
    puts "He's blocking the door to the Weapons Armory. Quick, do something before he attacks you!"

    print ">"
    input = $stdin.gets.chomp

    if input.downcase.include?("attack") || input.downcase.include?("shoot")
      puts "Quick on the draw you yank out your blaster and fire it at the Gothon."
      puts "His clown costume is flowing and moving around his body, which throws"
      puts "off your aim.  Your laser hits his costume but misses him entirely.  This"
      puts "completely ruins his brand new costume his mother bought him, which"
      puts "makes him fly into an insane rage and blast you repeatedly in the face until"
      puts "you are dead.  Then he eats you."
      return :death

    elsif input.downcase.include?("dodge")
      puts "Like a world class boxer you dodge, weave, slip and slide right"
      puts "as the Gothon's blaster cranks a laser past your head."
      puts "In the middle of your artful dodge your foot slips and you"
      puts "bang your head on the metal wall and pass out."
      puts "You wake up shortly after only to die as the Gothon stomps on"
      puts "your head and eats you."
      return :death

    elsif input.downcase.include?("tell a joke")
      puts "Lucky for you they made you learn Gothon insults in the academy."
      puts "You tell the one Gothon joke you know:"
      puts "Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gur ubhfr, fur fvgf nebhaq gur ubhfr."
      puts "The Gothon stops, tries not to laugh, then busts out laughing and can't move."
      puts "While he's laughing you run up and shoot him square in the head"
      puts "putting him down, then jump through the Weapon Armory door."
      return :laser_weapon_armory
    elsif input.downcase.include?("let's fight")
      return :fight
    elsif input.downcase.include?("cheat#0")
      return :finished
    else
      puts "Does not compute!"
      return :central_corridor
    end
  end
end

class Laser_Weapon_Armory < Scene
  def enter()
    puts "You do a dive roll into the Weapon Armory, crouch and scan the room"
    puts "for more Gothons that might be hiding.  It's dead quiet, too quiet."
    puts "You stand up and run to the far side of the room and find the"
    puts "neutron bomb in its container.  There's a keypad lock on the box"
    puts "and you need the code to get the bomb out.  If you get the code"
    puts "wrong 10 times then the lock closes forever and you can't"
    puts "get the bomb.  The code is 3 digits."
    passcode = 234
    # passcode = "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    count = 10


    while count != 0
       print ">"
       input = $stdin.gets.chomp.to_i
       count -= 1
      if input == passcode
           puts "The container clicks open and the seal breaks, letting gas out."
           puts "You grab the neutron bomb and run as fast as you can to the"
           puts "bridge where you must place it in the right spot."
        return :the_bridge
       break
      end
      if count > 1
            puts "You have #{count} attempts left"
          elsif count > 0
            puts "You have #{count} attempt left"
          else
            puts "The lock buzzes one last time and then you hear a sickening"
            puts "melting sound as the mechanism is fused together."
            puts "You decide to sit there, and finally the Gothons blow up the"
            puts "ship from their ship and you die."
        return :death
      end
    end
  end
end


class The_Bridge < Scene
  def enter()
    puts "You burst onto the Bridge with the netron destruct bomb"
    puts "under your arm and surprise 5 Gothons who are trying to"
    puts "take control of the ship. Each of them has an even uglier"
    puts "clown costume than the last. They haven't pulled their"
    puts "weapons out yet, as they see the active bomb under your"
    puts "arm and don't want to set it off."
    print "> "

    action = $stdin.gets.chomp

    if action == "throw the bomb"
      puts "In a panic you throw the bomb at the group of Gothons"
      puts "and make a leap for the door.  Right as you drop it a"
      puts "Gothon shoots you right in the back killing you."
      puts "As you die you see another Gothon frantically try to disarm"
      puts "the bomb. You die knowing they will probably blow up when"
      puts "it goes off."
      return :death

    elsif action == "slowly place the bomb"
      puts "You point your blaster at the bomb under your arm"
      puts "and the Gothons put their hands up and start to sweat."
      puts "You inch backward to the door, open it, and then carefully"
      puts "place the bomb on the floor, pointing your blaster at it."
      puts "You then jump back through the door, punch the close button"
      puts "and blast the lock so the Gothons can't get out."
      puts "Now that the bomb is placed you run to the escape pod to"
      puts "get off this tin can."
      return :escape_pod

    else
      puts "DOES NOT COMPUTE!"
      return :the_bridge
     end
   end
end

class Escape_Pod < Scene
  def enter()
    puts "You rush through the ship desperately trying to make it to"
    puts "the escape pod before the whole ship explodes.  It seems like"
    puts "hardly any Gothons are on the ship, so your run is clear of"
    puts "interference.  You get to the chamber with the escape pods, and"
    puts "now need to pick one to take.  Some of them could be damaged"
    puts "but you don't have time to look.  There's 5 pods, which one"
    puts "do you take?"

    good_pod = rand(1..5)
    print "[pod #]> "
    input = $stdin.gets.chomp
    if input == good_pod.to_s || input == "cheat#1"
      puts "You jump into pod %s and hit the eject button." % input
      puts "The pod easily slides out into space heading to"
      puts "the planet below.  As it flies to the planet, you look"
      puts "back and see your ship implode then explode like a"
      puts "bright star, taking out the Gothon ship at the same"
      puts "time.  You won!"
      return :finished
    else
      puts "You jump into pod %s and hit the eject button." % input
      puts "The pod escapes out into the void of space, then"
      puts "implodes as the hull ruptures, crushing your body"
      puts "into jam jelly."
      return :death
    end
  end
end

class Fighter
  attr_accessor :name, :health, :power

  def initialize(name, health, power)
    @name = name
    @health = health
    @power = power
    puts "#{@name}: #{@health} health points, #{@power} power points"
  end

  gothons = ["Hrothgarr Stonemug", "Arthas Menethil", "Illidan Stormrage",
    "Sylvanas Windrunner", "Muradin Bronzebeard", "Varok Saurfang",
    "Bolvar Fordragon", "Kael'thas Sunstrider", "Orgrim Doomhammer",
    "Varian Wrynn"]

  $gothon = gothons.sample
end

class Fight < Scene
  def enter()
    gothon = Fighter.new($gothon, rand(75..90), rand(7..9))
    hero = Fighter.new("You", rand(35..45), rand(15..18))
    puts "____________FIGHT!___________"
    while gothon.health > 0 && hero.health > 0
      gothon.health -= hero.power
      hero.health -= gothon.power
      puts "#{$gothon}:  #{gothon.health} hp"
      puts "You: #{hero.health} hp"
    end
    if gothon.health > 0
        "#{$gothon} win"
        return :death
      elsif hero.health > 0
       puts "You win, lucky bastard!"
        return :laser_weapon_armory
      else
        puts "You're both dead"
        return :death
    end
  end
end


class Finished < Scene
  def enter()
    puts "You won! Good job."
  end
end

class Map
  @@scenes = {
    central_corridor: Central_Corridor.new(),
    laser_weapon_armory: Laser_Weapon_Armory.new(),
    the_bridge: The_Bridge.new(),
    escape_pod: Escape_Pod.new(),
    death: Death.new(),
    fight: Fight.new(),
    finished: Finished.new(),
  }

  # tworzymy zmienną start_scene
  def initialize(start_scene)
    @start_scene = start_scene
  end
  # w metodzie tej, korzystając z klasy Engine podajemy nazwe sceny - jej symbol
  # dla zmiennej val wyciagamy i przyporzudkowujemy wartosc klucza będącego
  # parametrem metody
  def next_scene(scene_name)
    val = @@scenes[scene_name]
    return val
  end

  def opening_scene()
    return next_scene(@start_scene)
  end
end

a_map = Map.new(:central_corridor)
a_game = Engine.new(a_map)
a_game.play()
