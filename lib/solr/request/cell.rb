class Solr::Request::Cell < Solr::Request::Select
  def initialize(doc, file_name)
    params = {
      'captureAttr' => true,
      'defaultField' => 'text',
      'fmap.div' => 'content_t',
      'capture' => 'div',
      'resource.name' => file_name,
      'stream.file' => file_name,
    }
    doc.each do |f|
      params["literal.#{f.name}"] = f.value
      if f.boost
        params["boost.#{f.name}"] = f.boost
      end
    end
    super(nil,params)
  end
 
  def handler
    'update/extract'
  end
end

