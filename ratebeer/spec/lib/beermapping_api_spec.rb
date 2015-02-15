require 'rails_helper'

describe "BeermappingApi" do 
    it "When HTTP GET return one entry, it is  parsed and returned" do 

        canned_answer = <<-END_OF_STRING
        <?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location>
    <id>12411</id>
    <name>Gallows Bird</name>
    <status>Brewery</status>
    <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink>
    <proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink>
    <blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap>
    <street>Merituulentie 30</street>
    <city>Espoo</city>
    <state nil="true"/>
    <zip>02200</zip>
    <country>Finland</country>
    <phone>+358 9 412 3253</phone>
    <overall>91.66665</overall>
    <imagecount>0</imagecount>
  </location>
</bmp-locations>
        END_OF_STRING

        stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml"})
        
        places = BeermappingApi.places_in("espoo")

        expect(places.size).to eq(1)
        place = places.first
        expect(place.name).to eq("Gallows Bird")
        expect(place.street).to eq("Merituulentie 30")
    end

    it "when http get returns nil, places_in is an empty array" do
        
        stub_request(:get, /.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml"})
        
        places = BeermappingApi.places_in("")


        expect(places).to eq([])
    end
end