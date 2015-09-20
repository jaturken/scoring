require 'vkontakte_api'
class VkontakteSearcher
  attr_accessor :vk

  PAGE = 20
  # TOKEN = "716ddd52d747b62ab5ebd594d25b7f2d3020c85f1a84d59d4302fd4a238eb072ce5f732374a8ec2279206"
  # TOKEN = "8c5b4321f74088238bcf1f5babbded163fe588673a3b4404d4411830837d8841147986bdff1b8d33870d7"
  # TOKEN = '3a2eb13ac1c9af23b1974c1b7a6c7cc1a03483d4ba34e8d16ad63fdf1a9e66076c82c26ff4d91a162df5f'
  TOKEN = "795687486c3c95c7940a5677b2d3053598ef14ff0720cc9b2f9442229b7862f6eae68cf7ec428d949725d"
  def initialize
    @vk = VkontakteApi::Client.new(TOKEN)
  end

  def display_univers_data
    universities = @vk.database.getUniversities(city_id: 282)[1..-1]
    universities.each do |uni|
      University.create(vk_id: uni.id, name: uni.title)
      puts "Save uni #{uni.name}"
      begin
        sleep(1)
        faculties = @vk.database.getFaculties(university_id: uni.id)[1..-1]
      rescue VkontakteApi::Error
        puts "Banned!! sleep 3 seconds"
        sleep(3)
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

  def search_users(sex)
    (20..23).each do |age|
      Faculty.all.each do |faculty|
        puts "#{Time.now}. Start getting users: age #{age}, sex: #{sex}, faculty: #{faculty.name}"
        begin
            params = {
              city_id: 282,
              age_from: age,
              age_to: age,
              university_faculty: faculty.vk_id,
              sex: sex,
              count: 500
            }
          data = @vk.users.search(params)[1..-1]
          sleep(1)
          puts "#{Time.now} Found #{data.count} users"
        rescue VkontakteApi::Error
          puts "Banned!! sleep 1 second"
          sleep(1)
          retry
        end

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

  def full_users_data
    empty_profiles = Vkontakte.where(deactivated: nil).limit(50).to_a
    while !empty_profiles.empty? do
      sleep(1)
      user_ids = empty_profiles.map(&:vk_id).join(',')
      params = {
        user_ids: user_ids,
        fields: 'sex, bdate, city, country, photo_50, photo_100, photo_200_orig, photo_200, photo_400_orig, photo_max, photo_max_orig, photo_id, online, online_mobile, domain, has_mobile, contacts, connections, site, education, universities, schools, can_post, can_see_all_posts, can_see_audio, can_write_private_message, status, last_seen, common_count, relation, relatives, counters, screen_name, maiden_name, timezone, occupation,activities, interests, music, movies, tv, books, games, about, quotes, personal, friend_status, military, career'
      }

      data = vk.friends.get(params)[1..-1]
      data.map do |profile|
        data = profile_data(profile)
        Vkontakte.where(vk_id: profile.uid).update(data)
      end

      empty_profiles = Vkontakte.where(university_id: nil).limit(50).to_a
    end
  end

  private

  def profile_data(profile)
    faculties = Faculty.all
    universities = profile.universities
    if universities
      university = profile.universities.find do |f|
        faculties.map(&:vk_id).include?(f.faculty)
      end
      faculty_id = !!university ? university.faculty : nil
      university_id = !!university ? university.id : nil
      univers_count = profile.universities.count
    else
      faculty_id = nil
      university_id = nil
      univers_count = 0
    end
    connections = [profile.skype, profile.instagram, profile.mobile_phone].join(',')
    occupation = if profile.occupation
      profile.occupation.type
    else
      'Work'
    end
    {
      university_id: university_id,
      faculty_id: faculty_id,
      deactivated: 0,
      photo_id: profile.photo_100,
      verified: 1,
      sex: profile.sex,
      bdate: profile.bdate,
      city: profile.city.to_s,
      country: profile.country.to_s,
      home_town: profile.city.to_s,
      photo_100: profile.photo_100,
      domain: profile.domain,
      has_mobile: profile.has_mobile,
      site: profile.site,
      univers_count: univers_count,
      connections: connections,
      education_form: profile.education_form,
      occupation_type: occupation
    }
  end

end
