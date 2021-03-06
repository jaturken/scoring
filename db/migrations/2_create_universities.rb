Sequel.migration do
  change do
    create_table(:universities) do
      primary_key :id
      Integer :vk_id
      String :name, size: 256, null: false, default: ''
      Integer :city_id, null: false, default: 282
      Integer :country_id, null: false, default: 3
    end
  end
end
