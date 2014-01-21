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
		self.website.downcase! if self.website.present?
		self.facebook.downcase! if self.facebook.present?
		self.googleplus.downcase! if self.googleplus.present?
		self.youtube.downcase! if self.youtube.present?
		self.twitter.downcase! if self.twitter.present?
	end
end
