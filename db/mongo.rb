Mongo::Logger.logger.level = Logger::WARN 

mongodb_db_name = $app_name 

DB_URI = ENV["MONGODB_URI"] || "mongodb://localhost:27017/#{mongodb_db_name}"

$mongo = Mongo::Client.new(DB_URI, max_pool_size: 20).database

$mongo_data = {}

class Mongo::Collection
  def get(params = {}) 
    params = {_id: params} if !params.is_a? Hash
    get_many(params).last
  end

  def get_many(params = {}, opts = {}) # opts {limit: 100} to limit
    self.find(params, opts).to_a
  end

  def all(params = {}, opts = {})
    get_many(params, opts)
  end

  def first
    get_many.first
  end

  def last(opts = {})
    get_many(opts, sort: [{created_at: -1}]).first
  end

  def exists?(fields)
    get_many(fields, {projection: {_id:1}, limit: 1}).count > 0
  end

  def random(amount = 1, crit = {}) #random items
    arr = []
    amount.times { arr << find(crit).limit(1).skip(rand(find(crit).count)).first }
    amount == 1 ? arr[0] : arr
  end

  def num(crit = {}, opts = {})
    get_many(crit, opts).count
  end

  def search_anywhere(val, opts = {})
    crit = crit_any_field(self,val)
    get_many(crit)
  end

  def search_by(field, val, opts={})
    crit = {field => {"$regex" => Regexp.new(val, Regexp::IGNORECASE) } } 
    get_many(crit, opts)
  end
    
  def add(doc)
    doc_id = nice_id(self)
    doc[:_id] ||= doc_id
    doc[:created_at] = Time.now
    self.insert_one(doc)
    doc.hwia
  end

  def update_id(_id, fields = {}, opts = {}) #opts can be e.g. { :upsert => true }    
    fields[:updated_at] = Time.now
    opts[:return_document] = :after
    
    res = self.find_one_and_update({_id: _id}, {'$set' => fields}, opts)    
    return nil unless res
    {_id: _id}.merge(res).hwia
  end

  def update_all(new_data)
    update_many({},{'$set': new_data})
  end

  def upsert(crit, fields={})
  fields_to_set = crit.merge(fields)
  res = self.find_one_and_update(crit, {'$set' => fields_to_set}, upsert: true)
end  

  def set(crit, fields = {}, opts = {}) #opts {upsert: true} to upsert
    update(crit, {'$set' => fields.merge(updated_at: Time.now)}, opts)
  end
end #end Mongo class 

get '/mongo/extension/refresh_this_file' do 
  'refresh_this_file'
end