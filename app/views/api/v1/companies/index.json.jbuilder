json.companies @companies do |company|
	json.id company.id
	json.name company.name
	json.type company.ctype
end