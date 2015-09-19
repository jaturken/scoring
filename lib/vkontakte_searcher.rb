require 'vkontakte_api'
class VkontakteSearcher
  attr_accessor :vk

  PAGE = 20
  TOKEN = "716ddd52d747b62ab5ebd594d25b7f2d3020c85f1a84d59d4302fd4a238eb072ce5f732374a8ec2279206"

  def initialize
    @vk = VkontakteApi::Client.new(TOKEN)
  end

  def display_univers_data
    universities = @vk.database.getUniversities(city_id: 282)[1..-1]
    universities.each do |uni|
      University.create(vk_id: uni.id, name: uni.title)
      puts "Save uni #{uni.name}"
      begin
        faculties = @vk.database.getFaculties(university_id: uni.id)[1..-1]
      rescue VkontakteApi::Error
        puts "Banned!! sleep 1 second"
        sleep(1)
        retry
      end

      faculties.each do |faculty|
        faculty_data = {
          vk_id: faculty.id,
          university_id: uni.id,
          name: faculty.title
        }
        Faculty.create(faculty_data)
      end
      puts "Save all faculties for uni #{uni.name}"
    end

    puts "Done."
  end

  def search_users
    (20..23).each do |age|
      [1,2].each do |sex|
        Faculty.all.each do |faculty|
          puts "#{Time.now}. Start getting users: age #{age}, sex: #{sex}, faculty: #{faculty.name}"
          begin
            params = {
              city_id: 282,
              age_from: age,
              age_to: age,
              university_faculty: faculty.vk_id,
              sex: sex,
              count: 1000
            }
            data = @vk.users.search(params)[1..-1]
          rescue VkontakteApi::Error
            puts "Banned!! sleep 1 second"
            sleep(1)
            retry
          end

          DB.transaction do
            data.map do |user|
              vk_data = {
                first_name: user.first_name,
                last_name: user.last_name,
                vk_id: user.uid
              }
              Vkontakte.create(vk_data)
            end
          end
        end
      end
    end
  end

end
