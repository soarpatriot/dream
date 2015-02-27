module SoftDelete

  def self.included base
    base.class_eval do
      default_scope -> { where(is_destroyed: false) }
    end
  end

  def soft_delete
    self.update is_destroyed: true
  end

end
