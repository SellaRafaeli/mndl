class Hash
  def just(firstItem, *args) 
    # this method removes keys with empty values. Consider using just_keys instead.
    args = (firstItem.is_a? Array) ? firstItem : args.unshift(firstItem)

    args = (args.map {|v| v.to_s}) + (args.map {|v| v.to_sym})
    self.slice(*args).compact.hwia
  end

  def just_keys(item, *args)
    args = (item.is_a? Array) ? item : args.unshift(item)
    self.hwia.select{|key, value| args.include?(key) }
  end

  def hwia
    HashWithIndifferentAccess.new self
  end

  def compact
    delete_if { |k, v| !v.present? }
  end
end

class Array
  def just(opts_arr)
    res = select {|v| v.in?(Array(opts_arr))}
  end

  def avg
    (self.reduce(:+) / self.size.to_f).round(2)
  end

  def mapo(field)
    self.map {|el| el[field]}
  end

  def mapf(method_name)
    self.map(&method(method_name.to_sym))
  end

  def hash_of_num_occurrences
    self.each_with_object(Hash.new(0)){|word,counts|counts[word]+=1}.sort_by{|k,v|v}.reverse.to_h
  end

  def to_simple_hash
    self.reduce({}) {|h,k| h[k.to_s] = k; h }.hwia
  end
end


def guid
  SecureRandom.uuid
end

def nice_id(coll = nil)
  res = SecureRandom.urlsafe_base64(7,false)[0..8]
  res
end

## Time 
def nice_date(time, opts = {})
  time.strftime("%e/%-m") rescue ''
end

def nice_datetime(time, opts = {})
  time.strftime("%b %e, %l:%M %p") rescue '' #"Jul 9, 12:55 PM"
end