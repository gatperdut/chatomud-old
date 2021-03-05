require 'csv'

table = CSV.read(ARGV[0])

skill = ":#{table[0][0]}"

(1..(table.length - 1)).each do |height|
  row = table[height]

  (1..20).each do |against|
    score = row[0]
    if score.include?("-")
      if height == (table.length - 1)
        add_extra = score.split("-").map(&:to_i).min - 1
      else
        add_extra = nil
      end
      score = score.split("-").map(&:to_i).max
    else
      score = score.to_i
      if height == (table.length - 1)
        add_extra = score - 1
      else
        add_extra = nil
      end
    end

    cell = row[21 - against.to_i]
    if cell.include?(" ")
      splitted = cell.split(" ")
      hits = splitted[0].to_i
      critical_severity = ":#{splitted[1][0]}"
      critical_type = splitted[1][1]
      critical_type = case critical_type
        when 'S'
          critical_type = ":slash"
        when 'K'
          critical_type = ":crush"
        when 'P'
          critical_type = ":puncture"
        when 'H'
          critical_type = ":hand_to_hand"
        else
          raise "invalid critical type"
      end
    else
      hits = cell.to_i
      critical_severity = ':no_critical'
      critical_type = ':not_applicable'
    end
    connects = hits > 0 ? true : false

    puts "Attack.create!(score_limit: #{score}, base: #{skill}, against: #{against}, hits: #{hits}, critical_severity: #{critical_severity}, critical_type: #{critical_type}, connects: #{connects})"
    if add_extra != nil
      puts "Attack.create!(score_limit: #{add_extra}, base: #{skill}, against: #{against}, hits: 0, critical_severity: :no_critical, critical_type: :not_applicable, connects: false)"
    end
  end
end
