json.array!(@violations) do |violation|
  json.extract! violation, :id, :violation_id, :inspection_id, :violation_category, :violation_date, :violation_date_closed, :violation_type
  json.url violation_url(violation, format: :json)
end
