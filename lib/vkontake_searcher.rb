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

  end
end
