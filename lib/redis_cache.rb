class RedisCache
  def get_data(key)
    REDIS.get(key)
  end

  def set_data(key, value)
    REDIS.set(key, value)
  end

  def set_hash(key, value)
    REDIS.rpush(key, value)
  end

  def expire_data(key, expiry)
    REDIS.expire(key, expiry)
  end

  def delete_data(key)
    REDIS.del(key)
  end
end