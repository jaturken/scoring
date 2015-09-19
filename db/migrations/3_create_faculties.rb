Sequel.migration do
  change do
    create_table(:faculties) do
      primary_key :id
      Integer :vk_id
      Integer :university_id
      Integer :city_id, null: false, default: 282
      Integer :country_id, null: false, default: 3
    end
  end
end
