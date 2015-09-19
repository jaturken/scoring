class VkontakteSearcher
  attr_accessor :vk
  attr_accessor :sex

  PAGE = 20
  UNIVERSITIES = []

  def initialize(token, sex)
    @vk = VkontakteApi::Client.new(token)
    @sex = sex
  end

  def display_univers_data
    token = "716ddd52d747b62ab5ebd594d25b7f2d3020c85f1a84d59d4302fd4a238eb072ce5f732374a8ec2279206"

    puts "Parsing university..."

    univ = vk.database.getUniversities(city_id: 282)

    univ.id.each do |idd|
      puts idd
      facultet = vk.database.getFaculties(university_id: #{idd})
      facultet.each do |facIdd|
        puts facIdd
      end
    end

    puts "Done."
  end
end
