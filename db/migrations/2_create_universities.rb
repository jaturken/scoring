Sequel.migration do
  change do
    create_table(:universities) do
      primary_key :id
      Integer :vk_id
      String :name, size: 256, null: false, default: ''
    end
  end
end
