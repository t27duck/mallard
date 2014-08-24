class Decorator
  attr_accessor :model

  def self.generate(relation_or_record)
    if relation_or_record.is_a?(ActiveRecord::Base)
      generate_from_record(relation_or_record)
    else
      generate_from_relation(relation_or_record)
    end
  end

  def initialize(model)
    @model = model
  end

  def respond_to?(method_name, *args)
    super(method_name, *args) || @model.respond_to?(method_name, *args)
  end

  def method_missing(method_name, *args)
    return @model.send(method_name, *args) if @model.respond_to?(method_name)
    super(method_name, *args)
  end

  private ######################################################################

  def self.generate_from_record(record)
    klass = "#{record.class.name}Decorator".constantize
    klass.new(record)
  end

  def self.generate_from_relation(relation)
    klass = "#{relation.model.name}Decorator".constantize
    relation.map do |el|
      klass.new(el)
    end
  end
end
