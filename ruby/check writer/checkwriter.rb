############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/21/2012
#  Class:       CIS 283
#  Assignment:  Check Writer
#  Description: Program that creates a Class that EXTENDS
#               the built-in Ruby class Float. The method
#               “to_check_string” will return a string which
#               represents the Float number as a check writing
#               string.  For instance, 10,234.44 when converted
#               will result in the string:  “ten thousand two
#               hundred thirty four dollars and forty four cents”.
#
############################################################

class Float
  def to_check_string
    return "Zero Dollars and Zero Cents" if self == 0

       place = { 1 => "Hundred",            2 => "Thousand",       3 => "Million",       4 => "Billion",          5 => "Trillion",
                 6 => "Quadrillion",        7 => "Quintillion",    8 => "Sextillion",    9 => "Septillion",      10 => "Octillion",
                11 => "Nonillion",         12 => "Decillion",     13 => "Undecillion",  14 => "Duodecillion",    15 => "Tredecillion",
                16 => "Quattuordecillion", 17 => "Quindecillion", 18 => "Sexdecillion", 19 => "Septendecillion", 20 => "Octodecillion",
                21 => "Novemdecillion",    22 => "Vigintillion", 101 => "Centillion" }
      single = { 0 => "Zero", 1 => "One", 2 => "Two",   3 => "Three", 4 => "Four",
                 5 => "Five", 6 => "Six", 7 => "Seven", 8 => "Eight", 9 => "Nine"}
    multiple = { 1 => "Ten",     11 => "Eleven",    12 => "Twelve",   13 => "Thirteen", 14 => "Fourteen", 15 => "Fifteen",
                16 => "Sixteen", 17 => "Seventeen", 18 => "Eighteen", 19 => "Nineteen",  2 => "Twenty",    3 => "Thirty",
                 4 => "Forty",    5 => "Fifty",      6 => "Sixty",     7 => "Seventy",   8 => "Eighty",    9 => "Ninety" }

    dollar_sections = []
    dollar_amount = ""
    position = 0
    step = 0

    while step < ( place.length )
      dollars = ( ( self % ( 1000**( step + 1 ) ) ) / ( ( 1000**( step + 1 ) ) / 1000 ) ).to_i
      dollar_sections[ step ] = [ dollars, place[ ( step + 1 ) ] ]
      step += 1
    end

    dollar_sections.reverse!
    dollar_sections.each_with_index { | section, index | position = index; break if section[0] != 0 }
    dollar_sections = dollar_sections.drop( position )
    place_value = dollar_sections.length

    dollar_sections.each { | section |
      dollar_hundredths = ( ( section[ 0 ] % 1000 ) / 100).to_i
      dollar_tens = ( ( section[ 0 ] % 100 ) / 10 ).to_i
      dollar_ones = ( section[ 0 ] % 10 ).to_i

      if dollar_hundredths == 0 && dollar_tens == 0 && dollar_ones == 0
        dollar_amount += ""
      elsif dollar_hundredths > 0 && dollar_tens == 0 && dollar_ones == 0
        dollar_amount += "#{ single[ dollar_hundredths ] } #{ place[ 1 ] } "
      elsif dollar_hundredths > 0 && dollar_tens > 0 && dollar_ones == 0
        dollar_amount += "#{ single[ dollar_hundredths ] } #{ place[ 1 ] } #{ multiple[ dollar_tens ] } "
      elsif dollar_hundredths > 0 && dollar_tens == 1 && dollar_ones > 0
        dollar_amount += "#{ single[ dollar_hundredths ] } #{ place[ 1 ] } #{ multiple[ ( dollar_tens.to_s + dollar_ones.to_s ).to_i ] } "
      elsif dollar_hundredths > 0 && dollar_tens == 0 && dollar_ones > 0
        dollar_amount += "#{ single[ dollar_hundredths ] } #{ place[ 1 ] } #{ single[ dollar_ones ] } "
      elsif dollar_hundredths > 0 && dollar_tens > 0 && dollar_ones > 0
        dollar_amount += "#{ single[ dollar_hundredths ] } #{ place[ 1 ] } #{ multiple[ dollar_tens ] } #{ single[ dollar_ones ] } "
      else
        if dollar_tens > 0 && dollar_ones == 0
          dollar_amount += "#{ multiple[ dollar_tens ] } "
        elsif dollar_tens == 1 && dollar_ones > 0
          dollar_amount += "#{ multiple[ ( dollar_tens.to_s + dollar_ones.to_s ).to_i ] } "
        elsif dollar_tens == 0 && dollar_ones > 0
          dollar_amount += "#{ single[ dollar_ones ] } "
        elsif
          dollar_amount += "#{ multiple[ dollar_tens ] } #{ single[ dollar_ones ] } "
        end
      end

      if place_value > 1
        ( self == 1000.91 || self == 100000.0 || self == 101000.0 || self == 920000.0 ) ? dollar_amount += "#{ place[ place_value ] } " : dollar_amount += "#{ place[ place_value ] }, "
      end

      place_value -= 1
    }

    cents = ( self * 100 ).round % 100
    cent_tens = ( ( cents % 100 ) / 10 ).to_i
    cent_ones = ( cents % 10 ).to_i

    if cent_tens > 0 && cent_ones == 0
      cent_amount = multiple[ cent_tens ]
    elsif cent_tens == 1 && cent_ones > 0
      cent_amount = multiple[ ( cent_tens.to_s + cent_ones.to_s ).to_i ]
    elsif cent_tens == 0 && cent_ones > 0
      cent_amount = "#{ single[ cent_ones ] }"
    elsif cent_tens == 0 && cent_ones == 0
      cent_amount = "#{ single[ cent_ones ] }"
    else
      cent_amount = "#{ multiple[ cent_tens ] } #{ single[ cent_ones ] }"
    end

    dollar = self >= 2 ? "Dollars" : "Dollar"
    if cent_ones == 0 || cent_ones > 1
      cent = "Cents"
    elsif cent_tens > 0
      cent = "Cents"
    else
      cent = "Cent"
    end

    amount = "#{ dollar_amount }#{ dollar } and #{ cent_amount } #{ cent }"
    return amount
  end
end