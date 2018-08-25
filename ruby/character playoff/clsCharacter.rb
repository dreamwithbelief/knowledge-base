############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/09/2012
#  Class:       CIS 283
#  Assignment:  Character Playoff
#  Description: Class for the character.
#               Allows two different fictional characters to
#               face off against each other in a simulated
#               environment.
#
############################################################

class Character
  attr_accessor( :name, :race, :hp, :current_hp, :strength, :agility, :weapon, :armor )
  def initialize( name, race, hp, strength, agility, weapon, armor )
    @name = name
    @race = race
    @hp = hp.to_i
    @current_hp = 0
    @strength = strength.to_i
    @agility = agility.to_i
    @weapon = weapon
    @armor = armor
  end

  def current_status
    return "Current Health:\t#{ @current_hp }"
  end

  def reduce_hp( attacker, defender, d4, d8, d15 )
    hit = attacker.strength * ( 1 / d4.roll ) + ( attacker.weapon.hit_points / d8.roll ).to_i
    armor_save = ( defender.armor.hit_points / d15.roll ).to_i
    ( hit > armor_save ) ? ( defender.current_hp -= ( hit - armor_save ) ) : nil
    return [ hit, armor_save ]
  end

  def revive_character
    @current_hp = @hp
  end

  def to_s
    details = "Name:\t\t\t\t#{ @name }\n"
    details += "Race:\t\t\t\t#{ @race }\n"
    details += "Maximum Health:\t\t#{ @hp }\n"
    details += "Current Health:\t\t#{ @current_hp }\n"
    details += "Strength:\t\t\t#{ @strength }\n"
    details += "Agility:\t\t\t#{ @agility }\n"
    details += "Weapon:\n"
    details += "\tName:\t\t\t#{ @weapon.name }\n"
    details += "\tHit Points:\t\t#{ @weapon.hit_points }\n"
    details += "Armor:\n"
    details += "\tName:\t\t\t#{ @armor.name }\n"
    details += "\tHit Points:\t\t#{ @armor.hit_points }\n"
    return details
  end
end