doc("document_1.xml")/site/people/person[string-length(translate(concat(address/street,address/city,address/country,address/zipcode)," ","")) > 30]
