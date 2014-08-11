# Adds div and div['style'] to RELAXED filter
Sanitize::Config::CUSTOM_RELAXED = Sanitize::Config.merge(Sanitize::Config::RELAXED,
  :elements        => Sanitize::Config::RELAXED[:elements] + ['div'],
  :attributes => Sanitize::Config::RELAXED[:attributes].merge({'div' => ['style']})
)
