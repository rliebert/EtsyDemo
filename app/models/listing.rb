class Listing < ActiveRecord::Base

	belongs_to :user
	has_many :orders

	if Rails.env.devlopment?
		has_attached_file 	:image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "default.png"
	else
		has_attached_file 	:image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "default.png",
							:storage => :dropbox,
					    	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
					    	:path => ":style/:id_:filename"
	end

	validates_attachment_presence :image
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  	validates :name, :description, :price, presence: true
  	validates :price, numericality: { greater_than: 0 }

end
