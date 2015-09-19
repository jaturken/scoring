Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :email, size: 128, null: false, default: ''
      Time :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
