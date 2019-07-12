require 'csv'

sanitize_headers = ->(header) { header.delete_prefix('_').downcase }
cast_to_bool = ->(value) { ActiveModel::Type::Boolean.new.cast(value) }
split_skills = ->(value) { value&.split(', ')&.flatten }

options = {
  headers: true,
  header_converters: sanitize_headers,
}

CSV.foreach(Rails.root.join('users.csv'), options) do |row|
  attrs = row.to_h
  attrs['global_admin'] = cast_to_bool.(attrs['global_admin'])
  attrs['receive_marketing'] = cast_to_bool.(attrs['receive_marketing'])
  attrs['skills'] = split_skills.(attrs['skills'])
  User.create(attrs)
end
