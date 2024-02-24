# frozen_string_literal: true

# Based off of https://mariochavez.io/desarrollo/2023/09/01/full-text-search-with-sqlite-and-rails/
module SqliteSearch
  extend ActiveSupport::Concern

  private def update_search_index
    primary_key = self.class.primary_key
    table_name = self.class.table_name
    foreign_key = self.class.to_s.foreign_key
    model_constant = "fts_#{table_name}".classify.constantize

    search_attrs = @@search_scope_attrs.each_with_object({}) { |attr, acc|
      acc[attr] =  Nokogiri::HTML(public_send(attr)).text.gsub(/[^\dA-Za-z ]/, "") || ""
    }
    id_value = attributes[primary_key]

    model_constant.where(foreign_key => id_value).delete_all
    model_constant.create(search_attrs.merge!(foreign_key => id_value))
  end

  private def delete_search_index
    primary_key = self.class.primary_key
    table_name = self.class.table_name
    foreign_key = self.class.to_s.foreign_key

    "fts_#{table_name}".classify.constantize.where(foreign_key => attributes[primary_key]).delete_all
  end

  included do
    after_save_commit :update_search_index
    after_destroy_commit :delete_search_index

    scope_foreign_key = to_s.foreign_key
    scope :full_search, ->(query) {
      query = query.gsub(/[^\dA-Za-z ]/, "")

      return none if query.blank?

      joins("JOIN fts_#{table_name} ON fts_#{table_name}.#{scope_foreign_key} = #{quoted_table_name}.#{primary_key}").
      where(sanitize_sql_array(["fts_#{table_name} = :query", query: query])).order(:rank)
    }
  end

  class_methods do
    def search_scope(*attrs)
      @@search_scope_attrs = attrs
    end

    def rebuild_search_index(*ids)
      target_ids = Array(ids)
      target_ids = self.ids if target_ids.empty?
      scope_foreign_key = to_s.foreign_key
      model_constant = "fts_#{table_name}".classify.constantize

      model_constant.where(scope_foreign_key => target_ids).delete_all

      columns_to_insert = @@search_scope_attrs + [scope_foreign_key]
      target_ids.each do |id|
        record = select(*@@search_scope_attrs).find_by(id: id)

        next unless record.present?

        attrs = @@search_scope_attrs.map do |attr|
          [attr, Nokogiri::HTML(record[attr.to_sym]).text.gsub(/[^\dA-Za-z ]/, "")]
        end.to_h

        model_constant.create(attrs.merge!(scope_foreign_key => id))
      end
    end
  end
end
