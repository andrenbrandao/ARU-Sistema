#encoding: utf-8

class SocialInformation < ActiveRecord::Base
	belongs_to :republica
	before_validation :downcase_all

	attr_accessible :website, :facebook, :googleplus, :youtube, :twitter

	validates_format_of :website, :facebook, :googleplus,
	:youtube, :twitter, :with => URI::regexp(%w(http https)), message: "Por favor, insira o link completo, com http(s).", allow_blank: true

	def not_empty?
		self.website.present? || self.facebook.present? || self.googleplus.present?	|| self.youtube.present?  || self.twitter.present?  
	end

	private

	def downcase_all
		self.website.downcase!
		self.facebook.downcase!
		self.googleplus.downcase!
		self.youtube.downcase!
		self.twitter.downcase!
	end
end
