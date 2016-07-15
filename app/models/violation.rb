class Violation < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Violation.create!(row.to_hash)
    end
  end

  def self.unique_categories
    Violation.uniq.pluck(:violation_category).sort{|a,b| a <=> b}
  end

  def self.category_count(category)
    Violation.where("violation_category = ?",category).count
  end

  def self.violations_in_category(category)
    violations_in_category = Violation.where("violation_category = ?",category)
    violations_in_category.sort { |a,b| a.violation_date <=> b.violation_date }
  end


end
