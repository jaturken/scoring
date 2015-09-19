class VkontakteSearcher
  attr_accessor :vk

  PAGE = 20
  TOKEN = "716ddd52d747b62ab5ebd594d25b7f2d3020c85f1a84d59d4302fd4a238eb072ce5f732374a8ec2279206"

  def initialize
    @vk = VkontakteApi::Client.new(TOKEN)
  end

  def display_univers_data
    universities = @vk.database.getUniversities(city_id: 282).delete(1)
    universities.each do |uni|
      University.create(vk_id: uni.id, name: uni.name)
      puts "Save uni #{uni.name}"
      faculties = @vk.database.getFaculties(university_id: uni.id)
      facultet.each do |faculty|
        faculty_data = {
          vk_id: faculty.id,
          university_id: uni.id,
          name: faculty.name
        }
        Faculty.create(faculty_data)
      end
      puts "Save all faculties for uni #{uni.name}"
    end

    puts "Done."
  end
end
