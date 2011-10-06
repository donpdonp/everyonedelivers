class TwitterJob < Struct.new(:update)
  def perform
    Twitter.update(update)
  end
end