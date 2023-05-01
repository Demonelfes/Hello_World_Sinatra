class Gossip
  attr_accessor :author
  attr_accessor :content
  attr_accessor :id

  def initialize(author, content, id = 0)
    @author = author
    @content = content
    @id = id
  end

  def save
    CSV.open("./db/gossip.csv", "ab") { |csv| csv << [@author, @content] }
  end

  def self.all
    all_gossips = []
    CSV
      .read("./db/gossip.csv")
      .each { |csv_line| all_gossips << Gossip.new(csv_line[0], csv_line[1]) }
    return all_gossips
  end

  def self.find(id)
    gossips = self.all

    return gossips[id.to_i - 1]
  end

  def self.update(id, author, content)
    gossips = self.all
    gossip = gossips.find { |gossip| gossip.id == id }
    if gossip
      gossip.author = author
      gossip.content = content
      CSV.open("db/gossip.csv", "wb") do |csv|
        csv << %w[author content id]
        gossips.each do |gossip|
          csv << [gossip.author, gossip.content, gossip.id]
        end
      end
    end
  end
end
