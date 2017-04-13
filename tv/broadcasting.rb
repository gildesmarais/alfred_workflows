class Broadcasting
  def initialize(station, started_at, name, url, progress, stars)
    @station = station.strip
    @started_at = started_at.strip
    @name = name.strip
    @url = url.strip
    @progress = progress.to_f
    @stars = stars.to_i
  end

  def to_alfred
    { subtitle: subtitle, title: title, quicklookurl: quicklookurl }
  end

  private

  def progress_bar
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
