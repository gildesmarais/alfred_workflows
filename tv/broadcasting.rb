class Broadcasting
  def initialize(station, started_at, name, url, progress, stars)
    @station = station.to_s.strip
    @started_at = started_at.to_s.strip
    @name = name.to_s.strip
    @url = url.to_s. strip
    @progress = progress.to_f
    @stars = stars.to_i
  end

  def to_alfred
    { subtitle: subtitle, title: title, quicklookurl: quicklookurl }
  end

  def self.filter(items, query)
    return items unless query
    items.keep_if { |broadcast|
      broadcast.inspect.downcase.include?(query.downcase)
    }
  end

  private

  def progress_bar
    return if @progress <= 0.0

    total = 10
    processed = @progress.ceil / 10

    progress = '=' * processed
    remaining = ' ' * (total - processed)

    "[#{progress}#{remaining}]"
  end

  def title
    "#{@station}: #{@name} #{stars_indicator}"
  end

  def stars_indicator
    return if @stars <= 0
    '⭐' * @stars
  end

  def subtitle
    "#{@started_at}\t\t#{progress_bar}"
  end

  def quicklookurl
    @url
  end
end
