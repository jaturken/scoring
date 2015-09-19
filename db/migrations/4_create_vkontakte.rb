Sequel.migration do
  change do
    create_table(:vkontaktes) do
      primary_key :id
      Integer :university_id
      Integer :faculty_id
      Integer :vk_id
      String :first_name
      String :last_name
      String :deactivated
      String :photo_id
      Integer :verified
      Integer :sex
      String :bdate
      String :city
      String :country
      String :home_town
      String :photo_100, size: 200
      String :domain
      Integer :has_mobile
      String :site
      Integer :univers_count
      String :connections, size: 1000
      String :education_form
      String :occupation_type
    end
  end
end
