class Lbank::MemoryCache
  def initialize
    @store = {}
  end

  def store(key, value)
    @store[key] = value
  end

  def read(key)
    @store[key]
  end

  def fetch(key, &block)
    return self[key] if self[key]
    self[key] = block.call
  end

  alias :[]= :store
  alias :[] :read
end
