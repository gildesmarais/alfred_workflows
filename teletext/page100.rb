class Page100
  class Item
    def initialize(doc)
      @doc = doc
    end

    def url
      "https://ard-text.de/mobil/#{number}"
    end

    def number
      @doc.css('.number').text.strip
    end

    def title
      @doc.css('.text').text.strip
    end

    def to_alfred
      { title: "#{number}: #{title}", quicklookurl: url, subtitle: '' }
    end
  end

  def initialize(doc)
    @doc = doc
  end

  def to_alfred
    { items: items.map(&:to_alfred) }
  end

  private

  def items
    @doc.css('.master .broadcastTable tr:not(.title)').map do |broadcast|
      Item.new(broadcast)
    end
  end
end
