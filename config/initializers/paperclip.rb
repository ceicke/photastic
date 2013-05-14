# config/initializers/paperclip.rb 
Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-west-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
}
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
