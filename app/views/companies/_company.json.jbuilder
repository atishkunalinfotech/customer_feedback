json.extract! company, :id, :title, :user_id, :industry_id, :is_registered, :created_at, :updated_at
json.url company_url(company, format: :json)