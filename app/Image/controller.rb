require 'rho/rhocontroller'
class ImageController < Rho::RhoController
#index action will find all the images
def index
@images = Image.find(:all)
render :back => '/app'
end
#new action will take a picture from the camera and then will call camera_callback
def new
Camera::take_picture(url_for :action => :camera_callback)
redirect :action => :index
end
#edit action will choose a picture from device and then call camera_callback
def edit
Camera::choose_picture(url_for :action => :camera_callback)
"" # Hi alexey do I need to put any link here?
end
# delect action will remove a image
def delete
@image = Image.find(@params['id'])
@image.destroy
redirect :action => :index
end
def camera_callback
if @params['status'] == 'ok'
#create image record in the DB
image = Image.new({'image_uri'=>@params['image_uri']})
image.save
puts "new Image object: " + image.inspect
end
WebView.navigate( url_for :action => :index )
"" # Hi Alexey do I need to put a link here too?
end
end