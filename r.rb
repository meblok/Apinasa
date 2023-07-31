require "uri"
require "net/http"
require "json"

def request(url_requested)
    url = URI(url_requested)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(url)
    #equest["cache-control"] = 'no-cache'  #que no guarde en la memoria cache
    #request["postman-token"] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'   #no es necesario tampoco
    response = https.request(request)

    return JSON.parse(response.body)
    

end
data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=EHt7LTYn0ZRcEeicMRr609iWcZJzgAW4SCsJU0Gd').values[0]


 photos = data.map do |photo|
    photo["img_src"]

 end 
def build_web_page(photos)
    html =""
    photos_html = photos.each do |photo|

        html += " <img src=\"#{photo}\">\n"
    end
   
    html = "<!DOCTYPE html>
            <html>
                <head>
                    <title> Imagenes desde Marte </title>
                </head>
                <body>
                    #{photos_html}
                </body>
            </html"
        
  
    File.write('index.html', html)

end
build_web_page(photos)
