class SemanticsWrapper
  def initialize
    @sem3 =  semaintics_wrapper_instance
  end

  def resolve(upc)
    @sem3.products_field('upc', upc)
    @sem3.get_products
  end

  private

  def semaintics_wrapper_instance
    Semantics3::Products.new(config['semantics_api_key'], config['semantics_api_secret'])
  end

  def config
    config ||= YAML.load_file("#{::Rails.root}/config/secrets.yml")
  end
end
