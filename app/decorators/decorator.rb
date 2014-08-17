class Decorator
  attr_accessor :model

  def self.generate(relation)
    klass = "#{relation.model.name}Decorator".constantize
    relation.map do |rel|
      klass.new(rel)
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
end
