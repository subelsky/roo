require 'roo/excelx/extractor'

module Roo
  class Excelx::Comments < Excelx::Extractor

    def comments
      @comments ||= extract_comments
    end

    private

    def extract_comments
      if doc_exists?
        Hash[doc.xpath("//comments/commentList/comment").map do |comment|
          value = (comment.at_xpath('./text/r/t') || comment.at_xpath('./text/t')).text
          [::Roo::Utils.ref_to_key(comment.attributes['ref'].to_s), value]
        end]
      else
        {}
      end
    end

  end
end
